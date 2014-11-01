gulp    = require("gulp")
bower   = require("bower")
concat  = require("gulp-concat")
mainBowerFiles = require("main-bower-files")

gulp.task "bower", (done)->
  bower.commands.install().on "end", ->
    gulp.src mainBowerFiles()
      .pipe gulp.dest("tmp/bower/")
      .on "end", ->
        done()
  return undefined

gulp.task "extlib.js", ["bower"], ->
  gulp.src ["tmp/bower/**/*.js"]
    .pipe concat("extlib.js")
    .pipe gulp.dest("tmp/js/")

gulp.task "ioviz-aoj.js", ["extlib.js"], ->

