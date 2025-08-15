Return-Path: <linux-kernel+bounces-770849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1363B27F97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C482CB61E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AC303CBC;
	Fri, 15 Aug 2025 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzmeQFUr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDAA3002DC;
	Fri, 15 Aug 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258666; cv=none; b=IDYbaNzmPEmUJ+rQfqebXEPb5vN7mBm/7+7iJk21UVm7tIxFojlILQXrgIkA86larIK9NKExJlRhWxDl1IZYNr3+e77dCirQXoZq+g1Fox/ITcWADKFoO5JK9Fxe7wxD/bGiRZyJ/vgxcwBubA37ond60DfXw42TzubYkyhYt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258666; c=relaxed/simple;
	bh=muQZDm3HB4OxC2K9pGxjzcvqGF5LqYzQdGjLcQnqVE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tw0zQ07HU/e2J52o2wwGG9B6fbvOOj1pILFpYcJDV2y9B0yjw2v8W4Ff3v32nt1D15lIOdp5w1G++L2+lWz4rYi3ZLC3n8rzY0xqvRiarN2AOSR6l73Xa4PXCSz5VEb359cO+bAtLvNHAw0jjGC2CLgwT50U8vt40LETwfj9reQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzmeQFUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34D9C4CEFE;
	Fri, 15 Aug 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755258666;
	bh=muQZDm3HB4OxC2K9pGxjzcvqGF5LqYzQdGjLcQnqVE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzmeQFUrnWmwtmy/iTqbo6QyGc+nSn/XEaDytqBMN+Eb9pIU4Kos5ev6IWO5U+8rp
	 rH3DFry4IizN5Ql75FnNiTcY8DwXr33T5IOtGB3M/u9TnTWt1xrZNre8b8vQCshqw0
	 9zapCDw5nHc94o0DAJjuIzdUELPEXnAvQ8rZ3IUCfcxik8+89O82rJjE8NVk7M73nG
	 2rXcg9OTKUIVUEfV0YQ4ekpwRLpT0aer9z4l78zSlRAdkywdISA2iMFsG2uBd/IK63
	 7y+Dp1GHExhRofcOH+JZ5LO0XUGHgJyJ3a4hnUFT8mMUNglgPWHuLczemM2NOmITf8
	 gwqsllBoadvSQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umsxc-000000042om-0tB6;
	Fri, 15 Aug 2025 13:51:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] scripts: sphinx-build-wrapper: add an argument for LaTeX interactive mode
Date: Fri, 15 Aug 2025 13:50:37 +0200
Message-ID: <6ad508ef010240665c8a8ce98c8ffe38a7be67fe.1755258303.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755258303.git.mchehab+huawei@kernel.org>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
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
 scripts/sphinx-build-wrapper | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/scripts/sphinx-build-wrapper b/scripts/sphinx-build-wrapper
index b9d40f4a6573..f6fec766c3e6 100755
--- a/scripts/sphinx-build-wrapper
+++ b/scripts/sphinx-build-wrapper
@@ -148,7 +148,7 @@ class SphinxBuilder:
 
         return path
 
-    def __init__(self, venv=None, verbose=False, n_jobs=None):
+    def __init__(self, venv=None, verbose=False, n_jobs=None, interactive=None):
         """Initialize internal variables"""
         self.venv = venv
         self.verbose = None
@@ -157,7 +157,11 @@ class SphinxBuilder:
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
@@ -661,6 +665,9 @@ def main():
     parser.add_argument('-j', '--jobs', type=jobs_type,
                         help="Sets number of jobs to use with sphinx-build")
 
+    parser.add_argument('-i', '--interactive', action='store_true',
+                        help="Change latex default to run in interactive mode")
+
     parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
                         default=None,
                         help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
@@ -670,7 +677,7 @@ def main():
     SphinxBuilder.check_python()
 
     builder = SphinxBuilder(venv=args.venv, verbose=args.verbose,
-                            n_jobs=args.jobs)
+                            n_jobs=args.jobs, interactive=args.interactive)
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
                   theme=args.theme, css=args.css, paper=args.paper)
-- 
2.50.1


