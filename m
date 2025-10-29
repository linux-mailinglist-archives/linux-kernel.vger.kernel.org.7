Return-Path: <linux-kernel+bounces-875706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E4C19A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E64946215F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0269D2FB977;
	Wed, 29 Oct 2025 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="qcrPDbEm"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B52F6904
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733223; cv=none; b=VE+ZollHKTq4MFwb8ugcSZZ2Fyw9PJ/PHVUsv2/s8Q2P4QI6xw8RWEepBjXIaWCXYSjWRaELLqC5ptYLLpLLGTRMBquyWDz2S3s+5rZIuEeL8+7tihuI03uC6053nS4/xZB72cpMphKWsWs7rEadSGBD/hFRtW7gIeMpcSdCKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733223; c=relaxed/simple;
	bh=bBMVXH5ooqk0fbGAP+h/I66WrWQ/EJr5YDI16WD35LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VCCO53CCYXBMvXy5ActkgvXAuLlbCFpPWRi5YQN/uxyuQL1mMjkJ/xyi7LyiFWPxaKMXp9VMEn41/iODdpbmH+Yr4MKOyPqo9wCPF5Ec1Pr7bC/rR6e8XcpbzBVvrnfAWcLAeJ9635UUdYh2SmfcKTKbYhz3otSprbiD12w3Gb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=qcrPDbEm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so5106172a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733220; x=1762338020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFMCoYg6OZGdoPrg44aEfWpYsmxT09LG0Bx5eG4s0NA=;
        b=qcrPDbEmHBQf1SJiUxrDDMjKXSMTUB+IZwuG7gOoz+Xy8SNnzJmOBaWvbzBMOWpzUr
         I3FwZfxXSDWjDX5s0dD+nEKvYfy18rE92GL8UV2Jsj0UPUVon/obpAd/GiWAqf9wruJz
         evZE1BYCn7pNIUnM6acqVrrs7+01QK05rjH/qfQ/P0SahM2WfXuFNpjt4uwmKmOW/skQ
         QxoHXDWfHqSSTdNckG8o+ezyiFmqRcvKMNGSBspUgc4hzie9SPBX11P0jRt+0BvJfzCY
         Fb89InQfksFzyZs80hKJezBTP8INn/lcc4eBcpUgrxYeGxUapAHSQwWBavBtiCZ6EtXb
         rjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733220; x=1762338020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFMCoYg6OZGdoPrg44aEfWpYsmxT09LG0Bx5eG4s0NA=;
        b=mkfzo8AAOGnAkfj+G89ntp8PCZiTGpdiSWcReevOYJoBUwjJx4gbC8NvL/TeXYRP0i
         ahHwIQlrcM8QvcJmbJr/cUPWPRQ6czxrqTG8MSltCLY6n1RcT2pg+EY93XVQmBUe6nlk
         8HfoLv0vgsyjAfq8fZvF6IMVdfghRWj4exkmOs+82sZcRzUvJ/hMhetCahh5rz06mKuZ
         kd70v9JLAc8uG9rs5JKbUbCbko7SDGG7GyZB5owLFGMgASpVUydBHV02X8F4twzVwpXq
         BOhNQM8WnFYd+HxWBO5SU9BNiITRmoPtFgQ+hrsRGR2St2JxEcw3t4X7eu10FFCOEaDJ
         BHHg==
X-Forwarded-Encrypted: i=1; AJvYcCU85RWgCwnYGxXiR3bppNS9gGWxPCWyx1suGKSVRkqMmbDtLpcD3Kg3Py9uYgkHZQYkT/z/JAYfbnsllI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLRagevyll+SNlLWxegcV9lnqGtfCFhOPbJJ7nRg+uXAn1JeZV
	FJBhPESCq0nvWrK34u1sbZyCEmOftgVd1MlTG6j6WRfWK8GPcN1Yna/CLCGdn51OiwY=
