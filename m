Return-Path: <linux-kernel+bounces-886346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A573EC354CC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF54F50B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F9E3101DD;
	Wed,  5 Nov 2025 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCfcqG/d"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6330FC35
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341003; cv=none; b=eUqT8JBAtCD4HZhgPnoWOinooPARE8mPfmE/lSer11H5P581w/n3uFaQA8jo9yCB8sv2fj64NZI5fMKyB729+uRV//e/b4vPH8AEAgAuLNKOe5KkQgh5IFskbXa9JYJ62oz2g02q+WVME/vq8hqr+8B2ApWfcOpHGOuDaSvNdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341003; c=relaxed/simple;
	bh=hstc0vY91gKGBMtCAdJ8eBxi8EGOtO55dsqiQicv5j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opyrZY5sudq44oLcStXNRxqvSeznWc+kdq6LA9xWYwtWh4boJ6IusX8xeH/+Q7AwHhdWJ7nXRHllhiqLYQ4cxzyiF8DjZai4hPPtOxGZY4fLq5RW1gn6svItvfBpF0219aP9AXqMT6IBXmTcZPV9RUKcnCdmMjf/JIiGFlhzpJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCfcqG/d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477549b3082so15451175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762341000; x=1762945800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSJdhsMEI+4YuimZ1hmkS4JUtetSOHWFOs9qPgUuN/8=;
        b=OCfcqG/dyw6a4BwCZi3A7751m9GT+KJpq8Ci0tE1nORIPO8wW6UCJxTdZnjIo4KnU4
         z44Je3zA5DWDmz8x0ivg8iIHRPcFjfhUosrcgasJ8TMMgtt2AIrLd8ucrtbjhvQKTHdN
         ua1bc7WJGzKLX1b3va4AgE437g5d9yd9Z+JFdW4jZv5itXYHKW36Xec8pbz50Ek1Q9QG
         KT4zXubWHvWcZY/Yw2JvKvEN0iaWTvRffEMwytW8xaUxnO+UfAz2juOG7PJLwuvTU54k
         1W01yHyXslrsXjO0YylOtf7LX+H95kNswvCeDrsiuMP1QYQIgQSx0FdBLDqHazGzswVP
         KmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341000; x=1762945800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSJdhsMEI+4YuimZ1hmkS4JUtetSOHWFOs9qPgUuN/8=;
        b=bEEgpTZPYkAjcuDz1ZARxsuahOPF5D4njzV/ELIwQaYwIdvw614tXn03aX3oxPz+99
         PrOOzn0FKWDkYwb8YAlcrByN/h5hzIy5FNlBsJXc5oqFe4UI76eUJLBGgGRw2BkAPKAs
         pPWJFiSqTecrfEQdVhld6KPC4tgE11ZzSTXnEwduvLyCtRgh12/UaM/ie3en6wdQvpBl
         Mh5JjyhmhDoRUFYBFNkHyAQsSjuSuWS011V0hq2jaFAviiNmZp8ThndlLcH0dzXmTe/h
         G8u/HSAQJondmlMDTQFgqMd5/dz8SeIcuhbcq7qCTH5BL2oAfaqYNaHHXb5gYANDed/Y
         rxxQ==
X-Gm-Message-State: AOJu0YyRs1uZ9P2GXFEjhy+iYnv/uvz3B5IqzZRvVHRP4n4kdZiiDp7t
	ga2PR77AlvXzfptTt7gpR2YMU8CCOCQq/EvN1Zqs7ps3fZ9yKqiF0404
X-Gm-Gg: ASbGncvY0sAw1PPNmif+JegNangQ2cnPxt8XrgrxCaKwI/iInSB42xjsu5ZQODCMfLX
	lItWFWAlrDGP1MTgsQAXclugmuiLUAAV4vsPNPcmxLtI2VFkl5ZI+TzDsxb/5d3uPFtqx5Y2sON
	LY7KSAnF4L3XBQ6qVOVtJC1LJ4y3vTbOJ9YS7laO1mcXVMhi+BfnsRqnDYuvgrf/v4Dql2NNMl2
	ma2Vvi7aZRYbHFPpZLaBYTqO19dk92bvy8M+Z73DwcbQBCCW85nAqUHGLEVBB8UVwbQJaRFABiQ
	C6O7zbnlH+oFHl6YGrZ2r3RiVmVbimvHrgkKvIG7ugLYYZevLDkcuom4//lUM5f/uOp4TzVCMRM
	GasloLvhdiY2RYnVETOZdFJ23Z7qjtAm52ZwfwFdOcFiqRjp801tucj26W9wBlWDGuuJDyNESdA
	fjVsqn+ClaIik=
X-Google-Smtp-Source: AGHT+IFgNrtalxzChmeyomCPGlCrqR2rqh01/vklcS8njZxeR/kapLNbNRzhAZqZQMVsHdryQdmTfA==
X-Received: by 2002:a05:600c:4583:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-4775cdc8ea6mr25282445e9.17.1762340999987;
        Wed, 05 Nov 2025 03:09:59 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c42adsm39728415e9.4.2025.11.05.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:09:58 -0800 (PST)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	khalid@kernel.org,
	stable@kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: [PATCH v4 2/2] f2fs: Add sanity checks before unlinking and loading  inodes
Date: Wed,  5 Nov 2025 13:09:43 +0200
Message-ID: <c56dfb1f6a27cd04a91d41a0448a26118c7cdc38.1762339963.git.zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762339963.git.zlatistiv@gmail.com>
References: <cover.1762339963.git.zlatistiv@gmail.com>
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

Additionally add the check for i_nlink == 1 in
sanity_check_inode in order to detect on-disk corruption early.

Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 fs/f2fs/inode.c |  6 ++++++
 fs/f2fs/namei.c | 17 ++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..e2405b79b3cc 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -294,6 +294,12 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 		return false;
 	}
 
+	if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
+		f2fs_warn(sbi, "%s: directory inode (ino=%lx) has a single i_nlink",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	if (f2fs_has_extra_attr(inode)) {
 		if (!f2fs_sb_has_extra_attr(sbi)) {
 			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 40cf80fd9d9a..849cfdc57b30 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -570,12 +570,13 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 
 	if (unlikely(inode->i_nlink == 0)) {
-		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has zero i_nlink",
 			  __func__, inode->i_ino);
-		err = -EFSCORRUPTED;
-		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
-		f2fs_folio_put(folio, false);
-		goto out;
+		goto corrupted;
+	} else if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
+		f2fs_warn(sbi, "%s: directory inode (ino=%lx) has a single i_nlink",
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
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	f2fs_folio_put(folio, false);
 out:
 	trace_f2fs_unlink_exit(inode, err);
 	return err;
-- 
2.51.0


