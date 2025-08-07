Return-Path: <linux-kernel+bounces-759531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0CAB1DEBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD230620B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0001274642;
	Thu,  7 Aug 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sGHV8l5/"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C1253934;
	Thu,  7 Aug 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601419; cv=none; b=Jagm21r6FSxwxbuCuehp87Pc0bbgDNDPF7TBm4lCcKNwHweXaZOaV5XIcKPAaucbEgyajEfe5/yZrE+wsgXCIXRFj3hJqLuCYzMRneoRPMAlYQ4CwTdWyiq5YGOaJEgJdND4e+Y/x4mC2X9XCNLaoL3KKmdJBBdtEQJ7OkrVNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601419; c=relaxed/simple;
	bh=L2cDRRPB5aff3Em7QzWZf/GRyXBTUFvU1Z5hya/sLok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paCCadssNYw/FGXCWzbMSHtLBCz1SRB8IzO6GvAhRgaoYdcC9QzXEftPoLZZaNSlV5FASBD0V/Kzzo4zv0Hohm/ba+DERyy5KTRWFx+mOs0b/Sj0NcegJwKZ3/RU9rpvcn629J/3+qQTsfuI7H2/S2mOPTAU5kmsXGg7m0faHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sGHV8l5/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC6E540AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601411; bh=YuXq70gYDsDxuz2bttxrJmH0VnivAUsKGyBztKXkuug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGHV8l5/Rk2e+s7obyRPNjPZu1sjIXq0Lf8CK3psAherICZ84m+bSAOsI1kwwVKP/
	 10U/lQg8Yg8jQzl96gdTdq1EP2qJjAnMX4hVKxUd2Rq95dYg/HlZAGjkB85iULYgus
	 AjBA2tZzTHLgiSfV5Z7zawhQaCT1l8uVItwensWrgpW6VFpmD7NhvnxQQkTot2GpSv
	 6bRBjn2AbKGM6Y9uf5wIwNls3MzFzof74SrDkxp6wH/Fnfi+J9GPhcLa5m+nHIeMhG
	 S1MMttXkPF9dHlz9ocLwtNbLKAswMcN+argwng/4S1KCMV6RDXT2xghez80DYkrkiE
	 44W2tLeXrM/TQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id BC6E540AE7;
	Thu,  7 Aug 2025 21:16:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 03/12] docs: kdoc: backslashectomy in kdoc_parser
Date: Thu,  7 Aug 2025 15:16:30 -0600
Message-ID: <20250807211639.47286-4-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807211639.47286-1-corbet@lwn.net>
References: <20250807211639.47286-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A lot of the regular expressions in this file have extraneous backslashes
that may have been needed in Perl, but aren't helpful here.  Take them out
to reduce slightly the visual noise.

Escaping of (){}[] has been left in place, even when unnecessary, for
visual clarity.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index aa6d11bf29b1..14ded23f11e0 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -46,7 +46,7 @@ doc_decl = doc_com + KernRe(r'(\w+)', cache=False)
 known_section_names = 'description|context|returns?|notes?|examples?'
 known_sections = KernRe(known_section_names, flags = re.I)
 doc_sect = doc_com + \
-    KernRe(r'\s*(\@[.\w]+|\@\.\.\.|' + known_section_names + r')\s*:([^:].*)?$',
+    KernRe(r'\s*(@[.\w]+|@\.\.\.|' + known_section_names + r')\s*:([^:].*)?$',
            flags=re.I, cache=False)
 
 doc_content = doc_com_body + KernRe(r'(.*)', cache=False)
@@ -60,7 +60,7 @@ attribute = KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
 export_symbol = KernRe(r'^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*', cache=False)
 export_symbol_ns = KernRe(r'^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*', cache=False)
 
-type_param = KernRe(r"\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+type_param = KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
 
 #
 # Tests for the beginning of a kerneldoc block in its various forms.
@@ -405,7 +405,7 @@ class KernelDoc:
 
         for arg in args.split(splitter):
             # Strip comments
-            arg = KernRe(r'\/\*.*\*\/').sub('', arg)
+            arg = KernRe(r'/\*.*\*/').sub('', arg)
 
             # Ignore argument attributes
             arg = KernRe(r'\sPOS0?\s').sub(' ', arg)
@@ -428,7 +428,7 @@ class KernelDoc:
 
                 arg = arg.replace('#', ',')
 
-                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)')
+                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\].]*)\s*\)')
                 if r.match(arg):
                     param = r.group(1)
                 else:
@@ -443,7 +443,7 @@ class KernelDoc:
                 # Array-of-pointers
 
                 arg = arg.replace('#', ',')
-                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\]\.]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
+                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\].]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
                 if r.match(arg):
                     param = r.group(1)
                 else:
@@ -709,7 +709,7 @@ class KernelDoc:
                         if not arg:
                             continue
 
-                        r = KernRe(r'^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).*)')
+                        r = KernRe(r'^([^\(]+\(\*?\s*)([\w.]*)(\s*\).*)')
                         if r.match(arg):
                             # Pointer-to-function
                             dtype = r.group(1)
@@ -1044,7 +1044,7 @@ class KernelDoc:
         Stores a typedef inside self.entries array.
         """
 
-        typedef_type = r'((?:\s+[\w\*]+\b){0,7}\s+(?:\w+\b|\*+))\s*'
+        typedef_type = r'((?:\s+[\w*]+\b){0,7}\s+(?:\w+\b|\*+))\s*'
         typedef_ident = r'\*?\s*(\w\S+)\s*'
         typedef_args = r'\s*\((.*)\);'
 
@@ -1265,7 +1265,7 @@ class KernelDoc:
             self.dump_section()
 
             # Look for doc_com + <text> + doc_end:
-            r = KernRe(r'\s*\*\s*[a-zA-Z_0-9:\.]+\*/')
+            r = KernRe(r'\s*\*\s*[a-zA-Z_0-9:.]+\*/')
             if r.match(line):
                 self.emit_msg(ln, f"suspicious ending line: {line}")
 
@@ -1476,7 +1476,7 @@ class KernelDoc:
         """Ancillary routine to process a function prototype"""
 
         # strip C99-style comments to end of line
-        line = KernRe(r"\/\/.*$", re.S).sub('', line)
+        line = KernRe(r"//.*$", re.S).sub('', line)
         #
         # Soak up the line's worth of prototype text, stopping at { or ; if present.
         #
-- 
2.50.1


