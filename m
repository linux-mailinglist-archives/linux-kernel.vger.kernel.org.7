Return-Path: <linux-kernel+bounces-724702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776CAFF608
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBA1562C83
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7801C433A5;
	Thu, 10 Jul 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep8VuA+j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B51442E8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107697; cv=none; b=tmQ8ffXfv63dkT5U2NLx6qA1NfFIoVrA0YREJuNWgok/MAUYu9TkTylqiMb37Kai0sV+iN7JqhJS9/m5smGWiBh4X/OjM+UZC2AvD4wG4GlU1eT7JJ3unMz5JnTE5EbbydiYXssIU2cmuJC0FPVsHjqRP3KLVue3zzoLVQLgdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107697; c=relaxed/simple;
	bh=LQfrwZrWRYIqKVVIR3iO+TsksQaspGY3o5laAGrgm+M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Rb0AxkKN9ANiezMUbcXAqjE0ZV2Ht8Mss8xQ7nTB1w37wUgMk67A/FEjFmB/1hREHW/HYelDp1MA9Luef2ST0pYadQRd8PDHj8XUTd7SUBJNMiSGn2p9Fj5NT6c12ibqyzGL7YS4UD8TFb/2QJOCQuX/KtZPnXBU8mLcKL/X0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep8VuA+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAF5C4CEEF;
	Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107696;
	bh=LQfrwZrWRYIqKVVIR3iO+TsksQaspGY3o5laAGrgm+M=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Ep8VuA+jORm3sPl+r99s0hXZHIZpKS8F+qX0kiCr2T52gfxowuDoyUpasyZVwUoEO
	 mD8e7nSNho8rHh89YcwvuPlI2RwD9j+FeFJvH++HD4I4pMubML+c97M0sVowOnMYvp
	 FpFLV7Na7RXtRigks05DeDV8ro20qGNbMvN8Bw1qerhFPY2991PHnpDU8Z0V2+00I6
	 AeOoSLOpRHq+kPL0rF/+xo9BSl/WtorLCiN3Mxv1fN1mmKvFz8g1727up7mq7Mk4be
	 X05MSNbXQFg28JIMDWfvyuhY6odc8SO01tJ2FzTJr+QzTq3igwKlRGtO5QkzvKZlt9
	 lhzqU0KdCqHyw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfFd-00000001Wiv-1DKh;
	Wed, 09 Jul 2025 20:35:01 -0400
Message-ID: <20250710003501.140835955@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:34:44 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 7/9] verification/rvgen: Restructure the classes to prepare for LTL
 inclusion
References: <20250710003437.191509804@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Both container generation and DA monitor generation is implemented in the
class dot2k. That requires some ugly "if is_container ... else ...". If
linear temporal logic support is added at the current state, the "if else"
chain is longer and uglier.

Furthermore, container generation is irrevelant to .dot files. It is
therefore illogical to be implemented in class "dot2k".

Clean it up, restructure the dot2k class into the following class
hierarchy:

         (RVGenerator)
              /\
             /  \
            /    \
           /      \
          /        \
    (Container)  (Monitor)
                    /\
                   /  \
                  /    \
                 /      \
              (dot2k)  [ltl2k] <- intended

This allows a simple and clean integration of LTL.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/692137a581ba6bee7a64d37fb7173ae137c47bbd.1751634289.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rvgen/Makefile           |   2 +
 tools/verification/rvgen/__main__.py        |   6 +-
 tools/verification/rvgen/rvgen/container.py |  22 ++
 tools/verification/rvgen/rvgen/dot2k.py     | 275 ++------------------
 tools/verification/rvgen/rvgen/generator.py | 264 +++++++++++++++++++
 5 files changed, 308 insertions(+), 261 deletions(-)
 create mode 100644 tools/verification/rvgen/rvgen/container.py
 create mode 100644 tools/verification/rvgen/rvgen/generator.py

diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/Makefile
index 8d08825e7e54..cca8c9ba82e8 100644
--- a/tools/verification/rvgen/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -19,5 +19,7 @@ install:
 	$(INSTALL) rvgen/dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2c.py
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
 	$(INSTALL) rvgen/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2k.py
