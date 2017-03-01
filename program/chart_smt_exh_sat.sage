# reset()    # reset deactivated becaouse it caused R stop working if it run for second time 
# r.detach()
# r.closeAllConnections()
# r.rm()
#######################################################
# try:
#     os.mkdir('simulation_plots')
# except Exception:
#     pass
# for m in [22..25]:
#   name = 'simulation_plots/nama-boxplot_'+str(m)+'.png'
#   r.png(file = '"%s"'%name )
#   x = r.rnorm(100)
#   y = r.rnorm(100)
#   r.boxplot(x,y,x,y)
#   name = 'simulation_plots/nama-plot_'+str(m)+'.png'
#   r.png(file = '"%s"'%name )
#   r.plot(x,y)
#   r.dev_off()
#######################################################
list_m=[2..7]
##SMT
smt={}
for m in list_m:
  try:
    f = file('simulation_smt/simulation_smt_bv_bb_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,'pre_time') in smt:
      smt[m,'pre_time'].append(float(line_list[2]))
      smt[m,'com_time'].append(float(line_list[3]))
    else:
      smt[m,'pre_time'] = [float(line_list[2])]
      smt[m,'com_time'] = [float(line_list[3])]
  f.close()

##Exh
exh={}
for m in list_m:
  try:
    f = file('simulation_exh/simulation_exh_bb_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,int(line_list[1]),'time') in exh:
      exh[m,'time'].append(float(line_list[2]))
      exh[m,'guess'].append(int(line_list[3]))
      exh[m,'bcktrk'].append(int(line_list[4]))
    else:
      exh[m,'time'] = [float(line_list[2])]
      exh[m,'guess'] = [int(line_list[3])]
      exh[m,'bcktrk'] = [int(line_list[4])]
  f.close()

##SAT
sat={}
for m in list_m:
  try:
    f = file('simulation_sat/simulation_cnf_bb_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,'pre_time') in sat:
      sat[m,'pre_time'].append(float(line_list[2]))
      sat[m,'com_time'].append(float(line_list[3]))
    else:
      sat[m,'pre_time'] = [float(line_list[2])]
      sat[m,'com_time'] = [float(line_list[3])]
  f.close()
  

  
#scatter plot ratio of blanks vs pretime  #scatter plot ratio of blanks vs time


smt_com_lst = [ mean(smt[m1, 'com_time'])+mean(smt[m1, 'pre_time']) for m1 in list_m ]
exh_com_lst = [ mean(exh[m1, 'time']) for m1 in list_m ]
sat_com_lst = [ mean(sat[m1, 'com_time'])+mean(sat[m1, 'pre_time']) for m1 in list_m ]

print list_m
print sat_com_lst
print exh_com_lst
print smt_com_lst


# print zip(*[list_m,exh_com_lst])
# print zip(*[list_m,smt_com_lst])
# print zip(*[list_m,sat_com_lst])
