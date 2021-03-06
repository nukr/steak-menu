AppDispatcher = require('../dispatcher/AppDispatcher')
EventEmitter  = require('events').EventEmitter
AppConstants  = require('../constants/AppConstants')
_             = require('lodash')
localforage = require('localforage')
async = require('async')

view = 'Main'
editMeal = []
url = 'http://0.0.0.0:3000'
_allMeals = []

update = (data) ->
    _allMeals[index] = data for meal, index in _allMeals when meal.id is data.id

destroy = (data) ->
    _.remove _allMeals, (meal) ->
        meal.id is data.id

create = (data) ->
    _allMeals.push(data)

MealStore = _.extend EventEmitter.prototype,

    init: ->

    getView: ->
        view

    getAllMeals: ->
        _allMeals

    getEditMeal: ->
        editMeal

    emitChange: ->
        @emit AppConstants.CHANGE_EVENT

    addChangeListener: (callback) ->
        @on AppConstants.CHANGE_EVENT, callback

    removeChangeListener: (callback) ->
        @removeListener AppConstants.CHANGE_EVENT, callback

AppDispatcher.register (payload) ->
    action = payload.action
    switch action.actionType
        when AppConstants.SHOW_EDIT_MEAL
            view = 'EditMeal'
            editMeal = action.item

        when AppConstants.UPDATE_MEAL
            view = 'Main'
            update action.item

        when AppConstants.SHOW_CREATE_MEAL
            view = 'CreateMeal'

        when AppConstants.CREATE_MEAL
            view = 'Main'
            create(action.item)

        when AppConstants.DELETE_MEAL
            destroy(action.item)
            view = "Main"

        when AppConstants.RECEIVE_ALL
            _allMeals = action.item

        when AppConstants.ERROR
            view = 'Error'

    MealStore.emitChange()

    return true

module.exports = MealStore
