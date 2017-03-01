reset()
load("binario_exh.sage")
load("binario_sat_cnf.sage")
print '\n'

#input random puzzle
database_binario = load('puzzle_database/binario_database_mat.sobj')

for m in [2..50]:
    f = file('simulation_sat/simulation_cnf_'+str(m)+'.txt', 'w')
    f.write('size  blanks  precomp  comp_time  postcomp\n')
    f.close()
    for blanks in  [1..(2*m)^2]:
        for i in xrange(30):
            Z0 = binario_chooser(database_binario, m , blanks)
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
            solution = matrix(GF(2),2*m,solution)
            toc_sat_a = timeit.default_timer()-tic;
            print 2*m, 'blank:',blanks,'|',toc_sat_p,toc_sat_c, toc_sat_a
            f = file('simulation_sat/simulation_cnf_'+str(m)+'.txt', 'a')
            f.write(str(m) + ' ' + str(blanks) + ' ' + str(toc_sat_p) + ' ' + str(toc_sat_c)+' '+str(toc_sat_a)+'\n')
            f.close()
            print '------------------------------------------'



