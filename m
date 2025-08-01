Return-Path: <linux-kernel+bounces-752757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37510B17A85
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E0626282
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9D018C031;
	Fri,  1 Aug 2025 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tYR9sZR6"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11721B7F4;
	Fri,  1 Aug 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007227; cv=none; b=SeU137ENivUzjgfkWTUdfnqO7SmcGjQPtDvOuPDQO5Xdvo9zTWDX2FrkujmlbKTyVJcHkelJqfPF26wc8+bFDqIZcZ8SCF3O1yBHza1X2RmCxskXeFa/MTyN52nIfeGeixVUAoO9jm3AcCq+dWyYLuQ6XYBWMtqJMf4Kt7ONwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007227; c=relaxed/simple;
	bh=frcYFnmG0494T3FY+1nGa2e/mEUxGzhuM4LmaELetMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBz7xrMTaHXufIKH+6xCd2FeVwQiPh08F8j/yndO4uCZeSazO9Ys663fyLJNDnX7kSqKKUi2lopYiNLEPYJVrx6z+hTpuagteRy30yHP2HxVYgTIcr+m2nIXH5dzxt1Lu33v3ZzikB35oa6bHHg8JAut1DOpqIzSfwikWFFI/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tYR9sZR6; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 77BFF40AF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007221; bh=7BavdRyyfUuS3E2LBEfR5bO38C3nR3zuf6VYXzSLSuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYR9sZR6Pi7qkJ+QUZB05aTSKAhnhFgwrguRwf4DH86aPEdPrKE8WSagTtEIQ7lRS
	 zIJ0JdBqr+1oYYKon0sV3sL7Z/oh079xy9XHE2DXspd1/RSKZE+doP75Z7fRoaMQwy
	 V0CKl43PFhMI7g/D02lwOVJ/KB38uJdpv1zLpDpA8Er/JboVNsB/w09L/xQgTnx/Hc
	 DhT1Fqk1me+bsAK3cAIrHx9GpA1wIolgwDuZAybXUTboVkcB7jzV8XFwxBOcl5yS2I
	 O+9oKIhqqgBMbtQ1Qg4YeVvWzIiN0XwQRwCF2DTFg4f6EFzfnH7xM77Lsp6lCtPeLJ
	 RtOF+x/eyy2sA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 77BFF40AF3;
	Fri,  1 Aug 2025 00:13:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 12/12] docs: kdoc: a few final dump_struct() touches
Date: Thu, 31 Jul 2025 18:13:26 -0600
Message-ID: <20250801001326.924276-13-corbet@lwn.net>
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

Add a couple more comments so that each phase of the process is
now clearly marked.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 131956d89f84..fa2041276f8c 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -801,14 +801,15 @@ class KernelDoc:
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


