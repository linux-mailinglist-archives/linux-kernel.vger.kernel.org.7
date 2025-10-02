Return-Path: <linux-kernel+bounces-840857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ABBBB5969
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6284A18979B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC430274FCE;
	Thu,  2 Oct 2025 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Hffaai"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880539FD9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759446664; cv=none; b=nN4bLOhSIEjCfx3UAQDLZVny89rlds7nDr2w/XiRJllqzBzWR6FCpayj7SuznYDvuNsDrVXBcQKA400sOJvrtWMwS+PL+YDXsLmZviPx/z84RF9jcZ+XRSozp4Z0nUOavb5+reGE+Gi/PZJDbcibHhk3vboNKs6ARtEqZfA+QQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759446664; c=relaxed/simple;
	bh=05QBzRd86DhaBHC/HzFaLKts1U4K0ZRH0JC89nOeuak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPKmd+zfeHZb8jzKAXCyKJRqXfRXoA83oMHr35hG0cloSMfVGk5okQJrdxFd+/vFCum4HVk7AjiQXZId+E+ToE2brF7kWJPEgDtDJIlbq6QNOnrZ7Ybd+gomplgdU1zenwwqdBE8TWPHCZEmWNy7K/+a/TI6RhrFIrlHQEcR7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Hffaai; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b54dd647edcso1285486a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 16:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759446662; x=1760051462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFC69a6NBsLOPw5S/NgD9GIK97Ncfay1Ur+maFKsDH0=;
        b=j8Hffaai8x/QwsCo4UmjJtkbzT63gkStG3uzsDmggN1+B6GSoKyCISQ2dyJd1p41Rs
         7O+08/+jI0HBKPs3fy604HSKnTwNL4cFTwNyUnOhv2dl9nbwBu5F4MIoU8iVvjsXN/AG
         6itafzNpYIV6L6evpxRHBbLGBWs0UlRwhW/YMJg4vspwF9JuC8orGetUL5BcbVqojO2d
         HLGzzfaHG+8rbnoT+D71QCks3Lq564i258QYmD5rCLxGDPqb27syrc5bHYq51Hzdl5En
         mZoNw/Nu3zj4kMC3FEomhpC6PsODocQ2MtJp2BCPDFp2MgBiUjrINzTbiO4MlULdyFgv
         iDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759446662; x=1760051462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFC69a6NBsLOPw5S/NgD9GIK97Ncfay1Ur+maFKsDH0=;
        b=IZlNysZWU9jUyHLt/mp+z59BOHkAET0DnJ2KyzxFljY/s01EwRFibLRNpd9Kh0UH5E
         IgivhlomXehRvpGHYYVV5+99xl7GMeCj2x1Os8g4pV/NXA7i9nkhPggcJtSzhHDpwrzc
         3dyOEXVQ/9x8/92LJzqXAnQ+mvNNfnwXjI3DMK87Y/fM9kPj02IgPhF7Cr6BFoiX0C0o
         kcMm39LB0emEC5+QMLheSONvqdVlafFH1TI94jr9XZA0jMSH6nb50J6hTUOAG4D2h+7V
         R+pocx1Tk/vewqndDhx79PjYo3kylT1VmRxUN6ul/eQ2QRNhTbsWaypVDeUDOpTcX5wP
         Shfg==
X-Forwarded-Encrypted: i=1; AJvYcCXe+S20rvRjnTnxg2TWntg/bm4aiESowf9cnh+VkLAammC74fV/bYYsoUlaSl5+mMwEKupIObC/m7CddRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSsaP9sf1ykTJJcmwpRXgeHIePga10iAMNMMv2uIcXrWBZARK
	PuxByRqsNp67O6CJXWLhrVQ2h0Oi23a8I5UNU4XjJmKqVc83YE6SWR49
X-Gm-Gg: ASbGncttgjt9cDcZKeappb0oGcSEBpmkOo+q1X0jjR52rxS3Ql22EuL5c6qFz8l9ASM
	iswF0vBg2Xrw3zjwRWgp6d7sU0p8BW5KvSZDaka3hdmWCnHsRQJBgADS8i4FrjpclT4lgwpt5DA
	g2bQCW8dZIVM+/cvwQgfyXlCkK8m/EQzOO0m2LEIOiwlb0Md7msIaoeGSw7aOtlxybguyR4yqUi
	IrqiCQ4qtqWBoplA4sHg4Fs7/4vRICz7HGwWSay7wlmq22K9X2MJyt6jU/9uRYeIA2Q+hO8kMhb
	rZu81mClDdhlskdcC77jDcc+6zzaQoKlQP1wWZz1wRyqZx+HJ4qjKWUQAU+Cje5aknoyj8Syyyj
	JNOL/BLHshuL+rLMhRPwahnD5x4+8w5teqlRD9HCEs18ONZ9O3qx1
X-Google-Smtp-Source: AGHT+IGUOdKa1AKW2FKiv+nG8uiNpD1FAXt7j4+A8CLzObKcsOtjM7P0Sez7FihNRKz72nbVUzDMxQ==
X-Received: by 2002:a17:902:dad0:b0:24c:c8e7:60b5 with SMTP id d9443c01a7336-28e9a58b550mr11718715ad.16.1759446661851;
        Thu, 02 Oct 2025 16:11:01 -0700 (PDT)
