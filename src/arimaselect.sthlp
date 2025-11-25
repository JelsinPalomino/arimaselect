{smcl}
{* *! version 0.0.1 24nov2025}

{p2colset 1 16 18 2}{...}
{p2col:{bf:arimaselect} {hline 2}}ARIMASELECT. Alternativa a ARIMASOC, para STATA versión 16{p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}

{pstd}
Sintaxis básica para el cálculo de modelos ARIMA(p,0,q)

{p 8 16 2}
{cmd:arimaselect}
{depvar}
{cmd:,} 
{opth maxar(numlist)} 
{opth maxma(numlist)} 

{pstd}
Sintaxis basica para el modelo por defecto

{p 8 16 2}
{cmd:arimaselect}
{depvar}

{pstd}
Sintaxis para el modelo definiendo niveles AR y MA

{p 8 16 2}
{cmd:arimaselect}
{depvar}
{cmd:,} 
{opth maxar(#p)} 
{opth maxma(#q)}

{synoptset 28 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:arimaselect}
{synopt:{opth maxar(numlist)}}autoregressive terms of the structural model disturbance{p_end}
{synopt:{opth maxma(numlist)}}moving-average terms of the structural model disturbance{p_end}
{synoptline}
{p 4 6 2}
Debes aplicar el comando {opt tsset} en tus datos antes de usar {opt arimaselect}; see {manhelp tsset TS}.
{p_end}

{marker menu}{...}
{title:Menu}

{phang}
{bf: Estadísticas > Series de tiempo > ARIMA y ARMA models}

{marker descripción}
{title:Descripción}

{pstd}
El comando {cmd:arimaselect} Pretende calcular las estadísticas para selección del 
orden de los componentes AR y MA. Se intenta replicar los resultados del comando 
{cmd:arimasoc} para STATA versión 16.

{marker linkspdf}{...}
{title:Enlaces a documentación en PDF}

	{mansection TS arimaQuickstart:Quick start}

{marker examples}{...}
{title:Examples}

{hline}
{pstd}Setup{p_end}
{phang2}{cmd:. webuse wpi1}{p_end}

{pstd}ARIMASELECT con valores de AR y MA por defecto (1){p_end}
{phang2}{cmd:. arimaselect wpi}{p_end}

{pstd}ARIMASELECT con valores de AR y MA definidos{p_end}
{phang2}{cmd:. arimaselect wpi, maxar(2) maxma(2)}

{hline}

{marker author}{...}
{title:Author}

{pstd}Jelsin Stalin Palomino Huaytapuma{break}
Economista{break}
Email: {browse "mailto:jstpalomino@hotmail.com":jstpalomino@hotmail.com}
{p_end}

{marker support}{...}
{title:Support and updates}

{pstd}{cmd:arimaselect} Revisa más actualizaciones en: 
({browse "https://github.com/MaykolMedrano/enahodata":Github repo}).{p_end}