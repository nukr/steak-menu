/*
 * Copyright (c) 2014, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 * AppDispatcher
 *
 * A singleton that operates as the central hub for application updates.
 */

var _ = require('lodash');
var Dispatcher = require('flux').Dispatcher;
var AppConstants = require('../constants/AppConstants');
var AppDispatcher = new Dispatcher();

_.extend(AppDispatcher, {

  /**
   * A bridge function between the views and the dispatcher, marking the action
   * as a view action.  Another variant here could be handleServerAction.
   * @param  {object} action The data coming from the view.
   */
  handleViewAction: function(action) {
    var payload = {
      source: AppConstants.SOURCE_VIEW_ACTION,
      action: action
    };

    this.dispatch(payload);
  },

  handleServerAction: function(action) {
    var payload = {
      source: AppConstants.SOURCE_SERVER_ACTION,
      action: action
    };

    this.dispatch(payload);
  }

});

module.exports = AppDispatcher;

