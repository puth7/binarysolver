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



from multiprocessing import Process
from time import sleep

def f(time):
    sleep(time)


def run_with_limited_time(func, args, kwargs, time):
    """Runs a function with time limit

    :param func: The function to run
    :param args: The functions args, given as tuple
    :param kwargs: The functions keywords, given as dict
    :param time: The time limit in seconds
    :return: True if the function ended successfully. False if it was terminated.
    """
    p = Process(target=func, args=args, kwargs=kwargs)
    p.start()
    p.join(time)
    if p.is_alive():
        p.terminate()
        return False

    return True


from multiprocessing import Process
from time import sleep

def f(n):
    return factor(n)


def run_with_limited_time(func, args, kwargs, time):
    """Runs a function with time limit

    :param func: The function to run
    :param args: The functions args, given as tuple
    :param kwargs: The functions keywords, given as dict
    :param time: The time limit in seconds
    :return: True if the function ended successfully. False if it was terminated.
    """
    p = Process(target=func, args=args, kwargs=kwargs)
    p.start()
    p.join(time)
    if p.is_alive():
        p.terminate()
        return False

    return True


print run_with_limited_time(f, (954313153843, ), {}, 2.5)




for m in [2..50]:
    filename='simulation_gb/simulation_gb_v2_'+str(m)+'.txt'
    f = file(filename, 'w')
    f.write('size type  blanks  precomp  comp_time status\n')
    f.close()
    for blanks in  [round(0.75*(2*m)^2)]:
        for l in [1..6]:
            for i in xrange(3):
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
                run_with_limited_time(F.groebner_basis(), ( ), {}, 2.5)
                toc_gb_c = timeit.default_timer()-tic;
                print m,'type:',l, 'blank:',blanks,'|',toc_gb_p,toc_gb_c , stat
                f = file(filename, 'a')
                f.write(str(m) + ' ' +str(l)+' '+ str(blanks) + ' ' + str(toc_gb_p) + ' ' + str(toc_gb_c)+' '+stat+'\n')
                f.close()
                print '------------------------------------------'



