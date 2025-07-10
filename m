Return-Path: <linux-kernel+bounces-724703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D9AFF607
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D9A4E14C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36B51A0B08;
	Thu, 10 Jul 2025 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUQEVkTl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9113C3F2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107696; cv=none; b=dCJFwciXvp5+JqVRgGRn0dgVSa6Fs4tRG55+GPaWB5s9vYTgTfKkLjrAdgpGalTKw8BSoWT/JDNXDHXwQjIMCLt04RAcxFA6z+Uwa6wFL2qlFpJ1JGTkrAcS1AwAfKAapZinQ5fCIBi3eiGcXhRrDlO/YxkU3tYtn4zQ4Jfcetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107696; c=relaxed/simple;
	bh=OwQGGSG3VOQzKbOitie3JFQ3glP3Vf5wiKIpEFVcxSE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DUdz19hkZgScZMmCOIj7qT0YTKIdclPbZwwJfHP5iDUk5XgXtCaAf8vNDW9F+iZMuMfmOYS/+wsopmxm4SsTvWKS1dnA8ZTZn/6w7JfG4M0qZc48apLphZRhPA8lHbbSGnjIKRo4Ey3LTkt3DP+Jeq6VsWRnKHNNqve53R0b8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUQEVkTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771EFC19422;
	Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107696;
	bh=OwQGGSG3VOQzKbOitie3JFQ3glP3Vf5wiKIpEFVcxSE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=FUQEVkTlV7ruBqbfw7MA8owJE0e9Oaxx/Armum74WyZgQIKvBZE0cJXxKx1kj77nr
	 kpwhZ+QUikT7c7tl5+HVq6gokCcYE2cNhIrQq1GID3CeVpsxStr9KwjlTK7Oa7awih
	 C7JslTRsch468kdHQMsnc9fVSTz4kuwOKdehEmDWByu/IPWYYL/D6E4Ev9vRVMpEtz
	 +wyPDgKQCHYfxsjjhmQhpQ2+M5uWK+TP5k3CIkLgTfaQdt56GQhJa+GEkZBDV6QznI
	 N6U5hoUbvQvLfpOaizVquszVaPydiUArJk4+kBjV0MLFzwjwzJCfyEOFtnlj9Ikk+h
	 9VwQEWn7UCGfw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfFd-00000001WiP-0UqL;
	Wed, 09 Jul 2025 20:35:01 -0400
Message-ID: <20250710003500.971623482@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:34:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 6/9] verification/rvgen: Restructure the templates files
References: <20250710003437.191509804@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

To simply the scripts and to allow easy integration of new monitor types,
restructure the template files as followed:

1. Move the template files to be in the same directory as the rvgen
   package. Furthermore, the installation will now only install the
   templates to the package directory, not /usr/share/. This simplify
   templates reading, as the scripts do not need to find the templates at
   multiple places.

