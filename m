Return-Path: <linux-kernel+bounces-723796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B96AFEB18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7C6176DAC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5F22EA757;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmY8RSh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B92E6122;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=eQUVFQafYnn+bLDxKiAeDbUXYrNL0zjFtdWetHcJyj7NgZVn9xoCR+5ziNvZJ1slvBfGqYZfrWJUIkU/kRv7Nru4TPo+w9jHueKvZMXbODatMNvVmmtqQyKNn8LqYBtQfW7rD/cxnsCthdEVcWCj1j55hhm2zfKlGczAPgOtkR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=ycz4EO/MkfHKJ8271RLTLGkxXzNhsic8MuWu+lzxdXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L43eBryPTiv8GiBC+6C1jt/frmC+KTMSf1prLGd/xUAzVlIYKq3MkbSciOOFUSgr1Xq4iTl2vnrMn9XlbNoYKUA+qdGtqcHC4jGAehuBIidu+3xdUG8/TrgLPbM99F319DG5C2x/TgeidCljxenu6wwh78lWrMwbMRy2dxe7YtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmY8RSh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE7DC4AF0B;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=ycz4EO/MkfHKJ8271RLTLGkxXzNhsic8MuWu+lzxdXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmY8RSh/2ccIcKCxarhNZ7eU+fsna2ok9uthk9M/gGT+5z+eg22I3yBo+pmf5qzZO
	 rDdn+NdGZPDL2mkUsgTTi8E8ypqHpfwI7Gah8l8hucWz+JjMjSSALaMZDbtWPV1p6K
	 yOs3vzCt8NYpj4tmMbQl/Ys4NMrwUn1sqDWq1mjf7G7v+4Uph3TOQ7ZIj+efd0MYaK
	 tdR4tp22rmATFMBK6hQDWeT0RxBQTjkiLV+Yxuzj2gbSRo/aPIUmFppF1d1bBpC/uE
	 ep3ki9jcx4NCvjdQSJ6KxCqFmSXA5tkLFKYRaXP4ki18/IIJy9S3Pcpulw6WH8t3wg
	 sk0spJ9my/jww==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECa-1UQU;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/39] scripts: sphinx-pre-install: fix support for gentoo
Date: Wed,  9 Jul 2025 15:51:42 +0200
Message-ID: <852f9b2fdf58c32f4dae6e85281e9940a873075b.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

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
2.49.0


