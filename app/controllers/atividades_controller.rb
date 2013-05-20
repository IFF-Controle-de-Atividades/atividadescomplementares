#encoding:utf-8

class AtividadesController < ApplicationController
 
  before_filter :authenticate_aluno!
  before_filter :current_aluno, :only => [:new, :show, :create, :edit, :update, :destroy]
  # GET /atividades
  # GET /atividades.json
  def index
    @atividades = Atividade.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @atividades }
    end
  end

  # GET /atividades/1
  # GET /atividades/1.json
  def show
    @atividade = Atividade.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @atividade }
    end
  end

  # GET /atividades/new
  # GET /atividades/new.json
  def new
    @atividade = Atividade.new
    @aluno_atual = current_aluno

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @atividade }
    end
  end

  # GET /atividades/1/edit
  def edit
    @atividade = Atividade.find(params[:id])
    
  end

  # POST /atividades
  # POST /atividades.json
  def create
    @atividade = Atividade.new(params[:atividade])
    @aluno_atual = current_aluno
    respond_to do |format|
      if @atividade.save
#        AtividadeMailer.atividade_registration(@aluno_atual,@atividade).deliver
        format.html { redirect_to aluno_home_path }
        flash[:notice] = "Sua Atividade foi inserida com sucesso"
        format.json { render json: @atividade, status: :created, location: @atividade }
      else
        format.html { render action: "new" }
        format.json { render json: @atividade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /atividades/1
  # PUT /atividades/1.json
  def update
    @atividade = Atividade.find(params[:id])

    respond_to do |format|
      if @atividade.update_attributes(params[:atividade])
        format.html { redirect_to aluno_home_path }
        flash[:notice] = "Sua Atividade foi atualizada com sucesso"
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @atividade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atividades/1
  # DELETE /atividades/1.json
  def destroy
    @atividade = Atividade.find(params[:id])
    @atividade.destroy

    respond_to do |format|
      format.html { redirect_to listadeatividades_path }
      format.json { head :no_content }
    end
  end


 end