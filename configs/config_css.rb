def add_sizing_css
<<-'SCSS'
$navbar-height: 100px;
$footer-height: 100px;

.page-min-height {
  min-height: calc(100vh - #{$navbar-height} - #{$footer-height})
}
.navbar-height{
  height: $navbar-height;
}

$sizes: 1px 4px 10px 12px 14px 16px 18px 20px 100px 125px 150px 200px 300px;
@each $size in $sizes {
  .height-#{$size} {
    height: $size;
  }
  .width-#{$size} {
    width: $size;
  }
  .max-height-#{$size} {
    max-height: $size;
  }
  .max-width-#{$size} {
    max-width: $size;
  }
  .min-height-#{$size} {
    min-height: $size;
  }
  .min-width-#{$size} {
    min-width: $size;
  }
}
SCSS
end

def add_banner_css
<<-SCSS
  .cookies-banner {
  background-color: $dark-transparent;
  z-index: 1000;
  font-size: 12px;
  bottom: 0px;
  p {
    font-size: 12px;
  }
}
SCSS
end

def add_utilities_css
<<-SCSS
.text-cookie {
  color: $cookie;
  &:hover{
    text-decoration: none;
    color: darken($cookie, 35%);
  }
}
.border-cookie {
  border-color: $cookie;
}
SCSS
end

def add_alert_css
 <<-SCSS
.alert {
  position: fixed;
  bottom: 16px;
  right: 16px;
  z-index: 1000;
}
.alert-info {
  background: $alert-info;
}
.alert-warning {
  background: $alert-warning;
}
SCSS
end

def add_colors_css
<<-'SCSS'
$blue-light: #BFD2D5;
$yellow-smooth: #F2B960;
$orange-smooth: #E65A2F;
$dark-gray: #39404d;
$light-gray: #f9f9f9;
$dark-transparent: rgba(50, 50, 50, 0.8);
$alert-info: $yellow-smooth;
$alert-warning: $orange-smooth;
$cookie: $blue-light;

$colors: ("blue-light", $blue-light), ("yellow-smooth", $yellow-smooth), ("orange-smooth", $orange-smooth), ("dark-gray", $dark-gray), ("light-gray", $light-gray),
  ("cookie", $cookie);

@each $color in $colors {
  .bg-#{nth($color, 1)} {
    background-color: nth($color, 2);
  }
  .text-#{nth($color, 1)} {
    color: nth($color, 2);
  }
}
SCSS
end

def add_font_css
<<-'SCSS'
// Import Google fonts
@import url("https://fonts.googleapis.com/css?family=Open+Sans:400,300,700|Raleway:400,100,300,700,500");
@import url('https://fonts.googleapis.com/css?family=Montserrat:400,,500,600&display=swap');

$fonts: 12px 14px 18px 20px;

@each $font in $fonts {
  .font-size-#{$font} {
    font-size: $font;
  }
}
SCSS
end

def add_button_css
<<-SCSS
.btn {
  cursor: pointer;
}
.btn.btn-rounded {
  border-radius: 20px;
}
.btn-cookie {
  color: $primary;
  background-color: $cookie;
  padding: 0.375rem 0.75rem;
  line-height: 1.5;
  font-weight: 600;
  border-radius: 8px;
  border: 1px solid transparent;
  transition: all 0.15s ease-in-out;
  &:hover {
    color: white;
    text-decoration: none;
    background-color: darken($cookie, 35%);
  }
}
SCSS
end

def add_footer_css
<<-SCSS
.footer {
  background-color: #3b3c3c;
  height: $footer-height;
  padding: 0px 50px;
}
.footer-links {
  display: flex;
  align-items: center;
}
.footer-links a {
  color: white;
  opacity: 0.4;
  text-decoration: none;
  font-size: 12px;
  font-weight: 300;
  padding: 0px 10px;
}
.footer-copyright {
  color: white;
  opacity: 0.4;
  font-size: 12px;
  font-weight: 300;
  text-decoration: none;
  a {
    color: white;
    opacity: 0.4;
    &:hover {
      color: white;
      opacity: 1;
      text-decoration: none;
    }
  }
}
SCSS
end

def add_bootstrap_variables_css
<<-SCSS
$spacer: 1rem !default;
$spacers: (
  0: 0,
  1: ($spacer * .25),
  2: ($spacer * .5),
  3: $spacer,
  4: ($spacer * 1.5),
  5: ($spacer * 3)
)
SCSS
end

def add_input_css
<<-SCSS
.toggle-slide-input {
  position: relative;
  display: inline-block;
  width: 2.75em;
  min-width: 2.75em;
  height: 1.55em;
  border-radius: 1.55em;
  vertical-align: middle;
  margin: 0 0.5rem;
  input {
    display: none;
  }
  label {
    display: block !important;
    width: 100% !important;
    height: 100%;
    border-radius: 1.75em;
    transition: background 0.125s;
    background-color: $dark-gray;
  }
  label::after {
    position: absolute;
    content: '';
    top: 0.1em;
    left: 0.1em;
    height: 1.35em;
    background-color: $cookie;
    border: 1px solid $dark-gray;
    border-radius: 1.35em;
    transition: all 0.2s;
    background: $light-gray;
    right: 1.3em;
  }
  input:checked + label {
    background-color: $cookie;
    &:after {
      right: 0.1em;
      left: 1.3em;
      border: 1px solid $cookie;
    }
  }
}
SCSS
end

