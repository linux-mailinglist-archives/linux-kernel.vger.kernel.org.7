Return-Path: <linux-kernel+bounces-838228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64375BAEBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE3D1757D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C134A2D1905;
	Tue, 30 Sep 2025 23:09:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BD46B5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273747; cv=none; b=S4HDsB9Bt42ikMU4zp00puVfTeLSDFpq6r/UWwULX+xu+zDZ92zFxb3zwBkLc+BTFZELc9u0kzdXaMDFDztUTq0hwmYoJWeYslj2phCj6w1V3uET7YevxmUc8ecYwhpimdDGjNoy5dv2bJFEg+Nbkpm5Q0bPMYip750arZGqCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273747; c=relaxed/simple;
	bh=5lDvcXIeGPUsv+AkTfO0s7bxyTTIOFgdjFN7AdwpZc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lTWgoCW9TV5it7nKz3WLFFuFEpd7Y/aCKr6UlN8MmOMqfiv7r5VjU15ojIhlizA5fhsgvnz2iP/C7zSKs8pgBTczrRj5hNSbVFK+Dyu1Oa1Dc2LSxHnVxA9h1SJw2k1eggddz3PGyVBgz8GFKx34RykTy8e22ARHYyA0l0K/Hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-927b19c5023so310002939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759273745; x=1759878545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYbSbQTb09OIs8pfghtWas1guMBAPPKIVZKsCmODl74=;
        b=OV0IXSSt2rb9YLBdide1vwZ+22Dz/eXduKWeB56muSXWcV77pfjRvth6E7XO1G6gMD
         QtvZjbXt+qbCw6tg/JTjqr1IyAJUt9GI6dfaFEsGfVh2vpJqdDdbJ/HmatPYAfIomlKv
         bpCdo0euKkORWeohn7bX7vdesq5IMRcdRgUy99cPjJ9WVEnhxBlyvLpDqY9yJ0yzy7yj
         yWDvSlFQov8zlMs5BxfY5ij9lCUaJRE9lnFXXf+E31ZIvBhLF/9MuhACCPmXGda9nQFa
         8c5Jgy/UbaZurVvDxP8teJv1dK1Z1PzBdH3N/6RmwIRMx3B9TPhkBPD03BFFsZqxwKOF
         40Ww==
X-Gm-Message-State: AOJu0YzWH7q9bKkb5hL1ZrmWAOiJX98dOnaP5bH7uyDhL4VnY4+xq5Ky
	B7qzARlMoO2hy15aUGcg6BQ/hDyrOj4LMsxzIuArpS11+5zDZFS5ybtIqF5f9FlHDSUeE94z+ve
	LI1f/hFU7c6D8kqkaezh8lnILlx84OhDyy3zns/uM5Hwd4W7bxVmdvWQAjvs=
X-Google-Smtp-Source: AGHT+IHPRdfy0Z2/rAc4fqDBQMarOIwjG9Qtwr1bEfswvY2DLLDGBU7IsSEu6EQYAp6wQ2Vfzp/azrwDRwWysbsUs0YhkCTvKTNT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:3f6:5e71:1519 with SMTP id
 e9e14a558f8ab-42d815aac14mr25011475ab.4.1759273744836; Tue, 30 Sep 2025
 16:09:04 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:09:04 -0700
In-Reply-To: <68335d8e.a70a0220.253bc2.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc6310.050a0220.25d7ab.0769.GAE@google.com>
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
index ca5499e9412b..ef3870afb8fb 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -930,7 +930,11 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	while (i) {
 		ext_debug(inode, "depth %d: num %d, max %d\n",
 			  ppos, le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
-
+		if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC) {
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
 
+	if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC) {
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
+	if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC) {
+		EXT4_ERROR_INODE(inode, "invalid extent header at depth %d", depth);
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 	/*
 	 * consistent leaf must not be empty;
 	 * this situation is possible, though, _during_ tree modification;
-- 
2.43.0


