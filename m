Return-Path: <linux-kernel+bounces-833665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E7BA2974
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53DB4A2445
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE79427EFF7;
	Fri, 26 Sep 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="X1aLK2eW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872427E05B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869825; cv=none; b=MiNq5S/6HtsY+zLC57+FEoQbx880niEJW9lG7dfIuYnOEWW5SLdsktrkziN9ETsw9SbSsSSIquPBo5/Nv9bNZ2KNndsq2FjnjCwGKJk7XcVZbaovMmPJi1CIvBbK5HWvmDVLTHj+OBW3D/H5PFprZIn52vlbNeyWitW8DLh2Bqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869825; c=relaxed/simple;
	bh=OGjdQW2fPGuYQ5EHej/4NhFa8z1IHIEgYJSvEvOJ/h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NloLn2pHeP/oFPy7XO88ulhkmYafLoo6ALhpEgn9jyFvYVH0JxRIiGQEqWCz2JEliRdbAlbKn8TaeVnuZJLY5HpdZ1WdptNmBAD5RN9XJXBLDBfSS9JvaQMeaqhase1o2Pqc39HQRKw9u502w+CA+prpUt5fwqvWNFaW/bQb6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=X1aLK2eW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f605f22easo1644004b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1758869822; x=1759474622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX1AvjPYqPc07VyrXJLPNqN7Y76elCWsekCNrFr22Ew=;
        b=X1aLK2eWhl4PdjusXxGMjAFblRu51kKwaiLrZONuDCLo4V9OwHbVAEKHfbvJfT6N+Q
         AEzEI5VwGxMAwrlegVYHI3P9D9cciOJxwiU7bX+9X4NRR4xKWa6xm+FPGQtk9zKxtGB/
         XMYWvjv+9P9ckSu3ZmMpI33pQFz0LY71UJZu+iWo9pqtK6HIn6lYpIUrld5A/RwtYvQU
         bVk7daTOZaDCQRHYLX4kC6zDDI63e0Tb74Rw5aV4DCJhG09ynfbQaLNb+HETHx2JgPrk
         Hl5MpSe5jRKRcDnhOfZlHOypf15fWdxZfF+f+p4u4l9Ij1sz9UzNl1GRzZ9/OYXjb2MS
         Ja7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869822; x=1759474622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX1AvjPYqPc07VyrXJLPNqN7Y76elCWsekCNrFr22Ew=;
        b=l2vUReFBmeFFEhKqXMTRAF38cSvwME5j3hkanIwXjx0svoLxUeWlW1SCpxV7UXpKQX
         yauK6K/VdJ80eTttLMbBxpNzEy3xhCOzb/P7VDCVQSPVKR8owmGbE7EoxiHIfnubBNKq
         I6IK47sOSX8UVS1Xtdos5FJsZD/lc9nVc0UO9mFXjjnYJhplAE8WZa+y0p7JiiY9buHK
         l5EhHM1OfidLPELf+NDrxDFlX72qUYG/wXkqv3LZyldkRAQd7StS3yU7UEP9mkVGkuTr
         g/+ltxJPoX2iUTNz8QlMljxpN+Oe/OT4aPIY19u/nzIXeErHccyg1sP84Ux34njnHoP2
         pN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZldGr0W+CohcYVE4iuoPBhA41c9J24X6NXYoY8LECTovcO0QAj3+E4JRMf1aCB72gwn1T/cuDmOwoMZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5q8ffeD7bx6UtgiKF2ZQr6qK7MWzv2GXxY8zroQCzYMLfXWH
	en1uLSA9ymW/2LgMYBYVDOyzakRdE9F9UC3ScZcaA5pUJlEbrf0FIQx6S+ihTHgPBB0=
X-Gm-Gg: ASbGnctzTWEHOmvhtbpDKp+/b5LiHD7onrak+9KuBrqCawmpWakThanHU6xXFnUez0e
	kFuHiJxjRsZYafVywsvIVBrPC/NDdls7/34ULwiF06Pjr1BEF0+uCCbO2PMGoy9LyGvWibmBKxN
	vIDRIrfh+PFGOyWNzM6dNgLk0aFEcVbAmF3FqiAlPIMIset9CTCY+7g/olHhr10pLEcLeDZ5OWR
	pWE6D0Bx2shp42zblFNOosdKqkB5JZfEb9wSpubU+10jrXtL7WSCa9VVYE7VVlk6qCoxRRFdiKU
	bRt95/5AP5V+qc34XvL06fDNDQZAcfwPsnB6e4lFy4a+/gKkIwhscZ1kBS8DC9Xjt8Ok3ETD7VE
	55zD+KTZwx01+1qdOpDprqrVPNLsuib6P2gw4TqdM8delJPsT+xD3od0ifw==
X-Google-Smtp-Source: AGHT+IEJuoFu3AqWz+6Ia84gW9VhTEjnQyT1iUNvqk+U9XhDT4f46dcSlDiMFRq3zQJq5LoCWNwKLA==
X-Received: by 2002:a05:6a00:853:b0:772:3ea3:3218 with SMTP id d2e1a72fcca58-780fcec0a66mr5554818b3a.23.1758869822399;
        Thu, 25 Sep 2025 23:57:02 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:94ad:363a:4161:464c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c158fsm3654182b3a.24.2025.09.25.23.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:57:01 -0700 (PDT)
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
Subject: [PATCH v3 5/6] fscrypt: replace local base64url helpers with lib/base64
Date: Fri, 26 Sep 2025 14:56:56 +0800
Message-Id: <20250926065656.14522-1-409411716@gms.tku.edu.tw>
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

Replace the base64url encoding and decoding functions in fscrypt with the
generic base64_encode() and base64_decode() helpers from lib/base64.

This removes the custom implementation in fscrypt, reduces code
duplication, and relies on the shared Base64 implementation in lib.
The helpers preserve RFC 4648-compliant URL-safe Base64 encoding without
padding, so there are no functional changes.

This change also improves performance: encoding is about 2.7x faster and
decoding achieves 23-28x speedups compared to the previous implementation.

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
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


