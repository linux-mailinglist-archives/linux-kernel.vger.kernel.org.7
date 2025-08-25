Return-Path: <linux-kernel+bounces-785195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94FB34766
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C193AF9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4A130149F;
	Mon, 25 Aug 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ8bjumF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814F32FE58F;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139449; cv=none; b=q++jePTTc5KBbX/U+e+YhZqs/p/hyz25Sk5Ez/RRsOsKTPbbuKEPeo4gAKSD9FS/oAazd81fWj2ZqJ+9PrS08oqsG3XAYKH1qZkQH3JArWFpxE3Kfmw+A9cePD0CQ1NilRV60rW4/PDGlUGZdiyZfShNNhVmcfYlx6M7msHbnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139449; c=relaxed/simple;
	bh=07ltFNs1ZVDrRsHyXMC8vS/Q/NnwAG3htK5IbjLMyV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An+JmY91DvZqA4SEs9r7LDDcSnuWf+xXvKWw3ScQ2RXJO3oYeViwFY2xSbsaAtvxjFw+5PwE8C8k5r5GS4ffblyNgYW61MFinhp5Hq/KRXyySZWhYM/l6b1GCyBgCZTgzZ7mRP6CAbCNr6RC2MNV/mPuUJ26qYYNTnJp3dqpqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ8bjumF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E84EC19421;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139449;
	bh=07ltFNs1ZVDrRsHyXMC8vS/Q/NnwAG3htK5IbjLMyV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZ8bjumF8lLHC46ZcGpjlepVHJJsc9/irk/sVw3HIaBH8sAqnCHuxjFwR/L/dYOQ7
	 fBp4Hk171PBrzVlDLdM1tNgxVkbsDmarXWGmLu1Z0mD0hyAA3DrZqhMeYFdojH1sDG
	 oa+iDgnmZlhMPmbCprAaEVxuJ98Z0EM58/fLoXQC2MDlqItw9buphyPmVY22qiiC74
	 7hxgDeOcBt9defB96anKaPUrIcd2w+JrodgwOhKNGwXQc3WOtmRCjT7D28tKePlg3h
	 H/zWcO9wCd2m7Pl2rKNijv0DSWjLn9xU19CS5CxoIO92pw1t3I2A8G91FtkZiJvzUK
	 jcZw25JsC+2GA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uqa5n-0000000HALk-1TrC;
	Mon, 25 Aug 2025 18:30:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] tools/docs: sphinx-build-wrapper: add support to run inside venv
Date: Mon, 25 Aug 2025 18:30:35 +0200
Message-ID: <d8b3d9a7167c3c992a95118d654f125f73ddbf22.1756138805.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756138805.git.mchehab+huawei@kernel.org>
References: <cover.1756138805.git.mchehab+huawei@kernel.org>
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
 tools/docs/sphinx-build-wrapper | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index e9c522794fbe..9c5df50fb99d 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -63,6 +63,7 @@ from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
 #
 #  Some constants
 #
+VENV_DEFAULT = "sphinx_latest"
 MIN_PYTHON_VERSION = PythonVersion("3.7").version
 PAPER = ["", "a4", "letter"]
 
@@ -114,8 +115,9 @@ class SphinxBuilder:
 
         return path
 
-    def __init__(self, verbose=False, n_jobs=None):
+    def __init__(self, venv=None, verbose=False, n_jobs=None):
         """Initialize internal variables"""
+        self.venv = venv
         self.verbose = None
 
         #
@@ -192,6 +194,21 @@ class SphinxBuilder:
 
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
@@ -206,7 +223,10 @@ class SphinxBuilder:
 
             cmd = []
 
-            cmd.append(sys.executable)
+            if self.venv:
+                cmd.append("python")
+            else:
+                cmd.append(sys.executable)
 
             cmd.append(sphinx_build)
 
@@ -528,11 +548,16 @@ def main():
     parser.add_argument('-j', '--jobs', type=jobs_type,
                         help="Sets number of jobs to use with sphinx-build")
 
+    parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
+                        default=None,
+                        help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
+
     args = parser.parse_args()
 
     PythonVersion.check_python(MIN_PYTHON_VERSION)
 
-    builder = SphinxBuilder(verbose=args.verbose, n_jobs=args.jobs)
+    builder = SphinxBuilder(venv=args.venv, verbose=args.verbose,
+                            n_jobs=args.jobs)
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
                   theme=args.theme, css=args.css, paper=args.paper)
-- 
2.51.0


