@load_visualizer = (selector, problemId, type, text, callback)->
  requirejs(
    [
      "ioviz/aoj/stream_factory"
    ]
    (
    )->
  )
