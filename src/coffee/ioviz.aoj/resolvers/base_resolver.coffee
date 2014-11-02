define(
  [
    "ioviz.aoj/errors"
    "ioviz/utils/errors"
  ]
  (
    Errors
    jQuery
  )->
    class BaseResolver
      @resolve: (options)->
        throw Errors::NOT_IMPLEMENT
)
