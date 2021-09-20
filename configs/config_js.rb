def add_application_js
<<-JS
//= require rails-ujs
//= require_tree .
JS
end

def add_pack_application_js
<<-JS
// External imports
import "bootstrap";

// Internal imports
import { initCookieBanner } from '../components/cookies'
import { initMapbox } from '../plugins/init_mapbox';
import "controllers"

document.addEventListener('turbolinks:load', () => {
  initCookieBanner();
  initMapbox();
});
JS
end

def add_pack_application_rails6_js
<<-JS
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

var Turbolinks = require("turbolinks")
Turbolinks.start()
JS
end

def add_webpack_js
<<-JS
const webpack = require('webpack')

// Preventing Babel from transpiling NodeModules packages
environment.loaders.delete('nodeModules');

// Bootstrap 4 has a dependency over jQuery & Popper.js:
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)
JS
end

def add_cookie_js
<<-JS
const initCookieBanner = () => {
  const cookiesBanner = document.getElementById("cookiesBanner");
  const cookiesGlobalConsentBtn = document.getElementById("cookiesGlobalConsent"); // "Accepter" button in cookies banner
  const cookiesConfigBtn = document.getElementById("cookiesConfigBtn"); // "Je valide" button in modal
  const googleAnalyticsBtn = document.getElementById("google_analytics_consent");
  const gaKey = googleAnalyticsBtn.dataset.analytics;
  const optOutCookieName = 'ga-disable-' + gaKey;

  const hideCookiesBanner = () => {
    cookiesBanner.classList.add("d-none");
  }
  const showCookiesBanner = () => {
    cookiesBanner.classList.remove("d-none");
  }

  const setCookie = (name, value, months) => {
    let expirationDate = new Date;
    expirationDate.setMonth(expirationDate.getMonth() + months);
    document.cookie = name + "=" + value + ";path=/;expires=" + expirationDate.toGMTString();
  }
  const saveCookiesPreferences = (googleAnalyticsRefused) => {
    setCookie("cookies-preferences-given", "true", 12);
    setCookie(optOutCookieName, `${googleAnalyticsRefused}`, 12); // Sets cookie if does not exist already
    window[optOutCookieName] = googleAnalyticsRefused; // Updates cookie value if already exists
    hideCookiesBanner();
  }
  if (document.cookie.indexOf('cookies-preferences-given=true') == -1) {
    showCookiesBanner();
  } else {
    googleAnalyticsBtn.checked = (document.cookie.indexOf(optOutCookieName + '=false') != -1);
  }

  cookiesGlobalConsentBtn.addEventListener("click", (e) => {
    googleAnalyticsBtn.checked = true;
    saveCookiesPreferences(!googleAnalyticsBtn.checked)
  })

  cookiesConfigBtn.addEventListener("click", (e)=>{
    saveCookiesPreferences(!googleAnalyticsBtn.checked)
  })
}
export { initCookieBanner };
JS
end

def add_mapbox_js
<<-JS
import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

export const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
  }
};
JS
end