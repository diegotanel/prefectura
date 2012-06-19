class PosicionesController < ApplicationController

  def new
    @OrigenesDeReporte = OrigenDeReporte.all
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
        @listado = obtenerListado(@respuestaWS)
        @listadoJSON = ActiveSupport::JSON.encode(@listado)
        File.open(File.join("spec/helpers", 'file.txt'), 'w') do |f|
          f.write @listadoJSON 
        end
      end
      redirect_to root_path
    else
      @OrigenesDeReporte = OrigenDeReporte.all
      render 'new'
    end

  end

end
