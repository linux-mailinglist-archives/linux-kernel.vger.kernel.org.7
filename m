Return-Path: <linux-kernel+bounces-770846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D7BB27F94
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2441D045B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB23E303CBA;
	Fri, 15 Aug 2025 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJqbPr+o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D172FCC0B;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258666; cv=none; b=GKAFPpUaLKIWir78JfRMYVHzVycFLGVXgcI+SQ9RMEBWLXYEkGt7uoMmwxB6fntVerftuUFVozQ+unpAw5RcSLegz18H9DBK4TPCHcXDrTuTVUpC8nXzktjQ4KsruKAm+tTVkLH6dvKz+Yn9OsY5j+PGOEdrJQXyDtbNu9qmkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258666; c=relaxed/simple;
	bh=ZoOtF8id0ICXUTMlmq1Pqq/MM5WeKdvyH7/glTLcTBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnJX8yFIWKLMCXUbj/4P207wlk8gvQnwBLBTKRO5CzSSdUdaMMTzNW79fGfCTpyxl1e1NJZyz5UPH25lC1S+qohpJtoJs4P4KsbIGYGUDBZlqildo2QSahBk1ksoJxEWjwtChxD23+wIqJqfUfJlQkij+xmr4EKXho18D71iTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJqbPr+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5371C4CEFC;
	Fri, 15 Aug 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258665;
	bh=ZoOtF8id0ICXUTMlmq1Pqq/MM5WeKdvyH7/glTLcTBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJqbPr+okVXndDrRx0wc0NynxAK9Hf7ZjlKzaD06dTFia2tJP1ubqqMKadBBiKRfP
	 6rfoH36bWO1DDRyyn1fiBpcJunXb1MwxA3cV6mBIRxatgkI/rxbzUJ1Dpjpx7u9Iiy
	 Z/qR+2vcKy45Fy/FCV1qJClvrKfvUyfL1XT/RcK4Rlw2BOjsGxqVXt1mr1fp0ouoo+
	 cyyz06PZ7KjxqF76LJgYR0Mq/8ocBsNefCEgzwD9En2N7m/eMpqpW3pFV1GRyx2CMJ
	 pTJQft2rsqLjh+YZWEKpYkavxgUMdlIULRSdp8yk6N6GWMssksYU6uBCBSACBM33jL
	 616iVHowj+ObA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umsxc-000000042oi-0m79;
	Fri, 15 Aug 2025 13:51:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] scripts/sphinx-build-wrapper: restore SPHINXOPTS parsing
Date: Fri, 15 Aug 2025 13:50:36 +0200
Message-ID: <da3e3258cfaaff331030cfe00df604b12f80f5cf.1755258303.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755258303.git.mchehab+huawei@kernel.org>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While rewriting the wrapper, incidentally support for SPHINXOPTS
was dropped. Restore it and better handle them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile       |  1 +
 scripts/sphinx-build-wrapper | 86 +++++++++++++++++++++++++++++-------
 2 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 280728cf78b9..d2e626627ee6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -19,6 +19,7 @@ endif
 
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
+SPHINXOPTS    =
 SPHINXDIRS    = .
 DOCS_THEME    =
 DOCS_CSS      =
diff --git a/scripts/sphinx-build-wrapper b/scripts/sphinx-build-wrapper
index 5c728956b53c..b9d40f4a6573 100755
--- a/scripts/sphinx-build-wrapper
+++ b/scripts/sphinx-build-wrapper
@@ -148,10 +148,10 @@ class SphinxBuilder:
 
         return path
 
-    def __init__(self, venv=None, verbose=False):
+    def __init__(self, venv=None, verbose=False, n_jobs=None):
         """Initialize internal variables"""
         self.venv = venv
-        self.verbose = verbose
+        self.verbose = None
 
         # Normal variables passed from Kernel's makefile
         self.kernelversion = os.environ.get("KERNELVERSION", "unknown")
@@ -159,6 +159,34 @@ class SphinxBuilder:
         self.pdflatex = os.environ.get("PDFLATEX", "xelatex")
         self.latexopts = os.environ.get("LATEXOPTS", "-interaction=batchmode -no-shell-escape")
 
