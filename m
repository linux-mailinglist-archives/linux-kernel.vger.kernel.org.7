Return-Path: <linux-kernel+bounces-759535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376FEB1DEC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAF81AA288F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B32749F4;
	Thu,  7 Aug 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FziolT9X"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2A25C827;
	Thu,  7 Aug 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601419; cv=none; b=EJZci3OQJAjse9sPxc5xm20YJrHar0CqX+PkZSEHBigLr9ZcAt8LphpXSxDmTpBnn10blzwz9a/e6FLimz5dUd5Km3De1OGe3cHH5g38dhkc7ntivcKPW129H4Zr0pIIxlgdQfwvs1oc94Jc5+YDgYYLm/xbTTxa37BaKVdGDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601419; c=relaxed/simple;
	bh=yinGlBpie4HuwDcmTLO434pKDF6hqOOdlGj9uA+y5Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbbEUJIskmvSwNjbVM7Ny+9AJUhsMzrtpZwZEiMxUF5EmpJIsB8b6H9sFtwe4bFikZqkLapVZsQUgs9AMWIYLdmkUf/Yel/zdy5gsJr3Yi9Y/oG9CwwXug8AporjJQY0NFa0pM0XI3iqAlkFDUozSMU61ySNg9OndlAN9T3bt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FziolT9X; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E44FE40AEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601413; bh=MmGVKremYkRJqBzecc3T13fDBxhjQG5SuE3oGA2LXdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FziolT9Xapiqa/Lk1h4W0BWrcclG2WwUFAnsIhyq5oKt1uk0xT4IlsrbF7aDPu1Hw
	 24juoFZJs109NqqxftBf6ncmA+F3Np9GBWDNwE7O+qqXwr7b7rSs0na+wH4ftr92rv
	 pjc/dS2aYhYzhDEe9/xmg9nGoibFsgikBT83K1o9GO2aeEMjjsaB+EiW/UnHbFkZjL
	 cGXHSpm2jkuGQJttBr/6NSnQCzr1MrmiCZ1p3woW5JtWOwtHJ7gX2LbBKNd7eRwzh9
	 UEQHj55g3NUBqXHOcu1G7IncgCOeCPeor+2choBWvOs/IcrPcZnQEaWEF6sXOUNGVo
	 FtvqPfGwARq2Q==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id E44FE40AEF;
	Thu,  7 Aug 2025 21:16:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 07/12] docs: kdoc: rework the rewrite_struct_members() main loop
Date: Thu,  7 Aug 2025 15:16:34 -0600
Message-ID: <20250807211639.47286-8-corbet@lwn.net>
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

Adopt a more Pythonic form for the main loop of this function, getting rid
of the "while True:" construction and making the actual loop invariant
explicit.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index fbd7f6ce3360..e11f3d6e9469 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -663,11 +663,8 @@ class KernelDoc:
         # re limitation.
 
         struct_members = KernRe(r'(struct|union)([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\};]*)(;)')
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


