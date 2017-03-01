reset()
import subprocess
load('binario_smt_bv_v2.sage')
binario_database_mat = {}# load('puzzle_database_v2/binario_database_mat_v2') # load database from file. otherwise, = {}

try:
    os.mkdir('puzzle_database_v2')
except Exception:
    pass
 
var_list = ['x_'+str(i) for i in [1..6]]
for m in [46..57]:
  f = file('puzzle_database_v2/binario_smt_bv_temp.ys','w')
  for z in var_list:
    variable(m,f,z)
    cell_constraint(m,f,z)
    first_constraint(m,f,z)
    second_constraint(m,f,z)
    third_constraint(m,f,z)
  distinct_result_v2(m,f,var_list)  
  f.write('(check) \n')
  f.write('(show-model) \n')
  f.close()
  #running the solver (yices)
  subprocess.call('yices puzzle_database_v2/binario_smt_bv_temp.ys > puzzle_database_v2/binario_solved_'+str(m)+'.txt',shell=True)
  #this is for reading the puzzle from SMT_bv result:  #done for sizes <= 57.
  binario_str={}
  g = file('puzzle_database_v2/binario_solved_'+str(m)+'.txt','r')
  for line in g:
    l = len(line)
    if line[0] != '('  or line[7:10] !='row': #flush 1st line
      continue
    typ = line[5:6];
    seq = line[-2*m-2:-2];
    idx = line[11:11+l-1-4-11-2*m];
    binario_str[int(typ),int(idx)]=map(int,list(seq))
  g.close()
  for z in var_list:
    binario_database_mat[m,int(z[2])]=matrix([binario_str[int(z[2]),i] for i in xrange(2*m)])
  save(binario_database_mat,'puzzle_database_v2/binario_database_mat_v2')
  




