module WsHelperSpike
	def retornarHash(xml)
		Hash.from_xml(xml).with_indifferent_access
	end

	def obtenerLosValoresPorNokogiri(xml)
		require 'nokogiri'
		obtenerValoresDeXML(Nokogiri::XML(xml).to_xml)
	end


	def obtenerValoresDeXML(xml)
		@xml = retornarHash(xml)
		@registros = @xml[:Envelope][:Body][:GetReportResponse][:GetReportResult][:diffgram][:NewDataSet][:Table]
		@registros.map do |registro| registro.values end
	end
end
