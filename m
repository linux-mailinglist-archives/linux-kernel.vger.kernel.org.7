Return-Path: <linux-kernel+bounces-726643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D34CB00FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDEE1CA8534
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC928B418;
	Thu, 10 Jul 2025 23:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jHj5Q8u1"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE13093BC;
	Thu, 10 Jul 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190320; cv=none; b=UtDeePYCgPMNrSShGt/kkVJ9y2VdATy/jcdkzmXK6p22JOV9QbUAy5vNVYw70C69EliP7iq2B3T6/xdZlu/iDOekPnGeCUye8420FiUuuB1GxTGwH2198Tr8LmvNAwvqLo5ztCZqTyaPrBAKquHoIpxs1gZSTi2JsmpI1I34Pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190320; c=relaxed/simple;
	bh=dECE7HmGYRkH+wFN9HM0uf4VtBgfKt5FWt2EPDfKnrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO06lNnAjKt9uNTHL6j7FdyBKDQUmjnWTGogs/W9nSZ/oGevLjH5O+5NENWQJf5+JEE10Uh4JtyRuywFbyhwsW9yKx/Rnv9LL4W21GhSPv6vqjlFHq4ZkXhnBGWjBVYkAOAlOSpBus+UGpZP1E9F+MhKLv3mfycEv/WbjXqmi6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jHj5Q8u1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 38BD540AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190318; bh=nPOfJuokmVPpEF/4Hc1zpZaBuvlA3dKu+HWEiyN98XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHj5Q8u1vBkg9Zkb2jHuyUCURSzP5asEjJi4ROq0PLwmRJvM6PF5mggcJt8R+zF/t
	 FXC6X9gyypTr5pUEQTot32ryGefynXaeQYGJ/Y6u5DQr0N4cJCEIKsdkTz7/7PkLmy
	 W3a5uIGSPdd0s2CtTUGat+CdZCwelBXdnxxlKkiCbYrLSOT7wbVcebk88pYUF9NEPt
	 5z2uP1+CnlmrP8AmX0VNSm07x0fZD8j7x8cD0ZBtXkV8TRmTDaw8ufT0jmmv8hgauX
	 zrtJ7OnIAQBcx5D5HSh49mEPpa0QpDsryiQVIUbjhBcmhdPFTIY7cTwiH36O7nNI9O
	 We0FAKmXwLaJg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 38BD540AB5;
	Thu, 10 Jul 2025 23:31:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 11/12] docs: kdoc: clean up check_sections()
Date: Thu, 10 Jul 2025 17:31:41 -0600
Message-ID: <20250710233142.246524-12-corbet@lwn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710233142.246524-1-corbet@lwn.net>
References: <20250710233142.246524-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

entry.sectcheck is just a duplicate of our list of sections that is only
passed to check_sections(); its main purpose seems to be to avoid checking
the special named sections.  Rework check_sections() to not use that field
(which is then deleted), tocheck for the known sections directly, and
tighten up the logic in general.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 7191fa94e17a..fdde14b045fe 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -42,9 +42,11 @@ doc_decl = doc_com + KernRe(r'(\w+)', cache=False)
 #         @{section-name}:
 # while trying to not match literal block starts like "example::"
 #
+known_section_names = 'description|context|returns?|notes?|examples?'
+known_sections = KernRe(known_section_names, flags = re.I)
 doc_sect = doc_com + \
-            KernRe(r'\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$',
-                flags=re.I, cache=False)
+    KernRe(r'\s*(\@[.\w]+|\@\.\.\.|' + known_section_names + r')\s*:([^:].*)?$',
+           flags=re.I, cache=False)
 
 doc_content = doc_com_body + KernRe(r'(.*)', cache=False)
 doc_inline_start = KernRe(r'^\s*/\*\*\s*$', cache=False)
@@ -115,7 +117,6 @@ class KernelEntry:
         self.config = config
 
         self._contents = []
-        self.sectcheck = ""
         self.prototype = ""
 
         self.warnings = []
@@ -187,7 +188,6 @@ class KernelEntry:
             self.parameterdescs[name] = contents
             self.parameterdesc_start_lines[name] = self.new_start_line
 
-            self.sectcheck += name + " "
             self.new_start_line = 0
 
         else:
@@ -478,29 +478,20 @@ class KernelDoc:
                         self.push_parameter(ln, decl_type, param, dtype,
                                             arg, declaration_name)
 
-    def check_sections(self, ln, decl_name, decl_type, sectcheck):
+    def check_sections(self, ln, decl_name, decl_type):
         """
         Check for errors inside sections, emitting warnings if not found
         parameters are described.
         """
-
-        sects = sectcheck.split()
-
-        for sx in range(len(sects)):                  # pylint: disable=C0200
-            err = True
-            for param in self.entry.parameterlist:
-                if param == sects[sx]:
-                    err = False
-                    break
-
-            if err:
+        for section in self.entry.sections:
+            if section not in self.entry.parameterlist and \
+               not known_sections.search(section):
                 if decl_type == 'function':
                     dname = f"{decl_type} parameter"
                 else:
                     dname = f"{decl_type} member"
-
                 self.emit_msg(ln,
-                              f"Excess {dname} '{sects[sx]}' description in '{decl_name}'")
+                              f"Excess {dname} '{section}' description in '{decl_name}'")
 
     def check_return_section(self, ln, declaration_name, return_type):
         """
@@ -754,7 +745,7 @@ class KernelDoc:
 
         self.create_parameter_list(ln, decl_type, members, ';',
                                    declaration_name)
-        self.check_sections(ln, declaration_name, decl_type, self.entry.sectcheck)
+        self.check_sections(ln, declaration_name, decl_type)
 
         # Adjust declaration for better display
         declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
@@ -1018,7 +1009,7 @@ class KernelDoc:
                           f"expecting prototype for {self.entry.identifier}(). Prototype was for {declaration_name}() instead")
             return
 
-        self.check_sections(ln, declaration_name, "function", self.entry.sectcheck)
+        self.check_sections(ln, declaration_name, "function")
 
         self.check_return_section(ln, declaration_name, return_type)
 
-- 
2.49.0


