require 'spec_helper'

describe "atividades/show" do
  before(:each) do
    @atividade = assign(:atividade, stub_model(Atividade,
      :nome => "Nome",
      :modalidade_nome => "Modalidade Nome",
      :carga_horaria => 1.5,
      :aluno_id => 1,
      :avaliador_id => 2,
      :avaliada => false,
      :carga_horaria_aceita => 3,
      :justificativa => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nome/)
    rendered.should match(/Modalidade Nome/)
    rendered.should match(/1.5/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(/3/)
    rendered.should match(/MyText/)
  end
end
