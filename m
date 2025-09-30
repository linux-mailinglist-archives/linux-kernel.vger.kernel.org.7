Return-Path: <linux-kernel+bounces-837549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E811FBAC8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AC8175E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416402F60B2;
	Tue, 30 Sep 2025 10:45:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B812F9C2A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229107; cv=none; b=RpYl4b4qGlhR3KIoHpSNlnjNkqe2DRQSnQ770uaYrxkAWs+riKacSPTE6TT6EBW/PCc0TVkWpXg3RyI+vvm7927doZaqfO7Cx6yuNY/0930JC3jiASXbt+ifH8mQiLve+EQTGClMwImmMRBnC/ejkxECKDOPdgpvoEqy37Fa8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229107; c=relaxed/simple;
	bh=YkbI4PjxwEB3oapyELQgLevKgLni5S4vSQedXnLPHIs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LIPh3etQAI7aplp9/iogbRjNkOM2lnC1iJDRBEm/0UIaR4S9pnXjXj238xYbCrkhskQkZxyfERlV5Gv+JlOHMGfrq9WbN+sdNhRmaB60yQPpYjBZfq3koaY7rhSubc4NOpzmy++yVqfvpo6YRBHlBuUrWJHd3DaCuYcrjoUuuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-91e1d4d0976so708583039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229104; x=1759833904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9u+1p3ug5V2HqeyMDDDkQaU0p3RZHN7kKwmeqGVHMo=;
        b=YMI4ZIHtvC1N+x0rZ265bgCOgk87HskGG+fvTy6AN+zjNSr6TgPxXl4wO/DSgayLwf
         6z6d9yGDsxlUtU0mlCr8wKOgCq89FmkHeUZavNvyCgadZjMghSgtqNDTe7UAoNI63A2k
         DZyWrtONo9sP4Kk2pSjO0rDO74oavJH7VxCB8CzIhjBYt2KYkRsr7NzobvpG51b/B+B+
         DqdX00KgZ6/xyKeb/VNSAdvEwcJRQa6nj2Y8Jl+ZtZ2ynYQdZSBeJm9KAGSNebnKQzTQ
         KXIfWWUk8W8rrmdO92AslznhmgZdHdVpN2YnzRQ3tRSlhWSp2V2tV0kJmdiaOGJqoNrY
         xvFw==
X-Gm-Message-State: AOJu0Yws/JwjI7ZFVO+07yA5ggXyFUy4r1sLOpMt6uAjl/Wcv6fj90hn
	+p1/Huv9HKFn4utTx+uZ8H57V0HIvUjfRefCfVfvCbTmEXpy3jNe+Ieuj5WgHnTpY1YvkZnTDrq
	hib/5ZUX8DTdkKEU1azVknpVsRKAvv8dZOKlbei9B05ru8ujMV7jHxG0oiS0=
X-Google-Smtp-Source: AGHT+IEGYwv5o59MEtMY14wtzxycOSJolxKv8fli5mYkSjMAHto6scpcS99604ylVEenEQRBMXh1FRVo+YgPzLCKnzpveUQDkD96
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc8:b0:428:76ec:b2ba with SMTP id
 e9e14a558f8ab-42876ecb4a2mr212184455ab.12.1759229104309; Tue, 30 Sep 2025
 03:45:04 -0700 (PDT)
Date: Tue, 30 Sep 2025 03:45:04 -0700
In-Reply-To: <68b95f81.a00a0220.eb3d.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dbb4b0.a70a0220.10c4b.0152.GAE@google.com>
Subject: Forwarded: [PATCH v4] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v4] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

syzbot reported a BUG_ON in ext4_es_cache_extent() when opening a verity
file on a corrupted ext4 filesystem mounted without a journal.

The issue is that the filesystem has an inode with both the INLINE_DATA
and EXTENTS flags set:

    EXT4-fs error (device loop0): ext4_cache_extents:545: inode #15:
    comm syz.0.17: corrupted extent tree: lblk 0 < prev 66

Investigation revealed that the inode has both flags set:
    DEBUG: inode 15 - flag=1, i_inline_off=164, has_inline=1, extents_flag=1

This is an invalid combination since an inode should have either:
- INLINE_DATA: data stored directly in the inode
- EXTENTS: data stored in extent-mapped blocks

Having both flags causes ext4_has_inline_data() to return true, skipping
extent tree validation in __ext4_iget(). The unvalidated out-of-order
extents then trigger a BUG_ON in ext4_es_cache_extent() due to integer
underflow when calculating hole sizes.

Fix this by detecting this invalid flag combination early in ext4_iget()
and rejecting the corrupted inode.

Reported-and-tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Suggested-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in v4:
- Move check to right after ext4_set_inode_flags() as suggested by Zhang Yi,
  since we're checking flags directly (not ext4_has_inline_data() return value)

Changes in v3:
- Fix code alignment and use existing function/line variables per Zhang Yi

Changes in v2:
- Instead of adding validation in ext4_find_extent(), detect the invalid
  INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
  Zhang Yi to avoid redundant checks in the extent lookup path
---
 fs/ext4/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..2fef378dbc97 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5348,6 +5348,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 	ei->i_flags = le32_to_cpu(raw_inode->i_flags);
 	ext4_set_inode_flags(inode, true);
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, function, line, 0,
+			"inode has both inline data and extents flags");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
 	inode->i_blocks = ext4_inode_blocks(raw_inode, ei);
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl_lo);
 	if (ext4_has_feature_64bit(sb))
-- 
2.43.0