X-Gm-Gg: ASbGncvxcR/QQ/08RZUsDLKs0UjkYM0TP+FlEHX1omsJs+xMb/SFjs7OnS08PJgDWMT
	AtGiao66y1EQ1sQSOPtUXt//mc9y2Fuww0Lvo/2X5FHbCd+e6lAWNnopQ8OVYTtsjAPHa1PVoSO
	IW1u1B7IxwrHppThG3TTVW3Opf8cejqJYMuviP89Z5qGuvKUeuOcdNC9fL3TTr/UXUPni8TYA9w
	eawXaKk2930EY0fP064e092S5LQhcjX2uW7fiGvB3bfnCk9IOwxGZN5+rgXSgTKfsNr1k1ECnbL
	n4/lAfZY6lVsYcdbhzPNUKpmc4r4slH2IUb5Bprad4xTEOSr3QUyid65MfpAuv9Q80P/6IhOsGn
	SabywMUbNvuIuCQIfJFRVLGp/ms1C47XO1KmZG3qiN7w0mYixMzC24YYfbL6YAgajjTIFfmx27e
	gkWj1IjPzpzGintOYyZPEIyY5e0EYRL66mGYc=
X-Google-Smtp-Source: AGHT+IH1SB6k0AoIpHs1QgMXDfWchgJ8uAEd6sDYAB2V3Ti9M2biGYW6sBZaYhSxBbUY7EdsjCAVwA==
X-Received: by 2002:a17:903:32d0:b0:270:e595:a440 with SMTP id d9443c01a7336-294deea9fe0mr23697295ad.25.1761733219623;
        Wed, 29 Oct 2025 03:20:19 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d39048sm146426775ad.66.2025.10.29.03.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:20:19 -0700 (PDT)
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
Subject: [PATCH v4 1/6] lib/base64: Add support for multiple variants
Date: Wed, 29 Oct 2025 18:20:12 +0800
Message-Id: <20251029102012.542970-1-409411716@gms.tku.edu.tw>
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Extend the base64 API to support multiple variants (standard, URL-safe,
and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes a
variant parameter and an option to control padding. Update NVMe auth
code to use the new interface with BASE64_STD.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 drivers/nvme/common/auth.c |  4 +--
 include/linux/base64.h     | 10 ++++--
 lib/base64.c               | 62 ++++++++++++++++++++++----------------
 3 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 91e273b89..5fecb53cb 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -178,7 +178,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 	if (!key)
 		return ERR_PTR(-ENOMEM);
 
-	key_len = base64_decode(secret, allocated_len, key->key);
+	key_len = base64_decode(secret, allocated_len, key->key, true, BASE64_STD);
 	if (key_len < 0) {
 		pr_debug("base64 key decoding error %d\n",
 			 key_len);
@@ -663,7 +663,7 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
 	if (ret)
 		goto out_free_digest;
 
-	ret = base64_encode(digest, digest_len, enc);
+	ret = base64_encode(digest, digest_len, enc, true, BASE64_STD);
 	if (ret < hmac_len) {
 		ret = -ENOKEY;
 		goto out_free_digest;
diff --git a/include/linux/base64.h b/include/linux/base64.h
index 660d4cb1e..a2c6c9222 100644
--- a/include/linux/base64.h
+++ b/include/linux/base64.h
@@ -8,9 +8,15 @@
 
 #include <linux/types.h>
 
+enum base64_variant {
+	BASE64_STD,       /* RFC 4648 (standard) */
+	BASE64_URLSAFE,   /* RFC 4648 (base64url) */
+	BASE64_IMAP,      /* RFC 3501 */
+};
+
 #define BASE64_CHARS(nbytes)   DIV_ROUND_UP((nbytes) * 4, 3)
 
-int base64_encode(const u8 *src, int len, char *dst);
-int base64_decode(const char *src, int len, u8 *dst);
+int base64_encode(const u8 *src, int len, char *dst, bool padding, enum base64_variant variant);
+int base64_decode(const char *src, int len, u8 *dst, bool padding, enum base64_variant variant);
 
 #endif /* _LINUX_BASE64_H */
diff --git a/lib/base64.c b/lib/base64.c
index b736a7a43..a7c20a8e8 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * base64.c - RFC4648-compliant base64 encoding
+ * base64.c - Base64 with support for multiple variants
  *
  * Copyright (c) 2020 Hannes Reinecke, SUSE
  *
  * Based on the base64url routines from fs/crypto/fname.c
- * (which are using the URL-safe base64 encoding),
- * modified to use the standard coding table from RFC4648 section 4.
+ * (which are using the URL-safe Base64 encoding),
+ * modified to support multiple Base64 variants.
  */
 
 #include <linux/kernel.h>
@@ -15,26 +15,31 @@
 #include <linux/string.h>
 #include <linux/base64.h>
 
-static const char base64_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+static const char base64_tables[][65] = {
+	[BASE64_STD] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
+	[BASE64_URLSAFE] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_",
+	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
+};
 
 /**
- * base64_encode() - base64-encode some binary data
+ * base64_encode() - Base64-encode some binary data
  * @src: the binary data to encode
  * @srclen: the length of @src in bytes
- * @dst: (output) the base64-encoded string.  Not NUL-terminated.
+ * @dst: (output) the Base64-encoded string.  Not NUL-terminated.
+ * @padding: whether to append '=' padding characters
+ * @variant: which base64 variant to use
  *
- * Encodes data using base64 encoding, i.e. the "Base 64 Encoding" specified
- * by RFC 4648, including the  '='-padding.
+ * Encodes data using the selected Base64 variant.
  *
- * Return: the length of the resulting base64-encoded string in bytes.
+ * Return: the length of the resulting Base64-encoded string in bytes.
  */
-int base64_encode(const u8 *src, int srclen, char *dst)
+int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
 {
 	u32 ac = 0;
 	int bits = 0;
 	int i;
 	char *cp = dst;
+	const char *base64_table = base64_tables[variant];
 
 	for (i = 0; i < srclen; i++) {
 		ac = (ac << 8) | src[i];
@@ -48,44 +53,49 @@ int base64_encode(const u8 *src, int srclen, char *dst)
 		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
 		bits -= 6;
 	}
-	while (bits < 0) {
-		*cp++ = '=';
-		bits += 2;
+	if (padding) {
+		while (bits < 0) {
+			*cp++ = '=';
+			bits += 2;
+		}
 	}
 	return cp - dst;
 }
 EXPORT_SYMBOL_GPL(base64_encode);
 
 /**
- * base64_decode() - base64-decode a string
+ * base64_decode() - Base64-decode a string
  * @src: the string to decode.  Doesn't need to be NUL-terminated.
  * @srclen: the length of @src in bytes
  * @dst: (output) the decoded binary data
+ * @padding: whether to append '=' padding characters
+ * @variant: which base64 variant to use
  *
- * Decodes a string using base64 encoding, i.e. the "Base 64 Encoding"
- * specified by RFC 4648, including the  '='-padding.
+ * Decodes a string using the selected Base64 variant.
  *
  * This implementation hasn't been optimized for performance.
  *
  * Return: the length of the resulting decoded binary data in bytes,
- *	   or -1 if the string isn't a valid base64 string.
+ *	   or -1 if the string isn't a valid Base64 string.
  */
-int base64_decode(const char *src, int srclen, u8 *dst)
+int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
 {
 	u32 ac = 0;
 	int bits = 0;
 	int i;
 	u8 *bp = dst;
+	const char *base64_table = base64_tables[variant];
 
 	for (i = 0; i < srclen; i++) {
 		const char *p = strchr(base64_table, src[i]);
-
-		if (src[i] == '=') {
-			ac = (ac << 6);
-			bits += 6;
-			if (bits >= 8)
-				bits -= 8;
-			continue;
+		if (padding) {
+			if (src[i] == '=') {
+				ac = (ac << 6);
+				bits += 6;
+				if (bits >= 8)
+					bits -= 8;
+				continue;
+			}
 		}
 		if (p == NULL || src[i] == 0)
 			return -1;
-- 
2.34.1


