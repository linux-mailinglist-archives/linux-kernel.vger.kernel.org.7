Return-Path: <linux-kernel+bounces-794641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61544B3E4AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4154C481BC4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936E3322A1F;
	Mon,  1 Sep 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx+hZ/5+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C430BF7B;
	Mon,  1 Sep 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732887; cv=none; b=dCXGZITr8lEmrRHDuIdl8enoGxqk0+kuV22JXXVVkQXmA4ZYLT/JEvdWTL602CW2YUxYZZUxVf1GfvijoYzxtIC1CDX5cgdU7SYDv4Chxo/TCqvanLfj1sS+7lE6QdKM57Q5SlaaOumHCADrPOEFvfsL8boQxzx8CIyjCH9yG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732887; c=relaxed/simple;
	bh=paNW933ryrWEDMiFPIgdp/xZ5YGElQtG05+ItbRB/bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSn+gaQ7fG0DYIuXi1UFDe3pyArFDIf6/lo5OQ9Av73gKEtxVMh3Eb7Kd0ZhY5QN3k/uDyITkiZNrsankD27taOJIrc7Rhas8slsAu1ZPVoe13WSj88jqvgGXkFYVK8ulfoe2yJNfvvWbizD2NhvknRmobsuZCoe4U04Nx6DJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx+hZ/5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E51C4CEF0;
	Mon,  1 Sep 2025 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732887;
	bh=paNW933ryrWEDMiFPIgdp/xZ5YGElQtG05+ItbRB/bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jx+hZ/5+h2JynkLVQ4GXRFQWLkeDOv1wEUfOzv+kZdZ6rbFP4wtrT+lNDRLMV19BU
	 7/SHeZEwLjSe8z39GrLIhUZ/R6watFjz3A48RXv1oa1m1WoUZRe0KUiGSnpenS3DJu
	 /rRB0jK1rzQCu3Fm0j2cG8h1XqRQzVTDx9JipB+bQbu0ILX5OPL8S5+EB/yM6hO+H7
	 algtafiWmErnkPWyUSQgVkrjA+9/bbYQm5FOhhIoT401Cv6A9R1qBwP05NOxAU3YCv
	 m9e+ukfRP/yAJRgblqwLrkuY3jmcWvA9Loi7aKgrlb9VGvHWz9tc87j6aoRHkinBGX
	 50dhDYf832nkA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut4TN-00000003Dcb-2Fzi;
	Mon, 01 Sep 2025 15:21:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] docs: kernel_include.py: fix an issue when O= is used
Date: Mon,  1 Sep 2025 15:21:21 +0200
Message-ID: <da91980ce42f31730dc982920167b2757b9d2769.1756732363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756732363.git.mchehab+huawei@kernel.org>
References: <cover.1756732363.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As reported by Stephen, building docs with O= is now
broken. Fix it by ensuring that it will seek files under
Kernel source tree.

The original logic was defined to accept including files
under Documentation/output. The new logic doesn't need it
anymore for media, but it might still be useful to preserve
the previous behavior. So, I ended preserving it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20250901142639.4de35a11@canb.auug.org.au/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 44 +++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 23566ab74866..661ed978bed8 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -314,15 +314,49 @@ class KernelInclude(Directive):
     def run(self):
         """Include a file as part of the content of this reST file."""
         env = self.state.document.settings.env
-        path = os.path.realpath(os.path.expandvars(self.arguments[0]))
 
-        # to get a bit security back, prohibit /etc:
-        if path.startswith(os.sep + "etc"):
-            raise self.severe('Problems with "%s" directive, prohibited path: %s' %
-                              (self.name, path))
+        #
+        # The include logic accepts only patches relative to:
+        #   - Kernel source tree
+        #   - Documentation output directory
+        #
+        # The logic does check it to prevent directory traverse
+        #
+
+        srctree = os.path.abspath(os.environ["srctree"])
+
+        path = os.path.expandvars(self.arguments[0])
+        src_path = os.path.join(srctree, path)
+
+        if os.path.isfile(src_path):
+            base = srctree
+            path = src_path
+        elif os.path.exists(arg):
+            # Allow patches from output dir
+            base = os.getcwd()
+            path = os.path.abspath(path)
+        else:
+            raise self.warning(f'File "%s" doesn\'t exist', path)
+
+        abs_base = os.path.abspath(base)
+        abs_full_path = os.path.abspath(os.path.join(base, path))
+
+        try:
+            if os.path.commonpath([abs_full_path, abs_base]) != abs_base:
+                raise self.severe('Problems with "%s" directive, prohibited path: %s' %
+                                  (self.name, path))
+        except ValueError:
+            # Paths don't have the same drive (Windows) or other incompatibility
+            raise self.severe('Problems with "%s" directive, invalid path: %s' %
+                            (self.name, path))
 
         self.arguments[0] = path
 
+        #
+        # Add path location to Sphinx dependencies to ensure proper cache
+        # invalidation check.
+        #
+
         env.note_dependency(os.path.abspath(path))
 
         # HINT: I had to copy&paste the whole Include.run method. I'am not happy
-- 
2.51.0


