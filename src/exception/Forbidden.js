const ErrorWrapper = require('./ErrorWrapper')

module.exports = class BadRequest extends ErrorWrapper {
  exception = this.constructor.name

  timestamp = new Date().toISOString()

  errorName = 'FORBIDDEN'

  errorCode = 100003

  httpCode = 401

  stacktrace

  details

  constructor(message) {
    super(message)
    this.message = message
    this.name = 'FORBIDDEN'
    Error.captureStackTrace(this, this.constructor)
  }
}
