Return-Path: <linux-kernel+bounces-894633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C2C4B758
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7F43B6523
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E2326F443;
	Tue, 11 Nov 2025 04:29:51 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96234D39B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762835390; cv=none; b=NSz0A4XjA8oGuVN5/ij2jwW7o940wOZxfGjY+HkOA0Qbl1StFyNn4GgAmXlrYOjFNbvHoaAbryNSPjI2AmS0XICYjioRYpajyH9gIB2WJ5AlpEdhVRUuq6xbwCgQ5S+Gh+jfcSn2rdSQ36NOp5RXcxygAqZXCk/niwKFar6gaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762835390; c=relaxed/simple;
	bh=cl2Wcb+YO7qxjJUUHZfkp8FQb+1q7+UxxFP9UKGkxWA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RWuFTTSlSN8d10ike1k3tFHoiyVrzRxAAraayleIj00mS0JNDIs3XGDtHpHjzh1mQSeP/VhDYSb2EMYLMw/ZPgPtj/7MxsPmUwWr6Tdsoe2z2cWcg8xXraMmtYd+s1yqTRkufcZLixpHD2S8cr7WEEa0EEOmzdljegaJGLKY5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4337853ffbbso27521025ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762835386; x=1763440186;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LM5P1DP+2J101/qr5C6YsI+Ey/EzCD01ubhDxN7YcrQ=;
        b=hwX52O/udLkRa9xEEkwYtcgGIFH04msZoUj8DOlQCBFFpwjs6GKsZQZLHRoml7iW+/
         IfBtEOF0AcS8fy9hbmCBZJqG8bRLK9aMNRusbC2QpCijSkkp2sJxRqGjM+RA+hufIaNq
         ckBJmyop4oisLkNyMwfZfuPf5o1wuWwlBuzIznaJW51+SFM+RQ4tZbTT3FVzzb7oio7p
         63KNu4Si38N6iPgyhdg0jQxOlnDv8B0D94/BDMjfJYaTx6IWqoaIGZPHMscIqSGyRdzT
         E+M7egsUGSPzYu/Ii3MI5ris50lWzuqRrbn7sCM/6c4s6cGfYGzk5+sIo/E6515s/Vv9
         qFLw==
X-Gm-Message-State: AOJu0YzIcYzUPsciGqKHCXYIUh1GBI31wrXLojHK/Cpxj7UcHG3Rt3dZ
	0Bp+ucdYveXMNVGNqY+t92s6f5aEhjZkMe/rwzRnsbTRBQbe8ZexKUR6tbkxf28B8cL23QBc138
	3EUNsVP5Rnu8CiR89sDz1f3o2/an6gQOXKDAv9sFIBU95CKMq1UMPsSl6tCI=
X-Google-Smtp-Source: AGHT+IH3SfSi2nCgxS6FcTGPYCWmMC8q1tlSVBpOF1h/FwRiL3YvSIJGCyZlQdVGhbQuR/VWEZfcNrFlLhmaAHUHNuMdLWiiURH4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318b:b0:433:23f0:1ebf with SMTP id
 e9e14a558f8ab-43367dd8574mr166942995ab.9.1762835386368; Mon, 10 Nov 2025
 20:29:46 -0800 (PST)
Date: Mon, 10 Nov 2025 20:29:46 -0800
In-Reply-To: <69122a59.a70a0220.22f260.00fc.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912bbba.a70a0220.22f260.0124.GAE@google.com>
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
 fs/ocfs2/xattr.c | 16 ++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

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
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index d70a20d29e3e..db352df00101 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -928,8 +928,21 @@ static int ocfs2_xattr_list_entries(struct inode *inode,
 	size_t result = 0;
 	int i, type, ret;
 	const char *name;
-
-	for (i = 0 ; i < le16_to_cpu(header->xh_count); i++) {
+	u16 count;
+	size_t max_entries;
+	struct super_block *sb = inode->i_sb;
+
+	count = le16_to_cpu(header->xh_count);
+	max_entries = (sb->s_blocksize - sizeof(struct ocfs2_xattr_header)) /
+			sizeof(struct ocfs2_xattr_entry);
+	if (count > max_entries) {
+		mlog(ML_ERROR,
+			"xattr entry count %u exceeds maximum %zu in inode %llu\n",
+			count, max_entries,
+			(unsigned long long)OCFS2_I(inode)->ip_blkno);
+		return -EUCLEAN;
+	}
+	for (i = 0 ; i < count; i++) {
 		struct ocfs2_xattr_entry *entry = &header->xh_entries[i];
 		type = ocfs2_xattr_get_type(entry);
 		name = (const char *)header +
-- 
2.43.0


