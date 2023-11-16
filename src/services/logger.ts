const { createLogger, format, transports } = require('winston');
const { combine, timestamp } = format;

const level = process.env.LOG_LEVEL || 'info';
const logger = createLogger({
  level: level,
  format: format.json(),
  defaultMeta: { service: 'my-service-name' },
  transports: [
    //
    // - Write all logs with importance level of `error` or less to `error.log`
    // - Write all logs with importance level of `info` or less to `combined.log`
    //
    // new winston.transports.File({ filename: 'error.log', level: 'error' }),
    // new winston.transports.File({ filename: 'combined.log' }),
    new transports.Console({
      format: combine(
        timestamp(),
        format.cli({
          colors: { info: 'cyan', debug: 'green' }
        }),
      ),
      level: level
    }),
  ],
});


export default logger;
