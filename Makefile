CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17
LDFLAGS = -lstdc++fs -mconsole

SRC_DIR = src
LIB_DIR = lib
OBJ_DIR = obj
BIN_DIR = bin

SRCS = $(wildcard $(SRC_DIR)/**/*.cpp) $(wildcard $(LIB_DIR)/**/*.cpp)
OBJS = $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
OBJS := $(OBJS:$(LIB_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# Exclude beauty_print.cpp from SRCS to avoid multiple definitions
SRCS := $(filter-out $(LIB_DIR)/beauty_print.cpp, $(SRCS))
OBJS := $(filter-out $(OBJ_DIR)/beauty_print.o, $(OBJS))

MAIN_OBJ = $(OBJ_DIR)/installer.o
TARGET = $(BIN_DIR)/installer

all: $(TARGET)

$(TARGET): $(MAIN_OBJ) $(OBJS) $(OBJ_DIR)/beauty_print.o
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $(MAIN_OBJ) $(OBJS) $(OBJ_DIR)/beauty_print.o -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(LIB_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR)/beauty_print.o: $(LIB_DIR)/beauty_print.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

.PHONY: all clean