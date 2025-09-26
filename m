Return-Path: <linux-kernel+bounces-833662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D0BA295F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8EF3B16E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B0027F756;
	Fri, 26 Sep 2025 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="JN7Jyh35"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1232C27E040
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869765; cv=none; b=PWKhYkI9UVZTmQxKJrljkVydnjNYWmQhC20Sj14y/IdG4pt45EYvtJn1ajZKLJvziCSxRCfD4Xwb/6PUegjuhTQvfc0JFLuEU8M0ZZlJ8+07xn0DAlRRj6xVkgu+YJfMKuahwllszHSb/R5HAgCs4TjlHfQNbCR5DOUyyg+71hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869765; c=relaxed/simple;
	bh=+4YCN2dmmyfb7+Hl1S6/hlw/+FbPhHYA7RWFcIkHebg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiBRXZYXQ3sWmt93dVistcgdw21kx1qTraC1DqXOIzMPkLgtSbQGWHV7mBPExxmAZ/9iuOJkIMXLUImGkca3ikwCHPYtVoxr87KHOli0p+UCmpj0qknIiTwZ0u4nNIAe1WEgwe+r9At0zv0og6c/YHmKoc7IT9bDTASg4AeY2mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=JN7Jyh35; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f7da24397so1668565b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1758869763; x=1759474563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoUrxrA1gUNwCBEXabdQA4Jiv6vtYFchaTivJjmbSzM=;
        b=JN7Jyh35hvJxqKA0eciejU9HR/AggXWfxW842Us2/elza8ebZl/M6tJUk52hsdIqBW
         W9IS4Xp8Pmwht4WnmsBpoUkWYsIaf9NgkaqfoHv7yzgRQU0alsC7PXfOQEDm6ztWlcLR
         D8hXDXByInnZymjNFQEi7JhMcfOasIcjNRMqgKpPIYweTZlekjs45IDHAjYQCRCRmE6u
         PuM1043istvCMg45FJxoFhOwPscckrfvPXLKoEnw6i43TDTDMjHqJB3oBUGVYJOvqZFF
         zxFY/AC2EuU186MUEDhdxVWbKcgnNyj8dDVeBtg1ZfwxG7gml+pwFKYvbZk8uiKL/fJT
         dqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869763; x=1759474563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoUrxrA1gUNwCBEXabdQA4Jiv6vtYFchaTivJjmbSzM=;
        b=ImQ+d8d/IgveSVm3piIFvnpaEKMzWTpta7NmyihWYpX+sGlrBlPZYn6aBi9lIkAFdo
         8Na7yB77AoeH1OrRVbYmfKEXoL2wFasbvC8ShQfrcdEU59v4fx9mO0h/fI/enP0HphJT
         dQMqEwaDgMdsMfF8g9vGIfgiVqMge4j+pKvh0KGeJXrqp5OpnM3ROn/UBsnZ0PeezOKl
         Mhb7rb/TMK1hnQHa6Nf8WAv7DEZktmM7ueHcx9RZuHkyd29VL00/x/uxioIB5wycVxim
         DNlxRIBqSHuKg7cco7K1+5pPVF+w9H8wPuPa/+RCOhna10Nrx26ruFWqUFzt53Vw1wra
         R0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtbt4di6xc5Qhjp+m3BblM0HnoSV2IrJ4RM700Qm2cYS/zD45hHIt/0/hcCut39sgmKbRDy/ASG3iyeE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOsAi+VhAVja3Gt+tH3NQJt9M0yDGy7uZ5CjrIEJOc0b7P3sGP
	VJ6smDDN/tCMMzyqW1eZeGMmzUoijoImnOW9CZWCuBKwcPsHEPSkxOo77awFNp7YE/w=
X-Gm-Gg: ASbGncvQV2IbVs3EMC3pGqt2BOOa5xpI8b4kLyJReEaIloLlEqW3b+X259yVm5Y5fko
	khs+t3EVt0JJspK82r+OoIGhQFRFAicXYoZrx94Yowl313Dq0ZvoWXwfMB8NxVIwKNBFr5u8r7o
	qvOyFyqhd+TkmWcoHgUJl3poxHDNimA9wAQh/fxwvEKqafoQlyFYckavx6rJPFnq8j3eA+lVx4P
	XN0+Mc9zKwgsqmBmAkZlIxehruAxGlk06TBpf9ad/ifeGbFvzoZBwUaq5cVluZ9Rmg8iBsFJTDs
	s5nMJ0ZwIQvR+1qECx4QdMrBRdCl2JRT645bD1kqNbC9+EQmeIESKvD2MoeK7Nu+l3FuSlciuc+
	WBReXym67K+RAKIZCVFEF0323NCLSIndaKXzm7DS+h62dnYw=
X-Google-Smtp-Source: AGHT+IGYm5AiCHUG81wKjmGsOZM0oMcXTABlIBjc3hApVwgc3SyeCPuiUQVrAgnYuzKJCyjqVgplKg==
X-Received: by 2002:a17:902:d4c8:b0:24c:ed95:2725 with SMTP id d9443c01a7336-27ed4a06ca7mr77835285ad.4.1758869763210;
        Thu, 25 Sep 2025 23:56:03 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:94ad:363a:4161:464c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed672aa0asm45307415ad.62.2025.09.25.23.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:56:02 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: 409411716@gms.tku.edu.tw
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	ceph-devel@vger.kernel.org,
	ebiggers@kernel.org,
	hch@lst.de,
	home7438072@gmail.com,
	idryomov@gmail.com,
	jaegeuk@kernel.org,
	kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	tytso@mit.edu,
	visitorckw@gmail.com,
	xiubli@redhat.com
Subject: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse lookup tables
Date: Fri, 26 Sep 2025 14:55:56 +0800
Message-Id: <20250926065556.14250-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Replace the use of strchr() in base64_decode() with precomputed reverse
lookup tables for each variant. This avoids repeated string scans and
improves performance. Use -1 in the tables to mark invalid characters.

Decode:
  64B   ~1530ns  ->  ~75ns    (~20.4x)
  1KB  ~27726ns  -> ~1165ns   (~23.8x)

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index 1af557785..b20fdf168 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -21,6 +21,63 @@ static const char base64_tables[][65] = {
 	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
 };
 
+static const s8 base64_rev_tables[][256] = {
+	[BASE64_STD] = {
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,  -1,  63,
+	 52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
+	 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
+	 -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
+	 41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	},
+	[BASE64_URLSAFE] = {
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,
+	 52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
+	 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  63,
+	 -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
+	 41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	},
+	[BASE64_IMAP] = {
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  63,  -1,  -1,  -1,
+	 52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
+	 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
+	 -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
+	 41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	},
+};
+
 /**
  * base64_encode() - Base64-encode some binary data
  * @src: the binary data to encode
@@ -82,11 +139,9 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 	int bits = 0;
 	int i;
 	u8 *bp = dst;
-	const char *base64_table = base64_tables[variant];
+	s8 ch;
 
 	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64_table, src[i]);
-
 		if (src[i] == '=') {
 			ac = (ac << 6);
 			bits += 6;
@@ -94,9 +149,10 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 				bits -= 8;
 			continue;
 		}
-		if (p == NULL || src[i] == 0)
+		ch = base64_rev_tables[variant][(u8)src[i]];
+		if (ch == -1)
 			return -1;
-		ac = (ac << 6) | (p - base64_table);
+		ac = (ac << 6) | ch;
 		bits += 6;
 		if (bits >= 8) {
 			bits -= 8;
-- 
2.34.1


