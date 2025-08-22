Return-Path: <linux-kernel+bounces-782130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C114CB31B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB2F606D63
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96D322A1E;
	Fri, 22 Aug 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdSwNKJt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A851311979;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=oH+YUUVuzid+uE/C5kSduQSAHKgPvGnv9MjTYxuX/bpG/RBeKiRYF3/cLAcfWXYyq++rPf6qivwTVrBlTUamRdkZmnKljFCifIiLUIYTXQAg+jbUY+KgYfQ1sBEYgF5npjgJQc+v+BAG3A5hlY7aNkaqPwycjxEWNEDaK1Xqang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=qu5eqKXlag7ALsP16SkP+d9fl76226iDf9IK5Sgc2pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y352w/Oh8E6x0vY9jzKi1bgMRoMcrS8pWYBtG6OuQGit9w3KK0GZEMVsIpL3v2iK79x/tKY1Vh/KiiNp4C/KhhGsE2yDa/oEfQUu+cPKPTMD0TOewiBntkgSoSgabwhetZHE6Up5eGGlqYKeTMQT0PBY4DTHE94gzy8J8hL11U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdSwNKJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3331AC19425;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=qu5eqKXlag7ALsP16SkP+d9fl76226iDf9IK5Sgc2pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdSwNKJtIWxqNfoqmY0cnxTHcYolGcM5WW/mwIh0w0awYgEDDtZboXnG+5DlqMEcI
	 N/RjB868xkaXRXQEXQIA/VqG7KOXqEzDIyBRWiYJ9KnBMcmztF67RReWqh+UE9zTFD
	 HaKm+zHeqU0+evOhe7SU0GzXFj6RozppGl4ifQF+Ay+Po3OLJzLwCegiSGMqJFtuAm
	 N0yi1Aa3FV5i48XWN7496Rv5MKoHrsVCbbHsuzYBqGJ3CYcqZHuqrosEJAtTcPMHpb
	 ObmxCrdVEAB8lTSv+qVV494IUANdgO6Vy8Xm/a7fLFPESbln1AGjBa/yneB809Poyg
	 dEhBGOFIp6oaw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCrl-1zot;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/24] docs: kernel_include.py: move range logic to a separate function
Date: Fri, 22 Aug 2025 16:19:26 +0200
Message-ID: <12fa2204a9e7e309ae4b8694a37ebad9327ca634.1755872208.git.mchehab+huawei@kernel.org>
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


