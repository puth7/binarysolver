reset()
load('binario_smt_bv.sage')
load('binario_exh.sage')
import timeit
import subprocess
#also measure precomputation
#load file

#also measure precomputation
#load file
database_binario = load('puzzle_database/binario_database_mat.sobj')

try:
    os.mkdir('simulation_smt')
except Exception:
    pass

for m in [2..2]:
    filename = 'simulation_smt/simulation_smt_bv_time_test_'+str(m)+'.txt'
    g1 = file(filename, 'w')
    g1.write('size  blanks  precomp  comp_time  status\n')
    g1.close()
    for blanks in [1..(2*m)^2]:
        for i in xrange(30):
            tic = timeit.default_timer()
            f =  file('simulation_smt/binario_smt_bv_temp.ys','w')
            A =  binario_chooser(database_binario, m, blanks)
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
            g1.write(str(m) + ' ' + str(blanks) + ' ' + str(toc1)+' '+ str(toc2)+' '+str(status) )
            g1.close()
            print m, blanks, toc1, toc2, status.strip()


