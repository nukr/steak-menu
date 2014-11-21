AppDispatcher = require('../dispatcher/AppDispatcher')
AppConstants = require('../constants/AppConstants')

AppActionCreators =
###############################################################################
    # Meal CRUD
    showEditMeal: (item) ->
        AppDispatcher.handleServerAction
            actionType: AppConstants.SHOW_EDIT_MEAL,
            item: item

    editMeal: (item) ->
        AppDispatcher.handleServerAction
            actionType: AppConstants.EDIT_MEAL,
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
###############################################################################

module.exports = AppActionCreators

