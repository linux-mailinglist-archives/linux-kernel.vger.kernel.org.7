Return-Path: <linux-kernel+bounces-808995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E083FB50742
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8C474E2285
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83E35FC29;
	Tue,  9 Sep 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HRg+rZIF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A0352FD0;
	Tue,  9 Sep 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450649; cv=none; b=mR7GdFR+UX26stM5GG0aAVgqAG16t++A0aSrKiwsa8WUOop6XPJEtaMgkFPU/EzFCGrc6CBr/WNivGGl4Z8b+ZriDGPHEzpEZJSmDia/AuvUnQTNs73ZW5FsxUdJW9nhaOeU1QCSWRJEqmx6+Mt3WghFXKnst056X4aFi45rpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450649; c=relaxed/simple;
	bh=rEctjVEMrcusVAKt6bJpmB6kpl+NhauZEayBdQUhQ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3RmKWJ/V99+8whqP+0ensokmfPFSEKMl5QFBABfZxSH2h6w9dFel6iUOCMFhdjX7i1B6CEWkUmAB3C4wQWkY+tmC16Nus8xoELM7+uuxFXYjWIen6EqOxgiVUiudXU9FDfvi6lY1280xpPa/+xKAs2VDVXcPUCh6Tl4Kg5WWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HRg+rZIF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 60C1740B0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450647; bh=BGqHXiew3PPntdhvPFvwS+m9Yv4GGGGtHEvQoh2kNvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRg+rZIF2jxUUXheNxM5uk8UwPlucCyR6tR5rMvVi+0mkpr+mbLWbpPjuL1doRYpA
	 No+4BuFyCv+jn2K+LhAqvj66B77TZZEOfG45r8uFRMOIMFRR2savf5iIclr6hLSwe0
	 LZu1R1lGkV7Ri33RQlwwrSfQPqmAiA70/QjdQE9Dp94Th3WMNzUduE0RIGGBod0pxf
	 P4b6X20aCto0HzAxR+feP8icGiKek2y6jekyXHdsg0ofc1FBUwIk44s6Emepj7Zvd4
	 UfZbm611DEhIloaslNJ8U/+waCr8+OriUOlMuN/ZKxuUmaN08FmRtb9WEBcajz4SQL
	 QTU7agCAeB0SQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 60C1740B0B;
	Tue,  9 Sep 2025 20:44:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 03/13] docs: kdoc: remove a single-use variable
Date: Tue,  9 Sep 2025 14:43:39 -0600
Message-ID: <20250909204349.123680-4-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909204349.123680-1-corbet@lwn.net>
References: <20250909204349.123680-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct_attribute is only used once, so just put its value there directly
and drop the name.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 2118c20b3056..b25c8d80b965 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -76,13 +76,11 @@ doc_begin_func = KernRe(str(doc_com) +			# initial " * '
 # Here begins a long set of transformations to turn structure member prefixes
 # and macro invocations into something we can parse and generate kdoc for.
 #
-struct_attribute = KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
-                          flags=re.I | re.S, cache=False)
 struct_args_pattern = r'([^,)]+)'
 
 struct_prefixes = [
     # Strip attributes
-    (struct_attribute, ' '),
+    (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
     (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
     (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
     (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-- 
2.51.0


