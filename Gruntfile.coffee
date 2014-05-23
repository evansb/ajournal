
module.exports = (grunt) ->
    fs = require 'fs'
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        coffee:
            compile:
                options:
                    expand: true
                    bare: true
                files:
                    'Gruntfile.js': 'Gruntfile.coffee'
                    './ajournal/ajournal.js': [
                        './ajournal/core/*.coffee'
                        './ajournal/plugin/*.coffee'
                        './ajournal/*.coffee'
                    ]
        coffeelint:
            options:
                indentation:
                    value: 4
            all: [ 'Gruntfile.coffee', './ajournal/**/*.coffee']
        uglify:
            dist:
                files:
                    './ajournal/ajournal.min.js' : ['./ajournal/ajournal.js']

    npmTasks = [
        'grunt-contrib-coffee',
        'grunt-contrib-uglify',
        'grunt-coffeelint'
    ]

    for task in npmTasks
        grunt.loadNpmTasks task

    grunt.registerTask 'default' , ['coffeelint:all', 'coffee:compile','uglify']

# vim: ts=4 sw=4 et
