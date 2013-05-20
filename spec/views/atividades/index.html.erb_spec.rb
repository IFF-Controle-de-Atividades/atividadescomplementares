require 'spec_helper'

describe "atividades/index" do
  before(:each) do
    assign(:atividades, [
      stub_model(Atividade,
        :nome => "Nome",
        :modalidade_nome => "Modalidade Nome",
        :carga_horaria => 1.5,
        :aluno_id => 1,
        :avaliador_id => 2,
        :avaliada => false,
        :carga_horaria_aceita => 3,
        :justificativa => "MyText"
      ),
      stub_model(Atividade,
        :nome => "Nome",
        :modalidade_nome => "Modalidade Nome",
        :carga_horaria => 1.5,
        :aluno_id => 1,
        :avaliador_id => 2,
        :avaliada => false,
        :carga_horaria_aceita => 3,
        :justificativa => "MyText"
      )
    ])
  end

  it "renders a list of atividades" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Modalidade Nome".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
