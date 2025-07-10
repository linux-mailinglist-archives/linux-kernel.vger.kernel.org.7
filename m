Return-Path: <linux-kernel+bounces-724706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D8FAFF60C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA64E1C41353
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB141AA7BF;
	Thu, 10 Jul 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDAkFzaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FEB125B2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107697; cv=none; b=PZdj9uiiKrITTCNasoJh3f8Qy/iPzq8QZeD4tJ9HDz6jU5D/tYY4ecQ2HHs/NFnO+qnsUXgVeaNWNyjSTJgIzzVj9P2DuXwFET5qg3Un3twbKkr8rLRidHbR7t48kjp4sGcUE8B1H/NxlgeFyhdV+jJ7lYAayzDlFMA/bQfEq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107697; c=relaxed/simple;
	bh=zYfTKOa6h3U1XrTfzqWW6+lsb4ZafI7zKrTqCiYO9a0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DsyTFfcQrHfoa88xQ9/ihcFxsgL487xP4JyRat8Oe+IlASkV1h/b3hBomcvRkleU1tXuGfqG+SE+VZHL8sCd04doD2nOXDCt0WeiqTSS4CVYkkttXqbrfpg7BAfw3LON19Iz/diRzYlk4n7Aa0T/2Sa0NlekR/XUzJcgVOF2qGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDAkFzaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D35C4CEF8;
	Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107696;
	bh=zYfTKOa6h3U1XrTfzqWW6+lsb4ZafI7zKrTqCiYO9a0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=oDAkFzaJyjhpCR7PBmpo+1indRBSyI4L8fklQW9o8/sLdbwm5QKwTnIAyr4WD4SUT
	 mHk9M3d4GwcT0FCGUgKeOBgrcNGCyt+8s8fciH3bXArqZfkaube7Z3r3kNlhlybuyV
	 1YyhENi4eSRMS0kLnH+sulJLPFGcq438CjLNLuBlcgiGkMSg4G7s2oVTIqm6QIu/3w
	 bzaYuKSxe2dtXklxuTrIhdkAH9hU43MkV3BmoXDZ/kc0C424bqJTNLCl72JM1tcdWZ
	 lBzmB7khdG2y2Aj/06PAkPdONBrHTCTOkW84d0WPJtk7jp/OUko2Eh0dzKaN3G+Uyt
	 GL+BZe1slgBUQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfFc-00000001WhQ-3H02;
	Wed, 09 Jul 2025 20:35:00 -0400
Message-ID: <20250710003500.633837240@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:34:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 4/9] verification/dot2k: Prepare the frontend for LTL inclusion
References: <20250710003437.191509804@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

The dot2k tool has some code that can be reused for linear temporal logic
monitor. Prepare its frontend for LTL inclusion:

  1. Rename to be generic: rvgen

  2. Replace the parameter --dot with 2 parameters:
     --class: to specific the monitor class, can be 'da' or 'ltl'
     --spec: the monitor specification file, .dot file for DA, and .ltl
             file for LTL

The old command:

  python3 dot2/dot2k monitor -d wip.dot -t per_cpu

is equivalent to the new commands:

  python3 rvgen monitor -c da -s wip.dot -t per_cpu

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/dea18f7a44374e4db8df5c7e785604bc3062ffc9.1751634289.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/{dot2 => rvgen}/Makefile    | 10 +++++-----
 .../{dot2/dot2k => rvgen/__main__.py}          | 18 +++++++++++++-----
 tools/verification/{dot2 => rvgen}/dot2c       |  2 +-
 .../{dot2 => rvgen}/dot2k_templates/Kconfig    |  0
 .../dot2k_templates/Kconfig_container          |  0
 .../{dot2 => rvgen}/dot2k_templates/main.c     |  0
 .../dot2k_templates/main_container.c           |  0
 .../dot2k_templates/main_container.h           |  0
 .../{dot2 => rvgen}/dot2k_templates/trace.h    |  0
 .../{dot2 => rvgen/rvgen}/automata.py          |  0
 .../{dot2 => rvgen/rvgen}/dot2c.py             |  2 +-
 .../{dot2 => rvgen/rvgen}/dot2k.py             | 10 +++++-----
 12 files changed, 25 insertions(+), 17 deletions(-)
 rename tools/verification/{dot2 => rvgen}/Makefile (55%)
 rename tools/verification/{dot2/dot2k => rvgen/__main__.py} (72%)
 rename tools/verification/{dot2 => rvgen}/dot2c (97%)
 rename tools/verification/{dot2 => rvgen}/dot2k_templates/Kconfig (100%)
 rename tools/verification/{dot2 => rvgen}/dot2k_templates/Kconfig_container (100%)
 rename tools/verification/{dot2 => rvgen}/dot2k_templates/main.c (100%)
 rename tools/verification/{dot2 => rvgen}/dot2k_templates/main_container.c (100%)
 rename tools/verification/{dot2 => rvgen}/dot2k_templates/main_container.h (100%)
 rename tools/verification/{dot2 => rvgen}/dot2k_templates/trace.h (100%)
 rename tools/verification/{dot2 => rvgen/rvgen}/automata.py (100%)
 rename tools/verification/{dot2 => rvgen/rvgen}/dot2c.py (99%)
 rename tools/verification/{dot2 => rvgen/rvgen}/dot2k.py (98%)

