reset()
##EXH
exh={}
list_m=[2..9]

for m in list_m:
  try:
    f = file('simulation_exh/simulation_exh_v2_'+str(m)+'.txt','r')
  except:
    continue
  
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m) in exh:
      exh[m].append(float(line_list[2]))
    else:
      exh[m] = [float(line_list[2])]
  f.close()

  #scatter plot blanks vs pretime   #scatter plot blanks vs time
 
  com_time_lst = [ mean(exh[m]) ]
  print m, com_time_lst
#  print exh

  

