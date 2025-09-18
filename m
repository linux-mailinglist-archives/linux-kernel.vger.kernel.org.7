Return-Path: <linux-kernel+bounces-765199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FB3B22CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF45505F23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164582FAC08;
	Tue, 12 Aug 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVWlM2p5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9E2F83D8;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=iA22JMcIydt01giblUvd57SiFsKohaQw0AQqLWV0ITmriOQAtLPWuZqLwJHXfcQj23DGcQRt/tWD2OkqxcV+SObijkOdqTc8gKblugl7MvE/+zknxzU8lyEwBt8JBawbHgOscf++pvyxiL+IUww5Nn9e2qNy3d6mNILSBySU/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=wgqUPfvWSrBA5ivsAx4eRsEEzhKN45zQn51pt6lQAvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rk5ESwafhSO2WFNMqjGusuqxSWMhiD9caE2/5Gl5ziQoOs9fMVwEjFchTfGdm1TJki8jkOnquv1zZdi7ybZdJk18Ou+6g9OoqajEqPFTaMtqtsn13tTSB1m4S9ks/d4YbxkV6Seeo1R37MV9AACi2weG6LQZx/4QXxHeurf1yko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVWlM2p5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E72C19423;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=wgqUPfvWSrBA5ivsAx4eRsEEzhKN45zQn51pt6lQAvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVWlM2p5sybpqHreC0thYYlbvhZcCKCNreb+B8RpCyenatfF1yn1fgvUGhGzoDQhD
	 vC7fvfy6ufmIUkFn2vhItHxvqAaUL/QrYkgdqAlx/dlO9DShjpJlhlWd3yOsu/zRYX
	 zsbZSDnbb0ZzEK7oA5hstceeM/X+Jc/qcYlupmF3it2AaHBDB9rvMvVgkTOzKLQU06
	 OPtLB4hP9I72pASpdSo8qS0D052pU+vD1gw0PL6hmVUDsVTfvkkRbE7qxnq28Xv4Hk
	 aP/5teAMQIxC33zEb2qxnpUOJ5tbN7lQ9m85Fq48MkvnMVhJ7mzeRnVjxkxALM0TSD
	 cfNFNpk5MvnKw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kXG-4AmJ;
	Tue, 12 Aug 2025 17:53:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/39] scripts: sphinx-pre-install: fix several codingstyle issues
Date: Tue, 12 Aug 2025 17:52:49 +0200
Message-ID: <5139b18535e1436e4b1773706224a9ec3a386697.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Address most pylint issues.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 52 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 1c96f6692e9a..1b11162da9fb 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -2,8 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017-2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 #
-# pylint: disable=C0103,C0114,C0115,C0116,C0301
-# pylint: disable=R0902,R0904,R0912,R0915,R1705,R1710,E1121
+# pylint: disable=C0103,C0114,C0115,C0116,C0301,C0302
+# pylint: disable=R0902,R0904,R0911,R0912,R0914,R0915,R1705,R1710,E1121
 
 # Note: this script requires at least Python 3.6 to run.
 # Don't add changes not compatible with it, it is meant to report
@@ -115,7 +115,7 @@ class DepManager:
         if dtype[1]:
             return f"ERROR: {msg} mandatory deps missing"
         else:
-            out = f"Warning: {msg} optional deps missing"
+            return f"Warning: {msg} optional deps missing"
 
     @staticmethod
     def is_optional(dtype):
@@ -125,7 +125,7 @@ class DepManager:
     @staticmethod
     def is_pdf(dtype):
         """Ancillary routine to report if a dependency is for PDF generation"""
-        if (dtype[0] == DepManager._PDF_TYPE):
+        if dtype[0] == DepManager._PDF_TYPE:
             return True
 
         return False
@@ -191,8 +191,8 @@ class DepManager:
             self.missing_pkg[dtype].append(progs.get(prog, prog))
 
         install = []
-        for dtype in self.missing_pkg.keys():
-            install += self.missing_pkg[dtype]
+        for dtype, pkgs in self.missing_pkg.items():
+            install += pkgs
 
         return " ".join(sorted(set(install)))
 
@@ -267,8 +267,6 @@ class AncillaryMethods:
             "python3.[0-9][0-9]",
         ]
 
-        new_python_cmd = None
-
         # Seek for a python binary newer than MIN_PYTHON_VERSION
         for path in os.getenv("PATH", "").split(":"):
             for pattern in patterns:
@@ -276,7 +274,7 @@ class AncillaryMethods:
                     if os.path.isfile(cmd) and os.access(cmd, os.X_OK):
                         version = SphinxDependencyChecker.get_python_version(cmd)
                         if version >= MIN_PYTHON_VERSION:
-                            return(cmd)
+                            return cmd
 
     @staticmethod
     def check_python():
