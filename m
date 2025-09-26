Return-Path: <linux-kernel+bounces-833906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F28BA3526
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECF6161B41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747D32EC0A4;
	Fri, 26 Sep 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0FKX8p5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2D2EB873;
	Fri, 26 Sep 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881791; cv=none; b=ZrkQsmeDwyyuXLA4XkLIux+pceIZBH4XbJCGEaWFTTyKWGMyA2uW9i/x2ccuDJO/9AZsljS96ZqbUimeuDW6zMlDErABRV2HiLhuh8e4u6ir/V/Sn/an43Ndw8KFgwO8QAYN8tQNfee2jhIat/rvnJ5DxEddPQvDYRegPs0TgbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881791; c=relaxed/simple;
	bh=PrZzCy2cGIvNKyqPlF29RNpkiBN75wr7qz5JmPP/oR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoXOI1eVxgl3gmhgehg4l0UFfO6u7uxR+3LutVKHvpzF3MskYASLZSv509gPvto+V1ff2W/ahJe32/fBDpI9LsXXKtndTIIFsXyX2OLYQVP5BkcRMq0PKJZJxrkFjYJk+dHgmWKLSvxyDoPxS5cgcY0A8GtTHm0Llx0pvENzbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0FKX8p5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52674C4CEF4;
	Fri, 26 Sep 2025 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758881791;
	bh=PrZzCy2cGIvNKyqPlF29RNpkiBN75wr7qz5JmPP/oR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0FKX8p5Ky3NFMI8lBsHmgdZcuwskAo/j8NUIQl8F9pDjIVy41NvwJcyoC+IEavfj
	 05L2FEH/oPwWSceHpi5UIYynLcHS484IpMLpS33ZBWiAXhtKuYRXXDCH7RDRpeP1Iq
	 htqUcvg08T763klpDp9SX6lsYGscKiTMX1bOq2eKuPgZGFBkx04ZuZa7v9PS0MVb2F
	 3lUbVRKzVN1DXtRMFpzdyWKJATtFE1uMjnXaz5vz19iX29vr0YW9B4vtVJ7awWcwTt
	 xuIwwYd5SapGr60Ycp5yf11rTrEHBeHIInhabwfsiaNQ1Lj3qT2XvYRWGQMPmPuELl
	 foNShE29H60gA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v25V7-00000005Xom-1BFQ;
	Fri, 26 Sep 2025 12:16:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 1/2] tools/docs/sphinx-build-wrapper: allow skipping sphinx-build step
Date: Fri, 26 Sep 2025 12:16:18 +0200
Message-ID: <30dae295606ae1735f3bbeef4ca041a76dcd4540.1758881658.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758881658.git.mchehab+huawei@kernel.org>
References: <cover.1758881658.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Most targets have two steps:
- step 1: run sphinx-build;
- step 2: run a post-build logic.

The second step can be as simple as copying static files like CSS,
but may may also envolve running make. allowing to skip the first
step helps debugging what's broken, and also allows using make
command line arguments like --ignore-errors.

Add an option to skip step 1.

Requested-by: Akira Yokosawa <akiyks@gmail.com>
Link: https://lore.kernel.org/linux-doc/5031e0c4-f17e-41b8-8955-959989e797f2@gmail.com/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 98c4db5b7c47..cce985dced00 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -622,7 +622,8 @@ class SphinxBuilder:
         shutil.rmtree(self.builddir, ignore_errors=True)
 
     def build(self, target, sphinxdirs=None,
-              theme=None, css=None, paper=None, deny_vf=None, rustdoc=False):
+              theme=None, css=None, paper=None, deny_vf=None, rustdoc=False,
+              skip_sphinx=False):
         """
         Build documentation using Sphinx. This is the core function of this
         module. It prepares all arguments required by sphinx-build.
@@ -644,9 +645,10 @@ class SphinxBuilder:
         #
         # Other targets require sphinx-build, so check if it exists
         #
-        sphinxbuild = shutil.which(self.sphinxbuild, path=self.env["PATH"])
-        if not sphinxbuild and target != "mandocs":
-            sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")
+        if not skip_sphinx:
+            sphinxbuild = shutil.which(self.sphinxbuild, path=self.env["PATH"])
+            if not sphinxbuild and target != "mandocs":
+                sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")
 
         if builder == "latex":
             if not self.pdflatex_cmd and not self.latexmk_cmd:
@@ -732,7 +734,7 @@ class SphinxBuilder:
 
             if target == "mandocs":
                 self.handle_man(kerneldoc, docs_dir, src_dir, output_dir)
-            else:
+            elif not skip_sphinx:
                 try:
                     result = self.run_sphinx(sphinxbuild, build_args,
                                              env=self.env)
@@ -814,6 +816,9 @@ def main():
     parser.add_argument('-i', '--interactive', action='store_true',
                         help="Change latex default to run in interactive mode")
 
+    parser.add_argument('-s', '--skip-sphinx-build', action='store_true',
+                        help="Skip sphinx-build step")
+
     parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
                         default=None,
                         help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
@@ -829,7 +834,8 @@ def main():
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs,
                   theme=args.theme, css=args.css, paper=args.paper,
-                  rustdoc=args.rustdoc, deny_vf=args.deny_vf)
+                  rustdoc=args.rustdoc, deny_vf=args.deny_vf,
+                  skip_sphinx=args.skip_sphinx_build)
 
 if __name__ == "__main__":
     main()
-- 
2.51.0


