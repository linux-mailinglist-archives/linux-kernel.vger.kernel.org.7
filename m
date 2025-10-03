Return-Path: <linux-kernel+bounces-841354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA34BB7123
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5FA3A93A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6719DF66;
	Fri,  3 Oct 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/RJpGBQ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1C34BA50
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759499263; cv=none; b=A2jhYw4ebeNKYRhlsiS2vUfeGsKHGV53yAGbR4QQk0W59qfowAhPbi1yAbqOkRWLKY8WZX0CptHyvpajRQ2nXxC6rQTGUMHSiMpK+SDruOozPJO4BvDDCeaiFirnQbhpx3ipfEoKQS2DNH7J18WbijBZ5iNR5V4bA8hOApDpZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759499263; c=relaxed/simple;
	bh=B83U5Fb924a+CtxXo1Lus3OG+QNUvJeFsmwJTwagFxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pp0OxLy9dDYQE5huJ47wqD0xVvmuLIbfg8WOvxq4X4d8o76U3dCUGMIC9vyhKPep8KgYCOmt84Scf+rzz0Wnk6uqQlioh2XQpoCcK6Q7dPRrJr0QJt73oXUIgNBpbnhYLpEKhgfa2SLXM0BqWwhaAAScuGL8h+qbZJyPThiM2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/RJpGBQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6395172532fso1095193a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759499260; x=1760104060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXz1taGyCnsjIOklnSCeHrVpWlskjbKzfy7PmtERQsU=;
        b=H/RJpGBQ+GTn9k5Ndb9CPVnrqCrl+15pjPrP/k0BKMVasZUgpkC7MJJy/hCWT17N/Q
         f1RncssUSFWY1t7dAxhdGiBAbtMhmQeEugDgq4xMfZ27OeKUPBNTnKKi9/3ZcGkXoAR8
         VyrMKwQUJ+byCtLchxmbDDLar8/6tF3cSDzg18SP+A8a0C2AP8MRKYTUnCNAA9POFFOw
         pldaC8LBrlep9xitEVU0F6CCc1uN9TZOjtj2Gf4TIL0ULr1FwhBmdNid0wAqzSHTcGJk
         gg3/BKsVubCykFOgEuHo732+dsEI87zB05QCbpA8FBr7gotsGN/Ir98QLfyETonUkk6j
         weWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759499260; x=1760104060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXz1taGyCnsjIOklnSCeHrVpWlskjbKzfy7PmtERQsU=;
        b=I14YVPSjE5tDR08O6Ca8I6lqAdgQM0m8BD5/nuAkbZo6Drq6uC1kEf7nMS0taCRLEs
         a/xEOF+4CS3ZOtB40gZYuY68cr8IKUou7VMb17LN1RonElwUlMBsQ3nasO20uQKr3Bgd
         qDiIn4jgwb4c9cHsUb7rpbb6MOf65ci00c/V8Th8gfkwGvyW6m80hVGKodhN52y+T0OS
         z6lGodChKweGUQGSc5uRscTgOipdhLLzoBqZanWwGHVkMrVaVL5si1rXuQBK1OcxDdJV
         W7p3idcxP/5HdmJMYi+mmq01yNQsOLCoXvndrLGKzqFdcHOoRcM+haW4yzYgqV/uWcOF
         xyoA==
X-Gm-Message-State: AOJu0Yzq+z2zrDoCAl254RDjJjFg3uuSzZWKtttq+b3a0uSEwp9dN0Pt
	oDQMF25FUz92snQZkqJC3bDkk21FGqx8yOeSjcVwgTJw+WhL7NecUm/a8bQnEA==
X-Gm-Gg: ASbGnct2pxzKiZuDKMcOB++mdIRvlSdGHDQYkCJyH/UX3F6ujCa6+9D4PansakQM66b
	RZySIg3nO4NTE9BfmBY8W8uI82xOLNHcftxmyOD1l+v8WNTz7KFXxE7t8PfSuH/P67VmXfPp0gq
	wgwJWL3t/nVI+/AOTEtnq/pZkBIA3Mov+75A7ELlMcJX9M9EO8xctpjEHv9HS+gMWBOUfMwV5q3
	OzISSGe+RDu8Ukbm0jXGzSYlwon8pUGP+osswAoDHRrBWHBINlaUbXtDwuabT8I0NoHWE9BU8LC
	kEFyEB6dJBZoVMgu/m8sRzyTnF/emrxd3Dpvdw+0BJW9+Iqwj21IvEB9kxN6gNfNZSFpyQiBqE9
	JEAE8ErAbXaWyHH/Cq9UoNXlnZAypJA8LWIL87+jTWzo0B923TDDLBb8l22Y7nQQYazSkjd3uZA
	zSmfw/oERonZOUiw==
X-Google-Smtp-Source: AGHT+IGT22rMOS7zpkVXCQktJ+CXsz5d60nlco16amfiTaRrE8PNlBBx+BmcaTn1+GNMGJdxBxc5Uw==
X-Received: by 2002:a05:6402:5250:b0:62f:2afa:60e6 with SMTP id 4fb4d7f45d1cf-639346c8b7dmr3139059a12.7.1759499259990;
        Fri, 03 Oct 2025 06:47:39 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637881011e9sm4009560a12.25.2025.10.03.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:47:39 -0700 (PDT)
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
Subject: [PATCH] f2fs: Perform sanity check before unlinking directory inode
Date: Fri,  3 Oct 2025 16:47:31 +0300
Message-ID: <20251003134731.470392-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current i_nlink corruption check does not take into account
directory inodes which have one additional i_nlink for their "." entry.

Add additional check and a common corruption path.

Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
Fixes: 81edb983b3f5 ("f2fs: add check for deleted inode")
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 fs/f2fs/namei.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..68b33e8089b0 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -502,12 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 
-	if (inode->i_nlink == 0) {
+	if (unlikely(inode->i_nlink == 0)) {
 		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
 			  __func__, inode->i_ino);
-		err = -EFSCORRUPTED;
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
-		goto out_iput;
+		goto corrupted;
+	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
+			  __func__, inode->i_ino);
+		goto corrupted;
 	}
 
 	if (IS_ENCRYPTED(dir) &&
@@ -533,6 +535,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
 				ino, IS_ERR(new) ? PTR_ERR(new) : err);
 	return new;
+corrupted:
+	err = -EFSCORRUPTED;
+	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 out_iput:
 	iput(inode);
 out:
@@ -572,10 +577,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (unlikely(inode->i_nlink == 0)) {
 		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
 			  __func__, inode->i_ino);
-		err = -EFSCORRUPTED;
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
-		f2fs_folio_put(folio, false);
-		goto fail;
+		goto corrupted;
+	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
+			  __func__, inode->i_ino);
+		goto corrupted;
 	}
 
 	f2fs_balance_fs(sbi, true);
@@ -601,6 +607,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
+
+	goto fail;
+corrupted:
+	err = -EFSCORRUPTED;
+	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
+	f2fs_folio_put(folio, false);
 fail:
 	trace_f2fs_unlink_exit(inode, err);
 	return err;
-- 
2.51.0


