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

##SMT
smt={}
list_m=[20..21]
for m in list_m:
  try:
    f = file('simulation_smt/simulation_smt_v2_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,int(line_list[1]),int(line_list[2]),'pre_time') in smt:
      smt[m,int(line_list[1]),int(line_list[2]),'pre_time'].append(float(line_list[3]))
      smt[m,int(line_list[1]),int(line_list[2]),'com_time'].append(float(line_list[4]))
    else:
      smt[m,int(line_list[1]),int(line_list[2]),'pre_time'] = [float(line_list[3])]
      smt[m,int(line_list[1]),int(line_list[2]),'com_time'] = [float(line_list[4])]
  f.close()
  for type in [1..6]:
    
    
  # g = file('simulation_smt/simulation_smt_aggre_'+str(m)+'.txt','w')
  # g.write('blank compt_time\n')
  # for blnk in [1..(2*m)^2]:
  #   g.write(str(blnk)+' '+str(mean(smt[m,blnk,'com_time']))+'\n')
  # g.close()

  #com_data = map(list,zip(*[blnk_lst,com_time_lst]))
  
  
# #scatter plot ratio of blanks vs pretime  #scatter plot ratio of blanks vs time
# blnk_ratio_lst = [ blnk/(2*m1)^2 for m1 in list_m for blnk in [1..(2*m1)^2 ] ]
# pre_time_lst   = [ mean(smt[m1, blnk, 'pre_time']) for m1 in list_m for blnk in [1..(2*m1)^2] ]
# com_time_lst   = [ mean(smt[m1, blnk, 'com_time']) for m1 in list_m for blnk in [1..(2*m1)^2] ]
# name = 'simulation_plots/smt_scatterplot_pre_time_' + '.png'
# mtitle='SMT solver '
# ylabel='Precomputation time (s)'
# xlabel='Ratio of blanks '
# r.png(file = '"%s"'%name )
# r.plot(blnk_ratio_lst,pre_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
# r.dev_off()
# name = 'simulation_plots/smt_scatterplot_com_time_' + '.png'
# mtitle='SMT solver '
# ylabel='Computation time (s)'
# xlabel='Ratio of blanks '
# r.png(file = '"%s"'%name )
# r.plot(blnk_ratio_lst,com_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
# r.dev_off()
