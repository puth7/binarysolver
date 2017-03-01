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




##SAT
sat={}
list_m = [2..6]
for m in list_m:
  try:
    f = file('simulation_sat/simulation_cnf_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,int(line_list[1]),'pre_time') in sat:
      sat[m,int(line_list[1]),'pre_time'].append(float(line_list[2]))
      sat[m,int(line_list[1]),'com_time'].append(float(line_list[3]))
    else:
      sat[m,int(line_list[1]),'pre_time'] = [float(line_list[2])]
      sat[m,int(line_list[1]),'com_time'] = [float(line_list[3])]
  f.close()
  # for blanks in [1..(2*m)^2]:
  #    #boxplot of computation time 
  #    name = 'simulation_plots/sat_boxplot_com_time_'+str(m) + '_' + str(blanks) + '.png'
  #    mtitle ='SAT solver \n Size: '+str(2*m)+' x '+str(2*m)+'. Blanks = '+ str(blanks)
  #    ylabel ='Computation time (s)'
  #    r.png(file = '"%s"'%name )
  #    r.boxplot(sat[m,blanks,'com_time'])
  #    r.title(main='"%s"'%mtitle, ylab='"%s"'%ylabel)
  #    r.dev_off()
  #    #boxplot of  precomputation time
  #    name = 'simulation_plots/sat_boxplot_pre_time_'+str(m) + '_' + str(blanks) + '.png'
  #    mtitle ='SAT solver\n Size: '+str(2*m)+' x '+str(2*m)+'. Blanks = '+ str(blanks)
  #    ylabel ='Precomputation time (s)'
  #    r.png(file = '"%s"'%name )
  #    r.boxplot(sat[m,blanks,'pre_time'])
  #    r.title(main='"%s"'%mtitle, ylab='"%s"'%ylabel)
  #    r.dev_off()
  #scatter plot blanks vs pretime   #scatter plot blanks vs time
  blnk_lst = [1..(2*m)^2 ]
  pre_time_lst = [ mean(sat[m, blnk, 'pre_time']) for blnk in [1..(2*m)^2 ]]
  com_time_lst = [ mean(sat[m, blnk, 'com_time']) for blnk in [1..(2*m)^2 ]]
  name = 'simulation_plots/sat_scatterplot_pre_time_' + str(m)  + '.png'
  mtitle='SAT solver\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Precomputation time (s)'
  xlabel='Number of blanks '
  r.png(file = '"%s"'%name )
  r.plot(blnk_lst,pre_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
  name = 'simulation_plots/sat_scatterplot_com_time_' + str(m) + '.png'
  mtitle='SAT solver\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Computation time (s)'
  xlabel='Number of blanks '
  r.png(file = '"%s"'%name )
  r.plot(blnk_lst,com_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
#scatter plot ratio of blanks vs pretime  #scatter plot ratio of blanks vs time
blnk_ratio_lst = [ blnk/(2*m1)^2 for m1 in list_m for blnk in [1..(2*m1)^2 ] ]
pre_time_lst   = [ mean(sat[m1, blnk, 'pre_time']) for m1 in list_m for blnk in [1..(2*m1)^2] ]
com_time_lst   = [ mean(sat[m1, blnk, 'com_time']) for m1 in list_m for blnk in [1..(2*m1)^2] ]
name = 'simulation_plots/sat_scatterplot_pre_time_' + '.png'
mtitle='SAT solver '
ylabel='Precomputation time (s)'
xlabel='Ratio of blanks '
r.png(file = '"%s"'%name )
r.plot(blnk_ratio_lst,pre_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
r.dev_off()
name = 'simulation_plots/sat_scatterplot_com_time_' + '.png'
mtitle='SAT solver '
ylabel='Computation time (s)'
xlabel='Ratio of blanks '
r.png(file = '"%s"'%name )
r.plot(blnk_ratio_lst,com_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
r.dev_off()

##SMT
smt={}
list_m=[2..23]
for m in list_m:
  try:
    f = file('simulation_smt/simulation_smt_bv_time_'+str(m)+'.txt','r')
  except:
    continue
  for line in f:
    if line.startswith('size'):
      continue
    line_list=line.split()
    if (m,int(line_list[1]),'pre_time') in smt:
      smt[m,int(line_list[1]),'pre_time'].append(float(line_list[2]))
      smt[m,int(line_list[1]),'com_time'].append(float(line_list[3]))
    else:
      smt[m,int(line_list[1]),'pre_time'] = [float(line_list[2])]
      smt[m,int(line_list[1]),'com_time'] = [float(line_list[3])]
  f.close()
  # for blanks in [1..(2*m)^2]:
  #    #boxplot of computation time 
  #    name = 'simulation_plots/smt_boxplot_com_time_'+str(m) + '_' + str(blanks) + '.png'
  #    mtitle ='SMT solver \n Size: '+str(2*m)+' x '+str(2*m)+'. Blanks = '+ str(blanks)
  #    ylabel ='Computation time (s)'
  #    r.png(file = '"%s"'%name )
  #    r.boxplot(smt[m,blanks,'com_time'])
  #    r.title(main='"%s"'%mtitle, ylab='"%s"'%ylabel)
  #    r.dev_off()
  #    #boxplot of  precomputation time
  #    name = 'simulation_plots/smt_boxplot_pre_time_'+str(m) + '_' + str(blanks) + '.png'
  #    mtitle ='SMT solver\n Size: '+str(2*m)+' x '+str(2*m)+'. Blanks = '+ str(blanks)
  #    ylabel ='Precomputation time (s)'
  #    r.png(file = '"%s"'%name )
  #    r.boxplot(smt[m,blanks,'pre_time'])
  #    r.title(main='"%s"'%mtitle, ylab='"%s"'%ylabel)
  #    r.dev_off()
  #scatter plot blanks vs pretime   #scatter plot blanks vs time
  blnk_lst = [1..(2*m)^2 ]
  pre_time_lst = [ mean(smt[m, blnk, 'pre_time']) for blnk in [1..(2*m)^2 ]]
  com_time_lst = [ mean(smt[m, blnk, 'com_time']) for blnk in [1..(2*m)^2 ]]
  name = 'simulation_plots/smt_scatterplot_pre_time_' + str(m)  + '.png'
  mtitle='SMT solver\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Precomputation time (s)'
  xlabel='Number of blanks '
  r.png(file = '"%s"'%name )
  r.plot(blnk_lst,pre_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
  name = 'simulation_plots/smt_scatterplot_com_time_' + str(m) + '.png'
  mtitle='SMT solver\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Computation time (s)'
  xlabel='Number of blanks '
  r.png(file = '"%s"'%name )
  r.plot(blnk_lst,com_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
#scatter plot ratio of blanks vs pretime  #scatter plot ratio of blanks vs time
blnk_ratio_lst = [ blnk/(2*m1)^2 for m1 in list_m for blnk in [1..(2*m1)^2 ] ]
pre_time_lst   = [ mean(smt[m1, blnk, 'pre_time']) for m1 in list_m for blnk in [1..(2*m1)^2] ]
com_time_lst   = [ mean(smt[m1, blnk, 'com_time']) for m1 in list_m for blnk in [1..(2*m1)^2] ]
name = 'simulation_plots/smt_scatterplot_pre_time_' + '.png'
mtitle='SMT solver '
ylabel='Precomputation time (s)'
xlabel='Ratio of blanks '
r.png(file = '"%s"'%name )
r.plot(blnk_ratio_lst,pre_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
r.dev_off()
name = 'simulation_plots/smt_scatterplot_com_time_' + '.png'
mtitle='SMT solver '
ylabel='Computation time (s)'
xlabel='Ratio of blanks '
r.png(file = '"%s"'%name )
r.plot(blnk_ratio_lst,com_time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
r.dev_off()


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
  #spine plot / stacked bar chart of the number of unique solution appended with nonunique (y axis), x axis: number of blanks
  pairs_unique=[[uniq[m, blnk].count(False), uniq[m, blnk].count(True)] for blnk in [1..(2*m)^2]]
  name = 'simulation_plots/uniq_stacked_bar_plot'+str(m) + '.png'
  mtitle='Distribution of uniqueness'
  xlabel='Blanks '
  r.png(file = '"%s"'%name )
  r.barplot(r.cbind(*pairs_unique), main='"%s"'%mtitle, xlab='"%s"'%xlabel)
  r.dev_off()
# scatter plot of ratio of blanks vs ratio of uniqueness
blnk_ratio_lst = [ blnk/(2*m1)^2 for m1 in list_m for blnk in [1..(2*m1)^2 ] ]
ratio_uniq_lst   = [float(uniq[m1, blnk].count(False))/len(uniq[m1, blnk]) for m1 in list_m for blnk in [1..(2*m1)^2] ]
name = 'simulation_plots/uniq_scatterplot' + '.png'
mtitle='Uniqueness vs. blanks'
ylabel='Ratio of uniqueness'
xlabel='Ratio of blanks '
r.png(file = '"%s"'%name )
r.plot(blnk_ratio_lst,ratio_uniq_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
r.dev_off()


##Exh
exh={}
list_m=[2..9]
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
  # for blanks in [1..(2*m)^2]:
  #   try:
  #     #boxplot of computation time 
  #     name = 'simulation_plots/exh_boxplot_com_time_'+str(m) + '_' + str(blanks) + '.png'
  #     mtitle ='Exhaustive search \n Size: '+str(2*m)+' x '+str(2*m)+'. Blanks = '+ str(blanks)
  #     ylabel ='Computation time (s)'
  #     r.png(file = '"%s"'%name )
  #     r.boxplot(exh[m,blanks,'time'])
  #     r.title(main='"%s"'%mtitle, ylab='"%s"'%ylabel)
  #     r.dev_off()
  #     #boxplot of guessing
  #     name = 'simulation_plots/exh_boxplot_guess_'+str(m) + '_' + str(blanks) + '.png'
  #     mtitle ='Exhaustive search \n Size: '+str(2*m)+' x '+str(2*m)+'. Blanks = '+ str(blanks)
  #     ylabel ='Number of guessing'
  #     r.png(file = '"%s"'%name )
  #     r.boxplot(exh[m,blanks,'guess'])
  #     r.title(main='"%s"'%mtitle, ylab='"%s"'%ylabel)
  #     r.dev_off()
  #     #boxplot of backtract
  #     name = 'simulation_plots/exh_boxplot_backtract_'+str(m) + '_' + str(blanks) + '.png'
  #     mtitle ='Exhaustive search \n Size: '+str(2*m)+' x '+str(2*m)+'. Blanks = '+ str(blanks)
  #     ylabel ='Number of backtract'
  #     r.png(file = '"%s"'%name )
  #     r.boxplot(exh[m,blanks,'bcktrk'])
  #     r.title(main='"%s"'%mtitle, ylab='"%s"'%ylabel)
  #     r.dev_off()
  #   except:
  #     continue
  blnk_lst = [blnk for blnk in [2..(2*m)^2] for i in xrange(len(exh[m,blnk,'time']))]  
  time_lst = flatten([exh[m, blnk, 'time'] for blnk in [2..(2*m)^2 ]])
  guess_lst = flatten([exh[m, blnk, 'guess'] for blnk in [2..(2*m)^2 ]])
  bcktrk_lst = flatten([exh[m, blnk, 'bcktrk'] for blnk in [2..(2*m)^2 ]])
  name = 'simulation_plots/exh_scatterplot_blank_vs_time_' + str(m)  + '.png'
  mtitle='Exhaustive search\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Computation time (sec)'
  xlabel='Number of blanks '
  r.png(file = '"%s"'%name )
  r.plot(blnk_lst,time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
  name = 'simulation_plots/exh_scatterplot_blank_vs_guess_' + str(m) + '.png'
  mtitle='Exhaustive search\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Number of guesses'
  xlabel='Number of blanks '
  r.png(file = '"%s"'%name )
  r.plot(blnk_lst,guess_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
  name = 'simulation_plots/exh_scatterplot_blank_vs_backtrack_' + str(m) + '.png'
  mtitle='Exhaustive search\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Number of backtrack'
  xlabel='Number of blanks '
  r.png(file = '"%s"'%name )
  r.plot(blnk_lst,bcktrk_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
  name = 'simulation_plots/exh_scatterplot_guess_vs_time_' + str(m) + '.png'
  mtitle='Exhaustive search\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Computation time (sec)'
  xlabel='Number of guesses '
  r.png(file = '"%s"'%name )
  r.plot(guess_lst,time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
  name = 'simulation_plots/exh_scatterplot_guess_vs_backtrack_' + str(m) + '.png'
  mtitle='Exhaustive search\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Number of backtrack '
  xlabel='Number of guesses'
  r.png(file = '"%s"'%name )
  r.plot(guess_lst,bcktrk_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
  name = 'simulation_plots/exh_scatterplot_backtrack_vs_time_' + str(m) + '.png'
  mtitle='Exhaustive search\n Size: '+str(2*m)+' x '+str(2*m)
  ylabel='Computation time'
  xlabel='Number of backtrack '
  r.png(file = '"%s"'%name )
  r.plot(bcktrk_lst,time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
  r.dev_off()
# scatter plot ratio of blanks vs time
# scatter plot ratio of blanks vs guesses
# scatter plot ratio of blanks vs backtrack
blnk_ratio_lst = [blnk/(2*m1)^2 for m1 in list_m for blnk in [2..(2*m1)^2 ] for i in xrange(len(exh[m1,blnk,'time'])) ]
time_lst   = flatten([exh[m1, blnk, 'time'] for m1 in list_m for blnk in [2..(2*m1)^2] ])
guess_lst   = flatten([exh[m1, blnk, 'guess'] for m1 in list_m for blnk in [2..(2*m1)^2] ])
bktrk_lst   = flatten([exh[m1, blnk, 'bcktrk'] for m1 in list_m for blnk in [2..(2*m1)^2] ])

name = 'simulation_plots/exh_scatterplot_blank_ratio_vs_time_' + '.png'
mtitle='Exhaustive search '
ylabel='Computation time (sec)'
xlabel='Ratio of blanks '
r.png(file = '"%s"'%name )
r.plot(blnk_ratio_lst,time_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
r.dev_off()

name = 'simulation_plots/exh_scatterplot_blank_ratio_vs_guess_' + '.png'
mtitle='Exhaustive search'
ylabel='Number of guesses'
xlabel='Ratio of blanks '
r.png(file = '"%s"'%name )
r.plot(blnk_ratio_lst,guess_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
r.dev_off()

name = 'simulation_plots/exh_scatterplot_blank_ratio_vs_backtrack_' + '.png'
mtitle='Exhaustive search'
ylabel='Number of backtrack'
xlabel='Ratio of blanks '
r.png(file = '"%s"'%name )
r.plot(blnk_ratio_lst,bktrk_lst, main='"%s"'%mtitle, ylab='"%s"'%ylabel, xlab='"%s"'%xlabel)
r.dev_off()



#Chart (scatter plot) , listplot
#1. ratio of blanks vs time(pre and comp)
#2. ratio of blanks vs ratio of uniqueness
#   ratio of blanks vs guesses
#   ratio of blanks vs backtrack
#3. number of blanks vs time(pre and comp)
#4. number of blanks vs guesses
#5. number of blanks vs backtrack
#6. number of guess vs time(pre and comp)
#7. number of guess vs backtrack
#8. number of backtrack vs time(pre and comp)
#   spine plot/ stacked barchart of uniqueness
#9. boxplot of time(pre and comp)
#10.boxplot of backtrack
#11.boxplot of guesses