@@ -306,8 +304,8 @@ class AncillaryMethods:
 
         new_python_cmd = SphinxDependencyChecker.find_python()
         if not new_python_cmd:
-            print(f"ERROR: Python version {python_ver} is not spported anymore")
-            print(f"       Can't find a new version. This script may fail")
+            print(f"ERROR: Python version {python_ver} is not spported anymore\n")
+            print("       Can't find a new version. This script may fail")
             return
 
         # Restart script using the newer version
@@ -362,6 +360,9 @@ class MissingCheckers(AncillaryMethods):
         self.version_check = args.version_check
         self.texlive = texlive
 
+        self.min_version = (0, 0, 0)
+        self.cur_version = (0, 0, 0)
+
         self.deps = DepManager(self.pdf)
 
         self.need_symlink = 0
@@ -370,8 +371,10 @@ class MissingCheckers(AncillaryMethods):
         self.verbose_warn_install = 1
 
         self.virtenv_dir = ""
-
         self.install = ""
+        self.python_cmd = ""
+
+        self.virtenv_prefix = ["sphinx_", "Sphinx_" ]
 
     def check_missing_file(self, files, package, dtype):
         """
@@ -542,10 +545,10 @@ class MissingCheckers(AncillaryMethods):
                         self.min_version = parse_version(match.group(1))
                         break
         except IOError:
-            sys.exit(f"Can't open {self.conf}")
+            sys.exit(f"Can't open {conf}")
 
         if not self.min_version:
-            sys.exit(f"Can't get needs_sphinx version from {self.conf}")
+            sys.exit(f"Can't get needs_sphinx version from {conf}")
 
         self.virtenv_dir = self.virtenv_prefix[0] + "latest"
 
@@ -709,7 +712,6 @@ class SphinxDependencyChecker(MissingCheckers):
         self.rec_sphinx_upgrade = 0
 
         self.system_release = self.get_system_release()
-        self.python_cmd = ""
         self.activate_cmd = ""
 
         # Some distros may not have a Sphinx shipped package compatible with
@@ -722,8 +724,6 @@ class SphinxDependencyChecker(MissingCheckers):
         # Certain hints are meant to be shown only once
         self.first_hint = True
 
-        self.min_version = (0, 0, 0)
-        self.cur_version = (0, 0, 0)
         self.latest_avail_ver = (0, 0, 0)
         self.venv_ver = (0, 0, 0)
 
@@ -731,7 +731,6 @@ class SphinxDependencyChecker(MissingCheckers):
 
         self.conf = prefix + "Documentation/conf.py"
         self.requirement_file = prefix + "Documentation/sphinx/requirements.txt"
-        self.virtenv_prefix = ["sphinx_", "Sphinx_" ]
 
     #
     # Distro-specific hints methods
@@ -814,6 +813,7 @@ class SphinxDependencyChecker(MissingCheckers):
 
         if not rel:
             print("Couldn't identify release number")
+            noto_sans_redhat = None
             self.pdf = False
         elif re.search("Fedora", self.system_release):
             # Fedora 38 and upper use this CJK font
@@ -1111,7 +1111,7 @@ class SphinxDependencyChecker(MissingCheckers):
             for fname, portage in portages.items():
                 install = False
 
-                while install == False:
+                while install is False:
                     if not files:
                         # No files under package.usage. Install all
                         install = True
@@ -1335,7 +1335,7 @@ class SphinxDependencyChecker(MissingCheckers):
         old_optional = self.deps.optional
 
         self.pdf = False
-        self.optional = 0
+        self.deps.optional = 0
         self.install = ""
         old_verbose = self.verbose_warn_install
         self.verbose_warn_install = 0
@@ -1346,8 +1346,8 @@ class SphinxDependencyChecker(MissingCheckers):
 
         self.check_distros()
 
-        self.need = old_need
-        self.optional = old_optional
+        self.deps.need = old_need
+        self.deps.optional = old_optional
         self.verbose_warn_install = old_verbose
 
     def recommend_sphinx_version(self, virtualenv_cmd):
@@ -1528,13 +1528,13 @@ class SphinxDependencyChecker(MissingCheckers):
         self.recommend_sphinx_version(virtualenv_cmd)
         print("")
 
-        if not self.optional:
+        if not self.deps.optional:
             print("All optional dependencies are met.")
 
-        if self.need == 1:
+        if self.deps.need == 1:
             sys.exit("Can't build as 1 mandatory dependency is missing")
-        elif self.need:
-            sys.exit(f"Can't build as {self.need} mandatory dependencies are missing")
+        elif self.deps.need:
+            sys.exit(f"Can't build as {self.deps.need} mandatory dependencies are missing")
 
         print("Needed package dependencies are met.")
 
-- 
2.50.1


