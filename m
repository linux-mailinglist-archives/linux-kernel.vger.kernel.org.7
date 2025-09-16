Return-Path: <linux-kernel+bounces-818587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DA5B59396
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0F6B4E1A80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34730DEC8;
	Tue, 16 Sep 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRb5xgl7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E23074AC;
	Tue, 16 Sep 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018219; cv=none; b=uQ06tAaOyk0IMQKj2sENsocITUsaHKxjKVULZKShQjWtkdOgsiz+RFchK8LcSk5/FY3hM70lhXS3NWMQVV5UXPIDCpJJFHV8m3z5ErJmkWvRL6DSBKU5i56nfltcEYgbVQESjaaaGPyKr3c0DQn2CgMUOKuX7deUI/2QUprMfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018219; c=relaxed/simple;
	bh=bnuRSZ5VgKW9EMMlXkntotHnx/AGBzkicE3rznCRcFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CL4SvJHTeqRXQ8ZSSu6hxOFnYV9Ujr//3K33DNevpYlaTa3ewUK5cbSnTgcct68ssrM0v3zKWbm3fgpmketln9U6HbcB25fiJs8mXenwclDTF8d1WJrvCLbYubiQB0VXnPm/E73gOom4YreuMLImZUskBaCe+SNvqGlfNpRGkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRb5xgl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C258C4CEFC;
	Tue, 16 Sep 2025 10:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018219;
	bh=bnuRSZ5VgKW9EMMlXkntotHnx/AGBzkicE3rznCRcFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jRb5xgl7PPXB7EK9MnwOf50HWPqF+ocDRYlkoxRCNngylzFiMF9qxFcSEl7IlK4KM
	 xBJJpM614AGPB5eOK82A3H9GXAbo5pUGG8+DomfsJ7lDOmK8HtSJW5x0fGlEaQbANP
	 fjoYXOSvXgXrrU9XI67Yv+FFupqUI4pwlOSDTaoxlXvugDd0uU6OLes/ekhFKFxGw5
	 eT/AzIgIIPcRci7mVxHinPJ0scPUCXwFzKYq+yZPZl68Xz23AnHBCn+XMpQ313Hp2F
	 6SO7vdrVXmAbtKZ9SlUvRTRSgJR4mkcQkQjiDprV/0dp7Kwtw2dp024CV7e30UpwIM
	 ozCVBbbtMGd5A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqT-0000000BBQA-1IE7;
	Tue, 16 Sep 2025 12:23:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 21/21] tools/docs: sphinx-build-wrapper: add support to run inside venv
Date: Tue, 16 Sep 2025 12:22:57 +0200
Message-ID: <da30965e88d5b3ec6a69414b6d19546ee7f0e24a.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
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
index 90ad0b22b472..b611dbe250f9 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -69,6 +69,7 @@ from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
 #
 #  Some constants
 #
+VENV_DEFAULT = "sphinx_latest"
 MIN_PYTHON_VERSION = PythonVersion("3.7").version
 PAPER = ["", "a4", "letter"]
 
@@ -179,8 +180,10 @@ class SphinxBuilder:
         if not verbose:
             self.sphinxopts += ["-q"]
 
-    def __init__(self, builddir, verbose=False, n_jobs=None, interactive=None):
+    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None,
+                 interactive=None):
         """Initialize internal variables"""
+        self.venv = venv
         self.verbose = None
 
         #
@@ -230,6 +233,21 @@ class SphinxBuilder:
 
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
@@ -264,7 +282,12 @@ class SphinxBuilder:
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
@@ -748,12 +771,16 @@ def main():
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


