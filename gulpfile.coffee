gulp = require("gulp")
bower = require("bower")
mainBowerFiles = require("main-bower-files")

gulp.task "bower", (done)->
  bower.commands.install().on "end", ->
    gulp.src mainBowerFiles()
      .pipe gulp.dest("tmp/bower/")
      .on "end", ->
        done()
  return undefined

gulp.task "ioviz-aoj.js", ["bower"], ->

