
# Task : AJournal
# Description : The main task that load site configuration and run
# all tasks
# Author : Evan Sebastian <evanlhoini@gmail.com>

AJournal =
    set_site_default: (site) ->
        site.template = site.template or 'template'
        site.output = site.output or '_site'
        site.encoding = site.encoding or 'utf8'
    buildTasks : (tasks, error) ->
        _ = require('underscore')
        graph = {}; visited = {}; order = []
        _.each tasks, (task) -> graph[task.name] = task.dependencies
        tasks = Object.keys graph

        get_zero_dep = (graph) ->
            _.filter tasks, (task) ->
                not_visited = _.filter graph[task], (d) -> not visited[d]?
                not visited[task] and not_visited.length is 0

        zero_dep = get_zero_dep graph
        until zero_dep.length is 0
            _.each zero_dep, (id, dep) -> visited[id] = true; order.push id
            zero_dep = get_zero_dep graph
        if tasks.length isnt order.length
            error.throw "Error in processing dependencies"
        return order

    loadTasks : (directory) ->
        fs = require 'fs'
        tasks = []
        files = fs.readdirSync ('./.ajournal/'+ directory)
        for file in files
            if file[0] isnt '.'
                tasks.push require ('./' + directory + '/' + file)
        return tasks

    error :
        log: (msg) -> console.log '\t' + msg
        throw: (msg) -> throw msg

    build: () ->
        _ = require 'underscore'
        require('rootpath')()
        error = @error

        site = require '../config.json'
        invalid  = (site) -> not (site? and site.title? and site.task_dir?)
        error.throw "Invalid or incomplete config.json, make sure field title and
         task are not empty" if invalid site

        @set_site_default(site)

        allTasks = []
        loadTasks = @loadTasks
        _.each site.task_dir, (dir) ->
            allTasks = allTasks.concat (loadTasks dir)

        _.each allTasks, (task) -> console.log "Loaded #{task.name}"

        order = @buildTasks allTasks
        allTasks = _.groupBy allTasks, (task) -> task.name
        for task_name in order
            console.log "#{task_name}:"
            _.each allTasks[task_name], (p)-> p.run site, error

module.exports = AJournal
