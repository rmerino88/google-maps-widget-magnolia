[#assign key = content.googleMapsKey!]
<script defer src="http://maps.googleapis.com/maps/api/js?key=${key?trim}" type="text/javascript"></script>

[#assign key = content.googleMapsKey!][#assign key = content.googleMapsKey!]

[#assign listaCoordenadas = cmsfn.children(content, "mgnl:contentNode")]

[#assign textoBotonVolverAlMapa = content.botonVolverAlMapa!]
[#assign mapType = content.mapType!""] 
[#assign estilo = ""]
[#if mapType == "roadmap"]
	[#assign estilo = content.mapTyperoadmap!""]
[/#if]
[#assign zoom = content.zoom!"5"]
[#assign initLat = content.latitudInicial!""]
[#assign initLong = content.longitudInicial!""]
[#assign height = content.height!"500"]
[#assign width = content.width!"100"]

[#if listaCoordenadas?has_content]
	<div class="map-container" style="width: ${width}%; height: ${height}px">
		<div id="mapa" class="mapa"></div>
		<button id="btnVolverMapa" class="btn btn-primary btnVolverMapa">${textoBotonVolverAlMapa!}</button>
	</div>
[/#if]

<script>
	$(document).ready(function(){
		 
		var coordenadas = new Array();
		var tipoMapa="${mapType!}";
		var estilo="${estilo!}";
		initLat = ${initLat};
		initLong = ${initLong};
		var zoom = ${zoom}
		
		[#if listaCoordenadas?has_content]
			[#list listaCoordenadas as coordenada]
			
				[#assign latitud = coordenada.latitud!]
				[#assign longitud = coordenada.longitud!]
				[#assign contenido = coordenada.contenido!""]
				[#assign contenido = ""]
				[#assign titulo = coordenada.title!]
				[#if coordenada.contenido??]
					[#assign contenido = cmsfn.decode(coordenada).contenido!""]
					[#assign contenido = contenido?replace("\n","")!] 
				[/#if]
				
				[#assign iconSrc = ""]
				[#assign image = coordenada.image!]
				[#if image?has_content]
					[#if image??]
						[#assign iconSrc = damfn.getAssetLink(image)!]	 
					[/#if]
				[/#if]
					
				var contenido = escape('${contenido}');
				coordenadas.push(['${titulo}',contenido,'${latitud!}','${longitud!}','${iconSrc}']);
			[/#list]
			
			var $btnVolverMapa = $('#btnVolverMapa');
			$btnVolverMapa.click(function(){
				cargarMapa(coordenadas, tipoMapa, estilo, initLat, initLong, zoom);
			});
			
			cargarMapa(coordenadas, tipoMapa, estilo, initLat, initLong, zoom);
		[/#if]
	});
</script>