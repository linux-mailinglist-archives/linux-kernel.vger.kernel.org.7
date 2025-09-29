Return-Path: <linux-kernel+bounces-836421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BB2BA9A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059F27A7B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA283009CA;
	Mon, 29 Sep 2025 14:41:00 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D5155A25
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156859; cv=none; b=gbbORk6FOsjTTEGskVKgqjBs31eBc7jgEO5wsdKpooc0YD5x7Y9n6n9cKH2EQnlW5fd6fxQcKJqiTxzm1uE6N/Qw4Dc6MaS7db4mdyaW5ss9CR6NGiup2G/4x246W8E/cQvirnHZ6GKgrzbh1zbZCsitu4poom+RIwGeoess3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156859; c=relaxed/simple;
	bh=1CRbODPK7ioT15EyYl7D+bsfUQaZM/OFVQCWP3ouOmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pZD8GUb/nYM0+FrkHAccmn/q6W73q7SJdBKAO5pF4BB46lJpuepg1nvjyDtEX0ZmIhBeNjrkndZMBcqe1GkpINXqEBnx8qtp8Dd7AOUwcn03A4FAagMfH58vahrZ8J7BP0ZdynsnDzpWbf/rlrRTlGTxPmLqqc7ZI1KRH/LJdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42af09092b9so37411035ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759156857; x=1759761657;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfzZ4Giby9AuuBEdLkByvfbmZudZADXVREZx6+m9Q6E=;
        b=CDXNyvpHLSdpgxBNwdIZQ8slKEMgSTqCG6HpzmDTssc7yOpbPPbLHYW/3ielzV/JVw
         x5nTS2ug5ohb/+lGJGR8N5hVV0jRaj2U+pBCQrwhU+E3W8O7/+B3Dul/1pjWJVplgTZ4
         XxAypDUW8cJAGd1O82lRwX/t9KnihU4emaMou5DWj9OqNpALBGzYcn85F1tVmMMUsZKK
         sxEJ8L7YGhTbyf+qGcR15V2EM5Tm9q3ii4NwndtE4AM+AhhIjYT6DiDjvSiBAdEeT3M7
         rCpqJ36CGW6Fc7htzhUpl7WMv0RCtrQGGAtDFDQdAg1AMlq/HSZnJJQsgfyO5YdfViyv
         TDbQ==
X-Gm-Message-State: AOJu0YzXpDMGGvumu4FNPY+kXmMZyJUzvuLiyVfEj6DAkXJWTV+uSs9m
	xjrRkSDKY9zBMJSkVS4EPOfyAe2zSwGD3uHtv2VVRINEdnY64pyLxj94Ef2QcX6/7kA272xa26K
	veWDVxKKUfj7AGFw7YsybbPAPLSmJ3Ir5fiGSV8L2d9ESyAnOUI4rBrJyQpg=
X-Google-Smtp-Source: AGHT+IHcHIykMVsO12AMolaZVmeyNe2XsY5kBmsyxSx2tz6JjHKCmdQnwMbURloU3kdOvR0ygCQ2ObgJMzEkVPMcUZ35xFoXUiSC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b44:b0:428:4a1b:b26a with SMTP id
 e9e14a558f8ab-4284a1bb314mr159423805ab.6.1759156857389; Mon, 29 Sep 2025
 07:40:57 -0700 (PDT)
Date: Mon, 29 Sep 2025 07:40:57 -0700
In-Reply-To: <68b95f81.a00a0220.eb3d.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68da9a79.050a0220.1696c6.0017.GAE@google.com>
Subject: Forwarded: [PATCH v2] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v2] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

syzbot reported a BUG_ON in ext4_es_cache_extent() when opening a verity
file on a corrupted ext4 filesystem mounted without a journal.

The issue is that the filesystem has an inode with both the INLINE_DATA
and EXTENTS flags set:

    EXT4-fs error (device loop0): ext4_cache_extents:545: inode #15:
    comm syz.0.17: corrupted extent tree: lblk 0 < prev 66

Investigation revealed that the inode has both flags set:
    DEBUG: inode 15 - flag=1, i_inline_off=164, has_inline=1

This is an invalid combination since an inode should have either:
- INLINE_DATA: data stored directly in the inode
- EXTENTS: data stored in extent-mapped blocks

Having both flags causes ext4_has_inline_data() to return true, skipping
extent tree validation in __ext4_iget(). The unvalidated out-of-order
extents then trigger a BUG_ON in ext4_es_cache_extent() due to integer
underflow when calculating hole sizes.

Fix this by detecting this invalid flag combination early in ext4_iget()
and rejecting the corrupted inode.

Reported-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Suggested-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Instead of adding validation in ext4_find_extent(), detect the invalid
  INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
  Zhang Yi to avoid redundant checks in the extent lookup path

 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..71fa3faa1475 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5445,6 +5445,15 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	ret = 0;
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, __func__, __LINE__, 0,
+			"inode has both inline data and extents flags");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
+
 	if (ei->i_file_acl &&
 	    !ext4_inode_block_valid(inode, ei->i_file_acl, 1)) {
 		ext4_error_inode(inode, function, line, 0,
-- 
2.43.0

