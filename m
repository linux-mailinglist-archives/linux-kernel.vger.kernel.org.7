Return-Path: <linux-kernel+bounces-792987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBAB3CB3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379CE16C8C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E4F22156F;
	Sat, 30 Aug 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="ufnFSx9e"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12636124
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560493; cv=none; b=my0kMxGZblxlFbroC8AQs192pCULJcEdMdqNVdAk7Pp/486cbuZRmHfYaXwNuI/PTXv5px5f2DaP2TAeH9k0M7pIl4P4ct+ZiiXVmKPNT+FnB7tXONni0t2URIX+VDc00l6/a22HROQdZrcICiOHWK9LM+fZ7U2xq28zpd1OXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560493; c=relaxed/simple;
	bh=D/uQU/qJRg2bGoMSqlTovJpg/Wq8ID5V47mETCpc4G8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FU+6ZsVIt03poPGiMRUMBh6HV5/S4jpptC2nBqudoDgd1m2wEX4qdfYHiF6xq3GNls/VNmQQ1FF5/u082/ykr4R8CrcovBU6AJbvWsTi4bhm76Q/DevvpF2p6ke3tCKbiq4TrDliVRGDn3oQHzN6QTq5g+6dqStM/KN6h6mlgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=ufnFSx9e; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-770530175a6so1889482b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1756560489; x=1757165289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dG543pWXBgR7jVWwE5uz1I8zd2LZe9v+aEs4hAx53go=;
        b=ufnFSx9ewbTseAPPjpUCrA+ZmlS89r4xX6jqtbqDI73MzvufBNPv8hYu4HCCvHBNIB
         shXzKNtTq5i2mLNc9juteAFubtYOtE/fJPuF6+fjEgnRQdyMI6dam7sgL7JyqHJUEuhf
         MpJHyEwIfmp/uAvsq5ZZfAXbFM0GdsdZlpXutvv8lcNE5/+g5FnpOLJn+/jYId+r654v
         X6jAvj4hRF8lTsbVx/0jsUsz8s+W4DDqwfezI4/iEnQ/rC9kp6ZFNCgbuGr8xcCGHbft
         0XXJQKMmExrAfhJEGh6siXQ9k0Khg9jQTgqfLSor78vYs2gUFgjEwN/JjKlUrbtGJ6IF
         HrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756560489; x=1757165289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dG543pWXBgR7jVWwE5uz1I8zd2LZe9v+aEs4hAx53go=;
        b=bWBqLNIoO4xPtHAy9dwUpspyflucuzhsIS9JVsBDwypGSGiSVas1mDmdi0D1PihUgN
         l6D0kigfZ6eoZeS4TTuDnl+IO4baKxzMggxoQvU38FqIGx3CiUYodLcQhHl49ZA5u1ti
         NiQg6LlIkQlq+pBKYk9pvN6Q7AlPLk/30ip5WqIDA09EcMYhxcmEQgFGDbKHy66LjIYG
         xhEqtMvO4vZltmpeNmvoVxvGUzHfTfxCFLpHxH5UOWLNguKCZVOnKLqDF9lD5uP5XDvB
         hlciKHt3EfaGDBArX825RCfoxTbMgB3xBbIAA69thDsTDah4kDoRDFfjJViUPjigYulf
         pXaQ==
X-Gm-Message-State: AOJu0YzDmMmOPFJaC1mFtACL1Qa69AQuTxlfE+yWo0UQ0FO7G6zzBQNg
	DpIyCbLZjgmT2ClYkjjKSDXulUmlZoFEPYQ2nDcOOkkhdCCs0+XNk+fwy6XYJazKx1s=
