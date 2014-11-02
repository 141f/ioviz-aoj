# (c) 2014 Database Systems Lab, University of Aizu.
# (c) 2014 Hiroyuki Sano <sh19910711 at gmail.com>

# Find appropriate visualizer
#
# @param options [Object] (Required)
#   options = {
#     problemId:  the problem id [Required],
#     type:       the data type (input / output) [Required],
#     text:       the target text data
#     selector:   the location of visualizer (e.g. "#iovis")
#     width:      the width of visualizer
#     height:     the height of visualizer
#   }
#
# @param callback [Function] (Optional)
#   the function called after visualize
@find_visualizer = (options, callback)->
  requirejs(
    [
      "ioviz/aoj/resolvers/data_resolver"
      "ioviz/aoj/resolvers/visual_resolver"
    ]
    (
      DataResolver
      VisualResolver
    )->
      stream = DataResolver.resolve(options)
        .pipe VisualResolver.resolve(options)
        .on "end", ->
          callback() if callback instanceof Function
  )

