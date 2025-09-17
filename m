Return-Path: <linux-kernel+bounces-820639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD07B7D1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1271C08905
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8628332898E;
	Wed, 17 Sep 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmvoOSL0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4C3728B6;
	Wed, 17 Sep 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111357; cv=none; b=gl6sl6vlJ/qZ1djCdT3eQu49I8jLQfnazg1L4oauVL/kOK/U2OoRA+qK3CJdRspxYc7QUw3iFoeN2IMKgQZSsGjkLi4LHgHaLvn+Nsk9qsl9efFOQeRqLIPh7mj/VQli6t/YRcCODdjFc+CpIyV9aezKYSYdNfYohNHNeyFpDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111357; c=relaxed/simple;
	bh=Pbt/uH3/UgM6ew/nk/FSpaBLbop272L8YPcfdZN28/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvcljgq9gXT3jrH2CMjLu+QhEfLG1Q8+dYA+ofw4wBCP8nW81mxwmhDzFfQrXmSQDM4g4Dqk25XsYpW1chcq2kkcWGpeWsRmPo2Za6bX9M2Spg3jdr0bOV4EXJXWz0Zx2i0oxO6R4EllXSqHe6BzZmz54GjGuUeQbAgAL+VGj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmvoOSL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14EAC4CEFD;
	Wed, 17 Sep 2025 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111356;
	bh=Pbt/uH3/UgM6ew/nk/FSpaBLbop272L8YPcfdZN28/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmvoOSL0CsnT8QTxitmP48dsarh/Et5dMpv6mosIMl1y8gaXJN42II6loeIE4p314
	 jbe2AyS29p/2i5DS7Dlzx6ZuL37IWhd56tWuXTfZeKr0LdGujIu6mbJ7y+eUWhCgrE
	 auH++UuJK9e98rSYcrW5LsxuxYVWyGziRDCD5GfzLLXVlhJg1GrjoWHYi8ND+uVG08
	 GvCV6a8b5hQcws2dhcStwsLlK4IfwD3PoGIpsfzVu1pBEm+BIpJbV/M8SnkKd1Q6pM
	 FZ9EuUf7ag2StayO1FqeHa/Co7zi5pP9q4OjMRYN+vBhBVcC2wXOc/SAZ5oEs0LxeT
	 NA+rLOaDafCBg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGeC-1xOE;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 16/24] tools/docs: sphinx-build-wrapper: allow building PDF files in parallel
Date: Wed, 17 Sep 2025 14:15:10 +0200
Message-ID: <cd325e4e2cb0c6fb10457dddadc4df70ab20c201.1758111077.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758111077.git.mchehab+huawei@kernel.org>
References: <cover.1758111077.git.mchehab+huawei@kernel.org>
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
 tools/docs/sphinx-build-wrapper | 218 +++++++++++++++++++++++---------
 1 file changed, 156 insertions(+), 62 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 50761f125bc9..0fe21b343e7a 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -51,6 +51,8 @@ import shutil
 import subprocess
 import sys
 
+from concurrent import futures
+
 from lib.python_version import PythonVersion
 from lib.latex_fonts import LatexFontChecker
 
@@ -291,6 +293,87 @@ class SphinxBuilder:
         except (OSError, IOError) as e:
             print(f"Warning: Failed to copy CSS: {e}", file=sys.stderr)
 
+    def build_pdf_file(self, latex_cmd, from_dir, path):
+        """Builds a single pdf file using latex_cmd"""
+        try:
+            subprocess.run(latex_cmd + [path],
+                            cwd=from_dir, check=True, env=self.env)
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
+
+                        #
+                        # if verbose, get the name of built PDF file
+                        #
+                        if self.verbose:
+                           builds[name] = os.path.relpath(pdf_to, self.builddir)
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
     def handle_pdf(self, output_dirs, deny_vf):
         """
         Extra steps for PDF output.
@@ -301,6 +384,8 @@ class SphinxBuilder:
         """
         builds = {}
         max_len = 0
