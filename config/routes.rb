Blog::Application.routes.draw do
  root :to => "articles#index"

  controller :admin do
    get   "/admin", :action => :index
  end

  controller :articles do
    get   "/articles",                :action => :index,    :as => :articles
    post  "/articles",                :action => :create,   :as => :create_article
    get   "/articles/drafts",         :action => :drafts,   :as => :drafts_articles
    get   "/articles/new",            :action => :new,      :as => :new_article
    get   "/articles/search",         :action => :search,   :as => :search_articles
    get   "/articles/:id",            :action => :preview,  :as => :preview_article
    put   "/articles/:id",            :action => :update,   :as => :update_article
    get   "/articles/:id/edit",       :action => :edit,     :as => :edit_article
    get   "/:year/:month/:day/:slug", :action => :show,     :as => :article
  end

  controller :categories do
    get   "/category/:id", :action => :show, :as => :category
  end

  controller :comments do
    post  "/articles/:article_id/comments/new",   :action => :create, :as => :new_comment
    put   "/articles/:article_id/comments/:id",   :action => :update, :as => :update_comment
  end

  controller :feed do
    get   "/feed", :action => :feed, :as => :feed
  end

  controller :labs do
    get   "/labs",            :action => :index,  :as => :labs
    post  "/labs",            :action => :create, :as => :create_lab
    get   "/labs/drafts",     :action => :drafts, :as => :drafts_labs
    get   "/labs/new",        :action => :new,    :as => :new_lab
    put   "/labs/:id",        :action => :update, :as => :update_lab
    get   "/labs/:id/edit",   :action => :edit,   :as => :edit_lab
  end

  controller :sessions do
    get   "/login",   :action => :new,    :as => :login
    post  "/login",   :action => :create, :as => false # TODO: what is the rule to avoid alias?
    get   "/logout",  :action => :destroy
  end

  controller :users do
    get   "/about",           :action => :about,  :as => :about
    get   "/users",           :action => :index,  :as => :users
    post  "/users",           :action => :create, :as => :create_user
    get   "/users/new",       :action => :new,    :as => :new_user
    get   "/users/:id/edit",  :action => :edit,   :as => :edit_user
  end

end
