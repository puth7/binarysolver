reset()
load('binario_smt_bv_v2.sage')
load('binario_exh.sage')
import subprocess
#also measure precomputation
#load file

#also measure precomputation
#load file
database_binario = load('puzzle_database/binario_database_mat.sobj')

try:
    os.mkdir('simulation_unique')
except Exception:
    pass

for m in [21..50]:               
    g1 = file('simulation_unique/simulation_smt_bv_unique_time_comput_'+str(m)+'.txt', 'w')
    g1.write('size  blanks  time  status\n')
    g1.close()
    g2 = file('simulation_unique/simulation_smt_bv_unique_time_precomput_'+ str(m)+'.txt', 'w')
    g2.write('size  blanks  time\n')
    g2.close()
    for blanks in [1..(2*m)^2]:
        for i in xrange(30):
            tic = timeit.default_timer()
            f =  file('simulation_unique/binario_smt_bv_unique_temp.ys','w')
            A =  binario_chooser(database_binario, m, blanks)
            variable(m,f,'x')
            variable(m,f,'y')    
            cell_constraint(m,f,'x')
            cell_constraint(m,f,'y')
            first_constraint(m, f, 'x')
            first_constraint(m, f, 'y')
            second_constraint(m, f, 'x')
            second_constraint(m, f, 'y')
            third_constraint(m, f, 'x')
            third_constraint(m, f, 'y')
            distinct_result(m, f, 'x', 'y')
            filled_cells(A, f, 'x')
            filled_cells(A, f, 'y')
            f.write('(check) \n')
            f.close()
            toc1 = timeit.default_timer() - tic
            g2 = file('simulation_unique/simulation_smt_bv_unique_time_precomput_'+str(m)+'.txt','a')
            g2.write(str(m) + ' ' + str(blanks) + ' ' + str(toc1) + '\n')
            g2.close()
            ###
            tic = timeit.default_timer()
            status = subprocess.check_output('yices simulation_unique/binario_smt_bv_unique_temp.ys', shell = True)
            toc2 = timeit.default_timer() - tic
            g1 = file('simulation_unique/simulation_smt_bv_unique_time_comput_' + str(m) +'.txt','a')
            g1.write(str(m) + ' ' + str(blanks) + ' ' + str(toc2) + ' ' + str(status))
            g1.close()
            print m, blanks, toc1, toc2, status.strip()