+	$(INSTALL) rvgen/container.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/container.py
+	$(INSTALL) rvgen/generator.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/generator.py
 	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
 	cp -rp rvgen/templates $(DESTDIR)$(PYLIB)/rvgen/
diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 994d320ad2d1..63ecf0c37034 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -10,6 +10,8 @@
 
 if __name__ == '__main__':
     from rvgen.dot2k import dot2k
+    from rvgen.generator import Monitor
+    from rvgen.container import Container
     import argparse
     import sys
 
@@ -29,7 +31,7 @@ if __name__ == '__main__':
                                 help="Monitor class, either \"da\" or \"ltl\"")
     monitor_parser.add_argument('-s', "--spec", dest="spec", help="Monitor specification file")
     monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type",
-                                help=f"Available options: {', '.join(dot2k.monitor_types.keys())}")
+                                help=f"Available options: {', '.join(Monitor.monitor_types.keys())}")
 
     container_parser = subparsers.add_parser("container")
     container_parser.add_argument('-n', "--model_name", dest="model_name", required=True)
@@ -47,7 +49,7 @@ if __name__ == '__main__':
                 print("Unknown monitor class:", params.monitor_class)
                 sys.exit(1)
         else:
-            monitor = dot2k(None, None, vars(params))
+            monitor = Container(vars(params))
     except Exception as e:
         print('Error: '+ str(e))
         print("Sorry : :-(")
diff --git a/tools/verification/rvgen/rvgen/container.py b/tools/verification/rvgen/rvgen/container.py
new file mode 100644
index 000000000000..47d8ab2ad3ec
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/container.py
@@ -0,0 +1,22 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+#
+# Generator for runtime verification monitor container
+
+from . import generator
+
+
+class Container(generator.RVGenerator):
+    template_dir = "container"
+
+    def __init__(self, extra_params={}):
+        super().__init__(extra_params)
+        self.name = extra_params.get("model_name")
+        self.main_h = self._read_template_file("main.h")
+
+    def fill_model_h(self):
+        main_h = self.main_h
+        main_h = main_h.replace("%%MODEL_NAME%%", self.name)
+        return main_h
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index a9ed97d0b224..ed0a3c901106 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -9,108 +9,21 @@
 #   Documentation/trace/rv/da_monitor_synthesis.rst
 
 from .dot2c import Dot2c
-import platform
-import os
+from .generator import Monitor
 
-class dot2k(Dot2c):
-    monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
-    rv_dir = "kernel/trace/rv"
-    monitor_type = "per_cpu"
 
-    def __init__(self, file_path, MonitorType, extra_params={}):
-        self.container = extra_params.get("subcmd") == "container"
-        self.parent = extra_params.get("parent")
-        if self.container:
-            self.abs_template_dir = os.path.join(os.path.dirname(__file__), "templates/container")
-        else:
-            self.abs_template_dir = os.path.join(os.path.dirname(__file__), "templates/dot2k")
-
-        if self.container:
-            if file_path:
-                raise ValueError("A container does not require a dot file")
-            if MonitorType:
-                raise ValueError("A container does not require a monitor type")
-            if self.parent:
-                raise ValueError("A container cannot have a parent")
-            self.name = extra_params.get("model_name")
-            self.events = []
-            self.states = []
-            self.main_h = self._read_template_file("main.h")
-        else:
-            super().__init__(file_path, extra_params.get("model_name"))
+class dot2k(Monitor, Dot2c):
+    template_dir = "dot2k"
 
-            self.monitor_type = self.monitor_types.get(MonitorType)
-            if self.monitor_type is None:
-                raise ValueError("Unknown monitor type: %s" % MonitorType)
-            self.monitor_type = MonitorType
-            self.trace_h = self._read_template_file("trace.h")
-
-        self.main_c = self._read_template_file("main.c")
-        self.kconfig = self._read_template_file("Kconfig")
+    def __init__(self, file_path, MonitorType, extra_params={}):
+        self.monitor_type = MonitorType
+        Monitor.__init__(self, extra_params)
+        Dot2c.__init__(self, file_path, extra_params.get("model_name"))
         self.enum_suffix = "_%s" % self.name
