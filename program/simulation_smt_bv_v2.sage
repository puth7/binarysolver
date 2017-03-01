reset()
load('binario_smt_bv.sage')
load('binario_exh.sage')
import timeit
import subprocess
#also measure precomputation
#load file

#also measure precomputation
#load file
database_binario = {}
var_list = ['x_'+str(i) for i in [1..6]]
for m in [2..48]:
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
        database_binario[m,int(z[2])]=matrix([binario_str[int(z[2]),i] for i in xrange(2*m)])


try:
    os.mkdir('simulation_smt')
except Exception:
    pass

for m in [20..50]:
    filename='simulation_smt/simulation_smt_v2_'+str(m)+'.txt'
    g1 = file(filename, 'w')
    g1.write('size  type blanks  precomp  comp_time  status\n')
    g1.close()
    for blanks in [1..(2*m)^2]:
        for l in [1..6]:
            for i in xrange(3):
                tic = timeit.default_timer()
                f =  file('simulation_smt/binario_smt_bv_temp.ys','w')
                A = database_binario[m,l]
                location_index = cartesian_product([Set(xrange((2*m))), Set(xrange((2*m)))])
                set_of_blank_cell = Subsets(location_index,blanks)
                index_of_blank_cell = set_of_blank_cell.random_element()
                for i in index_of_blank_cell:
                    A[i[0],i[1]] = 9
                variable(m,f)
                cell_constraint(m,f)
                first_constraint(m, f)
                second_constraint(m, f)
                third_constraint(m, f)
                filled_cells(A, f)
                f.write('(check) \n')
                f.close()
                toc1 = timeit.default_timer() - tic
                ###
                tic = timeit.default_timer()
                status = subprocess.check_output('yices simulation_smt/binario_smt_bv_temp.ys', shell = True)
                toc2 = timeit.default_timer() - tic
                g1 = file(filename,'a')
                g1.write(str(m) + ' '+str(l)+' ' + str(blanks) + ' ' + str(toc1)+' '+ str(toc2)+' '+str(status) )
                g1.close()
                print m, l,blanks, toc1, toc2, status.strip()


