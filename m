Return-Path: <linux-kernel+bounces-792988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F1B3CB3D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70316A03E2F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EAF279359;
	Sat, 30 Aug 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="xZqbuKkt"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FF22156D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560512; cv=none; b=ZwwWKZ2eHA4T1egN7hUhWi39pNb3uDDy4ybNzNaB/9ZPtAHA/DD4zmz9jQ3KcivJ9DCTkFI97d8+Kd2lvXHnD3CHiyljKShwJopCA8O/9L0+KRlRiXisVjGHoi5GFesX3nCHNy6DALRaSHg+81X6oYePptMI9MJgT9aPl4xMuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560512; c=relaxed/simple;
	bh=rqY5ifaQ099fg0ROy4fQHHxhXXZlKfaRMWFmXd7yn6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjmymIZkUxh2ItSAWokqnRLjhkmmowtOwrzmW802jPDo2YwZaFsd7L5mRf0n8vm5V2T6DF/rAkFdc0EwzyLu/pGuLN2Cox4t+6XL1Tl6zw5w5Y2AWyUQQuRL3LKROnPFBc4507ZqV6TEOH0zpwH3betap8NHbeKfl5dx8qCfJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=xZqbuKkt; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47175d02dcso2526143a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1756560508; x=1757165308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVIJb1ig+WCLfQAs9Ab9QM8wAITsonpvQJCq8EwpAzg=;
        b=xZqbuKkt1VKuwvRU3Oq5CliN8hhhKfgY6kjhlk86VFGGxfIXY2wP/6Br/8XUbNSGph
         5jTTw8CwWTliNesmEJWhsobmcAq3FHJKnfLDW//hPwwKa2tO01zJeNWwMHcFnsCz0Sn+
         bdtYCjsI0XKboPaSTzpxSAHO3hfHp1IvNKX05u4pBMMUSvnoLcB5WRERvG9YyLg6d2DD
         sT1hS3r6ytD3XscEWqoAwcfQrVmkchxndubmTkt9AjgyDoNz2zywbQ2a5nlltkUd6m48
         ao7Oa2AMr2LSRLAyRaHioZ/1Vib+kFrD6aId55C2YFxPT86uFzBBqZquh/0sMUOr+ykY
         oY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756560508; x=1757165308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVIJb1ig+WCLfQAs9Ab9QM8wAITsonpvQJCq8EwpAzg=;
        b=oXxIfXrmWxHStriXaa4QYuU3T49SuXfN+NZOvVVmOKrhk3G/ZQl6B2BoFzYNMPHsYx
         Tf0jRLnlXlA9gvd1mq4d8c97f9gEhM9PjHsVX1VGMSP1u69TImIayDgJAiaj87KdFW10
         NfrbeXIBZs7G18tMiKxKRxDke3RDI9D7TwGi8tFjV6hwiX+E+zX0yUWHpHr/kXKBJ2J/
         tj+Bqbi+PsjBs8vgGWA1jWFCQTMbqVBRpWc/VYqFQm/aqRsTy11y3ob3csg1K1jV3Su7
         /7Wqk7CSWa/zGC3tzxvDkntxlYZhK8oSSNqL/IeB5jF25cZr4KiTMeZjzj6OyV3kRdpp
         nl3g==
X-Forwarded-Encrypted: i=1; AJvYcCUpttGBTGORmxme5J7pdveTcfXJ8f+cHWP/uGtUNUhLudUH8rs/5sZb+6mZFjJ9zHnQ2tlHPF0WPytX/m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoS32wtP6L4x8RvF6x7XSlCaw6syh+7LaC8TAoOSR8QeKLhGyB
	QFzGzKr3nJa4ezPHvbEM86ru5dVyM97jeWNPjIzTSzh9NqHhfhm9X9R/jKmVtU9X+Kk=
