/*************************************************
 * Project name: ivs2-profiler
 * Date:         2023-04-09
 *************************************************/
/**
 * @file profiler.cpp
 *
 * @author Zdeněk Borovec <xborov08@vutbr.cz>
 * @author Tomáš Krejčí <xkrejc84@vutbr.cz>
 * @author Jan Lozrt <xlozrt00@vutbr.cz>
 * @author Jakub Mitrenga <xmitre07@vutbr.cz>
 *
 * @brief Profiler for testing the performance of our ivs2-mathlib math library
 */

#include <cstddef>
#include <iostream>
#include "ivs2-mathlib/ivs-math.hpp"

using namespace std;

int main() {
    double res = ivsm::add(2, 3);
    cout << res << endl;
    return 0;
}
