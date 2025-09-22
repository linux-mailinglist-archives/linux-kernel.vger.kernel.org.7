Return-Path: <linux-kernel+bounces-827118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C180B905BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7813BFB79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18393305E3E;
	Mon, 22 Sep 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDhIOwyI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16E305053;
	Mon, 22 Sep 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540496; cv=none; b=us2sVGyXKBMe3uhLMv+w0FGcfxx2O5xZrsz3zPvG4iJ+s9OU+FRgc3ybL4idjB8P4D2dZus8Zbr8G7+zIOr8Y/oYv+AZER+nriN5irraPWu9kHuBo31f7Wx6TNeggbHMr2HHdDLI6mVB/FwOOXCd9Lv5BmerLnQrgjl3prlj+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540496; c=relaxed/simple;
	bh=PrZzCy2cGIvNKyqPlF29RNpkiBN75wr7qz5JmPP/oR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtAYWfB4sBe0IaFa7Fhor8cfsG/SK0coQBYk/57b73sIfsHgnnxQdVh2G0g3XrjOPi+Aa0u9ko/XB7xQKGVh0YWO6YpiY9x1ntWCtFvLB3oSPtMW3J2PCCHtmBFHl0hupOGEpEio9UJfpOUBn1l8UgqJLEBw+3onZe5Eijx4js8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDhIOwyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4F7C116B1;
	Mon, 22 Sep 2025 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758540495;
	bh=PrZzCy2cGIvNKyqPlF29RNpkiBN75wr7qz5JmPP/oR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDhIOwyIaX/Jfz/QdWhfC1ByDLg2hRGYygbuzpqXa8H4XOYc8rDFWATznPlZy72I7
	 qMjZaMATotRcV97OxDC4Y9Nsigjz40HXl2bYRAKJG3U++Pp5LTgNgULcapNqvCc+le
	 7mmnxyX2npYLNPxIIVKVIQha+Bv+e6ui3w/5HhZVBxbpekgpCrpijoVWX8hBcQC8B2
	 3o8nUo9P0f+V3r+9hCp78tuUQghWbSGqVXiP3p+H8psgijvxNtUkfGbAc//vMuneDi
	 FHlboFQDuA2mW+ga+lgSXCtj7yX4vg4QRcMynhJqaQEq8VMwFikfWq6VP56MqH2KOl
	 RqZNJcmUI9bxw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0eiL-00000005vOx-3c40;
	Mon, 22 Sep 2025 13:28:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2 3/3] tools/docs/sphinx-build-wrapper: allow skipping sphinx-build step
Date: Mon, 22 Sep 2025 13:27:40 +0200
Message-ID: <30dae295606ae1735f3bbeef4ca041a76dcd4540.1758539031.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758539031.git.mchehab+huawei@kernel.org>
References: <cover.1758539031.git.mchehab+huawei@kernel.org>
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