X-Gm-Gg: ASbGncsTwfdsOCLWHAd5XiPdgbUg4XoyWD83yLz/i8bxcL9GbChwmQej5vGv33qcS6S
	wX1PGKZlRXbsqmbDAXNCUJSdOG9hgMiC2RzCKvtp9wm/aOrMCOUy9YS2qurrYYQIwWZYWaZ6scb
	qbQ7G3zxHqlaQzwOWheKI+qyqrjw/siFEhsJt7MDHIjx7j4o4J8lkp1ky2sL+2xDGiFzj/mKiuw
	EIzLw3o5JaKePgXv90DLmMzdDBDTg8Xkk2nNR3QTuF/wmqrNQFX2xb629cfVJaI2RFCivZSAasz
	KE4OOUO7I7QazPulGoWdOaXUP6n3aO9hdAHaYPlZTHjL6sF1tb2dyR7tAukjxVWVRuWeuMmDSJQ
	ZRG6w49YejNP5yjRJ41CZbUJap1mOrndKdWRx7rezhgdfKVLYlWuCIHbfgg==
X-Google-Smtp-Source: AGHT+IH1aenkX9NfQCDhzRvH/yKza7soUGR1T3/s2bq3UdS5nOm8eSPcfqFQ8adG3vFA8O62q95qiA==
X-Received: by 2002:a05:6a20:7291:b0:243:78a:828c with SMTP id adf61e73a8af0-243d6f7e6a7mr2957806637.51.1756560489037;
        Sat, 30 Aug 2025 06:28:09 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7a16:5a8f:5bc5:6642])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006dd49sm4862910a12.5.2025.08.30.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 06:28:08 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>
Subject: [PATCH] lib/base64: optimize base64_encode() with block processing
Date: Sat, 30 Aug 2025 21:28:05 +0800
Message-Id: <20250830132805.7727-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, base64_encode() processed one input byte at a time using a
bitstream approach, accumulating bits and emitting characters when 6
bits were available. This caused extra bit operations and loop overhead.

This patch processes 3-byte blocks at a time, mapping them directly to 4
output characters. Remaining 1 or 2 bytes are handled with standard Base64
padding. This reduces computation and improves performance.

Performance test (5 runs) for base64_encode():

64B input:
-------------------------------------------------------
| Old method | 129 | 135 | 125 | 126 | 131 | avg ~129 ns |
-------------------------------------------------------
| New method |  87 |  86 |  85 |  85 |  86 | avg ~86 ns  |
-------------------------------------------------------

1KB input:
--------------------------------------------------------
| Old method | 1296 | 1286 | 1291 | 1290 | 1290 | avg ~1291 ns |
--------------------------------------------------------
| New method |  771 |  771 |  769 |  772 |  771 | avg ~771 ns  |
--------------------------------------------------------

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
Tested on Linux 6.8.0-64-generic x86_64
with Intel Core i7-10700 @ 2.90GHz

Test is executed in the form of kernel module.

Test script:

static int encode_v1(const u8 *src, int srclen, char *dst)
{
	u32 ac = 0;
	int bits = 0;
	int i;
	char *cp = dst;

	for (i = 0; i < srclen; i++) {
		ac = (ac << 8) | src[i];
		bits += 8;
		do {
			bits -= 6;
			*cp++ = base64_table[(ac >> bits) & 0x3f];
		} while (bits >= 6);
	}
	if (bits) {
		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
		bits -= 6;
	}
	while (bits < 0) {
		*cp++ = '=';
		bits += 2;
	}
	return cp - dst;
}

static int encode_v2(const u8 *src, int srclen, char *dst)
{
	u32 ac = 0;
	int i = 0;
	char *cp = dst;

	while (i + 2 < srclen) {
		ac = ((u32)src[i] << 16) | ((u32)src[i + 1] << 8) | (u32)src[i + 2];
		*cp++ = base64_table[(ac >> 18) & 0x3f];
		*cp++ = base64_table[(ac >> 12) & 0x3f];
		*cp++ = base64_table[(ac >>  6) & 0x3f];
		*cp++ = base64_table[ac & 0x3f];
		i += 3;
	}

	switch (srclen - i) {
	case 2:
		ac = ((u32)src[i] << 16) | ((u32)src[i + 1] << 8);
		*cp++ = base64_table[(ac >> 18) & 0x3f];
		*cp++ = base64_table[(ac >> 12) & 0x3f];
		*cp++ = base64_table[(ac >>  6) & 0x3f];
		*cp++ = '=';
		break;
	case 1:
		ac = ((u32)src[i] << 16);
		*cp++ = base64_table[(ac >> 18) & 0x3f];
		*cp++ = base64_table[(ac >> 12) & 0x3f];
		*cp++ = '=';
		*cp++ = '=';
		break;
	}

	return cp - dst;
}

