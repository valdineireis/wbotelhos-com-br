# coding: utf-8
require 'spec_helper'

describe Lab, "#edit" do
  let!(:lab_published) { FactoryGirl.create :lab_published, description: 'description', image: 'image.jpg' }

  context "when logged" do
    let(:user) { FactoryGirl.create :user }

    before { login with: user.email }

    context "page" do
      before { visit labs_edit_path lab_published }

      it "display title" do
        page.find('#title h2').should have_content 'Editar Projeto'
      end
    end

    context "form" do
      before { visit labs_edit_path lab_published }

      it { current_path.should == "/labs/#{lab_published.id}/edit" }

      # TODO: why should have_field with text: does not work?
      it { page.find('#lab_name').value.should == lab_published.name }
      it { page.find('#lab_slug').value.should == lab_published.slug }
      it { page.find('#lab_description').value.should == lab_published.description }
      it { page.find('#lab_image').value.should == lab_published.image }
      it { page.should have_button 'Atualizar' }
    end

    context "while draft" do
      let!(:lab_draft) { FactoryGirl.create :lab }

      before { visit labs_edit_path lab_draft }

      it "display draft indicator" do
        page.find('#status').should have_content 'Rascunho'
      end
    end

    context "while published" do
      before { visit labs_edit_path lab_published }

      it "displays published indicator" do
        page.find('div#status').should have_content 'Publicado'
      end

      it "hide publish button" do
        page.should have_no_button 'Publicar'
      end

      it "shows the site url" do
        page.find('a#published').should have_content lab_published.site
      end
    end
  end

  context "when unlogged" do
    before { visit labs_edit_path lab_published.id }

    it "redirects to the login page" do
      current_path.should == login_path
    end

    it "displays error message" do
      page.should have_content 'Você precisa estar logado!'
    end
  end
end