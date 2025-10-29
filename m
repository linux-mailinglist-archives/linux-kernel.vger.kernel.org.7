Return-Path: <linux-kernel+bounces-875710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C82C19AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC477463D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E42FF661;
	Wed, 29 Oct 2025 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="Y7jyWP2w"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925D7081E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733270; cv=none; b=rIAjVH7I3AQe+EnOWpKKE9LNujHcKparbFQYuvafRX1JSRaDfH7Xd8EDY1iLfG08QqM2Ye33vsLCk5Ft3WU26Ptxe3CFrcTLxeqYQ+AYwRLcpmYtBMTZ4h9gcHTe6+izxjloCP9oE6IvGLlNB8FoxapvI6zDixJ3cZtmEpHTOw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733270; c=relaxed/simple;
	bh=dY4q8YkbiAgjzKiEsiASrXojI4Al4U1XdOPWUwH7wwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+vDFN5lDvH8e+Z3r2ZNTjHvY4VpeCuFJUHRr2d3V696K0WhNAjmhnXRSGGgk3nIlBBWFXfyswLL51zY/8TiMw43/M6pP1DUTUWfpb9imfTfVyjQ+IPXB7JzNoPR389Lq1jIXApPn4Y+EGERqGMaCDWyOye0P0CIU+ghpy09DOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=Y7jyWP2w; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so5466104b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733267; x=1762338067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbulqRf/JzdfAl/dtv+qftIvyvV8wiDVdKN2RHYy4TQ=;
        b=Y7jyWP2w71F6U7E40iH6TwrqZJ9SpKzBaiTTDR7tz0WgNCy58k6NyUs2mNgWEQH4qD
         q1pnSengwQ+QSnRFJmx5YJ1J1sw8Ur2c1JxvEHxq/8XeclgO/hgsdtu/8jwm5HYa7jT1
         CTHTSGpK3N9jwJWZbzXySdpqKxPvHN5y72i8PMQP9d7UkOkdm8ofpahtrLQH4A8yv/pL
         FUecIMEncs9gs+WDZQVcpZIBT7VZNkxdM8Dqk7jT0xmnlwraNIqNEhUCMluU28ZTYpro
         ilcIoAUR+IE+Ycex3wcdBrccs3q2V00N2Q4qBYp7R4a4PZEERQpfztD0LKxoxGwWdzz8
         2noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733267; x=1762338067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbulqRf/JzdfAl/dtv+qftIvyvV8wiDVdKN2RHYy4TQ=;
        b=qb7ipE8ETyQQLVfUPXScJ+yBDrE8Hfeq76rSlfWOUl85EXI1cCK1kX2d5+Sursdo3R
         iNOQGG8YiKlV2JR8Oup2F33kYd+5iAXRqnANL1moKlfge9NqXZwPNrPw9EWL4GdAQ0Oc
         iI5lJZQ95O9HFTE0OSXOOWI79yYOSxHz7GhpE/iahl26hIHEStlSKkSB/qt0ZHLC/Qs8
         6P29hrRusPf2NeW66uP7BgJw2HYzBt/qyK/APVR3vxWaf7FbS1e1WvlOgW8kjchSmdGp
         4hi4/Fc/P53J+6AhZqPgUR4/M+wlYFhmH92rlWcQg7nD1Jh7CEP1OPJkBr4Bzivj1Fj9
         wsTg==
X-Forwarded-Encrypted: i=1; AJvYcCXpoTTDe4u7hR63BErtzlx7fDPjDtVnx1CSJjJgGU9mCrlNoj2wHES4iJavf94XzWGZ1mfdfKVfZJRFTPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya62/q9QoV1zTd3PW+SmGozF94JPg4gvCPFGrQnksma2JxeCJ+
	TtqrC4crcteSe9kWvBeUafofC+VxCNNH8Zti1kdde5TiI/gtfLeG0S2bD7o4e0xBBfg=
X-Gm-Gg: ASbGnctTVCvk9ooaVzdcQaqc2DMq5sCM9Lnjx+7khnQnAeFKAGQcpjU90PwVwihVn4o
	kxS8uKS+Fcb7dnqj+vyYhrGKFPJP77cehpst59jH+JrB1FW4IxZu0vLoA8awl/3OytXRAh7EZuD
	TVI0wcDGt7TstrVTX1IU/ZXlZX9un6DQKp0tSXrgQmax3TJXD0LrOmY6dFCot+mpah+KyJkQADD
	dW4hTdXbDGXHTpJFVEj8DBsA/L1kJOCtddSFqtA2F4LW+6ee8hF5hERfTcrzpR2Cue7R+qd1Mpv
	8h7o755RQHVWSapbKyNIsottTMTQjWLTA68n5hImyePuTESLEyV29AcALx2McftmSCbwM/UYNV0
	1r2feuUVVIZgSLXkTSPt8tZxa3cjUn1ZrrZK6tS2awZ4bYNPGc383jig2Ru2zo+smFg6fAxxS0I
	6evgagWp8lpa/IID2ty7MFxH0W
X-Google-Smtp-Source: AGHT+IHL0MICP1K9H4r8j+kOSzogqVuiVQjNGs4tt84n15SY6d/K/p8SfQsZ4RZjWKksxhhmDOquvA==
X-Received: by 2002:a05:6a00:2da5:b0:77f:4f3f:bfda with SMTP id d2e1a72fcca58-7a4e53f14dcmr2854006b3a.31.1761733267109;
        Wed, 29 Oct 2025 03:21:07 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414034661sm14888261b3a.26.2025.10.29.03.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:21:06 -0700 (PDT)
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
Subject: [PATCH v4 3/6] lib/base64: rework encode/decode for speed and stricter validation
Date: Wed, 29 Oct 2025 18:21:00 +0800
Message-Id: <20251029102100.543446-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old base64 implementation relied on a bit-accumulator loop, which was
slow for larger inputs and too permissive in validation. It would accept
extra '=', missing '=', or even '=' appearing in the middle of the input,
allowing malformed strings to pass. This patch reworks the internals to
improve performance and enforce stricter validation.

