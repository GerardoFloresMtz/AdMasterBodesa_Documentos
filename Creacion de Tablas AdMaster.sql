-----------------------------------------------------------------------------------
------------------------------   TABLAS DE  PUBLICACION ---------------------------
-----------------------------------------------------------------------------------
--2024-05-19

°CREATE TABLE TmpFechaProceso (
	FechaProceso 					DATE,		--- Fecha Semana Operacion Emergentes de los compradores
	EstadoProceso					CHAR(4),		
			-- ALT (ALTA) / INI (INICIO) / INC (Inicio Calculo) / FIC (Fin Calculo) / FCSE (ERROR CALCULO)
			-- INT (Inicio Transmitir) / FIT (Fin Transmitir)   / FTSE (ERROR TRANSMISION) 
			-- ITJ (Inicio Transmitir) / FTJ (Fin Transmitir)   / FTJE (ERROR TRANSMISION) 
			-- PRG (Calculo Siguiente Programacion)
	FechaSiguienteEjecucion			DATE,
	FechaProcesamientoReporte		DATE,		--- Fecha Semana Generacion Reporte, se manejan 2 fechas porque 
												---	los lunes a primera hora los compradores compradores operan los espacios con FechaProceso ya		
												---	el reporte se genera durante el lunes en la mañana
	FechaInicioMediosEnRecopilacion	DATE,		---??? Confirmar
	FechaFinalMediosEnRecopilacion	DATE		---??? Confirmar
)

ALTER TABLE TmpFechaProceso
	ADD FechaProcesamientoReporte		DATE

*CREATE TABLE LogProcesoPublicacion (
	FolioId			BIGINT,
	Proceso			VARCHAR(50),
	MensajeProceso	VARCHAR(255),
	EstadoProceso	VARCHAR(5),
	FechaAlta		DATETIME
)

-----------------------------------------------------------------------------------
---------------------TABLAS PARA ADMINITRACION DE CARGAS --------------------------
-----------------------------------------------------------------------------------
CREATE TABLE EventosDiseño(
	EventosId						BIGINT,
	ObjetosFileId					BIGINT
)

