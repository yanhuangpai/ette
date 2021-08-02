package db

import (
	"fmt"
	"log"

	cfg "github.com/itzmeanjan/ette/app/config"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

// Connect - Connecting to postgresql database
func Connect() *gorm.DB {
	// _db, err := gorm.Open(postgres.Open(fmt.Sprintf("postgresql://%s:%s@%s:%s/%s",
	// 	cfg.Get("DB_USER"), cfg.Get("DB_PASSWORD"), cfg.Get("DB_HOST"),
	// 	cfg.Get("DB_PORT"), cfg.Get("DB_NAME"))),
	// 	&gorm.Config{
	// 		Logger:                 logger.Default.LogMode(logger.Silent),
	// 		SkipDefaultTransaction: true, // all db writing to be wrapped inside transaction manually
	// 	})
	var datetimePrecision = 2

	_db, err := gorm.Open(mysql.New(mysql.Config{
		DSN: fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8&parseTime=True&loc=Local",
			cfg.Get("DB_USER"), cfg.Get("DB_PASSWORD"), cfg.Get("DB_HOST"),
			cfg.Get("DB_PORT"), cfg.Get("DB_NAME")), // data source name, refer https://github.com/go-sql-driver/mysql#dsn-data-source-name
		DefaultStringSize:         256,                // add default size for string fields, by default, will use db type `longtext` for fields without size, not a primary key, no index defined and don't have default values
		DisableDatetimePrecision:  true,               // disable datetime precision support, which not supported before MySQL 5.6
		DefaultDatetimePrecision:  &datetimePrecision, // default datetime precision
		DontSupportRenameIndex:    true,               // drop & create index when rename index, rename index not supported before MySQL 5.7, MariaDB
		DontSupportRenameColumn:   true,               // use change when rename column, rename rename not supported before MySQL 8, MariaDB
		SkipInitializeWithVersion: false,              // smart configure based on used version
	}), &gorm.Config{
		Logger:                 logger.Default.LogMode(logger.Silent),
		SkipDefaultTransaction: true, // all db writing to be wrapped inside transaction manually
	})
	if err != nil {
		log.Fatalf("[!] Failed to connect to db : %s\n", err.Error())
	}

	_db.AutoMigrate(&Blocks{}, &Transactions{}, &Events{}, &Users{}, &DeliveryHistory{}, &SubscriptionPlans{}, &SubscriptionDetails{})
	return _db
}