def add_navbar_css
<<-SCSS
.navbar-flo {
  box-shadow: 0 1px 5px 0 rgba(0,0,0,0.07),0 1px 0 0 rgba(0,0,0,0.03);
  background: white;
  transition: all 0.3s ease;
  height: $navbar-height;
  padding: 0px 30px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  position: fixed;
  z-index: 600;
  width: 100%;
}
.navbar-flo-brand img {
  height: 60px;
}
.navbar-flo .avatar {
  height: 35px;
  width: 35px;
  border-radius: 50%;
}
.navbar-flo-item {
  padding: 0 20px;
}
.navbar-flo-link {
  color: black;
  font-size: 14px;
  cursor: pointer;
}
.navbar-flo-link:hover {
  color: $blue-light;
  text-decoration: none;
}
.navbar-link {
  flex: 0 1 auto;
  cursor: pointer;
  padding: 0 10px;
  text-decoration: none;
  color: white;
  font-size: 12px;
  @media (max-width: 768px){
    font-size: 20px;
  }
}
.navbar-link:hover {
  color: $blue-light;
  text-decoration: none;
}
.navbar-link:visited {
  outline: 0;
  color: white;
  text-decoration: none;
}
.navbar-link:focus {
  color: white;
  outline: 0;
  text-decoration: none;
}
.navbar-dropdown {
  flex: 0 1 auto;
  cursor: pointer;
  padding: 0 10px;
  text-decoration: none;
  color: white;
}
.navbar-dropdown-menu {
  margin-top: 15px;
  border-color: $blue-light;
}
.navbar-dropdown-menu > a {
  transition: color 0.3s ease;
  font-weight: lighter !important;
  font-size: 10px !important;
  line-height: 22px !important;
  padding: 0px 15px;
  display: flex;
}
.navbar-dropdown-menu > a:hover {
  background: transparent !important;
  color: black !important;
}
.navbar-dropdown-menu:before {
  content: ' ';
  height: 10px;
  width: 10px;
  position: absolute;
  right: 10px;
  top: -6px;
  background-color: white;
  transform: rotate(45deg);
  border-left: 1px solid $blue-light;
  border-top: 1px solid $blue-light;
}
.hamburger {
  position: absolute;
  width: 30px;
  height: 25px;
  top: 15px;
  right: 15px;
  z-index: 5;
}
.hamburger div {
  position: relative;
  width: 30px;
  height: 2px;
  background-color: black;
  margin-top: 7px;
  -webkit-transition: all 0.4s ease-in-out;
  transition: all 0.4s ease-in-out;
}
#toggle {
  display: none;
}
#toggle:checked + .hamburger .top {
  -webkit-transform: rotate(-45deg);
          transform: rotate(-45deg);
  margin-top: 22.5px;
  background-color: white;
}
#toggle:checked + .hamburger .meat {
  -webkit-transform: rotate(45deg);
          transform: rotate(45deg);
  margin-top: -2px;
  background-color: white;
}
#toggle:checked + .hamburger .bottom {
  -webkit-transform: scale(0);
          transform: scale(0);
}
#toggle:checked + .hamburger + .nav {
  top: 0;
  background-color: rgba(74, 167, 159,0.9);
}
.nav {
  z-index: 1;
  position: fixed;
  width: 100%;
  height: 100%;
  top: -100%;
  left: 0;
  right: 0;
  bottom: 0;
  overflow: hidden;
  -webkit-transition: all 0.3s ease-in-out;
  transition: all 0.3s ease-in-out;
}
.nav .nav-wrapper {
  position: relative;
  z-index: 500;
  overflow-y: auto;
  height: 100%;
  width: 100%;
}
nav {
  height: 100vh;
  text-align: center;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
      -ms-flex-direction: column;
          flex-direction: column;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  -webkit-box-pack: center;
      -ms-flex-pack: center;
          justify-content: center;
}
nav a {
  width: 100%;
  padding: 10px 0;
  margin-top: 15px;
  color: black;
  font-weight: bold;
  opacity: 0;
  text-decoration: none;
  font-size: 2.3em;
  letter-spacing: 3px;
  -webkit-transition: all 0.3s ease;
  transition: all 0.3s ease;
}
nav a:hover {
  color: white;
  -webkit-transition: all 0.3s ease;
  transition: all 0.3s ease;
}
nav a:first-child {
  margin-top: 0;
}
#toggle:checked + .hamburger + .nav .nav-wrapper nav a {
  opacity: 0.9;
  -webkit-transform: scale(1);
          transform: scale(1);
}
SCSS
end

def add_components_index_css
<<-SCSS
@import "alert";
@import 'banner';
@import 'footer';
@import 'input';
@import 'navbar';
@import 'utilities';
SCSS
end

def add_config_index_css
<<-SCSS
@import "fonts";
@import "colors";
@import "sizing";
@import "bootstrap_variables";
SCSS
end
def add_layouts_index_css
<<-SCSS
SCSS
end

def add_units_index_css
<<-SCSS
@import "button";
SCSS
end

def add_application_css
<<-SCSS
// External libraries
@import "bootstrap/scss/bootstrap";
@import "font-awesome-sprockets";
@import "font-awesome";

// Your CSS partials
@import "layouts/index";
@import "config/index";
@import "components/index";
@import "units/index";
SCSS
end