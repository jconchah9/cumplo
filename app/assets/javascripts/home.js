$(document).on('turbolinks:load', function() {
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 30,
    min: new Date(1997,1,1),
    max: new Date(2020,1,1),
    format: 'yyyy-mm-dd'
  });
});