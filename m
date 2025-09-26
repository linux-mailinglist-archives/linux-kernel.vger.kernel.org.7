Return-Path: <linux-kernel+bounces-833666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43779BA297D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84041B27FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3427FB2B;
	Fri, 26 Sep 2025 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="WDwJuxmo"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F227E054
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869840; cv=none; b=Fkmk7Zib2OGfDtaCInpUD1x7ANwbWpIkoB/EUZRkg8TTIq5rJO2BhGlarSGqIEPqFm8tzVORKMkJLEmxe89L6NPIYcxbZKXYHw8gewGo1UHXhf3rIpxtVv3Fq5GButm1YwsFT7q/RVFv3am30DVK+vpp3QcjiGf4JjSqyQu66Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869840; c=relaxed/simple;
	bh=CAGiyfQcjLEBYWF2D4ZxF9et3ubh52B6JUIxa3MQPOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MTTVwr0hPBjfMxRWoRrGsD1ZKBrOB2HZr9eFvrGtSjNicWzfo2b+vgs2xM5LfZL1w+0c9Iuiz8aBRDDdYhmGRKY8o6FxADs9ukFnE2vConY01ifJEHNCnX/3bN5V+fkVu8rS35IqlBWNGoEzNxwecHdJjieJaj7mMjKj0Kpy4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=WDwJuxmo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-25669596921so19293805ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1758869838; x=1759474638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igTUGl2eyyaTZ+rlOxfJOLC6Xg0h3npTvJ/qhTpvyus=;
        b=WDwJuxmo7sZV6UeYvTdAuoixPueN8JpadMvfPxPBNvCOZnRtc41bdbocBNU+eQIOkL
         FnNZVExPj3qdXhh7oCw3jyk0QUYeqJpCQgDyqWLwnomGBeTHT9cBvcO+jisXORiviAs0
         FrFAA3GXWxi/cIDQPZb5w2R4XXjnJCrlu3JJXSrZXDk4nb8XZ34Ek3ebybJuX7/XZxm1
         GmVMeRqHj1SqhghJjZnj7IA+RUe5bqNbnM4Zmk4+57JqfSXoVSKOtixxelPAEBLlVai4
         a3zg3yUtwjr6nBeFbrnqGSRhaISdHwnEsbl+WJdLMKn4vEPi89vdLo+IrMcJ8gKz0vWJ
         7aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869838; x=1759474638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igTUGl2eyyaTZ+rlOxfJOLC6Xg0h3npTvJ/qhTpvyus=;
        b=Ba0VQQ1z5PUsQn9dcfa8M0Cw6Q6R/4mfkDgsHXsnl7fbcOBKOL1MzINSOIOTnCyzRp
         Uv5PEijhcCXm/yrQ0O6M1AIu94OwOb0VZkwl1RaQ3Cr0H3aZm/NKKP5P20in3+PpqQEd
         3p5PGa9LtOOn/VXPHjjnrd2S7q62g4dQjjyH0/QcNeyXhJGveCNDlPlVJ4xOl4JZ+iPk
         /Hj84LgFBy+HcKonZ+a3iM2JM2TH3zQTbaezmFHqatDRqeI1jqndedrGsuEl/RmgZrOC
         NbR2XmquG0+9BFPr9Z5+lfR3zwvNnADwM69p5UFFgvAOu4CgOOAJMpsp12IzjAC2QofP
         3Fhw==
X-Forwarded-Encrypted: i=1; AJvYcCVA3FfdrYkPtMoaH3DjloBHA2HRveKSnoqylIcB+qjthY+KW+SBc98Iag8MjR5mbwV18YuAvndJBE5FiBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNWjBTU1slopQVGudhmeuu0rMnTeZYvaFpfKxisOsZZ31Z9XR
	N8vv7czYSnG7RelelLpduSdq1QR0MD7t9xr+nFCqSXzdLVR+FMFWvplGcL2agWwBz2k=
X-Gm-Gg: ASbGncs+aRBlQ22oBDC4Ov0hcn6nkkSr8qpKjW2+8NA5MIuiBOosGBDrDb/dNwEPhfB
	4vXX9xl2V4/+aFrb2S6bti/cUsFdrsVoxdvK8YdVaDi/Byw4PJYFi0oStuAkbd3S0xSzl6NcdAS
	8IJCY8XS0ebfLb/m/RfSuq/G/bl1kFDNm2+4Wf8AwoYnpufFQeqB6+9AYjEiPsgJEA4zqA5Ku2y
	Wdo62wDEaIDU7Sc1ZtJcsJcurS0Bvi7wZmPN0fk6V75uKA05bvmqNflgccM6Hx7N3VE6WVcWETG
	QZ1FS2z5ejPrndRDgIn6/Nb8XdLWGBBcfe441wDQcPCGcJHjIkRGT7UgCZ47c4bqX/8CrEgcCxv
	Hba8iVpR4WAYxbqsDlTddVHLcSZx1pMHX8CSN/LapnUFq2HI=
