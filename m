Return-Path: <linux-kernel+bounces-884386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9BEC30124
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E7A462061
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5029A2BDC09;
	Tue,  4 Nov 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzJvYqoy"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352429AB11
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246005; cv=none; b=Pq7cZcyELNBeSGT+8Yv1Pkv2u7j3qEuFxEWap8q8Pwq4EIK5XIKkIka5u6z9zPI3uU3y8YGdpd2i5kOYb1aj3YXPl5nvdmyio295XMVZ75GSJ2owIxHdHl0qpwB+fsbqZnKHgaAQmUx7HAdG6RPNTg+9WfnIMPcZdybR0h2iJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246005; c=relaxed/simple;
	bh=Wf4TBrAOAA3IG3OdYDh0WfQE4U26yPFHYPSBa9u/sV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy8g4TkNwt1PCl1rjF/b4/jM0uzWkjBPaxIwqDZIb21lalletbBO3xYn8WbJ2TGphcqAxWaAIU0GAVotVwwWYLbp2wLqlW8qqc1u6n9mnVf9uWxlXlNiwp6tcM4GGEWdm2gKMVFAUXHbHerTrGhE8rNeLEmVVKEF7C9URNjzRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzJvYqoy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755a7652eso3360545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762246002; x=1762850802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK9/r+IfnFlfj3Kuw96HA2MKcOpR1Q7/bmqW3PPyDGM=;
        b=AzJvYqoyeZNEIZz1r1MyaKLevuSbekCCDfnYwRWFGsdf0CYUJIy2vQI7a9nXLBrdkU
         YNudemUToIqjeW/g7Q4nsq5TimuUXYeuxEhoP8ICyEh+OFKAGCpeFSA4TmRHZs0m7G+A
         buWLPQDZ7b1JwaLgShM6xVdgEhuziO8bai75iU4Xeurd5gAk18Qok/IgLLRvZX+sx0nd
         kE8Fu1ggrGTySSmgJ2n3QOwZQwiic7ulmWGYU9DXvAY8HSOIDWLUwX7xEoIOjPNrI7NX
         EuAra7gaDdxLjVWaAuRGhkrqJQhE5ChgB1QLJfUg5OQe9H+UYQ5JZ4QCdXfvdDILA/HX
         42vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246002; x=1762850802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK9/r+IfnFlfj3Kuw96HA2MKcOpR1Q7/bmqW3PPyDGM=;
        b=YXXySoSpSbYbMwbzNU66sr0cphOvVvGAxTf1+8vVfGYLVKELSdMUQ68w5U3G8HVQC5
         Pc7t/6UGA5xvjCwdP5h3vppOmXk+fynSxwZnc2HljxdOiN5ZUAM7kwWCEbQ1vdcma/GG
         kHRf/9ExHveBliTsd1Z4QEWWAgmlRi+66iBIzcQMBjBKKF3KLHLRoPyScQTexeYROrwT
         omFCnucK9cqDWGEhBXTCXVVdbiq2j6Cdab4bS3mkf9iSdbUg56qdTeyQmT08BwLsajWx
         6hXpO5DoEOZJWQU0bCuT0+euB/FPBiUoHrxIQM8UNn5Obqx8xwUrYL7pJTNEpfDZWVZq
         BWsA==
X-Gm-Message-State: AOJu0YyLsTJlGDMNfHhYgw2VNeewPpN9ru6KIYUvgFi1ua4GREkO6QMk
	cbKjY6bStoTbhuDmS4yTdc4Hs+QHBHDMZq9h8gtgg1lXyF53oKL+e0Os
X-Gm-Gg: ASbGncuAIjVaUA78K1FtwA6g27V9J86uftnyJgdWdRcDIjOi9EEuafKH2WjW/mlstGu
	afJSqy6sANYjBLrcSuhqS5OSFOmnWrtGvtHHvk/YWmbLDtZMiFI2V32uWKiTCr4aFrcRAD0c0hx
	Zh+8lw8O+KFoxfxIpMAqEuX4aXCONS1ZavyVfrbikJwy9DjswRCkJN5f2QkIpDEYDBcWyJzpnHG
	wbmpgAoJmpfI4zxMkqWf5mNYdmgDgSoPhVt2upiVdqVHKCQbH94aY8IhOmmkCA/k3PKoMIczM2O
	/7gUh5d2ZM9pyzLdd1BwJSw1xI/sz3Sjoga8iL6HijcMv/BZHwB8tYnJ6nr/aqWt2yQV6998hX8
	NrRSrXyARHA4HmLVgLgit76T0gihoOAN5PJPniV/4maZawMyLhYKAe5U37zbzU31x1YY2RRuzjU
	0xv2vlNwuWTt5zXsk6ef2aUw==
X-Google-Smtp-Source: AGHT+IGhgCX2NfeSdDb0gpSYu/I4DorVKH+J4uT9I1EZQvppI43csdNacLNGraQ9BsMWF4m2sbtX8Q==
X-Received: by 2002:a05:600d:4350:b0:477:3543:3a4a with SMTP id 5b1f17b1804b1-47735433f88mr92298435e9.2.1762246001456;
        Tue, 04 Nov 2025 00:46:41 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm200375535e9.13.2025.11.04.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:46:41 -0800 (PST)
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
Subject: [PATCH v3 2/2] f2fs: Add sanity checks before unlinking and loading  inodes
Date: Tue,  4 Nov 2025 10:46:20 +0200
Message-ID: <ef5cfc5cee26e34586e7415de41d865a360e0d98.1762184787.git.zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762184787.git.zlatistiv@gmail.com>
References: <cover.1762184787.git.zlatistiv@gmail.com>
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
 fs/f2fs/namei.c | 15 +++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..b808e1dc2ae7 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -294,6 +294,12 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 		return false;
 	}
 
+	if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
+		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	if (f2fs_has_extra_attr(inode)) {
 		if (!f2fs_sb_has_extra_attr(sbi)) {
 			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 40cf80fd9d9a..65af1d56a99e 100644
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
+	} else if (S_ISDIR(inode->i_mode) && unlikely(inode->i_nlink == 1)) {
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


