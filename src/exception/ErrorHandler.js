const ErrorWrapper = require('./ErrorWrapper')

function handleException(exception) {
  const error = mapError(exception)
  const headers = getHeaders(error)

  console.error({
    ...error,
  })

  const responseBody = JSON.stringify(error)

  return {
    statusCode: error.httpCode,
    headers: headers,
    body: responseBody
  }
}

function mapError(error) {
  const errorWrapper = new ErrorWrapper()
  errorWrapper.errorCode = error.errorCode || 100003
  errorWrapper.httpCode = error.httpCode || Number(error.status) || 500
  errorWrapper.errorName = error.name || error.errorName || 'internal-server-error'
  errorWrapper.status = error.httpCode || Number(error.status) || 500
  errorWrapper.message = error.message
  errorWrapper.details = getErrors(error)
  errorWrapper.timestamp = error.timestamp || new Date().toISOString()

  return errorWrapper
}

function getErrors(error) {
  return [error, error.origin]
    .filter(Boolean)
    .reduce((errs, { errors }) => {
      return [...errs, ...(errors || [])]
    }, [])
}

function getHeaders(error) {
  return [error, error.origin]
    .filter(Boolean)
    .reduce((obj, { headers }) => {
      return {
        ...obj,
        ...(headers || {}),
      }
    }, {})
}

module.exports = { handleException }