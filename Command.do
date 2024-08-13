use "/Users/ludifeng/Desktop/Master thesis/data.dta"
generate byte Province = 0
replace Province = 1 if region == "Ningxia" | region == "Inner Mongolia" | region == "Tibet" | region == "Guangxi" | region == "Xingjiang"
save "/Users/ludifeng/Desktop/Master thesis/data.dta", replace
xtset id year
local varlist "Rsr Nir Ir Rir GDP_pgr Ur Di Igr Pcp Cpgr Eoe Hc Cdr Odr Pipr Sr Poup Poum Auhs"
estpost summarize `varlist', detail
esttab using Myfile.rtf, cells("count mean(fmt(3)) sd(fmt(3)) min(fmt(3)) p50(fmt(3)) max(fmt(3))") noobs compress replace title(esttab_Table: Descriptive statistics)
estpost correlate `varlist', matrix
esttab using Myfile.rtf, unstack not noobs compress nogaps replace star(* 0.1 ** 0.05 *** 0.01) b(%8.3f) p(%8.3f) title(esttab_Table: correlation coefficient matrix)
esttab using Myfile.rtf, unstack not noobs compress nogaps replace star(* 0.1 ** 0.05 *** 0.01) b(%8.3f) p(%8.3f) title(esttab_Table: correlation coefficient matrix)
label variable Rsr "Residents saving rate"
label variable Nir "nominal interest rate"
label variable Ir "Inflation rate"
label variable Rir "Real interest rate"
label variable GDP_pgr "GDP per capita growth rate"
label variable Ur "Unemployment rate"
label variable Di "Urban disposable income per capita (excluding inflation)"
label variable Igr "Income growth rate"
label variable Pcp "Sales price of commercial housing (yuan/square meter)"
label variable Cpgr "House price growth rate"
label variable Eoe "Expenditure on education"
label variable Hc "Heath care expenditure"
label variable Cdr "Child dependency ratio"
label variable Odr "Elderly dependency ratio"
label variable Pipr "Urban pension insurance participation rate"
label variable Sr "Sex ratio"
label variable Poup "Proportion of unmarried population"
label variable Poum "Proportion of unmarried men"
label variable Auhs "Urban household size"
xtreg Rsr Rir GDP_pgr Ur Di Igr Pcp Cpgr Eoe Hc Cdr Odr Pipr Sr Poup Poum Auhs,fe
xtreg Rsr Rir GDP_pgr Ur Di Igr Pcp Cpgr Eoe Hc Cdr Odr Pipr Sr Poup Poum Auhs,re
xttest0
qui xtreg Rsr Rir GDP_pgr Ur Di Igr Pcp Cpgr Eoe Hc Cdr Odr Pipr Sr Poup Poum Auhs,fe
est store fe
qui xtreg Rsr Rir GDP_pgr Ur Di Igr Pcp Cpgr Eoe Hc Cdr Odr Pipr Sr Poup Poum Auhs,re
est store re
hausman fe re
reg Rsr Rir Nir Ir Di Igr
reg Rsr Rir  Di Igr
est store m1
xtreg Rsr Rir  Di Igr,fe
est store m2
xtreg Rsr Nir  Di Igr,fe
est store m3
xtreg Rsr Ir  Di Igr,fe
est store m4
esttab m1 m2 m3 m4 using Myfile.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) se(%7.2f)  r2(%9.3f) ar2 aic bic obslast scalars(F)
xtreg Rsr Rir  Di Igr Cpgr
est store m5
xtreg Rsr Rir  Di Igr Cpgr,fe
est store m5
xtreg Rsr Rir  Di Igr Cpgr if year<2015,fe
est store m6
xtreg Rsr Rir  Di Igr Cpgr if year>=2015,fe
est store m7
esttab m5 m6 m7 using Myfile.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) se(%7.2f)  r2(%9.3f) ar2 aic bic obslast scalars(F)
xtreg Rsr Rir  Di Igr Eoe ,fe
est store m8
xtreg Rsr Rir  Di Igr Eoe  Hc ,fe
est store m9
xtreg Rsr Rir  Di Igr   Hc Cpgr ,fe
est store m10
esttab m8 m9 m10 using Myfile.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) se(%7.2f)  r2(%9.3f) ar2 aic bic obslast scalars(F)
xtreg Rsr Rir  Di Igr Cdr ,fe
est store m11
xtreg Rsr Rir  Di Igr Odr ,fe
est store m12
xtreg Rsr Rir  Di Igr Odr Pipr ,fe
est store m13
xtdes
xtreg Rsr Rir  Di Igr Cdr if Province ==0,fe
est store m134
est store m14
xtreg Rsr Rir  Di Igr Odr  if Province ==0,fe
est store m15
xtreg Rsr Rir  Di Igr Odr Pipr  if Province ==0,fe
est store m16
esttab m11 m12 m13 m14 m15 m16 using Myfile.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) se(%7.2f)  r2(%9.3f) ar2 aic bic obslast scalars(F)
xtreg Rsr Rir  Di Igr Sr ,fe
est store m17
xtreg Rsr Rir  Di Igr Auhs ,fe
est store m18
xtreg Rsr Rir  Di Igr Poup ,fe
est store m19
xtreg Rsr Rir  Di Igr Poum ,fe
est store m20
xtreg Rsr Rir  Di Igr Sr Auhs Poup Poum ,fe
est store m21
esttab m17 m18 m19 m20 m21 using Myfile.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) se(%7.2f)  r2(%9.3f) ar2 aic bic obslast scalars(F)
aaplot Rsr Rir
xtreg Rsr Rir  Di Igr Pipr Cdr  ,fe
est store m11
xtreg Rsr Rir  Di Igr Pipr Odr ,fe
est store m12
xtreg Rsr Rir  Di Igr Pipr Odr Hc ,fe
est store m13
xtreg Rsr Rir  Di Igr Pipr Cdr  if Province ==0 ,fe
est store m14
xtreg Rsr Rir  Di Igr Pipr Odr  if Province ==0,fe
est store m15
xtreg Rsr Rir  Di Igr Pipr Odr Eoe if Province ==0,fe
est store m16
esttab m11 m12 m13 m14 m15 m16 using Myfile.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) se(%7.2f)  r2(%9.3f) ar2 aic bic obslast scalars(F)
xtreg Rsr Rir  Di Igr Sr ,fe
xtreg Rsr Rir  Di Igr Pipr Sr ,fe
xtreg Rsr Rir  Di Igr Pipr Cdr ,fe
xtreg Rsr Rir  Di Igr Sr  if Province ==0,fe
est store m17
esttab m17 m18 m19 m20 m21 using Myfile.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) se(%7.2f)  r2(%9.3f) ar2 aic bic obslast scalars(F)
xtreg Rsr Rir  Di Igr Sr  if Province ==0, fe
est store m17
xtreg Rsr Rir  Di Igr Auhs  if Province ==0,fe
est store m18
xtreg Rsr Rir  Di Igr Poup  if Province ==0,fe
est store m19
xtreg Rsr Rir  Di Igr Poum  if Province==0,fe
est store m20
xtreg Rsr Rir  Di Igr Sr Auhs Poup Poum  if Province==0,fe
est store m21
esttab m17 m18 m19 m20 m21 using Myfile.rtf, replace star( * 0.10 ** 0.05 *** 0.01 ) nogaps compress  b(%20.3f) se(%7.2f)  r2(%9.3f) ar2 aic bic obslast scalars(F)
save "/Users/ludifeng/Desktop/Master thesis/result.dta"
