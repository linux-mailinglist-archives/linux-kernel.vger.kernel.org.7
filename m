Return-Path: <linux-kernel+bounces-820626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB8EB7D0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06CC1C012A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA3B3233EF;
	Wed, 17 Sep 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3KQxy18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B831A7EE;
	Wed, 17 Sep 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111355; cv=none; b=ksnt/+2YaANtJhh6kDyoRSEfVKY320NOCtH9d73QCX9D5f2bj4YQz/O0CxAPkl4KCDaKyThVKTDFfnhWT2+Yr9ubjdRigYo9ytoDGhB6e/U7rNwmdBCL7uKQ3KhDh5tyuteEg15PBL0cm6FRz8LAnfKzR9Conh0f5bootaFYh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111355; c=relaxed/simple;
	bh=5h0Y2l0VICf3uSdAhL346MOGEeZeAoHZKXVIcjeYSFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNonKc8OuCR337vSk4mUOpS7PQiy0M6K0REW9Bw9ggUVtU7t9bsCfIWUAHANb++DeOWsPChAGBwOnsFHAAD0LdWp8bl/CZHbigg+lmo84SWqR2qnfm3DWbcLb0UK79zSsm9+0tAdXZGADA2e62rB0NeWnUKfrWQ202G/ZKSBH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3KQxy18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA34C4CEFC;
	Wed, 17 Sep 2025 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111355;
	bh=5h0Y2l0VICf3uSdAhL346MOGEeZeAoHZKXVIcjeYSFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3KQxy18stTFku7K5UzoFyBSpJmbElGYMZjjhl7ncGUbf1p/K6TAiSYrpLYpxBFAs
	 ySYpHUQDNHeyapWE6lpDiq8VVS1eWtIf9oGC5hy9yLrV5NZXJ9cNQXO1/VTIhSUCk8
	 HJVFaLTWLjTQ9SP01TnmMx5lQxe6/cqwpzHG6QpPCsqBcO74zU3RnVEiAeUDjSxj0l
	 kxDj1tbZf/h+1MDCDICfy31cFX9qUEPfiMOWgRcQXknCFtSsGOwzciEQ4Ilk+qymQU
	 e8u+ZLyVBdKtGWUbETOzQ8Jk65EEElOF0g0ZtBG123/xjMDHJVlLb3C0+2h8kkOMMy
	 y/Sc6L+ax6kbQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGei-2tcX;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 24/24] tools/docs: sphinx-build-wrapper: add support to run inside venv
Date: Wed, 17 Sep 2025 14:15:18 +0200
Message-ID: <8372cc28d0f91a133da98c5cb8b005c3dbffdc23.1758111077.git.mchehab+huawei@kernel.org>
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

Sometimes, it is desired to run Sphinx from a virtual environment.
Add a command line parameter to automatically build Sphinx from
such environment.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 103b0044bb0b..6ed3d58ec277 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -69,6 +69,7 @@ from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
 #
 #  Some constants
 #
+VENV_DEFAULT = "sphinx_latest"
 MIN_PYTHON_VERSION = PythonVersion("3.7").version
 PAPER = ["", "a4", "letter"]
 
@@ -171,8 +172,10 @@ class SphinxBuilder:
         if not verbose:
             self.sphinxopts += ["-q"]
 
-    def __init__(self, builddir, verbose=False, n_jobs=None, interactive=None):
+    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None,
+                 interactive=None):
         """Initialize internal variables"""
+        self.venv = venv
         self.verbose = None
 
         #
@@ -220,6 +223,21 @@ class SphinxBuilder:
 
         self.get_sphinx_extra_opts(n_jobs)
 
+        #
+        # If venv command line argument is specified, run Sphinx from venv
+        #
+        if venv:
+            bin_dir = os.path.join(venv, "bin")
+            if not os.path.isfile(os.path.join(bin_dir, "activate")):
+                sys.exit(f"Venv {venv} not found.")
+
+            # "activate" virtual env
+            self.env["PATH"] = bin_dir + ":" + self.env["PATH"]
+            self.env["VIRTUAL_ENV"] = venv
+            if "PYTHONHOME" in self.env:
+                del self.env["PYTHONHOME"]
+            print(f"Setting venv to {venv}")
+
     def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):
         """
         Executes sphinx-build using current python3 command.
@@ -254,7 +272,12 @@ class SphinxBuilder:
             if self.n_jobs:
                 n_jobs = str(self.n_jobs)
 
-            cmd = [sys.executable, sphinx_build]
+            if self.venv:
+                cmd = ["python"]
+            else:
+                cmd = [sys.executable,]
+
+            cmd += [sphinx_build]
             cmd += [f"-j{n_jobs}"]
             cmd += self.sphinxopts
             cmd += build_args
@@ -772,12 +795,16 @@ def main():
     parser.add_argument('-i', '--interactive', action='store_true',
                         help="Change latex default to run in interactive mode")
 
+    parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
+                        default=None,
+                        help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
+
     args = parser.parse_args()
 
     PythonVersion.check_python(MIN_PYTHON_VERSION, show_alternatives=True,
                                bail_out=True)
 
-    builder = SphinxBuilder(builddir=args.builddir,
+    builder = SphinxBuilder(builddir=args.builddir, venv=args.venv,
                             verbose=args.verbose, n_jobs=args.jobs,
                             interactive=args.interactive)
 
-- 
2.51.0


