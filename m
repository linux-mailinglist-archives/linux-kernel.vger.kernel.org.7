Return-Path: <linux-kernel+bounces-780029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74962B2FCC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA5162719E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A002D6621;
	Thu, 21 Aug 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRinbi0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD795283FFF;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=Y1Q9u0G2AD0eYzUsSLLlYxsazmTXoY5k8Bam40EQtvQDFlU4ZB5OHxeOjQE6VbU459zqpIkH4BGoE7kbpfQgS7uOEzLzVlEJDbXtiAtaEWQuh7mpyCm3GsvOwAypd92McE3QlCJuQX7qa4CTk6yKPgmStopT8LwB6ajsti6E96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=qu5eqKXlag7ALsP16SkP+d9fl76226iDf9IK5Sgc2pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2aEEb9WZWc+jk4DktyLu5jirh5n9r8aWiwRDO/6PG9f15yb5idiTUU2BWcP+b0/6O4wPhWOZuRgaQKWZqLbaaEKH/GqG0aglnhDu674CbdmSjraXKA0eDlfQs1wuAwOQejI64b8klTYeWouOi93JL8ZvypvZP2SnX1wfOwguvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRinbi0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2FDC19425;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=qu5eqKXlag7ALsP16SkP+d9fl76226iDf9IK5Sgc2pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRinbi0d6r5qMfaikiw5DtkpvrdOOyetl0qHefidh+cg+lNQdpwcx+xA6+sfu1QeN
	 KQ0JmDXxCTRcMhXD2jUgJ0K+zO7K891bjKeGpVHmpkdjQfbusB7/W6ovjI10+ASGgD
	 RQejKDkArVxdx8ZIwnwTiBRNDdQ26eOPiiEe4uzalKCianmRw3TJ1sR39EpuzaVb7t
	 n3DVWanaRyhQDddqN2AoEC8TrSJgSGyApATG2krXPQQFAPSnoK7pHlW04sQK5nk3ey
	 4t0IN/TFjo0lGd8fGifxuBJqSPwYxEOJHruLwK3aKCzxetWHqDWnEJzZtXcAbjquNP
	 1anIs8lJN6AXQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT8u-1SLl;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/24] docs: kernel_include.py: move range logic to a separate function
Date: Thu, 21 Aug 2025 16:21:20 +0200
Message-ID: <811121f0b40c788936c6aec92a27500767b9b0dd.1755784930.git.mchehab+huawei@kernel.org>
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

Cleanup run() function by moving the range logic to a separate
function.

Here, I ended checking the current Sphinx implementation, as it
has some extra logic for the range check.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 51 +++++++++++++++++---------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index ef86ee9e79d6..c5f4f34e22cb 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -131,6 +131,38 @@ class KernelInclude(Include):
 
         return parser.gen_output()
 
+    def apply_range(self, rawtext):
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
     def run(self):
         """Include a file as part of the content of this reST file."""
         env = self.state.document.settings.env
@@ -185,24 +217,7 @@ class KernelInclude(Include):
         else:
             rawtext = self.read_rawtext(path, encoding)
 
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
+        rawtext = self.apply_range(rawtext)
 
         include_lines = statemachine.string2lines(rawtext, tab_width,
                                                   convert_whitespace=True)
-- 
2.50.1


