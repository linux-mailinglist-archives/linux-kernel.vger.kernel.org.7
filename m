Return-Path: <linux-kernel+bounces-752753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F6B17A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1BF5A3375
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C4C49659;
	Fri,  1 Aug 2025 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Aj0oz6j4"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD06ADD;
	Fri,  1 Aug 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007225; cv=none; b=ebnFKjndCLDsXutwGuKsqCoytrvjpVKJPzHaKaVpW3v7M65C62jgmH6doTetQohe8QZXYD4Jy32mMvwUuHeHJbKDxzxyHwTU2T57HnoG9fy8mHiOI9qTx7GcMJkIOj68UTw2MzPDusgP/XEPq+XDYjP0c3DMFoc797SCwjfWbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007225; c=relaxed/simple;
	bh=AobM2Kpc01QvA+kOgc8gyZRMbf6boLHS4knPy8pT+ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQ8vkkWQ+qZwXqLo1ceGO0nT2pZArkEe0SrkoTP3uDUyjWnjWNBqg44fy39KygNOjVDP8dP5yPRmqQFZquO9pPODzKOUiPAUswRQkqgK73DVzSwEFT7PnjWx1LHA8kpRPq4aig8s9nLwqS4UQNsIZULguMGLcq96kHPMGUYU/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Aj0oz6j4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8EFA440AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007219; bh=7nfDzqe9mxKKh3BHeIroRqaSenA+9Y00nOCwi9jfqt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aj0oz6j4ej+8DbPm9xtjXKqoJ4QHVsFQCpSSydK+5pC06i5pQskNRJWMPZDlugS0O
	 GVZlli0lEn7mDzwrTgZxVKfP+rl4m/7O+UGth4ztaG41U3xTlb4+3qalsOYgVmo7+k
	 bw3k/NsR/EVXzDxEicWmEaWq4kMUM3TNwySppbf8zmXYNAaXHSDF4UNAV76k1T8OFY
	 q0yUFq2SfKFMjSRbNYkWEg6xNa8QXSqimhHD/V0RgmkhJTd5lEILIlU3RhrnjpmejC
	 MayPxi2EAb5H2XxusibvarfRPV1Pen2V/mnBehkl1MTY0JoQKEiifyHFkHgN0h+9Qu
	 su701h+uzjI0w==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 8EFA440AED;
	Fri,  1 Aug 2025 00:13:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 07/12] docs: kdoc: rework the rewrite_struct_members() main loop
Date: Thu, 31 Jul 2025 18:13:21 -0600
Message-ID: <20250801001326.924276-8-corbet@lwn.net>
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

Adopt a more Pythonic form for the main loop of this function, getting rid
of the "while True:" construction and making the actual loop invariant
explicit.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 5c4ad8febb9f..efc5888fcc74 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -663,11 +663,8 @@ class KernelDoc:
         # re limitation.
 
         struct_members = KernRe(r'(struct|union)([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
-        while True:
-            tuples = struct_members.findall(members)
-            if not tuples:
-                break
-
+        tuples = struct_members.findall(members)
+        while tuples:
             for t in tuples:
                 newmember = ""
                 maintype = t[0]
@@ -738,6 +735,7 @@ class KernelDoc:
                                     newmember += f"{dtype} {s_id}.{name}; "
 
                 members = members.replace(oldmember, newmember)
+            tuples = struct_members.findall(members)
         return members
 
     def dump_struct(self, ln, proto):
-- 
2.50.1


