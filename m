Return-Path: <linux-kernel+bounces-820642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6B1B7D1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE87483FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B89E330ED9;
	Wed, 17 Sep 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQFj/nqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98F2FBDE8;
	Wed, 17 Sep 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111358; cv=none; b=dreLXmktjuCZ+7ZslDe3hXcXN4UfYst6tp07N+k20ABKDad7KNg1sNVBaIqJvxNuAhzShHqV1p2CMA9AF2F7B7G9OdFhzcCsSgzGB/4PnlRr7gSP9XUIvzQt7j4wuAkh4WhWMA2jvyBADN8t0mNOsv+kGhb2/1TM6LHXvnDYl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111358; c=relaxed/simple;
	bh=PUUaTyw8rlc0Hc2z+x0BdPRC+RKe/Sri73mjZjht+w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buHOeact7041/VkGo4Cwv/+/NB/OBbaTue8XGMD5EY0US7KRZCB5iDhdY4EYn8dzvNSIFg8o1Cp1vf/ikONCgZkSlqFaB5oD/d+XQAwFGgOkK5Xcm/PqpuURb1aYFpA3oH1vosPuR4V2CM+D/GYezFLRADyzCtbOaNP0vFRdVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQFj/nqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBEDC4CEF5;
	Wed, 17 Sep 2025 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111358;
	bh=PUUaTyw8rlc0Hc2z+x0BdPRC+RKe/Sri73mjZjht+w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQFj/nqSwFzfj++u4XcOZwP5aN8k6g6yaU9dLkvDKnoAq204Qy5szO+u/j+Nn1fzo
	 njTPyCogL1XTpEPZxKn0q3GeNmSc0t2mGtFzfYLb0qCxBTshOzQOS0h1vAMF3kpqGI
	 D+YKuq8Iq/p41aLdmkDd342nP1ceAZ63bwK9fwmEb+DJPc0nhThiKlj/Mz/8maLgqZ
	 CsYC8iwp/8WcRC4/3DJki7c9ez3EcGKraK7aO/hYtsbsv/BYYRzCIGkysQwuACXfbb
	 m5n+lJcqN6jobKmnYZMe84PAbBqPFjk/NGBpsK7Jxu6qAHqV0ybJlUfkGqWLK6jfJx
	 ns26zxHzece1g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGe8-1qN7;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 15/24] tools/docs: sphinx-build-wrapper: add an argument for LaTeX interactive mode
Date: Wed, 17 Sep 2025 14:15:09 +0200
Message-ID: <48d17b80c88d5f54ed63713fa2410f75ef15bc58.1758111077.git.mchehab+huawei@kernel.org>
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
index c57c732b879c..50761f125bc9 100755
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
@@ -584,12 +588,16 @@ def main():
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
                   theme=args.theme, css=args.css, paper=args.paper,
-- 
2.51.0


