Return-Path: <linux-kernel+bounces-765173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5677B22C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F5B504AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C53A2FA81D;
	Tue, 12 Aug 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip4R/w8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94D2F8BC3;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=eAfTQvAPsl0P85/8YIlNysgLizAEHSsVi/uiT3ye0qK3c3ZRzlq/S5IcfwTTxtkseCBzKF2/cFgH51mvP1vaXhSwPgEhcSp+k5LSyHTMtE1qjFLQRJpHkJxj/u4Smm/KNo+oxXlBVFkJfDceEduMCEI20enz8fUf+Naw+OOFLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=cob72lTRvAFK2nKnFZHwgao4n+Ti/eTdktqy5wFC7NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQXhsMrwkfODqv0s92AQJWi8JBo5SKSd7gDacX4hj+20f38RpRgvkG3ERYFjZo6VFhiT4+eGzVH3p9TDlmxfoe+coF3VuL9zikoLVi7XxuoFRm8cBuwRr0mKJrG5SURfQfeLq/9qaVVa1MqqbF+BBgmb7DIU8kDu65SSlRFE//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip4R/w8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2EAC113CF;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=cob72lTRvAFK2nKnFZHwgao4n+Ti/eTdktqy5wFC7NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ip4R/w8WKu4o/Sx7cFm84ltMbnw3oAznk6tLfiWw7QM6ghYHPIJLOTfzUJ9COR21w
	 1/E/uK23u7V7Oi5jkKdRijdOZLhI2b/X7Bywu39BEfdKiBCC//BO/smwp8kgIlxFcj
	 FLNY2aMT0czPFXx/q+gfAVJRNpTyTzTZFwOK0m7PGIMCOCUQPJIFaoG1pGVc2XE5gT
	 KkHaEtLJ6OrvK8s2Rd3hJSRvKCkmjthUuld4LcDSI1bZTJjduhKzVlOtEWpZDI0SMr
	 JpIsBQIBBxx6WWfgDURHhIdWDoyVUwBI1A0JgTwjEIyJI0z4b4dpdz57YsjKIAb7yJ
	 gczE4r3gj8h1g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVq-1RSx;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/39] scripts: sphinx-pre-install: fix support for gentoo
Date: Tue, 12 Aug 2025 17:52:27 +0200
Message-ID: <283987633aae7d99e0eff41e24eb6285c1b6b335.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Some gentoo packages have changes. Fix it.

While here, improve emerge portage use logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 65438c198674..b793796329c8 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -669,12 +669,13 @@ class SphinxDependencyChecker:
 
     def give_gentoo_hints(self):
         progs = {
-            "convert":      "media-gfx/imagemagick",
-            "dot":          "media-gfx/graphviz",
-            "rsvg-convert": "gnome-base/librsvg",
-            "virtualenv":   "dev-python/virtualenv",
-            "xelatex":      "dev-texlive/texlive-xetex media-fonts/dejavu",
-            "yaml":         "dev-python/pyyaml",
+            "convert":       "media-gfx/imagemagick",
+            "dot":           "media-gfx/graphviz",
+            "rsvg-convert":  "gnome-base/librsvg",
+            "virtualenv":    "dev-python/virtualenv",
+            "xelatex":       "dev-texlive/texlive-xetex media-fonts/dejavu",
+            "yaml":          "dev-python/pyyaml",
+            "python-sphinx": "dev-python/sphinx",
         }
 
         if self.pdf:
@@ -699,21 +700,17 @@ class SphinxDependencyChecker:
             print("You should run:")
         print("\n")
 
-        imagemagick = "media-gfx/imagemagick svg png"
-        cairo = "media-gfx/graphviz cairo pdf"
-        portage_imagemagick = "/etc/portage/package.use/imagemagick"
-        portage_cairo = "/etc/portage/package.use/graphviz"
 
-        result = self.run(["grep", "imagemagick", portage_imagemagick],
-                          stdout=subprocess.PIPE, text=True)
-        if not result.stdout.strip():
-            print(f"\tsudo su -c 'echo \"{imagemagick}\" > {portage_imagemagick}'")
+        portages = [
+            "media-gfx/imagemagick",
+            "media-gfx/graphviz",
+        ]
 
-        result = self.run(["grep", "graphviz", portage_cairo],
-                          stdout=subprocess.PIPE, text=True)
-
-        if not result.stdout.strip():
-            print(f"\tsudo su -c 'echo \"{cairo}\" > {portage_cairo}'")
+        for p in portages:
+            result = self.run(["grep", p, "/etc/portage/package.use/*"],
+                               stdout=subprocess.PIPE, text=True)
+            if not result.stdout.strip():
+                print(f"\tsudo emerge -av1 {p}")
 
         print(f"\tsudo emerge --ask {self.install}")
 
-- 
2.50.1


