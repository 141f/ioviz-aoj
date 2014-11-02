gulp    = require("gulp")
glob    = require("glob")
phantoMocha   = require("phantomochajs")

gulp.task "test", ["requirejs-config.js"], ->
  gulp.src ["spec/spec_helper.coffee", "spec/*_spec.coffee"]
    .pipe phantoMocha(
    )

