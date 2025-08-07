Return-Path: <linux-kernel+bounces-759540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A06B1DEC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFEA584CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4C275841;
	Thu,  7 Aug 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rSraMNF5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758B2741B0;
	Thu,  7 Aug 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601421; cv=none; b=Yu1hv4CaQxW8m/FwFtTi7iGXKdJ7iD2ZiiXz+3E5PjPlMv7mQ4vi+cPMHGJ7LE3dPhOy8U8fFM7y8yNJh3VJ34cCBplOFJy8DwMJtyRigEzoIeFJOjsPOouc35jKMzQ5RB5fz16NxqWCriJa9SSIBEaYqsT0jQavqVV/mfMl5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601421; c=relaxed/simple;
	bh=Atau+QLjGuOfyYM2kTyMv5X5+6yarKGZzvGs4vVXSdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSTE1PBtunpDXH7ys7ITIvioUPiGqGTDRYCU/z7DkHssqzXU5j5wd4hsozeBqsx047Ve2uzY+xKZ+BbUilPeEuxC2f0I6xOHuWFTy+BpKv7pukDtk6wWpYSDCjxhFkTzPuJMGjMtlDVmKdEPF7V/BNVNDp/FhIdSszWX4kOf61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rSraMNF5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9D01C40AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601416; bh=49DuByfCp+pk3uQ5bmHdgqLWb3lRGAoir3iVBpGDYmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSraMNF5JnEFatxIyNggjj2udIvNm+FORQnqnGy6Roqx09a4MIb/T85LnnZsAKZAi
	 KURvV6jMX8bfkQCpif+6n+21UoHn2LldjY6fhDBERi44+dFdvuFBcJWJ8X84BB4Bxe
	 0szvek3MfZXxMvZ+zwx5BxXa0nwe9uR6yA1pv55XYclmTI39LdbIPLmQM76sYNQL7y
	 BmmuMFpG9PWTH3q252pXrcbqVuXuZD1EN0HbqyeT8b5QGMqKRaT8kC8DEPae9/4cq1
	 GRjGk1SUokJrcEfy6UX19yeW2NHVs09W2i877hY3AY3ESuetAvpTAL/pOtn+ZerlRQ
	 HnC8HcfWJM/qQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 9D01C40AF4;
	Thu,  7 Aug 2025 21:16:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 12/12] docs: kdoc: a few final dump_struct() touches
Date: Thu,  7 Aug 2025 15:16:39 -0600
Message-ID: <20250807211639.47286-13-corbet@lwn.net>
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

Add a couple more comments so that each phase of the process is
now clearly marked.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 878fbfab4ac7..9b21fb86709a 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -802,14 +802,15 @@ class KernelDoc:
         nested = NestedMatch()
         for search, sub in struct_nested_prefixes:
             members = nested.sub(search, sub, members)
-
-        # Keeps the original declaration as-is
+        #
+        # Deal with embedded struct and union members, and drop enums entirely.
+        #
         declaration = members
         members = self.rewrite_struct_members(members)
-
-        # Ignore other nested elements, like enums
         members = re.sub(r'(\{[^\{\}]*\})', '', members)
-
+        #
+        # Output the result and we are done.
+        #
         self.create_parameter_list(ln, decl_type, members, ';',
                                    declaration_name)
         self.check_sections(ln, declaration_name, decl_type)
-- 
2.50.1