Changes:
 - Encoder:
   * Process input in 3-byte blocks, mapping 24 bits into four 6-bit
     symbols, avoiding bit-by-bit shifting and reducing loop iterations.
   * Handle the final 1-2 leftover bytes explicitly and emit '=' only when
     requested.
 - Decoder:
   * Based on the reverse lookup tables from the previous patch, decode
     input in 4-character groups.
   * Each group is looked up directly, converted into numeric values, and
     combined into 3 output bytes.
   * Explicitly handle padded and unpadded forms:
      - With padding: input length must be a multiple of 4, and '=' is
        allowed only in the last two positions. Reject stray or early '='.
      - Without padding: validate tail lengths (2 or 3 chars) and require
        unused low bits to be zero.
   * Removed the bit-accumulator style loop to reduce loop iterations.

Performance (x86_64, Intel Core i7-10700 @ 2.90GHz, avg over 1000 runs,
KUnit):

Encode:
  64B   ~90ns   -> ~32ns   (~2.8x)
  1KB  ~1332ns  -> ~510ns  (~2.6x)

Decode:
  64B  ~1530ns  -> ~35ns   (~43.7x)
  1KB ~27726ns  -> ~530ns  (~52.3x)

Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 110 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 41 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index 8a0d28908..bcdbd411d 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -51,28 +51,38 @@ static const s8 base64_rev_maps[][256] = {
 int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
 {
 	u32 ac = 0;
-	int bits = 0;
-	int i;
 	char *cp = dst;
 	const char *base64_table = base64_tables[variant];
 
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
+	while (srclen >= 3) {
+		ac = (u32)src[0] << 16 | (u32)src[1] << 8 | (u32)src[2];
+		*cp++ = base64_table[ac >> 18];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		*cp++ = base64_table[ac & 0x3f];
+
+		src += 3;
+		srclen -= 3;
 	}
-	if (padding) {
-		while (bits < 0) {
+
+	switch (srclen) {
+	case 2:
+		ac = (u32)src[0] << 16 | (u32)src[1] << 8;
+		*cp++ = base64_table[ac >> 18];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		if (padding)
+			*cp++ = '=';
+		break;
+	case 1:
+		ac = (u32)src[0] << 16;
+		*cp++ = base64_table[ac >> 18];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		if (padding) {
+			*cp++ = '=';
 			*cp++ = '=';
-			bits += 2;
 		}
+		break;
 	}
 	return cp - dst;
 }
@@ -88,41 +98,59 @@ EXPORT_SYMBOL_GPL(base64_encode);
  *
  * Decodes a string using the selected Base64 variant.
  *
- * This implementation hasn't been optimized for performance.
- *
  * Return: the length of the resulting decoded binary data in bytes,
  *	   or -1 if the string isn't a valid Base64 string.
  */
 int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
 {
-	u32 ac = 0;
-	int bits = 0;
-	int i;
 	u8 *bp = dst;
-	s8 ch;
+	s8 input[4];
+	s32 val;
+	const u8 *s = (const u8 *)src;
+	const s8 *base64_rev_tables = base64_rev_maps[variant];
 
-	for (i = 0; i < srclen; i++) {
-		if (padding) {
-			if (src[i] == '=') {
-				ac = (ac << 6);
-				bits += 6;
-				if (bits >= 8)
-					bits -= 8;
-				continue;
-			}
-		}
-		ch = base64_rev_maps[variant][(u8)src[i]];
-		if (ch == -1)
-			return -1;
-		ac = (ac << 6) | ch;
-		bits += 6;
-		if (bits >= 8) {
-			bits -= 8;
-			*bp++ = (u8)(ac >> bits);
+	while (srclen >= 4) {
+		input[0] = base64_rev_tables[s[0]];
+		input[1] = base64_rev_tables[s[1]];
+		input[2] = base64_rev_tables[s[2]];
+		input[3] = base64_rev_tables[s[3]];
+
+		val = input[0] << 18 | input[1] << 12 | input[2] << 6 | input[3];
+
+		if (unlikely(val < 0)) {
+			if (!padding || srclen != 4 || s[3] != '=')
+				return -1;
+			padding = 0;
+			srclen = s[2] == '=' ? 2 : 3;
+			break;
 		}
+
+		*bp++ = val >> 16;
+		*bp++ = val >> 8;
+		*bp++ = val;
+
+		s += 4;
+		srclen -= 4;
 	}
-	if (ac & ((1 << bits) - 1))
+
+	if (likely(!srclen))
+		return bp - dst;
+	if (padding || srclen == 1)
 		return -1;
+
+	val = (base64_rev_tables[s[0]] << 12) | (base64_rev_tables[s[1]] << 6);
+	*bp++ = val >> 10;
+
+	if (srclen == 2) {
+		if (val & 0x800003ff)
+			return -1;
+	} else {
+		val |= base64_rev_tables[s[2]];
+		if (val & 0x80000003)
+			return -1;
+		*bp++ = val >> 2;
+	}
 	return bp - dst;
 }
 EXPORT_SYMBOL_GPL(base64_decode);
+
-- 
2.34.1


