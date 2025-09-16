Return-Path: <linux-kernel+bounces-818579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029DAB59391
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75737ABE85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116F3090D5;
	Tue, 16 Sep 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOwHfbyv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DCB306489;
	Tue, 16 Sep 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018217; cv=none; b=IQmoRT13ZFDBdeXxuBGw5J+ut+FrXQHRVWVb8ph8eGAY3AqHPqXNhHk9DZg3vJ3KDWqTWvFbZqDCHLXj+8L1lelcQTT0GxyHlgFbvJ2FBVXaLLrQ+jV5Ngo4vauMoBua8tCcS0F/Jb5S2Lox37SMk3tPgXR3b/jueGVoOjhjkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018217; c=relaxed/simple;
	bh=Um/5hSZElcigGfGfqDdP8kwoICyt5uQYwgvn0kBeh7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iWFV9tf5w6lLvz0ueCrS87ds8teh9UXDaJh0XNhRAKsuR2sUwUQHrm46OuT9wMOR6AcILzOiOqbog5lEpZzgv/5Cg2fDgiLAddU9j4+vXNhRNeX/MagcM2KMsmbJCO7mWN7JqKnCwuwxk6XE2Es2vGzqimtEkhKXtzDPu2Hw0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOwHfbyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6766AC4CEFA;
	Tue, 16 Sep 2025 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018217;
	bh=Um/5hSZElcigGfGfqDdP8kwoICyt5uQYwgvn0kBeh7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOwHfbyvR3bEWMSRSTdnxYKjaVonkFwyge95ReqFDnc15ZbSG1h9pHK/4KF27Nvv7
	 LWA7iT+rdq6vfx5ykTFLR70ruMQJn4dta8LczWY+jX6YDYMrzBhJJcpZXhL1oYTLAy
	 Hfb9o/3Sc/1BkPFMhaDH9rC2RouqU7JcvQ7pzziTkrDzJ+nmfWct4riNTvZ6yBJK1P
	 n+IYEDOtLl7StXxcOD22K8fBXCvtGuqXLpegBu1+cIPjDhN7UsxDowEKuH+LgZ9Q5G
	 edQsEsEBeTeRHV7dKNUf/mGMuL9aaaPXjqc3Q0CHmOUQ/tAW2MWnMvcfiVITKVXFUe
	 j26gZp8UpRZrA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqT-0000000BBPW-06vI;
	Tue, 16 Sep 2025 12:23:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/21] tools/docs: sphinx-build-wrapper: add an argument for LaTeX interactive mode
Date: Tue, 16 Sep 2025 12:22:49 +0200
Message-ID: <7238e04135bde9e98808ee1b35ec09e5df1fb10f.1758018030.git.mchehab+huawei@kernel.org>
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

By default, we use LaTeX batch mode to build docs. This way, when
an error happens, the build fails. This is good for normal builds,
but when debugging problems with pdf generation, the best is to
use interactive mode.

We already support it via LATEXOPTS, but having a command line
argument makes it easier:

Interactive mode:
	./scripts/sphinx-build-wrapper pdfdocs --sphinxdirs peci -v -i
	...
	Running 'xelatex --no-pdf  -no-pdf -recorder  ".../Documentation/output/peci/latex/peci.tex"'
	...

Default batch mode:
        ./scripts/sphinx-build-wrapper pdfdocs --sphinxdirs peci -v
	...
	Running 'xelatex --no-pdf  -no-pdf -interaction=batchmode -no-shell-escape -recorder  ".../Documentation/output/peci/latex/peci.tex"'
	...

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index a65a2297eb40..413f51575de8 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -173,7 +173,7 @@ class SphinxBuilder:
         if not verbose:
             self.sphinxopts += ["-q"]
 
-    def __init__(self, builddir, verbose=False, n_jobs=None):
+    def __init__(self, builddir, verbose=False, n_jobs=None, interactive=None):
         """Initialize internal variables"""
         self.verbose = None
 
@@ -183,7 +183,11 @@ class SphinxBuilder:
         self.kernelversion = os.environ.get("KERNELVERSION", "unknown")
         self.kernelrelease = os.environ.get("KERNELRELEASE", "unknown")
         self.pdflatex = os.environ.get("PDFLATEX", "xelatex")
-        self.latexopts = os.environ.get("LATEXOPTS", "-interaction=batchmode -no-shell-escape")
+
+        if not interactive:
+            self.latexopts = os.environ.get("LATEXOPTS", "-interaction=batchmode -no-shell-escape")
+        else:
+            self.latexopts = os.environ.get("LATEXOPTS", "")
 
         if not verbose:
             verbose = bool(os.environ.get("KBUILD_VERBOSE", "") != "")
@@ -567,12 +571,16 @@ def main():
     parser.add_argument('-j', '--jobs', type=jobs_type,
                         help="Sets number of jobs to use with sphinx-build")
 
+    parser.add_argument('-i', '--interactive', action='store_true',
+                        help="Change latex default to run in interactive mode")
+
     args = parser.parse_args()
 
     PythonVersion.check_python(MIN_PYTHON_VERSION)
 
     builder = SphinxBuilder(builddir=args.builddir,
-                            verbose=args.verbose, n_jobs=args.jobs)
+                            verbose=args.verbose, n_jobs=args.jobs,
+                            interactive=args.interactive)
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
                   theme=args.theme, css=args.css, paper=args.paper)
-- 
2.51.0


