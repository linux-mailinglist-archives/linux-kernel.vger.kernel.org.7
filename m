Return-Path: <linux-kernel+bounces-813855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B55B54B83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228EA686681
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92D3090C4;
	Fri, 12 Sep 2025 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avSi4RjA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD093019BA;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677595; cv=none; b=sVQ5nwfGA33HDwyC/mSxOlKXP85F6kC2z/2vCk7ic3/YCVwX0OdMZja/wuGzyTPndr2eRWX61ertDVwAraedJQFzY+7mmJ3gl2bVrSxle6MWWK7UuCfmgSbNapGLkQdPRBXCRQXq9ZuPy+mtY3pH6Xr22Y6HiRP6UTGLA2M+xhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677595; c=relaxed/simple;
	bh=2Z4kQcJjaWeqOHt0ImEre/Ug31h1v77fVwF5t5AR2BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X23YAVFhQpE5byEsaebHp4EjGgT6zncUnhNAAiazo1CIBV1YN3Z5lVQ1BtFGsYNvxw8NltU8nm3JfTKHtRt0ex7FTrHpIJlyPxjSmRZ+ZMZv2iwmQeyt6b28M8jJxWwWrZshBymA7fS78QZdR3BzGb41JPH/G5Td2DtJDVPtAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avSi4RjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8079CC19421;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677594;
	bh=2Z4kQcJjaWeqOHt0ImEre/Ug31h1v77fVwF5t5AR2BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avSi4RjAW8nRdbP4WF5BxAIX9ExRAkZ1qKdhCj/fp9vx3nAqih2JMlrRvEi5/TewE
	 jisDjWAqoQpOhr6yWB9DTr2FvZU0l3UAlUn8kngn8T1LSxYcf6NTFknXgatIzvOFiA
	 olgRenaYXrUACfDnwdtPXibxZzTBqf8pkJa9/pxjyxhZa3u1BCQ+A3XdP8c6ajFJQv
	 8Pn7ff5hsX7QRSgtcmLuI+t3YScIGGJtYCehudelPmI9leL9gLRRmChBpr7IsOojOL
	 9kwb2dX6zcCnORfaNRl3gI3++q8g0G4k8fia0I1rXuMLxDhqMefbQx2V8RhSoE7PFp
	 1eH2UqlOwgkpw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux2Ea-00000008Rsf-3KGj;
	Fri, 12 Sep 2025 13:46:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/18] tools/docs: sphinx-build-wrapper: add an argument for LaTeX interactive mode
Date: Fri, 12 Sep 2025 13:46:19 +0200
Message-ID: <1b420224e962db0b9e9a0c65705e07c24a4a2ef0.1757677427.git.mchehab+huawei@kernel.org>
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
index b34389f65076..1ba3afec6e65 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -173,7 +173,8 @@ class SphinxBuilder:
         if not verbose:
             self.sphinxopts += ["-q"]
 
-    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None):
+    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None,
+                 interactive=None):
         """Initialize internal variables"""
         self.venv = venv
         self.verbose = None
@@ -184,7 +185,11 @@ class SphinxBuilder:
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
@@ -584,6 +589,9 @@ def main():
     parser.add_argument('-j', '--jobs', type=jobs_type,
                         help="Sets number of jobs to use with sphinx-build")
 
+    parser.add_argument('-i', '--interactive', action='store_true',
+                        help="Change latex default to run in interactive mode")
+
     parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
                         default=None,
                         help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
@@ -593,7 +601,8 @@ def main():
     PythonVersion.check_python(MIN_PYTHON_VERSION)
 
     builder = SphinxBuilder(builddir=args.builddir, venv=args.venv,
-                            verbose=args.verbose, n_jobs=args.jobs)
+                            verbose=args.verbose, n_jobs=args.jobs,
+                            interactive=args.interactive)
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,
                   theme=args.theme, css=args.css, paper=args.paper)
-- 
2.51.0