2. Move dot2k_templates/* to:
     - templates/dot2k/
     - templates/container/

   This allows sharing templates reading code between DA monitor generation
   and container generation (and any future generation type).

   For template files which can be shared between different generation
   types, support putting them in templates/

This restructure aligns with the recommendation from:
https://python-packaging.readthedocs.io/en/latest/non-code-files.html

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/462d90273f96804d3ba850474877d5f727031258.1751634289.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rvgen/Makefile             |  5 +-
 tools/verification/rvgen/rvgen/dot2k.py       | 47 ++++++++-----------
 .../templates}/Kconfig                        |  0
 .../templates/container/Kconfig}              |  0
 .../templates/container/main.c}               |  0
 .../templates/container/main.h}               |  0
 .../templates/dot2k}/main.c                   |  0
 .../templates/dot2k}/trace.h                  |  0
 8 files changed, 20 insertions(+), 32 deletions(-)
 rename tools/verification/rvgen/{dot2k_templates => rvgen/templates}/Kconfig (100%)
 rename tools/verification/rvgen/{dot2k_templates/Kconfig_container => rvgen/templates/container/Kconfig} (100%)
 rename tools/verification/rvgen/{dot2k_templates/main_container.c => rvgen/templates/container/main.c} (100%)
 rename tools/verification/rvgen/{dot2k_templates/main_container.h => rvgen/templates/container/main.h} (100%)
 rename tools/verification/rvgen/{dot2k_templates => rvgen/templates/dot2k}/main.c (100%)
 rename tools/verification/rvgen/{dot2k_templates => rvgen/templates/dot2k}/trace.h (100%)

diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/Makefile
index cea9c21c3bce..8d08825e7e54 100644
--- a/tools/verification/rvgen/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -3,7 +3,6 @@ INSTALL=install
 prefix  ?= /usr
 bindir  ?= $(prefix)/bin
 mandir  ?= $(prefix)/share/man
-miscdir ?= $(prefix)/share/rvgen
 srcdir  ?= $(prefix)/src
 
 PYLIB  ?= $(shell python3 -c 'import sysconfig;  print (sysconfig.get_path("purelib"))')
@@ -21,6 +20,4 @@ install:
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
 	$(INSTALL) rvgen/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2k.py
 	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
-
-	mkdir -p ${miscdir}/
-	cp -rp dot2k_templates $(DESTDIR)$(miscdir)/
+	cp -rp rvgen/templates $(DESTDIR)$(PYLIB)/rvgen/
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index e29462413194..a9ed97d0b224 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -14,14 +14,16 @@ import os
 
 class dot2k(Dot2c):
     monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
-    monitor_templates_dir = "rvgen/dot2k_templates/"
     rv_dir = "kernel/trace/rv"
     monitor_type = "per_cpu"
 
     def __init__(self, file_path, MonitorType, extra_params={}):
         self.container = extra_params.get("subcmd") == "container"
         self.parent = extra_params.get("parent")
-        self.__fill_rv_templates_dir()
+        if self.container:
+            self.abs_template_dir = os.path.join(os.path.dirname(__file__), "templates/container")
+        else:
+            self.abs_template_dir = os.path.join(os.path.dirname(__file__), "templates/dot2k")
 
         if self.container:
             if file_path:
@@ -33,9 +35,7 @@ class dot2k(Dot2c):
             self.name = extra_params.get("model_name")
             self.events = []
             self.states = []
-            self.main_c = self.__read_file(self.monitor_templates_dir + "main_container.c")
-            self.main_h = self.__read_file(self.monitor_templates_dir + "main_container.h")
-            self.kconfig = self.__read_file(self.monitor_templates_dir + "Kconfig_container")
+            self.main_h = self._read_template_file("main.h")
         else:
             super().__init__(file_path, extra_params.get("model_name"))
 
@@ -43,35 +43,16 @@ class dot2k(Dot2c):
             if self.monitor_type is None:
                 raise ValueError("Unknown monitor type: %s" % MonitorType)
             self.monitor_type = MonitorType
-            self.main_c = self.__read_file(self.monitor_templates_dir + "main.c")
-            self.trace_h = self.__read_file(self.monitor_templates_dir + "trace.h")
-            self.kconfig = self.__read_file(self.monitor_templates_dir + "Kconfig")
+            self.trace_h = self._read_template_file("trace.h")
+
+        self.main_c = self._read_template_file("main.c")
+        self.kconfig = self._read_template_file("Kconfig")
         self.enum_suffix = "_%s" % self.name
         self.description = extra_params.get("description", self.name) or "auto-generated"
         self.auto_patch = extra_params.get("auto_patch")
         if self.auto_patch:
             self.__fill_rv_kernel_dir()
 
-    def __fill_rv_templates_dir(self):
-
-        if os.path.exists(self.monitor_templates_dir):
-            return
-
-        if platform.system() != "Linux":
-            raise OSError("I can only run on Linux.")
-
-        kernel_path = "/lib/modules/%s/build/tools/verification/rvgen/dot2k_templates/" % (platform.release())
-
-        if os.path.exists(kernel_path):
-            self.monitor_templates_dir = kernel_path
-            return
-
-        if os.path.exists("/usr/share/rvgen/dot2k_templates/"):
-            self.monitor_templates_dir = "/usr/share/rvgen/dot2k_templates/"
-            return
-
-        raise FileNotFoundError("Could not find the template directory, do you have the kernel source installed?")
-
     def __fill_rv_kernel_dir(self):
 
         # first try if we are running in the kernel tree root
@@ -109,6 +90,16 @@ class dot2k(Dot2c):
         fd.close()
         return content
 
+    def _read_template_file(self, file):
+        try:
+            path = os.path.join(self.abs_template_dir, file)
+            return self.__read_file(path)
+        except Exception:
+            # Specific template file not found. Try the generic template file in the template/
+            # directory, which is one level up
+            path = os.path.join(self.abs_template_dir, "..", file)
+            return self.__read_file(path)
+
     def fill_monitor_type(self):
         return self.monitor_type.upper()
 
diff --git a/tools/verification/rvgen/dot2k_templates/Kconfig b/tools/verification/rvgen/rvgen/templates/Kconfig
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/Kconfig
rename to tools/verification/rvgen/rvgen/templates/Kconfig
diff --git a/tools/verification/rvgen/dot2k_templates/Kconfig_container b/tools/verification/rvgen/rvgen/templates/container/Kconfig
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/Kconfig_container
rename to tools/verification/rvgen/rvgen/templates/container/Kconfig
diff --git a/tools/verification/rvgen/dot2k_templates/main_container.c b/tools/verification/rvgen/rvgen/templates/container/main.c
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/main_container.c
rename to tools/verification/rvgen/rvgen/templates/container/main.c
diff --git a/tools/verification/rvgen/dot2k_templates/main_container.h b/tools/verification/rvgen/rvgen/templates/container/main.h
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/main_container.h
rename to tools/verification/rvgen/rvgen/templates/container/main.h
diff --git a/tools/verification/rvgen/dot2k_templates/main.c b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/main.c
rename to tools/verification/rvgen/rvgen/templates/dot2k/main.c
diff --git a/tools/verification/rvgen/dot2k_templates/trace.h b/tools/verification/rvgen/rvgen/templates/dot2k/trace.h
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/trace.h
rename to tools/verification/rvgen/rvgen/templates/dot2k/trace.h
-- 
2.47.2



