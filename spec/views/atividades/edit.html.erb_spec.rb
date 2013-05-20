require 'spec_helper'

describe "atividades/edit" do
  before(:each) do
    @atividade = assign(:atividade, stub_model(Atividade,
      :nome => "MyString",
      :modalidade_nome => "MyString",
      :carga_horaria => 1.5,
      :aluno_id => 1,
      :avaliador_id => 1,
      :avaliada => false,
      :carga_horaria_aceita => 1,
      :justificativa => "MyText"
    ))
  end

  it "renders the edit atividade form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", atividade_path(@atividade), "post" do
      assert_select "input#atividade_nome[name=?]", "atividade[nome]"
      assert_select "input#atividade_modalidade_nome[name=?]", "atividade[modalidade_nome]"
      assert_select "input#atividade_carga_horaria[name=?]", "atividade[carga_horaria]"
      assert_select "input#atividade_aluno_id[name=?]", "atividade[aluno_id]"
      assert_select "input#atividade_avaliador_id[name=?]", "atividade[avaliador_id]"
      assert_select "input#atividade_avaliada[name=?]", "atividade[avaliada]"
      assert_select "input#atividade_carga_horaria_aceita[name=?]", "atividade[carga_horaria_aceita]"
      assert_select "textarea#atividade_justificativa[name=?]", "atividade[justificativa]"
    end
  end
end
