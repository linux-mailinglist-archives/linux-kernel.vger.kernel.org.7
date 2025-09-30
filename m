Return-Path: <linux-kernel+bounces-837397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CCBAC3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B4144E212E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD252D3226;
	Tue, 30 Sep 2025 09:16:42 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56861279908
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223801; cv=none; b=hLIviwJpzB5f3mZydLKjucAY4SFjytCA3v5b/N1hM4FIFPaQ1bM9lkWe8m5u/F9ZivZf4MdAFqKpmYWlpdQRyGr6lvRDdX4DZTQWwACCCDob/OTLCQp+AbjoqgVjmnnYRJOHYp4eKsc5eqqoP9rfMy2I5ROcdRhXxzL0yChx4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223801; c=relaxed/simple;
	bh=8Hu8S7M6pdr0y9oKS5K4/59tm4V8kRm65zCvhUH/Jvo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AtJu6C9nO75PBIHBTVxRZMJVsN+kAzPPjQK1T7s3J60vVIAjSZifvptdUr0aIZBMb8uB7aX6GmCi3ihMFHiNA6BKz9fHZqfQwAnYFbe3DPXbwWUpCzyw/I9Xv8dczZ4NROUFMfW2X+p7dEe2dsdfiRpM+wKThNd5BfO6VG614aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42575c5c876so84450375ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759223799; x=1759828599;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjxlYsLRK/Y7/YvdN21EKZpewwalHCH+H3eI+DPnnG8=;
        b=vULR9ZtzXKeXYWdYifi9D11o40iSCF+2B1Oro7tKm/0HTGrOSI8mjMxWuVWN88GM8t
         r0yG/BiZNB5xvzVcTJ20QYkMtlp7/unyHGsfFMaBQFMs4+j409CHNPZ4iKq1hcuPeh9M
         MSBePF1e0M4FzrzxjXazk1b4Y21C5jRH0Rv0MIv5hQ2VDKQP3D3vQWpWcWOCHwzYiPzm
         T8uLnH1KShdDmkY8nseYC8G7C866p+xnr6z+tINC2SpAWW26ieQAqYwhfsjWjF6HJT4h
         +eNMrFPvzCy9y8BFcVakJXkswzoMgm91+vBlxTPmDi06osj8K057wQLMtKi+fXmTzoFp
         BTmA==
X-Gm-Message-State: AOJu0YzjJm5bbANC65W1T49keNtN5VwwHKV6iMMYTrNRMgDUwMbcgIUj
	wmw4fcJrnW8Kb3FGDai4YVuH+qIwpP5hwBo52vyODPXiEN223QMCxImpUiAy1YA3Uw0vTS18WnU
	5NuEQ5v8pQ3D15xnyDMZp/xi5JqVjIVSbICxTZai7EdCyx0CiB2y5QIOzKEw=
X-Google-Smtp-Source: AGHT+IE8SNnm3XdIOO41McQvqI5ZeCokBvlUeWh+gU5VbK916yyNgdMLNjx0NVacmOuVWcr2xEyE6RKgMcmO3u9jSK8e/jtCEtxh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca45:0:b0:429:5f74:3bad with SMTP id
 e9e14a558f8ab-4295f83a1c9mr146939545ab.30.1759223799479; Tue, 30 Sep 2025
 02:16:39 -0700 (PDT)
Date: Tue, 30 Sep 2025 02:16:39 -0700
In-Reply-To: <68b95f81.a00a0220.eb3d.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68db9ff7.a70a0220.10c4b.0133.GAE@google.com>
Subject: Forwarded: [PATCH v3] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v3] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
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
Changes in v3:
- Fix code alignment and use existing function/line variables per Zhang Yi
- Keep check after ret = 0 where all inode fields are initialized, as
  i_inline_off gets set during inode initialization after ext4_set_inode_flags()

Changes in v2:
- Instead of adding validation in ext4_find_extent(), detect the invalid
  INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
  Zhang Yi to avoid redundant checks in the extent lookup path
---
 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..5c97de5775c7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5445,6 +5445,15 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	ret = 0;
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, function, line, 0,
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


