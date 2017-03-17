reset()
load("binario_exh.sage")
load("binario_sat_cnf_tseytin.sage")
print '\n'

#input random puzzle
database_binario = load('../input/puzzle_database_v2/binario_database_mat_v2.sobj')
try:
    os.mkdir('../output/simulation_sat')
except Exception:
    pass

for m in [2..3]:
    filename='../output/simulation_sat/simulation_cnf_v2_tse_'+str(m)+'.txt'
    f = file(filename, 'w')
    f.write('size type  blanks  precomp  comp_time  postcomp\n')
    f.close()
    for blanks in  [1..(2*m)^2]:
        for l in [1..6]:
            for i in xrange(3):
                Z0 = database_binario[m,l]
                location_index = cartesian_product([Set(xrange((2*m))), Set(xrange((2*m)))])
                set_of_blank_cell = Subsets(location_index,blanks)
                index_of_blank_cell = set_of_blank_cell.random_element()
                for i in index_of_blank_cell:
                    Z0[i[0],i[1]] = 9
                ### SATsolver
                tic =timeit.default_timer()
                #generate
                binario_cnf_sat = binario_generate_cnf(m,Z0)
                toc_sat_p = timeit.default_timer()-tic;
                ##solver:
                tic = timeit.default_timer()
                solver = SAT(solver="cryptominisat")
                for clause in binario_cnf_sat:
                    solver.add_clause(tuple(clause))
                toc_sat_c = timeit.default_timer()-tic;
                #postcomputation:
                tic = timeit.default_timer()
                solution = [];
                for i in solver()[1:]:
                    if i == True:
                        solution.append(1)
                    elif i == False:
                        solution.append(0)
                solution = matrix(GF(2),2*m,solution[0:(2*m)^2])
                toc_sat_a = timeit.default_timer()-tic;
                print m,'type:',l, 'blank:',blanks,'|',toc_sat_p,toc_sat_c, toc_sat_a
                f = file(filename, 'a')
                f.write(str(m) + ' ' +str(l)+' '+ str(blanks) + ' ' + str(toc_sat_p) + ' ' + str(toc_sat_c)+' '+str(toc_sat_a)+'\n')
                f.close()
                print '------------------------------------------'



