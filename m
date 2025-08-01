Return-Path: <linux-kernel+bounces-752758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B23B17A88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC5D188EA3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931B3433A6;
	Fri,  1 Aug 2025 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SOIZKUDw"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B021B95B;
	Fri,  1 Aug 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007227; cv=none; b=CPmA9QNni5PGNH+iMqmykV4WpYFPVebbrIDrOaGUGqgrJZMgbYg+Y3e+8QFBs1On+36FFLxNUehKOoJCs14LNJZ13lJ/ggd3u5iR79Udtyw4buCvYltL/XlYbu4Cnba6u4DMmIMmnisvyqA+L4vHHyO4QoXJHvJ2ca4jG4MzNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007227; c=relaxed/simple;
	bh=H6p72Ss8kbUZeWCCe4TABpW5lDHCvzbrOV6nIqxbz9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9mgSTKP0ch4/xDuoHpTa8ZmHVHE8pd6B5tmOhz6oHkjduR1oYWfVQbTlI7WIocAnHyi83iLJIZD9rtchuQGRRdEp9YqV3i4LNPiV5ZGLAbZa5jRimWzLBoCL0wa7mBKtchdUyz4dcGC/UcSrt/9ZQwIp7iy/8NmSmAycjKhp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SOIZKUDw; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6633940AF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007220; bh=hNNZNp01RtrW+DLUWFXNUyvzDohZ34N8ED3quRO1A40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOIZKUDwJkRlXyZOvCmn6ppvAoTPQoRA4h4LPJxpM356DthOa5E+Jira8r46rM4tC
	 iXam7jf6CLbzleWSPVvK0bJC2VjV6uHKJ+GV5XoTeC38dtGKY3o6oQoDA9ymjHbQ3x
	 aJkaXjFS6Uz+bznh8rfdoIMV8cOnhe0w7F9L+gvrwJUnLtXxAN9da/Z6xkyHL6eX1q
	 iifemJXnlAHCLWc6HolvLZ1G8kTb2/f+z/+ddic6sZGTupLeDaz1E2eHuUP+CtLEut
	 RXG/C1zR/QuSk25McXZ81Wym1n+LVwLm1LGYV0JsxhgHuVbC3JpLIt759YGbOGaEcg
	 5x/twsIQYMjsA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 6633940AF1;
	Fri,  1 Aug 2025 00:13:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 10/12] docs: kdoc: further rewrite_struct_members() cleanup
Date: Thu, 31 Jul 2025 18:13:24 -0600
Message-ID: <20250801001326.924276-11-corbet@lwn.net>
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

Get rid of some single-use variables and redundant checks, and generally
tighten up the code; no logical change.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 89 ++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 20e0a2abe13b..2b7d7e646367 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -673,73 +673,68 @@ class KernelDoc:
         while tuples:
             for t in tuples:
                 newmember = ""
-                maintype = t[0]
-                s_ids = t[5]
-                content = t[3]
-
-                oldmember = "".join(t)
-
-                for s_id in s_ids.split(','):
+                oldmember = "".join(t) # Reconstruct the original formatting
+                #
+                # Pass through each field name, normalizing the form and formatting.
+                #
+                for s_id in t[5].split(','):
                     s_id = s_id.strip()
 
-                    newmember += f"{maintype} {s_id}; "
+                    newmember += f"{t[0]} {s_id}; "
+                    #
+                    # Remove bitfield/array/pointer info, getting the bare name.
+                    #
                     s_id = KernRe(r'[:[].*').sub('', s_id)
                     s_id = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
-
-                    for arg in content.split(';'):
+                    #
+                    # Pass through the members of this inner structure/union.
+                    #
+                    for arg in t[3].split(';'):
                         arg = arg.strip()
-
-                        if not arg:
-                            continue
-
+                        #
+                        # Look for (type)(*name)(args) - pointer to function
+                        #
                         r = KernRe(r'^([^(]+\(\*?\s*)([\w.]*)(\s*\).*)')
                         if r.match(arg):
                             # Pointer-to-function
-                            dtype = r.group(1)
-                            name = r.group(2)
-                            extra = r.group(3)
-
-                            if not name:
-                                continue
-
                             if not s_id:
                                 # Anonymous struct/union
-                                newmember += f"{dtype}{name}{extra}; "
+                                newmember += f"{r.group(1)}{r.group(2)}{r.group(3)}; "
                             else:
-                                newmember += f"{dtype}{s_id}.{name}{extra}; "
-
+                                newmember += f"{r.group(1)}{s_id}.{r.group(2)}{r.group(3)}; "
+                        #
+                        # Otherwise a non-function member.
+                        #
                         else:
-                            # Handle bitmaps
+                            #
+                            # Remove bitmap and array portions and spaces around commas
+                            #
                             arg = KernRe(r':\s*\d+\s*').sub('', arg)
-
-                            # Handle arrays
                             arg = KernRe(r'\[.*\]').sub('', arg)
-
-                            # Handle multiple IDs
                             arg = KernRe(r'\s*,\s*').sub(',', arg)
-
+                            #
+                            # Look for a normal decl - "type name[,name...]"
+                            #
                             r = KernRe(r'(.*)\s+([\S+,]+)')
-
                             if r.search(arg):
-                                dtype = r.group(1)
-                                names = r.group(2)
+                                for name in r.group(2).split(','):
+                                    name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name)
+                                    if not s_id:
+                                        # Anonymous struct/union
+                                        newmember += f"{r.group(1)} {name}; "
+                                    else:
+                                        newmember += f"{r.group(1)} {s_id}.{name}; "
                             else:
                                 newmember += f"{arg}; "
-                                continue
-
-                            for name in names.split(','):
-                                name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name).strip()
-
-                                if not name:
-                                    continue
-
-                                if not s_id:
-                                    # Anonymous struct/union
-                                    newmember += f"{dtype} {name}; "
-                                else:
-                                    newmember += f"{dtype} {s_id}.{name}; "
-
+                #
+                # At the end of the s_id loop, replace the original declaration with
+                # the munged version.
+                #
                 members = members.replace(oldmember, newmember)
+            #
+            # End of the tuple loop - search again and see if there are outer members
+            # that now turn up.
+            #
             tuples = struct_members.findall(members)
         return members
 
-- 
2.50.1


