Return-Path: <linux-kernel+bounces-853957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B9BDD241
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F143AFF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7443830274C;
	Wed, 15 Oct 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be5TlGWf"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDC2727E2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513739; cv=none; b=BhyDs6+eQ/jTrCB/3GXw6W3p+fWFqwd/9onHl4XWHgnSiPU0JvaWsmb5tQ6LOXpDASFlvbBhbAeoGAMUB9H71MMhrY5b2i7Qi7auzXDOxT5csk6uFNSdrB/GGeWJ4VRnAEjtmdretX/GtFlcMp8pU6aynTO67lnjZsraQ88jOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513739; c=relaxed/simple;
	bh=LnoauIs/Y5iL+KDQ/07Df1ME8X2Pl/XSucIAsssERmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XQBaGd0dgMQskkhDOmBJsuZyVTiYAVd+FdCDWH1nJWOTmcFu0/ir4IJH7lvHiSBzMEAzmJGi2xFKNhrWRrnXdS+4PzSnLlYgpcGKHoADcXf055bKF/CvV9pS3av+98yGCDq4pZcF5kcS7V/E9A407ErRFr6lrSaB4oKEHYHAKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be5TlGWf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5672588b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760513737; x=1761118537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy/hEtN2/NVng990dfEXmt28WC9jcrITPTpGO9f9qcc=;
        b=Be5TlGWfnmct8iGqhZibLmBB8g3b9DVZgbFgyRhwZ8N4sVaOSiZr6xqCWUQWAubz+l
         IFzFvHm4jCOnavDkcSC3hqZVe+8ES7ysyBHjsHQbgq5i4E0DCnsPzVjplqviam/UO+8w
         zR6QH8P+QCL03hGThV2vdvqX579OC4o7oIIzHmAsc17xcRG27BKpBZZ9U2sI7QG8K64j
         iBVfgZGDwvwztHe6zUhebMV3Gro5QuZjJJSMi2KLdKx3Ufx+uz0MJij6bpI3k/Zhthjj
         6z+WzGPzxSoSJ02pNUcwq5CsLd2BOBPmFu1P7Vf7cxjaeZVQZ1FiiaZu+mCyO60ExLA0
         5+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760513737; x=1761118537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qy/hEtN2/NVng990dfEXmt28WC9jcrITPTpGO9f9qcc=;
        b=qHZ+yerWtdYmL788fJ/kvEU/FYxoN5zZss1xddeeFnd+rRmm15Qk3Rz0wB7AXkCUUM
         9KghTgCIC4C/0kC2k0fW7iNhUyBbqtBdXWhp+RR6f6SvAnJyFvpxX1V7hUnn8iqeeCEH
         T3xXKb8l3x7NL7r6w///UtMFA2q89cbRPP2L5koutxY5zO2+OLygI+2C2z/56EHc1wCe
         fgr6JGI8zQgSMTIpcSRaQnC3d33TodIHA6n/CDjzslv5A+obwIk4/h3RIVC7NFOlFGs9
         Xl9fD2SZbolctaNC57os3Iw3m0a0km5f+vy4MZlHBmzAS9uaYFJb1mX603i0rc+7S/ux
         38Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWgJCYWV7Tl6WxeDGLuSaf7chBN3ma9vNqsIaDzY9Z6l6tRnCcry2yHD8mxgFHRpW8m+qQ9DP4hKrlnFs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQVSv2j7/RGnx9dbAkEskuKE9Npf2nVk7kTaPXqAVweMYDBbF
	GaLjaA7dJPb2VssGPIUIa8mwsgHBI0R9ybvD+dNn4rwBorwWguo1wIrx
