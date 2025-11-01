Return-Path: <linux-kernel+bounces-881290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF3C27EB6
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF485189DC11
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DAE2F692D;
	Sat,  1 Nov 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEZn8VJ+"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C595285CA3
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762001830; cv=none; b=h6NgUZIEQeHDq9bza6LN/T3ooFRJNbqv0ft1/lZpXUPZp2Vjh4BU0QeoIQqJAZTSAtkGKoHTTF2WNWlgQTurRC5aRFi6lpOe1/4+kZCl+jNSBdWugNSnv5u4Nz1u++hRW+x9Wt7leZWIGnSGe/eKUQKsyrhmCbrj46mgjYQMsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762001830; c=relaxed/simple;
	bh=AsORuNq9QEoETuNPsp+K3BhhFHPTpvIBWJR3uME9i68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Birf6XjlMVKrFl5/J2js7gW3FRx2FwQdzSfrZLg55W0j9T0ZjUDjRkDuejag7y4CYnTxESJT5dd9PmnzFLWo37AWEJkW1ybPeeRMTUsV6oOFZ1mf2tpLcqwwyMP9da4G826lHhi+8EaKhHXOVd8tjtg/yp2NQX5tietal3zH4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEZn8VJ+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429c7e438a8so423899f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762001827; x=1762606627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWKdMEjFczqiSseno1SbcYTWU+7mZhr1wnVQJoT8m64=;
        b=UEZn8VJ+G8p4avmCCQ8/I/uACVDwKkLPHM7XTY5omCjCN1IO+1hQ/ALvHxXEDlENgb
         IilJnRwjdxOBK5Utx2LTDgEiMcHWXk8NaNuj33AHpbROTxNS/598JXqvxXsiZPlIznir
         jPpGOwK+qCRox7hNtG4J7HycYQ+KZnCXsznSYXWHE8128+KFf/kHgwxDiVcDH7Ppmi7U
         3F6QBYoD+OPij2keKcPbFGNqw4wr0e/2WwudktQr9YkUjdQ+azJ+tKgaql+ZKlOb2Wyy
         tSslNCJukfSe4kfe/am6szzruBBZGD+g+KjdSYA2bZogDy7amA8xLNlHAvc9p42etjil
         eZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762001827; x=1762606627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWKdMEjFczqiSseno1SbcYTWU+7mZhr1wnVQJoT8m64=;
        b=Jee+EkOQBMRnscT0Ue+Ujn6WOGHgwWII9f8Qomh/Qr6aXsM+ZUYi0+Oob9oPoRkoZS
         Orz7uJrknOL+iIGhXNqEk8gcn7ADarNasJgkAuq9XhTM+IEstK+9NaHdz5W/0gBeEA1m
         tAgRgwJZ9/MbjXWCnjemPKvQTtD3RNSRkGrlljystvqcaGrSNuuxnxHjaySLt3aHA6F4
         ND/uQQe/ws0BreVno4nDg7n0dQM9tM0gg/KSh+6SDU3r2H/eB+LUq/wrp7OM+M1Ngpwe
         dMzt9AaqX37dDF8kWBHOsgp1WTXtVVGi7sQE3928onTpwUT6oleHMqNcl0u6sekO3OkJ
         0gdQ==
X-Gm-Message-State: AOJu0YzIemJT2k96PPuUxFBlfroi8JqVNXM5nUwdYTUty4upN9Y06pI6
	mwz/HYmZrxaP44P1/Cs9hLTbqC8QZEYIV6JplBKPPbM0X0AzholpgK1I
X-Gm-Gg: ASbGncvQ33IoXdX1MDYBXDqSLWwjT7kBRE5ZGe06D3sC5TlhFeYVdWh/+xhaa/IcseS
	v8JlTpduNTDleY+Co07wHpQvqIwdPo/9Pc/306TDLjQ3MT+dNbqsenUrVlpx0VUcyx5B7+9qXGd
	JnH7eYy4NkxviMl+edb38l2Ws2HA8eJ4xOxQjhCIsJANq4meJc442CcPQSKckxXmoot2Sr21Tzq
	DZYDT/TMQHo5+RKXK4OGj6mmwOQVs/NiNQ2+/Sj4QmWY20Vs7zL5EsDq3vHerJgVNH5lUqo+FqH
	KlHhSiGAm7UYvZURIUwBgNonxx4bHxsOrcuu+LtDSSS4bPMyMFemr5FkPLapXqXxDPPqqJb6Yiz
	gAd6yd47xYNoJE0w4TqJSj8Jf2+vmJlWpGiX0TeJ0bqbZx4jU/aWSms6OXA3ujCNewZliiSTmIt
	c7nogcFIfqkFp4giwjGclx7svgmiJP8hoe
X-Google-Smtp-Source: AGHT+IHvGjk8Ah1Fx4qTSdPIY7y0Q5flgx6ul0HOMtKhPjD29is/NlNCRvL/ugm2YCTq2bo/oqsYFQ==
X-Received: by 2002:a05:6000:43c5:20b0:429:b857:6fb7 with SMTP id ffacd0b85a97d-429bd6ac095mr5276612f8f.52.1762001827234;
        Sat, 01 Nov 2025 05:57:07 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f2b5asm8827647f8f.40.2025.11.01.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:57:06 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	khalid@kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: [PATCH v2 2/2] f2fs: Add sanity checks before unlinking and loading  inodes
Date: Sat,  1 Nov 2025 14:56:16 +0200
Message-ID: <55522ef8f3424e563ff18a720c709dcb065091af.1761993022.git.zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761993022.git.zlatistiv@gmail.com>
References: <cover.1761993022.git.zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for inode->i_nlink == 1 for directories during unlink,
as their value is decremented twice, which can trigger a warning in
drop_nlink. In such case mark the filesystem as corrupted and return
from the function call with the relevant failure return value.

Additionally add the 2 checks for i_nlink == 0 and i_nlink == 1 in
sanity_check_inode in order to detect on-disk corruption early.

Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 fs/f2fs/inode.c | 10 ++++++++++
 fs/f2fs/namei.c | 15 +++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..089cbf3646f0 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -294,6 +294,16 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 		return false;
 	}
 
+	if (unlikely(inode->i_nlink == 0)) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
+			  __func__, inode->i_ino);
+		return false;
+	} else if (S_ISDIR(inode->i_mode) && inode->i_nlink == 1) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	if (f2fs_has_extra_attr(inode)) {
 		if (!f2fs_sb_has_extra_attr(sbi)) {
 			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 40cf80fd9d9a..d13077bad482 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -572,10 +572,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (unlikely(inode->i_nlink == 0)) {
 		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
 			  __func__, inode->i_ino);
-		err = -EFSCORRUPTED;
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
-		f2fs_folio_put(folio, false);
-		goto out;
+		goto corrupted;
+	} else if (S_ISDIR(inode->i_mode) && inode->i_nlink == 1) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
+			  __func__, inode->i_ino);
+		goto corrupted;
 	}
 
 	f2fs_balance_fs(sbi, true);
@@ -601,6 +602,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
+
+	goto out;
+corrupted:
+	err = -EFSCORRUPTED;
+	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+	f2fs_folio_put(folio, false);
 out:
 	trace_f2fs_unlink_exit(inode, err);
 	return err;
-- 
2.51.0


