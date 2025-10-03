Return-Path: <linux-kernel+bounces-840972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0E5BB5D85
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 05:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE80134447E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 03:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F321386B4;
	Fri,  3 Oct 2025 03:16:39 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95E44A01
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759461399; cv=none; b=VUb6uRC8RjTva/Cy4hxaaYEkNuXd0mr/0Lvsis5W6D6GaEims1qxFdbA2uxYs/nQjl32wZ9xYn3H+XdreVfQ8p5C/zpQexFtcWNrKWN5v+9Nlbr0RRGveOnIR17WX86a2uZCGVHvDyC9tlr4CBLPzeNjTVOhU/ke+j4Iv0SweOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759461399; c=relaxed/simple;
	bh=NDRM+J9lKX33WXEMjOf9LqOMGSK46DWBIK5lKWB0k7o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pbEVUE1qHBChLSc1ZdUtfoAvsoJg+6xS5Deop42ollkinPl3vq2v2BMS7Y5E9IzaKdt5/ydZGPpxwdX2OeXMGkt3kz8i3JdqufQ+Sy/e2/MtX++yQm7PyNOGApq3VyQ0j5xLtCX6+gCT2UgOxpSDZ4bTlLUMfu3mZykhGBfQIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42575c5c876so20596655ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 20:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759461393; x=1760066193;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzsTwJgfq/2Y2E9BOjtYkmKVXp5nzlvk+b2UGHuqZjk=;
        b=Pwvj789woefwfqQ1AumZj1FPkiwjlvDskpKkWgyhlQYbG5MAnF5coGoH1ATtKvtWp+
         TzhGMl5nlA+LfdEYn0Iua7sT/WyCOuQZItEYK7uxjROI2xo1RHj5n3mqeeMMLMtAGP5X
         kuH+JaFrDD9n2KkfRX9eY9s0DRn0LSGleYq8WVKshrIEJoqkgcpC7EVD/6x4RCZFzy4P
         DgMPZCfNIkr3Avi0IYAp2yy+y+vY1S2O4FcawjDjpdX51YBhgDHZRApo2erv/FrLOgb1
         DI1Q3fUivFBIS0jw6/5052e8FBD71SBcVrlsl9VTRuHc1R0AGs1j/uNt2XSKyOyP1T6v
         2XuA==
X-Gm-Message-State: AOJu0YxGe+dLixVw9hzP3j2WZybJ7ZMQNh0me0mu3SKRXhwLlK822ja5
	Z+59ZkFqVY2Xf7SQC0/fls39JQ+8WnhnMKd6oevW3yiP11B0DgfAHuMPQ8yQBFnL/3hzMOOmdPK
	DAoGpqk2ruSDg+OS0LMEvQOAL+dtsjm7wchS/yrB9qNBaWAzfNe7aaEyLxwM=
X-Google-Smtp-Source: AGHT+IFzzXzEMUHWGosUbXS3KuR7pcpcNkxlUGDD6X5aHnXyRrJVepyJRW+ziolQlfi/grApj19om+CXh1WshlXQKvhoh5bbOgcU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1546:b0:40d:e7d8:63fa with SMTP id
 e9e14a558f8ab-42e7adca144mr17446405ab.26.1759461393079; Thu, 02 Oct 2025
 20:16:33 -0700 (PDT)
Date: Thu, 02 Oct 2025 20:16:33 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df4011.050a0220.1696c6.003d.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: reject inline data flag when i_extra_isize
 is zero
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: reject inline data flag when i_extra_isize is zero
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

 Prevent use-after-free in ext4_search_dir by rejecting inodes that claim to
 have inline data but have no extra inode space allocated. ext4 inline data is
 stored in the extra inode space beyond the standard 128-byte inode structure.
 This requires i_extra_isize to be non-zero to provide space for the
 system.data xattr that stores the inline directory entries or file data.
 However, a corrupted filesystem can craft an inode with both: - i_extra_isize
 == 0 (no extra space) - EXT4_INODE_INLINE_DATA flag set (claims to use extra
 space) This creates a fundamental inconsistency. When i_extra_isize is zero,
 ext4_iget() skips calling ext4_iget_extra_inode(), which means the inline
 xattr validation in check_xattrs() never runs. Later, when
 ext4_find_inline_entry() attempts to access the inline data, it reads
 unvalidated and potentially corrupt xattr structures, leading to
 out-of-bounds memory access and use-after-free. Fix this by validating in
 ext4_iget() that if an inode has the EXT4_INODE_INLINE_DATA flag set,
 i_extra_isize must be non-zero. This catches the corruption at inode load
 time before any inline data operations are attempted. 

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com 
Closes:https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397 
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
 fs/ext4/inline.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..d6541e661dfa 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1614,9 +1614,19 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 
 	if (ext4_get_inline_size(dir) == EXT4_MIN_INLINE_DATA_SIZE)
 		goto out;
-
+
 	inline_start = ext4_get_inline_xattr_pos(dir, &is.iloc);
 	inline_size = ext4_get_inline_size(dir) - EXT4_MIN_INLINE_DATA_SIZE;
+	void *inode_start = ext4_raw_inode(&is.iloc);
+	void *inode_end = inode_start + EXT4_INODE_SIZE(dir->i_sb);
+
+	if (inline_start < inode_start ||
+	    inline_start >= inode_end ||
+	    inline_start + inline_size > inode_end) {
+		 printk(KERN_WARNING "found error in ext4_find_inline_entry\n");
+		 ret = -EFSCORRUPTED;
+		goto out;
+	}
 
 	ret = ext4_search_dir(is.iloc.bh, inline_start, inline_size,
 			      dir, fname, 0, res_dir);
-- 
2.43.0


