Return-Path: <linux-kernel+bounces-744761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D048AB11093
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA845A8496
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144162EBDD5;
	Thu, 24 Jul 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZwjtdfB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C482EB5D1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379937; cv=none; b=c/4rkTiCRMdCQWUEbt5jMXZWtxe9PAUw1U26OOzQou1SXoyQJk+NlZgDmifHnbOcMHXmHr5pfj0Db1iI8vDANFDYExSYScWR+nEQnobwxx/HLHTld3cKcY3q5zMwKGhfm6q1lcVdus4A0ANPu+n+Hm70rwV8mWgf2tiQ+HJXF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379937; c=relaxed/simple;
	bh=K8jy8lC0vXKnJGo8j1ajnUpJxFDUjeplSBb1drpHlcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3eKStOuXOxU8NS1ljbVwlWTg9XZVIjpULePnJW/4noh8xEhllS3BR+c8Q88L5lvdzO+CPMwhvZbGguEvjjLCjo0TspLSR0hN29tg42xqmZt0bQTvviccCq9AVjnPfG5kQEcWAMKvOqX9xLub9V2a5PJQRv1pgt/lxMiqdUjobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZwjtdfB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so237350566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753379934; x=1753984734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9r3xc52zVdNjHOZzkIV/j2mgshG88/fLyFM4rWHFSLM=;
        b=hZwjtdfBxlNmnmLfq9fLEjE/jOaBRFwIS/comWjgsIMUTf0lGabL64b9q4ZlGXj9oQ
         pn9WL07s9t3bMX7RMAUc0Fz+iUpWVcAGt3slT+roFQTnFen/3cxtQYXtutWQ+TBfhkMW
         uTLBf/hfWZXHeDdYCYoHzEXje2feF/QzfpG4Pe4me11KI8RviqAwtoS1mmGZ5XG4XwKM
         CrkXi2kR+WejIi0AROx9+sbF70Y0CouQqJpgmo7RLSXHlpERtFG+9NnvHSCp61JUPG1d
         VY2E2ILcyWOwCD4PwRO55iSSTwAVCdZiM5ct+dF4+fm+ofkrW2NQ0PB16n0x0/FQBa1z
         qWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753379934; x=1753984734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9r3xc52zVdNjHOZzkIV/j2mgshG88/fLyFM4rWHFSLM=;
        b=nhH57VRQsRLNuiB9iq/m64+AopkCURyMRf0C9gHHiO9wYFnFFEFeS6lH2TV6s1Gz7R
         KpKqcOoV7fIW/RNgp7H6pyhObL2OSBSctDwpqXbB7M/7CAQkZAHmuWj2Hgv3kavDthbk
         WTD7hEDe+MSji2XqpSNTj9l59posiq1m+3p0slzS1MB+LD/cz/4yBM0So79n5hbD+cPb
         4PeymbqELjmCbwrmnN4DLagPQ+d7Nvj+xPsYBxWVH09B07BgjQxhEu+sLWS8RIZCZT7Z
         Nlw/dimvl9kkDUNy3yQpGzqBU/xPXBkWnMwNjrTcoZBYCOhMVzK2DJlc+skiAoWSafIp
         pXKw==
X-Forwarded-Encrypted: i=1; AJvYcCXfJKLoVwAUMVlZvfZU/ZHiPeBRA0Q4Cb/MS7UvQiEMDXx/D0/NudSJU1SpQmoEOAM9aOB8Z+O6OC3QWi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2L9jp6DYPQk5PNaRXJVzvmmPaOwQX3oaKyUjO1zDOOYVEV2V
	8O21SNkwgaldcVGaIf4t5XTPkxFAYQ8OqyD3zZ+c6KDBUEe+3EDHZ5yZ
X-Gm-Gg: ASbGncuNJexoe8fsi2UMQxyGqWRaAt2VUOXlWGvtPqpPhlYqr3ru5HOQ0LmopZgLT++
	O4WYPcG1q508dt4dgVkHtq1+pvTJBaPVpNIUSfYV62O2/gIcYJ4BeKSm0ZvcUsbxi4xczFn/X1O
	z7GBZtJuP5AzOZ32bWCpKZ5xZOXzriQHe1WWFi7I8mZlPby4B6yGsgOomEKoX2cwbE+SL/qncqP
	rfuyumP7t1MVjh4ssMD0odH4Q6FBPFoHeqmXjKqNyXMPaAGUtG8LkQ5uewOkj1a9QWSvYagDvP/
	b+2myRthDwX8p6y34BzfTxCumryUXnNpBlHikaOVaeYmcskPa45PLWUKbL58AmQIYnbJY6Pi4G2
	p4OjpnL5f3FzJQJ7jKPed
