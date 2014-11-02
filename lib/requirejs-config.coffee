through = require("through2")
gutil = require("gulp-util")
File = gutil.File
path = require("path")
_ = require("lodash")
fs = require("fs")

requireAll = (filename, options)->
  cwd = process.cwd()
  pathlist = []

  isDirectory = (pathString)->
    fs.lstatSync(pathString).isDirectory()

  toModulePath = (file)->
    modulePath = path.relative(cwd, file.path)
    unless isDirectory(modulePath)
      if /\./.test(path.basename(modulePath))
        extName = path.extname(modulePath)
        modulePath = modulePath.slice 0, -1 * extName.length
    modulePath

  stream = through.obj(
    # on data
    (file, enc, cb)->
      pathlist.push {
        name: path.basename(toModulePath(file))
        path: toModulePath(file)
      }
      cb()

    # on end
    (cb)->
      _(options.paths).each (value, key)->
        pathlist.push {
          name: key
          path: value
        }
      result_contents = ""
      result_contents += "requirejs.config({paths:{"
      result_contents += pathlist
        .map (module)->
          "'#{module.name}': '#{module.path}'"
        .join(",")
      result_contents += "}"
      result_contents += ",baseUrl: '#{options.baseUrl}'" if options && options.baseUrl
      result_contents += "});"

      @push new File(
        contents: new Buffer(result_contents)
        stat:
          mode: "0644"
        path: filename
      )

      cb()
  )

module.exports = requireAll
