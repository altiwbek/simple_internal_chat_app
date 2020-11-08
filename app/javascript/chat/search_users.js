
$(document).on('turbolinks:load', function() {
  $(".search-users-ajax").select2({
    placeholder: "Select Multiple Users",
    theme: "bootstrap",
    allowClear: true,
    minimumInputLength: 3,
    ajax: {
      url: "/search_users",
      contentType: "application/json; charset=utf-8",
      data: function (params) {
        var query =
          {
            term: params.term,
          };
        return query;
      },
      processResults: function (result) {
        return {
          results: $.map(result.users, function (item) {
            return {
              id: item.id,
              text: item.email
            };
          }),
        };
      }
    }
  });
})