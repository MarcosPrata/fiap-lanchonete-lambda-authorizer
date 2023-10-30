const ErrorWrapper = require('./ErrorWrapper')

module.exports = class BadRequest extends ErrorWrapper {
  exception = this.constructor.name

  timestamp = new Date().toISOString()

  errorName = 'BAD_REQUEST'

  errorCode = 100003

  httpCode = 400

  stacktrace

  details

  constructor(message) {
    super(message)
    this.message = message
    this.name = 'BAD_REQUEST'
    Error.captureStackTrace(this, this.constructor)
  }
}