Received: from fedora ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d111905sm31334655ad.24.2025.10.02.16.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:11:01 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: kent.overstreet@linux.dev
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7f176adb30b21606c5fc@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] bcachefs: fix use-after-free in bch2_dirent_to_text()
Date: Fri,  3 Oct 2025 04:40:33 +0530
Message-ID: <20251002231033.23810-1-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bounds checking before calculating pointer offsets in dirent name
accessor functions to prevent out-of-bounds memory access when
processing corrupted filesytem metadata.

When d_name_len contains a corrupted value, the pointer calculation
&d.v->d_cf_name_block.d_names[name_len] results in an offset far
outside the dirent structure, triggering KASAN use-after-free erors.

While bch2_dirent_validate() detects such corruption,
bch2_dirent_to_text() may still be called for debug output, so the
accessor functions must handle invalid data gracefully.

Fixes: c21f41f6905be4fc5059a10a5bba94105ba87269 ("bcachefs: bch2_dirent_to_text() shows casefolded dirents")
Reported-by: syzbot+7f176adb30b21606c5fc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f176adb30b21606c5fc
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 fs/bcachefs/dirent.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/bcachefs/dirent.c b/fs/bcachefs/dirent.c
index d198001838f3..8be31b41c32b 100644
--- a/fs/bcachefs/dirent.c
+++ b/fs/bcachefs/dirent.c
@@ -58,8 +58,16 @@ static unsigned bch2_dirent_name_bytes(struct bkey_s_c_dirent d)
 
 struct qstr bch2_dirent_get_name(struct bkey_s_c_dirent d)
 {
+	unsigned int name_len, max_len;
+
 	if (d.v->d_casefold) {
-		unsigned name_len = le16_to_cpu(d.v->d_cf_name_block.d_name_len);
+		name_len = le16_to_cpu(d.v->d_cf_name_block.d_name_len);
+		max_len = bkey_val_bytes(d.k) -
+			offsetof(struct bch_dirent, d_cf_name_block.d_names);
+
+		if (name_len > max_len)
+			return (struct qstr) QSTR_INIT(NULL, 0);
+
 		return (struct qstr) QSTR_INIT(&d.v->d_cf_name_block.d_names[0], name_len);
 	} else {
 		return (struct qstr) QSTR_INIT(d.v->d_name, bch2_dirent_name_bytes(d));
@@ -68,13 +76,19 @@ struct qstr bch2_dirent_get_name(struct bkey_s_c_dirent d)
 
 static struct qstr bch2_dirent_get_casefold_name(struct bkey_s_c_dirent d)
 {
-	if (d.v->d_casefold) {
-		unsigned name_len = le16_to_cpu(d.v->d_cf_name_block.d_name_len);
-		unsigned cf_name_len = le16_to_cpu(d.v->d_cf_name_block.d_cf_name_len);
-		return (struct qstr) QSTR_INIT(&d.v->d_cf_name_block.d_names[name_len], cf_name_len);
-	} else {
+	unsigned int name_len, cf_name_len, max_len;
+
+	if (!d.v->d_casefold)
 		return (struct qstr) QSTR_INIT(NULL, 0);
-	}
+
+	name_len = le16_to_cpu(d.v->d_cf_name_block.d_name_len);
+	cf_name_len = le16_to_cpu(d.v->d_cf_name_block.d_cf_name_len);
+	max_len = bkey_val_bytes(d.k) - offsetof(struct bch_dirent, d_cf_name_block.d_names);
+
+	if (name_len > max_len || cf_name_len > max_len || name_len + cf_name_len > max_len)
+		return (struct qstr) QSTR_INIT(NULL, 0);
+
+	return (struct qstr) QSTR_INIT(&d.v->d_cf_name_block.d_names[name_len], cf_name_len);
 }
 
 static inline struct qstr bch2_dirent_get_lookup_name(struct bkey_s_c_dirent d)
@@ -212,11 +226,18 @@ void bch2_dirent_to_text(struct printbuf *out, struct bch_fs *c, struct bkey_s_c
 	struct bkey_s_c_dirent d = bkey_s_c_to_dirent(k);
 	struct qstr d_name = bch2_dirent_get_name(d);
 
+	if (!d_name.name || !d_name.len) {
+		prt_str(out, "(invalid)");
+		return;
+	}
+
 	prt_printf(out, "%.*s", d_name.len, d_name.name);
 
 	if (d.v->d_casefold) {
-		struct qstr d_name = bch2_dirent_get_lookup_name(d);
-		prt_printf(out, " (casefold %.*s)", d_name.len, d_name.name);
+		struct qstr d_cf_name = bch2_dirent_get_lookup_name(d);
+
+		if (d_cf_name.name && d_cf_name.len)
+			prt_printf(out, " (casefold %.*s)", d_name.len, d_name.name);
 	}
 
 	prt_str(out, " ->");
-- 
2.51.0


