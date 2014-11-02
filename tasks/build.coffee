gulp    = require("gulp")
bower   = require("bower")
concat  = require("gulp-concat")
coffee  = require("gulp-coffee")
mainBowerFiles  = require("main-bower-files")
amdOptimize     = require("amd-optimize")

gulp.task "require-all-ioviz-aoj.js", ->
  requireAll = require("../lib/require-all")
  gulp.src ["src/coffee/ioviz.aoj/**/*.coffee"]
    .pipe requireAll(
      "require-all-ioviz-aoj.js"
      {
        baseUrl: "src/coffee"
      }
    )
    .pipe gulp.dest("tmp/js/config/")

gulp.task "ioviz.aoj.js", ["bower", "coffee", "require-all-ioviz-aoj.js"], ->
  gulp.src(["bower_components/ioviz/dist/ioviz/**/*.js"], {base: "./"})
    .pipe amdOptimize("ioviz", amdOptimizeOptions)
    .pipe concat "ioviz.aoj.js"
    .pipe gulp.dest "tmp/"

amdOptimizeOptions =
  configFile: gulp.src("tmp/config.coffee").pipe(coffee())

gulp.task "coffee", ->
  gulp.src ["src/coffee/**/*.coffee"]
    .pipe coffee()
    .pipe gulp.dest("tmp/js/")

gulp.task "bower", (done)->
  bower.commands.install().on "end", ->
    gulp.src mainBowerFiles()
      .pipe gulp.dest("tmp/js/bower/")
      .on "end", ->
        done()
  return undefined

