Return-Path: <linux-kernel+bounces-811536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1491AB52A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D511BC5835
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD2299944;
	Thu, 11 Sep 2025 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="TDK4leq3"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AB296BA9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576790; cv=none; b=jtNG7SnmBGKb02aHadxdpWX+yYPsxeDACjdAIFhVAakl9e0p4fJi+2PnsZYGPEYnBbzRiQmrGvHWyRKcpC+sXaOtjrxdt3kbCFbC/ixs6jCJRCxQ8Mq8Yow732CTYYmUHclllXbmgZX9fFfmkZ6lpl0Yt8t1Hx69GEMcWZoDcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576790; c=relaxed/simple;
	bh=hyrovsqb25GvOk5ch0SE10QIDXuqIsRkz/P2XEfDCm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oow/PojyGQrg6pIB+ZlEYssP+fHT6YEoS+Um9qHsLKzGDJ49D1riNX5NChKpQu51GVLUe/jjrXK1bKNMweeNc4UjMysfNbVKvm9bkyXqVlpgX7jA8lie70dvtpKD8L6/nfFaT1HVdVq9FOH+Jvua3F3sswgHKfe6Z5xp1GclA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=TDK4leq3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b523af71683so402931a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757576788; x=1758181588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o5UYWtgC17zidQRxgu3di44p2yuLDtqoBTP3KdD9qk=;
        b=TDK4leq3UlGV/qzuVwuOMXfh6wGfrcmPYnDlI+gt1yO9LJYLd5J86OM1yHMIosStXN
         QJVQRjBMCKcfr310lUmDDWlbCl0veaX7RPs1s630aPCwWRWnRebXEE5TLzCjnvWt9rto
         GnKHuEDVUJy8kOYs8oxSjJqS+WWkNBYALPglTcsryNg1jn/rFCi9Y4pV2WbeWX6dmey8
         Rlsfj3Ljc831tLj2taQWnrVtOQUtUQTo5YcwaeLFiPoNlrHvJw7ArM5y6PpWwCu7j/ZR
         ZrQH/V323u38WrV/1a2K6xwtN+TCuB2B0s9p+Jg26g3AMRwW4YHThbPPTfhTEvKMAl12
         rYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757576788; x=1758181588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/o5UYWtgC17zidQRxgu3di44p2yuLDtqoBTP3KdD9qk=;
        b=Jocn/3Hu7J611QOGQKTKDZw34l0ExOk3Q+YRp51PhnkuP3UzSDlAaADQe5mx1OQDoB
         Rr+qh59Ioq385ydYnIhzxj4aizNAR0Rgmlt+eYQ0LMGpPWgfSCjaWxoBkt8AT+JKk227
         rmHPs/Q6BHXsEk+7eEZtiRgc3aMaCzzmfdrPvfdJp+IxqDWVXMY8cjEBBRPVzbdtADn0
         y/x8LkF4kuC9zG670Zaq3kQlkOdcr1S37D2vNtKm2KTST6p+FSC44ns5qZ1HlTh7mZHh
         jeYDYAmkJHktuPLdTy0Xin46muP8DDkF+E9j9a+UU0ToIGKCGWTUe/Q+WZTR89h077Eq
         6dYA==
X-Forwarded-Encrypted: i=1; AJvYcCXyXSrYDwcDrkE6B1Z2Pd0RP2SpVAIg12zkrE18qERc7BWX4SKwMD2A4s68JnZsJPt4Y7020qlEKBstJ0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTfC8d1aWQTKl3LxdNNbJN0i4GWlgpgru3RG6S79oTmEhvPjTa
	6XH8O2AbwwsJvy/0ZawP76hpCdupi7T/oqrM7/zisELS3W2sE3r1b3zmzUih7J3X4PG90mnzxLc
	CSJ88qII=
X-Gm-Gg: ASbGncvxc3ScAmUxXF7GDbuEWQsYRTEZ8hDu6GjgSAkgSSkzYW58+ZlEczu7surgOn5
	lq4xz7g0xX5vX2jxiUTKXIHyrXGbCu+hk9DOrD1yehDO/McfFg2utOPy1cZngN1/f6rTLOjiIUN
	uKYi4wi4Jj9ArnnDFwuo0MWL61yqgunxsOdOFkK6u2aZImcniSkJmLMZjyNDWJSFti8e+LGUakL
	SLmaSPXUCjvqN98/rHy3wGDeDyntKgANFGwQJBmFOFQoMMdMKUI3CuXSZlsAUc/U1bHGdBjWV+M
	aMbYU3hUHPwZ/11Z2GZyBdWUf+4fdiyvKKLe+bvUYiCm9a0NgJLNe9yjVFa6O1zC7WsJhb+Ork1
	uO0+rBhM73YNu3KH8gfeQQAAh81HOhtOla61sKEEBuHeaacD7/+EhU4VGFejcn5qSFA5u
