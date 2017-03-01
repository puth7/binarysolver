###Uniquness
uniq={}
list_m = [2..20]
for m in list_m:
  try:
    f = file('simulation_unique/simulation_smt_bv_unique_time_comput_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,int(line_list[1])) in uniq:
      uniq[m,int(line_list[1])].append(line_list[3]=='sat')
    else:
      uniq[m,int(line_list[1])] = [line_list[3]=='sat']
  f.close()
  # scatter plot of the ratio of unique solution e (y axis), x axis: number of blanks
  blnk_lst = [1..(2*m)^2 ] 
  ratio_uniq_lst   = [[blnk,float(uniq[m, blnk].count(False))/len(uniq[m, blnk])]  for blnk in [1..(2*m)^2] ]
 
  halfuniq=[]
  for ratuniq in ratio_uniq_lst:
    if ratuniq[1]<0.57 and ratuniq[1]>0.45:
      halfuniq.append(ratuniq[0])
  print m, round(mean(halfuniq)    )


  
  
# scatter plot of ratio of blanks vs ratio of uniqueness
blnk_ratio_lst_all = [ blnk/(2*m1)^2 for m1 in list_m for blnk in [1..(2*m1)^2 ] ]
ratio_uniq_lst_all   = [float(uniq[m1, blnk].count(False))/len(uniq[m1, blnk]) for m1 in list_m for blnk in [1..(2*m1)^2] ]


