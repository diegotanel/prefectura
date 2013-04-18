#encoding: utf-8

require 'spec_helper'

describe PosicionesController do

  describe "GET 'new'" do
    it "debe ser exitoso" do
      get :new 
      response.should be_success
    end

    it "debe inicializar los tipos de reportes" do
      @origenDeReporteROS = Factory(:origenDeReporte)
      @origenDeReporteMDZ = Factory(:origenDeReporte, :codigo => "mdz", :etiqueta => "Mendoza")
      get :new 
      @OrigenesDeReporte = assigns(:OrigenesDeReporte)
      @OrigenesDeReporte.should_not be_nil
      @OrigenesDeReporte.count.should == 2
    end 

    #    it "debe tener el título correcto" do
    #      get :new
    #      response.should have_selector("titulo", :content => "Reporte prefectura")
    #    end

    describe "verificar formulario" do
      it "que exista" do
        get :new 
        response.should have_selector("form")
      end

      it "con los atributos correctos" do
        get :new 
        response.should have_selector("form", :method => "post", :action => posiciones_path)
      end

      describe "si contiente los controles correspondientes" do
        it "combobox para los reportes" do
          get :new 
          response.should have_selector("select", :name => "reporte[codigo]")
        end

        it "control para seleccionar la fecha" do
          get :new 
          response.should have_selector("select", :name => "reporte[fecha(1i)]")
          response.should have_selector("select", :name => "reporte[fecha(2i)]")
          response.should have_selector("select", :name => "reporte[fecha(3i)]")
        end

        it "submit" do
          get :new 
          response.should have_selector("input", :type => "submit")
        end

        it "submit con la etiqueta correcta" do
          get :new 
          response.should have_selector("input", :type => "submit", :value => "Obtener reporte")
        end

        describe "y se llenen con los datos correspondientes" do
          it "combobox con los tipos de reportes" do
            @origenDeReporteROS = Factory(:origenDeReporte)
            @origenDeReporteMDZ = Factory(:origenDeReporte, :codigo => "mdz", :etiqueta => "Mendoza")
            @reportes = [@origenDeReporteROS, @origenDeReporteMDZ ]
            get :new 
            @reportes.each do |reporte|
              response.should have_selector("option", :value => reporte.codigo, :content => reporte.etiqueta)
            end
          end

          it "un control con la fecha" do
            DateTime.stub!(:today).and_return(DateTime.new(2011, 05, 13))
            get :new
            response.should have_selector("select", :name => "reporte[fecha(1i)]", :content => "2011")  # año
            response.should have_selector("select", :name => "reporte[fecha(2i)]", :content => "5")     # mes
            response.should have_selector("select", :name => "reporte[fecha(3i)]", :content => "13")    # día
          end
        end
      end
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @attr = { "codigo" => "",  "fecha(1i)" =>  "", "fecha(2i)" => "",  "fecha(3i)" => "" }
    end

    describe "fallido" do

      it "debe obtener el parámetro código como nulo" do
        post :create, :reporte => @attr
        assigns(:cod).should be_blank
      end

      it "debe obtener el parámetro fecha como nulo" do
        post :create, :reporte => @attr
        assigns(:ano).should be_blank
        assigns(:mes).should be_blank
        assigns(:dia).should be_blank
      end

      it "debe redibujar la página si hay una falla" do
        @attr2 = @attr.merge("codigo" => "ros", "fecha(1i)" => "2012")
        post :create, :reporte => @attr2
        response.should render_template('new')
      end

      # it "should have a flash.now message" do
      #        post :create, :session => @attr
      #        flash.now[:error].should =~ /invalid/i
      #    end
    end

    describe "exitoso"  do
      before(:each) do
        @datosCorrectos = @attr.merge("codigo" => "ros", "fecha(1i)" => "2012", "fecha(2i)" => "6", "fecha(3i)" => "11")
        controller.stub!(:obtenerDatosdelWS).and_return("")
      end

      it "debe obtener el parámetro código" do
        post :create, :reporte =>  @datosCorrectos
        assigns(:cod).should == @datosCorrectos["codigo"]
      end

      it "debe obtener el parámetro fecha" do
        post :create, :reporte =>  @datosCorrectos
        assigns(:ano).should == "2012"
        assigns(:mes).should == "6"
        assigns(:dia).should == "11"
      end

      it "debe obtener el parámetro fecha como string" do
        post :create, :reporte => @datosCorrectos
        assigns(:fechaString).should == "2012-6-11"
      end

      it "debe retorar la fecha" do
        post :create, :reporte => @datosCorrectos
        assigns(:fec).should == Time.new(2012,6,11,12)
      end

      it "debe retornar la fecha formateada" do
        post :create, :reporte => @datosCorrectos
        assigns(:fecFormateada).should == "11-06-12"
      end

      it "debe obtener la dirección del WS" do
        @path_urlWS = Factory(:urlws)
        post :create, :reporte => @datosCorrectos
        assigns(:url).should == @path_urlWS.url
      end

      describe "consulta y persistencia de datos" do
        before(:each) do
          @xmlWS = File.open(File.join("spec/helpers", "soap.txt"), :encoding => "ISO-8859-1").read
          controller.stub!(:obtenerDatosdelWS).and_return(@xmlWS)
