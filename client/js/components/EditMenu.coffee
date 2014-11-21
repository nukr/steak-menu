React = require('react')
MealStore = require('../stores/MealStore.coffee')
actions = require('../actions/AppActionCreator.coffee')
url = 'http://0.0.0.0:3000'
{button, label, fieldset, legend, input, h1, form, div} = React.DOM

ControlGroupInput = React.createFactory React.createClass
    render: ->
        div className: 'control-group',
            label className: 'control-label col-lg-2',
                @props.label
            div className: 'col-lg-10',
                input
                    className: 'form-control'
                    name: @props.name
                    placeholder: @props.label
                    defaultValue: @props.value

EditMeal = React.createFactory React.createClass
    getInitialState: ->
        meal: MealStore.getEditMeal()

    render: ->
        div {},
            form className: 'form-edit-meal form-horizontal',
                fieldset {},
                    legend {},
                        'Edit Meal'
                    ControlGroupInput
                        label: 'Name'
                        name: 'name'
                        value: @state.meal.name
                    ControlGroupInput
                        label: 'Price'
                        name: 'price'
                        value: @state.meal.price
                    ControlGroupInput
                        label: 'Category'
                        name: 'category'
                        value: @state.meal.category
                    ControlGroupInput
                        label: 'Remark'
                        name: 'remark'
                        value: @state.meal.remark
                    input
                        type: 'hidden'
                        name: 'id'
                        value: @state.meal.id
                    div className: 'control-group',
                        div className: 'col-lg-offset-2 col-lg-10',
                            button
                                onClick: @submit
                                className: 'btn btn-primary',
                                    'Submit'

    submit: (e) ->
        e.preventDefault()
        formData = $('.form-edit-meal').serialize()
        actions.editMeal(formData)


module.exports = EditMeal