X-Gm-Gg: ASbGncsUhIzlllDMw47TlEI4S9LcMDtTRV82Z6GyJQXPiez4yDJL305CdYKBZKDxCRl
	7AaGchVkLRiiVVw+C7g35PFDE9xDcSbrDY6IRfkj0M5pFvX5VwRcEBazJ79qoVhAN9TpMS0ruSh
	Ceuajbrp+xwXpF8irhsB19q5QRjefsnLtcGlkYuiQdXg3sY9oB+eQbdVHebVWVrAho5FOhpEIjz
	qOqhhDob5oiVguf8BAuBvhn2FTLlRuke/VcRVwoLiu7hXR9RVeoUxOiOEqO0j2lCjcsABoNQ5Y8
	K9l0CXIBXLTbD/xp7ECIiwQ9lfmEAbZpRrEAMzjdvLSsAtFyhjbh4OLDUn2tg5n8LooVKNMq9KV
	4Ka1UZ7fe+3LNqZ1RyntAnCl6JVZlZlQ89u4Fmy2me4kkR2nFDg2wxviMihku7TRbrnIVV4TSnl
	ymRK4=
X-Google-Smtp-Source: AGHT+IF+RK8LeSZE9IM4y5bjGsIiBgBsDpf8u33EJSLe4TS7qsyy5ASweq3OAhEAIWPq0SLT82Tl8w==
X-Received: by 2002:a17:903:1aa5:b0:269:96db:94f with SMTP id d9443c01a7336-290273ffec4mr367735365ad.49.1760513737488;
        Wed, 15 Oct 2025 00:35:37 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f5840csm187216485ad.107.2025.10.15.00.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 00:35:37 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	pali@kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v4] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Wed, 15 Oct 2025 16:34:54 +0900
Message-Id: <20251015073454.1505099-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the len argument value passed to exfat_ioctl_set_volume_label()
from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds read
occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.

And because of the NLS_NAME_OVERLEN macro, another error occurs when
creating a file with a period at the end using utf8 and other iocharsets.

So to avoid this, you should remove the code that uses NLS_NAME_OVERLEN
macro and make the len argument value be the length of the label string,
but with a maximum length of FSLABEL_MAX - 1.

Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: d01579d590f7 ("exfat: Add support for FS_IOC_{GET,SET}FSLABEL")
Suggested-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/exfat_fs.h | 1 -
 fs/exfat/file.c     | 7 ++++---
 fs/exfat/namei.c    | 2 +-
 fs/exfat/nls.c      | 3 ---
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 329697c89d09..38210fb6901c 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -29,7 +29,6 @@ enum exfat_error_mode {
 enum {
 	NLS_NAME_NO_LOSSY =	0,	/* no lossy */
 	NLS_NAME_LOSSY =	1 << 0,	/* just detected incorrect filename(s) */
-	NLS_NAME_OVERLEN =	1 << 1,	/* the length is over than its limit */
 };
 
 #define EXFAT_HASH_BITS		8
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f246cf439588..adc37b4d7fc2 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -509,8 +509,8 @@ static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned long ar
 static int exfat_ioctl_set_volume_label(struct super_block *sb,
 					unsigned long arg)
 {
-	int ret = 0, lossy;
-	char label[FSLABEL_MAX];
+	int ret = 0, lossy, label_len;
+	char label[FSLABEL_MAX] = {0};
 	struct exfat_uni_name uniname;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -520,8 +520,9 @@ static int exfat_ioctl_set_volume_label(struct super_block *sb,
 		return -EFAULT;
 
 	memset(&uniname, 0, sizeof(uniname));
+	label_len = strnlen(label, FSLABEL_MAX - 1);
 	if (label[0]) {
-		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
+		ret = exfat_nls_to_utf16(sb, label, label_len,
 					 &uniname, &lossy);
 		if (ret < 0)
 			return ret;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 7eb9c67fd35f..a6426a52fd29 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -442,7 +442,7 @@ static int __exfat_resolve_path(struct inode *inode, const unsigned char *path,
 		return namelen; /* return error value */
 
 	if ((lossy && !lookup) || !namelen)
-		return (lossy & NLS_NAME_OVERLEN) ? -ENAMETOOLONG : -EINVAL;
+		return lossy ? -ENAMETOOLONG : -EINVAL;
 
 	return 0;
 }
diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..57db08a5271c 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,9 +616,6 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
-		lossy |= NLS_NAME_OVERLEN;
-
 	*uniname = '\0';
 	p_uniname->name_len = unilen;
 	p_uniname->name_hash = exfat_calc_chksum16(upname, unilen << 1, 0,
--

