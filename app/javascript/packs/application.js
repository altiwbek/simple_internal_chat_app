// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap';
import "@fortawesome/fontawesome-free/js/all";
require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("jquery");
require( 'select2' );
require( 'select2/dist/js/i18n/en.js' );
require("../chat/messages");
require("../chat/search_users");

import "select2/dist/css/select2.min.css";
import "select2-theme-bootstrap4/dist/select2-bootstrap.min.css";


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
