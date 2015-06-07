$(document).on 'page:change', ->
  
  $("form").on "ajax:success", (e, data, status, xhr) ->
    $(".status, .expiration_date").empty()
    $(".status").html("Status: " + data["status"])
    if data["expiration_date"] != ""
      $(".expiration_date").html("Expiration date: " + data["expiration_date"])
    $(form).on "ajax:error", (e, xhr, status, error) ->
      alert(error)