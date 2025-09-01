Return-Path: <linux-kernel+bounces-794817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA8B3E798
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CB87B07B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F584341AD6;
	Mon,  1 Sep 2025 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyITw5k8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A053431EF;
	Mon,  1 Sep 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737758; cv=none; b=njP9veTf0V5Hw0q1O5ITxzRScTJm9uR0L1zoKIqfHhphnG5LWFcMl9GIa3lQ4ttpO4DBeg2Lxr/XPFrsXNgnkNL6TXvqPFw/o4TUyFJNeMLXMNXiHSpdU6xYj6UGotEmBExbNs35/CZdEeafWwp8Jv0YzVdOjrilNwHkuElQzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737758; c=relaxed/simple;
	bh=GXdIZYgZXOUywbntK26Nh9NT9EDQqDYFjNsBclOQiSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TSTb8hnsJeENDJMwvilrZ9nrFp9ySYV92cdGFM0T8d/HoP/Ytq5vVQ0LOdt573a3oeu3BuzbaaLCXON9KK91ALP0KOhNp98uWqJTuDNefJ10s9MK3ww9GkRkNuQRz0MxQ46epd42772kRkFANxepu6xvkD+hx/OCnVfpWOjK/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyITw5k8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6610EC4CEFC;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737757;
	bh=GXdIZYgZXOUywbntK26Nh9NT9EDQqDYFjNsBclOQiSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FyITw5k8sv2hC88ynb8tvJfbvdN4RyCh19hRfyPRTqPIuuDry2j6CQSoj8sEpPT7B
	 lBTqWqlOkrE8O590Yc1A6eyTW5X/8XJtt3pDLRSQsraFlQWA/dcXCq/CQUZmIZNWTG
	 jA0M3IvLx45aAC8DStdXMXwKG/YSJxp9w02FqfmKfgbk1LcmjHjY3sWQXOOfL+gXDq
	 pvnCCaZT8k9dtOFNtvmW1YQEDDQ1l4vGjNpRbhmxNWhGlKPwcbZYhma6zT4A7SQ+64
	 idwBKkESUM9J3oq+UoWBctA4z1xPjNHiyfFszv5jwbzM6z02Eko96jeUpJte8ITa5E
	 A5p0bAZcfuB/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut5jv-00000003G3Y-2jQ9;
	Mon, 01 Sep 2025 16:42:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <mchehab+huawei@kernel.org>,
	Benno Lossin <mchehab+huawei@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <mchehab+huawei@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Miguel Ojeda <mchehab+huawei@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 07/15] tools/docs: sphinx-build-wrapper: add comments and
  blank lines
Date: Mon,  1 Sep 2025 16:42:23 +0200
Message-ID: <9669d75bf1b5406772192e0d7a96a20a2cde9e00.1756737440.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756737440.git.mchehab+huawei@kernel.org>
References: <cover.1756737440.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

To help seing the actual size of the script when it was added,=0D
I opted to strip out all comments from the original script.=0D
=0D
Add them here:=0D
=0D
 tools/docs/sphinx-build-wrapper | 261 +++++++++++++++++++++++++++++++-=0D
 1 file changed, 257 insertions(+), 4 deletion(-)=0D
=0D
As the code from the script has 288 lines of code, it means that=0D
about half of the script are comments.=0D
=0D
Also ensure pylint won't report any warnings.=0D
=0D
No functional changes.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 tools/docs/sphinx-build-wrapper | 261 +++++++++++++++++++++++++++++++-=0D
 1 file changed, 257 insertions(+), 4 deletions(-)=0D
=0D
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrap=
per=0D
index df469af8a4ef..e9c522794fbe 100755=0D
--- a/tools/docs/sphinx-build-wrapper=0D
+++ b/tools/docs/sphinx-build-wrapper=0D
@@ -1,21 +1,71 @@=0D
 #!/usr/bin/env python3=0D
 # SPDX-License-Identifier: GPL-2.0=0D
