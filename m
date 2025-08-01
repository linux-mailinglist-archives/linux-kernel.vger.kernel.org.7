Return-Path: <linux-kernel+bounces-752749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6357B17A75
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D025A0D29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A3D20311;
	Fri,  1 Aug 2025 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="emE1SCB3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDF3D81;
	Fri,  1 Aug 2025 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007224; cv=none; b=eAd+FjeUb48gk3wLvRxld2d0tX5DgUgZdxWDi8M6o+W+7Q7mb5+UVChabsAVQ7zbNeDmoNaOS4ukc2A3xrf1wmVhKU5vO/iFrJ7aOQeMTi46Fa4oeFU0KRmTwDUClDWSghcqwqGnBY6xXkACn88HqwHDLMrHQ99HvGPE7VlYT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007224; c=relaxed/simple;
	bh=bEcraGPV3gR6r987wiaDaKSp3nJiNG59kH23+FTy4qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kH8CuPFFeP8awQybEvWoCGVL5RNaMR6LwCOWMrVsmGGVzxWrJI2WP2KAW3+xbiaSmFL+54ZbTvODEwJEks9MnGjd9vOrfJB+MQucv6nw81voZ8d5CadGz4FCRv0nAGxXLsspug5FyOpljl9xHb3DVVrMWffytJqRXbOKo89S3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=emE1SCB3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4CD5F40AE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007216; bh=BMowMrRpgTtdnzeANz/44PHHl5NAaWPnyULE2WLjzW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emE1SCB3Je0HVXYzD3QL1p5c9SgjuyoubV3LnMmAyeGbdcfHAMcQcu9Q7BlhQnVFs
	 W35Y6sflAxcFqVhRNJv1BmbuT6VIIqSSymahfHws1HjHJ9AtiNdrdRDkJ7juyXecnB
	 e6JV3cc+zGG8xUaXPK/Q00vigjv2y3qEUClqIoez6h2X1LF/IYiUwsrIXF94sEZd+j
	 Im4qr7SEUDQ01/2ySAyzXZmND+nfpxxoI/j9KId2BqXfeUC0f9j2ddihCK9jLu7xGq
	 +MXpLXR2///xWwhprQaRRp0a404TtsZEfwdG7vh0XIwdHah3cLxH33DnJ4iyp3wHOk
	 mhDLNY0RUrmRA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 4CD5F40AE5;
	Fri,  1 Aug 2025 00:13:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 03/12] docs: kdoc: backslashectomy in kdoc_parser
Date: Thu, 31 Jul 2025 18:13:17 -0600
Message-ID: <20250801001326.924276-4-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801001326.924276-1-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
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

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 9948ede739a5..e1efa65a3480 100644
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
@@ -331,7 +331,7 @@ class KernelDoc:
 
         self.entry.anon_struct_union = False
 
-        param = KernRe(r'[\[\)].*').sub('', param, count=1)
+        param = KernRe(r'[)[].*').sub('', param, count=1)
 
         if dtype == "" and param.endswith("..."):
             if KernRe(r'\w\.\.\.$').search(param):
@@ -405,7 +405,7 @@ class KernelDoc:
 
         for arg in args.split(splitter):
             # Strip comments
-            arg = KernRe(r'\/\*.*\*\/').sub('', arg)
+            arg = KernRe(r'/\*.*\*/').sub('', arg)
 
             # Ignore argument attributes
             arg = KernRe(r'\sPOS0?\s').sub(' ', arg)
@@ -428,14 +428,14 @@ class KernelDoc:
 
                 arg = arg.replace('#', ',')
 
-                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)')
+                r = KernRe(r'[^(]+\(\*?\s*([\w[\].]*)\s*\)')
                 if r.match(arg):
                     param = r.group(1)
                 else:
                     self.emit_msg(ln, f"Invalid param: {arg}")
                     param = arg
 
-                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
+                dtype = KernRe(r'([^(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
                 self.push_parameter(ln, decl_type, param, dtype,
                                     arg, declaration_name)
 
@@ -443,14 +443,14 @@ class KernelDoc:
                 # Array-of-pointers
 
                 arg = arg.replace('#', ',')
-                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\]\.]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
+                r = KernRe(r'[^(]+\(\s*\*\s*([\w[\].]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
                 if r.match(arg):
                     param = r.group(1)
                 else:
                     self.emit_msg(ln, f"Invalid param: {arg}")
                     param = arg
 
-                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
+                dtype = KernRe(r'([^(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
 
                 self.push_parameter(ln, decl_type, param, dtype,
                                     arg, declaration_name)
@@ -637,8 +637,8 @@ class KernelDoc:
             # it is better to also move those to the NestedMatch logic,
             # to ensure that parenthesis will be properly matched.
 
-            (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
-            (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+            (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^)]+)\)', re.S), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+            (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^)]+)\)', re.S), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
             (KernRe(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
             (KernRe(r'DECLARE_HASHTABLE\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
             (KernRe(r'DECLARE_KFIFO\s*\(' + args_pattern + r',\s*' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
@@ -700,7 +700,7 @@ class KernelDoc:
                     s_id = s_id.strip()
 
                     newmember += f"{maintype} {s_id}; "
-                    s_id = KernRe(r'[:\[].*').sub('', s_id)
+                    s_id = KernRe(r'[:[].*').sub('', s_id)
                     s_id = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
 
                     for arg in content.split(';'):
@@ -709,7 +709,7 @@ class KernelDoc:
                         if not arg:
                             continue
 
-                        r = KernRe(r'^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).*)')
+                        r = KernRe(r'^([^(]+\(\*?\s*)([\w.]*)(\s*\).*)')
                         if r.match(arg):
                             # Pointer-to-function
                             dtype = r.group(1)
@@ -767,12 +767,12 @@ class KernelDoc:
         self.check_sections(ln, declaration_name, decl_type)
 
         # Adjust declaration for better display
-        declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
+        declaration = KernRe(r'([{;])').sub(r'\1\n', declaration)
         declaration = KernRe(r'\}\s+;').sub('};', declaration)
 
         # Better handle inlined enums
         while True:
-            r = KernRe(r'(enum\s+\{[^\}]+),([^\n])')
+            r = KernRe(r'(enum\s+\{[^}]+),([^\n])')
             if not r.search(declaration):
                 break
 
@@ -969,8 +969,8 @@ class KernelDoc:
         # - pci_match_device, __copy_to_user (long return type)
 
         name = r'[a-zA-Z0-9_~:]+'
-        prototype_end1 = r'[^\(]*'
-        prototype_end2 = r'[^\{]*'
+        prototype_end1 = r'[^(]*'
+        prototype_end2 = r'[^{]*'
         prototype_end = fr'\(({prototype_end1}|{prototype_end2})\)'
 
         # Besides compiling, Perl qr{[\w\s]+} works as a non-capturing group.
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
 
@@ -1476,14 +1476,14 @@ class KernelDoc:
         """Ancillary routine to process a function prototype"""
 
         # strip C99-style comments to end of line
-        line = KernRe(r"\/\/.*$", re.S).sub('', line)
+        line = KernRe(r"//.*$", re.S).sub('', line)
         #
         # Soak up the line's worth of prototype text, stopping at { or ; if present.
         #
         if KernRe(r'\s*#\s*define').match(line):
             self.entry.prototype = line
         elif not line.startswith('#'):   # skip other preprocessor stuff
-            r = KernRe(r'([^\{]*)')
+            r = KernRe(r'([^{]*)')
             if r.match(line):
                 self.entry.prototype += r.group(1) + " "
         #
-- 
2.50.1


