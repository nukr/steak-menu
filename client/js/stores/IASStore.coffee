AppDispatcher = require('../dispatcher/AppDispatcher')
EventEmitter  = require('events').EventEmitter
AppConstants  = require('../constants/AppConstants')
_             = require('lodash')
localforage = require('localforage')
async = require('async')

editPack = {}
accessToken = {}
user = {}
users = []
roles = []
view = 'Loading'
index = 'CustomerManagement'

IASStore = _.extend EventEmitter.prototype,

    getUnitState: (unitID) ->
        unitState: unitState[unitID]

    getUser: ->
        user

    getUsers: ->
        users

    getRoles: ->
        roles

    getView: ->
        view

    getAccessToken: ->
        accessToken

    getEditPack: ->
        editPack

    reset: ->
        accessToken = {}
        user = {}
        index = 'CustomerManagement'

    init: ->
        loadView = (callback) ->
            localforage.getItem 'view', callback

        loadUser = (callback) ->
            localforage.getItem 'user', callback

        loadAuth = (callback) ->
            localforage.getItem 'access_token', callback

        processResults = (err, results) ->
            if results.view is null
                view = 'CustomerManagement'
                localforage.setItem 'view', view
            else
                view = results.view
                localforage.setItem 'view', view
            user = results.user
            accessToken = results.accessToken
            IASStore.emitChange()

        localforage.getItem 'access_token', ((err, value) ->
            if value is null
                view = 'Signin'
                @emitChange()
                localforage.setItem 'view', view
            else
                async.parallel
                    view: loadView
                    user: loadUser
                    accessToken: loadAuth,
                    processResults
        ).bind(@)

    emitChange: ->
        @emit AppConstants.CHANGE_EVENT

    addChangeListener: (callback) ->
        @on AppConstants.CHANGE_EVENT, callback

    removeChangeListener: (callback) ->
        @removeListener AppConstants.CHANGE_EVENT, callback

AppDispatcher.register (payload) ->
    action = payload.action

    switch action.actionType
###############################################################################
    # Package CRUD
        when AppConstants.SHOW_PACKAGE_LIST
            view = 'PackageList'
            localforage.setItem 'view', view

        when AppConstants.SHOW_EDIT_PACKAGE
            view = 'Loading'
            $.get "http://0.0.0.0:3000/api/packs/#{action.item}", (pack) ->
                view = 'EditPackage'
                editPack = pack
                localforage.setItem 'view', view
                IASStore.emitChange()

        when AppConstants.SHOW_CREATE_PACKAGE
            view = 'CreatePackage'
            localforage.setItem 'view', view

        when AppConstants.CREATE_PACKAGE
            view = 'Loading'
            $.ajax
                type: 'POST'
                url: 'http://0.0.0.0:3000/api/packs'
                data: action.item
                dataType: 'json'
                success: (data) ->
                    console.log data
                    view = 'PackageList'
                    localforage.setItem 'view', view
                    IASStore.emitChange()

        when AppConstants.EDIT_PACKAGE
            view = 'Loading'
            $.ajax
                type: 'PUT'
                url: "http://0.0.0.0:3000/api/packs/#{action.item.id}"
                data: action.item.formData
                dataType: 'json'
                success: (data) ->
                    console.log data
                    view = 'PackageList'
                    localforage.setItem 'view', view
                    IASStore.emitChange()

        when AppConstants.DELETE_PACKAGE
            view = 'Loading'
            $.ajax
                type: 'DELETE'
                url: "http://0.0.0.0:3000/api/packs/#{action.item}"
                dataType: 'json'
                success: (data) ->
                    view = 'PackageList'
                    localforage.setItem 'view', view
                    IASStore.emitChange()