diff --git a/tools/verification/dot2/Makefile b/tools/verification/rvgen/Makefile
similarity index 55%
rename from tools/verification/dot2/Makefile
rename to tools/verification/rvgen/Makefile
index 021beb07a521..cea9c21c3bce 100644
--- a/tools/verification/dot2/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -3,7 +3,7 @@ INSTALL=install
 prefix  ?= /usr
 bindir  ?= $(prefix)/bin
 mandir  ?= $(prefix)/share/man
-miscdir ?= $(prefix)/share/dot2
+miscdir ?= $(prefix)/share/rvgen
 srcdir  ?= $(prefix)/src
 
 PYLIB  ?= $(shell python3 -c 'import sysconfig;  print (sysconfig.get_path("purelib"))')
@@ -16,11 +16,11 @@ clean:
 
 .PHONY: install
 install:
-	$(INSTALL) automata.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/automata.py
-	$(INSTALL) dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2c.py
+	$(INSTALL) rvgen/automata.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/automata.py
+	$(INSTALL) rvgen/dot2c.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2c.py
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
-	$(INSTALL) dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/dot2/dot2k.py
-	$(INSTALL) dot2k -D -m 755 $(DESTDIR)$(bindir)/
+	$(INSTALL) rvgen/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2k.py
+	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
 
 	mkdir -p ${miscdir}/
 	cp -rp dot2k_templates $(DESTDIR)$(miscdir)/
diff --git a/tools/verification/dot2/dot2k b/tools/verification/rvgen/__main__.py
similarity index 72%
rename from tools/verification/dot2/dot2k
rename to tools/verification/rvgen/__main__.py
index 133fb17d9d47..994d320ad2d1 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/rvgen/__main__.py
@@ -9,11 +9,11 @@
 #   Documentation/trace/rv/da_monitor_synthesis.rst
 
 if __name__ == '__main__':
-    from dot2.dot2k import dot2k
+    from rvgen.dot2k import dot2k
     import argparse
     import sys
 
-    parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
+    parser = argparse.ArgumentParser(description='Generate kernel rv monitor')
     parser.add_argument("-D", "--description", dest="description", required=False)
     parser.add_argument("-a", "--auto_patch", dest="auto_patch",
                         action="store_true", required=False,
@@ -25,7 +25,9 @@ if __name__ == '__main__':
     monitor_parser.add_argument('-n', "--model_name", dest="model_name")
     monitor_parser.add_argument("-p", "--parent", dest="parent",
                                 required=False, help="Create a monitor nested to parent")
-    monitor_parser.add_argument('-d', "--dot", dest="dot_file")
+    monitor_parser.add_argument('-c', "--class", dest="monitor_class",
+                                help="Monitor class, either \"da\" or \"ltl\"")
+    monitor_parser.add_argument('-s', "--spec", dest="spec", help="Monitor specification file")
     monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type",
                                 help=f"Available options: {', '.join(dot2k.monitor_types.keys())}")
 
@@ -36,8 +38,14 @@ if __name__ == '__main__':
 
     try:
         if params.subcmd == "monitor":
-            print("Opening and parsing the dot file %s" % params.dot_file)
-            monitor = dot2k(params.dot_file, params.monitor_type, vars(params))
+            print("Opening and parsing the specification file %s" % params.spec)
+            if params.monitor_class == "da":
+                monitor = dot2k(params.spec, params.monitor_type, vars(params))
+            elif params.monitor_class == "ltl":
+                raise NotImplementedError
+            else:
+                print("Unknown monitor class:", params.monitor_class)
+                sys.exit(1)
         else:
             monitor = dot2k(None, None, vars(params))
     except Exception as e:
