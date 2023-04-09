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
#include <sstream>
#include <vector>
#include "ivs2-mathlib/ivs-math.hpp"

#define ERROR -1

using namespace std;

/**
 * @brief Function to calculate sample mean for standard deviation
 *
 * @param samples Vector of samples
 */
double sample_mean(vector<double> samples)
{
    double sum = 0;
    for (double value : samples)
    {
        sum = ivsm::add(sum, value);
    }

    return ivsm::divide(sum, samples.size());
}

/**
 * @brief Function to calculate standard deviation from input vector
 *
 * @param samples Vector of samples
 */
double std_deviation(vector<double> samples)
{
    double sm = sample_mean(samples);
    size_t N = samples.size();
    
    // calculate value to subtract from each sample in sum
    double expSm = ivsm::exponentiate(sm, 2); 
    double subVal = ivsm::multiply(expSm, N); 

    double sum = 0;
    double expVal;
    for (double value : samples)
    {
        expVal = ivsm::exponentiate(value, 2);
        sum = ivsm::add(sum, expVal);
    }

    double dividend = ivsm::subtract(sum, subVal);
    double divisor = ivsm::subtract(N, 1);
    double quotient = ivsm::divide(dividend, divisor);

    double result = ivsm::root(quotient, 2);

    return result;
}

/**
 * @brief Reads whitespace separated numbers from stdin and parses them
 *        to vector.
 * 
 * @param[out] out Vector to fill with numbers
 */
int read_input(vector<double> &out)
{
    string input;
    double value;
    char charCheck;
    // read whitespace separated input
    while(cin >> input)
    {
        // convert input string to double
        stringstream stream(input);
        stream >> value;

        // check if input contains a char
        if (stream.fail() || stream.get(charCheck))
        {
            stream.clear();
            return ERROR;
        }

        out.push_back(value);
    }

    return 0;
}


int main() 
{
    vector<double> samples;

    if (read_input(samples) == ERROR)
    {
        cerr << "ERROR: Invalid input" << endl;
        return 1;
    }

    if (samples.size() < 2)
    {
        cerr << "ERROR: At least 2 values must be provided" << endl;
        return 1;
    }

    // print standard deviation with 4 decimal places to stdout
    cout.precision(4);
    cout << fixed << std_deviation(samples) << endl;

    return 0;
}
