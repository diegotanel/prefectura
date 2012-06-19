#encoding: utf-8

require 'spec_helper'

describe WsHelper do
  describe "parsear XML" do
    before(:each) do
      @dummy_class = DummyClass.new
      @dummy_class.extend(WsHelper)
    end

    it "debe tener un metodo retornarHash"do
      @dummy_class.should respond_to(:retornarHash)
    end

    it "debe tener un método obtenerListado" do
      @dummy_class.should respond_to(:obtenerListado)
    end

    it "debe tener un método formatearTextoComoFecha" do
      @dummy_class.should respond_to(:obtenerFecha)
    end

    describe "comparación de datos" do
      before(:each) do
        @xml = File.open(File.join("spec/helpers", "soap.txt"), :encoding => "ISO-8859-1").read
      end

      it "obtener los valores en un hash" do
        @attr = [{"FH_INFO"=>"03/04/2012", "HS_INFO"=>"22:14:36", "PT_INFO"=>"CORR", "MATRICULA"=>"0", "SDIST"=>"ZPPA", "NRO_OMI"=>"8950811", "IDEN"=>"CAVALIER III", "PT_ORIG"=>nil, "PT_DESTINO"=>nil, "TIPO_MOV"=>nil, "PT_FINAL"=>nil, "EN_VIAJE"=>"1", "NOMBRE"=>"Rio Paraguay", "UNIDAD"=>"KM", "KM"=>"1240", "CARGA"=>nil, "OBSERVAC"=>nil, "BAND"=>"Paraguay", "ARQUEO_NETO"=>"N", "CALADO_MAX"=>"N", "CALADOR"=>nil, "SERN"=>"CORR", "TIPO_EVENTO"=>"Inserción de Carga", "COMENTARIO"=>nil, "ID_VIAJE"=>"23112", "ID_ETAPA"=>"58416", "NRO_ETAPA"=>"2", "ID_EVENTO"=>"196160", "REMOLCADA_POR"=>nil, "ORIGEN"=>nil, "DESTINO"=>nil}, {"FH_INFO"=>"03/04/2012", "HS_INFO"=>"22:14:36", "PT_INFO"=>"CORR", "MATRICULA"=>"0", "SDIST"=>"ZPPA", "NRO_OMI"=>"8950811", "IDEN"=>"CAVALIER III", "PT_ORIG"=>nil, "PT_DESTINO"=>nil, "TIPO_MOV"=>nil, "PT_FINAL"=>nil, "EN_VIAJE"=>"1", "NOMBRE"=>"Rio Paraguay", "UNIDAD"=>"KM", "KM"=>"1240", "CARGA"=>nil, "OBSERVAC"=>nil, "BAND"=>"Paraguay", "ARQUEO_NETO"=>"N", "CALADO_MAX"=>"N", "CALADOR"=>nil, "SERN"=>"CORR", "TIPO_EVENTO"=>"Inserción de Carga", "COMENTARIO"=>nil, "ID_VIAJE"=>"23112", "ID_ETAPA"=>"58416", "NRO_ETAPA"=>"2", "ID_EVENTO"=>"196160", "REMOLCADA_POR"=>nil, "ORIGEN"=>nil, "DESTINO"=>nil}]
        @valores = @dummy_class.obtenerListado @xml
        @valores.should == @attr
      end

      it "nodo de los registros"
    end
  end

  describe "parámetro reportName" do
    describe "camino exitoso" do
      it ""
    end

    describe "fallo" do
      it "en blanco o nulo"
      it "reporte inexistente"
    end
  end

  describe "parámetro fecha" do
    describe "camino exitoso" do
      it ""
    end

    describe "fallo" do
      it "en blanco o nulo"
      it "fecha mal formada"
      it "fecha mayor a la actual"
    end
  end

  describe "operaciones WS" do
    describe "fallo" do
      it "error de conexión con la URL"
      it "no existe el método"
    end
    describe "columnas" do
      describe "camino exitoso" do
      end
      describe "fallo" do
        it "difiere la cantidad"
        it "orden cambiado"
        it "se eliminaron"
        it "se adicionaron"
      end
    end
    describe "registros"do
      describe "fallo" do
        it "no existe el nodo"
      end
    end

  end
end
