Return-Path: <linux-kernel+bounces-794814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D152B3E792
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BD81A83653
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BFE346A11;
	Mon,  1 Sep 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qx1fCkr0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C3341AB1;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737758; cv=none; b=ftZlnbttbZl3v/A0u4jV/BlfKlYptKpMZJvLqrI6NDg/3jZr2w9K9ZSwMNLUf7D/8ti/9UgqnZAjIWCfN28/WnQPB75f/m+9QrWIyjWlRQ3SqMYeyV/hEaXIDv+ymJ5KnvMWRHOyv5oTUsVGuQzqI/UqzsbGsjmwrBiFN1Wgaxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737758; c=relaxed/simple;
	bh=9q6X7vB/+UD8d5Co4DYpFC4MptFcOsSfJ/mYNLQGx24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cLlaB43Ki823k/Hs0ZF2pNsPWKWJr5vUOqLuGsYE2eOoA0ts5nEV7VnOL3SOCxkww/fsANRY9jTI6NuOZhjvPexQ2SaeX99C2Xz1GrOs+7U5ndTZrpHaqkmXE7ckTd3KIut4Nkp3q0mWuYNlHAkqC+XezTvFCPxtbHPVQXbb8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qx1fCkr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75641C113CF;
	Mon,  1 Sep 2025 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737757;
	bh=9q6X7vB/+UD8d5Co4DYpFC4MptFcOsSfJ/mYNLQGx24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qx1fCkr032WgtcAvyvOpm9R79Yv6R39CWG0aJUCC7iVKnPXLqWUiwLZe3Vxh61EFV
	 dlrHEGVx6FlDxhZpWdrsG7GDTUhyRwwH0DrZ93QZDRIRaokIPsDQqOtyiLWi6g20LP
	 YGVbNYlwHRE2GSq+p+aBKfUOr9UkxtqW4QNH6enMAObbNA8SaA9nP+lYKFrg7BsUFE
	 TtTBhkOv3K52bWvluSPs1IJlqvCi8gE8FRtF32D0uCv+2CjAR7iyMCVn46n4M5lcvi
	 akOoIvJKvvK7c105ZmXfHFZc1R3/8IwlwBWgYZ5yKrK7GJawSEMLKtKiyjzc7pCIHp
	 yHMAG2PdCFgjg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut5jv-00000003G3o-3ES7;
	Mon, 01 Sep 2025 16:42:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] tools/docs: sphinx-build-wrapper: add an argument
  for LaTeX interactive mode
Date: Mon,  1 Sep 2025 16:42:27 +0200
Message-ID: <c0b14c9c20c44bed49ccc475b3c2d5fc59002892.1756737440.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756737440.git.mchehab+huawei@kernel.org>
References: <cover.1756737440.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

By default, we use LaTeX batch mode to build docs. This way, when=0D
an error happens, the build fails. This is good for normal builds,=0D
but when debugging problems with pdf generation, the best is to=0D
use interactive mode.=0D
=0D
We already support it via LATEXOPTS, but having a command line=0D
argument makes it easier:=0D
=0D
Interactive mode:=0D
	./scripts/sphinx-build-wrapper pdfdocs --sphinxdirs peci -v -i=0D
	...=0D
	Running 'xelatex --no-pdf  -no-pdf -recorder  ".../Documentation/output/pe=
ci/latex/peci.tex"'=0D
	...=0D
=0D
Default batch mode:=0D
        ./scripts/sphinx-build-wrapper pdfdocs --sphinxdirs peci -v=0D
	...=0D
	Running 'xelatex --no-pdf  -no-pdf -interaction=3Dbatchmode -no-shell-esca=
pe -recorder  ".../Documentation/output/peci/latex/peci.tex"'=0D
	...=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 tools/docs/sphinx-build-wrapper | 13 ++++++++++---=0D
 1 file changed, 10 insertions(+), 3 deletions(-)=0D
=0D
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrap=
per=0D
index 9c5df50fb99d..4e87584a92cd 100755=0D
--- a/tools/docs/sphinx-build-wrapper=0D
+++ b/tools/docs/sphinx-build-wrapper=0D
@@ -115,7 +115,7 @@ class SphinxBuilder:=0D
 =0D
         return path=0D
 =0D
-    def __init__(self, venv=3DNone, verbose=3DFalse, n_jobs=3DNone):=0D
+    def __init__(self, venv=3DNone, verbose=3DFalse, n_jobs=3DNone, intera=
ctive=3DNone):=0D
         """Initialize internal variables"""=0D
         self.venv =3D venv=0D
         self.verbose =3D None=0D
@@ -126,7 +126,11 @@ class SphinxBuilder:=0D
         self.kernelversion =3D os.environ.get("KERNELVERSION", "unknown")=
=0D
         self.kernelrelease =3D os.environ.get("KERNELRELEASE", "unknown")=
=0D
         self.pdflatex =3D os.environ.get("PDFLATEX", "xelatex")=0D
-        self.latexopts =3D os.environ.get("LATEXOPTS", "-interaction=3Dbat=
chmode -no-shell-escape")=0D
+=0D
+        if not interactive:=0D
+            self.latexopts =3D os.environ.get("LATEXOPTS", "-interaction=
=3Dbatchmode -no-shell-escape")=0D
+        else:=0D
+            self.latexopts =3D os.environ.get("LATEXOPTS", "")=0D
 =0D
         if not verbose:=0D
             verbose =3D bool(os.environ.get("KBUILD_VERBOSE", "") !=3D "")=
=0D
@@ -548,6 +552,9 @@ def main():=0D
     parser.add_argument('-j', '--jobs', type=3Djobs_type,=0D
                         help=3D"Sets number of jobs to use with sphinx-bui=
ld")=0D
 =0D
+    parser.add_argument('-i', '--interactive', action=3D'store_true',=0D
+                        help=3D"Change latex default to run in interactive=
 mode")=0D
+=0D
     parser.add_argument("-V", "--venv", nargs=3D'?', const=3Df'{VENV_DEFAU=
LT}',=0D
                         default=3DNone,=0D
                         help=3Df'If used, run Sphinx from a venv dir (defa=
ult dir: {VENV_DEFAULT})')=0D
@@ -557,7 +564,7 @@ def main():=0D
     PythonVersion.check_python(MIN_PYTHON_VERSION)=0D
 =0D
     builder =3D SphinxBuilder(venv=3Dargs.venv, verbose=3Dargs.verbose,=0D
-                            n_jobs=3Dargs.jobs)=0D
+                            n_jobs=3Dargs.jobs, interactive=3Dargs.interac=
tive)=0D
 =0D
     builder.build(args.target, sphinxdirs=3Dargs.sphinxdirs, conf=3Dargs.c=
onf,=0D
                   theme=3Dargs.theme, css=3Dargs.css, paper=3Dargs.paper)=
=0D
-- =0D
2.51.0=0D
=0D