-        self.description = extra_params.get("description", self.name) or "auto-generated"
-        self.auto_patch = extra_params.get("auto_patch")
-        if self.auto_patch:
-            self.__fill_rv_kernel_dir()
-
-    def __fill_rv_kernel_dir(self):
-
-        # first try if we are running in the kernel tree root
-        if os.path.exists(self.rv_dir):
-            return
-
-        # offset if we are running inside the kernel tree from verification/dot2
-        kernel_path = os.path.join("../..", self.rv_dir)
-
-        if os.path.exists(kernel_path):
-            self.rv_dir = kernel_path
-            return
-
-        if platform.system() != "Linux":
-            raise OSError("I can only run on Linux.")
-
-        kernel_path = os.path.join("/lib/modules/%s/build" % platform.release(), self.rv_dir)
-
-        # if the current kernel is from a distro this may not be a full kernel tree
-        # verify that one of the files we are going to modify is available
-        if os.path.exists(os.path.join(kernel_path, "rv_trace.h")):
-            self.rv_dir = kernel_path
-            return
-
-        raise FileNotFoundError("Could not find the rv directory, do you have the kernel source installed?")
-
-    def __read_file(self, path):
-        try:
-            fd = open(path, 'r')
-        except OSError:
-            raise Exception("Cannot open the file: %s" % path)
-
-        content = fd.read()
-
-        fd.close()
-        return content
-
-    def _read_template_file(self, file):
-        try:
-            path = os.path.join(self.abs_template_dir, file)
-            return self.__read_file(path)
-        except Exception:
-            # Specific template file not found. Try the generic template file in the template/
-            # directory, which is one level up
-            path = os.path.join(self.abs_template_dir, "..", file)
-            return self.__read_file(path)
 
     def fill_monitor_type(self):
         return self.monitor_type.upper()
 
-    def fill_parent(self):
-        return "&rv_%s" % self.parent if self.parent else "NULL"
-
-    def fill_include_parent(self):
-        if self.parent:
-            return "#include <monitors/%s/%s.h>\n" % (self.parent, self.parent)
-        return ""
-
     def fill_tracepoint_handlers_skel(self):
         buff = []
         for event in self.events:
@@ -144,30 +57,6 @@ class dot2k(Dot2c):
             buff.append("\trv_detach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_%s);" % (self.name, event))
         return '\n'.join(buff)
 
-    def fill_main_c(self):
-        main_c = self.main_c
-        monitor_type = self.fill_monitor_type()
-        min_type = self.get_minimun_type()
-        nr_events = len(self.events)
-        tracepoint_handlers = self.fill_tracepoint_handlers_skel()
-        tracepoint_attach = self.fill_tracepoint_attach_probe()
-        tracepoint_detach = self.fill_tracepoint_detach_helper()
-        parent = self.fill_parent()
-        parent_include = self.fill_include_parent()
-
-        main_c = main_c.replace("%%MONITOR_TYPE%%", monitor_type)
-        main_c = main_c.replace("%%MIN_TYPE%%", min_type)
-        main_c = main_c.replace("%%MODEL_NAME%%", self.name)
-        main_c = main_c.replace("%%NR_EVENTS%%", str(nr_events))
-        main_c = main_c.replace("%%TRACEPOINT_HANDLERS_SKEL%%", tracepoint_handlers)
-        main_c = main_c.replace("%%TRACEPOINT_ATTACH%%", tracepoint_attach)
-        main_c = main_c.replace("%%TRACEPOINT_DETACH%%", tracepoint_detach)
-        main_c = main_c.replace("%%DESCRIPTION%%", self.description)
-        main_c = main_c.replace("%%PARENT%%", parent)
-        main_c = main_c.replace("%%INCLUDE_PARENT%%", parent_include)
-
-        return main_c
-
     def fill_model_h_header(self):
         buff = []
         buff.append("/* SPDX-License-Identifier: GPL-2.0 */")
