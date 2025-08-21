Return-Path: <linux-kernel+bounces-780033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820B8B2FCBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB41D16A811
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9C2D6E40;
	Thu, 21 Aug 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po/npVGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC820284B4E;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=U/Ti2l6qQyv+kF8bqyIblIJoyvAZnTQc/VZVgl6vIgp+Z7cLLUcJnH1bvlTt1ccNejCmtxLNG0EPbpJAglo732XDiEvJhc3hwcl0H3mXUmB2jGAvABJXn8K2q+8J1lvKPXHLOnPgTwvgQ//x2jwfwPyt++c4PGTyqZV0gXVoaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=Ws1QXmr61TBgn6INp6mbk145NP3+6J63X8KSGxb87Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoEISo7Nd+uHPPulCtc/kvB2EVRZYVLz8TbwDRb6KwDweu4anvqpU1erDivEx0RDvvtVJ/yj1akL+IuJfbYL0jIcHjl5LDlPSvNxxumxG8lZbTDi0NuX909woGxDAnWGN3AhdcCwlK2lnwsXZNbpeHO0TfQro+i9C4dPKDJeyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po/npVGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3860BC4AF0E;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=Ws1QXmr61TBgn6INp6mbk145NP3+6J63X8KSGxb87Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Po/npVGgnsdCdD5oVXuzmKjwuCyVuhasVX1oMR6sWXAwhUpxLoJFf+q4e8RoDOHB5
	 kvYtePU5w6gcHXlsqtg/Gi1fMQ8mFkxOx5ZMr3y/nDpdQ0HtVNyUNMFhegA8up6chy
	 aS1l9rKxltnST7NQt65ito0gKqBsZpGW5MBDqwfTmjJNVRh7c3C7bg0aC0OML8K8Fd
	 xRtltGsKMikh5K63IsvcC5LXZg4Q9q0Vklo4KQxhBIDpAeiiqgqXzomlTjjuYqing1
	 PZdGRhscAfmkHQA3nBeWSsgIgAhogRLHN/Vb97z703MOZGUrFMwcqHGYxGnjWJS0lZ
	 LueazZwTfK05w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT9E-1zuD;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/24] docs: kernel_include.py: move apply_range() and add a docstring
Date: Thu, 21 Aug 2025 16:21:25 +0200
Message-ID: <b7d6bd379aba82a5960abc62c84b4f0fa8f2b8fc.1755784930.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755784929.git.mchehab+huawei@kernel.org>
References: <cover.1755784929.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While not required, better to have caller functions at the end.
As apply_range() is now called by xref_text(), move it to be
before the latter.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 68 ++++++++++++++------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 90ed8428f776..fd4887f80577 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -113,6 +113,42 @@ class KernelInclude(Include):
             except UnicodeError as error:
                 raise self.severe('Problem with directive:\n%s' % ErrorString(error))
 
+    def apply_range(self, rawtext):
+        """
+        Handles start-line, end-line, start-after and end-before parameters
+        """
+
+        # Get to-be-included content
+        startline = self.options.get('start-line', None)
+        endline = self.options.get('end-line', None)
+        try:
+            if startline or (endline is not None):
+                lines = rawtext.splitlines()
+                rawtext = '\n'.join(lines[startline:endline])
+        except UnicodeError as error:
+            raise self.severe(f'Problem with "{self.name}" directive:\n'
+                              + io.error_string(error))
+        # start-after/end-before: no restrictions on newlines in match-text,
+        # and no restrictions on matching inside lines vs. line boundaries
+        after_text = self.options.get("start-after", None)
+        if after_text:
+            # skip content in rawtext before *and incl.* a matching text
+            after_index = rawtext.find(after_text)
+            if after_index < 0:
+                raise self.severe('Problem with "start-after" option of "%s" '
+                                  "directive:\nText not found." % self.name)
+            rawtext = rawtext[after_index + len(after_text) :]
+        before_text = self.options.get("end-before", None)
+        if before_text:
+            # skip content in rawtext after *and incl.* a matching text
+            before_index = rawtext.find(before_text)
+            if before_index < 0:
+                raise self.severe('Problem with "end-before" option of "%s" '
+                                  "directive:\nText not found." % self.name)
+            rawtext = rawtext[:before_index]
+
+        return rawtext
+
     def xref_text(self, env, path, tab_width):
         """
         Read and add contents from a C file parsed to have cross references.
@@ -163,38 +199,6 @@ class KernelInclude(Include):
 
         return []
 
-    def apply_range(self, rawtext):
-        # Get to-be-included content
-        startline = self.options.get('start-line', None)
-        endline = self.options.get('end-line', None)
-        try:
-            if startline or (endline is not None):
-                lines = rawtext.splitlines()
-                rawtext = '\n'.join(lines[startline:endline])
-        except UnicodeError as error:
-            raise self.severe(f'Problem with "{self.name}" directive:\n'
-                              + io.error_string(error))
-        # start-after/end-before: no restrictions on newlines in match-text,
-        # and no restrictions on matching inside lines vs. line boundaries
-        after_text = self.options.get("start-after", None)
-        if after_text:
-            # skip content in rawtext before *and incl.* a matching text
-            after_index = rawtext.find(after_text)
-            if after_index < 0:
-                raise self.severe('Problem with "start-after" option of "%s" '
-                                  "directive:\nText not found." % self.name)
-            rawtext = rawtext[after_index + len(after_text) :]
-        before_text = self.options.get("end-before", None)
-        if before_text:
-            # skip content in rawtext after *and incl.* a matching text
-            before_index = rawtext.find(before_text)
-            if before_index < 0:
-                raise self.severe('Problem with "end-before" option of "%s" '
-                                  "directive:\nText not found." % self.name)
-            rawtext = rawtext[:before_index]
-
-        return rawtext
-
     def literal(self, path, tab_width, rawtext):
         """Output a literal block"""
 
-- 
2.50.1


