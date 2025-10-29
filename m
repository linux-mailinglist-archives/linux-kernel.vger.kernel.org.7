Return-Path: <linux-kernel+bounces-875714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 150E5C19AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10C774FE919
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E722FFDEB;
	Wed, 29 Oct 2025 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="1SPYfW5y"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9A2FBE01
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733306; cv=none; b=at4mMfOx00P6WBC6REdVOkXs0MMBJKsqN3ZCDs4/MFs6E95PXe3xniGKkc4n9inh4Di8bzDER225lSUkxfob11z9cW6b0ll4KFyzqrxJqdYCYtF10iYOUEvus9PMH+WPNFxy8BFDcOGniZMcCIkemU/DAFBmIYypLze5o3lrK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733306; c=relaxed/simple;
	bh=SQqzGjAx1hI7hCbHqZs+c8TXQffbLrD+ZEO8KPw3bvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgMQZvDZNqP7cO/RSGuMwo8TtD2mi4XRH4RZKeNMAf5KXwxQn16SmwKUUbzZ82VL7j1uPepWeKgHWRbhd1nv43H+VE49+HQvbDueezGnfxOxepGrbu1Kuh+YFAQkQoORmnLkXG2JicXCgNqLCSl8d2H2FTsJOQC7pYEryrwVA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=1SPYfW5y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b550eff972eso4696831a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733304; x=1762338104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlnFareBsbb11YH09aBxV9jcp59svMC58VGTOIUCegI=;
        b=1SPYfW5yxKv7ED7XbKbJKAu/qqZIJiL1jZClPDQWkabPSqIdTYjT1LCvAOP4wMbBgp
         hw0FePBfHEgTcVJeHkvLohqZVWBdTz2nK8GxzPYnjaS18JAxz5ztAUA/A+Fyx7HeHjkD
         vDgKtEZxKmvADTR/28I+V+AEt+HuBGVdOeD/8E4+b6d5I281QZd8pMEMZlz0fGd9lHz7
         d1PiSHWOCOgHb79Vnd8tmTCZO1PorDwIx238JcRmoUwX55LTBkL+RTQ2on8IWkwaFo8J
         UWndWlpWno1LONAN48xzzs58zfLUQVEALbWXbvlJD/r9fHSeMZ6ibz3QOBwNE5eJ9GAQ
         XvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733304; x=1762338104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlnFareBsbb11YH09aBxV9jcp59svMC58VGTOIUCegI=;
        b=Yj8Za9bsxRi0ipNYIFxUP3tbfUeD01cqaQPOnFINges3MqqEugV0+X8ApGkAyWjCp8
         5wQLgiCYklhLFG8BBJt/Gd6NYFH9AlDQ5/gdkFLGBv0yvDiCEqUMWa4Qlo8w7YAc46/B
         umakdwpy9BUdFf2GV6YAPfzcTsFq4AuQAN+4MDHeLVbMWYE4olBz543koruOzp3EyWeI
         p0Dl2QBlTwekqENX+TCwz2suAJUs8GVlLstGxlclLr3+nGFmWS3C9gZ4xvXqmmitPwzB
         y/ih9euhWg+iUhr8pwRpxremSTSX+710hgsmaMvoLxPFSdXmF3PY/75yJ8WvnOtA3h2R
         R50g==
X-Forwarded-Encrypted: i=1; AJvYcCXnuaSJduYgq6Hn4yZgCl9BVhM7iWUnyGHhMnH/E2TZbnd1gUZGCR7CqdrK7OZnCmBahWU8wFQbIvxQSV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5rioiV2lw6MzN+Sp0QDx83RV44qEQN5bixdp339puB092BVe
	dlLA4AZdA6uWER+jRIBDsxAzx66lvM4WSY0g9eJiq1sq2dW8DnygQ8vJZ0XvHM7w/+0=
X-Gm-Gg: ASbGncuK47eits7ghnAunN1hKzOvmZzsZVgTJYbQAbAzeHtKxpp3su5D175n7OYjbZI
	AsKGXAmpj2EYOmjsSt3cM4w4ssWDmyUI1QO+uK4jcpi6MYYluxaLLmOmHSrtivSwxORGBMlEq3H
	y3kav9q5EQ4PaGluwyfTBMRTR1jculZIK2/Jmt+2A/Am1y2Po/2sggZOvhrhCcoHNWOQmc1SmKz
	y5gTGqOPgHSrRcGAtLH19h9NymJT/R8grPtRlcNhKOIPKcrfsOUfBt34FqpzMMLjpSi4LOcWOl9
	g3yVjZgCiRm124v242FZIHmREvfBmCkVzEmw+gaDzDTzx+aIGrHtJwKTJddUh4AV3sm04D/ApT4
	I+vAaoa39k5R8Tna6T2V73lcZnNiowA/Mr4GAQPsk6pz6goI+h6mr7sxP1vFBTTOjVKNRUSABzE
	RSMONjXRch5Yma16tAK6d65xUN
