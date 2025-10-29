Return-Path: <linux-kernel+bounces-875716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CBAC19AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC2E1A63FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685C326D73;
	Wed, 29 Oct 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="lzy/yyrT"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066130F7F5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733334; cv=none; b=QR3C6rBajnJNKODtCX/+XCK5tdzld8ZWKaRvqmeJdF1ndf2ITL9jhUDdwXj/dHx2KT4eCgSkUFaegr2NXM9M7Vx5RLroc84Qpp5Wc6sSJoG1zfpXkqx47In/sdYHTgYMXaey2U3qQ3qFBclZAC8BxybaeE0JQAHVdutrz33P+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733334; c=relaxed/simple;
	bh=Srjjbp+31jlTlDMVW5Yg8ROeMQuCxMFPaHceKuOPFLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MkeJzvLCDOhulmKa8XbAlI349wKr+F8QA256NZyPjXIggraVCwDY5jk3FJ7m35gQ6Ps502nNutm132JoKaGW+AAzAXlcmnns4ZEqwIhWdtc8KRYNXlcoH9FBN851BCfnwpChpx0xKJsVjOe7s3IHfcaVz40gAl2bRe6ZcqMti4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=lzy/yyrT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781206cce18so998785b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733330; x=1762338130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExH2mWp+TtRat+/Z2Sn0K+6uHuJUKGnny14cPSnH5Oc=;
        b=lzy/yyrT9FLe1zQ8UtMVsNJvhDIQavjpAyiBS8iIuPG76xJ8lSqXTCyJhJxPsI2T3P
         2cJwRkHy9pVWkepe951CZ+8J9uAWvoZyWVxaWI/Y/zJo5vFp8k91RHm6WfwNwRIUyQ6D
         amPIfIrNi6d8GP2VAN2gi3w5HHRKw6J08n2BlJPEg+yHcPl6cUekazMlfwr/pTggwRjQ
         RmPjyjnFzPBm7CAVib6LFFWNe2TU5hTQ3AJdtXb7ODTP4n1F0ZRoNvY6VhOpIaLHbcnB
         BLOWT+xpxEPw5VwcDINM4EjJEfxVjixW7ZlqDKmmZSYM6Lo76Ol3mAMlmLAkIppd1EC6
         Te6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733330; x=1762338130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExH2mWp+TtRat+/Z2Sn0K+6uHuJUKGnny14cPSnH5Oc=;
        b=vM0jXGYePwkayTGuaWggCsrhbgLKPTkcols51UGmg3NLMb1fMluipTxGUU5uu2Ebvm
         ZtJUxzLSINlEiee1OtmdVme4KNff+uIRKMqHi2TCpxe77l/FyouMuk/H115j9clHgmka
         T7zliZpgDWst/9qAXA7HYUyceSYuPigzBZO0PulBqLLbXBZ97BQWlS5WlwWaxzERAx0k
         oQNPe2U3Tpdq3BcOhymVSFi82ViYHY/eBwQZX/rtQqNU3WmdhtTEn/hyFT2Xig02NFmo
         oZ4jcPavHxn3oWFX6yRVvTl9fFfF9GkS5m5ZbYic2Qry90H0JJIgXwU6ft8pwc16ZDid
         /Rig==
X-Forwarded-Encrypted: i=1; AJvYcCVJlv+P1sZRVzlIi4BewlQq9dMniJ6oQMIZ8ZC7GXyOcetRcdqL3+QucUU1Y/Gxq9UNxBhaGOmH0K+YbjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/aZK3QrtHDUFQUMvsVAz5QH/D+CO2rcmxaeGW7/jKDDUYa26c
	Q0AriC8wT96KrqiIkIVelA9lljXIHsQHNhrPFD7rPDoUlT9dmQ8BnZJFWJeYIng3lPI=
X-Gm-Gg: ASbGncuNWPzIYwOWholFuMGOhbCbxnNFvvTbILtipixf+u6M0y3O94cCTFWCV11jJsM
	mGeiDtt49EolV45JOrBDrtJ+3sWScFDXUvDcJDYAukSPHP3G7Rrgx1tCtAeRB3azIK56uz6+oKM
	PRKlGmh+/Z8WR1svR9Ks/BH2DlwKmEK0Ixu6MUyfMYCtNhKKkONsoYs/GA0mKozXKzc4EWiiu7b
	w3zxYD3z/xyE6aufKXFWCs8tNc0NBFdI4JlgqkoXvp/qYVG7PNYEJ4t0zDLsmE6YVY3TmEGjiVw
	6sF7pPMtnI4a0hZ4Z/ZjEO5EXOWFeheCcNHygtNncB7wKdeE9H5vxWBm2xH8YUbbXZEM4tE1pR3
	JfzLg6n15NmsC6Tu2vDVfj1NQ0Zk3KntyOow7XtgsVWvley217O1QmlDb5V0yz0Y8PKve6kNb+O
	4CqiB5XAxRI4YQ4TCbiaGhkj71
X-Google-Smtp-Source: AGHT+IEqYKX6PUZCvPQ43ID+NkdezuDDTSQSofgCTqlK+FDd2PcLeAZunAzA4UgtHlctwdsk1r5vIA==
X-Received: by 2002:a05:6a00:130f:b0:77f:43e6:ce65 with SMTP id d2e1a72fcca58-7a442cc2c03mr6912507b3a.0.1761733330060;
        Wed, 29 Oct 2025 03:22:10 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409f714sm14560993b3a.72.2025.10.29.03.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:22:09 -0700 (PDT)
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
Subject: [PATCH v4 6/6] ceph: replace local base64 helpers with lib/base64
Date: Wed, 29 Oct 2025 18:22:02 +0800
Message-Id: <20251029102202.544118-1-409411716@gms.tku.edu.tw>
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

Remove the ceph_base64_encode() and ceph_base64_decode() functions and
replace their usage with the generic base64_encode() and base64_decode()
helpers from lib/base64.

This eliminates the custom implementation in Ceph, reduces code
duplication, and relies on the shared Base64 code in lib.
The helpers preserve RFC 3501-compliant Base64 encoding without padding,
so there are no functional changes.

This change also improves performance: encoding is about 2.7x faster and
decoding achieves 43-52x speedups compared to the previous local
implementation.

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
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


