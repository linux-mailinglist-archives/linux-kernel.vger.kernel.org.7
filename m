Return-Path: <linux-kernel+bounces-752750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108D1B17A77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7373C1C2866A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224920330;
	Fri,  1 Aug 2025 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HBi64n7u"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E113FFD;
	Fri,  1 Aug 2025 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007224; cv=none; b=fnF4tIiOd1G0n8DweZI050fBc6rJD08MIrREPozigqdbWqblnJjPjzqWI3wscUKs4fVcT17ppZ6atHsXji00zwIt/9nqwD17UaH0XQFDncO/6ciK086zklCLz9GVMCgLyvoBMzCd9/aFAYjEKh/7yKFAzE12uyrSc/CoXnQITs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007224; c=relaxed/simple;
	bh=blEVpsi6veADUr0KfDdwggA32HbZDYZqLsP2P50MwYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R61MztTMSLUVOMJC8VVCwQyY4U9dXZaE0BeCiwy2yrMvAABdD/HCiW0urYbmQy6EvyRPg+C76VUhPDFnSIaCP0KmCxziM1wGEwWeNHYo+ppd1a33/zIYPKt5oWLvY/j7XUA398/u1wWyIE0dJJi0Jgt8zqKoUUzz0GuXTkJQMDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HBi64n7u; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B640A40AE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007216; bh=IuPz8fhYbCvGgUOKEXCuX26f3cOrt2ePp/b91/+1Mmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBi64n7uwabgrYR1nhWv/mYdLLM04xkz3N9JgdD1tChXzbMn5IX7LE4rjoYXVdU/9
	 a7BcqpDHsc2E8UyT12ry3EtenqvCjERhU29Pi78OQ2ogeFuUjaRtmtsvi5nR9G8wSP
	 rsK/ilGcNoU/YfH4Q36stZ5jT4W90wPavkvbKwGPIA83huOMnRdagANd1pC7QZuOVx
	 /ieErMM8LwtD+uu91/frpau0VgDFC1U3JT2FJ7k2YF0nKUHYRzRhbcm9pNMZECjb1E
	 p3kmc13j0kuyXhMmvsFe1vIVmZS6C8TVrl55a+BVbq1Ez4cz0EdYntgs7U4PiSMKeb
	 PWLD9D5v3w1yg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id B640A40AE4;
	Fri,  1 Aug 2025 00:13:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 02/12] docs: kdoc: Move a regex line in dump_struct()
Date: Thu, 31 Jul 2025 18:13:16 -0600
Message-ID: <20250801001326.924276-3-corbet@lwn.net>
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

The complex struct_members regex was defined far from its use; bring the
two together.  Remove some extraneous backslashes while making the move.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 93fcd8807aa8..9948ede739a5 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -551,7 +551,6 @@ class KernelDoc:
         ]
 
         definition_body = r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers) + ")?"
-        struct_members = KernRe(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\}\;]*)(\;)')
 
         # Extract struct/union definition
         members = None
@@ -683,6 +682,7 @@ class KernelDoc:
         # So, we need to have an extra loop on Python to override such
         # re limitation.
 
+        struct_members = KernRe(type_pattern + r'([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
         while True:
             tuples = struct_members.findall(members)
             if not tuples:
-- 
2.50.1


