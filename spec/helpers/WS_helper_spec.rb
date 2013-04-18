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
      @dummy_class.should respond_to(:obtenerListadoEnArray)
    end

    it "debe tener un método formatearTextoComoFecha" do
      @dummy_class.should respond_to(:obtenerFecha)
    end

    describe "comparación de datos" do
      before(:each) do
        @xml = File.open(File.join("spec/helpers", "soap.txt"), :encoding => "ISO-8859-1").read
      end

      it "obtener los datos en forma de array" do
        @attr = [["0", "03/04/2012", "22:13:55", "CORR", "0", "ZPPA", "8950811", "CAVALIER III", nil, nil, nil, nil, "1", "Rio Paraguay", "KM", "1240", nil, nil, "Paraguay", "N", "N", nil, "CORR", "Inserción de Carga", nil, "23112", "58416", "2", "196157", nil, nil, nil], ["1", "03/04/2012", "22:14:36", "CORR", "0", "ZPPA", "8950811", "CAVALIER III", nil, nil, nil, nil, "1", "Rio Paraguay", "KM", "1240", nil,
nil, "Paraguay", "N", "N", nil, "CORR", "Inserción de Carga", nil, "23112", "58416", "2", "196160", nil, nil, nil]]
        @valores = @dummy_class.obtenerListadoEnArray @xml
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
