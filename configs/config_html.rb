def add_layout_html
<<-HTML
<!DOCTYPE html>
<html>
  <head>
    <%= render "layouts/google_analytics" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title><%= meta_title %></title>
    <meta name="description" content="<%= meta_description %>">
    <!-- Facebook Open Graph data -->
    <meta property="og:title" content="<%= meta_title %>" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="<%= request.original_url %>" />
    <meta property="og:image" content="<%= meta_image %>" />
    <meta property="og:description" content="<%= meta_description %>" />
    <meta property="og:site_name" content="<%= meta_title %>" />
    <%= favicon_link_tag asset_path("favicon.svg")%>

    <%= yield(:robots) %>
    <%= csrf_meta_tags %>
    <%= action_cable_meta_tag %>
    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= stylesheet_pack_tag 'application', media: 'all' %> <!-- Uncomment if you import CSS in app/javascript/packs/application.js -->
    #{"    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload', defer: true %>\n" if Rails.version < "6"}
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload', defer: true %>
    <!-- 	prevent Chrome animation on loading -->
    <script type="text/javascript"> </script>
  </head>
  <body>
    <%= render "layouts/cookies_banner" %>
    <%= render 'shared/navbar' %>
    <%= render 'shared/flashes' %>
    <%= yield %>
    <%= render 'shared/footer' %>

    <script type="application/ld+json">
      {
        "@context": "http://schema.org",
        "@type": "Organization",
        "name": "yourdomain",
        "url": "https://www.yourdomain.com/",
        "logo": "",
        "contactPoint": [{
          "@type": "ContactPoint",
          "url": "https://www.yourdomain.com",
          "email": "contact@yourdomain.com",
          "telephone": "+33-30000000",
          "contactType": "customer service"
        }],
        "image": "",
        "description": ""
      }
    </script>
  </body>
</html>
HTML
end

def add_pages_home_html
<<-HTML
<%= content_for :meta_title %>
<div class="container page-min-height">
  <h1>Pages#Home</h1>
  <p>Find me in app/views/pages/home.html.erb</p>
</div>
HTML
end

def add_pages_legal_html
<<-HTML
<% content_for(:robots) do %>
  <meta name="robots" content='noindex, nofollow'>
<% end %>
<div class="container page-min-height">
  <%= @page.content&.html_safe %>
   <div class="mt-3">
    À tout moment, l’Utilisateur peut faire le choix d’exprimer et de modifier ses souhaits en matière de Cookies. <a href="<%= ENV["DOMAIN"] %>">agences-et-curieux-sabstenir.fr</a> pourra en outre faire appel aux services de prestataires externes pour l’aider à recueillir et traiter les informations décrites dans cette section.</p>
            À tout moment, l’Utilisateur peut faire le choix d’exprimer et de modifier ses souhaits en matière de Cookies en cliquant sur le lien ci-dessous. <a href="<%= ENV["DOMAIN"] %>">agences-et-curieux-sabstenir.fr</a> pourra en outre faire appel aux services de prestataires externes pour l’aider à recueillir et traiter les informations décrites dans cette section.</p>
    <div class="d-flex justify-content-center mb-4">
      <div class="btn btn-cookie font-size-16px py-2" data-bs-toggle="modal" data-bs-target="#cookiesModal">PERSONNALISER LES COOKIES</div>
    </div>
  </div>
</div>
HTML
end

def update_error_with_controller_html
  <<-HTML
  <div class="container text-center page-min-height py-5">
      <h1>
        Page d'erreur
      </h1>
      <p>Une erreur est survenue. <br> Veuillez nous excuser pour la gêne occasionée.</p>
      <p>N'hésitez pas à retourner sur la page précédente et à réessayer.</p>
      <p><a class="link_mail_to" href="mailto:florent.braure@gmail.com">Reporter le probléme</a></p>
    </div>
    <div class="container">
      <a class="button-green" href="/">Retour sur le site</a>
    </div>
  HTML
end

