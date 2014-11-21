React = require('react')
MealStore = require('./stores/MealStore.coffee')
Main  = require('./components/Main.coffee')

MealStore.init()

$(document).ready ->
    React.render Main(), document.getElementById('main')