@@ -226,147 +115,15 @@ class dot2k(Dot2c):
         buff.append("	     TP_ARGS(%s)" % tp_args_c)
         return '\n'.join(buff)
 
-    def fill_monitor_deps(self):
-        buff = []
-        buff.append("	# XXX: add dependencies if there")
-        if self.parent:
-            buff.append("	depends on RV_MON_%s" % self.parent.upper())
-            buff.append("	default y")
-        return '\n'.join(buff)
-
-    def fill_trace_h(self):
-        trace_h = self.trace_h
-        monitor_class = self.fill_monitor_class()
-        monitor_class_type = self.fill_monitor_class_type()
-        tracepoint_args_skel_event = self.fill_tracepoint_args_skel("event")
-        tracepoint_args_skel_error = self.fill_tracepoint_args_skel("error")
-        trace_h = trace_h.replace("%%MODEL_NAME%%", self.name)
-        trace_h = trace_h.replace("%%MODEL_NAME_UP%%", self.name.upper())
-        trace_h = trace_h.replace("%%MONITOR_CLASS%%", monitor_class)
-        trace_h = trace_h.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
-        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_EVENT%%", tracepoint_args_skel_event)
-        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_ERROR%%", tracepoint_args_skel_error)
-        return trace_h
-
-    def fill_kconfig(self):
-        kconfig = self.kconfig
-        monitor_class_type = self.fill_monitor_class_type()
-        monitor_deps = self.fill_monitor_deps()
-        kconfig = kconfig.replace("%%MODEL_NAME%%", self.name)
-        kconfig = kconfig.replace("%%MODEL_NAME_UP%%", self.name.upper())
-        kconfig = kconfig.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
-        kconfig = kconfig.replace("%%DESCRIPTION%%", self.description)
-        kconfig = kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
-        return kconfig
-
-    def fill_main_container_h(self):
-        main_h = self.main_h
-        main_h = main_h.replace("%%MODEL_NAME%%", self.name)
-        return main_h
-
-    def __patch_file(self, file, marker, line):
-        file_to_patch = os.path.join(self.rv_dir, file)
-        content = self.__read_file(file_to_patch)
-        content = content.replace(marker, line + "\n" + marker)
-        self.__write_file(file_to_patch, content)
-
-    def fill_tracepoint_tooltip(self):
-        monitor_class_type = self.fill_monitor_class_type()
-        if self.auto_patch:
-            self.__patch_file("rv_trace.h",
-                            "// Add new monitors based on CONFIG_%s here" % monitor_class_type,
-                            "#include <monitors/%s/%s_trace.h>" % (self.name, self.name))
-            return "  - Patching %s/rv_trace.h, double check the result" % self.rv_dir
-
-        return """  - Edit %s/rv_trace.h:
-Add this line where other tracepoints are included and %s is defined:
-#include <monitors/%s/%s_trace.h>
-""" % (self.rv_dir, monitor_class_type, self.name, self.name)
-
-    def fill_kconfig_tooltip(self):
-        if self.auto_patch:
-            self.__patch_file("Kconfig",
-                            "# Add new monitors here",
-                            "source \"kernel/trace/rv/monitors/%s/Kconfig\"" % (self.name))
-            return "  - Patching %s/Kconfig, double check the result" % self.rv_dir
-
-        return """  - Edit %s/Kconfig:
-Add this line where other monitors are included:
-source \"kernel/trace/rv/monitors/%s/Kconfig\"
-""" % (self.rv_dir, self.name)
-
-    def fill_makefile_tooltip(self):
-        name = self.name
-        name_up = name.upper()
-        if self.auto_patch:
-            self.__patch_file("Makefile",
-                            "# Add new monitors here",
-                            "obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o" % (name_up, name, name))
-            return "  - Patching %s/Makefile, double check the result" % self.rv_dir
-
-        return """  - Edit %s/Makefile:
-Add this line where other monitors are included:
-obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
-""" % (self.rv_dir, name_up, name, name)
-
-    def fill_monitor_tooltip(self):
-        if self.auto_patch:
-            return "  - Monitor created in %s/monitors/%s" % (self.rv_dir, self. name)
-        return "  - Move %s/ to the kernel's monitor directory (%s/monitors)" % (self.name, self.rv_dir)
-
-    def __create_directory(self):
-        path = self.name
-        if self.auto_patch:
-            path = os.path.join(self.rv_dir, "monitors", path)
-        try:
-            os.mkdir(path)
-        except FileExistsError:
-            return
-        except:
-            print("Fail creating the output dir: %s" % self.name)
-
-    def __write_file(self, file_name, content):
-        try:
-            file = open(file_name, 'w')
-        except:
-            print("Fail writing to file: %s" % file_name)
-
-        file.write(content)
-
-        file.close()
-
-    def __create_file(self, file_name, content):
-        path = "%s/%s" % (self.name, file_name)
-        if self.auto_patch:
-            path = os.path.join(self.rv_dir, "monitors", path)
-        self.__write_file(path, content)
-
-    def __get_main_name(self):
-        path = "%s/%s" % (self.name, "main.c")
-        if not os.path.exists(path):
-            return "main.c"
-        return "__main.c"
-
-    def print_files(self):
-        main_c = self.fill_main_c()
-
-        self.__create_directory()
-
-        path = "%s.c" % self.name
-        self.__create_file(path, main_c)
+    def fill_main_c(self):
+        main_c = super().fill_main_c()
 
