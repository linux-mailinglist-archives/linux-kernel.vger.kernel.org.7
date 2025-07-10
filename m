Return-Path: <linux-kernel+bounces-726642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A22B00FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA4A1CA8613
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11530AAA3;
	Thu, 10 Jul 2025 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="G+AiduJS"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC5307AF3;
	Thu, 10 Jul 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190320; cv=none; b=G/Lppm7k61mRpkjrFgptBB/WYuDEGNjhxR26WGbiABsq8lLmPeUocH6VFDbYcrnygFEOdUuwxgdAynU313eowi+nqBR/QnuDklfGaywCTs1kGOUMp9Oh2xhuCknp3UBeR/v/ve+/ID5mU/gy3uSMhQPT594/KljeDWJm3OpgKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190320; c=relaxed/simple;
	bh=4nh3cywrUze4Xrhhvl/aFhvIptVuid/szc3DGTHSGoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjLp4d+xXK7iZpMwNqFvS7NR/sZQqz6JND4c9yim6kvVJ1kHyoguZKaFS67Adv+62x0LYlGhAcTKuwlND1QxK1XSX9jmjw6jlAmwY8RDxBq6P2xO5iJ9qpQ0YwUMy5aYGJgSJP0UX04rC0F3nIFYax3+H/SymNAmvbzd6Ds2Gzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=G+AiduJS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AAE23406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190318; bh=S11g0dvo4Gp8wnfQWL7KxGwp6Pr2KHF/P4OTfx/g+II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+AiduJS6AtUNPDom5xHtTNrQg/0u/ALUtTsW4uJSO+WpikX85DA8pw0FlDVWOQe8
	 tls++VTlNPKBa2KxA/Z7HZtQRLmY9q4AoFgGoW/3k5wvtdxSsum46ORdoqic/Mg9Mp
	 HulINH1QfhxuSR02vu+xEpY4DZs+PdOx3HgwaCUkVzXJWri8j0rDkM2UDGZ6k9tCPl
	 8Di2gfDovWnUWAxNf0uJKjyGvOkR+KV3EmwvOsFuetO7vMiHjJKYW9JPhE38cPl38j
	 xmMC6Ip6DclkvOH12UkL68IHMjd1qzReoEX72NhEz9/qnavKL8+neT2vy3aeXNqgL3
	 378QLwrEbpaKQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id AAE23406FA;
	Thu, 10 Jul 2025 23:31:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 10/12] docs: kdoc: directly access the always-there KdocItem fields
Date: Thu, 10 Jul 2025 17:31:40 -0600
Message-ID: <20250710233142.246524-11-corbet@lwn.net>
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

They are part of the interface, so use them directly.  This allows the
removal of the transitional __dict__ hack in KdocItem.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_item.py   |  5 +----
 scripts/lib/kdoc/kdoc_output.py | 16 +++++++---------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
index beac5c70a881..fe52d87fda88 100644
--- a/scripts/lib/kdoc/kdoc_item.py
+++ b/scripts/lib/kdoc/kdoc_item.py
@@ -22,10 +22,7 @@ class KdocItem:
         self.other_stuff = other_stuff
 
     def get(self, key, default = None):
-        ret = self.other_stuff.get(key, default)
-        if ret == default:
-            return self.__dict__.get(key, default)
-        return ret
+        return self.other_stuff.get(key, default)
 
     def __getitem__(self, key):
         return self.get(key)
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 8a31b637ffd2..ea8914537ba0 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -124,9 +124,7 @@ class OutputFormat:
         Output warnings for identifiers that will be displayed.
         """
 
-        warnings = args.get('warnings', [])
-
-        for log_msg in warnings:
+        for log_msg in args.warnings:
             self.config.warning(log_msg)
 
     def check_doc(self, name, args):
@@ -184,7 +182,7 @@ class OutputFormat:
 
         self.data = ""
 
-        dtype = args.get('type', "")
+        dtype = args.type
 
         if dtype == "doc":
             self.out_doc(fname, name, args)
@@ -373,7 +371,7 @@ class RestFormat(OutputFormat):
                 signature = args['functiontype'] + " "
             signature += name + " ("
 
-        ln = args.get('declaration_start_line', 0)
+        ln = args.declaration_start_line
         count = 0
         for parameter in args.parameterlist:
             if count != 0:
@@ -445,7 +443,7 @@ class RestFormat(OutputFormat):
     def out_enum(self, fname, name, args):
 
         oldprefix = self.lineprefix
-        ln = args.get('declaration_start_line', 0)
+        ln = args.declaration_start_line
 
         self.data += f"\n\n.. c:enum:: {name}\n\n"
 
@@ -474,7 +472,7 @@ class RestFormat(OutputFormat):
     def out_typedef(self, fname, name, args):
 
         oldprefix = self.lineprefix
-        ln = args.get('declaration_start_line', 0)
+        ln = args.declaration_start_line
 
         self.data += f"\n\n.. c:type:: {name}\n\n"
 
@@ -492,8 +490,8 @@ class RestFormat(OutputFormat):
 
         purpose = args.get('purpose', "")
         declaration = args.get('definition', "")
-        dtype = args.get('type', "struct")
-        ln = args.get('declaration_start_line', 0)
+        dtype = args.type
+        ln = args.declaration_start_line
 
         self.data += f"\n\n.. c:{dtype}:: {name}\n\n"
 
-- 
2.49.0


