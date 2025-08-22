Return-Path: <linux-kernel+bounces-782139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C1B31BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3E464638E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9EA340D9C;
	Fri, 22 Aug 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/UmZz7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC53126B6;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=qLf2i4Dh4QFJCLqnTlQZ0IKI0VM7+PL8MOumJTlyAaymiGVrCK9oSS3sEPzZiipRjgLgAWr3UWQi4QoAiFRjFbSd3Qeq+6qtXKPaKjo5qXcYFUSGZZWNu6S6nR/rDsg7KWh/FlW/oRcV4bNCBnyRM6PPSBR7qf/RkEeWjyYoasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=Ws1QXmr61TBgn6INp6mbk145NP3+6J63X8KSGxb87Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h35OQ33KyF7+nPnjMP1jJT1Z5OiTHzF1iyBH7JkxYZXbRig9WQ/qDehPuPTur9yfcpetpShcVdtk1HJS7YMdXu+1AM8eKVBbqb/egxoyEogCYZbbp7sjEv+l3sousKYQITnT1z9H7k8NycBYD9fkkvz20Kv1EuvSH3Ro1RCiMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/UmZz7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF21C2BCFB;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=Ws1QXmr61TBgn6INp6mbk145NP3+6J63X8KSGxb87Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/UmZz7yAOustPWvl4KdxNa10k9SKWpsVEgVCBHWWf2qeF9aIrTQJl7w7HcQAXpx2
	 lhK5ujvC58DtAbc3i3mwHico7q3QrXurJ00wVtE7oCYB6MWdzf8s40abNQdyogKjTo
	 nyCJYRTZzy3O+8AIyOT2vX4RXmtnlm+BVE8cvKftd0TVeYfU0DnDDBjurqXhdqUeDf
	 oFMKr1E8bq/SvcUYNN3fCvRpLafkkhIbCBpgCNQuraAoNAz20XcYPSd7+8wAB+0bwC
	 n47qFXAld4ObKSRDYjBRDmdpX5pp8uIsbrTVMJ6rz9XZTIOdOnV6WgRUOykCWHk2Sy
	 8asOz4S2JOfwg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCs7-2Xu1;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/24] docs: kernel_include.py: move apply_range() and add a docstring
Date: Fri, 22 Aug 2025 16:19:31 +0200
Message-ID: <a6ce0fd7c03a01338753fd81ed0c4631f78311d6.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
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


