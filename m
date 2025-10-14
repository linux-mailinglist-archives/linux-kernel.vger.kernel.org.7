Return-Path: <linux-kernel+bounces-852173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8EBD85A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B5C3A3AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC26B2E2EF0;
	Tue, 14 Oct 2025 09:06:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477329D27A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432765; cv=none; b=p84hE1FZZrfZMar9Hwg4XdCScxo7uwc5a5wyQcZ1GYlH9JqnBH4+sjGA0Z5uQzZC6jGnNJlf6sSkrOD+GiCC8g6S29Jr1/yGqe2Cs8KasQ8pmw1t16U5YqnftDqoGvcEpSYiWlfZ74nFDIv/C/WgqZPgecB68q2K0VG+J9x4/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432765; c=relaxed/simple;
	bh=ZJxq86MAaUc9nrpD/uVktL8KjBEiEbdh1BGy9uiLdRU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mzk+IvDrJnO7tJQ0NtXP27sDSjwbl/Ap0cQvFeZK+LVvbG1eF3soQ3H8bWDbazINpX1qcP6eFUpEptuUaotpQvBCzRpp0k6iSc70GzWkwJ4FnCvZaRmbwUSN5exuRj0eY9s45f9lM2Bp4AAcuHmlUqLIVjDeuKskrkyh1RA6KxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-930db3a16c1so2562213139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432763; x=1761037563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNlmuOhMa+ZX3ZEtBrVSHZ8REsWdNePdWG0/VYwfDWQ=;
        b=gZimBAj3trrXK3uiepOtw+V+aZFhV0OqllCVm3ZhwBakopHeaNLlaFpENtoktvjex9
         hGZFp2oKDwx+7EYTSC0NuHnThDAnhTFYmeFVM2pleJgdtx88Vh2KrRfbF7BL79h/ptsd
         1az67Vy6+e9NIYjHwkXk/YboXv/TvJ3e5Tq1X2r12MDj555mMKm0lc4YDuuP/A8OblpL
         Bm/QTzFeSN5XOpgnWkYisYanWyDc+zwLqyBiYvcrNqxWztDMZfg/Z9btQAQrdSN/UMaZ
         G4QQez0mjQHSN7tuH9gTjtbfqr3UFCnOcaCFp6MIJuNkgDlAnDlpTTPMcS6cKobmmQM4
         Sh7g==
X-Gm-Message-State: AOJu0YxYxmhaLKR8dlw+L6T8zFxGMzlY6I8QJVZKn+wq/rp6Y3dA8rY/
	Mxb5hIAoXhOoALfm5iYL6CmyEGLhkXAB0sh7KKD5O+Fj6jaYAxabBiwfl/+Nd33vkZhsUO2nPXk
	zNy6d0/jlb+ZuUai600qytoPxCpNlayTVnM9OYZdQ3ofuEFhupherVbcp/JU=
X-Google-Smtp-Source: AGHT+IEg+9nlogk3SWlcDtM7lHKmzZBZBgIoNoL1zg7Um+siEDwtg8Su0xIgRpvRk8Y7g/hduiia4TNeK/gFGjEz6KbgKSuiNaJn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2283:b0:42f:983e:e54d with SMTP id
 e9e14a558f8ab-42f983ee7famr200663965ab.4.1760432763002; Tue, 14 Oct 2025
 02:06:03 -0700 (PDT)
Date: Tue, 14 Oct 2025 02:06:02 -0700
In-Reply-To: <68ed7606.a70a0220.b3ac9.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee127a.050a0220.91a22.0201.GAE@google.com>
Subject: Forwarded: [PATCH] ntfs3: add debug warnings for run_lock initialization
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ntfs3: add debug warnings for run_lock initialization
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Add debug messages to track when run_lock is initialized for regular
files to help diagnose lockdep warnings.

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ntfs3/file.c  | 1 +
 fs/ntfs3/inode.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4c90ec2fa2ea..0eb218a2b999 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -773,6 +773,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
+	printk(KERN_WARNING "ntfs_setattr: testing by deepanshu \n");
 	struct inode *inode = d_inode(dentry);
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u32 ia_valid = attr->ia_valid;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3959f23c487a..e4ba37c3cf72 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -462,7 +462,11 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		if (ino != MFT_REC_MFT)
+		{
+			ntfs_warn(sb, "DEBUG: deepanshu  Read inode %lu, S_ISREG=%d, run_lock_init=%d",
+          ino, S_ISREG(mode), (ino != MFT_REC_MFT));
 			init_rwsem(&ni->file.run_lock);
+		}
 	} else if (S_ISCHR(mode) || S_ISBLK(mode) || S_ISFIFO(mode) ||
 		   S_ISSOCK(mode)) {
 		inode->i_op = &ntfs_special_inode_operations;
@@ -1180,6 +1184,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		      umode_t mode, dev_t dev, const char *symname, u32 size,
 		      struct ntfs_fnd *fnd)
 {
+	//ntfs_warn(sb, "DEBUG: In inodde function");
 	int err;
 	struct super_block *sb = dir->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -1604,6 +1609,8 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		init_rwsem(&ni->file.run_lock);
+		ntfs_warn(sb, "DEBUG: Created regular file inode %lu, run_lock initialized", 
+              inode->i_ino);
 	} else {
 		inode->i_op = &ntfs_special_inode_operations;
 		init_special_inode(inode, mode, dev);
-- 
2.43.0


