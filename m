Return-Path: <linux-kernel+bounces-841912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C8BB8827
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965F01889E12
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D19D2857EA;
	Sat,  4 Oct 2025 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GOrCXp/v"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48A6283141
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543266; cv=none; b=RqrRAPdiJSMxE13gH2W6IX8Y1s8IttGX6fZ2mb1bJn9KnVirQY27lSHaW2JKorJvJr77zHFb5MneiZG54lt8YoQYE6pEUQo3uPkNFoeZixXZbj/tZXON1LlCPjqIImteiW7b2/Lkm4w+bzZtMms/NxT0b9W2vVndD1r4BALyI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543266; c=relaxed/simple;
	bh=fJzfsa+Ryi3JN+cImqkE3DET+oMsTYcxlVBzWsdxoBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adp7yWOGGi7nQ6ahhFKPiHIRfB1qupcPdF9QYP1bndBYoLt7cEKPokjCGCbIy239i+7Vb4Dy+zuwYgrfSs9S6X67w6GofivP8quA9M2i9Pxfj9ufFPjyfdWyqvd4VhRD+yPX7lSAFh0ysKbmjW8wIOzzq1cYKB9tOgMB9eelg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GOrCXp/v; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759543263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJ7rTHqPZYDIm6nky3NqUMxo2UT+0SMVyCYRQdn2bac=;
	b=GOrCXp/vSsuymUBsqiPwZtq0Fj/CilLXSeBMrZqbZg34ibW9GIMTgkYGifThO64yC9+dB5
	rKBwUqKBt1ZCkWamqKuRuRKFuYF/Ol7HBcvfmlVbJguzkiFSKeZJE+QTZ6Vmx17iWng/CX
	dx+wxM1cbTVveWUFlW2x/oyIARY4ztM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 7/7] lib: Give compression, checksum, crypto config opts names
Date: Fri,  3 Oct 2025 22:00:49 -0400
Message-ID: <20251004020049.918665-8-kent.overstreet@linux.dev>
In-Reply-To: <20251004020049.918665-1-kent.overstreet@linux.dev>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Give these config options names so that they show up under the "Library
routes" kernel configuration menu, and can be enabled by distributions.

These are needed for bcachefs to be built out of tree.

Most (but not all, notably CRC64) of these libraries have crypto API
wrappers which are already selectable under the "Cryptographic API"
configuration menu; however, Eric Biggers has been working to reduce
usage of the cryptographic API in favor of much more lightweight direct
APIs.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/Kconfig        | 16 ++++++++--------
 lib/crc/Kconfig    |  4 ++--
 lib/crypto/Kconfig |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index e831f4462453..eb3b6b96b303 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -142,7 +142,7 @@ source "lib/crc/Kconfig"
 source "lib/crypto/Kconfig"
 
 config XXHASH
-	tristate
+	tristate "XXHASH checksum algorithm"
 
 config AUDIT_GENERIC
 	bool
@@ -176,10 +176,10 @@ config 842_DECOMPRESS
 	tristate
 
 config ZLIB_INFLATE
-	tristate
+	tristate "Zlib decompression"
 
 config ZLIB_DEFLATE
-	tristate
+	tristate "Zlib compression"
 	select BITREVERSE
 
 config ZLIB_DFLTCC
@@ -196,13 +196,13 @@ config LZO_DECOMPRESS
 	tristate
 
 config LZ4_COMPRESS
-	tristate
+	tristate "LZ4 compression"
 
 config LZ4HC_COMPRESS
-	tristate
+	tristate "LZ4HC compression"
 
 config LZ4_DECOMPRESS
-	tristate
+	tristate "LZC decompression"
 
 config ZSTD_COMMON
 	select XXHASH
@@ -210,11 +210,11 @@ config ZSTD_COMMON
 
 config ZSTD_COMPRESS
 	select ZSTD_COMMON
-	tristate
+	tristate "ZSTD compression"
 
 config ZSTD_DECOMPRESS
 	select ZSTD_COMMON
-	tristate
+	tristate "ZSTD decompression"
 
 source "lib/xz/Kconfig"
 
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index 70e7a6016de3..3a3d6290211b 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -54,7 +54,7 @@ config CRC_T10DIF_ARCH
 	default y if X86
 
 config CRC32
-	tristate
+	tristate "CRC32 algorithm"
 	select BITREVERSE
 	help
 	  The CRC32 library functions.  Select this if your module uses any of
@@ -74,7 +74,7 @@ config CRC32_ARCH
 	default y if X86
 
 config CRC64
-	tristate
+	tristate "CRC64 algorithm"
 	help
 	  The CRC64 library functions.  Select this if your module uses any of
 	  the functions from <linux/crc64.h>.
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 1e6b008f8fca..51e4e8d3b793 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -62,7 +62,7 @@ config CRYPTO_LIB_CHACHA_GENERIC
 	  enabled, this implementation serves the users of CRYPTO_LIB_CHACHA.
 
 config CRYPTO_LIB_CHACHA
-	tristate
+	tristate "Chacha encryption algorithm"
 	help
 	  Enable the ChaCha library interface. This interface may be fulfilled
 	  by either the generic implementation or an arch-specific one, if one
@@ -125,7 +125,7 @@ config CRYPTO_LIB_POLY1305_GENERIC
 	  enabled, this implementation serves the users of CRYPTO_LIB_POLY1305.
 
 config CRYPTO_LIB_POLY1305
-	tristate
+	tristate "Poly1305 authentication algorithm"
 	help
 	  Enable the Poly1305 library interface. This interface may be fulfilled
 	  by either the generic implementation or an arch-specific one, if one
-- 
2.51.0


