AppDispatcher = require('../dispatcher/AppDispatcher')
AppConstants = require('../constants/AppConstants')

AppActionCreators =
###############################################################################
    # Meal CRUD
    showEditMeal: (item) ->
        AppDispatcher.handleServerAction
            actionType: AppConstants.SHOW_EDIT_MEAL,
            item: item

    updateMeal: (item) ->
        AppDispatcher.handleServerAction
            actionType: AppConstants.UPDATE_MEAL,
            item: item

    showCreateMeal: ->
        AppDispatcher.handleServerAction
            actionType: AppConstants.SHOW_CREATE_MEAL

    createMeal: (item) ->
        AppDispatcher.handleServerAction
            actionType: AppConstants.CREATE_MEAL,
            item: item

    deleteMeal: (item) ->
        AppDispatcher.handleServerAction
            actionType: AppConstants.DELETE_MEAL,
            item: item

    receiveAll: (item) ->
        AppDispatcher.handleServerAction
            actionType: AppConstants.RECEIVE_ALL
            item: item
    error: (error) ->
        AppDispatcher.handleServerAction
            actionType: AppConstants.ERROR
            item: error

###############################################################################

module.exports = AppActionCreators