CREATE TABLE MovimientosPublicacion(
	MovimientosId					BIGINT,
	PublicacionId					BIGINT,
	Accion							VARCHAR(3),		-- CAA --> Carga Archivo, DEA --> Descarga Archivo, VIA --> Visualizar archivo
	Descripcion 					VARCHAR(200),
	ObjetosFileId					BIGINT
)
-----------------------------------------------------------------------------------
------------------------------   TABLAS DE  PUBLICACION ---------------------------
-----------------------------------------------------------------------------------
CREATE TABLE Publicacion (
	PublicacionId					BIGINT,
	ZonasId							BIGINT,
	EventosId						BIGINT,
	FechaInicio						DATE,
	FechaFinal						DATE,
	DescripcionPublicacion			VARCHAR(400),
	StatusDiseñoPublicacion			VARCHAR(3),			-- EVE --> HACE REFERENCIA A EventosDiseño, SEM --> Nuevo Diseño cargado despues al inicial
	DiseñoObjetosFileId				BIGINT,				-- NULL SI CAMPO ANTERIOR ES EVE
	StatusActualizacionExcel		VARCHAR(3),			-- CAL --> Ofertas de Publicacion correspondiente al Calculo, UPD --> ARCHIVO EXCEL CARGADO 
	ExcelCargaObjetosFileId			BIGINT,
	StatusPublicacion				VARCHAR(3),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_Publicacion ON Publicacion (PublicacionId);

CREATE TABLE PublicacionPromocionPublicada (
	PublicacionId					BIGINT,
	PromocionPublicadaId			BIGINT,
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PublicacionPromocionPublicada ON PublicacionPromocionPublicada (PublicacionId, PromocionPublicadaId);

CREATE TABLE PublicacionCrmPublicado (
	PublicacionId					BIGINT,
	CrmPublicadoId					BIGINT,
	ConsecutivoId					BIGINT,
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PublicacionCrmPublicado ON PublicacionCrmPublicado (PublicacionId, CrmPublicadoId, ConsecutivoId );


CREATE TABLE PublicacionMecanicas (
	PublicacionId					BIGINT,
	MecanicasId						BIGINT,
	EventosId						BIGINT,
	CategoriasId					BIGINT,
	SubCategoriasId					BIGINT,
	ProveedoresId					BIGINT,
	MarcasId						VARCHAR(10),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PublicacionMecanicas ON PublicacionMecanicas (PublicacionId, MecanicasId);

CREATE TABLE PromocionDireccion (				--- ANTES PromocionPublicada
	PromocionDireccionId			BIGINT,
	FormatoCargaId					BIGINT,
	EventosId						BIGINT,
	NombreEvento					VARCHAR(300),
	MediosId						INT,
	TituloPromocion					VARCHAR(300),
	FechaInicio						DATE,
	FechaFinal						DATE,
	StatusId						BIGINT,
	ZonasId							BIGINT,
	HastaAgotarProductos			CHAR(1),
	DesgloseOfertas					CHAR(1),
	DescripcionPromociones			VARCHAR(300),
	Restricciones					VARCHAR(300),
	RestriccionesDeptoMarca			VARCHAR(300),
	CanalesVentaParticipantes		VARCHAR(300),
	ObservacionHaciaMarketing		VARCHAR(300),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PromocionPublicada ON PromocionPublicada (PromocionPublicadaId);

CREATE TABLE PromocionDireccionSubCategorias (			-- ANTES PromocionPublicadaSubCategorias 
	PromocionDireccionId			BIGINT,
	SubCategoriasId					BIGINT,
	SubNombreCategoria				VARCHAR(300),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PromocionDireccionSubCategorias ON PromocionDireccionSubCategorias (PromocionPublicadaId, SubCategoriasId);


CREATE TABLE PromocionDireccionCategorias (				-- ANTES PromocionPublicadaCategorias
	PromocionDireccionId			BIGINT,
	CategoriasId					BIGINT,
	NombreCategoria					VARCHAR(300),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PromocionDireccionCategorias ON PromocionDireccionCategorias (PromocionPublicadaId, CategoriasId);

CREATE TABLE PromocionDireccionProveedores (			--- ANTES PromocionPublicadaProveedores
	PromocionDireccionId			BIGINT,
	ProveedoresId					BIGINT,
	NombreProveedor					VARCHAR(300),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PromocionDireccionProveedores ON PromocionDireccionProveedores (PromocionPublicadaId, ProveedoresId);

CREATE TABLE PromocionDireccionMarcas (			--- ANTES PromocionPublicadaMarcas
	PromocionDireccionId			BIGINT,
	MarcasId						VARCHAR(10),
	NombreMarcas					VARCHAR(300),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PromocionDireccionMarcas ON PromocionDireccionMarcas (PromocionPublicadaId, MarcasId);

CREATE TABLE PromocionDireccionGruposArticulos (			--- ANTES PromocionPublicadaGruposArticulos
	PromocionDireccionId			BIGINT,
	GruposArticulosId				BIGINT,
	NombreGruposArticulos			VARCHAR(300),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PromocionDireccionGruposArticulos ON PromocionDireccionGruposArticulos (PromocionPublicadaId, GruposArticulosId);


CREATE TABLE PromocionPublicadaMecanicas (			--- BORRAR TABLA  ---
	PromocionPublicadaId			BIGINT,
	MecanicasId						BIGINT,
	EventosId						BIGINT,
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_PromocionPublicadaMecanicas ON PromocionPublicadaMecanicas (PromocionPublicadaId, MecanicasId);

CREATE TABLE CrmPublicado (
	CrmPublicadoId					BIGINT,
	ConsecutivoId					BIGINT,
	Nombre							VARCHAR(300),
	FechaInicio						DATE,
	FechaFinal						DATE,
	CriterioSeleccion				VARCHAR(300),
	Beneficio						VARCHAR(300),
	DuracionBeneficio				VARCHAR(300),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT,
	FechaModificacion				DATETIME,
	UsuarioModificacionId			BIGINT
)
CREATE UNIQUE INDEX PK_CrmPublicado ON CrmPublicado (CrmPublicadoId);

---------------------------------------------------------------------------------
--------- DATOS PARA LAS PUBLCIACIONES ADCONTENT - ADSTORE ----------------------
---------------------------------------------------------------------------------
CREATE TABLE PublicacionDatosBase	(
		PublicacionId				BIGINT, 
		PromocionDireccionId		BIGINT,					-- CAMBIO NOMBRE DE CAMPO ANTES PromocionPublicadaId --
		EspacioPromocionalesId		BIGINT,
		EventosId					BIGINT,
		NombreEvento				VARCHAR(300)	NULL,		
		MediosId					BIGINT,
		NombreMedio					VARCHAR(300) 	NULL,
		TodasTiendasZona			INT				NULL,
		FechaInicioMedio			DATE			NULL,
		FechaFinalMedio				DATE			NULL,
		FechaInicioEvento			DATE			NULL,
		FechaFinalEvento			DATE			NULL,	
		Restricciones				VARCHAR(500) 	NULL, 
		ObservacionesEvento 		VARCHAR(500) 	NULL,
		ComentarioAsignacion 		VARCHAR(500)	NULL,
		MecanicasId		 			INT 			NULL,
		NombreMecanica				VARCHAR(300) 	NULL, 
		FechaInicio					DATE			NULL,	
		FechaFinal					DATE			NULL,
		DepartamentosId				INT 			NULL,
		NombreDepartamento 			VARCHAR(300) 	NULL,
		CodigoEAN					VARCHAR(20) 	NULL,
		ProductosId					VARCHAR(20) 	NULL,
		NombreProducto				VARCHAR(400) 	NULL,
		ProveedoresId				INT 			NULL,
		NombreProveedores			VARCHAR(300) 	NULL,
		GrupoProductosId			INT 			NULL,
		NombreGrupoProductos 		VARCHAR(300) 	NULL,
		MarcasId					INT 			NULL,
		NombreMarcas				VARCHAR(300) 	NULL,
		CategoriasId 				INT 			NULL,
		NombreCategorias			VARCHAR(300) 	NULL, 
		ZonasId						INT 			NULL,
		NombreZonas					VARCHAR(300) 	NULL,
		Modelo						VARCHAR(300) 	NULL,
		DetalleTiendasParte1		VARCHAR(1000) 	NULL,
		DetalleTiendasParte2		VARCHAR(1000) 	NULL,
		DetalleTiendasParte3		VARCHAR(1000) 	NULL,
		Mensualidades				INT 			NULL,
		DesDirContado				INT 			NULL,
		DesDirCredito				INT 			NULL,
		DesCarContado				INT 			NULL,
		DesCarCredito				INT 			NULL,
		PrecioAnterior				INT 			NULL,
		PrecioPromocion				INT 			NULL,
		Observaciones				VARCHAR(1000) 	NULL,
		PerteneceAFolleto			VARCHAR(1000) 	NULL,
		Comentarios					VARCHAR(1000) 	NULL,
		PrecioContado				INT 			NULL,
		AbonitoRedondeado			INT 			NULL,
		NumeroParcialidades 		INT 			NULL,
		Caracteristica1				VARCHAR(1000) 	NULL,
		Caracteristica2				VARCHAR(1000) 	NULL,
		Caracteristica3				VARCHAR(1000) 	NULL,
		Variable					VARCHAR(1000) 	NULL,
		StatusIdEspacio				INT 			NULL,
		NombreStatusEspacio			VARCHAR(200) 	NULL,
		TipoMediosId				INT 			NULL,
		NombreTipoMedios			VARCHAR(400) 	NULL,
		ClaveFormato				VARCHAR(400) 	NULL,
		DetallesId					INT 			NULL
	)
CREATE 		 INDEX PK_PublicacionDatosBase 			ON PublicacionDatosBase (PublicacionId, PromocionPublicadaId, EspacioPromocionalesId, DetallesId );
CREATE  	  INDEX PK_PublicacionDatosBase_DetallesId 	ON PublicacionDatosBase (DetallesId );	
	
CREATE TABLE PublicacionEncuentasAdStore	(				--- YA NO SE USA --
		PublicacionId					BIGINT,
		EncuestaId						BIGINT,
		NombreEncuesta					VARCHAR(800),
		DetalleTiendasParte1			VARCHAR(1000), 
		DetalleTiendasParte2			VARCHAR(1000), 
		DetalleTiendasParte3			VARCHAR(1000),
		TotalRegistros					BIGINT,
		TodasTiendasZona				INT
	)
CREATE 		 INDEX PK_PublicacionEncuentasAdStore ON PublicacionEncuentasAdStore (PublicacionId, EncuestaId );

CREATE TABLE PublicacionEncuentasAdStoreMediosTiendas (		--- YA NO SE USA --
		PublicacionId					BIGINT,
		EncuestaId						BIGINT,
		MediosId						BIGINT,
		TiendasId						BIGINT
	)
CREATE 		 INDEX PK_PublicacionEncuentasAdStoreMediosTiendas ON PublicacionEncuentasAdStoreMediosTiendas (PublicacionId, EncuestaId, MediosId, TiendasId );

CREATE TABLE EncuentasAdStoreCategorias		(				--- YA NO SE USA --
		PublicacionId					BIGINT,
		EncuestaId						BIGINT,
		CategoriasId					BIGINT,
		ConsecutivoId					BIGINT,
		TotalRegistrosCategoria			FLOAT,
		PonderacionCategoria			FLOAT
	)
CREATE 		 INDEX PK_EncuentasAdStoreCategorias ON EncuentasAdStoreCategorias (PublicacionId, EncuestaId, CategoriasId );

	
CREATE TABLE  EncuentasAdStorePreguntas		(				--- YA NO SE USA --
		PublicacionId					BIGINT,
		EncuestaId						BIGINT,
		DetallesId						BIGINT,
		CategoriasId					BIGINT,
		PreguntaId						BIGINT,
		PrecioPorcentajeContado			DECIMAL,	
		PrecioPorcentajeCredito			DECIMAL,
		TipoValorContado				VARCHAR(10),
		TipoValorCredito				VARCHAR(10),
		MensajePregunta					VARCHAR(500),
		TotalRegistros					FLOAT,
		TotalRegistrosCategoria			FLOAT,
		PonderacionRow					FLOAT,
		PonderacionCategoria			FLOAT
	)
CREATE UNIQUE INDEX PK_EncuentasAdStorePreguntas ON EncuentasAdStorePreguntas (PublicacionId, EncuestaId, PreguntaId, DetallesId );

CREATE TABLE  EncuentasAdContent		(					--- YA NO SE USA --
		PublicacionId					BIGINT,
		EncuestaId						BIGINT,
		DetallesId						BIGINT,
		PromocionPublicadaId			BIGINT,
		TipoPromocion					VARCHAR(20),
		NombreEventoPublicacion			VARCHAR(300),
		TituloPromocion					VARCHAR(300),
		FechaInicioPublicacion			DATE,
		FechaFinalPublicacion			DATE,
		HastaAgotarProductos			CHAR(1),
		DesgloseOfertas					CHAR(1),
		DescripcionPromociones			VARCHAR(300),
		RestriccionesPublicacion		VARCHAR(300),
		RestriccionesDeptoMarca			VARCHAR(300),
		CanalesVentaParticipantes		VARCHAR(300)
	)
CREATE UNIQUE INDEX PK_EncuentasAdContent ON EncuentasAdContent (PublicacionId, EncuestaId, DetallesId, PromocionPublicadaId );
---------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
------------------------------   TABLAS DE  MENSAJERIA ----------------------------
-----------------------------------------------------------------------------------

CREATE TABLE ObjetosJson(
	ObjetosJsonId			BIGINT,
	ConsecutivoId			BIGINT,
	ObjetoJsonStr			VARCHAR(2000),
	CantidadCarPaquete		BIGINT,
	CantidadCarEntregados	BIGINT,
	TotalCaracteres			BIGINT,
	FechaCreacion			DATETIME,
	UsuarioCreadorId		BIGINT
)
CREATE UNIQUE INDEX PK_ObjetosJson ON ObjetosJson (ObjetosJsonId, ConsecutivoId);

CREATE TABLE ObjetosFile(
	ObjetosFileId			BIGINT,
	OrigenArchivo			VARCHAR(10),		-- ORIGEN DE ARCHIVO, MEC --> EXCEL CARGA MECANICAS, 
																	  APE --> Administracion Publicacion Excel, 
																	  APD --> Administracion Publicacion Diseño
	ConsecutivoId			BIGINT,				--- BORRAR CAMPO ---
	NombreArchivo			VARCHAR(200),
	Extension				VARCHAR(10),
	FileBase64Str			VARCHAR(MAX)		--VARCHAR(2000),
	CantidadCarPaquete		BIGINT,				--- BORRAR CAMPO ---
	CantidadCarEntregados	BIGINT,				--- BORRAR CAMPO ---
	TotalCaracteres			BIGINT,
	LongitudArchivo			BIGINT,
	FechaCreacion			DATETIME,
	UsuarioCreadorId		BIGINT
)
CREATE UNIQUE INDEX PK_ObjetosFile ON ObjetosFile (ObjetosFileId, ConsecutivoId);


CREATE TABLE MensajesSalientes(
	MensajesSalientesId		BIGINT,
	PublicacionId			BIGINT,
	EncuestaId				BIGINT,
	Aplicacion				VARCHAR(15),		/* ADSTORE, ADCONTENT 	*/
	ConsecutivoProceso		INT,
	Accion					VARCHAR(50),
	ContentType				VARCHAR(50),
	Accept					VARCHAR(50),
	AcceptCharSet			VARCHAR(50),
	Url						VARCHAR(1000),
	UrlMetodo				VARCHAR(300),
	MetodoAutentificacion	VARCHAR(50),
	LlaveAutentificacion	VARCHAR(300),
	ObjetosJsonIdEntrada	BIGINT,
	ObjetosFileIdEntrada	BIGINT,
	EstadoMensaje			VARCHAR(3),			/* ALT(ALTA), ERR(ENVIADO Y RECHAZADO), PRO (PROCESADO)  */
	NumeroReintentos		INT,
	FechaCreacion			DATETIME,
	UsuarioCreadorId		BIGINT,
	FechaModificacion		DATETIME,
	UsuarioModificacionId	BIGINT
);
CREATE UNIQUE INDEX PK_MensajesSalientes ON MensajesSalientes ( MensajesSalientesId );

CREATE TABLE MensajesSalientesPerfilesAdContent(
	MensajesSalientesId		BIGINT,
	PerfilesAdContentId		BIGINT,
	FechaCreacion			DATETIME,
	UsuarioCreadorId		BIGINT,
	FechaModificacion		DATETIME,
	UsuarioModificacionId	BIGINT
);
CREATE UNIQUE INDEX PK_MensajesSalientesPerfilesAdContent ON MensajesSalientesPerfilesAdContent ( MensajesSalientesId, PerfilesAdContentId );

CREATE TABLE MensajesSalientesTiendasAdStore(			-- YA NO SE USA --
	MensajesSalientesId		BIGINT,
	TiendasId				BIGINT,
	FechaCreacion			DATETIME,
	UsuarioCreadorId		BIGINT,
	FechaModificacion		DATETIME,
	UsuarioModificacionId	BIGINT
);
CREATE UNIQUE INDEX PK_MensajesSalientesTiendasAdStore ON MensajesSalientesTiendasAdStore ( MensajesSalientesId, TiendasId );

CREATE TABLE MensajesSalientesResultado(
	MensajesSalientesId			BIGINT,
	ConsecutivoId				INT,
	EstadoHttpInvocacion		INT,
	ResultadoHttpInvocacion		VARCHAR(1000),
	DescripcionException		VARCHAR(3000),
	ObjetosJsonRecibidoId		BIGINT,
	ObjetosFileIdRecibido		BIGINT,
	FechaCreacion				DATETIME,
	UsuarioCreadorId			BIGINT,
	FechaModificacion			DATETIME,
	UsuarioModificacionId		BIGINT
);
CREATE UNIQUE INDEX PK_MensajesSalientesResultado ON MensajesSalientesResultado (MensajesSalientesId, ConsecutivoId);


SE CORRIO HASTA AQUI
///---------------------------------------------------------///
///------------- RELACION PERFILES ADCONTENT ---------------///
///---------------------------------------------------------///
CREATE TABLE TiendasPerfilesAdContent(
	TiendasId				BIGINT,
	PerfilAdContentId		VARCHAR(50),
	Activo					BIT,
	FechaCreacion			DATETIME,
	UsuarioCreadorId		BIGINT,
	FechaModificacion		DATETIME,
	UsuarioModificacionId	BIGINT
);
CREATE UNIQUE INDEX PK_TiendasPerfilesAdContent ON TiendasPerfilesAdContent (TiendasId, PerfilAdContentId);


///---------------------------------------------------------///
///------------- RELACION RUTAS TIENDAS ADCONTENT ----------///
///---------------------------------------------------------///
CREATE TABLE TiendasRutasAdStore(					-- YA NO SE USA --
	TiendasId				BIGINT,
	RutasId					VARCHAR(50),
	Activo					BIT,
	FechaCreacion			DATETIME,
	UsuarioCreadorId		BIGINT,
	FechaModificacion		DATETIME,
	UsuarioModificacionId	BIGINT
);
CREATE UNIQUE INDEX PK_TiendasRutasAdStore ON TiendasRutasAdStore (TiendasId, RutasId);
-----------------------------------------------------------------------------------
------------------------------   CARGA DE ARCHIVOS	   ----------------------------
-----------------------------------------------------------------------------------
CREATE TABLE EXCEL_PROMOCIONESDIRECCION(			--- YA NO SE USA EXCEL_PROMOCIONESPUBLICADAS --
	TRANSACTIONID					BIGINT,
	OfertaExcelId					BIGINT,
	PromocionPublicadaId			BIGINT,
	FormatoCargaId					BIGINT,
	EventosId						BIGINT,
	NombreEvento					VARCHAR(300),
	TituloPromocion					VARCHAR(300),
	FechaInicio						DATE,
	FechaFinal						DATE,
	ZonasId							BIGINT,
	HastaAgotarProductos			CHAR(1),
	DesgloseOfertas					CHAR(1),
	DescripcionPromociones			VARCHAR(300),
	Restricciones					VARCHAR(300),
	RestriccionesDeptoMarca			VARCHAR(300),
	CanalesVentaParticipantes		VARCHAR(300),
	ObservacionHaciaMarketing		VARCHAR(300),
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT	
)
ALTER TABLE EXCEL_PROMOCIONESDIRECCION ADD ObservacionHaciaMarketing		VARCHAR(300) NULL

CREATE UNIQUE INDEX PK_EXCEL_PROMOCIONESDIRECCION ON EXCEL_PROMOCIONESDIRECCION (TRANSACTIONID, OfertaExcelId);

CREATE TABLE EXCEL_PROMOCIONESDIRECCION_MECANICAS(			--- YA NO SE USA ANTES EXCEL_PROMOCIONESPUBLICADAS_MECANICAS --
	TRANSACTIONID					BIGINT,
	OfertaExcelId					BIGINT,
	OfertaExcelId_PreMecanicas		BIGINT
)
CREATE INDEX FK_EXCEL_PROMOCIONESDIRECCION_MECANICAS_MECANICAS ON EXCEL_PROMOCIONESDIRECCION_MECANICAS_MECANICAS (TRANSACTIONID, OfertaExcelId, OfertaExcelId_PreMecanicas);

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
CREATE TABLE UsuariosZonas (
	UsuariosId						BIGINT,
	ZonasId							BIGINT,
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT
)
CREATE UNIQUE INDEX PK_UsuariosZonas ON UsuariosZonas (UsuariosId, ZonasId);

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
°ALTER TABLE Eventos 
	ADD esEmergente BIT DEFAULT 0

°CREATE TABLE EXCELGENTEMP_EVENTO(
	TRANSACTIONID	BIGINT,
	EventosId		BIGINT,
	UsuariosId		BIGINT,
	FechaCreacion	DATETIME
)

CREATE UNIQUE INDEX PK_EXCELGENTEMP_EVENTO  ON EXCELGENTEMP_EVENTO (TRANSACTIONID, EventosId)


ALTER TABLE FormatosCargaExcel 
	ADD ClaveFormatoEmergente VARCHAR(30)

UPDATE FormatosCargaExcel SET
ClaveFormatoEmergente = 'LM-BOD-FOR-A-001-V6' 
WHERE FormatosId = 1

UPDATE FormatosCargaExcel SET
ClaveFormatoEmergente = 'LM-BOD-FOR-B-002-V6' 
WHERE FormatosId = 2

UPDATE FormatosCargaExcel SET
ClaveFormatoEmergente = 'LM-BOD-FOR-1-003-V6' 
WHERE FormatosId = 4
--..............................................--
UPDATE FormatosCargaExcel SET
ClaveFormato = 'LM-BOD-FOR-A-001-V5' 
WHERE FormatosId = 1

UPDATE FormatosCargaExcel SET
ClaveFormato = 'LM-BOD-FOR-B-002-V5' 
WHERE FormatosId = 2

UPDATE FormatosCargaExcel SET
ClaveFormato = 'LM-BOD-FOR-1-003-V5' 
WHERE FormatosId = 4


VERSIONES ACTUALES EN DESA ANTES DE AJUSTE MULTIVERSION TRADICIONAL - EMERGENTE
1	- LM-BOD-FOR-A-001-V6
2	- LM-BOD-FOR-B-002-V6
4	- LM-BOD-FOR-1-003-V6
10	- LM-FOR-EPR-001-V1
11	- LM-FOR-ECRM-001-V1

VERSIONES ACTUALES EN PROD AL 22 ABRIL 2026
1	- LM-BOD-FOR-A-001-V5
2	- LM-BOD-FOR-B-002-V5
4	- LM-BOD-FOR-1-003-V5

	
ALTER TABLE FormatosCargaExcelDesglose 
	ADD aplicaEventoEmergente VARCHAR(1) DEFAULT 'N'

ALTER TABLE FormatosCargaExcelDesglose 
	ADD APP_VIEW_CONFIG_GRID_CFG_ID BIGINT 

ALTER TABLE FormatosCargaExcel 
	ADD InicioVigencia 	DATE

ALTER TABLE FormatosCargaExcel
	ADD FinVigencia		DATE
	
UPDATE FormatosCargaExcel SET
	InicioVigencia 	= '2010-01-01',
	FinVigencia		= '2060-12-31'

UPDATE Eventos  SET
esEmergente = 0

UPDATE Eventos  SET
esEmergente = 1
WHERE Nombre LIKE '%PROMOCIONES EMERGENTES%'


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

ESTE NO APLICA
CREATE TABLE EXCEL_PROMOCIONESPUBLICADAS(
	TRANSACTIONID					BIGINT,
	OfertaExcelId					BIGINT,
	MecanicasId						BIGINT,
	FechaCreacion					DATETIME,
	UsuarioCreadorId				BIGINT	
)




///////-------------------------------------------------------////
Creacion Funcion
PublicacionJsonAdStore
PublicacionJsonAdContent
AccesoEspaciosPromocionales

Creacion sp
udp_Reporte_SubReportesParaAdContent_rep						SIEMPRE NO
udp_Reportes_DetalleAlSuper_rep
°udp_Reporte_DetalleAdContent_rep
udp_Reporte_DetalleAdContentCRM_rep								SIEMPRE NO
udp_Reporte_DetalleMarketing_rep


°udp_Evento_CalcularPublicacionOfertasBodesa_2_pro				<------ Calculo de losreportes
°udp_Evento_PublicarOfertasBodesa_pro
°udp_Reporte_DetalleCalculoEmergentes_rep


udp_Evento_CalcularPublicacionOfertasBodesa_pro					SIEMPRE NO
udp_Evento_CalcularPublicacionAdStoreBodesa_pro					SIEMPRE NO
udp_Evento_Publicar_sel   										SIEMPRE NO
udp_Evento_MensajesSalientesPorPublicacion_sel
udp_Evento_MensajesSalientes_ObjetosJson_ups
udp_Evento_MensajesSalientes_ObjetosFile_ups
udp_Evento_ObjetoJson_ins
udp_Evento_ObjetoJson_sel
udp_Evento_ConsultaPublicaciones_sel
udp_Evento_CierraSemanaRegistoOfertas_pro

udp_Evento_MensajesSalientesResultado_ins
udp_Evento_MensajesSalientesResultado_act
udp_Seguimiento_Eventos_sel
udp_Seguimiento_Medios_sel
udp_Oferta_AutorizaPreciosEspeciales_ups

udp_Oferta_CalcularCategoriaEnEspacio_sel
udp_Oferta_DatosParaCorreoVoBo_rep

udp_Reporte_DetalleParaCorreoLaMarina_rep
udp_Reporte_DetalleParaCorreoElBodegon_rep
udp_Reporte_DetalleMarketing_rep
udp_Reporte_DetalleParaCedis_rep
udp_Reporte_DetalleParaInventario_rep
udp_Reporte_DetalleParaProgramacionCelerity_rep
udp_Reporte_DetalleParaProgramacionElBodegon_rep
udp_Reporte_DetalleParaProgramacionMax4less_rep
udp_Reporte_DetalleParaProgramacionVtaLinea_rep
udp_Reporte_DetalleVentasElBodegon_rep
udp_Reporte_DetalleVentasLaMarina_rep



udp_Oferta_sel
udp_Oferta_EspacioPromocionalMecanicas_ups
udp_Oferta_EspacioPromocionalPorTipoMedio_sel

udp_Oferta_ProcesaExcel_Ofertas_Multiformato_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_Fechas_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_PromPub_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_Banderas_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_Claves_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_Enteros_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_Fechas_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_Generales_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_Montos_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_OtrosDatos_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_Porcentaje_pro
udp_Oferta_ProcesaExcel_Ofertas_Multiformato_Obtiene_Precios_pro
udp_Oferta_ImportaOfertas_Multiformato_pro
udp_Oferta_ImportaOfertas_Multiformato_Asignacion_pro
udp_Evento_ProcesaExcel_Publicacion_Multiformato_pro			SIEMPRE NO
udp_Oferta_Validaciones_Por_Formato_pro							SIEMPRE NO
udp_Oferta_ProcesaExcel_pro
udp_Evento_ProcesaExcel_Publicacion_Multiformato_PromPublicada_pro
udp_Evento_ProcesaExcel_Publicacion_Multiformato_CRM_pro
ValidaIntegridad 

udp_Evento_ProcesaExcel_Publicacion_Multiformato_Generales_pro
udp_Evento_ProcesaExcel_Publicacion_Multiformato_LeeCelda_pro

udp_Marcas_sel
udp_GruposArticulos_sel

udp_Direccion_PromocionPublicada_del
udp_Direccion_PromocionPublicada_udp
udp_Direccion_PromocionPublicada_sel
udp_Direccion_PromocionPublicada_Categorias_sel
udp_Direccion_PromocionPublicada_SubCategorias_sel
udp_Direccion_PromocionPublicada_Proveedores_sel
udp_Direccion_PromocionPublicada_Marcas_sel
udp_Direccion_PromocionPublicada_GruposArticulos_sel
udp_Direccion_AutorizaPromocionDireccion_ups


udp_Direccion_PromocionPublicada_upd
udp_Direccion_PromocionPublicada_Categorias_upd
udp_Direccion_PromocionPublicada_SubCategorias_upd
udp_Direccion_PromocionPublicada_Proveedores_upd
udp_Direccion_PromocionPublicada_Marcas_upd
udp_Direccion_PromocionPublicada_GruposArticulos_upd

udp_Direccion_CrmPublicada_sel	

udp_UsuariosCorreos_sel
udp_BanderasProcesamientoPublicacion_sel
udp_Evento_ActualizaEstadoPublicacion_pro

udp_Oferta_EncabezadosTablaDetallesMultiformato_sel   +Agrego Parametro de EventosId
udp_Oferta_PromocionesDetalles_sel

?udp_Oferta_PromocionesDetalles_sel
	CapturaOfertas.ts-->initColumnas  		agregar evento
	StructureService.ts --> getViewByAppId  agregar evento
	ApplicationController.java-->  getViewByAppInfo
 ------------------------------
SET IDENTITY_INSERT TipoMedios ON
INSERT INTO TipoMedios
		(	TipoMediosId,	Nombre,							NumeroPaginas, MaximoDeEspacios, AplicaPortadaYContraportada, 
			Activo,			GruposMediosId,					FechaCreacion, UsuarioCreadorId			)
	VALUES( 13,				'Promociones Emergentes',		0,				9999,				1,
			1,				1,								GETDATE(),		1						)
SET IDENTITY_INSERT TipoMedios OFF

------------------------------
INSERT INTO Parametros
			(	ParametrosId,	Nombre,										Titulo,										Valor, 
				TipoDato,		Editable,			Activo,					FechaCreacion,		UsuarioCreadorId		)
	VALUES	(	83,				'emailURLAutorizacionaEmergenteGerente',	'Url Autorizacion Espacios Emergentes',	'http://192.168.1.69:9000/rest/authOferta/authEmergenteGerente/',
				'VARCHAR',		1,					1,						GETDATE(),			1						)

INSERT INTO Parametros
			(	ParametrosId,	Nombre,										Titulo,										Valor, 
				TipoDato,		Editable,			Activo,					FechaCreacion,		UsuarioCreadorId		)
	VALUES	(	90,				'emailURLAutorizacionaEmergenteProgramdor',	'Url Autorizacion Espacios Emergentes',	'http://192.168.1.69:9000/rest/authOferta/authEmergenteProgramdor/',
				'VARCHAR',		1,					1,						GETDATE(),			1						)

INSERT INTO Parametros
			(	ParametrosId,	Nombre,										Titulo,										Valor, 
				TipoDato,		Editable,			Activo,					FechaCreacion,		UsuarioCreadorId		)
	VALUES	(	91,				'emailURLAutorizacionaDireccionProgramdor',	'Url Autorizacion Espacios Direcccion',	'http://192.168.1.69:9000/rest/authOferta/authEmergenteDireccionProgramdor/',
				'VARCHAR',		1,					1,						GETDATE(),			1						)

------------------------------



INSERT INTO REPORTES 
  VALUES(10, 'Reporte Comunicado AdContent', 'ReporteEnvioAdContent.jrxml', 'PDF', 
			1, GETDATE(), NULL, 1, NULL, NULL, NULL)

INSERT INTO  ReportesPerfiles
	( ReportesId,	PerfilesId,		Activo,		FechaCreacion,	UsuarioCreadorId )
select 11,			A.PerfilesId,	1,			GETDATE(),		1 
	from ReportesPerfiles A
	where ReportesId = 10

INSERT INTO REPORTES 
  VALUES(12, 'Reporte Comunicado AdStore', 'ReporteEnvioAdAdStore.jrxml', 'PDF', 
			1, GETDATE(), NULL, 1, NULL, NULL, NULL)

INSERT INTO  ReportesPerfiles
	( ReportesId,	PerfilesId,		Activo,		FechaCreacion,	UsuarioCreadorId )
select 12,			A.PerfilesId,	1,			GETDATE(),		1 
	from ReportesPerfiles A
	where ReportesId = 10




INSERT INTO REPORTES 
  VALUES(20, 'Reporte Comunicado AdContent LM', 'ReporteEnvioAdContentLaMarina.jrxml', 'PDF', 
			1, GETDATE(), NULL, 1, NULL, NULL, NULL)

INSERT INTO  ReportesPerfiles
	( ReportesId,	PerfilesId,		Activo,		FechaCreacion,	UsuarioCreadorId )
select 20,			A.PerfilesId,	1,			GETDATE(),		1 
	from ReportesPerfiles A
	where ReportesId = 10

INSERT INTO REPORTES 
  VALUES(21, 'Reporte Comunicado AdContent BOD', 'ReporteEnvioAdContentElBodegon.jrxml', 'PDF', 
			1, GETDATE(), NULL, 1, NULL, NULL, NULL)


INSERT INTO REPORTES 
  VALUES(30, 'Reporte Comunicado AdContent CEL', 'ReporteEnvioAdContentCelerity.jrxml', 'PDF', 
			1, GETDATE(), NULL, 1, NULL, NULL, NULL)

INSERT INTO REPORTES 
  VALUES(31, 'Reporte Comunicado AdContent MAX', 'ReporteEnvioAdContentMax4Less.jrxml', 'PDF', 
			1, GETDATE(), NULL, 1, NULL, NULL, NULL)


INSERT INTO  ReportesPerfiles
	( ReportesId,	PerfilesId,		Activo,		FechaCreacion,	UsuarioCreadorId )
select 21,			A.PerfilesId,	1,			GETDATE(),		1 
	from ReportesPerfiles A
	where ReportesId = 10

INSERT INTO REPORTES 
  VALUES(22, 'Reporte Para Autorizacion Oferta LM', 'ReporteCorreoAutorizacionLaMarina.jrxml', 'PDF', 
			1, GETDATE(), NULL, 1, NULL, NULL, NULL)


INSERT INTO REPORTES 
  VALUES(23, 'Reporte Para Autorizacion Oferta BOD', 'ReporteCorreoAutorizacionElBodegon.jrxml', 'PDF', 
			1, GETDATE(), NULL, 1, NULL, NULL, NULL)

INSERT INTO ESTADOS 



------------------------------
temporal de pruebas 
insert into ReportesPerfiles 
select 10, PerfilesId, Activo, FechaCreacion, Null, 1, null, null 
from ReportesPerfiles where ReportesId = 9

EXEC udp_EventoJsonAdStore 322, 1

INSERT INTO FoliosTransacciones 
	VALUES ( 'Publicacion', 0 )

INSERT INTO FoliosTransacciones 
	VALUES ( 'PromocionPublicada', 0 )

INSERT INTO FoliosTransacciones 
	VALUES ( 'CrmPublicado', 0 )

INSERT INTO FoliosTransacciones 
	VALUES ( 'ObjetosJson', 0 )

INSERT INTO FoliosTransacciones 
	VALUES ( 'ObjetosFile', 0 )

INSERT INTO FoliosTransacciones 
	VALUES ( 'MensajesSalientes', 0 )

INSERT INTO FoliosTransacciones 
	VALUES ( 'LogPublicacion', 0 )
	
INSERT INTO Parametros
	VALUES( 84, 'DiaCorteEmergentes', 'Dia Corte Ofertas Emergentes', '6', 'CHAR', 1, 1, GETDATE(), NULL, 1, NULL )

INSERT INTO Parametros
	VALUES( 85, 'HoraCorteEmergentes', 'Hora Corte Ofertas Emergentes', '13:00:00', 'CHAR', 1, 1, GETDATE(), NULL, 1, NULL )

INSERT INTO Parametros
	VALUES( 86, 'DiaGeneracionPub', 'Dia Generacion de Publicacion', '6', 'CHAR', 1, 1, GETDATE(), NULL, 1, NULL )

INSERT INTO Parametros
	VALUES( 87, 'HoraGeneracionPub', 'Hora Generacion de Publicacion', '17:00:00', 'CHAR', 1, 1, GETDATE(), NULL, 1, NULL )


------------------------------------------------------  
-----  09 JUNIO -----------
 INSERT INTO STATUS
		( 	StatusId, 					Nombre, 				TipoObjectoId, 		color, 						Icon, 
			BorderColumn, 				Modulo,					StatusIdAntecesor, 	StatusIdAntecesorAlterno, 	StatusIdSiguiente, 	
			StatusIdSiguienteAlterno, 	ClavesIdentificadores, 	colorExpired, 		IconExpired, 				BorderColumnExpired )
  VALUES(	13,			'En espera de que Programador apruebe',	4,				'#FCF3CF',					'fa fa-search-minus',
			'#5D4145',					4,						2,					2,							7,
			7,							'CVO, SAO',				'#FCF3CF',			'fa fa-search-minus',		'#5D4145'			)	

* INSERT INTO STATUS
		( 	StatusId, 					Nombre, 				TipoObjectoId, 		color, 						Icon, 
			BorderColumn, 				Modulo,					StatusIdAntecesor, 	StatusIdAntecesorAlterno, 	StatusIdSiguiente, 	
			StatusIdSiguienteAlterno, 	ClavesIdentificadores, 	colorExpired, 		IconExpired, 				BorderColumnExpired )
  VALUES(	14,			'Programado',							4,				'#FCF3CF',					'fa fa-search-minus',
			'#5D4145',					4,						2,					2,							7,
			7,							'CVO, SAO',				'#FCF3CF',			'fa fa-calendar-plus-o',	'#5D4145'			)	


INSERT INTO TmpFechaProceso 
	VALUES ( '2024-05-20', 'ALT', '2024-05-27' )


------------------------------------------------------
Esto ya no aplica

update Acciones set
ObjetoName = 'autDisenoLink'
where AccionesId = 25  and ModulosId = 17

INSERT INTO AccionesPerfiles 
			(AccionesId, PerfilesId, Activo, FechaCreacion, UsuarioCreadorId )
	VALUES  (	25,			2,			1,		GETDATE(),	1				)


------------------------------------------------------
DROP TABLE PromocionPublicada
DROP TABLE PromocionPublicadaCategorias 
DROP TABLE PromocionPublicadaProveedores
DROP TABLE PromocionPublicadaMarcas
DROP TABLE PromocionPublicadaMecanicas 
DROP TABLE CrmPublicado
DROP TABLE Publicacion 
DROP TABLE PublicacionPromocionPublicada
DROP TABLE PublicacionCrmPublicada
DROP TABLE ObjetosJson
DROP TABLE ObjetosFile
DROP TABLE MensajesSalientes
DROP TABLE MensajesSalientesPerfilesAdContent
DROP TABLE MensajesSalientesTiendasAdStore
DROP TABLE MensajesSalientesResultado
DROP TABLE PublicacionDatosBase
DROP TABLE PublicacionEncuentasAdStore
DROP TABLE PublicacionEncuentasAdStoreMediosTiendas
DROP TABLE EncuentasAdStorePreguntas
DROP TABLE EncuentasAdContent

DROP TABLE PublicacionDatosBase
DROP TABLE  PublicacionEncuentasAdStore
DROP TABLE  PublicacionEncuentasAdStoreMediosTiendas
DROP TABLE  EncuentasAdStorePreguntas
DROP TABLE  EncuentasAdContent


TRUNCATE TABLE PromocionPublicada
TRUNCATE TABLE PromocionPublicadaCategorias 
TRUNCATE TABLE PromocionPublicadaSubCategorias
TRUNCATE TABLE PromocionPublicadaProveedores
TRUNCATE TABLE PromocionPublicadaMarcas
TRUNCATE TABLE PromocionPublicadaMecanicas
TRUNCATE TABLE CrmPublicado
TRUNCATE TABLE Publicacion 
TRUNCATE TABLE PublicacionPromocionPublicada
TRUNCATE TABLE PublicacionCrmPublicado
TRUNCATE TABLE PublicacionMecanicas
TRUNCATE TABLE ObjetosJson
TRUNCATE TABLE ObjetosFile
TRUNCATE TABLE MensajesSalientes
TRUNCATE TABLE MensajesSalientesPerfilesAdContent
TRUNCATE TABLE MensajesSalientesTiendasAdStore
TRUNCATE TABLE MensajesSalientesResultado

TRUNCATE TABLE PublicacionDatosBase
TRUNCATE TABLE PublicacionEncuentasAdStore
TRUNCATE TABLE PublicacionEncuentasAdStoreMediosTiendas
TRUNCATE TABLE EncuentasAdStoreCategorias
TRUNCATE TABLE EncuentasAdStorePreguntas
TRUNCATE TABLE EncuentasAdContent


delete from FormatosCargaExcel where FormatosId IN ( 10, 11 )
delete from FormatosCargaExcelZonas where FormatosId IN ( 10, 11 )
delete from FormatosCargaExcelDesglose where FormatosId IN ( 10, 11 )
-------------------------------------------------------------------------------

DECLARE @TRA INT   SET @TRA = 3400
DELETE FROM EXCEL_PROMOCIONESMULTIFORMATO_Banderas WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONESMULTIFORMATO_Claves WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONESMULTIFORMATO_Enteros WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONESMULTIFORMATO_Montos WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONESMULTIFORMATO_Porcentajes WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONESMULTIFORMATO_Precios WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONESMULTIFORMATO_Textos WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONESMULTIFORMATO WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONESPUBLICADAS WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONESPUBLICADAS_MECANICAS WHERE TRANSACTIONID = @TRA
DELETE FROM EXCELGENTEMP_VALIDA  WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_PROMOCIONES  WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_MECANICASTIENDAS  WHERE TRANSACTIONID = @TRA
DELETE FROM EXCEL_MECANICAS  WHERE TRANSACTIONID = @TRA


DELETE FROM EXCELGENTEMP_ERRORES WHERE TRANSACTIONID = @TRA
UPDATE EXCELGENTEMP SET STATUS = 'N' WHERE TRANSACTIONID = @TRA



--USE ADMASTER_DEV 
--USE [ADMASTER_240527]
--USE ADMASTER_20231122


http://192.168.1.69:9000/#/app/promocion/promocion-form/0

-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
ALTER TABLE Interfaz_Usuarios ADD PerfilErp NVARCHAR(200) NULL

CREATE TABLE PerfilesErp (
  NombrePerfilErp	NVARCHAR(200),
  PerfilIdAdMaster	BIGINT
)

INSERT INTO PerfilesErp
	VALUES('COMPRADOR', 3 )

INSERT INTO PerfilesErp
	VALUES('INVENTARIOS', 6 )

INSERT INTO PerfilesErp
	VALUES('MARKETING', 2 )

INSERT INTO PerfilesErp
	VALUES('AUTORIZACIONES', 4 )

INSERT INTO PerfilesErp
	VALUES('ADMINISTRADOR', 1 )

INSERT INTO PerfilesErp
	VALUES('PROGRAMADOR', 8 )

-------------------------------------------------
Para testear proceso de tranmision

INSERT INTO PARAMETROS
 VALUES(92, 'PruebaProcesoTransmision', 'Activar Simulacion de ciclo de procesamiento de transmision', 'S', 'VARCHAR', 1, 1, GETDATE(), NULL, 1, NULL)


INSERT INTO PARAMETROS
 VALUES(93, 'FechaActualProcesoTransmision', 'Fecha y Hora Simulacion de ciclo de procesamiento de transmision', '2024-12-13 17:50:00', 'VARCHAR', 1, 1, GETDATE(), NULL, 1, NULL)

INSERT INTO PARAMETROS
 VALUES(94, 'EsInicioCicloEmergentes', 'Es primer Ciclo de Emergentes', 'S', 'VARCHAR', 1, 1, GETDATE(), NULL, 1, NULL)








Scheduler de los domingos a las 23:00
--------------------------------//////////////////////////////--------------------------------------
--------------------------------//////////////////////////////--------------------------------------
--------------------------------//////////////////////////////--------------------------------------
DECLARE @FolioIdLog INT

SELECT @FolioIdLog = A.FolioTransaccionId + 1
	FROM FoliosTransacciones A
	WHERE Proceso = 'LogPublicacion'

IF(@FolioIdLog IS NULL) BEGIN
	SET @FolioIdLog = 1
END

----..............................----
UPDATE FoliosTransacciones SET
	FolioTransaccionId = @FolioIdLog
	WHERE Proceso = 'LogPublicacion'
----..............................----
 
--------------------------------//////////////////////////////--------------------------------------
DECLARE @FechaUltimaGeneracionReporte DATE

SELECT @FechaUltimaGeneracionReporte = A.FechaProcesamientoReporte
	FROM TmpFechaProceso A

IF (@FechaUltimaGeneracionReporte  IS NULL) BEGIN
	SET @FechaUltimaGeneracionReporte  = DATEADD(   DAY,
													-((DATEPART(WEEKDAY, GETDATE()) + @@DATEFIRST - 2) % 7),
													GETDATE() )

END

			---SELECT FechaUltimaGeneracionReporte = @FechaUltimaGeneracionReporte
SET @FechaUltimaGeneracionReporte  = DATEADD(DAY, 7, @FechaUltimaGeneracionReporte ) 
			---SELECT FechaUltimaGeneracionReporte = @FechaUltimaGeneracionReporte

UPDATE TmpFechaProceso SET
	FechaProcesamientoReporte = @FechaUltimaGeneracionReporte

INSERT INTO LogProcesoPublicacion
	VALUES ( @FolioIdLog, 'ACT_FECHA_GEN_REPORTE', 'Actualizacion de Fecha a ' + CONVERT(VARCHAR(10), @FechaUltimaGeneracionReporte, 120) , 'ALT', GETDATE() )

--------------------------------//////////////////////////////--------------------------------------
----..............................----
SET @FolioIdLog = @FolioIdLog + 1
UPDATE FoliosTransacciones SET
	FolioTransaccionId = @FolioIdLog
	WHERE Proceso = 'LogPublicacion'
----..............................----

DECLARE @FechaCorteEmergentes DATE

SELECT @FechaCorteEmergentes = A.FechaProceso
	FROM TmpFechaProceso A

IF (@FechaCorteEmergentes IS NULL) BEGIN
	SET @FechaCorteEmergentes  = DATEADD( DAY,
													-((DATEPART(WEEKDAY, GETDATE()) + @@DATEFIRST - 2) % 7),
													GETDATE() )
END

SET @FechaCorteEmergentes  = DATEADD(DAY, 7, @FechaCorteEmergentes ) 
INSERT INTO LogProcesoPublicacion
	VALUES ( @FolioIdLog, 'CIERRE_SEM_OPE_EMERGENTES', 'Cierre de Operacion de Emergentes -> ' + CONVERT(VARCHAR(10), @FechaCorteEmergentes, 120) , 'ALT', GETDATE() )

----..............................----
SET @FolioIdLog = @FolioIdLog + 1
UPDATE FoliosTransacciones SET
	FolioTransaccionId = @FolioIdLog
	WHERE Proceso = 'LogPublicacion'
----..............................----

UPDATE TmpFechaProceso SET
	FechaProceso = @FechaCorteEmergentes

INSERT INTO LogProcesoPublicacion
	VALUES ( @FolioIdLog, 'ACT_FECHA_OPE_EMERGENTES', 'Actualizacion de Fecha a ' + CONVERT(VARCHAR(10), @FechaCorteEmergentes, 120) , 'ALT', GETDATE() )

----..............................----
SET @FolioIdLog = @FolioIdLog + 1
UPDATE FoliosTransacciones SET
	FolioTransaccionId = @FolioIdLog
	WHERE Proceso = 'LogPublicacion'
----..............................----
 
exec udp_Evento_CierraSemanaRegistoOfertas_pro @FechaCorteEmergentes

DECLARE @FechaSigPublicacion DATE
SET @FechaSigPublicacion =  DATEADD(DAY, 7, @FechaCorteEmergentes )

INSERT INTO LogProcesoPublicacion
	VALUES ( @FolioIdLog, 'INICIO_SEM_OPE_EMERGENTES', 'Inicio de Operacion de Emergentes ->' + CONVERT(VARCHAR(10), @FechaCorteEmergentes, 120) 
														+ ', para publicarse el ' +  CONVERT(VARCHAR(10), @FechaSigPublicacion, 120)  , 'ALT', GETDATE() )

--------------------------------//////////////////////////////--------------------------------------
--------------------------------//////////////////////////////--------------------------------------
--------------------------------//////////////////////////////--------------------------------------