static void run_test(const char *label, const u8 *data, int len)
{
    char *dst1, *dst2;
    int n1, n2;
    u64 start, end;

    dst1 = kmalloc(len * 2, GFP_KERNEL);
    dst2 = kmalloc(len * 2, GFP_KERNEL);

    if (!dst1 || !dst2) {
        pr_err("%s: Failed to allocate dst buffers\n", label);
        goto out;
    }

    pr_info("[%s] input size = %d bytes\n", label, len);

    start = ktime_get_ns();
    n1 = encode_v1(data, len, dst1);
    end = ktime_get_ns();
    pr_info("[%s] encode_v1 time: %lld ns\n", label, end - start);

    start = ktime_get_ns();
    n2 = encode_v2(data, len, dst2);
    end = ktime_get_ns();
    pr_info("[%s] encode_v2 time: %lld ns\n", label, end - start);

    if (n1 != n2 || memcmp(dst1, dst2, n1) != 0)
        pr_err("[%s] Mismatch detected between encode_v1 and encode_v2!\n", label);
    else
        pr_info("[%s] Outputs are identical.\n", label);

out:
    kfree(dst1);
    kfree(dst2);
}

static int __init base64_perf_init(void)
{
    u8 *data1k;

    pr_info("Module init - running multi-size tests\n");

    {
        static u8 test64[64];
        get_random_bytes(test64, sizeof(test64));
        run_test("64B", test64, sizeof(test64));
    }

    data1k = kmalloc(1024, GFP_KERNEL);
    if (data1k) {
        get_random_bytes(data1k, 1024);
        run_test("1KB", data1k, 1024);
        kfree(data1k);
    } else {
        pr_err("Failed to allocate 1KB test buffer\n");
    }

    return 0;
}
---
 lib/base64.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index b736a7a431c5..a8f7b0e8b6ac 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -32,25 +32,33 @@ static const char base64_table[65] =
 int base64_encode(const u8 *src, int srclen, char *dst)
 {
 	u32 ac = 0;
-	int bits = 0;
-	int i;
+	int i = 0;
 	char *cp = dst;
 
-	for (i = 0; i < srclen; i++) {
-		ac = (ac << 8) | src[i];
-		bits += 8;
-		do {
-			bits -= 6;
-			*cp++ = base64_table[(ac >> bits) & 0x3f];
-		} while (bits >= 6);
-	}
-	if (bits) {
-		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
-		bits -= 6;
+	while (i + 2 < srclen) {
+		ac = ((u32)src[i] << 16) | ((u32)src[i + 1] << 8) | (u32)src[i + 2];
+		*cp++ = base64_table[(ac >> 18) & 0x3f];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		*cp++ = base64_table[ac & 0x3f];
+		i += 3;
 	}
-	while (bits < 0) {
+
+	switch (srclen - i) {
+	case 2:
+		ac = ((u32)src[i] << 16) | ((u32)src[i + 1] << 8);
+		*cp++ = base64_table[(ac >> 18) & 0x3f];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		*cp++ = '=';
+		break;
+	case 1:
+		ac = ((u32)src[i] << 16);
+		*cp++ = base64_table[(ac >> 18) & 0x3f];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = '=';
 		*cp++ = '=';
-		bits += 2;
+		break;
 	}
 	return cp - dst;
 }
-- 
2.34.1


