class Basedbf

  def insertar (nombre_base, registro_dato, dbh)
    @nombre_base=nombre_base	
    @registro_dato=registro_dato
    campo=[]
    campo=registro_dato

    registro_base = dbh.prepare( "INSERT INTO #{nombre_base}(columna1,
                   columna2,columna3,columna4,columna5,columna6,columna7,columna8,columna9,columna10,
                                                                         columna11,columna12,columna13,columna14,columna15,columna16,columna17,columna18,columna19,columna20,
                                                                         columna21,columna22,columna23,columna24,columna25,columna26,columna27,columna28,columna29,columna30,columna31,columna32)
                   VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)" )
                   registro_base.execute(campo[0]	, campo[1], campo[2], campo[3], campo[4],campo[5],
                                         campo[6],campo[7], campo[8],campo[9], campo[10], campo[11], campo[12], campo[13],
                                         campo[14], campo[15], campo[16], campo[17], campo[18], campo[19], campo[20], campo[21],
                                         campo[22], campo[23],campo[24], campo[25], campo[26], campo[27], campo[28], campo[29], campo[30], campo[31])		   

                   registro_base.finish  # si no pongo esto sale el sig mensaje
                   # (WARNING: #<ODBC::Statement:0x1d2cff8> was not dropped before garbage collection)

                   msg='Registro ingresado'

                   return msg


  end
end


