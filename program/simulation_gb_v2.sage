reset()
load("binario_exh.sage")
load("binario_gb.sage")
print '\n'

#input random puzzle
database_binario = load('puzzle_database_v2/binario_database_mat_v2.sobj')
try:
    os.mkdir('simulation_gb')
except Exception:
    pass

for m in [2..6]:
    filename='simulation_gb/simulation_gb_v2_'+str(m)+'.txt'
    f = file(filename, 'w')
    f.write('size type  blanks  precomp  comp_time status\n')
    f.close()
    for blanks in  [1..(2*m)^2]:
        for l in [1..6]:
            for i in xrange(7):
                Z0 = database_binario[m,l]
                location_index = cartesian_product([Set(xrange((2*m))), Set(xrange((2*m)))])
                set_of_blank_cell = Subsets(location_index,blanks)
                index_of_blank_cell = set_of_blank_cell.random_element()
                for i in index_of_blank_cell:
                    Z0[i[0],i[1]] = 9
                # ### GBsolver
                #precomputation
                tic = timeit.default_timer()
                n = 2*m
                M = {}
                for i in xrange(n):
                    for j in xrange(n):
                        if Z0[i,j] != 9:
                            M[i,j] = Z0[i,j]
                F = binpuzzle2mpolynomials(n, M)
                toc_gb_p = timeit.default_timer()-tic;
                # ##solver:
                tic = timeit.default_timer()
                try:
                    G = F.groebner_basis()
                    stat = 'Y'
                except (RuntimeError) :
                    stat = 'N'
                    pass
                toc_gb_c = timeit.default_timer()-tic;
                print m,'type:',l, 'blank:',blanks,'|',toc_gb_p,toc_gb_c , stat
                f = file(filename, 'a')
                f.write(str(m) + ' ' +str(l)+' '+ str(blanks) + ' ' + str(toc_gb_p) + ' ' + str(toc_gb_c)+' '+stat+'\n')
                f.close()
                print '------------------------------------------'



