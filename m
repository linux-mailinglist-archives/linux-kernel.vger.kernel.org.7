Return-Path: <linux-kernel+bounces-769214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65855B26B65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9E61CE32E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86EB2874FA;
	Thu, 14 Aug 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FhrkEXq6"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA923BF96;
	Thu, 14 Aug 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186050; cv=none; b=OogJPKS42Lx9ZL4QdG+HarDvm+tr/Fu585blDA0F+UJ+dhsRFGA7tNj5UdPfPFyvRc8VBOTLglfigaG9MKHHbpa3vXYhE+qTAeHIXlxQj+fqAgLiLKTvb4Qbb1IJSVns6IGMdmbo664KuLLg1IF9tH/XXJOjbdD51c2w3fIlC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186050; c=relaxed/simple;
	bh=QMP+A6RZgqavqc1dXbtilnnyb8HnkdEJ1fmcIb+VkV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc/Mh/cNuFimWnTT4Drs2yTab7p9eLBkKDRFtAUQUrUpY9UsU/8kM0jWfBD1ucTIfDMRW7klAfx6gKi1UGxPQ7MG8HX5/4JDW9V5CjrwLy+Nbqtovw/WNr1BSwJ1Vc2coXKvDEZ308GmrATOUJQpps3sMWtYFTqWEpg9aCsXD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FhrkEXq6; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 47C4B40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755186047; bh=MrbbreIikBSbVzvRnFELl6mnrF8Yja7sRNIT6v6ZGfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhrkEXq6FWkRr25ezR0I9p5Y0HDEQLDTH/8Gxa7HMFHOUH3p/aLieoEflTzD6Jjb5
	 tskOEgEvCsZr461Tig7kQT+Rb114oAk65XOgIToQdHtMEWvDwT0PBlgzc6aK7S/cFX
	 FrR1/w51l1brjEXqb/9cq/yZWKS+JQLOeswhM+CvDrGLTAqil4RjlSeFv9IYr3TEAI
	 ine5MHutiue/hlEtUDZy3MRSH1b+MGhYeB//aVVQ/jO/jx4p3fk2UKICdlwmv0ExZz
	 Wj68HPeJPhgRjFD+dLj03qDLTNmPO5SDhtXzXLLrQk39Nw9odElXAaVheuiOOY6Mrh
	 Mi1a+lw/4Q7+w==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 47C4B40AB4;
	Thu, 14 Aug 2025 15:40:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 4/7] docs: kdoc: add a couple more comments in create_parameter_list()
Date: Thu, 14 Aug 2025 09:40:32 -0600
Message-ID: <20250814154035.328769-5-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814154035.328769-1-corbet@lwn.net>
References: <20250814154035.328769-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make what the final code is doing a bit more clear to slow readers like me.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 07234ce04409..29881757bf1c 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -568,12 +568,18 @@ class KernelDoc:
 
                 bitfield_re = KernRe(r'(.*?):(\w+)')
                 for param in args:
+                    #
+                    # For pointers, shift the star(s) from the variable name to the
+                    # type declaration.
+                    #
                     r = KernRe(r'^(\*+)\s*(.*)')
                     if r.match(param):
                         self.push_parameter(ln, decl_type, r.group(2),
                                             f"{dtype} {r.group(1)}",
                                             arg, declaration_name)
-
+                    #
+                    # Perform a similar shift for bitfields.
+                    #
                     elif bitfield_re.search(param):
                         if dtype != "":  # Skip unnamed bit-fields
                             self.push_parameter(ln, decl_type, bitfield_re.group(1),
-- 
2.50.1


