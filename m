Return-Path: <linux-kernel+bounces-794951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D238B3EB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F62B17A7C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA032A819;
	Mon,  1 Sep 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7A9ZdTB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FB2DF137;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740838; cv=none; b=oQdubXfw7IHwUQ06OGQ/BnMB1QTB4X1bNJ4N4KqgYhIFfw7BkzK766FrPgVlOMxiI8yUzANc2VbOKEkJNWJ0UyFC8cYWkLnQ28ktEo2agT59T38oGsQsx4OwrnC+1X14WfoVBU4LB921TkkGitxS1cuW89aN5G4ECTbU64y8gbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740838; c=relaxed/simple;
	bh=ZEp9+mn+IvGFaAL1/6SmTvhHmWgFvhI6q4G7xcQM/xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IrM3pZgkuYBWiKHcC22Hj+7PS5MN/IzCa0iOrnuRs7hoVgcyHH1rG4ad4KHHB49DNjOcyRy9pVpAPDdw6VuHNXjdPiEQ1GrZDjokpSVz6NKHdboZ8kukY/yrngb5D4SrgEChv8Oac2BPC54yL+7Km1AEG1dO0MCEvR2/gSyxoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7A9ZdTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6EDC4AF0B;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740837;
	bh=ZEp9+mn+IvGFaAL1/6SmTvhHmWgFvhI6q4G7xcQM/xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7A9ZdTBuUpPE1hb7EWHbqzwbMQXADQUPM8zNwvEhUUonYvmx5p8+100hFcTinieM
	 Yb9hUDh0tuUbDyByndKPjokl6Bf7LCfBvcsa1YC618410kxKkZ+CF+69f/5RjOtQVo
	 81wxE0YnaKOHY/XCoOw8Ot/Wx86S82+k7Wnetm54Os3i/mgR4nekWywvkd744FR7aj
	 mDgSjmqfCfLE1269UCnwz2twsKv5Lv2+ojDp3LWLfBOjaE2Y1WJhNZcRUANsPMjBLh
	 AijSVZbqE9eM2EpjhrdgGmKThle1xLUSFaNEeQhB2qCGlBIaGkY9m3ZAhgHFgZDJqW
	 JLqZgSDw+e5mQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut6Xb-00000003HM6-30r2;
	Mon, 01 Sep 2025 17:33:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 08/15] tools/docs: sphinx-build-wrapper: add support
  to run inside venv
Date: Mon,  1 Sep 2025 17:33:43 +0200
Message-ID: <a7597d308c1aece44456285a2ad062b3a42ea6e3.1756740314.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756740314.git.mchehab+huawei@kernel.org>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Sometimes, it is desired to run Sphinx from a virtual environment.=0D
Add a command line parameter to automatically build Sphinx from=0D
such environment.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 tools/docs/sphinx-build-wrapper | 31 ++++++++++++++++++++++++++++---=0D
 1 file changed, 28 insertions(+), 3 deletions(-)=0D
=0D
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrap=
per=0D
index e9c522794fbe..9c5df50fb99d 100755=0D
--- a/tools/docs/sphinx-build-wrapper=0D
+++ b/tools/docs/sphinx-build-wrapper=0D
@@ -63,6 +63,7 @@ from jobserver import JobserverExec         # pylint: dis=
able=3DC0413,C0411,E0401=0D
 #=0D
 #  Some constants=0D
 #=0D
+VENV_DEFAULT =3D "sphinx_latest"=0D
 MIN_PYTHON_VERSION =3D PythonVersion("3.7").version=0D
 PAPER =3D ["", "a4", "letter"]=0D
 =0D
@@ -114,8 +115,9 @@ class SphinxBuilder:=0D
 =0D
         return path=0D
 =0D
-    def __init__(self, verbose=3DFalse, n_jobs=3DNone):=0D
+    def __init__(self, venv=3DNone, verbose=3DFalse, n_jobs=3DNone):=0D
         """Initialize internal variables"""=0D
+        self.venv =3D venv=0D
         self.verbose =3D None=0D
 =0D
         #=0D
@@ -192,6 +194,21 @@ class SphinxBuilder:=0D
 =0D
         self.env =3D os.environ.copy()=0D
 =0D
+        #=0D
+        # If venv command line argument is specified, run Sphinx from venv=
=0D
+        #=0D
+        if venv:=0D
+            bin_dir =3D os.path.join(venv, "bin")=0D
+            if not os.path.isfile(os.path.join(bin_dir, "activate")):=0D
+                sys.exit(f"Venv {venv} not found.")=0D
+=0D
+            # "activate" virtual env=0D
+            self.env["PATH"] =3D bin_dir + ":" + self.env["PATH"]=0D
+            self.env["VIRTUAL_ENV"] =3D venv=0D
+            if "PYTHONHOME" in self.env:=0D
+                del self.env["PYTHONHOME"]=0D
+            print(f"Setting venv to {venv}")=0D
+=0D
     def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):=0D
         """=0D
         Executes sphinx-build using current python3 command and setting=0D
@@ -206,7 +223,10 @@ class SphinxBuilder:=0D
 =0D
             cmd =3D []=0D
 =0D
-            cmd.append(sys.executable)=0D
+            if self.venv:=0D
+                cmd.append("python")=0D
+            else:=0D
+                cmd.append(sys.executable)=0D
 =0D
             cmd.append(sphinx_build)=0D
 =0D
@@ -528,11 +548,16 @@ def main():=0D
     parser.add_argument('-j', '--jobs', type=3Djobs_type,=0D
                         help=3D"Sets number of jobs to use with sphinx-bui=
ld")=0D
 =0D
+    parser.add_argument("-V", "--venv", nargs=3D'?', const=3Df'{VENV_DEFAU=
LT}',=0D
+                        default=3DNone,=0D
+                        help=3Df'If used, run Sphinx from a venv dir (defa=
ult dir: {VENV_DEFAULT})')=0D
+=0D
     args =3D parser.parse_args()=0D
 =0D
     PythonVersion.check_python(MIN_PYTHON_VERSION)=0D
 =0D
-    builder =3D SphinxBuilder(verbose=3Dargs.verbose, n_jobs=3Dargs.jobs)=
=0D
+    builder =3D SphinxBuilder(venv=3Dargs.venv, verbose=3Dargs.verbose,=0D
+                            n_jobs=3Dargs.jobs)=0D
 =0D
     builder.build(args.target, sphinxdirs=3Dargs.sphinxdirs, conf=3Dargs.c=
onf,=0D
                   theme=3Dargs.theme, css=3Dargs.css, paper=3Dargs.paper)=
=0D
-- =0D
2.51.0=0D
=0D