X-Gm-Gg: ASbGncuPsZmdixCivP8VEYCRKEKXzQYBx6qhIj4T//hOJNZlXWot9diWWv2VX4ulN3g
	CVzRhJu5pTJFcx31XKUul+q/65GyfR3uXvML9vU20d6Q74fKl/c4Gr46OLd1+VsjzottivsUsxs
	4Hn/yc7oQ/zexT+QWds9VnLMMP1wBb5+mxKdXjaoEsVptx7AGtf4OQcJvRI2DrzwWSK2B8bVRw3
	RY3a3nZhG1dFWGLMlsO6eqAJyfKW8VtYQ4jZdo0eWzFsg6b9lkFJZPPwQFX5Ox2II3x5EpRTB1h
	v8cL/TcQXV5S271bYyR9qkVxCxMwL61FUN1Znnx0of0K0cMZIuJ7cfeoiCYe+IF8dCjwkaA9b5Z
	fyC5iU398uz1/gMaMbmXC/LsqTRXS5uB/dd6q8W9tomdgnF/ED63xL5Hrgg==
X-Google-Smtp-Source: AGHT+IHyJkZDKdgGkHFC09y0O8qYSmh9Rh1KUqMZ7YxphBzOoBEYI7HCjEYcIBxyA3JWOO7TVXftpQ==
X-Received: by 2002:a17:902:f543:b0:240:50ef:2f00 with SMTP id d9443c01a7336-24944a0e817mr29247275ad.26.1756560507819;
        Sat, 30 Aug 2025 06:28:27 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7a16:5a8f:5bc5:6642])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065b7413sm51623665ad.132.2025.08.30.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 06:28:27 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: xiubli@redhat.com,
	idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>
Subject: [PATCH] ceph: optimize ceph_base64_encode() with block processing
Date: Sat, 30 Aug 2025 21:28:22 +0800
Message-Id: <20250830132822.7827-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, ceph_base64_encode() used a bitstream approach, handling one
input byte at a time and performing extra bit operations. While correct,
this method was suboptimal.

This patch processes input in 3-byte blocks, mapping directly to 4 output
characters. Remaining 1 or 2 bytes are handled according to standard Base64
rules. This reduces computation and improves performance.

Performance test (5 runs) for ceph_base64_encode():

64B input:
-------------------------------------------------------
| Old method | 123 | 115 | 137 | 119 | 109 | avg ~121 ns |
-------------------------------------------------------
| New method |  84 |  83 |  86 |  85 |  84 | avg ~84 ns  |
-------------------------------------------------------

1KB input:
--------------------------------------------------------
| Old method | 1217 | 1150 | 1146 | 1149 | 1149 | avg ~1162 ns |
--------------------------------------------------------
| New method |  776 |  772 |  772 |  774 |  770 | avg ~773 ns  |
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
	if (bits)
		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
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
		*cp++ = base64_table[(ac >> 6) & 0x3f];
		*cp++ = base64_table[ac & 0x3f];
		i += 3;
	}

	switch (srclen - i) {
	case 2:
		ac = ((u32)src[i] << 16) | ((u32)src[i + 1] << 8);
		*cp++ = base64_table[(ac >> 18) & 0x3f];
		*cp++ = base64_table[(ac >> 12) & 0x3f];
		*cp++ = base64_table[(ac >> 6) & 0x3f];
		break;
	case 1:
		ac = ((u32)src[i] << 16);
		*cp++ = base64_table[(ac >> 18) & 0x3f];
		*cp++ = base64_table[(ac >> 12) & 0x3f];
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
---
 fs/ceph/crypto.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 3b3c4d8d401e..a35570fd8ff5 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -27,20 +27,31 @@ static const char base64_table[65] =
 int ceph_base64_encode(const u8 *src, int srclen, char *dst)
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
+	while (i + 2 < srclen) {
+		ac = ((u32)src[i] << 16) | ((u32)src[i + 1] << 8) | (u32)src[i + 2];
+		*cp++ = base64_table[(ac >> 18) & 0x3f];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		*cp++ = base64_table[ac & 0x3f];
+		i += 3;
+	}
+
+	switch (srclen - i) {
+	case 2:
+		ac = ((u32)src[i] << 16) | ((u32)src[i + 1] << 8);
+		*cp++ = base64_table[(ac >> 18) & 0x3f];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		break;
+	case 1:
+		ac = ((u32)src[i] << 16);
+		*cp++ = base64_table[(ac >> 18) & 0x3f];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		break;
 	}
-	if (bits)
-		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
 	return cp - dst;
 }
 
-- 
2.34.1