###############################################################################

        when AppConstants.SHOW_ADD_ROLE
            view = 'Loading'
            async.parallel
                users: (cb) ->
                    $.get "http://0.0.0.0:3000/api/users?access_token=#{accessToken.id}", (data) ->
                        cb(null, data)
                roles: (cb) ->
                    $.get "http://0.0.0.0:3000/api/roles?access_token=#{accessToken.id}", (data) ->
                        cb(null, data)
            , (err, results)->
                users = results.users
                roles = results.roles
                view = 'AddRole'
                localforage.setItem 'view', view
                IASStore.emitChange()

        when AppConstants.SHOW_CUSTOMER_MANAGEMENT
            view = 'CustomerManagement'
            localforage.setItem 'view', view

        when AppConstants.SHOW_CREATE_COMPANY
            view = 'CreateCompany'
            localforage.setItem 'view', view

        when AppConstants.CREATE_COMPANY
            view = 'Loading'
            $.ajax
                type: 'POST'
                url: 'http://0.0.0.0:3000/api/companies'
                data: action.item
                dataType: 'json'
                success: (data) ->
                    view = 'CustomerManagement'
                    localforage.setItem 'view', view
                    IASStore.emitChange()

        when AppConstants.SHOW_CONTACT
            view = 'Contact'
            localforage.setItem 'view', view

        when AppConstants.SHOW_PACK_SELECT
            view = 'PackSelect'
            localforage.setItem 'view', view

        when AppConstants.INIT_UNITS
            console.log action.item

        when AppConstants.SIGN_IN
            view = 'Loading'
            $.ajax
                type: 'POST'
                url: 'http://0.0.0.0:3000/api/users/login'
                data: action.item
                dataType: 'json'
                success: (data) ->
                    console.log 'login returns -> ', data
                    localforage.setItem 'access_token', data, (err, value) ->
                        view = index
                        localforage.setItem 'view', view
                        $.get "http://0.0.0.0:3000/api/users/#{data.userId}?access_token=#{data.id}", (user_server) ->
                            user = user_server
                            localforage.setItem 'user', user_server, (err, value) ->
                                IASStore.init()
                error: (xhr, type) ->
                    view = 'Signin'
                    IASStore.emitChange()

        when AppConstants.SIGN_OUT
            $.post "http://0.0.0.0:3000/api/users/logout?access_token=#{accessToken.id}", accessToken.id
            localforage.clear()
            IASStore.reset()
            view = 'Signin'

        when AppConstants.SHOW_USER_LIST
            view = 'UserList'
            localforage.setItem 'view', view

        when AppConstants.CREATE_ONLINE_MODULE
            $.post "http://0.0.0.0:3000/api/online_modules?access_token=#{accessToken.id}", action.item, (data) ->
                view = 'PackageList'
                localforage.setItem 'view', view
                IASStore.emitChange()

        when AppConstants.CREATE_OFFLINE_MODULE
            view = 'Loading'
            $.post "http://0.0.0.0:3000/api/offline_modules?access_token=#{accessToken.id}", action.item, (data) ->
                view = 'PackageList'
                localforage.setItem 'view', view
                IASStore.emitChange()

        when AppConstants.SHOW_CREATE_OFFLINE_MODULE
            view = 'CreateOfflineModule'
            localforage.setItem 'view', view

        when AppConstants.SHOW_CREATE_USER
            view = 'CreateUser'
            localforage.setItem 'view', view

        when AppConstants.SHOW_CREATE_ONLINE_MODULE
            view = 'CreateOnlineModule'
            localforage.setItem 'view', view

        when AppConstants.CREATE_USER

            view = 'Loading'
            $.post "http://0.0.0.0:3000/api/users?access_token=#{accessToken.id}", action.item, (data) ->
                IASStore.emitChange()

            view = 'UserList'
            localforage.setItem 'view', view

        when AppConstants.DROP_DOWN
            ''

        when AppConstants.MODULE_CHECKED
            console.log('module checked')

        else return true

    IASStore.emitChange()

    return true

module.exports = IASStore
