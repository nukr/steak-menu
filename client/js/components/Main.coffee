React = require('react')
EditMeal = require('./EditMenu.coffee')
CreateMeal = require('./CreateMeal.coffee')
MealStore = require('../stores/MealStore.coffee')
actions = require('../actions/AppActionCreator.coffee')
utils = require('../utils/MealWebAPIUtils.coffee')

{div, button, h1, table, tr, th, td, thead, tbody} = React.DOM

MealTr = React.createFactory React.createClass
    render: ->
        tr {},
            td {},
                @props.meal.name
            td {},
                @props.meal.category
            td {},
                @props.meal.price
            td {},
                button
                    onClick: @edit
                    className: 'btn btn-success',
                        'EDIT'
                button
                    onClick: @delete
                    className: 'btn btn-danger',
                        'DELETE'

    edit: ->
        actions.showEditMeal(@props.meal)

    delete: ->
        utils.delete(@props.meal)

MealTable = React.createFactory React.createClass
    componentWillMount: ->
    renderMeal: ->
        MealTr meal: meal for meal in @props.meals

    render: ->
        table className: 'table lead',
            thead {},
                tr {},
                    th {},
                        'Name'
                    th {},
                        'Category'
                    th {},
                        'Price'
                    th {},
                        'Function'
                        button
                            className: 'btn'
                            onClick: @showCreateMeal,
                                'Create Meal'
            tbody
                @renderMeal()

    showCreateMeal: ->
        actions.showCreateMeal()


Main = React.createFactory React.createClass
    getInitialState: ->
        view: MealStore.getView()

    componentWillMount: ->
        MealStore.addChangeListener @change

    render: ->
        div className: 'main row',
            switch @state.view
                when 'Main'
                    MealTable meals: MealStore.getAllMeals()

                when 'EditMeal'
                    EditMeal()

                when 'CreateMeal'
                    CreateMeal()

    change: ->
        @setState
            view: MealStore.getView()

module.exports = Main
