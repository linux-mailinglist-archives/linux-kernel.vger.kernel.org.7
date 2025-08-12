Return-Path: <linux-kernel+bounces-765519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618ABB2396A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1461B6710D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB382302CC9;
	Tue, 12 Aug 2025 19:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kNgdjhMu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D82FF179;
	Tue, 12 Aug 2025 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028681; cv=none; b=LfCurcgshPT2uMabYjn+VfY1g9Oql2xtMOkbi23ERPRq7YJzH/pqrsQrN/C3VNz/SE0UVY7/wbsaEJ2VGu35g1UPGwpbVKW6x7rcikVyuMZH9JXw555XC4M8vAe7SLxDRdozbMgH9gq/atdhaBSOGqdquTTElIG37Iz4JhLrIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028681; c=relaxed/simple;
	bh=rjJmmU5S7TbIUqYY/JAO40jGyx07vxve6fsT45iwmjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwa9QInoa/7/1WxBV8QgKvs4o1qTM8jtQviAaUHL1jjSmtNEKeP+wis1TjgyE5RAV17lSssbnuXJ1uTLiXQQVg5nLhKdMCZyfWVZdTHhU0XrXclW5Vch0F0gCd11iFoR9o5P+laZ4teZML2s2p/23v4wWcquSyd3VkfzarwTJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kNgdjhMu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 267D640AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755028679; bh=J57bzfXmOD2R1gP/y/AesBfePH55ilhwvePByC8Qo94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNgdjhMuC+5IoejMTX1/jr4wwxBXkZYm6lDQfJqWB3hI2thoNbBSRc0etNjYmlMX2
	 x2KUuArH3y59ymvQmmqmyvf0W0YP9J9ftiLxOFNqQaFYXgk5n/yyibnEY0VOwW6Pai
	 BJfrr02cVuLTp/pfbzIepR5NRh26qhxIfk81EGP65JB2wGbW4mp2yOXpMh9OL77yRW
	 Lf8hafbT1Ty52/ev++N7cPV6OnzT2eNanQMqw1+BgZ9Jpo7sno6OFNjxC2RsYqSSJI
	 pKZjFTvs4MElqfFKi1vIx2DVnP1zpHwC0RicI+o5lermwfJeh0OHRCga6uCmTqQGpG
	 4ef1sdcEUKffw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 267D640AF4;
	Tue, 12 Aug 2025 19:57:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/7] docs: kdoc: add a couple more comments in create_parameter_list()
Date: Tue, 12 Aug 2025 13:57:45 -0600
Message-ID: <20250812195748.124402-5-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812195748.124402-1-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make what the final code is doing a bit more clear to slow readers like me.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 47f7ea01ed10..36c4035343dc 100644
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


