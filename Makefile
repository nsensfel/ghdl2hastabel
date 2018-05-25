## Parameters ##################################################################
SRC_DIR ?= ${CURDIR}/src/
BIN_DIR ?= ${CURDIR}/bin/
LIB_DIR ?= ${CURDIR}/lib/

TARGET ?= ghdl2hastabel.jar
INSTALL_DIR ?= $(LIB_DIR)

#### Where to get the missing Jar files.
JAR_SOURCE ?= "https://noot-noot.org/tabellion/jar/"

#### Binaries
###### JAR binary
JAR ?= jar

###### JRE binary
JAVA ?= java

###### JDK binary
JAVAC ?= javac

##### Downloader
DOWNLOADER ?= wget

## Parameters Sanity Check #####################################################
ifeq ($(strip $(JAVA)),)
$(error No Java executable defined as parameter.)
endif

ifeq ($(strip $(JAVAC)),)
$(error No Java compiler defined as parameter.)
endif

## Java Config #################################################################
CLASSPATH = "$(SRC_DIR):$(BIN_DIR)"

## Makefile Magic ##############################################################
JAVA_SOURCES = \
	$(wildcard $(SRC_DIR)/ghdl2hastabel/*.java) \
	$(wildcard $(SRC_DIR)/ghdl2hastabel/*/*.java)
CLASSES = $(patsubst $(SRC_DIR)/%,$(BIN_DIR)/%, $(JAVA_SOURCES:.java=.class))

## Makefile Rules ##############################################################
$(TARGET): $(JAVA_SOURCES) $(CLASSES)
	$(MAKE) $(LIB_DIR)
	rm -f $(TARGET) $(INSTALL_DIR)/$@
	$(JAR) cf $@ -C $(BIN_DIR) .
	cp $@ $(INSTALL_DIR)/$@

clean:
	rm -rf $(BIN_DIR)/*
	rm -f $(TARGET)

$(CLASSES): $(BIN_DIR)/%.class: $(SRC_DIR)/%.java $(BIN_DIR)
	$(JAVAC) -cp $(CLASSPATH) -d $(BIN_DIR) $<

%.jar:
	$(MAKE) $(LIB_DIR)
	echo "Attempting to download missing jar '$@'..."
	cd $(LIB_DIR); $(DOWNLOADER) "$(JAR_SOURCE)/$(notdir $@)"

$(LIB_DIR):
	mkdir -p $@

$(BIN_DIR):
	mkdir -p $@

##### For my private use...
publish: $(TARGET)
	scp $< dreamhost:~/noot-noot/tabellion/jar/
