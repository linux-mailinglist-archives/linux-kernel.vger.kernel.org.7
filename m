Return-Path: <linux-kernel+bounces-840978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1095BB5E28
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 06:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FDB19C4268
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 04:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0019C569;
	Fri,  3 Oct 2025 04:02:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628A8462
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759464125; cv=none; b=BKa3XK192fZaajLC4aKKIqCyoWBCA6WkPgJYqj4RAq2K99Dk2zZYYUrbg/3UuRfCQlpV65a5LVDk6kVMjuPLRRvzJbj6U58LXZI3wlKCVagroSgMxZFE6+O+ZvdLmXtD1a/FgYpLDOtW/a8BKuk8Y62jDUkx128V6zVYLW2ryiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759464125; c=relaxed/simple;
	bh=eyi055f9zXPCvaXXoQ2ojBXddaGqLeH3jVlBfjyN+TE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Uq9zp9jAIZaj0reWtreCZQTgafx8nYD7rsyIMeIaBfWMvJtf0yqhty9O4LSzlGY3CIQe87RCbSv4YyFb7rEuoAK6P7s2ZT6aYUSaGX8KZRsZUTtExQ4U0MtDTAfxKeU3BMa9VnuJ1XayjuaGHhg5HdR2ZXWbkE8yQYsKC42tRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42e6e5c1d04so34813415ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 21:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759464123; x=1760068923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eA2T6Z3vQ1MaQ7FLlqdD9xk83DLXf4X+FSzsvuhkvFk=;
        b=DPjsieacPFI9pDFk+kPkrYEZFqrvghlKb2pCSA6uzwo1Svb8CnX1m2aOpKmmNrTgPj
         3SaM+1veaVvQFzRtIckS7QQjyyPA1zZ+e08dZgmHiCb9E8IF/Zsk9TgoGZNbaYD5ii/b
         iMfqM66DNp53a1CxaHPUYyP5ZI+DvAR0iQAD4OmVSXWA/g4pwGJJlBirDE/dr3l6CcDL
         0m8HjdRhSyg+tk2I3PnVULYvfA/YHCU2UeyfrzzOnTIJRLInFjEFbrev2Y3MYJsgjDQo
         oZlnH30aNcTS32m2UC903UQC/8JxVUzG7n4Sd957fLRtrqO2NdKqNR4OcUUwrutdQG1M
         lc9Q==
X-Gm-Message-State: AOJu0YydR213tklN172mbhStvfMjQ0BbcqfK1BciZBi4mGP8Urrt7Wpn
	kooUL45v7Kkr5r1ZVWRT4FiKWg3H82qSizc+zVbKWi8vYvfSm72NA7pP6w/dr3NDkBkljmT5goU
	TfSSy/vNtUfMZW596PeUXP0/6J14/NoDviATItOyR7ex0coGqZUzcPxzP4FE=
X-Google-Smtp-Source: AGHT+IHoLoAYLkeFRVLP1tip/lx/1mTWCK/4agCjSJH5lZD+b6e8lEkGKeE1VICxGLibfAJvYGRzp2KDNI16vIFBYhW04FOkC2I9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcb:b0:42d:b5d0:1930 with SMTP id
 e9e14a558f8ab-42e7ad8400emr20204765ab.23.1759464122751; Thu, 02 Oct 2025
 21:02:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 21:02:02 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df4aba.050a0220.2c17c1.0016.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: reject inline data flag when i_extra_size is zero
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: reject inline data flag when i_extra_size is zero
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


