Return-Path: <linux-kernel+bounces-809002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C5FB50752
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183734E85EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7536C090;
	Tue,  9 Sep 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FYDTe1UG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1243629BF;
	Tue,  9 Sep 2025 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450653; cv=none; b=qfFWDYEFJ/al7Q7AdRKK4Zy0CPrfe2hAIDURWszP47Q+CdXxjexG2vMbTRAeo5keIrQE7cWmTjL96g0JIgAl6OnUPpCKQ3e1B3BjwtcFGSm68N29d6iyv6RekEGhRubw/7YpIUH9RpLe7q4zX9ada5ID1DO/yTPPpS3uN2jE6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450653; c=relaxed/simple;
	bh=AskytDTPrYtPcFGtBEg3Nbq7tOIZzlhLCwApIormsQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ps/HNsySB8L4srtbeLJ9JH+AB+GSoxBrhBNT8fvb1EeLC8rNfck5n1AiEK4qfc5SyRF06Lu95sfJr6czbQFLk4o2zqlPOcl0i3KPnk3VD5ohBjRYhDwZTVTfykr89R1BP9YXigSqVZOU5VfV3sLGzcXEvvKkDL8sVgT8PDyMktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FYDTe1UG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2E61840B0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450651; bh=zUk5SRpzBj/HzKwulzlMEnnF5K8QVNxzFjyZknCsUzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYDTe1UGMhK3JgTKPiSNEMSUu2O3kCurzo8+nug0kYljIrwmEZL5g0SFzUTYRCy0H
	 2+IH3B1CGyiEooXkeRmnmCV1KVwr+j6XuuATfJUHNiZu7K3u988BFzxwvQMT3lerVd
	 VpfRuqH19JLPY7PP9rXG3BFIQYIMnojREWp6J5yxZ11yafXvp2M4DIkxbmqA34BY5p
	 oJahEfSltaYrDXCZDRkEVwrLbzmVne/IoNOOXoPzIhpfkkvgmlzK5cbPrgQE9mKBFZ
	 ke4P1jFdUbLvOV6l+zKU1bAUhw2RTUBcrKasb3V+lBXfyUJy3zrNiUXJk9nzXSK9Cj
	 92iYXB3cV+wAw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 2E61840B0D;
	Tue,  9 Sep 2025 20:44:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 10/13] docs: kdoc: final dump_function() cleanups
Date: Tue,  9 Sep 2025 14:43:46 -0600
Message-ID: <20250909204349.123680-11-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909204349.123680-1-corbet@lwn.net>
References: <20250909204349.123680-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some more comments to dump_function(), add some comments, and trim out
an unneeded duplicate output_declaration() call.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 27329ce9b5e9..5e41acfef7b8 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -999,32 +999,28 @@ class KernelDoc:
                                                declaration_name)
                     found = True
                     break
+        #
+        # Parsing done; make sure that things are as we expect.
+        #
         if not found:
             self.emit_msg(ln,
                           f"cannot understand function prototype: '{prototype}'")
             return
-
         if self.entry.identifier != declaration_name:
-            self.emit_msg(ln,
-                          f"expecting prototype for {self.entry.identifier}(). Prototype was for {declaration_name}() instead")
+            self.emit_msg(ln, f"expecting prototype for {self.entry.identifier}(). "
+                          f"Prototype was for {declaration_name}() instead")
             return
-
         self.check_sections(ln, declaration_name, "function")
-
         self.check_return_section(ln, declaration_name, return_type)
+        #
+        # Store the result.
+        #
+        self.output_declaration(decl_type, declaration_name,
+                                typedef=('typedef' in return_type),
+                                functiontype=return_type,
+                                purpose=self.entry.declaration_purpose,
+                                func_macro=func_macro)
 
-        if 'typedef' in return_type:
-            self.output_declaration(decl_type, declaration_name,
-                                    typedef=True,
-                                    functiontype=return_type,
-                                    purpose=self.entry.declaration_purpose,
-                                    func_macro=func_macro)
-        else:
-            self.output_declaration(decl_type, declaration_name,
-                                    typedef=False,
-                                    functiontype=return_type,
-                                    purpose=self.entry.declaration_purpose,
-                                    func_macro=func_macro)
 
     def dump_typedef(self, ln, proto):
         """
-- 
2.51.0


