package db

import (
	"database/sql"
	"time"

	"github.com/jmoiron/sqlx"
	_ "github.com/jteeuwen/go-bindata" // so it's detected by `dep ensure`
	"github.com/lbryio/errors.go"
	qtools "github.com/lbryio/query.go"
	log "github.com/sirupsen/logrus"
	"github.com/volatiletech/sqlboiler/boil"
)

func logQueryTime(logger *log.Logger, startTime time.Time) {
	logger.Debugln("Query took " + time.Since(startTime).String())
}

type QueryLogger struct {
	DB      *sqlx.DB
	Logger  *log.Logger
	Enabled bool
}

func (d *QueryLogger) Query(query string, args ...interface{}) (*sql.Rows, error) {
	if d.Logger != nil {
		q, err := qtools.InterpolateParams(query, args...)
		if err != nil {
			return nil, errors.Err(err)
		}
		d.Logger.Debugln(q)
		defer logQueryTime(d.Logger, time.Now())
	}
	return d.DB.Query(query, args...)
}

func (d *QueryLogger) Exec(query string, args ...interface{}) (sql.Result, error) {
	if d.Logger != nil {
		q, err := qtools.InterpolateParams(query, args...)
		if err != nil {
			return nil, errors.Err(err)
		}
		d.Logger.Debugln(q)
		defer logQueryTime(d.Logger, time.Now())
	}
	return d.DB.Exec(query, args...)
}

func (d *QueryLogger) QueryRow(query string, args ...interface{}) *sql.Row {
	if d.Logger != nil {
		q, err := qtools.InterpolateParams(query, args...)
		if err != nil {
			return nil
		}
		d.Logger.Debugln(q)
		defer logQueryTime(d.Logger, time.Now())
	}
	return d.DB.QueryRow(query, args...)
}

func (d *QueryLogger) Begin() (boil.Transactor, error) {
	if d.Logger != nil {
		d.Logger.Debug("->  Beginning tx")
	}
	tx, err := d.DB.Begin()
	if err != nil {
		return tx, err
	}
	return &queryLoggerTx{Tx: tx, logger: d.Logger}, nil
}

func (d *QueryLogger) Close() error {
	if d.Logger != nil {
		d.Logger.Print("Closing DB connection")
	}
	return d.DB.Close()
}

type queryLoggerTx struct {
	Tx     *sql.Tx
	logger *log.Logger
}

func (t *queryLoggerTx) Query(query string, args ...interface{}) (*sql.Rows, error) {
	if t.logger != nil {
		q, err := qtools.InterpolateParams(query, args...)
		if err != nil {
			return nil, errors.Err(err)
		}
		t.logger.Debugln("->  " + q)
		defer logQueryTime(t.logger, time.Now())
	}
	return t.Tx.Query(query, args...)
}

func (t *queryLoggerTx) Exec(query string, args ...interface{}) (sql.Result, error) {
	if t.logger != nil {
		q, err := qtools.InterpolateParams(query, args...)
		if err != nil {
			return nil, errors.Err(err)
		}
		t.logger.Debugln("->  " + q)
		defer logQueryTime(t.logger, time.Now())
	}
	return t.Tx.Exec(query, args...)
}

func (t *queryLoggerTx) QueryRow(query string, args ...interface{}) *sql.Row {
	if t.logger != nil {
		q, err := qtools.InterpolateParams(query, args...)
		if err != nil {
			return nil
		}
		t.logger.Debugln("->  " + q)
		defer logQueryTime(t.logger, time.Now())
	}
	return t.Tx.QueryRow(query, args...)
}

func (t *queryLoggerTx) Commit() error {
	if t.logger != nil {
		t.logger.Debug("->  Committing tx")
	}
	return t.Tx.Commit()
}

func (t *queryLoggerTx) Rollback() error {
	if t.logger != nil {
		t.logger.Debug("->  Rolling back tx")
	}
	return t.Tx.Rollback()
}
