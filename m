Return-Path: <linux-kernel+bounces-840085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C51BB37E8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFC73B955C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770422FFDDD;
	Thu,  2 Oct 2025 09:38:19 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F62FC009
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397899; cv=none; b=JByQMyenXV4VohgL6uEZN+xaXwT7IEU4wIfbF6uD3NY/8jZ3HbufRQbc9IjyyPR/+1KdBYOQ3ZklmsfGzoVBabhv1ITnwbODIVfbSH0jg9Baq2W2M4INYX3FDvnOGOHPUepPBf3lqLG7QjzfaM7TvBm79U9LzyShcqew4kD7Qx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397899; c=relaxed/simple;
	bh=HKPDVe60nWjrhsjElIpXEvSYl7dOQOiA7miVlZRnTBA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PkXEAl2dV6G8FbmjizAehPZkLmrS7STQOMl0hI0lUtHz82Gc98Rdko6CSuM8OoWdc+XcDfZdrBFovmBqPU+31X8AJJ9Uva5bG35GyVwwKTXUATnR9DuQce1floi2nK9S91FbqGp+DZa4hd/EKdhK9KYBVZa86pwA5pE8HuV0wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8870219dce3so90495439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759397896; x=1760002696;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HwZ809iSXjYBVytDidQlBmS0s4ilCkfPUEpt3m+TfE=;
        b=oLsgC0d0yQzvBCW9sTMhmYM9ASCxg5FzTqKmdvBpPl6Notqjxfe3MdwYorSrYILy5S
         hCjyu/Qw4FDj1cuh2O9VKgRahQHGvF6/sYdsiMC0iODSbR/sDItG4CEr3Vk2QfsaLt/p
         JD2L0Dd9CD4UYQ07ia5ocIIXwfQn+pI3ozjCSU6HwzAs0cw09BLepVIjvRAJx67TLAs0
         zirCxuroQ8gjmOaJfJ+o/iWw5m3ACRApqC4rdH0JKEgsY74et8cL3JhPx6hX2VCMFYEt
         yKxlqrZrQRNKCet3oMuvRz/f5bkhDXRVZ/cVQr4kCG39D4UkrYeDg96F4+E1+mAPhKDc
         ZJig==
X-Gm-Message-State: AOJu0YwSG68qckAZ2vybLC+cBivy8AWnyO0cgLpZ6btdOxn1RxMMkKKf
	7hGW81YANemdfPiuNiAk9eH8yT217xCrhHh+BHiAQnO6OKVj10iF+Y8ahVWOgkHfJCFHjno18HE
	WbojRdV3XdCX3dLtijhrNhWKqCt7Z6S5QkdQx9KmwWf2l9bc7uYJ80OMq99o=
X-Google-Smtp-Source: AGHT+IET4c2Z0H2Bd9H1jU0atTVTq6El7RBi6y1VI+QFO+Kdcgrf3TZKxrw8qVifikE3iGTO+bXIecbdDLEaGFTR5hY0s95JEBKU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c1a:b0:92e:298e:eeac with SMTP id
 ca18e2360f4ac-937a75bcf17mr646327239f.2.1759397896310; Thu, 02 Oct 2025
 02:38:16 -0700 (PDT)
Date: Thu, 02 Oct 2025 02:38:16 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de4808.050a0220.25d7ab.0784.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: reject system.data xattr with external inode storage
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: reject system.data xattr with external inode storage
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Prevent use-after-free in ext4_search_dir by rejecting inline directory
xattr entries that claim to use external inode storage.

ext4 uses the system.data xattr to store inline directory entries
within the inode. When an inode has the EXT4_INODE_INLINE_DATA flag set,
the system.data xattr must use inline storage (e_value_inum == 0).

However, a corrupted filesystem can craft a system.data xattr entry with
e_value_inum != 0, creating an inconsistency. The existing validation in
check_xattrs() skips e_value_offs validation when e_value_inum != 0,
allowing a corrupt e_value_offs to pass through unchecked.

Later, when ext4_find_inline_entry() is called, ext4_get_inline_xattr_pos()
reads the corrupt e_value_offs and calculates an inline_start pointer that
can point outside the inode buffer, potentially into freed memory. When
ext4_search_dir() attempts to access this invalid pointer, it results in
a KASAN use-after-free.

Fix this by validating in check_xattrs() that if an inode has the inline
data flag set, the system.data xattr entry must have e_value_inum == 0.
This enforces the consistency between the inode flag and xattr storage
type, catching the corruption at validation time during inode load before
the corrupt pointer can be used.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/xattr.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8680f649ea7e..827f2b6175d0 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -195,7 +195,7 @@ check_xattrs(struct inode *inode, struct buffer_head *bh,
 	struct ext4_xattr_entry *e = entry;
 	int err = -EFSCORRUPTED;
 	char *err_str;
-
+	printk(KERN_WARNING "ext_check_xattrs: entered in function\n");
 	if (bh) {
 		if (BHDR(bh)->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC) ||
 		    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
@@ -251,12 +251,18 @@ check_xattrs(struct inode *inode, struct buffer_head *bh,
 			err_str = "invalid ea_ino";
 			goto errout;
 		}
-		if (entry->e_name_index == EXT4_XATTR_INDEX_SYSTEM &&
-		    entry->e_name_len == 4 &&
-	            !memcmp(entry->e_name,"data", 4) &&
-		    ea_ino != 0) {
+		if (ext4_has_inline_data(inode) && ea_ino != 0) {
 			err_str = "system.data xattr cannot use external inode storage";
-			goto errout;
+			goto errout;
+		}
+		if (entry->e_name_index == EXT4_XATTR_INDEX_SYSTEM &&
+			entry->e_name_len == 4 &&
+			!memcmp(entry->e_name, "data", 4)) {
+			printk(KERN_ERR "Found system.data xattr: ea_ino=%lu\n", ea_ino);
+			if (ext4_has_inline_data(inode) && ea_ino != 0) {
+				err_str = "system.data xattr cannot use external inode storage";
+				goto errout;
+			}
 		}
 		if (size > EXT4_XATTR_SIZE_MAX) {
 			err_str = "e_value size too large";
-- 
2.43.0


