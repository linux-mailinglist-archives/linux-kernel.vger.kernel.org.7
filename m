Return-Path: <linux-kernel+bounces-894639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E02C4B78B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E60C3A7C56
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D8D2E9757;
	Tue, 11 Nov 2025 04:40:12 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643E279798
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762836011; cv=none; b=ktyAY/1bwi7jlnLQWLIPF8nrRjpixRPI1ggeKx1SJO21v28qwIwZOMwnAmAa/du9TobxSg3j0vqFXmTemkqloyoshlX4wmCyP2o1qZWUvre0pcUqH4u6zqs9ieUggp5ZCxGUKVx288dH2kH1P8ylhDsZZ1GENKn/d4m0Y5LvTVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762836011; c=relaxed/simple;
	bh=vdayF+3d6HXv249GH/gRqyTyXlPXIpYE1NsxYOF3hLY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lH80hoUAQjau7KG4Kt3UG0HWx+woKVTJ2gKmJpNY8k4/vfHT5SmdPoRhO9q3NXJjhXE2FOCzqY009LQ/Ya6Q6t8od/7c8Bqd1gfcFl28e3bEOTaKiDBxl0hcUuFRyPADAaLPP1gigG+hL8nAZopzXmp5Wm7yHNRFFSOXX2Y7tK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433795a26c5so27811035ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762836008; x=1763440808;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsPGuUIaEQNYEB44ayWoLwLquEMwjCUynDD3zJ7UhBM=;
        b=M2+YUhWc3guOZNxfBNVAy6r7AkOYxmAF7Nwfr5MdzxLGd7l51QeF5fqAbwJygr9b7m
         dNFtm0rznFfDaf50UvBKZ5AXYyBPgPUlo+w57wbhWdxaqdrOxclC9PEoLKNJY25y1UfF
         GJi6NWGMCsgOUKmlGgRruweSqU5EBTtzE84GkjzEpj8F/yNisv86FnfXZqh7tlqi+O1d
         PXsQX88Ix/1Hb0MyYaSu83O+gW73qjE1k5nFnwfnwE3hZMRmDj/Mvj4uy3pNowMmXUay
         WJ6xPbbZn23qCxOqDrA3qE4hNW7QBOhIUQd4qApNQ/4+qd+r/j9WbK5Bs8DxQLrM+IVR
         PpaA==
X-Gm-Message-State: AOJu0Yz49rS728YqUeVbnemEmm6wKNT/1mSJChnc0EHljUOqAHuDqFWM
	Ot9iGXTgpw9syQ1S4U6hnoY5T7tNRmiNsX8xXI8y0i1cG84bkfU691ieNFhUQonPX9dCdaWvnIm
	y7BJ7lXwCAsIB7lEMYqYTXrDeQYCYEHA+ED+ErTq+HJfGazHR8Q/WqIwFcVw=
X-Google-Smtp-Source: AGHT+IGlGzjWodHIhyG6FFaPSiJxiBsEjwpFBy6oGOnsxVkKILXXVzP0Z8EV3tOhgRpAD+243JQXu4hs2eS2O3wYgIJTlqIV7zw1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3399:b0:433:7b82:3074 with SMTP id
 e9e14a558f8ab-4337b8232b3mr102047855ab.22.1762836008450; Mon, 10 Nov 2025
 20:40:08 -0800 (PST)
Date: Mon, 10 Nov 2025 20:40:08 -0800
In-Reply-To: <69122a59.a70a0220.22f260.00fc.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912be28.a70a0220.22f260.0125.GAE@google.com>
Subject: Forwarded: [PATCH] ocfs2: validate xattr header in ocfs2_validate_inode_block
From: syzbot <syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ocfs2: validate xattr header in ocfs2_validate_inode_block
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci

Add validation of inline xattr header fields when validating inode
blocks to catch corruption early before the inode is used by the
system. This prevents corrupted xattr counts from causing out-of-bounds
access and use-after-free bugs in xattr processing code.

The validation checks:
1. xattr_inline_size does not exceed block size
2. xattr_inline_size is large enough for header structure
3. xattr entry count does not exceed available space

This moves validation to the inode block validation stage, providing
comprehensive protection for all code paths that access inline xattrs.

Reported-by: syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ab0ad25088673470d2d9
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/inode.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..9d5342b8dbc6 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1458,6 +1458,47 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		     (unsigned long long)bh->b_blocknr);
 		goto bail;
 	}
+	if (di->i_dyn_features & cpu_to_le16(OCFS2_INLINE_XATTR_FL)) {
+		struct ocfs2_xattr_header *header;
+		u16 xattr_inline_size;
+		u16 xattr_count;
+		size_t max_entries;
+
+		xattr_inline_size = le16_to_cpu(di->i_xattr_inline_size);
+
+		/* Validate inline size is within block bounds */
+		if (xattr_inline_size > sb->s_blocksize) {
+			mlog(ML_ERROR,
+			     "xattr inline size %u exceeds block size %lu in inode %llu\n",
+			     xattr_inline_size, sb->s_blocksize,
+			     (unsigned long long)bh->b_blocknr);
+			goto bail;
+		}
+		/* If there's xattr data, validate it */
+		if (xattr_inline_size > 0) {
+			/* Must be at least big enough for header */
+			if (xattr_inline_size < sizeof(struct ocfs2_xattr_header)) {
+				mlog(ML_ERROR,
+				     "xattr inline size %u too small for header in inode %llu\n",
+				     xattr_inline_size,
+				     (unsigned long long)bh->b_blocknr);
+				goto bail;
+			}
+			header = (struct ocfs2_xattr_header *)
+				 ((void *)di + sb->s_blocksize - xattr_inline_size);
+			xattr_count = le16_to_cpu(header->xh_count);
+			max_entries = (xattr_inline_size -
+				       sizeof(struct ocfs2_xattr_header)) /
+				       sizeof(struct ocfs2_xattr_entry);
+			if (xattr_count > max_entries) {
+				mlog(ML_ERROR,
+				     "xattr count %u exceeds maximum %zu in inode %llu\n",
+				     xattr_count, max_entries,
+				     (unsigned long long)bh->b_blocknr);
+				goto bail;
+			}
+		}
+	}
 
 	/*
 	 * Errors after here are fatal.
-- 
2.43.0