#          Basedbf.any_instance.stub(:insertar).and_return("ok")
        end

        it "debe obtener los datos del WS como stub" do 
          Basedbf.any_instance.stub(:insertar).and_return("ok")
          post :create, :reporte => @datosCorrectos
          assigns(:respuestaWS).should == @xmlWS
        end

#        it "debe almacenar los datos del XML" do
#          @registrosCompletos = [["0", "03/04/2012", "22:13:55", "CORR", "0", "ZPPA", "8950811", "CAVALIER III", nil, nil, nil, nil, "1", "Rio Paraguay", "KM", "1240", nil, nil, "Paraguay", "N", "N", nil, "CORR", "Inserción de Carga", nil, "23112", "58416", "2", "196157", nil, nil, nil, "1", "03/04/2012", "22:14:36", "CORR", "0", "ZPPA", "8950811", "CAVALIER III", nil, nil, nil, nil, "1", "Rio Paraguay", "KM", "1240", nil, nil, "Paraguay", "N", "N", nil, "CORR", "Inserción de Carga", nil, "23112", "58416", "2", "196160", nil, nil, nil], ["0", "03/04/2012", "22:13:55", "CORR", "0", "ZPPA", "8950811", "CAVALIER III", nil, nil, nil, nil, "1", "Rio Paraguay", "KM", "1240", nil, nil, "Paraguay", "N", "N", nil, "CORR", "Inserción de Carga", nil, "23112", "58416", "2", "196157", nil, nil, nil, "1", "03/04/2012", "22:14:36", "CORR", "0", "ZPPA", "8950811", "CAVALIER III", nil, nil, nil, nil, "1", "Rio Paraguay", "KM", "1240", nil, nil, "Paraguay", "N", "N", nil, "CORR", "Inserción de Carga", nil, "23112", "58416", "2", "196160", nil, nil, nil]]
#         post :create, :reporte => @datosCorrectos
#         @db = File.open(File.join("spec/helpers", "file.txt"), :encoding => "ISO-8859-1").read
#         ActiveSupport::JSON.decode(@db).should == @registrosCompletos
#       end


        it "debe almacenar los datos en un dbf" do
          post :create, :reporte => @datosCorrectos
          assigns(:respuestaWS).should == @xmlWS
        end

      end
      it "debe redireccionarse a la vista new"
      #    it "debe retornar la página de inicio" do
      #      @attr = {:codigo => "ros", :fecha => "2012-06-12T16:58:42-03:00" }
      #      post :create, :reporte => @attr
      #      response.should redirect_to(root_path)
      #    end
      it "notificación de satisfactorio"

    end
  end
end
