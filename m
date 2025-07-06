Return-Path: <linux-kernel+bounces-717406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980DFAF93E4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C83B62BB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9910B30207B;
	Fri,  4 Jul 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fz1te9J8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+PY5iH2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3362FCFF7;
	Fri,  4 Jul 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635238; cv=none; b=cQoNI0YWT2rc7Cn4CPD0hpIUhexweObS88ufZXLm/4O3px+sQRxb3PnLkjdjDLkpRTT+U09RzvSXLeeMeRvghwc7cVVarCA3wYybA42pAw2dojCpKbIeL7xQXrP5hURWE1Gaf6JpO6SNeIBEBaQxHiRDGPyUmlBrULsANV9B/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635238; c=relaxed/simple;
	bh=UszEQq6lsPFRfBHM7nHRRkL7K2X1EKuCM0p+KnG5igU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeM6Jcp4P2mLsmUpB9XWuzv8Z5N3XFvsFZjUlKhG6agTZZ0p+VbHMrLK1iWFO+L5tEX54d/BN1lpCMSd6Tjh/eHVVBW+2MmzXBI1ISDby9ZYpfbtURyD3e9NxDBz0K5T4Wl/humID2DDicNPwXMkt8XFlNoWcDUAmj2bgOdZ3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fz1te9J8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+PY5iH2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaFew1jGaEi6CxbD4hayUOm9FNrReyDgE4abUKZ5NBI=;
	b=Fz1te9J8XjoN6ox0ZRotQwHcUsKS4ZBLFHY+JWVw4iyvJiwYgrYlK4OdYXWJJvkrP+2Igm
	Kea9RoQ3sm0kwBblHGiWOSvIDU2yzTGcu2QIdbZP4AqsYro2ICVH6KfSMVf3bRqBbLZuFs
	iUnbn/QuuAeZ5IRDxl5XamGd7fS60J5Y5ejCp8GN5zyuSznEeHk1bHSHvx80wIVbwAPhha
	Kplfcrqq7r3jc1+t6PbFi2GWBvb9Hc0GzWBMydnq5tv6b2Pg6JUEcDxxgYNrPzBPuUiGFB
	FJ+WROSWk0lmbvBKjEVtqjofaXnDGeHeMU3ud+mM/z07AODmrnolwlxqsrGPCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaFew1jGaEi6CxbD4hayUOm9FNrReyDgE4abUKZ5NBI=;
	b=S+PY5iH2744MgzwtSWMj7GHgUa3T2BszotCzZh1VVwoQMmjt42pJjUfqk0vrrIl7bfF698
	DZSuDmSafP8eEgAA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v11 11/21] verification/rvgen: Restructure the templates files
Date: Fri,  4 Jul 2025 15:20:03 +0200
Message-Id: <462d90273f96804d3ba850474877d5f727031258.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
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
 rename tools/verification/rvgen/{dot2k_templates =3D> rvgen/templates}/Kco=
nfig (100%)
 rename tools/verification/rvgen/{dot2k_templates/Kconfig_container =3D> rv=
gen/templates/container/Kconfig} (100%)
 rename tools/verification/rvgen/{dot2k_templates/main_container.c =3D> rvg=
en/templates/container/main.c} (100%)
 rename tools/verification/rvgen/{dot2k_templates/main_container.h =3D> rvg=
en/templates/container/main.h} (100%)
 rename tools/verification/rvgen/{dot2k_templates =3D> rvgen/templates/dot2=
k}/main.c (100%)
 rename tools/verification/rvgen/{dot2k_templates =3D> rvgen/templates/dot2=
k}/trace.h (100%)

diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/M=
akefile
index cea9c21c3bce..8d08825e7e54 100644
--- a/tools/verification/rvgen/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -3,7 +3,6 @@ INSTALL=3Dinstall
 prefix  ?=3D /usr
 bindir  ?=3D $(prefix)/bin
 mandir  ?=3D $(prefix)/share/man
-miscdir ?=3D $(prefix)/share/rvgen
 srcdir  ?=3D $(prefix)/src
=20
 PYLIB  ?=3D $(shell python3 -c 'import sysconfig;  print (sysconfig.get_pa=
th("purelib"))')
@@ -21,6 +20,4 @@ install:
 	$(INSTALL) dot2c -D -m 755 $(DESTDIR)$(bindir)/
 	$(INSTALL) rvgen/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2k.py
 	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
-
-	mkdir -p ${miscdir}/
-	cp -rp dot2k_templates $(DESTDIR)$(miscdir)/
+	cp -rp rvgen/templates $(DESTDIR)$(PYLIB)/rvgen/
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/r=
vgen/rvgen/dot2k.py
index e29462413194..a9ed97d0b224 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -14,14 +14,16 @@ import os
=20
 class dot2k(Dot2c):
     monitor_types =3D { "global" : 1, "per_cpu" : 2, "per_task" : 3 }
-    monitor_templates_dir =3D "rvgen/dot2k_templates/"
     rv_dir =3D "kernel/trace/rv"
     monitor_type =3D "per_cpu"