diff --git a/tools/verification/dot2/dot2c b/tools/verification/rvgen/dot2c
similarity index 97%
rename from tools/verification/dot2/dot2c
rename to tools/verification/rvgen/dot2c
index 3fe89ab88b65..bf0c67c5b66c 100644
--- a/tools/verification/dot2/dot2c
+++ b/tools/verification/rvgen/dot2c
@@ -14,7 +14,7 @@
 #   Documentation/trace/rv/deterministic_automata.rst
 
 if __name__ == '__main__':
-    from dot2 import dot2c
+    from rvgen import dot2c
     import argparse
     import sys
 
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig b/tools/verification/rvgen/dot2k_templates/Kconfig
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/Kconfig
rename to tools/verification/rvgen/dot2k_templates/Kconfig
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig_container b/tools/verification/rvgen/dot2k_templates/Kconfig_container
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/Kconfig_container
rename to tools/verification/rvgen/dot2k_templates/Kconfig_container
diff --git a/tools/verification/dot2/dot2k_templates/main.c b/tools/verification/rvgen/dot2k_templates/main.c
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/main.c
rename to tools/verification/rvgen/dot2k_templates/main.c
diff --git a/tools/verification/dot2/dot2k_templates/main_container.c b/tools/verification/rvgen/dot2k_templates/main_container.c
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/main_container.c
rename to tools/verification/rvgen/dot2k_templates/main_container.c
diff --git a/tools/verification/dot2/dot2k_templates/main_container.h b/tools/verification/rvgen/dot2k_templates/main_container.h
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/main_container.h
rename to tools/verification/rvgen/dot2k_templates/main_container.h
diff --git a/tools/verification/dot2/dot2k_templates/trace.h b/tools/verification/rvgen/dot2k_templates/trace.h
similarity index 100%
rename from tools/verification/dot2/dot2k_templates/trace.h
rename to tools/verification/rvgen/dot2k_templates/trace.h
diff --git a/tools/verification/dot2/automata.py b/tools/verification/rvgen/rvgen/automata.py
similarity index 100%
rename from tools/verification/dot2/automata.py
rename to tools/verification/rvgen/rvgen/automata.py
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
similarity index 99%
rename from tools/verification/dot2/dot2c.py
rename to tools/verification/rvgen/rvgen/dot2c.py
index fa2816ac7b61..6009caf568d9 100644
--- a/tools/verification/dot2/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -13,7 +13,7 @@
 # For further information, see:
 #   Documentation/trace/rv/deterministic_automata.rst
 
-from dot2.automata import Automata
+from .automata import Automata
 
 class Dot2c(Automata):
     enum_suffix = ""
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
similarity index 98%
rename from tools/verification/dot2/dot2k.py
rename to tools/verification/rvgen/rvgen/dot2k.py
index 9ec99e297012..e29462413194 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -8,13 +8,13 @@
 # For further information, see:
 #   Documentation/trace/rv/da_monitor_synthesis.rst
 
-from dot2.dot2c import Dot2c
+from .dot2c import Dot2c
 import platform
 import os
 
 class dot2k(Dot2c):
     monitor_types = { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
-    monitor_templates_dir = "dot2/dot2k_templates/"
+    monitor_templates_dir = "rvgen/dot2k_templates/"
     rv_dir = "kernel/trace/rv"
     monitor_type = "per_cpu"
 
@@ -60,14 +60,14 @@ class dot2k(Dot2c):
         if platform.system() != "Linux":
             raise OSError("I can only run on Linux.")
 
-        kernel_path = "/lib/modules/%s/build/tools/verification/dot2/dot2k_templates/" % (platform.release())
+        kernel_path = "/lib/modules/%s/build/tools/verification/rvgen/dot2k_templates/" % (platform.release())
 
         if os.path.exists(kernel_path):
             self.monitor_templates_dir = kernel_path
             return
 
-        if os.path.exists("/usr/share/dot2/dot2k_templates/"):
-            self.monitor_templates_dir = "/usr/share/dot2/dot2k_templates/"
+        if os.path.exists("/usr/share/rvgen/dot2k_templates/"):
+            self.monitor_templates_dir = "/usr/share/rvgen/dot2k_templates/"
             return
 
         raise FileNotFoundError("Could not find the template directory, do you have the kernel source installed?")
-- 
2.47.2



