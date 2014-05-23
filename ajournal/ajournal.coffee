
# Task : AJournal
# Description : The main task that load site configuration and run
# all tasks
# Author : Evan Sebastian <evanlhoini@gmail.com>

AJournal =
    build: (config_json = './config.json') ->
        _ = require 'underscore'
        error = (except) -> throw except
        site = require config_json
        invalid  = (site) -> not (site? and site.title? and site.task_dir?)

        error "Invalid or incomplete config.json, make sure field title and
         task are not empty" if invalid site

        site.template = site.template or 'template'
        site.output = site.output or '_site'
        site.encoding = site.encoding or 'utf8'

        loadTasks = (directory) ->
            fs = require 'fs'
            tasks = []
            files = fs.readdirSync directory
            for file in files
                if file[0] isnt '.'
                    tasks.push require ('./' + directory + '/' + file)
            return tasks

        allTasks = []
        _.each site.task_dir, (dir) ->
            allTasks = allTasks.concat (loadTasks dir)

        buildTasks = (tasks) ->
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
            return order

        order = buildTasks allTasks
        allTasks = _.groupBy allTasks, (task) -> task.name
        for task_name in order
            console.log "Running #{task_name} on #{site.title}..."
            error = "Error on #{task_name}"
            _.each allTasks[task_name], (t) -> t.run(site, error)

module.exports = AJournal
