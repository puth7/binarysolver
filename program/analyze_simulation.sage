reset()
# table for different solver and different sizes
# table for the time variance for a particular solver
# table for the variance of the uniqueness puzzle vs number of blanks
# chart for the aggregated data
# stats:  mean, sdev, max, min

##Harversting the data

# # # SAT
# g = file('simulation_sat/statistics_sat.txt','w')
# g.write('size blank min_pre mean_pre max_pre stdev_pre min_com mean_com max_com stdev_com \n')
# for m in [2..6]:
#   sat={}
#   try:
#     f = file('simulation_sat/simulation_cnf_'+str(m)+'.txt','r')
#   except:
#     continue
#   for line in f:
#     if line.startswith('size'):
#       continue
#     line_list=line.split()
#     if (m,int(line_list[1]),'pre_time') in sat:
#       sat[m,int(line_list[1]),'pre_time'].append(float(line_list[2]))
#       sat[m,int(line_list[1]),'com_time'].append(float(line_list[3]))
#     else:
#       sat[m,int(line_list[1]),'pre_time'] = [float(line_list[2])]
#       sat[m,int(line_list[1]),'com_time'] = [float(line_list[3])]
#   f.close()
#   for blanks in [1..(2*m)^2]:
#     min_pre   = min(sat[m,blanks,'pre_time'])
#     mean_pre  = mean(sat[m,blanks,'pre_time']) 
#     max_pre   = max(sat[m,blanks,'pre_time'])
#     stdev_pre = std(sat[m,blanks,'pre_time'])
#     min_com   = min(sat[m,blanks,'com_time'])
#     mean_com  = mean(sat[m,blanks,'com_time'])
#     max_com   = max(sat[m,blanks,'com_time'])
#     stdev_com = std(sat[m,blanks,'com_time'])
#     g.write(str(m)+' '+str(blanks)+' '+str(min_pre)+' '+str(mean_pre)+' '+str(max_pre)+' '+str(stdev_pre)+' '+str(min_com)+' '+str(mean_com)+' '+str(max_com)+' '+str(stdev_com)+'\n')
# g.close()

# # SMT
# g = file('simulation_smt/statistics_smt.txt','w')
# g.write('size blank min_pre mean_pre max_pre stdev_pre min_com mean_com max_com stdev_com \n')
# for m in [2..22]:
#   smt={}
#   try:
#     f = file('simulation_smt/simulation_smt_bv_time_'+str(m)+'.txt','r')
#   except:
#     continue
#   for line in f:
#     if line.startswith('size'):
#       continue
#     line_list=line.split()
#     if (m,int(line_list[1]),'pre_time') in smt:
#       smt[m,int(line_list[1]),'pre_time'].append(float(line_list[2]))
#       smt[m,int(line_list[1]),'com_time'].append(float(line_list[3]))
#     else:
#       smt[m,int(line_list[1]),'pre_time'] = [float(line_list[2])]
#       smt[m,int(line_list[1]),'com_time'] = [float(line_list[3])]
#   f.close()
#   for blanks in [1..(2*m)^2]:
#     min_pre   = min(smt[m,blanks,'pre_time'])
#     mean_pre  = mean(smt[m,blanks,'pre_time']) 
#     max_pre   = max(smt[m,blanks,'pre_time'])
#     stdev_pre = std(smt[m,blanks,'pre_time'])
#     min_com   = min(smt[m,blanks,'com_time'])
#     mean_com  = mean(smt[m,blanks,'com_time'])
#     max_com   = max(smt[m,blanks,'com_time'])
#     stdev_com = std(smt[m,blanks,'com_time'])
#     g.write(str(m)+' '+str(blanks)+' '+str(min_pre)+' '+str(mean_pre)+' '+str(max_pre)+' '+str(stdev_pre)+' '+str(min_com)+' '+str(mean_com)+' '+str(max_com)+' '+str(stdev_com)+'\n')
# g.close()

## Uniquness
# uniq={}
# for m in [2..19]:
#   try:
#     f = file('simulation_unique/simulation_smt_bv_unique_time_comput_'+str(m)+'.txt','r')
#   except:
#     continue
#   for line in f:
#     if line.startswith('size'):
#       continue
#     line_list=line.split()
#     if (m,int(line_list[1])) in uniq:
#       uniq[m,int(line_list[1])].append(line_list[3]=='sat')
#     else:
#       uniq[m,int(line_list[1])] = [line_list[3]=='sat']
#   f.close()
# #statistics
# g = file('simulation_unique/statistics_unique.txt','w')
# g.write('size blank nonuniqe unique blank_ratio unique_ratio\n')
# for key in sorted(uniq):
#   m = key[0]
#   blanks = key[1]
#   unique = uniq[key].count(False)
#   nonunique = uniq[key].count(True)
#   total = unique+nonunique
#   g.write(str(m)+' '+str(blanks)+' '+str(nonunique)+' '+str(unique)+' '+str(n(blanks/(2*m)^2))+' '+str(n(unique)/total)+'\n')
# g.close()
  
# # Exh
# g = file('simulation_exh/statistics_exh.txt','w')
# g.write('size blank min_com mean_com max_com stdev_com min_gues mean_gues max_gues stdev_gues min_bctrk mean_bctrk max_bctrk stdev_bctrk  \n')
# for m in [2..8]:
#   exh={}
#   try:
#     f = file('simulation_exh/simulation_exh_'+str(m)+'.txt','r')
#   except:
#     continue
#   for line in f:
#     if line.startswith('size'):
#       continue
#     line_list=line.split()
#     if (m,int(line_list[1]),'time') in exh:
#       exh[m,int(line_list[1]),'time'].append(float(line_list[2]))
#       exh[m,int(line_list[1]),'guess'].append(int(line_list[3]))
#       exh[m,int(line_list[1]),'bcktrk'].append(int(line_list[4]))
#     else:
#       exh[m,int(line_list[1]),'time'] = [float(line_list[2])]
#       exh[m,int(line_list[1]),'guess'] = [int(line_list[3])]
#       exh[m,int(line_list[1]),'bcktrk'] = [int(line_list[4])]
#   f.close()
#   for blanks in [1..(2*m)^2]:
#     try:
#       min_com    = min(exh[m,blanks,'time'])
#       mean_com   = mean(exh[m,blanks,'time'])
#       max_com    = max(exh[m,blanks,'time'])
#       stdev_com  = std(exh[m,blanks,'time'])
#       min_gues   = min(exh[m,blanks,'guess'])
#       mean_gues  = mean(exh[m,blanks,'guess']).n()
#       max_gues   = max(exh[m,blanks,'guess'])
#       stdev_gues = std(exh[m,blanks,'guess']).n()
#       min_bctrk  = min(exh[m,blanks,'bcktrk'])
#       mean_bctrk = mean(exh[m,blanks,'bcktrk']).n() 
#       max_bctrk  = max(exh[m,blanks,'bcktrk'])
#       stdev_bctrk= std(exh[m,blanks,'bcktrk']).n()
#     except:
#       continue
#     g.write(str(m)+' '+str(blanks)+' '+str(min_com)+' '+str(mean_com)+' '+str(max_com)+' '+str(stdev_com)+' '+str(min_gues)+' '+str(mean_gues)+' '+str(max_gues)+' '+str(stdev_gues)+' '+str(min_bctrk)+' '+str(mean_bctrk)+' '+str(max_bctrk)+' '+str(stdev_bctrk)+'\n')
# g.close()


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
#9. boxplot of time(pre and comp)
#10.boxplot of backtrack
#11.boxplot of guesses
