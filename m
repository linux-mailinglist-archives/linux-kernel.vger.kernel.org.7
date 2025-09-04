Return-Path: <linux-kernel+bounces-800161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4065B43439
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D732D1C8074A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001052C159A;
	Thu,  4 Sep 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8rlMgaK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEEA2BE04C;
	Thu,  4 Sep 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971207; cv=none; b=W4G6jKI48olZLx4v2LxxHiYLAbQr6TnH1YayLTU2P3yaQtoIvFwN2RhkKW3/SvXWuRfKYjMD/f2xqgOqv4h0/UcjnCrlvIVytzRfEhj7h99eW86YFAW4B1bBESyBDser5fGolQjqzyn/S/GOf4h7mi1SEIegJ5fLpZBf4coPU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971207; c=relaxed/simple;
	bh=cbweHJfQC8VvqXB8Y5/FaxFei0KTfLWpMRtf/hEy3WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CTmjcEr8XQcEjeFtngT5UaCoQDgzsHh4dFBdE0i5293FoNT670hJVxkj+7YvwcoDi59Nc6+Qc2mnnl4iFZCWNGpRlfeIfXMdxEafs4vl6wFI6Tt7NKAlyLM1J3Iy086G1+qp5fI0+CCVmS0EaHGSNi3UWvm3eqzjvKSj0W1MLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8rlMgaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03F4C16AAE;
	Thu,  4 Sep 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756971206;
	bh=cbweHJfQC8VvqXB8Y5/FaxFei0KTfLWpMRtf/hEy3WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8rlMgaK5oFmVajHWaCxEyFIWpNuHT8VxwUR75AgZxpBFLU9Il59BZvuwVOyNhGHA
	 Ww5/CSYUE35MOZQNKjI+A6m+pwqkwg680TvCP4uyt2ouGGpoIPwVHdrcR8aMCLuk5a
	 +NQ3CLRlegY1Hu1bF9wKQuOmRnp89Acg8NgURIMQnPLyx+9p8fBr0XK8Ff3qN8mN41
	 9PBa266G5Hcikf2UNcRaAJqNx8zEynn30yrLeCTuSFse/MzDsXHiQTVoOIntz2eN2W
	 I5RGdmcV7nENtLBRuxNOuXs/hiVK2UFXXBDdOhfDTDuVkvnmB6drGsfgINc9FQ5/gi
	 WOh1K2OKSXCrA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uu4TF-00000009jPz-02L7;
	Thu, 04 Sep 2025 09:33:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/19] tools/docs: sphinx-build-wrapper: add an argument for LaTeX interactive mode
Date: Thu,  4 Sep 2025 09:33:13 +0200
Message-ID: <510bc978a84b22089c2de55a24a31300346771c7.1756969623.git.mchehab+huawei@kernel.org>
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
 tools/docs/sphinx-build-wrapper | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index cf7b30bc40ff..8ce57a25696f 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -120,7 +120,8 @@ class SphinxBuilder:
 
         return path
 
-    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None):
+    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None,
+                 interactive=None):
         """Initialize internal variables"""
         self.venv = venv
         self.verbose = None
@@ -131,7 +132,11 @@ class SphinxBuilder:
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
@@ -553,6 +558,9 @@ def main():
     parser.add_argument('-j', '--jobs', type=jobs_type,
                         help="Sets number of jobs to use with sphinx-build")
 
+    parser.add_argument('-i', '--interactive', action='store_true',
+                        help="Change latex default to run in interactive mode")
+
     parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
                         default=None,
                         help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
@@ -562,7 +570,8 @@ def main():
     PythonVersion.check_python(MIN_PYTHON_VERSION)
 
     builder = SphinxBuilder(builddir=args.builddir, venv=args.venv,
-                            verbose=args.verbose, n_jobs=args.jobs)
+                            verbose=args.verbose, n_jobs=args.jobs,
+                            interactive=args.interactive)
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
                   theme=args.theme, css=args.css, paper=args.paper)
-- 
2.51.0