X-Google-Smtp-Source: AGHT+IHteS95g5R+SEA5hYfsN63gBjXqrqlzeSj1IzPAJbScwKbn1hQUmgT3ebFm6WqVa9UsqoecmA==
X-Received: by 2002:a17:906:c148:b0:add:ede0:b9d4 with SMTP id a640c23a62f3a-af2f32dd3f9mr798904866b.0.1753379933609;
        Thu, 24 Jul 2025 10:58:53 -0700 (PDT)
Received: from zephyr ([77.237.184.200])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-af47cc6bc83sm139015766b.38.2025.07.24.10.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 10:58:53 -0700 (PDT)
From: Ali Nasrolahi <a.nasrolahi01@gmail.com>
X-Google-Original-From: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ali Nasrolahi <A.Nasrolahi01@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix comment formatting in basic_types.h
Date: Thu, 24 Jul 2025 21:28:19 +0330
Message-ID: <20250724175819.29142-1-A.Nasrolahi01@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several block comment formatting issues in basic_types.h
to comply with the Linux kernel coding style.

Changes include:
- Aligning comment markers with asterisks in multi-line comments
- Reformatting long lines for better readability
- Improving consistency in comment structure
- Fixing typos in comments

These changes improve readability and remove checkpatch.pl warnings.
No functional changes introduced.

Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
---
 .../staging/rtl8723bs/include/basic_types.h   | 41 ++++++++++---------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
index 24626e65fc7..1c2da18e621 100644
--- a/drivers/staging/rtl8723bs/include/basic_types.h
+++ b/drivers/staging/rtl8723bs/include/basic_types.h
@@ -22,11 +22,11 @@
 /*  TODO: Belows are Sync from SD7-Driver. It is necessary to check correctness */
 
 /*
- *Call endian free function when
+ * Call endian free function when
  *	1. Read/write packet content.
  *	2. Before write integer to IO.
  *	3. After read integer from IO.
-*/
+ */
 
 /*  */
 /*  Byte Swapping routine. */
@@ -68,7 +68,8 @@
 		(*((u32 *)(_ptr))) = EF2BYTE(_val);	\
 	} while (0)
 
-/* Create a bit mask
+/*
+ * Create a bit mask
  * Examples:
  * BIT_LEN_MASK_32(0) => 0x00000000
  * BIT_LEN_MASK_32(1) => 0x00000001
@@ -82,7 +83,8 @@
 #define BIT_LEN_MASK_8(__bitlen) \
 	(0xFF >> (8 - (__bitlen)))
 
-/* Create an offset bit mask
+/*
+ * Create an offset bit mask
  * Examples:
  * BIT_OFFSET_LEN_MASK_32(0, 2) => 0x00000003
  * BIT_OFFSET_LEN_MASK_32(16, 2) => 0x00030000
@@ -94,7 +96,8 @@
 #define BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen) \
 	(BIT_LEN_MASK_8(__bitlen) << (__bitoffset))
 
-/*Description:
+/*
+ * Description:
  * Return 4-byte value in host byte ordering from
  * 4-byte pointer in little-endian system.
  */
@@ -105,11 +108,11 @@
 #define LE_P1BYTE_TO_HOST_1BYTE(__pstart) \
 	(EF1BYTE(*((u8 *)(__pstart))))
 
-/*  */
-/* 	Description: */
-/* 		Translate subfield (continuous bits in little-endian) of 4-byte value in litten byte to */
-/* 		4-byte value in host byte ordering. */
-/*  */
+/*
+ * Description:
+ * Translate subfield (continuous bits in little-endian) of 4-byte value in
+ * little byte to 4-byte value in host byte ordering.
+ */
 #define LE_BITS_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
 	(\
 		(LE_P4BYTE_TO_HOST_4BYTE(__pstart) >> (__bitoffset))  & \
@@ -126,11 +129,11 @@
 		BIT_LEN_MASK_8(__bitlen) \
 	)
 
-/*  */
-/* 	Description: */
-/* 		Mask subfield (continuous bits in little-endian) of 4-byte value in litten byte oredering */
-/* 		and return the result in 4-byte value in host byte ordering. */
-/*  */
+/*
+ * Description:
+ * Mask subfield (continuous bits in little-endian) of 4-byte value in little
+ * byte ordering and return the result in 4-byte value in host byte ordering.
+ */
 #define LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
 	(\
 		LE_P4BYTE_TO_HOST_4BYTE(__pstart)  & \
@@ -147,10 +150,10 @@
 		(~BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen)) \
 	)
 
-/*  */
-/* 	Description: */
-/* 		Set subfield of little-endian 4-byte value to specified value. */
-/*  */
+/*
+ * Description:
+ * Set subfield of little-endian 4-byte value to specified value.
+ */
 #define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
 		*((u32 *)(__pstart)) =				\
 		(						\
-- 
2.50.1


