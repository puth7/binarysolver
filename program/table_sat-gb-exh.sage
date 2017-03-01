 reset() 
# r.detach()
# r.closeAllConnections()
# r.rm()

try:
    os.mkdir('simulation_plots')
except Exception:
  pass

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
list_m=[2]
##GB
gb={}
for m in list_m:
  try:
    f = file('simulation_gb/simulation_gb_v2_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,int(line_list[2]),'pre_time') in gb:
      gb[m,int(line_list[2]),'pre_time'].append(float(line_list[3]))
      gb[m,int(line_list[2]),'com_time'].append(float(line_list[4]))
    else:
      gb[m,int(line_list[2]),'pre_time'] = [float(line_list[3])]
      gb[m,int(line_list[2]),'com_time'] = [float(line_list[4])]
  f.close()

##SAT
sat={}
for m in list_m:
  try:
    f = file('simulation_sat/simulation_cnf_v2_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,int(line_list[2]),'pre_time') in sat:
      sat[m,int(line_list[2]),'pre_time'].append(float(line_list[3]))
      sat[m,int(line_list[2]),'com_time'].append(float(line_list[4]))
    else:
      sat[m,int(line_list[2]),'pre_time'] = [float(line_list[3])]
      sat[m,int(line_list[2]),'com_time'] = [float(line_list[4])]
  f.close()

##SAT_T
sat_t={}
for m in list_m:
  try:
    f = file('simulation_sat/simulation_cnf_v2_tse_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,int(line_list[2]),'pre_time') in sat_t:
      sat_t[m,int(line_list[2]),'pre_time'].append(float(line_list[3]))
      sat_t[m,int(line_list[2]),'com_time'].append(float(line_list[4]))
    else:
      sat_t[m,int(line_list[2]),'pre_time'] = [float(line_list[3])]
      sat_t[m,int(line_list[2]),'com_time'] = [float(line_list[4])]
  f.close()

##Exh
exh={}
for m in list_m:
  try:
      f = file('simulation_exh/simulation_exh_'+str(m)+'.txt','r')
  except:
      continue
  for line in f:
    if line.startswith('size'):
        continue
    line_list=line.split()
    if (m,int(line_list[1]),'time') in exh:
      exh[m,int(line_list[1]),'time'].append(float(line_list[2]))
      exh[m,int(line_list[1]),'guess'].append(int(line_list[3]))
      exh[m,int(line_list[1]),'bcktrk'].append(int(line_list[4]))
    else:
      exh[m,int(line_list[1]),'time'] = [float(line_list[2])]
      exh[m,int(line_list[1]),'guess'] = [int(line_list[3])]
      exh[m,int(line_list[1]),'bcktrk'] = [int(line_list[4])]
  f.close()

sat_lst=[]
exh_lst=[]
gb_lst=[]
for m in list_m:
  for blnk in [1..(2*m)^2]:
    try:
        exh_lst.append([blnk,mean(exh[m,blnk, 'time'])])
        gb_lst.append([blnk,mean(gb[m,blnk, 'com_time'])])
        sat_lst.append([blnk, mean(sat[m,blnk, 'com_time'])])
    except:
        continue
    

g = file('simulation_plots/different_number_exp.txt','w')
g.write('x exh gb sat \n')
for i in xrange(15):
    g.write(str(exh_lst[i][0])+' '+str(exh_lst[i][1])+' '+str(gb_lst[i][1])+' '+str(sat_lst[i][1])+'\n')
g.close()

# sat_com_lst = [ mean(sat[m1,blnk, 'com_time'])+mean(sat[m1,blnk, 'pre_time']) for blnk in [..]  for m1 in list_m ]
# exh_com_lst = [ mean(exh[m1,blnk, 'time']) for blnk in [1..]for m1 in list_m ]


# print sat_pre_lst
# print sat_com_lst
# print exh_com_lst

# print zip(*[list_m,exh_com_lst])
# print zip(*[list_m,sat_com_lst])


# fig2 = plot_semilogy(f2(x),x,[0,1600])
# fig2+=list_plot_semilogy(com_data,title='Log-linear fit for $m = 20$',axes_labels=['Blanks','log(time)'],frame=True,axes_labels_size=1)
# fig2.save('simulation_plots/sat_scatterplot_com_'+str(m)+'.png')
