Return-Path: <linux-kernel+bounces-774216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A5B2B001
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDA47B0B76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3576732BF59;
	Mon, 18 Aug 2025 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqnD8BNG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C532BF49;
	Mon, 18 Aug 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540611; cv=none; b=NSq5QepvjhZEXL/uH7mUdnW5dKaH2YV7RIHrO04UUjugRo0Bo3kpH/RVlfz1dC22YvVH55yN58S0iy2MWE9xSOsMltXjAYBrHaod7trxRfrJKC4EsDb7dX2zjyIkPOwas6N7pIq10ieRJl8kpXJ6IZ21g40wEpTDxOOEP2ICIaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540611; c=relaxed/simple;
	bh=pSUYHeQFFjfTKV4SrKrg5p5P0FR3kF+lS2zeb56AmEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5tpNf9Jtocfk4Dlst1CreFZG+XnersdgDfELLPrYwFaOMihn74XsjNxukryywN6VNnB9Qc74/7nxV2ajd8K/Ir2EgTqL3O8XzP3KqCyYk5sYd+d0ynLrnwnywLUcxkL9GWLf4acWciP7X4rWEkUyLQbd6qohn5/rd0g/3CrGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqnD8BNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCFDC4CEEB;
	Mon, 18 Aug 2025 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755540609;
	bh=pSUYHeQFFjfTKV4SrKrg5p5P0FR3kF+lS2zeb56AmEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqnD8BNGIzE7+OVaO2QIYI+pAI2A23y6Tv9IUkeXitQN8triKhyofOpP5PVZkwPRI
	 iUkfpr3qo5TSO9MzKxHV73nG5p9/qHkoGhOVn/exoAL7PhEZXMF4VLC0+DWl370ZT4
	 HRwKaSpVJvxHfMt1getZoP2z/EXMTc82gGQ+WYR3/i5rFppKmYchMR9WenLGHYZl7g
	 cEB7X/rXun0yfL1/w55DXTNDKhTUetG2m0JZr+iWRaLsWPF324ErHZ0uzxaDf/aYzA
	 dl4qxPPdEaCZdqIWjOk6oVDPbaOeJgwcdq8k2LKJ2ko6wHEz/cP5Odcmoyz2fTpMgu
	 vswVeHuWhKSZg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uo4J5-00000001sQb-1RN9;
	Mon, 18 Aug 2025 20:10:07 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	corbet@lwn.net
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] scripts/sphinx-build-wrapper: allow building PDF files in parallel
Date: Mon, 18 Aug 2025 20:10:01 +0200
Message-ID: <26e5efca73dbd2f863a51018054a749c9e5f5a19.1755540431.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755540431.git.mchehab+huawei@kernel.org>
References: <cover.1755540431.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Use POSIX jobserver when available or -j<number> to run PDF
builds in parallel, restoring pdf build performance. Yet,
running it when debugging troubles is a bad idea, so, when
calling directly via command line, except if "-j" is splicitly
requested, it will serialize the build.

With such change, a PDF doc builds now takes around 5 minutes
on a Ryzen 9 machine with 32 cpu threads:

	# Explicitly paralelize both Sphinx and LaTeX pdf builds
	$ make cleandocs; time scripts/sphinx-build-wrapper pdfdocs -j 33

	real	5m17.901s
	user	15m1.499s
	sys	2m31.482s

	# Use POSIX jobserver to paralelize both sphinx-build and LaTeX
	$ make cleandocs; time make pdfdocs

	real	5m22.369s
	user	15m9.076s
	sys	2m31.419s

	# Serializes PDF build, while keeping Sphinx parallelized.
	# it is equivalent of passing -jauto via command line
	$ make cleandocs; time scripts/sphinx-build-wrapper pdfdocs

	real	11m20.901s
	user	13m2.910s
	sys	1m44.553s

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/9b3b0430-066f-486e-89cc-00e6f1f3b096@gmail.com/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-build-wrapper | 141 ++++++++++++++++++++++++++---------
 1 file changed, 106 insertions(+), 35 deletions(-)

diff --git a/scripts/sphinx-build-wrapper b/scripts/sphinx-build-wrapper
index f21701d34552..0d13c19f6df3 100755
--- a/scripts/sphinx-build-wrapper
+++ b/scripts/sphinx-build-wrapper
@@ -53,6 +53,7 @@ import shutil
 import subprocess
 import sys
 
+from concurrent import futures
 from glob import glob
 
 LIB_DIR = "lib"
@@ -295,6 +296,76 @@ class SphinxBuilder:
         except (OSError, IOError) as e:
             print(f"Warning: Failed to copy CSS: {e}", file=sys.stderr)
 
