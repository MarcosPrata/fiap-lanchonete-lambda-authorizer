module.exports = class ErrorWrapper extends Error{
  exception
  message
  timestamp
  errorName
  errorCode
  httpCode
  stacktrace
  details
  status
}