+        tex_suffix = ".tex"
+        tex_files = []
 
         #
         # Since early 2024, Fedora and openSUSE tumbleweed have started
@@ -327,74 +412,83 @@ class SphinxBuilder:
 
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
-
-                    name = entry.name[:-len(tex_suffix)]
-                    has_tex = True
-
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
-                                       cwd=from_dir, check=True, env=self.env)
-                    except subprocess.CalledProcessError:
-                        pass
-
-                    pdf_name = name + ".pdf"
-                    pdf_from = os.path.join(from_dir, pdf_name)
-                    pdf_to = os.path.join(pdf_dir, pdf_name)
-
-                    if os.path.exists(pdf_from):
-                        os.rename(pdf_from, pdf_to)
-                        builds[name] = os.path.relpath(pdf_to, self.builddir)
-                    else:
-                        builds[name] = "FAILED"
-                        build_failed = True
-
-                    name = entry.name.removesuffix(".tex")
-                    max_len = max(max_len, len(name))
-
-            if not has_tex:
-                name = os.path.basename(from_dir)
-                max_len = max(max_len, len(name))
-                builds[name] = "FAILED (no .tex)"
-                build_failed = True
-
-        msg = "Summary"
-        msg += "\n" + "=" * len(msg)
-        print()
-        print(msg)
-
-        for pdf_name, pdf_file in builds.items():
-            print(f"{pdf_name:<{max_len}}: {pdf_file}")
-
-        print()
-
-        if build_failed:
+                    if entry.name.endswith(tex_suffix):
+                        tex_files.append((from_dir, pdf_dir, entry))
+
+        #
+        # When using make, this won't be used, as the number of jobs comes
+        # from POSIX jobserver. So, this covers the case where build comes
+        # from command line. On such case, serialize by default, except if
+        # the user explicitly sets the number of jobs.
+        #
+        n_jobs = 1
+
+        # n_jobs is either an integer or "auto". Only use it if it is a number
+        if self.n_jobs:
+            try:
+                n_jobs = int(self.n_jobs)
+            except ValueError:
+                pass
+
+        #
+        # When using make, jobserver.claim is the number of jobs that were
+        # used with "-j" and that aren't used by other make targets
+        #
+        with JobserverExec() as jobserver:
+            n_jobs = 1
+
+            #
+            # Handle the case when a parameter is passed via command line,
+            # using it as default, if jobserver doesn't claim anything
+            #
+            if self.n_jobs:
+                try:
+                    n_jobs = int(self.n_jobs)
+                except ValueError:
+                    pass
+
+            if jobserver.claim:
+                n_jobs = jobserver.claim
+
+            builds, build_failed, max_len = self.pdf_parallel_build(tex_suffix,
+                                                                    latex_cmd,
+                                                                    tex_files,
+                                                                    n_jobs)
+
+        #
+        # In verbose mode, print a summary with the build results per file.
+        # Otherwise, print a single line with all failures, if any.
+        # On both cases, return code 1 indicates build failures,
+        #
+        if self.verbose:
+            msg = "Summary"
+            msg += "\n" + "=" * len(msg)
+            print()
+            print(msg)
+
+            for pdf_name, pdf_file in builds.items():
+                print(f"{pdf_name:<{max_len}}: {pdf_file}")
+
+            print()
+            if build_failed:
+                msg = LatexFontChecker().check()
+                if msg:
+                    print(msg)
+
+                sys.exit("Error: not all PDF files were created.")
+
+        elif build_failed:
+            n_failures = len(builds)
+            failures = ", ".join(builds.keys())
+
             msg = LatexFontChecker().check()
             if msg:
                 print(msg)
 
-            sys.exit("PDF build failed: not all PDF files were created.")
-        else:
-            print("All PDF files were built.")
+            sys.exit(f"Error: Can't build {n_failures} PDF file(s): {failures}")
 
     def handle_info(self, output_dirs):
         """
-- 
2.51.0