X-Google-Smtp-Source: AGHT+IGsJ29z77Si0Jc2Vb5pCBLTmliotaWTgWM2zePJsxVuTaOzYIGurW3Xrr0Nqo5g1PeamIKvSw==
X-Received: by 2002:a17:902:d54e:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-27ed4a0e8d9mr69217065ad.26.1758869838002;
        Thu, 25 Sep 2025 23:57:18 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:94ad:363a:4161:464c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed688238esm44612135ad.94.2025.09.25.23.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:57:17 -0700 (PDT)
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
Subject: [PATCH v3 6/6] ceph: replace local base64 helpers with lib/base64
Date: Fri, 26 Sep 2025 14:57:11 +0800
Message-Id: <20250926065711.14620-1-409411716@gms.tku.edu.tw>
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

Remove the ceph_base64_encode() and ceph_base64_decode() functions and
replace their usage with the generic base64_encode() and base64_decode()
helpers from lib/base64.

This eliminates the custom implementation in Ceph, reduces code
duplication, and relies on the shared Base64 code in lib.
The helpers preserve RFC 3501-compliant Base64 encoding without padding,
so there are no functional changes.

This change also improves performance: encoding is about 2.7x faster and
decoding achieves 23-28x speedups compared to the previous local
implementation.

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 fs/ceph/crypto.c | 60 ++++--------------------------------------------
 fs/ceph/crypto.h |  6 +----
 fs/ceph/dir.c    |  5 ++--
 fs/ceph/inode.c  |  2 +-
 4 files changed, 9 insertions(+), 64 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index cab722619..9bb0f320b 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -15,59 +15,6 @@
 #include "mds_client.h"
 #include "crypto.h"
 
-/*
- * The base64url encoding used by fscrypt includes the '_' character, which may
- * cause problems in snapshot names (which can not start with '_').  Thus, we
- * used the base64 encoding defined for IMAP mailbox names (RFC 3501) instead,
- * which replaces '-' and '_' by '+' and ','.
- */
-static const char base64_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
-
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
@@ -316,7 +263,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 	}
 
 	/* base64 encode the encrypted name */
-	elen = ceph_base64_encode(cryptbuf, len, p);
+	elen = base64_encode(cryptbuf, len, p, false, BASE64_IMAP);
 	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
@@ -410,7 +357,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			tname = &_tname;
 		}
 
-		declen = ceph_base64_decode(name, name_len, tname->name);
+		declen = base64_decode(name, name_len,
+				       tname->name, false, BASE64_IMAP);
 		if (declen <= 0) {
 			ret = -EIO;
 			goto out;
@@ -424,7 +372,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 
 	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
 	if (!ret && (dir != fname->dir)) {
-		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
+		char tmp_buf[BASE64_CHARS(NAME_MAX)];
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
 				    oname->len, oname->name, dir->i_ino);
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 23612b2e9..b748e2060 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -8,6 +8,7 @@
 
 #include <crypto/sha2.h>
 #include <linux/fscrypt.h>
+#include <linux/base64.h>
 
 #define CEPH_FSCRYPT_BLOCK_SHIFT   12
 #define CEPH_FSCRYPT_BLOCK_SIZE    (_AC(1, UL) << CEPH_FSCRYPT_BLOCK_SHIFT)
@@ -89,11 +90,6 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
  */
 #define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
 
-#define CEPH_BASE64_CHARS(nbytes) DIV_ROUND_UP((nbytes) * 4, 3)
-
-int ceph_base64_encode(const u8 *src, int srclen, char *dst);
-int ceph_base64_decode(const char *src, int srclen, u8 *dst);
-
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
 void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8478e7e75..25045d817 100644
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
+			    req->r_path2, false, BASE64_IMAP);
 	req->r_path2[len] = '\0';
 out:
 	fscrypt_fname_free_buffer(&osd_link);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fc543075b..d06fb76fc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -911,7 +911,7 @@ static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
 	if (!sym)
 		return -ENOMEM;
 
-	declen = ceph_base64_decode(encsym, enclen, sym);
+	declen = base64_decode(encsym, enclen, sym, false, BASE64_IMAP);
 	if (declen < 0) {
 		pr_err_client(cl,
 			"can't decode symlink (%d). Content: %.*s\n",
-- 
2.34.1