=20
     def __init__(self, file_path, MonitorType, extra_params=3D{}):
         self.container =3D extra_params.get("subcmd") =3D=3D "container"
         self.parent =3D extra_params.get("parent")
-        self.__fill_rv_templates_dir()
+        if self.container:
+            self.abs_template_dir =3D os.path.join(os.path.dirname(__file_=
_), "templates/container")
+        else:
+            self.abs_template_dir =3D os.path.join(os.path.dirname(__file_=
_), "templates/dot2k")
=20
         if self.container:
             if file_path:
@@ -33,9 +35,7 @@ class dot2k(Dot2c):
             self.name =3D extra_params.get("model_name")
             self.events =3D []
             self.states =3D []
-            self.main_c =3D self.__read_file(self.monitor_templates_dir + =
"main_container.c")
-            self.main_h =3D self.__read_file(self.monitor_templates_dir + =
"main_container.h")
-            self.kconfig =3D self.__read_file(self.monitor_templates_dir +=
 "Kconfig_container")
+            self.main_h =3D self._read_template_file("main.h")
         else:
             super().__init__(file_path, extra_params.get("model_name"))
=20
@@ -43,35 +43,16 @@ class dot2k(Dot2c):
             if self.monitor_type is None:
                 raise ValueError("Unknown monitor type: %s" % MonitorType)
             self.monitor_type =3D MonitorType
-            self.main_c =3D self.__read_file(self.monitor_templates_dir + =
"main.c")
-            self.trace_h =3D self.__read_file(self.monitor_templates_dir +=
 "trace.h")
-            self.kconfig =3D self.__read_file(self.monitor_templates_dir +=
 "Kconfig")
+            self.trace_h =3D self._read_template_file("trace.h")
+
+        self.main_c =3D self._read_template_file("main.c")
+        self.kconfig =3D self._read_template_file("Kconfig")
         self.enum_suffix =3D "_%s" % self.name
         self.description =3D extra_params.get("description", self.name) or=
 "auto-generated"
         self.auto_patch =3D extra_params.get("auto_patch")
         if self.auto_patch:
             self.__fill_rv_kernel_dir()
=20
-    def __fill_rv_templates_dir(self):
-
-        if os.path.exists(self.monitor_templates_dir):
-            return
-
-        if platform.system() !=3D "Linux":
-            raise OSError("I can only run on Linux.")
-
-        kernel_path =3D "/lib/modules/%s/build/tools/verification/rvgen/do=
t2k_templates/" % (platform.release())
-
-        if os.path.exists(kernel_path):
-            self.monitor_templates_dir =3D kernel_path
-            return
-
-        if os.path.exists("/usr/share/rvgen/dot2k_templates/"):
-            self.monitor_templates_dir =3D "/usr/share/rvgen/dot2k_templat=
es/"
-            return
-
-        raise FileNotFoundError("Could not find the template directory, do=
 you have the kernel source installed?")
-
     def __fill_rv_kernel_dir(self):
=20
         # first try if we are running in the kernel tree root
@@ -109,6 +90,16 @@ class dot2k(Dot2c):
         fd.close()
         return content
=20
+    def _read_template_file(self, file):
+        try:
+            path =3D os.path.join(self.abs_template_dir, file)
+            return self.__read_file(path)
+        except Exception:
+            # Specific template file not found. Try the generic template f=
ile in the template/
+            # directory, which is one level up
+            path =3D os.path.join(self.abs_template_dir, "..", file)
+            return self.__read_file(path)
+
     def fill_monitor_type(self):
         return self.monitor_type.upper()
=20
diff --git a/tools/verification/rvgen/dot2k_templates/Kconfig b/tools/verif=
ication/rvgen/rvgen/templates/Kconfig
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/Kconfig
rename to tools/verification/rvgen/rvgen/templates/Kconfig
diff --git a/tools/verification/rvgen/dot2k_templates/Kconfig_container b/t=
ools/verification/rvgen/rvgen/templates/container/Kconfig
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/Kconfig_container
rename to tools/verification/rvgen/rvgen/templates/container/Kconfig
diff --git a/tools/verification/rvgen/dot2k_templates/main_container.c b/to=
ols/verification/rvgen/rvgen/templates/container/main.c
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/main_container.c
rename to tools/verification/rvgen/rvgen/templates/container/main.c
diff --git a/tools/verification/rvgen/dot2k_templates/main_container.h b/to=
ols/verification/rvgen/rvgen/templates/container/main.h
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/main_container.h
rename to tools/verification/rvgen/rvgen/templates/container/main.h
diff --git a/tools/verification/rvgen/dot2k_templates/main.c b/tools/verifi=
cation/rvgen/rvgen/templates/dot2k/main.c
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/main.c
rename to tools/verification/rvgen/rvgen/templates/dot2k/main.c
diff --git a/tools/verification/rvgen/dot2k_templates/trace.h b/tools/verif=
ication/rvgen/rvgen/templates/dot2k/trace.h
similarity index 100%
rename from tools/verification/rvgen/dot2k_templates/trace.h
rename to tools/verification/rvgen/rvgen/templates/dot2k/trace.h
--=20
2.39.5


