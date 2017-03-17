reset()
load("binario_exh.sage")

#Generate random puzzle ( not need to have unique solution)
print '\n';
database_binario = load('../input/puzzle_database_v2/binario_database_mat_v2.sobj')
# database diambil dari binario_database_mat. load dari file

try:
    os.mkdir('../output/simulation_exh')
except Exception:
    pass

for m in [2..3]:
    filename = '../output/simulation_exh/simulation_exh_v2_allblnk_' + str(m) + '.txt'
    f=file(filename, 'w')
    f.write('size  blanks  time  guess  backtrack\n')
    f.close()
    for blanks in [1..(2*m)^2]:
        for l in [1..6]:
            for i in xrange(3):
                Z0 = database_binario[m,l]
                location_index = cartesian_product([Set(xrange((2*m))), Set(xrange((2*m)))])
                set_of_blank_cell = Subsets(location_index,blanks)
                index_of_blank_cell = set_of_blank_cell.random_element()
                for i in index_of_blank_cell:
                    Z0[i[0],i[1]] = 9
                tic = timeit.default_timer()
                [A1, num_guess, num_backtrack] = (solvepuzzle(Z0))
                #print index_of_blank_cell
                toc_exh_c = timeit.default_timer() - tic;
                print 'm: ', m, '|blanks: ', blanks, '| comp exh : ', toc_exh_c, ' guess:', num_guess, ' backtrack:', num_backtrack, type(A1)
                f=file(filename,'a')
                f.write(str(m) + '  ' + str(blanks) + '  ' + str(toc_exh_c) + '  '+str(num_guess) + '  ' + str(num_backtrack) + '\n')
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
