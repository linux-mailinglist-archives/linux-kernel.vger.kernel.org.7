Return-Path: <linux-kernel+bounces-813849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7764DB54B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E91A1BC3F09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2E306480;
	Fri, 12 Sep 2025 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+LiSyzw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194DE30148D;
	Fri, 12 Sep 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677595; cv=none; b=ZIgTHaYJ/Yb6jJscFPi5Wc+kAaxRzUPDeMM5n5FMDikVqaEmmDu92nhuaJ01sGxQFSHgN2PwY8SFwe8Dcy1oyOhYGBGbMG0gIRSjfEPyagItX4kWGRpcFTsHUGU+PVYX92SMq56uqIXfbrmVMTl9uE9mnY82vzWKrcEmI4UiMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677595; c=relaxed/simple;
	bh=Oh6mMFUZNaaDz2lQnoLmBkYKDyszlEG8OhnySt8zzKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETEvOBpHKMLSwNE1fORcQvBRPNaFOO0vRb96B5uZlqJQDSwIuuDZxQSo+idj98cn+1rK0kyPVQHI/mqkgZ7KpfMzWsh5aRq4GV++KGKxEXLgJeqsv9G4gJEPuTQxV1P1JjwnqGrwpSx7CECsDEiNlHWglLt2QjbzcvlzsbKBuhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+LiSyzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89821C113D0;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677594;
	bh=Oh6mMFUZNaaDz2lQnoLmBkYKDyszlEG8OhnySt8zzKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+LiSyzwKblcwydcePDwkp1aMviaFVLTpJPkjpyxppVjV6dU/T0wx0BdBXHHqfefv
	 XFGyInrgHuMpurQQwEqC5i1p4HgacVVtlIb2LP9ek+c4ogk+ey3EbD6RadRjvxBWKg
	 2j6cY6iR2edbQYu5rkMHSCOx1esQiwzbSQ8wYSgYS1HIb1g/w/MgtgdG+BVgRwWs0S
	 ni55hdvddVHSJWpj1jQCv/OFpDmT7he/cMGaZGLcyFH8m39m8KuOotMxlxDNKDv5px
	 cMYfkT322JN9Ss33nb5enB+GXxaESlnvrQS8hp7XE+CMFOaWt9+wTHp/lzYJzKeUw6
	 MZeL4ZDRwb6Xg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux2Ea-00000008Rsn-3Xx7;
	Fri, 12 Sep 2025 13:46:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/18] tools/docs: sphinx-build-wrapper: allow building PDF files in parallel
Date: Fri, 12 Sep 2025 13:46:21 +0200
Message-ID: <357091cecbbce5663fd50f532cde5eb322c41cae.1757677427.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757677427.git.mchehab+huawei@kernel.org>
References: <cover.1757677427.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 158 +++++++++++++++++++++++---------
 1 file changed, 117 insertions(+), 41 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 465896e628fd..d66bb337ba1f 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -52,6 +52,8 @@ import shutil
 import subprocess
 import sys
 
+from concurrent import futures
+
 from lib.python_version import PythonVersion
 
 LIB_DIR = "../../scripts/lib"
@@ -314,6 +316,82 @@ class SphinxBuilder:
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
+            return False
+
+    def pdf_parallel_build(self, tex_suffix, latex_cmd, tex_files, n_jobs):
+        """Build PDF files in parallel if possible"""
+        builds = {}
+        build_failed = False
+        max_len = 0
+        has_tex = False
+
+        #
+        # LaTeX PDF error code is almost useless for us:
+        # any warning makes it non-zero. For kernel doc builds it always return
+        # non-zero even when build succeeds. So, let's do the best next thing:
+        # Ignore build errors. At the end, check if all PDF files were built,
+        # printing a summary with the built ones and returning 0 if all of
+        # them were actually built.
+        #
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
+                jobs[future] = (from_dir, pdf_dir, name)
+
+            for future in futures.as_completed(jobs):
+                from_dir, pdf_dir, name = jobs[future]
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
+                except futures.Error as e:
+                    builds[name] = f"FAILED ({repr(e)})"
+                    build_failed = True
+
+        #
+        # Handle case where no .tex files were found
+        #
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
@@ -324,7 +402,9 @@ class SphinxBuilder:
         """
         builds = {}
         max_len = 0
+        tex_suffix = ".tex"
 
+        tex_files = []
         for from_dir in output_dirs:
             pdf_dir = os.path.join(from_dir, "../pdf")
             os.makedirs(pdf_dir, exist_ok=True)
@@ -336,55 +416,51 @@ class SphinxBuilder:
 
             latex_cmd.extend(shlex.split(self.latexopts))
 
-            tex_suffix = ".tex"
-
-            #
-            # Process each .tex file
-            #
-
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
+        #
+        # When using make, this won't be used, as the number of jobs comes
+        # from POSIX jobserver. So, this covers the case where build comes
+        # from command line. On such case, serialize by default, except if
+        # the user explicitly sets the number of jobs.
+        #
+        n_jobs = 1
 
-                    #
-                    # LaTeX PDF error code is almost useless for us:
-                    # any warning makes it non-zero. For kernel doc builds it
-                    # always return non-zero even when build succeeds.
-                    # So, let's do the best next thing: check if all PDF
-                    # files were built. If they're, print a summary and
-                    # return 0 at the end of this function
-                    #
-                    try:
-                        subprocess.run(latex_cmd + [entry.path],
-                                       cwd=from_dir, check=True)
-                    except subprocess.CalledProcessError:
-                        pass
+        # n_jobs is either an integer or "auto". Only use it if it is a number
+        if self.n_jobs:
+            try:
+                n_jobs = int(self.n_jobs)
+            except ValueError:
+                pass
 
-                    pdf_name = name + ".pdf"
-                    pdf_from = os.path.join(from_dir, pdf_name)
-                    pdf_to = os.path.join(pdf_dir, pdf_name)
+        #
+        # When using make, jobserver.claim is the number of jobs that were
+        # used with "-j" and that aren't used by other make targets
+        #
+        with JobserverExec() as jobserver:
+            n_jobs = 1
 
-                    if os.path.exists(pdf_from):
-                        os.rename(pdf_from, pdf_to)
-                        builds[name] = os.path.relpath(pdf_to, self.builddir)
-                    else:
-                        builds[name] = "FAILED"
-                        build_failed = True
+            #
+            # Handle the case when a parameter is passed via command line,
+            # using it as default, if jobserver doesn't claim anything
+            #
+            if self.n_jobs:
+                try:
+                    n_jobs = int(self.n_jobs)
+                except ValueError:
+                    pass
 
-                    name = entry.name.removesuffix(".tex")
-                    max_len = max(max_len, len(name))
+            if jobserver.claim:
+                n_jobs = jobserver.claim
 
-            if not has_tex:
-                name = os.path.basename(from_dir)
-                max_len = max(max_len, len(name))
-                builds[name] = "FAILED (no .tex)"
-                build_failed = True
+            builds, build_failed, max_len = self.pdf_parallel_build(tex_suffix,
+                                                                    latex_cmd,
+                                                                    tex_files,
+                                                                    n_jobs)
 
         msg = "Summary"
         msg += "\n" + "=" * len(msg)
-- 
2.51.0


