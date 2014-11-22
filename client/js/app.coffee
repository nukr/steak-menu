React = require('react')
MealStore = require('./stores/MealStore.coffee')
Main  = require('./components/Main.coffee')
utils = require('./utils/MealWebAPIUtils.coffee')

utils.getAll()

$(document).ready ->
    React.render Main(), document.getElementById('main')

