Return-Path: <linux-kernel+bounces-726637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373D0B00FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F1A4A8913
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789E4307AFC;
	Thu, 10 Jul 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lE+5/rsi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB762D1F6B;
	Thu, 10 Jul 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190317; cv=none; b=OcWS7lJknzrV/JoXHWpIMXLNbEve+qnvvzZWxNjO40JXh3/aN8t7LS5v/3GPn9QGPNL1iURKQx7j84vHGVaCskZq1CsJFPQwX1z34uHbJZBHsah80Kg7DpaWiatVvV+OKZyf6QYwbHxwbW8Nil1ZJSLc/xrnSLhuFxSOmRkae8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190317; c=relaxed/simple;
	bh=P6yhrqkUMPctdFr2ViV3gZT6hN06lIi0XE/BpYCeQE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSXkPW+RBoyOXAmvmmfsDXLIk/YLUdiGN7RlrhP2tnQUow6KLxCa6pO3wrYrKVOQ/n8CkWva+Vbgp77+Bi4v6DAjXgVO0Z1zSyLpN4TFO7PAyQ2JAJaaIbch0oG1I3CB9E0OWcczzvBotNR9dxESeAHQtT97MLkKMqmTjHXybY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lE+5/rsi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 07D94406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190315; bh=AqFbr2+PxoELXgCLPo6n2CUdGey5ExLjhnXgIypFlxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lE+5/rsiSlpLqVlyd0ZzDwBobPtZxxZQ9SDR6jMkE5v7ugfO+9B/ia98dRLQ6URrA
	 tsoEEaRm6m85tT2A/4fYS6bUVGHdL7toUoCB9S5f1A6Dj8ef3kk0Si1CpAquQVTEa+
	 mK4bt1fWedqjoUwiD0bJemn0bzAfGWNqrRn0JD/6RnX/ebVqlHFM9JawjmVffUaOja
	 OYU0HS8GmemxImReqBYWh3Hk5veCRp+yXtZ5giC7YGOznBtCc1ODobSUSrIPmzsE86
	 yqo2PWUWNWuUZqtTr7mXfnU+GFYxv+fTBa8yoqyVyTenCNOPeT43fve/UT7QgreLxc
	 IbDCVlhXF6p9Q==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 07D94406FA;
	Thu, 10 Jul 2025 23:31:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 05/12] docs: kdoc: remove the "struct_actual" machinery
Date: Thu, 10 Jul 2025 17:31:35 -0600
Message-ID: <20250710233142.246524-6-corbet@lwn.net>
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

The code goes out of its way to create a special list of parameters in
entry.struct_actual that is just like entry.parameterlist, but with extra
junk.  The only use of that information, in check_sections(), promptly
strips all the extra junk back out.  Drop all that extra work and just use
parameterlist.

No output changes.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 608f3a1045dc..b28f056365cb 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -116,7 +116,6 @@ class KernelEntry:
 
         self._contents = []
         self.sectcheck = ""
-        self.struct_actual = ""
         self.prototype = ""
 
         self.warnings = []
@@ -366,15 +365,6 @@ class KernelDoc:
         org_arg = KernRe(r'\s\s+').sub(' ', org_arg)
         self.entry.parametertypes[param] = org_arg
 
-    def save_struct_actual(self, actual):
-        """
-        Strip all spaces from the actual param so that it looks like
-        one string item.
-        """
-
-        actual = KernRe(r'\s*').sub("", actual, count=1)
-
-        self.entry.struct_actual += actual + " "
 
     def create_parameter_list(self, ln, decl_type, args,
                               splitter, declaration_name):
@@ -420,7 +410,6 @@ class KernelDoc:
                     param = arg
 
                 dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
-                self.save_struct_actual(param)
                 self.push_parameter(ln, decl_type, param, dtype,
                                     arg, declaration_name)
 
@@ -437,7 +426,6 @@ class KernelDoc:
 
                 dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
 
-                self.save_struct_actual(param)
                 self.push_parameter(ln, decl_type, param, dtype,
                                     arg, declaration_name)
 
@@ -470,7 +458,6 @@ class KernelDoc:
 
                         param = r.group(1)
 
-                        self.save_struct_actual(r.group(2))
                         self.push_parameter(ln, decl_type, r.group(2),
                                             f"{dtype} {r.group(1)}",
                                             arg, declaration_name)
@@ -482,12 +469,10 @@ class KernelDoc:
                             continue
 
                         if dtype != "":  # Skip unnamed bit-fields
-                            self.save_struct_actual(r.group(1))
                             self.push_parameter(ln, decl_type, r.group(1),
                                                 f"{dtype}:{r.group(2)}",
                                                 arg, declaration_name)
                     else:
-                        self.save_struct_actual(param)
                         self.push_parameter(ln, decl_type, param, dtype,
                                             arg, declaration_name)
 
@@ -499,24 +484,11 @@ class KernelDoc:
 
         sects = sectcheck.split()
         prms = prmscheck.split()
-        err = False
 
         for sx in range(len(sects)):                  # pylint: disable=C0200
             err = True
             for px in range(len(prms)):               # pylint: disable=C0200
-                prm_clean = prms[px]
-                prm_clean = KernRe(r'\[.*\]').sub('', prm_clean)
-                prm_clean = attribute.sub('', prm_clean)
-
-                # ignore array size in a parameter string;
-                # however, the original param string may contain
-                # spaces, e.g.:  addr[6 + 2]
-                # and this appears in @prms as "addr[6" since the
-                # parameter list is split at spaces;
-                # hence just ignore "[..." for the sections check;
-                prm_clean = KernRe(r'\[.*').sub('', prm_clean)
-
-                if prm_clean == sects[sx]:
+                if prms[px] == sects[sx]:
                     err = False
                     break
 
@@ -782,7 +754,7 @@ class KernelDoc:
         self.create_parameter_list(ln, decl_type, members, ';',
                                    declaration_name)
         self.check_sections(ln, declaration_name, decl_type,
-                            self.entry.sectcheck, self.entry.struct_actual)
+                            self.entry.sectcheck, ' '.join(self.entry.parameterlist))
 
         # Adjust declaration for better display
         declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
-- 
2.49.0


