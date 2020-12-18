cmake_minimum_required( VERSION 3.0 )
project( myapp LANGUAGES CXX )
add_executable( myapp main.cpp )
target_link_libraries( myapp )
install( TARGETS myapp DESTINATION bin )
set_property(TARGET myapp PROPERTY CXX_STANDARD 14)

# https://pytorch.org/tutorials/advanced/cpp_frontend.html

