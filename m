Return-Path: <linux-kernel+bounces-769211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D692B26B68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24F3605A63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5E22566D2;
	Thu, 14 Aug 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="F9Qxj7Kn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355223313F;
	Thu, 14 Aug 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186048; cv=none; b=rvC+V77G8DV2lnwQSmnCm8iqdRC3LGJGbadzqTIVDQ1bQzSOW4rg5TQvmqjQ3bimJ4KVJDS9YLkTgAPBVyYg9BcOYPS8ZxF43JoSAUYYbUri883s6Y5DZqTfJaMRitM1coixhDOh4/PHQQKkyOW5ajNcEGnndePEJTzQDBegPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186048; c=relaxed/simple;
	bh=taHNU4VFd7VdXTyQOFopdCJIV9s+50hr+H2CAnWWCOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdPt/QRcDvftFd/6RqZPy3iKW/Fh6f3E4u4Q4Mnoq9Z0jK+kMH8208ysnd07Uzxdg9K4pnMEZJeyZlj8oHH2qTyJcwiAwcsrXHN4GbhDcEPaiygez7otJhu+hJb2d06QoLxoBZyhoEo42pqIk8xzNl4HS8OsXV9HF/HSkL4h/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=F9Qxj7Kn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3045A40AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755186046; bh=6d6Q/SQ4sl5V8NWDEJS4x1dcU36x0P3VKVqk7hJ38eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9Qxj7Kn3SolD2gBj4eLFUrNgUvfRQJ/NCAJmrltj0Z8KI02d+PxFsXXbxms5DcKF
	 p7tkois6KlhYby3Dxipy4em6Q84lHHDjnH8aXBbjsXrqBW7WKrX11lDe/4+fg24V2T
	 B1DdOyb7Qa94QWC9UL14Kdb5oYZcBpi3DErMiEyMAu5cJevWHgYwvd/kj1/RboqWUN
	 MakvPHw3aKCrLnUPdJC8i76FM13gvSScfYuZU8Kb8dO/AhGoxDE/5/GmE/YAZPBnwz
	 PU6uoz/qk4aK3+PSFr41S+5QuU14qOPVu0u/zb6tUUvgbcxDv2UrGKu4ZweRriwOSt
	 U4ZU5c1R8TM9w==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 3045A40AF5;
	Thu, 14 Aug 2025 15:40:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 2/7] docs: kdoc: tidy up space removal in create_parameter_list()
Date: Thu, 14 Aug 2025 09:40:30 -0600
Message-ID: <20250814154035.328769-3-corbet@lwn.net>
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

Remove a redundant test and add a comment describing what the space removal
is doing.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 96e3fe4ec431..53051ce831ba 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -545,12 +545,14 @@ class KernelDoc:
                                     arg, declaration_name)
 
             elif arg:
+                #
+                # Clean up extraneous spaces and split the string at commas; the first
+                # element of the resulting list will also include the type information.
+                #
                 arg = KernRe(r'\s*:\s*').sub(":", arg)
                 arg = KernRe(r'\s*\[').sub('[', arg)
-
                 args = KernRe(r'\s*,\s*').split(arg)
-                if args[0] and '*' in args[0]:
-                    args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
+                args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
 
                 first_arg = []
                 r = KernRe(r'^(.*\s+)(.*?\[.*\].*)$')
-- 
2.50.1


