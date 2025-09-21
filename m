Return-Path: <linux-kernel+bounces-826100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8584FB8D889
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFB817D0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B00724DCFD;
	Sun, 21 Sep 2025 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzmkkGtw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADE247291;
	Sun, 21 Sep 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758446024; cv=none; b=p/Fy2CzKfNKsHXazGrNUPVaCwGdGOsvf9mLthT5jZlaI/GlcT19hYT+ggM6P6P1nO05o4ltk25qK6eFEyCICgDNhNd2TpO0P6Lgnn3JJvQN9rTeU74LIHIidO2BK548+prcq/Fgaah2gkiHU5YWbNGtbYyxMpmVEhRQfThuGPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758446024; c=relaxed/simple;
	bh=qtWjq2u9Fz9LWQsKY5HbV/3WErrU5ohWZJS1W0AyBoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doL5iTXkRe6w6ymJlAUINftF3Fw++ZyrHrmTtwDcrKs7TFPD9TCX4RNrROspRaYMkJiDmC6ilZVryEqSHGABjklwZ+UU1tJ4QmLWFGXG0EVgBVvXlBW1aG5BCPweeAgC3xO500lg80hPHfIz8lhXkQOwewumQm0T9mXweHNIBM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzmkkGtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0ECC4CEE7;
	Sun, 21 Sep 2025 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758446023;
	bh=qtWjq2u9Fz9LWQsKY5HbV/3WErrU5ohWZJS1W0AyBoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzmkkGtwmx+MgXwzuo1cUHVBxl7FhCVbHK4/Zmyf3Lghh3q8URwGpQHgCcrWgdi7h
	 qQIxid75RgatbwynS5glKMSdb5pvp+oYRUjq+KeHOuAW+j99I1xZi5mVDi9pBzoZBH
	 nVhLpRsGimMgx7M9Sv2GBLaeKSwlWEFlXMzkc+0FRiFx7jKtcyllN2104AEYlN8ugv
	 rB4NpNYAA+qwVeeo5y/ko6+8cnNiv/CFxMxjPHQgeKF6eZN51gcRMHwL+W1hMO7E/2
	 hhnlRCH5Q1r0P+AdSGAC3UjhKIKgnjApUafyxH3O58zRUV/hXAOBJGgR02UhQh5O1O
	 wI8j8w4bu+DTQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0G8b-00000005CWE-21XV;
	Sun, 21 Sep 2025 11:13:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tools/docs/sphinx-build-wrapper: allow skipping sphinx-build step
Date: Sun, 21 Sep 2025 11:13:25 +0200
Message-ID: <10e440eafe6bf00cbc9f50df66fd7516b6f92769.1758444913.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758444913.git.mchehab+huawei@kernel.org>
References: <cover.1758444913.git.mchehab+huawei@kernel.org>
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
index bd8e2ed746e7..1f9c66ab33fe 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -603,7 +603,8 @@ class SphinxBuilder:
         shutil.rmtree(self.builddir, ignore_errors=True)
 
     def build(self, target, sphinxdirs=None,
-              theme=None, css=None, paper=None, deny_vf=None, rustdoc=False):
+              theme=None, css=None, paper=None, deny_vf=None, rustdoc=False,
+              skip_sphinx=False):
         """
         Build documentation using Sphinx. This is the core function of this
         module. It prepares all arguments required by sphinx-build.
@@ -625,9 +626,10 @@ class SphinxBuilder:
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
@@ -713,7 +715,7 @@ class SphinxBuilder:
 
             if target == "mandocs":
                 self.handle_man(kerneldoc, docs_dir, src_dir, output_dir)
-            else:
+            elif not skip_sphinx:
                 try:
                     result = self.run_sphinx(sphinxbuild, build_args,
                                              env=self.env)
@@ -795,6 +797,9 @@ def main():
     parser.add_argument('-i', '--interactive', action='store_true',
                         help="Change latex default to run in interactive mode")
 
+    parser.add_argument('-s', '--skip-sphinx-build', action='store_true',
+                        help="Skip sphinx-build step")
+
     parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
                         default=None,
                         help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
@@ -810,7 +815,8 @@ def main():
 
     builder.build(args.target, sphinxdirs=args.sphinxdirs,
                   theme=args.theme, css=args.css, paper=args.paper,
-                  rustdoc=args.rustdoc, deny_vf=args.deny_vf)
+                  rustdoc=args.rustdoc, deny_vf=args.deny_vf,
+                  skip_sphinx=args.skip_sphinx_build)
 
 if __name__ == "__main__":
     main()
-- 
2.51.0


