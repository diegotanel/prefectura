#encoding: utf-8

class PosicionesController < ApplicationController

  def new
    @OrigenesDeReporte = OrigenDeReporte.all
    @title = 'Home'
  end

  def create
    @cod = params[:reporte][:codigo]
    @ano = params[:reporte]["fecha(1i)"]
    @mes = params[:reporte]["fecha(2i)"]
    @dia = params[:reporte]["fecha(3i)"]

    unless @cod.blank? || @ano.blank? || @mes.blank? || @dia.blank?
      @fechaString = "#{@ano.to_s}-#{@mes.to_s}-#{@dia.to_s}"
      @fec = Chronic.parse(@fechaString)
      @fecFormateada = @fec.strftime("%d-%m-%y")
      @url = Urlws.first.url
      @respuestaWS = obtenerDatosdelWS(@cod, @fecFormateada, @url)
      unless @respuestaWS.blank?
        @listado = obtenerListadoEnArray(@respuestaWS)
        require 'dbi'
        require 'odbc_utf8'
        @dbh = DBI.connect('DBI:ODBC:rubydbf','','') #  Connect to a database, old style
        registro=Basedbf.new
        @listado.each do |valor| 
          mensaje=registro.insertar("pnanove", valor, @dbh)
        end
        flash[:success] = "Se obtenido la información exitosamente"
        redirect_to root_path
      end
    else
      @OrigenesDeReporte = OrigenDeReporte.all
      flash.now[:error] = 'Ha ocurrido un error al obtener los datos'
      render 'new'
    end
  end

end