def update_error_page_html(var)
<<-HTML
<!DOCTYPE html>
<html>
<head>
  <title> ENV["DOMAIN"] - Erreur</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <meta charset="UTF-8">
  <style>
    body {
        background-color: white;
        color: #2E2F30;
        text-align: center;
        font-family: "Montserrat", sans-serif;
        margin: 20px;
      }

      .banner-logo img {
        max-width: 90%;
      }

      .container {
        margin: 40px auto;
      }
      h1 {
        font-size: 32px;
        margin: 0px;
      }
      p {
        font-size: 20px;
      }
      .link_mail_to {
        text-decoration: none;
        color: #2e2f30ad;
      }
      .link_mail_to:hover {
        text-decoration: none;
        color: #2E2F30;
      }
      .button-green {
        border-radius: 2px;
        margin: 20px 0px;
        text-decoration: none;
        padding: 10px 41px;
        color: white;
        background-color: #888485;
        font-weight: lighter;
      }
     .button-green:hover {
        text-decoration: none;
        background-color: #a7a4a5;
      }
    </style>
  </head>
  <body class="rails-default-error-page">
    <!-- This file lives in public/500.html -->
      <div class="banner-logo">
        <img src="logo.png" alt="logo">
      </div>
      <div class="container">
        <h1>
          Page d'erreur
        </h1>
        <p>
          Une erreur est survenue. <br> Veuillez nous excuser pour la gêne occasionée.
        </p>
         <p>
          N'hésitez pas à retourner sur la page précédente et à réessayer.
        </p>
        <p>
          <a class="link_mail_to" href="mailto:florent.braure@gmail.com">Reporter le probléme</a>
        </p>
      </div>
      <div class="container">
        <a class="button-green" href="/">Retour sur le site</a>
      </div>
  </body>
</html>
HTML
end

def add_navbar_html
<<-HTML
<div class="navbar-flo">
  <a href="/" class="navbar-flo-brand">
    <%= image_tag "logo.png" %>
  </a>
  <div class="d-none d-md-block">
    <div class="d-flex align-items-center justify-content-between">
      <%= link_to "Exemple", "/", class: "navbar-flo-item navbar-flo-link" %>
      <% if user_signed_in? %>
        <%= link_to t(".sign_out", default: "Log out"), destroy_user_session_path, method: :delete , class: "navbar-flo-item navbar-flo-link"%>
      <% else %>
        <%= link_to t(".sign_in", default: "Login"), new_user_session_path , class: "navbar-flo-item navbar-flo-link"%>
      <% end %>
    </div>
  </div>
  <div class="d-block d-md-none">
    <div class="navbar-dropdown">
      <input id="toggle" type="checkbox"/>
      <label class="hamburger" for="toggle">
        <div class="top"></div>
        <div class="meat"></div>
        <div class="bottom"></div>
      </label>
      <div class="nav">
        <div class="nav-wrapper">
          <nav class= "d-flex flex-column">
            <%= link_to "Accueil", root_path, class: "navbar-link" %>
            <% if user_signed_in? %>
              <%= link_to "Se Déconnecter", destroy_user_session_path, class: "navbar-link", method: :delete %>
            <% else %>
              <%= link_to "Créer un Compte", new_user_registration_path, class: "navbar-link" %>
              <%= link_to "Se Connecter", new_user_session_path,  class: "navbar-link" %>
            <% end %>
          </nav>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="navbar-height"></div>
HTML
end

def add_footer_html
<<-HTML
<div class="footer d-flex justify-content-between align-items-center">
  <div class="footer-links">
  </div>
  <div class="footer-copyright d-flex flex-column">
    © 2018 <%=ENV["DOMAIN"] || "localhost:3000"%>
    <%= link_to legal_path do %>
      Mentions légales
    <% end %>
    <%= link_to "https://www.florent.braure.com/", target: "_blank" do %>
      Site réalisé par Florent BRAURE
    <% end %>
  </div>
</div>
HTML
end

