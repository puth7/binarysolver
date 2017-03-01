reset()
import subprocess
load('binario_smt_bv.sage')
binario_database_mat=load('puzzle_database/binario_database_mat') # load database from file. otherwise, = {}

for m in [2..57]:
  f = file('puzzle_database/binario_smt_bv_temp.ys','w')
  variable(m,f)
  cell_constraint(m,f)
  first_constraint(m,f)
  second_constraint(m,f)
  third_constraint(m,f)
  f.write('(check) \n')
  f.write('(show-model) \n')
  f.close()
  #running the solver (yices)
  subprocess.call('yices puzzle_database/binario_smt_bv_temp.ys > puzzle_database/binario_solved_smt_bv_'+str(m)+'.txt',shell=True)
  #this is for reading the puzzle from SMT_bv result:  #done for sizes <= 57.
  binario_str={}
  g = file('puzzle_database/binario_solved_smt_bv_'+str(m)+'.txt','r')
  for line in g:
    l = len(line)
    if line[0] == 's': #flush 1st line
      continue
    typ = line[3:6];
    seq = line[-2*m-2:-2];
    idx = line[7:7+l-12-2*m];
    binario_str[typ,int(idx)]=map(int,list(seq))
  g.close()
  binario_database_mat[m,0]=matrix([binario_str['row',i] for i in xrange(2*m)])
  binario_database_mat[m,1]=matrix([binario_str['col',i] for i in xrange(2*m)])
  save(binario_database_mat,'binario_database_mat')
  print binario_str



#######################################################
# OLD
#######################################################
# f=file('puzzle_database/solved_puzzle_exh.txt','r')
# data_mat = {};temp_mat=[]; k=0
# for line in f:
#   l = len(line)
#   if l > 4:
#     m = (l-2)/4
#     temp_mat.append(eval(line.replace(' ',',')))
#   else:
#     data_mat[k]=[m,temp_mat]
#     k +=1
#     temp_mat=[]
# f.close()

# for key in data_mat:
#   m = data_mat[key][0]
#   mat = data_mat[key][1]
#   k = 0
#   while (m,k) in binario_database_mat :
#     k += 1
#   binario_database_mat[m,k ] = matrix(mat) 

  
# for i in binario_database_mat:           
#   print i,  type(binario_database_mat[i]), 
  
# #print data_mat

# #partially solved puzzle
# B4=matrix([[9,9,9,9], [9,0,0,9], [9,0,9,9], [9,9,1,9]])
# B6=matrix([[9,9,1,9,9,9], [0,0,9,1,9,9], [0,9,9,9,9,9], [9,9,9,9,9,9], [9,9,9,1,9,9], [9,9,9,9,0,9]]) # unique solution
# B8=matrix([[9,0,9,9,9,9,9,9], [9,9,9,1,9,1,9,9], [9,9,0,9,9,9,9,9], [9,1,9,9,9,9,9,9], [9,9,9,9,1,9,9,9], [9,0,9,9,9,1,9,9], [9,0,9,9,0,9,9,9], [9,9,9,9,0,9,0,9]])
# B8_2=matrix([[9,0,9,9,9,9,9,9], [9,9,9,1,9,1,9,0],  [9,9,0,9,9,9,9,9], [9,1,9,9,9,9,9,9], [9,9,9,9,1,9,9,9], [9,0,9,9,9,1,9,9], [9,0,9,9,0,9,9,9], [9,9,9,9,0,9,0,9]])
# B8_3=matrix([[9,9,9,9,9,9,9,0], [9,0,0,9,9,1,9,9],  [9,0,9,9,9,1,9,0], [9,9,1,9,9,9,9,9], [0,0,9,1,9,9,1,9], [9,9,9,9,1,9,9,9], [1,1,9,9,9,0,9,1], [9,1,9,9,9,9,9,1]]) 
# B8_4=matrix([[9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9],  [9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9]])# multiple solution, blank puzzle 
# B10=matrix([[9,1,9,1,9,9,9,9,1,9], [0,9,0,9,9,9,9,9,9,9], [9,9,9,9,9,9,1,1,9,9], [9,9,1,9,9,9,9,9,9,9], [0,9,9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,0,0,9], [1,9,9,9,9,9,9,1,9,1], [9,9,0,9,9,9,0,9,9,9], [9,9,9,9,9,9,0,9,1,9], [9,9,9,9,0,9,9,0,9,9]]) 
# B12=matrix([[9,9,9,9,9,9,9,0,0,9,1,9], [9,9,1,9,9,9,9,9,9,9,1,9], [9,9,9,0,9,0,9,9,0,9,9,0], [9,9,9,9,9,0,9,9,9,9,9,9], [9,1,1,9,1,9,9,1,9,0,9,9], [9,1,1,9,0,9,0,0,9,9,9,9], [9,9,9,9,9,9,9,9,9,9,1,9], [1,9,9,0,0,9,9,9,0,9,9,9], [9,9,9,9,9,9,9,9,9,9,9,9], [9,9,1,9,9,9,9,9,1,9,9,9], [9,9,9,0,9,9,0,9,9,0,9,0], [9,9,1,0,9,9,9,0,9,9,9,9]]) # unique solution 
# B14=matrix([[9,9,9,9,1,0,9,9,9,9,9,9,9,1], [1,9,9,9,9,0,9,9,9,1,9,1,9,1], [9,9,1,9,9,9,1,9,9,9,9,9,9,9], [0,9,9,9,9,1,1,9,9,9,9,0,9,1], [0,9,0,9,9,9,9,9,1,9,9,9,9,1], [9,0,9,9,9,9,9,9,0,9,9,9,9,9], [9,9,1,9,9,9,9,9,9,1,9,9,1,9], [9,9,1,9,0,9,9,1,9,9,0,9,9,9], [9,9,9,9,9,1,9,1,9,9,9,9,1,9], [0,9,1,0,9,1,9,9,9,9,0,9,9,9], [9,9,1,9,9,9,9,9,9,9,0,0,9,9], [9,9,9,0,9,9,9,9,9,9,9,9,9,9], [9,1,9,9,9,9,9,9,9,0,9,9,9,9], [9,9,0,9,9,9,0,9,9,9,9,0,9,9]])
# #unsolveable puzzle:
# U6=matrix([[9,1,0,9,1,0],[1,0,1,0,1,0], [0,1,0,1,0,1], [9,0,1,9,0,1], [1,0,1,0,1,0], [0,1,0,1,0,1]])
# U10=matrix([[9,9,9,9,9,9,9,9,9,9],[9,9,9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9,9,9], [9,0,9,0,9,1,0,1,0,1], [1,9,9,9,1,9,9,9,9,9], [9,0,9,1,9,0,9,1,9,9], [9,9,9,9,0,9,9,9,0,9], [1,0,1,0,9,1,9,1,9,0], [9,9,9,9,9,9,9,9,9,9]]) 
# U10_b=matrix([[9,9,9,9,9,9,9,9,9,9], [9,0,9,0,9,1,0,1,0,1], [1,9,9,9,1,9,9,9,9,9], [9,0,9,1,9,0,9,1,9,9], [9,9,9,9,0,9,9,9,0,9], [1,0,1,0,9,1,9,1,9,0], [9,9,9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9,9,9], [9,9,9,9,9,9,9,9,9,9]]) 