+# Copyright (C) 2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
+#=0D
+# pylint: disable=3DR0902, R0912, R0913, R0914, R0915, R0917, C0103=0D
+#=0D
+# Converted from docs Makefile and parallel-wrapper.sh, both under=0D
+# GPLv2, copyrighted since 2008 by the following authors:=0D
+#=0D
+#    Akira Yokosawa <akiyks@gmail.com>=0D
+#    Arnd Bergmann <arnd@arndb.de>=0D
+#    Breno Leitao <leitao@debian.org>=0D
+#    Carlos Bilbao <carlos.bilbao@amd.com>=0D
+#    Dave Young <dyoung@redhat.com>=0D
+#    Donald Hunter <donald.hunter@gmail.com>=0D
+#    Geert Uytterhoeven <geert+renesas@glider.be>=0D
+#    Jani Nikula <jani.nikula@intel.com>=0D
+#    Jan Stancek <jstancek@redhat.com>=0D
+#    Jonathan Corbet <corbet@lwn.net>=0D
+#    Joshua Clayton <stillcompiling@gmail.com>=0D
+#    Kees Cook <keescook@chromium.org>=0D
+#    Linus Torvalds <torvalds@linux-foundation.org>=0D
+#    Magnus Damm <damm+renesas@opensource.se>=0D
+#    Masahiro Yamada <masahiroy@kernel.org>=0D
+#    Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
+#    Maxim Cournoyer <maxim.cournoyer@gmail.com>=0D
+#    Peter Foley <pefoley2@pefoley.com>=0D
+#    Randy Dunlap <rdunlap@infradead.org>=0D
+#    Rob Herring <robh@kernel.org>=0D
+#    Shuah Khan <shuahkh@osg.samsung.com>=0D
+#    Thorsten Blum <thorsten.blum@toblux.com>=0D
+#    Tomas Winkler <tomas.winkler@intel.com>=0D
+=0D
+=0D
+"""=0D
+Sphinx build wrapper that handles Kernel-specific business rules:=0D
+=0D
+- it gets the Kernel build environment vars;=0D
+- it determines what's the best parallelism;=0D
+- it handles SPHINXDIRS=0D
+=0D
+This tool ensures that MIN_PYTHON_VERSION is satisfied. If version is=0D
+below that, it seeks for a new Python version. If found, it re-runs using=
=0D
+the newer version.=0D
+"""=0D
+=0D
 import argparse=0D
 import os=0D
 import shlex=0D
 import shutil=0D
 import subprocess=0D
 import sys=0D
+=0D
 from lib.python_version import PythonVersion=0D
 =0D
 LIB_DIR =3D "../../scripts/lib"=0D
 SRC_DIR =3D os.path.dirname(os.path.realpath(__file__))=0D
+=0D
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))=0D
 =0D
-from jobserver import JobserverExec=0D
+from jobserver import JobserverExec         # pylint: disable=3DC0413,C041=
1,E0401=0D
 =0D
+#=0D
+#  Some constants=0D
+#=0D
 MIN_PYTHON_VERSION =3D PythonVersion("3.7").version=0D
 PAPER =3D ["", "a4", "letter"]=0D