def add_flash_html
<<-HTML
<% if notice %>
  <div class="alert alert-info alert-dismissible fade show m-1" role="alert">
    <%= notice %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </button>
  </div>
<% end %>
<% if alert %>
  <div class="alert alert-warning alert-dismissible fade show m-1" role="alert">
    <%= alert %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </button>
  </div>
<% end %>
HTML
end

def add_google_analytics_html
<<-HTML
<% if Rails.env == "production"  %>
  <!-- Global site tag (gtag.js) - Google Analytics -->
  <script async src="https://www.googletagmanager.com/gtag/js?id=<%= ENV['GOOGLE_ANALYTICS_KEY'] %>"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', "<%= ENV['GOOGLE_ANALYTICS_KEY'] %>");
  </script>
<% end %>
HTML
end

def add_cookie_html
<<-HTML
  <div id="cookiesBanner" class="cookies-banner py-3  d-none position-fixed w-100">
  <div class="d-md-flex container align-items-center">
    <p class="mb-md-0 flex-grow-1 text-white mr-md-3">
      Nous utilisons des cookies, dont des cookies tiers (Google) pour vous offrir une expérience utilisateur de qualité ainsi que pour suivre et analyser le trafic sur le site. En cliquant sur « Accepter », vous acceptez que nous utilisions ces cookies. Vous pouvez à tout moment modifier vos paramètres de cookies. Pour cela, nous vous invitons à consulter notre Politique de confidentialité en cliquant sur « Personnaliser »
      <br><%= link_to "En savoir plus", legal_path, target: "_blank", class: "link-no-decoration text-cookie" %>
    </p>
    <div class="d-flex">
      <div id="cookiesGlobalConsent" class="btn btn-cookie font-size-12px me-3">Accepter</div>
      <div class="btn btn-cookie font-size-12px" data-bs-toggle="modal" data-bs-target="#cookiesModal">Personnaliser</div>
    </div>
  </div>
</div>
<div class="modal fade font-size-14px font-montserrat" id="cookiesModal" tabindex="-1" role="dialog" aria-labelledby="cookiesModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered max-width-650px" role="document">
    <div class="modal-content p-3 ">
      <div class="modal-header border-0 p-0">
        <%= image_tag "logo.png", width: 60 %>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body px-md-6">
        <p class="font-weight-bold title-small">Votre Accord sur l'utilisation des cookies</p>
        <p>Vous êtes libre d'activer et de désactiver à tout moment les familles de cookies suivantes :</p>
        <p class="font-weight-bold">Cookies strictement nécessaires</p>
        <div class="d-flex align-items-center justify-content-between mb-3">
          <p class="flex-grow-1 mb-0">Ils sont indispensables au bon fonctionnement du site.</p>
          <%= image_tag "check.svg", width: 25 %>
        </div>
        <p class="font-weight-bold">Cookies Statistiques</p>
        <div class="d-flex align-items-center mb-2">
          <p class="flex-grow-1 mb-0">Ils nous permettent d'établir des statistiques anonymes via Google Analytics</p>
          <div class="min-width-60px">
            <div class="toggle-slide-input">
              <input type="checkbox" name="google_analytics_consent" id="google_analytics_consent" data-analytics="<%= ENV['GOOGLE_ANALYTICS_KEY'] %>">
              <label for="google_analytics_consent"></label>
            </div>
          </div>
        </div>
      </div>
      <div class="text-center">
        <div type="button" id="cookiesConfigBtn" class="btn btn-cookie" data-bs-dismiss="modal">Je valide</div>
      </div>
    </div>
  </div>
</div>
HTML
end

def add_devise_content_html
<<-HTML
<div class="container page-min-height pt-3">
  <%= yield(:form) %>
</div>
HTML
end

def update_devise_content_prepend_html
<<-HTML
<% content_for(:form) do %>
HTML
end
def update_devise_content_append_html
<<-HTML
<% end %>
<%= render "devise/shared/form"%>
HTML
end