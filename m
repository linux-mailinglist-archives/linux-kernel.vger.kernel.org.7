Return-Path: <linux-kernel+bounces-811120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6275B524A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CCFA82433
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA226E708;
	Wed, 10 Sep 2025 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l0fvFCVV"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926A25F798
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546751; cv=none; b=u3Zti895pNMDwItdlYC95H0Gchu6SZwT2TcLU6cGK0yxQSOdRsSiRX7957ov1vQBj4Zz80Fsjhu2PNsSQcy2PQZcwvLp4MDHiQTVX+pipaj6mbDTr41U7fC4bK2YawJhfuzsybsba4HuqOwmUKgUzLSTyt+ljZSFQMQyhE4Lymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546751; c=relaxed/simple;
	bh=9V0bE29KEboEUZunP/P29x8kJMn/gBb1WEqSyjpfTwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dt8wMmeZtPGTjL3foRHTCYhZuFqOvulBDSXGyzSunh7H5S/33f9eqG1RtHtn6/rqkt+g5X4us44Bo5POnthIdCwT22OCvBw8Bq6dl2oL5XCoWne3KGPJOZmKenHkWcP1q4OBSpYGmjwHhB3do+/+WtCIbvXMm4wCgnMNCujY5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l0fvFCVV; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757546746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4PArehQ+yUqtb9cJ2WUekoqWKkUmPU/daAE92zsO77c=;
	b=l0fvFCVV26RrqV2E7RNFMoMJjEjJvc1OxGz2rjVaxThrmiXyQPye1bCyz9R6XQDi/mp42p
	uO8i0TqHVzKuEK/LiuyukecUgdVPOe/dmmjAIePhxMbIpu1DYzvsJoOFMSR/0bNSZMFaGY
	gG6BQkHwGKC4/e0B9dYzLVS7WK9BLDQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lib/decompress: Use designated initializers for struct compress_format
Date: Thu, 11 Sep 2025 01:23:51 +0200
Message-ID: <20250910232350.1308206-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Switch 'compressed_formats[]' to the more modern and flexible designated
initializers. This improves readability and allows struct fields to be
reordered. Also use a more concise sentinel marker.

Remove the curly braces around the for loop while we're at it.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 lib/decompress.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index ab3fc90ffc64..7785471586c6 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -49,15 +49,15 @@ struct compress_format {
 };
 
 static const struct compress_format compressed_formats[] __initconst = {
-	{ {0x1f, 0x8b}, "gzip", gunzip },
-	{ {0x1f, 0x9e}, "gzip", gunzip },
-	{ {0x42, 0x5a}, "bzip2", bunzip2 },
-	{ {0x5d, 0x00}, "lzma", unlzma },
-	{ {0xfd, 0x37}, "xz", unxz },
-	{ {0x89, 0x4c}, "lzo", unlzo },
-	{ {0x02, 0x21}, "lz4", unlz4 },
-	{ {0x28, 0xb5}, "zstd", unzstd },
-	{ {0, 0}, NULL, NULL }
+	{ .magic = {0x1f, 0x8b}, .name = "gzip", .decompressor = gunzip },
+	{ .magic = {0x1f, 0x9e}, .name = "gzip", .decompressor = gunzip },
+	{ .magic = {0x42, 0x5a}, .name = "bzip2", .decompressor = bunzip2 },
+	{ .magic = {0x5d, 0x00}, .name = "lzma", .decompressor = unlzma },
+	{ .magic = {0xfd, 0x37}, .name = "xz", .decompressor = unxz },
+	{ .magic = {0x89, 0x4c}, .name = "lzo", .decompressor = unlzo },
+	{ .magic = {0x02, 0x21}, .name = "lz4", .decompressor = unlz4 },
+	{ .magic = {0x28, 0xb5}, .name = "zstd", .decompressor = unzstd },
+	{ /* sentinel */ }
 };
 
 decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
@@ -73,11 +73,10 @@ decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
 
 	pr_debug("Compressed data magic: %#.2x %#.2x\n", inbuf[0], inbuf[1]);
 
-	for (cf = compressed_formats; cf->name; cf++) {
+	for (cf = compressed_formats; cf->name; cf++)
 		if (!memcmp(inbuf, cf->magic, 2))
 			break;
 
-	}
 	if (name)
 		*name = cf->name;
 	return cf->decompressor;
-- 
2.51.0


