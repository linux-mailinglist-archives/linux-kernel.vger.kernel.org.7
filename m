Return-Path: <linux-kernel+bounces-770818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EEFB27F59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1095E882A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DDE3009FB;
	Fri, 15 Aug 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1KeOAvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3A2877FA;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=pAQ7nBHSO9UXHhEkwb1IbM8oVDcQ8eE8NwKB7Eyc2F/0SHgY2xCBnKzHAoFIx5YDvzWiviCnN6lRP8YNrqCiazX81Bd2MBqN0D8j8uzGvyQ6fmd3DywfiZZjACDb5ObCDzodykVulq/kYxCo+0CwYFcFnGDOZTwl4CI9Bv+BpIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=x7MW3bRve0BOOp4971V2uJ3c3u7EbdqpTM9d9SjBZLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mg9eABHvCbD8JOlX8CPNR0wSBvSIruUJY/CtJ3oSiDeJ09PE7fUPxY8FNRUQqmuDUGNAvfoKhJLWBsXalrZax9CFMhWo984X8BrpUjLh0nl2iI2TfgHmWOi5xOwYPAvGgHwRLmjLb7XTYvUBRrbL0+Yym+po3XxkzCk9tnPnWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1KeOAvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0606C4CEF5;
	Fri, 15 Aug 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257845;
	bh=x7MW3bRve0BOOp4971V2uJ3c3u7EbdqpTM9d9SjBZLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1KeOAvS3r3Q4dPyVQdSrawwkVjsICuOoJwjEygIdbsVlELusUsHS1Wf+iQv1Iivb
	 S2ixF27n4WTIrQ+x5EDNinCvEGHYfvzRm3DfQSf4uDsAIgs09RsA1EmG+Pnqi5eoTz
	 6MsGcjavkZBHL0NjgEk8CQWsVk+qkJx9M3YOVcmhZ6DIg6rbtskdIrUG8OiKuw9m8u
	 Qsu9L2Sr3jQU6cBPpOS6ukauSExINjEMblv1KVxxZgiwmljgMjexEMB3Qep0EeiaAO
	 ANS0Gm8I6ROiwbBQ6ffPllBfzwK/aMUhc+Rb978gi5Cpp/o7dI4uYyxlDZW6YrYog1
	 dm1lk61LhBFZw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskN-000000042T1-4B7h;
	Fri, 15 Aug 2025 13:37:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] docs: conf.py: better handle latex documents
Date: Fri, 15 Aug 2025 13:36:18 +0200
Message-ID: <6856916fe21b4ad31c692517b4a7fcb3bd320935.1755256868.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755256868.git.mchehab+huawei@kernel.org>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The original logic assumed that app.srcdir is identical to the
current working dir. This is the case for a normal build, but,
when SPHINXDIRS="some dir" is used, this is not the case anymore.

Adjust the logic to fill the LaTeX documents considering
app.srcdir, in a way that it will work properly on all cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 54 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index f9828f3862f9..2c1be59fd54b 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -51,11 +51,13 @@ else:
     dyn_exclude_patterns.append("devicetree/bindings/**.yaml")
     dyn_exclude_patterns.append("core-api/kho/bindings/**.yaml")
 
-# Properly handle include/exclude patterns
-# ----------------------------------------
+# Properly handle directory patterns and LaTeX docs
+# -------------------------------------------------
 
-def update_patterns(app, config):
+def config_init(app, config):
     """
+    Initialize path-dependent variabled
+
     On Sphinx, all directories are relative to what it is passed as
     SOURCEDIR parameter for sphinx-build. Due to that, all patterns
     that have directory names on it need to be dynamically set, after
@@ -86,6 +88,25 @@ def update_patterns(app, config):
 
         config.exclude_patterns.append(rel_path)
 
+    # LaTeX and PDF output require a list of documents with are dependent
+    # of the app.srcdir. Add them here
+
+    for fn in os.listdir(app.srcdir):
+        doc = os.path.join(fn, "index")
+        if not os.path.exists(os.path.join(app.srcdir, doc + ".rst")):
+            continue
+
+        has = False
+        for l in latex_documents:
+            if l[0] == doc:
+                has = True
+                break
+
+        if not has:
+            latex_documents.append((doc, fn + ".tex",
+                                    "Linux %s Documentation" % fn.capitalize(),
+                                    "The kernel development community",
+                                    "manual"))
 
 # helper
 # ------
@@ -456,32 +477,9 @@ latex_elements["preamble"] += """
         \\input{kerneldoc-preamble.sty}
 """
 
-# Grouping the document tree into LaTeX files. List of tuples
-# (source start file, target name, title,
-#  author, documentclass [howto, manual, or own class]).
-# Sorted in alphabetical order
+# This will be filled up by config-inited event
 latex_documents = []
 
-# Add all other index files from Documentation/ subdirectories
-for fn in os.listdir("."):
-    doc = os.path.join(fn, "index")
-    if os.path.exists(doc + ".rst"):
-        has = False
-        for l in latex_documents:
-            if l[0] == doc:
-                has = True
-                break
-        if not has:
-            latex_documents.append(
-                (
-                    doc,
-                    fn + ".tex",
-                    "Linux %s Documentation" % fn.capitalize(),
-                    "The kernel development community",
-                    "manual",
-                )
-            )
-
 # The name of an image file (relative to this directory) to place at the top of
 # the title page.
 # latex_logo = None
@@ -577,4 +575,4 @@ loadConfig(globals())
 def setup(app):
     """Patterns need to be updated at init time on older Sphinx versions"""
 
-    app.connect('config-inited', update_patterns)
+    app.connect('config-inited', config_init)
-- 
2.50.1


