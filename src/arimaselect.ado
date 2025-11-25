*! arimaselect
*! Versión 0.0.1: 2025/11/24
*! Autor: Jelsin Stalin Palomino Huaytapuma
*! Economista
*! jstpalomino@hotmail.com

capture program drop arimaselect
program define arimaselect, rclass

	version 16.0

	syntax varlist(min=1 max=1) [, /*
	*/Maxar(numlist int ascend >0) /*
	*/Maxma(numlist int ascend >0) /*
	*/ ]
	
	local mx_p = 1
	if "`maxar'" != "" {
		local mx_p = `maxar'
	}
	
	local mx_q = 1
	if "`maxma'" != "" {
		local mx_q = `maxma'
	}
	
	local variable 	= "`varlist'"
	local full_matrix = (`mx_p'+1)*(`mx_q'+1)
	local j=1
	
	matrix ResultModels = J(`full_matrix',5,.)
	matrix colnames ResultModels = Obs LL df AIC BIC
	local list_model ""
	
	di as text _dup(59) "-"
	di %~59s "Procesamiento y estimación de los modelos ARIMA"
	di %~59s "Serie - `variable'"
	di as text _dup(59) "-"
	di _newline "Iniciamos análisis......"
	
	forvalue p=0/`mx_p' {
		forvalue q=0/`mx_q' {
			loc modelo_nombre "ARIMA(`p',0,`q')"
			display "`modelo_nombre'"
			quietly arima `variable', arima(`p', 0, `q') nolog
			quietly estat ic
			
			local N			= el(r(S),1,1)
			local LL		= el(r(S),1,3)
			local df		= el(r(S),1,4)
			local aic		= el(r(S),1,5)
			local bic		= el(r(S),1,6)
			
			local LL_f	: display %9.3f `LL'
			local df_f	: display %9.3f `df'
			local aic_f	: display %9.3f `aic'
			local bic_f	: display %9.3f `bic'
			
			mat ResultModels[`j', 1] = `N'
			mat ResultModels[`j', 2] = `LL_f'
			mat ResultModels[`j', 3] = `df_f'
			mat ResultModels[`j', 4] = `aic_f'
			mat ResultModels[`j', 5] = `bic_f'
			
			local list_model "`list_model' `modelo_nombre'"
			
			local ++j
		}
	}
	
	matrix rownames ResultModels = `list_model'
	
	local min_aic = 1.0e+300
	local min_bic = 1.0e+300
	local max_ll = -1.0e+300
	local mejor_modelo_aic ""
	local mejor_modelo_bic ""
	local mejor_modelo_ll ""
	local num_filas = rowsof(ResultModels)
	local Rnames : rownames ResultModels
	
	forvalues i=1/`num_filas' {
		* AIC
		local aic_actual = ResultModels[`i', 4]
		local nombre_fila_actual_aic : word `i' of `Rnames'
		if `aic_actual' < `min_aic'{
			local min_aic = `aic_actual'
			local mejor_modelo_aic = "`nombre_fila_actual_aic'"
		}
		
		* BIC
		local bic_actual = ResultModels[`i', 5]
		local nombre_fila_actual_bic : word `i' of `Rnames'
		if `bic_actual' < `min_bic' {
			local min_bic = `bic_actual'
			local mejor_modelo_bic = "`nombre_fila_actual_bic'"
		}
		
		* LL
		local ll_actual = ResultModels[`i', 2]
		local nombre_fila_actual_ll : word `i' of `Rnames'
		if `ll_actual' > `max_ll' {
			local max_ll = `ll_actual'
			local mejor_modelo_ll = "`nombre_fila_actual_ll'"
		}
	}
	
	di "Análisis terminado......"
	
	di _newline "Modelo ajustado (`full_matrix'): .................... hecho"
	di "Criterios de selección de orden de rezago"
	matlist ResultModels
	di _newline "Modelos seleccionados"
	display as text "Selected (max) LL	:  " as result "`mejor_modelo_ll'"
	display as text "Selected (min) AIC	:  " as result "`mejor_modelo_aic'"
	display as text "Selected (min) BIC	:  " as result "`mejor_modelo_bic'"

end



