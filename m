Return-Path: <linux-kernel+bounces-785197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F27B3476D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1725E7146
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13945304975;
	Mon, 25 Aug 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL7Tge5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328E301003;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139449; cv=none; b=pKzIyX6WBB7HUlcWbT0k/n3FtOBRYoZac10+M3GdBIbB9W+lV8oiAH3eXqi5LnY89FrKIHAO5qyEMFJkVOyUeoOniZfHxdzN4GFZjNuyaQwOv0q32AU+l8b21CjBvtBYGo+UftOeJYWF4sQyQna/T32E8Lfx8rEDGnlPi7piskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139449; c=relaxed/simple;
	bh=DUnDSGE1B+eDLTJGGuJp1airL8xfT3+GXJbkMbRzrzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGJYrjstrlAnLOKgmyaodJjJx3h1HgafMvA99g6ah8hMYqJIJAVt3Z90XRHq/dfS9fS0x9eT6uCU7mCrun8rnoszDYBWs11BYv5nJ1XyaNYO3KVCwOGDk3nmS/J3bKHZtdq5+gftHP9cIfOPspnnczRMRXvry6XwjHgk4+6CF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL7Tge5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385E5C2BCAF;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139449;
	bh=DUnDSGE1B+eDLTJGGuJp1airL8xfT3+GXJbkMbRzrzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mL7Tge5UDOXr94ffaXCo6zSd4Xz0TTlVTFbF7QVaiGgF2fFm4xew84fVEx2aYv6OS
	 2CdqOG3EcF2R1GNvbJCYOVAdCDh+w+X1Zjvltb+Jm9h/Z5kHE2Y2TjQuwldQMLLt8L
	 sZBTOCf5lnvpkqxZOMpSztmaQ9KdwJhfc5/nQOGY8/7h/8ur84tyQUN7V+Jc+/G0q+
	 sF8glHFt/ITeKdlyvsIVSpLwnfw2luEk/iB4CccB65pHyBlgazyRK0AH9IA3FaoC3k
	 HF3g4nZ8YvuIppFBgsd3BIL8M0t3QiljLeLa6IAoIC0t1B9G9mq/nSCtb24zh/U5gH
	 ecBkyuEwe9dLQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uqa5n-0000000HALw-1nla;
	Mon, 25 Aug 2025 18:30:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] tools/docs: sphinx-build-wrapper: add an argument for LaTeX interactive mode
Date: Mon, 25 Aug 2025 18:30:38 +0200
Message-ID: <fdfc3a625a4313ab1946772dd129e8e9754e0b91.1756138805.git.mchehab+huawei@kernel.org>
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
 tools/docs/sphinx-build-wrapper | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 9c5df50fb99d..4e87584a92cd 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -115,7 +115,7 @@ class SphinxBuilder:
 
         return path
 
-    def __init__(self, venv=None, verbose=False, n_jobs=None):
+    def __init__(self, venv=None, verbose=False, n_jobs=None, interactive=None):
         """Initialize internal variables"""
         self.venv = venv
         self.verbose = None
@@ -126,7 +126,11 @@ class SphinxBuilder:
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
@@ -548,6 +552,9 @@ def main():
     parser.add_argument('-j', '--jobs', type=jobs_type,
                         help="Sets number of jobs to use with sphinx-build")
 
+    parser.add_argument('-i', '--interactive', action='store_true',
+                        help="Change latex default to run in interactive mode")
+
     parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
                         default=None,
                         help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
@@ -557,7 +564,7 @@ def main():
     PythonVersion.check_python(MIN_PYTHON_VERSION)
 
     builder = SphinxBuilder(venv=args.venv, verbose=args.verbose,
-                            n_jobs=args.jobs)
+                            n_jobs=args.jobs, interactive=args.interactive)
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
                   theme=args.theme, css=args.css, paper=args.paper)
-- 
2.51.0