+    def build_pdf_file(self, latex_cmd, from_dir, path):
+        """Builds a single pdf file using latex_cmd"""
+        try:
+            subprocess.run(latex_cmd + [path],
+                            cwd=from_dir, check=True)
+
+            return True
+        except subprocess.CalledProcessError:
+            # LaTeX PDF error code is almost useless: it returns
+            # error codes even when build succeeds but has warnings.
+            # So, we'll ignore the results
+            return False
+
+    def pdf_parallel_build(self, tex_suffix, latex_cmd, tex_files, n_jobs):
+        """Build PDF files in parallel if possible"""
+        builds = {}
+        build_failed = False
+        max_len = 0
+        has_tex = False
+
+        # Process files in parallel
+        with futures.ThreadPoolExecutor(max_workers=n_jobs) as executor:
+            jobs = {}
+
+            for from_dir, pdf_dir, entry in tex_files:
+                name = entry.name
+
+                if not name.endswith(tex_suffix):
+                    continue
+
+                name = name[:-len(tex_suffix)]
+
+                max_len = max(max_len, len(name))
+
+                has_tex = True
+
+                future = executor.submit(self.build_pdf_file, latex_cmd,
+                                         from_dir, entry.path)
+                jobs[future] = (from_dir, name, entry.path)
+
+            for future in futures.as_completed(jobs):
+                from_dir, name, path = jobs[future]
+
+                pdf_name = name + ".pdf"
+                pdf_from = os.path.join(from_dir, pdf_name)
+
+                try:
+                    success = future.result()
+
+                    if success and os.path.exists(pdf_from):
+                        pdf_to = os.path.join(pdf_dir, pdf_name)
+
+                        os.rename(pdf_from, pdf_to)
+                        builds[name] = os.path.relpath(pdf_to, self.builddir)
+                    else:
+                        builds[name] = "FAILED"
+                        build_failed = True
+                except Exception as e:
+                    builds[name] = f"FAILED ({str(e)})"
+                    build_failed = True
+
+        # Handle case where no .tex files were found
+        if not has_tex:
+            name = "Sphinx LaTeX builder"
+            max_len = max(max_len, len(name))
+            builds[name] = "FAILED (no .tex file was generated)"
+            build_failed = True
+
+        return builds, build_failed, max_len
+
     def handle_pdf(self, output_dirs):
         """
         Extra steps for PDF output.
@@ -305,7 +376,10 @@ class SphinxBuilder:
         """
         builds = {}
         max_len = 0
+        tex_suffix = ".tex"
 
+        # Get all tex files that will be used for PDF build
+        tex_files = []
         for from_dir in output_dirs:
             pdf_dir = os.path.join(from_dir, "../pdf")
             os.makedirs(pdf_dir, exist_ok=True)
@@ -317,49 +391,46 @@ class SphinxBuilder:
 
             latex_cmd.extend(shlex.split(self.latexopts))
 
-            tex_suffix = ".tex"
-
-            # Process each .tex file
-            has_tex = False
-            build_failed = False
+            # Get a list of tex files to process
             with os.scandir(from_dir) as it:
                 for entry in it:
-                    if not entry.name.endswith(tex_suffix):
-                        continue
+                    if entry.name.endswith(tex_suffix):
+                        tex_files.append((from_dir, pdf_dir, entry))
 
-                    name = entry.name[:-len(tex_suffix)]
-                    has_tex = True
+        # When using make, this won't be used, as the number of jobs comes
+        # from POSIX jobserver. So, this covers the case where build comes
+        # from command line. On such case, serialize by default, except if
+        # the user explicitly sets the number of jobs.
+        n_jobs = 1
 
-                    try:
-                        subprocess.run(latex_cmd + [entry.path],
-                                       cwd=from_dir, check=True)
-                    except subprocess.CalledProcessError:
-                        # LaTeX PDF error code is almost useless: it returns
-                        # error codes even when build succeeds but has warnings.
-                        pass
+        # n_jobs is either an integer or "auto". Only use it if it is a number
+        if self.n_jobs:
+            try:
+                n_jobs = int(self.n_jobs)
+            except ValueError:
+                pass
 
-                    # Instead of checking errors, let's do the next best thing:
-                    # check if the PDF file was actually created.
+        # When using make, jobserver.claim is the number of jobs that were
+        # used with "-j" and that aren't used by other make targets
+        with JobserverExec() as jobserver:
+            n_jobs = 1
 
-                    pdf_name = name + ".pdf"
-                    pdf_from = os.path.join(from_dir, pdf_name)
-                    pdf_to = os.path.join(pdf_dir, pdf_name)
+            # Handle the case when a parameter is passed via command line,
+            # using it as default, if jobserver doesn't claim anything
+            if self.n_jobs:
+                try:
+                    n_jobs = int(self.n_jobs)
+                except ValueError:
+                    pass
 
-                    if os.path.exists(pdf_from):
-                        os.rename(pdf_from, pdf_to)
-                        builds[name] = os.path.relpath(pdf_to, self.builddir)
-                    else:
-                        builds[name] = "FAILED"
-                        build_failed = True
+            if jobserver.claim:
+                n_jobs = jobserver.claim
 
-                    name = entry.name.removesuffix(".tex")
-                    max_len = max(max_len, len(name))
-
-            if not has_tex:
-                name = os.path.basename(from_dir)
-                max_len = max(max_len, len(name))
-                builds[name] = "FAILED (no .tex)"
-                build_failed = True
+            # Build files in parallel
+            builds, build_failed, max_len = self.pdf_parallel_build(tex_suffix,
+                                                                    latex_cmd,
+                                                                    tex_files,
+                                                                    n_jobs)
 
         msg = "Summary"
         msg += "\n" + "=" * len(msg)
-- 
2.50.1