+        if not verbose:
+            verbose = bool(os.environ.get("KBUILD_VERBOSE", "") != "")
+
+        # Handle SPHINXOPTS evironment
+        sphinxopts = shlex.split(os.environ.get("SPHINXOPTS", ""))
+
+        # As we handle number of jobs and quiet in separate, we need to pick
+        # it the same way as sphinx-build would pick, so let's use argparse
+        # do to the right argument expansion
+        parser = argparse.ArgumentParser()
+        parser.add_argument('-j', '--jobs', type=int)
+        parser.add_argument('-q', '--quiet', type=int)
+
+        # Other sphinx-build arguments go as-is, so place them
+        # at self.sphinxopts
+        sphinx_args, self.sphinxopts = parser.parse_known_args(sphinxopts)
+        if sphinx_args.quiet == True:
+            self.verbose = False
+
+        if sphinx_args.jobs:
+            self.n_jobs = sphinx_args.jobs
+
+        # Command line arguments was passed, override SPHINXOPTS
+        if verbose is not None:
+            self.verbose = verbose
+
+        self.n_jobs = n_jobs
+
         # Source tree directory. This needs to be at os.environ, as
         # Sphinx extensions and media uAPI makefile needs it
         self.srctree = os.environ.get("srctree")
@@ -199,7 +227,7 @@ class SphinxBuilder:
             else:
                 sys.exit(f"Venv {venv} not found.")
 
-    def run_sphinx(self, sphinx_build, sphinx_args, *args, **pwargs):
+    def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):
         """
         Executes sphinx-build using current python3 command and setting
         -j parameter if possible to run the build in parallel.
@@ -207,11 +235,9 @@ class SphinxBuilder:
 
         with JobserverExec() as jobserver:
             if jobserver.claim:
-                parallelism = str(jobserver.claim)
+                n_jobs = str(jobserver.claim)
             else:
-                # As Sphinx has parallelism since version 1.7, we don't need
-                # any check here.
-                parallelism = "auto"
+                n_jobs = "auto" # Supported since Sphinx 1.7
 
             cmd = []
 
@@ -222,10 +248,19 @@ class SphinxBuilder:
 
             cmd.append(sphinx_build)
 
-            if parallelism:
-                cmd.append("-j" + parallelism)
+            # if present, SPHINXOPTS or command line --jobs overrides default
+            if self.n_jobs:
+                n_jobs = str(self.n_jobs)
 
-            cmd += sphinx_args
+            if n_jobs:
+                cmd += [f"-j{n_jobs}"]
+
+            if not self.verbose:
+                cmd.append("-q")
+
+            cmd += self.sphinxopts
+
+            cmd += build_args
 
             if self.verbose:
                 print(" ".join(cmd))
@@ -447,9 +482,6 @@ class SphinxBuilder:
 
             args.extend(["-D", f"latex_elements.papersize={paper}paper"])
 
-        if not self.verbose:
-            args.append("-q")
-
         if self.config_rust:
             args.extend(["-t", "rustdoc"])
 
@@ -582,6 +614,25 @@ class SphinxBuilder:
         except OSError as e:
             sys.exit(f"Failed to restart with {new_python_cmd}: {e}")
 
+def jobs_type(value):
+    """
+    Handle valid values for -j. Accepts Sphinx "-jauto", plus a number
+    equal or bigger than one.
+    """
+    if value is None:
+        return None
+
+    if value.lower() == 'auto':
+        return value.lower()
+
+    try:
+        if int(value) >= 1:
+            return value
+
+        raise argparse.ArgumentTypeError(f"Minimum jobs is 1, got {value}")
+    except ValueError:
+        raise argparse.ArgumentTypeError(f"Must be 'auto' or positive integer, got {value}")
+
 def main():
     """
     Main function. The only mandatory argument is the target. If not
@@ -607,18 +658,19 @@ def main():
     parser.add_argument("-v", "--verbose", action='store_true',
                         help="place build in verbose mode")
 
+    parser.add_argument('-j', '--jobs', type=jobs_type,
+                        help="Sets number of jobs to use with sphinx-build")
+
     parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
                         default=None,
                         help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
 
     args = parser.parse_args()
 
-    if not args.verbose:
-        args.verbose = bool(os.environ.get("KBUILD_VERBOSE", "") != "")
-
     SphinxBuilder.check_python()
 
-    builder = SphinxBuilder(venv=args.venv, verbose=args.verbose)
+    builder = SphinxBuilder(venv=args.venv, verbose=args.verbose,
+                            n_jobs=args.jobs)
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
                   theme=args.theme, css=args.css, paper=args.paper)
-- 
2.50.1


