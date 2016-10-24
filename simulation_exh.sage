reset()
load("binario_exh.sage")

#Generate random puzzle ( not need to have unique solution)
print '\n';
database_binario = load('puzzle_database/binario_database_mat.sobj')
# database diambil dari binario_database_mat. load dari file

for m in [2..2]:
    filename = 'simulation_exh/simulation_exh_temp' + str(m) + '.txt'
    f=file(filename, 'w')
    f.write('size  blanks  time  guess  backtrack\n')
    f.close()
    for blanks in [1..(2*m)^2]:
        for i in xrange(30):
            Z0 = binario_chooser(database_binario, m, blanks)
            tic = timeit.default_timer()
            [A1, num_guess, num_backtrack] = (solvepuzzle(Z0))
            print Z0,'---',A1
            toc_exh_c = timeit.default_timer() - tic;
            print 2*m, 'x', 2*m, '|blanks: ', blanks, '| comp exh : ', toc_exh_c, ' guess:', num_guess, ' backtrack:', num_backtrack, type(A1)
            f=file(filename,'a')
            f.write(str(2*m) + '  ' + str(blanks) + '  ' + str(toc_exh_c) + '  '+str(num_guess) + '  ' + str(num_backtrack)+' '+str(Z0)+' '+str(A1) + '\n')
            f.close()
    print '------------------------------------------'

# remark:
#  in some cases, the running time is very long ( number of guesses and number of backtrack are very big). solution: give time limit

# add some statistics to the result

# [1 1 9 9]
# [9 9 1 9]
# [9 9 0 9]
# [9 0 1 9]
# ---
# [1 1 0 0]
# [1 0 1 0]
# [0 1 0 1]
# [0 0 1 1]

# 4 x 4 |blanks:  10 | comp exh :  0.0582370758057  guess: 2  backtrack: 1
