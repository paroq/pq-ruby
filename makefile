include $(PQ_FACTORY)/factory.mk

pq_part_name := ruby-2.2.1
pq_part_file := $(pq_part_name).tar.gz

pq_ruby_configuration_flags += --prefix=$(part_dir)
pq_ruby_configuration_flags += --with-openssl-include=$(pq-openssl-dir)/include
pq_ruby_configuration_flags += --with-openssl-lib=$(pq-openssl-dir)/lib

CFLAGS += -fPIC
CPPFLAGS += -fPIC

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) install
	cp $(source_dir)/libexec/instance_setup.sh $(stage_dir)/$(part_dir)/libexec
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && ./configure $(pq_ruby_configuration_flags)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
