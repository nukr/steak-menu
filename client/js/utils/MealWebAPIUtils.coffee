actions = require('../actions/AppActionCreator.coffee')

url = 'http://0.0.0.0:3000/api/meals'

module.exports =
    getAll: ->
        $.get url, (data) ->
            actions.receiveAll(data)

    update: (formData) ->
        $.ajax
            url: url
            method: 'PUT'
            data: formData
            success: (data) ->
                actions.updateMeal(data)
            error: (error) ->
                actions.error(error)

    delete: (meal) ->
        $.ajax
            url: "#{url}/#{meal.id}"
            method: 'DELETE'
            success: (data) ->
                actions.deleteMeal(meal)
            error: (error) ->
                actions.error(error)

    create: (formData) ->
        $.post url, formData, (data) ->
            actions.createMeal(data)