+=0D
 TARGETS =3D {=0D
     "cleandocs":     { "builder": "clean" },=0D
     "linkcheckdocs": { "builder": "linkcheck" },=0D
@@ -28,8 +78,19 @@ TARGETS =3D {=0D
     "xmldocs":       { "builder": "xml",     "out_dir": "xml" },=0D
 }=0D
 =0D
+=0D
+#=0D
+# SphinxBuilder class=0D
+#=0D
+=0D
 class SphinxBuilder:=0D
+    """=0D
+    Handles a sphinx-build target, adding needed arguments to build=0D
+    with the Kernel.=0D
+    """=0D
+=0D
     def is_rust_enabled(self):=0D
+        """Check if rust is enabled at .config"""=0D
         config_path =3D os.path.join(self.srctree, ".config")=0D
         if os.path.isfile(config_path):=0D
             with open(config_path, "r", encoding=3D"utf-8") as f:=0D
@@ -37,37 +98,83 @@ class SphinxBuilder:=0D
         return False=0D
 =0D
     def get_path(self, path, abs_path=3DFalse):=0D
+        """=0D
+        Ancillary routine to handle patches the right way, as shell does.=
=0D
+=0D
+        It first expands "~" and "~user". Then, if patch is not absolute,=
=0D
+        join self.srctree. Finally, if requested, convert to abspath.=0D
+        """=0D
+=0D
         path =3D os.path.expanduser(path)=0D
         if not path.startswith("/"):=0D
             path =3D os.path.join(self.srctree, path)=0D
+=0D
         if abs_path:=0D
             return os.path.abspath(path)=0D
+=0D
         return path=0D
 =0D
     def __init__(self, verbose=3DFalse, n_jobs=3DNone):=0D
+        """Initialize internal variables"""=0D
         self.verbose =3D None=0D
+=0D
+        #=0D
+        # Normal variables passed from Kernel's makefile=0D
+        #=0D
         self.kernelversion =3D os.environ.get("KERNELVERSION", "unknown")=
=0D
         self.kernelrelease =3D os.environ.get("KERNELRELEASE", "unknown")=
=0D
         self.pdflatex =3D os.environ.get("PDFLATEX", "xelatex")=0D
         self.latexopts =3D os.environ.get("LATEXOPTS", "-interaction=3Dbat=
chmode -no-shell-escape")=0D
+=0D
         if not verbose:=0D
             verbose =3D bool(os.environ.get("KBUILD_VERBOSE", "") !=3D "")=
=0D
+=0D
         if verbose is not None:=0D
             self.verbose =3D verbose=0D
+=0D
+        #=0D
+        # As we handle number of jobs and quiet in separate, we need to pi=
ck=0D
+        # both the same way as sphinx-build would pick, optionally accepts=
=0D
+        # whitespaces or not. So let's use argparse to handle argument exp=
ansion=0D
+        #=0D
         parser =3D argparse.ArgumentParser()=0D
         parser.add_argument('-j', '--jobs', type=3Dint)=0D
         parser.add_argument('-q', '--quiet', type=3Dint)=0D
+=0D
+        #=0D
+        # Other sphinx-build arguments go as-is, so place them=0D
+        # at self.sphinxopts, using shell parser=0D
+        #=0D
         sphinxopts =3D shlex.split(os.environ.get("SPHINXOPTS", ""))=0D
+=0D
+        #=0D
+        # Build a list of sphinx args=0D
+        #=0D
         sphinx_args, self.sphinxopts =3D parser.parse_known_args(sphinxopt=
s)=0D
         if sphinx_args.quiet is True:=0D
             self.verbose =3D False=0D
+=0D
         if sphinx_args.jobs:=0D
             self.n_jobs =3D sphinx_args.jobs=0D
+=0D
+        #=0D
+        # If the command line argument "-j" is used override SPHINXOPTS=0D
+        #=0D
+=0D
         self.n_jobs =3D n_jobs=0D
+=0D
+        #=0D
+        # Source tree directory. This needs to be at os.environ, as=0D
+        # Sphinx extensions use it=0D
+        #=0D
         self.srctree =3D os.environ.get("srctree")=0D
         if not self.srctree:=0D
             self.srctree =3D "."=0D
             os.environ["srctree"] =3D self.srctree=0D
+=0D
+        #=0D
+        # Now that we can expand srctree, get other directories as well=0D
+        #=0D
         self.sphinxbuild =3D os.environ.get("SPHINXBUILD", "sphinx-build")=
=0D
         self.kerneldoc =3D self.get_path(os.environ.get("KERNELDOC",=0D
                                                       "scripts/kernel-doc.=
py"))=0D
@@ -77,20 +184,36 @@ class SphinxBuilder:=0D
 =0D
         self.config_rust =3D self.is_rust_enabled()=0D
 =0D
+        #=0D
+        # Get directory locations for LaTeX build toolchain=0D
+        #=0D
         self.pdflatex_cmd =3D shutil.which(self.pdflatex)=0D
         self.latexmk_cmd =3D shutil.which("latexmk")=0D
 =0D
         self.env =3D os.environ.copy()=0D
 =0D
     def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):=0D
+        """=0D
+        Executes sphinx-build using current python3 command and setting=0D
+        -j parameter if possible to run the build in parallel.=0D
+        """=0D
+=0D
         with JobserverExec() as jobserver:=0D
             if jobserver.claim:=0D
                 n_jobs =3D str(jobserver.claim)=0D
             else:=0D
                 n_jobs =3D "auto" # Supported since Sphinx 1.7=0D
+=0D
             cmd =3D []=0D
+=0D
             cmd.append(sys.executable)=0D
+=0D
             cmd.append(sphinx_build)=0D
+=0D
+            #=0D
+            # Override auto setting, if explicitly passed from command lin=
e=0D
+            # or via SPHINXOPTS=0D
+            #=0D
             if self.n_jobs:=0D
                 n_jobs =3D str(self.n_jobs)=0D
 =0D
@@ -99,59 +222,100 @@ class SphinxBuilder:=0D
 =0D
             if not self.verbose:=0D
                 cmd.append("-q")=0D
+=0D
             cmd +=3D self.sphinxopts=0D
             cmd +=3D build_args=0D
+=0D
             if self.verbose:=0D
                 print(" ".join(cmd))=0D
             return subprocess.call(cmd, *args, **pwargs)=0D
 =0D
     def handle_html(self, css, output_dir):=0D
+        """=0D
+        Extra steps for HTML and epub output.=0D
+=0D
+        For such targets, we need to ensure that CSS will be properly=0D
+        copied to the output _static directory=0D
+        """=0D
+=0D
         if not css:=0D
             return=0D
+=0D
         css =3D os.path.expanduser(css)=0D
         if not css.startswith("/"):=0D
             css =3D os.path.join(self.srctree, css)=0D
+=0D
         static_dir =3D os.path.join(output_dir, "_static")=0D
         os.makedirs(static_dir, exist_ok=3DTrue)=0D
+=0D
         try:=0D
             shutil.copy2(css, static_dir)=0D
         except (OSError, IOError) as e:=0D
             print(f"Warning: Failed to copy CSS: {e}", file=3Dsys.stderr)=
=0D
 =0D
     def handle_pdf(self, output_dirs):=0D
+        """=0D
+        Extra steps for PDF output.=0D
+=0D
+        As PDF is handled via a LaTeX output, after building the .tex file=
,=0D
+        a new build is needed to create the PDF output from the latex=0D
+        directory.=0D
+        """=0D
         builds =3D {}=0D
         max_len =3D 0=0D
+=0D
         for from_dir in output_dirs:=0D
             pdf_dir =3D os.path.join(from_dir, "../pdf")=0D
             os.makedirs(pdf_dir, exist_ok=3DTrue)=0D
+=0D
             if self.latexmk_cmd:=0D
                 latex_cmd =3D [self.latexmk_cmd, f"-{self.pdflatex}"]=0D
             else:=0D
                 latex_cmd =3D [self.pdflatex]=0D
+=0D
             latex_cmd.extend(shlex.split(self.latexopts))=0D
+=0D
             tex_suffix =3D ".tex"=0D
+=0D
+            #=0D
+            # Process each .tex file=0D
+            #=0D
+=0D
             has_tex =3D False=0D
             build_failed =3D False=0D
             with os.scandir(from_dir) as it:=0D
                 for entry in it:=0D
                     if not entry.name.endswith(tex_suffix):=0D
                         continue=0D
+=0D
                     name =3D entry.name[:-len(tex_suffix)]=0D
                     has_tex =3D True=0D
+=0D
+                    #=0D
+                    # LaTeX PDF error code is almost useless for us:=0D
+                    # any warning makes it non-zero. For kernel doc builds=
 it=0D
+                    # always return non-zero even when build succeeds.=0D
+                    # So, let's do the best next thing: check if all PDF=0D
+                    # files were built. If they're, print a summary and=0D
+                    # return 0 at the end of this function=0D
+                    #=0D
                     try:=0D
                         subprocess.run(latex_cmd + [entry.path],=0D
                                        cwd=3Dfrom_dir, check=3DTrue)=0D
                     except subprocess.CalledProcessError:=0D
                         pass=0D
+=0D
                     pdf_name =3D name + ".pdf"=0D
                     pdf_from =3D os.path.join(from_dir, pdf_name)=0D
                     pdf_to =3D os.path.join(pdf_dir, pdf_name)=0D
+=0D
                     if os.path.exists(pdf_from):=0D
                         os.rename(pdf_from, pdf_to)=0D
                         builds[name] =3D os.path.relpath(pdf_to, self.buil=
ddir)=0D
                     else:=0D
                         builds[name] =3D "FAILED"=0D
                         build_failed =3D True=0D
+=0D
                     name =3D entry.name.removesuffix(".tex")=0D
                     max_len =3D max(max_len, len(name))=0D
 =0D
@@ -160,58 +324,100 @@ class SphinxBuilder:=0D
                 max_len =3D max(max_len, len(name))=0D
                 builds[name] =3D "FAILED (no .tex)"=0D
                 build_failed =3D True=0D
+=0D
         msg =3D "Summary"=0D
         msg +=3D "\n" + "=3D" * len(msg)=0D
         print()=0D
         print(msg)=0D
+=0D
         for pdf_name, pdf_file in builds.items():=0D
             print(f"{pdf_name:<{max_len}}: {pdf_file}")=0D
+=0D
         print()=0D
+=0D
         if build_failed:=0D
             sys.exit("PDF build failed: not all PDF files were created.")=
=0D
         else:=0D
             print("All PDF files were built.")=0D
 =0D
     def handle_info(self, output_dirs):=0D
+        """=0D
+        Extra steps for Info output.=0D
+=0D
+        For texinfo generation, an additional make is needed from the=0D
+        texinfo directory.=0D
+        """=0D
+=0D
         for output_dir in output_dirs:=0D
             try:=0D
                 subprocess.run(["make", "info"], cwd=3Doutput_dir, check=
=3DTrue)=0D
             except subprocess.CalledProcessError as e:=0D
                 sys.exit(f"Error generating info docs: {e}")=0D
 =0D
-    def cleandocs(self, builder):=0D
+    def cleandocs(self, builder):           # pylint: disable=3DW0613=0D
+        """Remove documentation output directory"""=0D
         shutil.rmtree(self.builddir, ignore_errors=3DTrue)=0D
 =0D
     def build(self, target, sphinxdirs=3DNone, conf=3D"conf.py",=0D
               theme=3DNone, css=3DNone, paper=3DNone):=0D
+        """=0D
+        Build documentation using Sphinx. This is the core function of thi=
s=0D
+        module. It prepares all arguments required by sphinx-build.=0D
+        """=0D
+=0D
         builder =3D TARGETS[target]["builder"]=0D
         out_dir =3D TARGETS[target].get("out_dir", "")=0D
+=0D
+        #=0D
+        # Cleandocs doesn't require sphinx-build=0D
+        #=0D
         if target =3D=3D "cleandocs":=0D
             self.cleandocs(builder)=0D
             return=0D
+=0D
         if theme:=0D
-                os.environ["DOCS_THEME"] =3D theme=0D
+            os.environ["DOCS_THEME"] =3D theme=0D
+=0D
+        #=0D
+        # Other targets require sphinx-build, so check if it exists=0D
+        #=0D
         sphinxbuild =3D shutil.which(self.sphinxbuild, path=3Dself.env["PA=
TH"])=0D
         if not sphinxbuild:=0D
             sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")=0D
+=0D
         if builder =3D=3D "latex":=0D
             if not self.pdflatex_cmd and not self.latexmk_cmd:=0D
                 sys.exit("Error: pdflatex or latexmk required for PDF gene=
ration")=0D
+=0D
         docs_dir =3D os.path.abspath(os.path.join(self.srctree, "Documenta=
tion"))=0D
+=0D
+        #=0D
+        # Fill in base arguments for Sphinx build=0D
+        #=0D
         kerneldoc =3D self.kerneldoc=0D
         if kerneldoc.startswith(self.srctree):=0D
             kerneldoc =3D os.path.relpath(kerneldoc, self.srctree)=0D
+=0D
         args =3D [ "-b", builder, "-c", docs_dir ]=0D
+=0D
         if builder =3D=3D "latex":=0D
             if not paper:=0D
                 paper =3D PAPER[1]=0D
+=0D
             args.extend(["-D", f"latex_elements.papersize=3D{paper}paper"]=
)=0D
+=0D
         if self.config_rust:=0D
             args.extend(["-t", "rustdoc"])=0D
+=0D
         if conf:=0D
             self.env["SPHINX_CONF"] =3D self.get_path(conf, abs_path=3DTru=
e)=0D
+=0D
         if not sphinxdirs:=0D
             sphinxdirs =3D os.environ.get("SPHINXDIRS", ".")=0D
+=0D
+        #=0D
+        # sphinxdirs can be a list or a whitespace-separated string=0D
+        #=0D
         sphinxdirs_list =3D []=0D
         for sphinxdir in sphinxdirs:=0D
             if isinstance(sphinxdir, list):=0D
@@ -219,17 +425,32 @@ class SphinxBuilder:=0D
             else:=0D
                 for name in sphinxdir.split(" "):=0D
                     sphinxdirs_list.append(name)=0D
+=0D
+        #=0D
+        # Step 1:  Build each directory in separate.=0D
+        #=0D
+        # This is not the best way of handling it, as cross-references bet=
ween=0D
+        # them will be broken, but this is what we've been doing since=0D
+        # the beginning.=0D
+        #=0D
         output_dirs =3D []=0D
         for sphinxdir in sphinxdirs_list:=0D
             src_dir =3D os.path.join(docs_dir, sphinxdir)=0D
             doctree_dir =3D os.path.join(self.builddir, ".doctrees")=0D
             output_dir =3D os.path.join(self.builddir, sphinxdir, out_dir)=
=0D
+=0D
+            #=0D
+            # Make directory names canonical=0D
+            #=0D
             src_dir =3D os.path.normpath(src_dir)=0D
             doctree_dir =3D os.path.normpath(doctree_dir)=0D
             output_dir =3D os.path.normpath(output_dir)=0D
+=0D
             os.makedirs(doctree_dir, exist_ok=3DTrue)=0D
             os.makedirs(output_dir, exist_ok=3DTrue)=0D
+=0D
             output_dirs.append(output_dir)=0D
+=0D
             build_args =3D args + [=0D
                 "-d", doctree_dir,=0D
                 "-D", f"kerneldoc_bin=3D{kerneldoc}",=0D
@@ -239,48 +460,80 @@ class SphinxBuilder:=0D
                 src_dir,=0D
                 output_dir,=0D
             ]=0D
+=0D
             try:=0D
                 self.run_sphinx(sphinxbuild, build_args, env=3Dself.env)=0D
             except (OSError, ValueError, subprocess.SubprocessError) as e:=
=0D
                 sys.exit(f"Build failed: {repr(e)}")=0D
+=0D
+            #=0D
+            # Ensure that each html/epub output will have needed static fi=
les=0D
+            #=0D
             if target in ["htmldocs", "epubdocs"]:=0D
                 self.handle_html(css, output_dir)=0D
+=0D
+        #=0D
+        # Step 2: Some targets (PDF and info) require an extra step once=0D
+        #         sphinx-build finishes=0D
+        #=0D
         if target =3D=3D "pdfdocs":=0D
             self.handle_pdf(output_dirs)=0D
         elif target =3D=3D "infodocs":=0D
             self.handle_info(output_dirs)=0D
 =0D
 def jobs_type(value):=0D
+    """=0D
+    Handle valid values for -j. Accepts Sphinx "-jauto", plus a number=0D
+    equal or bigger than one.=0D
+    """=0D
     if value is None:=0D
         return None=0D
+=0D
     if value.lower() =3D=3D 'auto':=0D
         return value.lower()=0D
+=0D
     try:=0D
         if int(value) >=3D 1:=0D
             return value=0D
+=0D
         raise argparse.ArgumentTypeError(f"Minimum jobs is 1, got {value}"=
)=0D
     except ValueError:=0D
-        raise argparse.ArgumentTypeError(f"Must be 'auto' or positive inte=
ger, got {value}")=0D
+        raise argparse.ArgumentTypeError(f"Must be 'auto' or positive inte=
ger, got {value}")  # pylint: disable=3DW0707=0D
 =0D
 def main():=0D
+    """=0D
+    Main function. The only mandatory argument is the target. If not=0D
+    specified, the other arguments will use default values if not=0D
+    specified at os.environ.=0D
+    """=0D
     parser =3D argparse.ArgumentParser(description=3D"Kernel documentation=
 builder")=0D
+=0D
     parser.add_argument("target", choices=3Dlist(TARGETS.keys()),=0D
                         help=3D"Documentation target to build")=0D
     parser.add_argument("--sphinxdirs", nargs=3D"+",=0D
                         help=3D"Specific directories to build")=0D
     parser.add_argument("--conf", default=3D"conf.py",=0D
                         help=3D"Sphinx configuration file")=0D
+=0D
     parser.add_argument("--theme", help=3D"Sphinx theme to use")=0D
+=0D
     parser.add_argument("--css", help=3D"Custom CSS file for HTML/EPUB")=0D
+=0D
     parser.add_argument("--paper", choices=3DPAPER, default=3DPAPER[0],=0D
                         help=3D"Paper size for LaTeX/PDF output")=0D
+=0D
     parser.add_argument("-v", "--verbose", action=3D'store_true',=0D
                         help=3D"place build in verbose mode")=0D
+=0D
     parser.add_argument('-j', '--jobs', type=3Djobs_type,=0D
                         help=3D"Sets number of jobs to use with sphinx-bui=
ld")=0D
+=0D
     args =3D parser.parse_args()=0D
+=0D
     PythonVersion.check_python(MIN_PYTHON_VERSION)=0D
+=0D
     builder =3D SphinxBuilder(verbose=3Dargs.verbose, n_jobs=3Dargs.jobs)=
=0D
+=0D
     builder.build(args.target, sphinxdirs=3Dargs.sphinxdirs, conf=3Dargs.c=
onf,=0D
                   theme=3Dargs.theme, css=3Dargs.css, paper=3Dargs.paper)=
=0D
 =0D
-- =0D
2.51.0=0D
=0D

