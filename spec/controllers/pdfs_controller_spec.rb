require 'spec_helper'

describe PdfsController do

  describe "GET 'aluno_atividades_pdf'" do
    it "returns http success" do
      get 'aluno_atividades_pdf'
      response.should be_success
    end
  end

  describe "GET 'avaliadores_pdf'" do
    it "returns http success" do
      get 'avaliadores_pdf'
      response.should be_success
    end
  end

  describe "GET 'atividades_pdf'" do
    it "returns http success" do
      get 'atividades_pdf'
      response.should be_success
    end
  end

  describe "GET 'alunos_pdf'" do
    it "returns http success" do
      get 'alunos_pdf'
      response.should be_success
    end
  end

end
