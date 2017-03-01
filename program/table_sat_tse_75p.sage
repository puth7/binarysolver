reset()
##SAT
sat={}
list_m=[2..9]
print 
for m in list_m:
  try:
    f = file('simulation_sat/simulation_cnf_v2_tse_'+str(m)+'.txt','r')
  except:
    continue
  
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,'pre_time') in sat:
      sat[m,'pre_time'].append(float(line_list[3]))
      sat[m,'com_time'].append(float(line_list[4]))
    else:
      sat[m,'pre_time'] = [float(line_list[3])]
      sat[m,'com_time'] = [float(line_list[4])]
  f.close()

  #scatter plot blanks vs pretime   #scatter plot blanks vs time
 
  pre_time_lst = [ mean(sat[m, 'pre_time']) ]
  com_time_lst = [ mean(sat[m, 'com_time']) ]
#  print m, com_time_lst
  print m, pre_time_lst
#  print '------------'
#  print sat

  