X-Google-Smtp-Source: AGHT+IHUrbIDUjSvWXWDJnw2/rvjU/6tI+i+eOkABLbPn89zVIkTMb70/fAZWJUo/N9Zo8PVFcB0yA==
X-Received: by 2002:a05:6a20:939d:b0:24a:8315:7e2 with SMTP id adf61e73a8af0-2533fab6295mr27158794637.20.1757576787693;
        Thu, 11 Sep 2025 00:46:27 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7811:c085:c184:85be])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47c47sm1152799b3a.35.2025.09.11.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:46:26 -0700 (PDT)
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
Subject: [PATCH v2 5/5] ceph: replace local base64 encode/decode with generic lib/base64 helpers
Date: Thu, 11 Sep 2025 15:46:17 +0800
Message-Id: <20250911074617.694704-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the local ceph_base64_encode and ceph_base64_decode functions and
replace their usage with the generic base64_encode and base64_decode
helpers from the kernel's lib/base64 library.

This eliminates redundant implementations in Ceph, reduces code
duplication, and leverages the optimized and well-maintained
standard base64 code within the kernel.

The change keeps the existing encoding table and disables padding,
ensuring no functional or format changes. At the same time, Ceph also
benefits from the optimized encoder/decoder: encoding performance
improves by ~2.7x and decoding by ~12-15x compared to the previous
local implementation.

Overall, this improves maintainability, consistency with other kernel
components, and runtime performance.

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 fs/ceph/crypto.c | 53 +++++-------------------------------------------
 fs/ceph/crypto.h |  6 ++----
 fs/ceph/dir.c    |  5 +++--
 fs/ceph/inode.c  |  2 +-
 4 files changed, 11 insertions(+), 55 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index cab722619..a3cb4ad99 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -21,53 +21,9 @@
  * used the base64 encoding defined for IMAP mailbox names (RFC 3501) instead,
  * which replaces '-' and '_' by '+' and ','.
  */
-static const char base64_table[65] =
+const char ceph_base64_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
 
-int ceph_base64_encode(const u8 *src, int srclen, char *dst)
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
-			*cp++ = base64_table[(ac >> bits) & 0x3f];
-		} while (bits >= 6);
-	}
-	if (bits)
-		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
-	return cp - dst;
-}
-
-int ceph_base64_decode(const char *src, int srclen, u8 *dst)
-{
-	u32 ac = 0;
-	int bits = 0;
-	int i;
-	u8 *bp = dst;
-
-	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64_table, src[i]);
-
-		if (p == NULL || src[i] == 0)
-			return -1;
-		ac = (ac << 6) | (p - base64_table);
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
 static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -316,7 +272,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 	}
 
 	/* base64 encode the encrypted name */
-	elen = ceph_base64_encode(cryptbuf, len, p);
+	elen = base64_encode(cryptbuf, len, p, false, ceph_base64_table);
 	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
@@ -410,7 +366,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			tname = &_tname;
 		}
 
-		declen = ceph_base64_decode(name, name_len, tname->name);
+		declen = base64_decode(name, name_len,
+				       tname->name, false, ceph_base64_table);
 		if (declen <= 0) {
 			ret = -EIO;
 			goto out;
@@ -424,7 +381,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 
 	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
 	if (!ret && (dir != fname->dir)) {
-		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
+		char tmp_buf[BASE64_CHARS(NAME_MAX)];
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
 				    oname->len, oname->name, dir->i_ino);
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 23612b2e9..c94da3818 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -8,6 +8,7 @@
 
 #include <crypto/sha2.h>
 #include <linux/fscrypt.h>
+#include <linux/base64.h>
 
 #define CEPH_FSCRYPT_BLOCK_SHIFT   12
 #define CEPH_FSCRYPT_BLOCK_SIZE    (_AC(1, UL) << CEPH_FSCRYPT_BLOCK_SHIFT)
@@ -89,10 +90,7 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
  */
 #define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
 
-#define CEPH_BASE64_CHARS(nbytes) DIV_ROUND_UP((nbytes) * 4, 3)
-
-int ceph_base64_encode(const u8 *src, int srclen, char *dst);
-int ceph_base64_decode(const char *src, int srclen, u8 *dst);
+extern const char ceph_base64_table[65];
 
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8478e7e75..830715988 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -998,13 +998,14 @@ static int prep_encrypted_symlink_target(struct ceph_mds_request *req,
 	if (err)
 		goto out;
 
-	req->r_path2 = kmalloc(CEPH_BASE64_CHARS(osd_link.len) + 1, GFP_KERNEL);
+	req->r_path2 = kmalloc(BASE64_CHARS(osd_link.len) + 1, GFP_KERNEL);
 	if (!req->r_path2) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	len = ceph_base64_encode(osd_link.name, osd_link.len, req->r_path2);
+	len = base64_encode(osd_link.name, osd_link.len,
+			    req->r_path2, false, ceph_base64_table);
 	req->r_path2[len] = '\0';
 out:
 	fscrypt_fname_free_buffer(&osd_link);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fc543075b..94b729ccc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -911,7 +911,7 @@ static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
 	if (!sym)
 		return -ENOMEM;
 
-	declen = ceph_base64_decode(encsym, enclen, sym);
+	declen = base64_decode(encsym, enclen, sym, false, ceph_base64_table);
 	if (declen < 0) {
 		pr_err_client(cl,
 			"can't decode symlink (%d). Content: %.*s\n",
-- 
2.34.1