X-Google-Smtp-Source: AGHT+IGM6v5wwL0QkZAKN6UIiQju9YhkO8h6NCZdmJ7iG19cg1e2QNUJaBTWOg7ESy9etZho85VIOA==
X-Received: by 2002:a17:903:42cc:b0:275:81ca:2c5 with SMTP id d9443c01a7336-294def2fe9amr24144575ad.59.1761733304103;
        Wed, 29 Oct 2025 03:21:44 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4b17sm149959545ad.5.2025.10.29.03.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:21:43 -0700 (PDT)
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
Subject: [PATCH v4 5/6] fscrypt: replace local base64url helpers with lib/base64
Date: Wed, 29 Oct 2025 18:21:38 +0800
Message-Id: <20251029102138.543870-1-409411716@gms.tku.edu.tw>
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

Replace the base64url encoding and decoding functions in fscrypt with the
generic base64_encode() and base64_decode() helpers from lib/base64.

This removes the custom implementation in fscrypt, reduces code
duplication, and relies on the shared Base64 implementation in lib.
The helpers preserve RFC 4648-compliant URL-safe Base64 encoding without
padding, so there are no functional changes.

This change also improves performance: encoding is about 2.7x faster and
decoding achieves 43-52x speedups compared to the previous implementation.

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 fs/crypto/fname.c | 89 ++++-------------------------------------------
 1 file changed, 6 insertions(+), 83 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index f9f6713e1..dcf7cff70 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
+#include <linux/base64.h>
 
 #include "fscrypt_private.h"
 
@@ -72,7 +73,7 @@ struct fscrypt_nokey_name {
 
 /* Encoded size of max-size no-key name */
 #define FSCRYPT_NOKEY_NAME_MAX_ENCODED \
-		FSCRYPT_BASE64URL_CHARS(FSCRYPT_NOKEY_NAME_MAX)
+		BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX)
 
 static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
 {
@@ -163,84 +164,6 @@ static int fname_decrypt(const struct inode *inode,
 	return 0;
 }
 
-static const char base64url_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
-
-#define FSCRYPT_BASE64URL_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
-
-/**
- * fscrypt_base64url_encode() - base64url-encode some binary data
- * @src: the binary data to encode
- * @srclen: the length of @src in bytes
- * @dst: (output) the base64url-encoded string.  Not NUL-terminated.
- *
- * Encodes data using base64url encoding, i.e. the "Base 64 Encoding with URL
- * and Filename Safe Alphabet" specified by RFC 4648.  '='-padding isn't used,
- * as it's unneeded and not required by the RFC.  base64url is used instead of
- * base64 to avoid the '/' character, which isn't allowed in filenames.
- *
- * Return: the length of the resulting base64url-encoded string in bytes.
- *	   This will be equal to FSCRYPT_BASE64URL_CHARS(srclen).
- */
-static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
-{
-	u32 ac = 0;
-	int bits = 0;
-	int i;
-	char *cp = dst;
-
-	for (i = 0; i < srclen; i++) {
-		ac = (ac << 8) | src[i];
-		bits += 8;
-		do {
-			bits -= 6;
-			*cp++ = base64url_table[(ac >> bits) & 0x3f];
-		} while (bits >= 6);
-	}
-	if (bits)
-		*cp++ = base64url_table[(ac << (6 - bits)) & 0x3f];
-	return cp - dst;
-}
-
-/**
- * fscrypt_base64url_decode() - base64url-decode a string
- * @src: the string to decode.  Doesn't need to be NUL-terminated.
- * @srclen: the length of @src in bytes
- * @dst: (output) the decoded binary data
- *
- * Decodes a string using base64url encoding, i.e. the "Base 64 Encoding with
- * URL and Filename Safe Alphabet" specified by RFC 4648.  '='-padding isn't
- * accepted, nor are non-encoding characters such as whitespace.
- *
- * This implementation hasn't been optimized for performance.
- *
- * Return: the length of the resulting decoded binary data in bytes,
- *	   or -1 if the string isn't a valid base64url string.
- */
-static int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
-{
-	u32 ac = 0;
-	int bits = 0;
-	int i;
-	u8 *bp = dst;
-
-	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64url_table, src[i]);
-
-		if (p == NULL || src[i] == 0)
-			return -1;
-		ac = (ac << 6) | (p - base64url_table);
-		bits += 6;
-		if (bits >= 8) {
-			bits -= 8;
-			*bp++ = (u8)(ac >> bits);
-		}
-	}
-	if (ac & ((1 << bits) - 1))
-		return -1;
-	return bp - dst;
-}
-
 bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				    u32 orig_len, u32 max_len,
 				    u32 *encrypted_len_ret)
@@ -387,8 +310,8 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 		       nokey_name.sha256);
 		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
-	oname->len = fscrypt_base64url_encode((const u8 *)&nokey_name, size,
-					      oname->name);
+	oname->len = base64_encode((const u8 *)&nokey_name, size,
+				   oname->name, false, BASE64_URLSAFE);
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
@@ -467,8 +390,8 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	if (fname->crypto_buf.name == NULL)
 		return -ENOMEM;
 
-	ret = fscrypt_base64url_decode(iname->name, iname->len,
-				       fname->crypto_buf.name);
+	ret = base64_decode(iname->name, iname->len,
+			    fname->crypto_buf.name, false, BASE64_URLSAFE);
 	if (ret < (int)offsetof(struct fscrypt_nokey_name, bytes[1]) ||
 	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
 	     ret != FSCRYPT_NOKEY_NAME_MAX)) {
-- 
2.34.1


