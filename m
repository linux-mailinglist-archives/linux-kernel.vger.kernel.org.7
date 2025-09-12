Return-Path: <linux-kernel+bounces-813837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E744EB54B72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED401686350
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1B30277E;
	Fri, 12 Sep 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXL2jOeX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60ED2EFD87;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677594; cv=none; b=ISbiQcagT2pJRoUT+OeSaiyhl471Z6FtCkEvFcY9pWPs65jWhM2HrRoc92bxJH4UPJfE8QO/yNZtez3kl/+Vh8u8qt1RSBdBt3W4Ld/9NvA0Y50yhpdVOPNz3l9oRcZGvtk8cNRgFtIHd3SSB96KXrxK+gL4N+ZRZlBJC7ebLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677594; c=relaxed/simple;
	bh=ARv1rqHunt9bGPhWs6AIjRlxcaRACh4Hd78l9fP4AjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSc4zcWmOGEf1NgqFxONR+go1oMkcltNuW8yIsNMGWgGhjj+/Sv4WQHhRTKirxUHUu5SB7ndouleEFbZchXEMHLYKcDzf9tE0n0FDfI9CV3n815T252W01G5GUVSnJu+vtMvKcDpFVDx81CK1TegtVLJK5sWMGHxGJNDAJ7gY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXL2jOeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F95AC4CEFF;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677594;
	bh=ARv1rqHunt9bGPhWs6AIjRlxcaRACh4Hd78l9fP4AjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXL2jOeXdYgyTiMaio6W1r/aQs78+FH7+d5RnV48vuohh57Ss1ztNhF6905/Uv9sx
	 hXumxzptiKxPkdcgTgq02BUKb00SKTAWwSFuASQgMLfW4g90mKL/84tq86nWbMapkO
	 iXtcQwDn2mBf84qNGhvLHcWAMApZ7DyvWrz8w+rPcMKe1dcFQ6LDU6d83VepNVK/BS
	 SbFo9B2RK31X9XVsWLtLd/lc3uBg7C6Ul/q0RjRyJ6f93vaOfbh81CR1TF9cD4/MU6
	 L1+dY5CClOSiY8flt6SbESSDpbrxfbagJXdULRQN7OEH3peCKX2RkY3ULIVxkjo1tw
	 Io4FJhuWjMj+w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux2Ea-00000008RsT-2zlL;
	Fri, 12 Sep 2025 13:46:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/18] tools/docs: sphinx-build-wrapper: add support to run inside venv
Date: Fri, 12 Sep 2025 13:46:16 +0200
Message-ID: <671ecc300e48979b0233c26e9afda31e50fc9bc6.1757677427.git.mchehab+huawei@kernel.org>
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

Sometimes, it is desired to run Sphinx from a virtual environment.
Add a command line parameter to automatically build Sphinx from
such environment.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 9e17c0dbaccd..b34389f65076 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -63,6 +63,7 @@ from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
 #
 #  Some constants
 #
+VENV_DEFAULT = "sphinx_latest"
 MIN_PYTHON_VERSION = PythonVersion("3.7").version
 PAPER = ["", "a4", "letter"]
 
@@ -172,8 +173,9 @@ class SphinxBuilder:
         if not verbose:
             self.sphinxopts += ["-q"]
 
-    def __init__(self, builddir, verbose=False, n_jobs=None):
+    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None):
         """Initialize internal variables"""
+        self.venv = venv
         self.verbose = None
 
         #
@@ -219,6 +221,21 @@ class SphinxBuilder:
 
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
@@ -253,7 +270,12 @@ class SphinxBuilder:
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
@@ -562,11 +584,15 @@ def main():
     parser.add_argument('-j', '--jobs', type=jobs_type,
                         help="Sets number of jobs to use with sphinx-build")
 
+    parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
+                        default=None,
+                        help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
+
     args = parser.parse_args()
 
     PythonVersion.check_python(MIN_PYTHON_VERSION)
 
-    builder = SphinxBuilder(builddir=args.builddir,
+    builder = SphinxBuilder(builddir=args.builddir, venv=args.venv,
                             verbose=args.verbose, n_jobs=args.jobs)
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
-- 
2.51.0