-        if self.container:
-            main_h = self.fill_main_container_h()
-            path = "%s.h" % self.name
-            self.__create_file(path, main_h)
-        else:
-            model_h = self.fill_model_h()
-            path = "%s.h" % self.name
-            self.__create_file(path, model_h)
+        min_type = self.get_minimun_type()
+        nr_events = len(self.events)
+        monitor_type = self.fill_monitor_type()
 
-            trace_h = self.fill_trace_h()
-            path = "%s_trace.h" % self.name
-            self.__create_file(path, trace_h)
+        main_c = main_c.replace("%%MIN_TYPE%%", min_type)
+        main_c = main_c.replace("%%NR_EVENTS%%", str(nr_events))
+        main_c = main_c.replace("%%MONITOR_TYPE%%", monitor_type)
 
-        kconfig = self.fill_kconfig()
-        self.__create_file("Kconfig", kconfig)
+        return main_c
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
new file mode 100644
index 000000000000..19d0078a3803
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -0,0 +1,264 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+#
+# Abtract class for generating kernel runtime verification monitors from specification file
+
+import platform
+import os
+
+
+class RVGenerator:
+    rv_dir = "kernel/trace/rv"
+
+    def __init__(self, extra_params={}):
+        self.name = extra_params.get("model_name")
+        self.parent = extra_params.get("parent")
+        self.abs_template_dir = \
+            os.path.join(os.path.dirname(__file__), "templates", self.template_dir)
+        self.main_c = self._read_template_file("main.c")
+        self.kconfig = self._read_template_file("Kconfig")
+        self.description = extra_params.get("description", self.name) or "auto-generated"
+        self.auto_patch = extra_params.get("auto_patch")
+        if self.auto_patch:
+            self.__fill_rv_kernel_dir()
+
+    def __fill_rv_kernel_dir(self):
+
+        # first try if we are running in the kernel tree root
+        if os.path.exists(self.rv_dir):
+            return
+
+        # offset if we are running inside the kernel tree from verification/dot2
+        kernel_path = os.path.join("../..", self.rv_dir)
+
+        if os.path.exists(kernel_path):
+            self.rv_dir = kernel_path
+            return
+
+        if platform.system() != "Linux":
+            raise OSError("I can only run on Linux.")
+
+        kernel_path = os.path.join("/lib/modules/%s/build" % platform.release(), self.rv_dir)
+
+        # if the current kernel is from a distro this may not be a full kernel tree
+        # verify that one of the files we are going to modify is available
+        if os.path.exists(os.path.join(kernel_path, "rv_trace.h")):
+            self.rv_dir = kernel_path
+            return
+
+        raise FileNotFoundError("Could not find the rv directory, do you have the kernel source installed?")
+
+    def _read_file(self, path):
+        try:
+            fd = open(path, 'r')
+        except OSError:
+            raise Exception("Cannot open the file: %s" % path)
+
+        content = fd.read()
+
+        fd.close()
+        return content
+
+    def _read_template_file(self, file):
+        try:
+            path = os.path.join(self.abs_template_dir, file)
+            return self._read_file(path)
+        except Exception:
+            # Specific template file not found. Try the generic template file in the template/
+            # directory, which is one level up
+            path = os.path.join(self.abs_template_dir, "..", file)
+            return self._read_file(path)
+
+    def fill_parent(self):
+        return "&rv_%s" % self.parent if self.parent else "NULL"
+
+    def fill_include_parent(self):
+        if self.parent:
+            return "#include <monitors/%s/%s.h>\n" % (self.parent, self.parent)
+        return ""
+
+    def fill_tracepoint_handlers_skel(self):
+        return "NotImplemented"
+
+    def fill_tracepoint_attach_probe(self):
+        return "NotImplemented"
+
+    def fill_tracepoint_detach_helper(self):
+        return "NotImplemented"
+
+    def fill_main_c(self):
+        main_c = self.main_c
+        tracepoint_handlers = self.fill_tracepoint_handlers_skel()
+        tracepoint_attach = self.fill_tracepoint_attach_probe()
+        tracepoint_detach = self.fill_tracepoint_detach_helper()
+        parent = self.fill_parent()
+        parent_include = self.fill_include_parent()
+
+        main_c = main_c.replace("%%MODEL_NAME%%", self.name)
+        main_c = main_c.replace("%%TRACEPOINT_HANDLERS_SKEL%%", tracepoint_handlers)
+        main_c = main_c.replace("%%TRACEPOINT_ATTACH%%", tracepoint_attach)
+        main_c = main_c.replace("%%TRACEPOINT_DETACH%%", tracepoint_detach)
+        main_c = main_c.replace("%%DESCRIPTION%%", self.description)
+        main_c = main_c.replace("%%PARENT%%", parent)
+        main_c = main_c.replace("%%INCLUDE_PARENT%%", parent_include)
+
+        return main_c
+
+    def fill_model_h(self):
+        return "NotImplemented"
+
+    def fill_monitor_class_type(self):
+        return "NotImplemented"
+
+    def fill_monitor_class(self):
+        return "NotImplemented"
+
+    def fill_tracepoint_args_skel(self, tp_type):
+        return "NotImplemented"
+
+    def fill_monitor_deps(self):
+        buff = []
+        buff.append("	# XXX: add dependencies if there")
+        if self.parent:
+            buff.append("	depends on RV_MON_%s" % self.parent.upper())
+            buff.append("	default y")
+        return '\n'.join(buff)
+
+    def fill_kconfig(self):
+        kconfig = self.kconfig
+        monitor_class_type = self.fill_monitor_class_type()
+        monitor_deps = self.fill_monitor_deps()
+        kconfig = kconfig.replace("%%MODEL_NAME%%", self.name)
+        kconfig = kconfig.replace("%%MODEL_NAME_UP%%", self.name.upper())
+        kconfig = kconfig.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
+        kconfig = kconfig.replace("%%DESCRIPTION%%", self.description)
+        kconfig = kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
+        return kconfig
+
+    def __patch_file(self, file, marker, line):
+        file_to_patch = os.path.join(self.rv_dir, file)
+        content = self._read_file(file_to_patch)
+        content = content.replace(marker, line + "\n" + marker)
+        self.__write_file(file_to_patch, content)
+
+    def fill_tracepoint_tooltip(self):
+        monitor_class_type = self.fill_monitor_class_type()
+        if self.auto_patch:
+            self.__patch_file("rv_trace.h",
+                            "// Add new monitors based on CONFIG_%s here" % monitor_class_type,
+                            "#include <monitors/%s/%s_trace.h>" % (self.name, self.name))
+            return "  - Patching %s/rv_trace.h, double check the result" % self.rv_dir
+
+        return """  - Edit %s/rv_trace.h:
+Add this line where other tracepoints are included and %s is defined:
+#include <monitors/%s/%s_trace.h>
+""" % (self.rv_dir, monitor_class_type, self.name, self.name)
+
+    def fill_kconfig_tooltip(self):
+        if self.auto_patch:
+            self.__patch_file("Kconfig",
+                            "# Add new monitors here",
+                            "source \"kernel/trace/rv/monitors/%s/Kconfig\"" % (self.name))
+            return "  - Patching %s/Kconfig, double check the result" % self.rv_dir
+
+        return """  - Edit %s/Kconfig:
+Add this line where other monitors are included:
+source \"kernel/trace/rv/monitors/%s/Kconfig\"
+""" % (self.rv_dir, self.name)
+
+    def fill_makefile_tooltip(self):
+        name = self.name
+        name_up = name.upper()
+        if self.auto_patch:
+            self.__patch_file("Makefile",
+                            "# Add new monitors here",
+                            "obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o" % (name_up, name, name))
+            return "  - Patching %s/Makefile, double check the result" % self.rv_dir
+
+        return """  - Edit %s/Makefile:
+Add this line where other monitors are included:
+obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
+""" % (self.rv_dir, name_up, name, name)
+
+    def fill_monitor_tooltip(self):
+        if self.auto_patch:
+            return "  - Monitor created in %s/monitors/%s" % (self.rv_dir, self. name)
+        return "  - Move %s/ to the kernel's monitor directory (%s/monitors)" % (self.name, self.rv_dir)
+
+    def __create_directory(self):
+        path = self.name
+        if self.auto_patch:
+            path = os.path.join(self.rv_dir, "monitors", path)
+        try:
+            os.mkdir(path)
+        except FileExistsError:
+            return
+        except:
+            print("Fail creating the output dir: %s" % self.name)
+
+    def __write_file(self, file_name, content):
+        try:
+            file = open(file_name, 'w')
+        except:
+            print("Fail writing to file: %s" % file_name)
+
+        file.write(content)
+
+        file.close()
+
+    def _create_file(self, file_name, content):
+        path = "%s/%s" % (self.name, file_name)
+        if self.auto_patch:
+            path = os.path.join(self.rv_dir, "monitors", path)
+        self.__write_file(path, content)
+
+    def __get_main_name(self):
+        path = "%s/%s" % (self.name, "main.c")
+        if not os.path.exists(path):
+            return "main.c"
+        return "__main.c"
+
+    def print_files(self):
+        main_c = self.fill_main_c()
+
+        self.__create_directory()
+
+        path = "%s.c" % self.name
+        self._create_file(path, main_c)
+
+        model_h = self.fill_model_h()
+        path = "%s.h" % self.name
+        self._create_file(path, model_h)
+
+        kconfig = self.fill_kconfig()
+        self._create_file("Kconfig", kconfig)
+
+
+class Monitor(RVGenerator):
+    monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
+
+    def __init__(self, extra_params={}):
+        super().__init__(extra_params)
+        self.trace_h = self._read_template_file("trace.h")
+
+    def fill_trace_h(self):
+        trace_h = self.trace_h
+        monitor_class = self.fill_monitor_class()
+        monitor_class_type = self.fill_monitor_class_type()
+        tracepoint_args_skel_event = self.fill_tracepoint_args_skel("event")
+        tracepoint_args_skel_error = self.fill_tracepoint_args_skel("error")
+        trace_h = trace_h.replace("%%MODEL_NAME%%", self.name)
+        trace_h = trace_h.replace("%%MODEL_NAME_UP%%", self.name.upper())
+        trace_h = trace_h.replace("%%MONITOR_CLASS%%", monitor_class)
+        trace_h = trace_h.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
+        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_EVENT%%", tracepoint_args_skel_event)
+        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_ERROR%%", tracepoint_args_skel_error)
+        return trace_h
+
+    def print_files(self):
+        super().print_files()
+        trace_h = self.fill_trace_h()
+        path = "%s_trace.h" % self.name
+        self._create_file(path, trace_h)
-- 
2.47.2



