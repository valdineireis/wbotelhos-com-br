# coding: utf-8
require 'spec_helper'

describe Article, '#edit' do
  let!(:category) { FactoryGirl.create :category }
  let!(:article_published) { FactoryGirl.create :article_published, categories: [category] }

  context 'when logged' do
    let(:user) { FactoryGirl.create :user }

    before do
      login with: user.email
      visit articles_edit_path article_published
    end

    context 'page' do
      it { current_path.should == "/articles/#{article_published.id}/edit" }

      it 'display title' do
        find('#title h2').should have_content 'Editar Artigo'
      end
    end

    context 'form' do
      it 'displays all categories' do
        page.should have_content category.name
      end

      it { page.should have_checked_field "category-#{category.id}" }
      it { page.should have_field 'article_body', text: article_published.body }
      it { page.should have_field "category-#{category.id}" }
      # TODO: using `page.should have_field 'article_title', text: article_published.title` does not work.
      it { find('#article_title').value.should == article_published.title }
      it { page.should have_button 'Atualizar' }
    end

    context 'while draft' do
      let!(:article_draft) { FactoryGirl.create :article, categories: [category] }

      before { visit articles_edit_path article_draft }

      it 'display draft indicator' do
        find('#status').should have_content 'Rascunho'
      end

      it 'show preview link' do
        find('#draft').should have_content 'Visualizar'
      end
    end

    context 'while published' do
      it 'displays published indicator' do
        find('#status').should have_content 'Publicado'
      end

      it 'hide publish button' do
        page.should have_no_button 'Publicar'
      end

      it 'show slug link' do
        find('#published').should have_content article_published.slug
      end
    end
  end

  context 'when unlogged' do
    before { visit articles_edit_path article_published.id }

    it 'redirects to the login page' do
      current_path.should == login_path
    end

    it 'displays error message' do
      within '#container-login' do
        page.should have_content 'Você precisa estar logado!'
      end
    end
  end
end
