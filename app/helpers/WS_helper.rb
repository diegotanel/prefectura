module WsHelper

  def retornarHash(xml)
    Hash.from_xml(xml).with_indifferent_access
  end

  def obtenerDatosdelWS(reportName, fecha, url)
    client = Savon::Client.new(url)
    response = client.request :get_report do |soap|
      soap.body = {"report_name" => reportName, "report_params" => {"ReportParam" => {"nombre" => "fecha", "valor" => fecha, :attributes! => { "ins0:valor" => { "xsi:type" => "xsd:string"} } } } }
    end
    response.to_xml
  end

  def obtenerListado(xml)
    @xml = retornarHash(xml)
    @registros = @xml[:Envelope][:Body][:GetReportResponse][:GetReportResult][:diffgram][:NewDataSet][:Table]
    @encabezados = ["FH_INFO", "HS_INFO", "PT_INFO", "MATRICULA", "SDIST", "NRO_OMI", "IDEN", "PT_ORIG", "PT_DESTINO", "TIPO_MOV", "PT_FINAL", "EN_VIAJE", "NOMBRE", "UNIDAD", "KM", "CARGA", "OBSERVAC", "BAND", "ARQUEO_NETO", "CALADO_MAX", "CALADOR", "SERN", "TIPO_EVENTO", "COMENTARIO", "ID_VIAJE", "ID_ETAPA", "NRO_ETAPA", "ID_EVENTO", "REMOLCADA_POR", "ORIGEN", "DESTINO"]
    @resultado = []
    @hash = {}
    @registros.each do |registro| 
      @encabezados.each do |encabezado| 
        @hash[encabezado] = registro[encabezado]
      end
      @resultado << @hash
    end
    return @resultado
  end

  #  def formatearFecha(fecha)
  #    fecha.strftime("%d-%m-%y")
  #  end

  def obtenerFecha(nombreDeCampo, params)
    @fecha = Date.new(params["#{nombreDeCampo.to_s}(1i)"].to_i, 
                      params["#{nombreDeCampo.to_s}(2i)"].to_i, 
                      params["#{nombreDeCampo.to_s}(3i)"].to_i)
    #   formatearFecha @fecha
  end

end
