Return-Path: <linux-kernel+bounces-800165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F0B4343A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94335866D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC632D0629;
	Thu,  4 Sep 2025 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3ZSj9jx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FDC2BE63F;
	Thu,  4 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=IhCtvkwh3mLP33vg0ekZmviJUtLl1eFhaayZbVjRpdXCXlLsfyr6JkQNAL3Iyv+gYTRwr+vo3alxCYpWfSwvS2bv1bG74FUWe0axMvhF/8VFT6aH39YQ4eghqDCDF3sn53T8q9v5kNlaspty3tTFBPjltOBLJlszDlpM6fTohbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=SW0tJnngS/ct2ODjXine9JSlkR4t/QS2wUfoS4CRDyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mtqCEfmC9fzdwHDyWRfRXRta1031fbma4g2WPpP+j5nUIqVJ+56NF1eFs7Ul/u1iQ0RyR3jfKbuoZ9YbX4bGXsEOxZbL2hZ1ouX5NKKtmsXvM2TZwvHs4aOd2TAc17BLN7BSE0kQeQACLHe570r6bg67K+TDjjH7JQ+gPKV5n3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3ZSj9jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5744C4CEF1;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971206;
	bh=SW0tJnngS/ct2ODjXine9JSlkR4t/QS2wUfoS4CRDyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3ZSj9jxUflsBM7votUvM+0jOHs5IDpPVUwYOkr+SpJalrBO60YvSkUE/3Gy2oAwa
	 LOQvUYTPdCkMz7rNDFp34i+9qY5F/UEMGxU6c2CGqzFRtzia3qiKH1tdO6hevUwI7X
	 TfzFBOnGIz+FKPcg7wKcQ2gq7Z6civQpBlAPlbNKipkLsN9SyxbH1T3XDfuv8o5e/4
	 GVc44hfukdewP/n70YvxiPA/3JhJVnTU6cbrb3AIJad9jTCN7CX8Y9IieJ0Zm0nF5O
	 GbmoandplZKQ+DV6cAVDXlqwmnUfNASqxDrUnXxRiG2+ylUJQitomo4CRnOcNlgFwD
	 nX5Rkue+MANQg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TE-00000009jPn-3uEG;
	Thu, 04 Sep 2025 09:33:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/19] tools/docs: sphinx-build-wrapper: add support to run inside venv
Date: Thu,  4 Sep 2025 09:33:10 +0200
Message-ID: <2158cc4cf1f9bcf4c191f8031c1fb717cb989f7f.1756969623.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756969623.git.mchehab+huawei@kernel.org>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
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
 tools/docs/sphinx-build-wrapper | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index ea9f8e17b0bc..cf7b30bc40ff 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -63,6 +63,7 @@ from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
 #
 #  Some constants
 #
+VENV_DEFAULT = "sphinx_latest"
 MIN_PYTHON_VERSION = PythonVersion("3.7").version
 PAPER = ["", "a4", "letter"]
 
@@ -119,8 +120,9 @@ class SphinxBuilder:
 
         return path
 
-    def __init__(self, builddir, verbose=False, n_jobs=None):
+    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None):
         """Initialize internal variables"""
+        self.venv = venv
         self.verbose = None
 
         #
@@ -195,6 +197,21 @@ class SphinxBuilder:
 
         self.env = os.environ.copy()
 
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
         Executes sphinx-build using current python3 command and setting
@@ -209,7 +226,10 @@ class SphinxBuilder:
 
             cmd = []
 
-            cmd.append(sys.executable)
+            if self.venv:
+                cmd.append("python")
+            else:
+                cmd.append(sys.executable)
 
             cmd.append(sphinx_build)
 
@@ -533,11 +553,15 @@ def main():
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


