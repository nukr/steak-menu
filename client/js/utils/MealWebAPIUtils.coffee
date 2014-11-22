actions = require('../actions/AppActionCreator.coffee')

url = 'http://0.0.0.0:3000/api/meals'

module.exports =
    getAll: ->
        $.get url, (data) ->
            actions.receiveAll(data)
