$ ->
  document.addEventListener("turbolinks:load", ()->
    $('#formModal').on('shown.bs.modal', (event)->
      button = $(event.relatedTarget)
      department = button.data('department')
      degrees = button.data('degrees').split('|')
      $('#modal-header').html(department)
      $('#department_options_department').val(department)

      $('#department_options_degrees').multiSelect().multiSelect('deselect_all').multiSelect('select', degrees)

    )
  )
