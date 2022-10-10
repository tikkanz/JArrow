NB. init
cocurrent 'parrow'

lib =: >@((3&{.)@(TAB&cut)&.>)@(LF&cut)
ret =: 0&{::
ptr =: <@(0&{::)
getChar =: {{memr (>y),0,_1,2}}
getCharFree =: {{res [ memf y [ res=.memr (y=.>y),0,_1,2}}
setChar =: {{p [ y memw p,0,(# y),2 [ p=.mema # y=.(>y),{.a.}}

libload =: {{
  if.     UNAME-:'Linux' do.
    libParquet =: '/usr/lib/x86_64-linux-gnu/libparquet-glib.so'
    libArrow   =: '/usr/lib/x86_64-linux-gnu/libarrow-glib.so'
    libFlight   =: '/usr/lib/x86_64-linux-gnu/libarrow-flight-glib.so'
  elseif. UNAME-:'Darwin' do.
    libParquet =: '"','" ',~  '/usr/local/lib/libparquet-glib.dylib'
    libArrow   =: '"','" ',~  '/usr/local/lib/libarrow-glib.dylib'
    libFlight   =: '"','" ',~  '/usr/local/lib/libarrow-flight-glib.dylib'
  elseif. UNAME-:'Win' do.
    libParquet =: '"','" ',~  'C:/msys64/mingqw64/bin/libparquet-glib-900.dll'
    libArrow   =: '"','" ',~  'C:/msys64/mingqw64/bin/libarrow-glib-900.dll'
    libFlight   =: '"','" ',~  'C:/msys64/mingqw64/bin/libarrow-flight-glib-900.dll'
  end.
  1
}}

cbind =: 4 : 0"1 1
  'type name args' =. y
  v =. (x,' ',name,' ',type)&cd
  (". 'name') =: v
  1
)

init =: {{
  libload''
  r=. 1
  r =. r <. <./ libParquet cbind parquetReaderBindings, parquetWriterBindings
  r =. r <. <./ libArrow cbind tableBindings, recordBatchBindings, chunkedArrayBindings
  r =. r <. <./ libArrow cbind basicDatatypeBindings, compositeDataTypeBindings
  r =. r <. <./ libArrow cbind basicArrayBindings, compositeArrayBindings
  r =. r <. <./ libArrow cbind schemaBindings, fieldBindings
  r =. r <. <./ libArrow cbind bufferBindings
  r =. r <. <./ libArrow cbind ipcOptionsBindings,readerBindings,orcFileReaderBindings,writerBindings
  r =. r <. <./ libArrow cbind readableBindings, inputStreamBindings, writeableBindings, writeableFileBindings, outputStreamBindings, fileBindings
  r =. r <. <./ libFlight cbind commonFlightBindings, clientFlightBindings, serverFlightBindings
  r
}}
