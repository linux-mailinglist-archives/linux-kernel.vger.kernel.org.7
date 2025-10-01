Return-Path: <linux-kernel+bounces-838278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2BBAEDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C9C17C01E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5814C83;
	Wed,  1 Oct 2025 00:10:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941253C17
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759277428; cv=none; b=MMFx+ACn9FMLo7OMhG33r+LAaDFLVr3I15XPvkzgaOlCUx7rFpnvp2qKq67wW5GoHH5aWX+e+fTxabFD/XmHpeKHZeZAMvqGfMKb6UiZYGId+PLNAoJkzIkhsM/J2XlKIvZL1Vwxet/dinvWiMMiHq6KHLyvRnNW2mFHhlRCDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759277428; c=relaxed/simple;
	bh=TGTKyLufNOQ3H3ooF+m6a2mb4Vu5MXgrcwIQlGfTCWY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tIhPe+uX0ZfkeRf5oMeaYx5PAi3QnAFgf1TSs9XP13I0ndox/Haj04r9CD3KFlWv069VTll9ETIeTkXk+aVL7rlbkV5yX//bmX26en7IOcEoljdU8/ATax7MPJ/yFT54af51avI+iQ57HQ6w16taps6mNxhgIeWCESNljGw4DPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4297610aacaso49260535ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759277426; x=1759882226;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EH7mdCMD3QzQ+wDIVk8XqrGvENnZL/IOytWntk+pKGo=;
        b=JXXGWo5SXBVMRf6zopgCAlJJcu6mIUqbKeNoaOvCha4W3pRc69Jy6CjpsisuyoMjjL
         zh8q1PgM2RT/kdgD6zaQ6ADVzJbCfJEs+0+JC+JiJ+CgXD7AFwdYuULNksV9LU3JwXnv
         I5rNjrFNR44l+W8wH5r+PrO4aXtcSzhMcECOu/0X4pbzGXKAUF/AQfE6Bg2LrbTbmbMF
         OGbPvUTrRw8ux75VTdz99/HGchvVkbsfmdXDYvPEFSZkDDiarhvLf//PE1RpZAx2ugP5
         +nB1cD6Kp76Xr/qf3alRPdQQuqhsbYVJfOHg/83aZTQeDqswI48PSZIFb8rvwyILbFEX
         7f4w==
X-Gm-Message-State: AOJu0YzjVXG/SGZGBwc7bMxnUZJF6BhCphxV3G6yPdQccVAYrTsd/bja
	QASCT/IuIiX7iIVWPh9BcvB9pxUJ90Eiu4QO5TDscBkz6XSlafBfXhvn1Ma5azVDpmoqgeNHXHJ
	jIRFrMVfU3eaimCdlsmMCVjHp97zzMePfKdggkK7plK0qiY5vSA52yBmCpR8=
X-Google-Smtp-Source: AGHT+IE4IYmN5tJ/GqE46Z6vhm8KZFi897z5wSjD0U++NSALc4QvYX5b/RvB3/KFvQ4Pws8xl32+gIo+4p4gADo10Mzl7HK3CgPq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2492:b0:42d:8253:bdb8 with SMTP id
 e9e14a558f8ab-42d8253bf60mr13984295ab.13.1759277425603; Tue, 30 Sep 2025
 17:10:25 -0700 (PDT)
Date: Tue, 30 Sep 2025 17:10:25 -0700
In-Reply-To: <68335d8e.a70a0220.253bc2.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc7171.050a0220.25d7ab.076c.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: add validation checks for corrupted extent headers
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: add validation checks for corrupted extent headers
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


syzbot reported use-after-free bugs in extent tree operations, particularly
in ext4_ext_binsearch_idx() and ext4_ext_binsearch() called from
ext4_find_extent(), as well as crashes in ext4_ext_correct_indexes() and
ext4_ext_map_blocks().

The crashes occur when extent headers contain invalid data (wrong magic
number or freed memory). This can happen during concurrent operations on
the same inode where extent tree modifications lead to stale pointers.

Add validation checks at key points:
1. In ext4_find_extent(): validate extent headers before calling
   ext4_ext_binsearch_idx() and ext4_ext_binsearch()
2. In ext4_ext_correct_indexes(): validate path and depth before
   dereferencing path[depth]
3. In ext4_ext_map_blocks(): validate extent header after getting
   the path from ext4_find_extent()

These defensive checks prevent crashes from invalid extent headers,
though the root cause of the corruption needs further investigation.
The checks ensure the code fails gracefully with -EFSCORRUPTED rather
than crashing on invalid memory access.

Reported-by: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..fef9db80d65c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -930,7 +930,11 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	while (i) {
 		ext_debug(inode, "depth %d: num %d, max %d\n",
 			  ppos, le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
-
+		if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC || le16_to_cpu(eh->eh_entries) > le16_to_cpu(eh->eh_max)) {
+			EXT4_ERROR_INODE(inode, "invalid extent header before binsearch_idx");
+			ret = -EFSCORRUPTED;
+			goto err;
+		}
 		ext4_ext_binsearch_idx(inode, path + ppos, block);
 		path[ppos].p_block = ext4_idx_pblock(path[ppos].p_idx);
 		path[ppos].p_depth = i;
@@ -952,12 +956,17 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	path[ppos].p_ext = NULL;
 	path[ppos].p_idx = NULL;
 
+	if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC || le16_to_cpu(eh->eh_entries) > le16_to_cpu(eh->eh_max)) {
+		EXT4_ERROR_INODE(inode, "invalid extent header before binsearch");
+		ret = -EFSCORRUPTED;
+		goto err;
+	}
 	/* find extent */
 	ext4_ext_binsearch(inode, path + ppos, block);
 	/* if not an empty leaf */
 	if (path[ppos].p_ext)
 		path[ppos].p_block = ext4_ext_pblock(path[ppos].p_ext);
-
+
 	ext4_ext_show_path(inode, path);
 
 	return path;
@@ -1708,7 +1717,8 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 	struct ext4_extent *ex;
 	__le32 border;
 	int k, err = 0;
-
+	if (!path || depth < 0 || depth > EXT4_MAX_EXTENT_DEPTH)
+		return -EFSCORRUPTED;
 	eh = path[depth].p_hdr;
 	ex = path[depth].p_ext;
 
@@ -4200,6 +4210,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
+	struct ext4_extent_header *eh;
 
 	ext_debug(inode, "blocks %u/%u requested\n", map->m_lblk, map->m_len);
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -4212,7 +4223,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	}
 
 	depth = ext_depth(inode);
-
+	eh = path[depth].p_hdr;
+	if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC || le16_to_cpu(eh->eh_entries) > le16_to_cpu(eh->eh_max)) {
+		EXT4_ERROR_INODE(inode, "invalid extent header at depth %d", depth);
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 	/*
 	 * consistent leaf must not be empty;
 	 * this situation is possible, though, _during_ tree modification;
-- 
2.43.0


