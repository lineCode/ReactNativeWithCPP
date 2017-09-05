#pragma once

#include "hello_world.hpp"
#include <string>


class HelloWorldImpl : public HelloWorld {

public:

    // Constructor
    HelloWorldImpl();

    // Our method that returns a string
    std::string get_hello_world();

};
