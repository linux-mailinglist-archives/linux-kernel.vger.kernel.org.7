Return-Path: <linux-kernel+bounces-894689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AE3C4B9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCDD91894EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AD129ACFD;
	Tue, 11 Nov 2025 06:06:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F5299950
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841185; cv=none; b=oDzgBLjBrRo82mBxi4Qrh8zwDoiKhpQsBxYs+KGYTFDwmzGC6D0V8dxvoKbzDIU6GN0Z8XMcBE7Cj9wnT8sPygg1GF6K92ifIOWDWIT0IDdpiXf7T5AUmjr1KcUy79FadMRRZwtAhyjwYkV+2Gcrrnuwor+1FHlPEsIhLG0FLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841185; c=relaxed/simple;
	bh=95hSHIEE7UyBeX2t/Yst2YwvKJXLhd6weHAdYCzGRzc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JnIBm3OCYnPQmwvLzNr/rsB1bmE87R0seYKRwNhDlYmoVUK2hoe8fVN7rugpLTIroigG41H1xWaozYoPML6fxeO6q8i1NLBEfpb46t0GCZtFVplInwdZtLgwq8mQlJTJPIC0XycsPCT9kXkwA2vCvX84diAaBpUnURSLDF13au0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43335646758so42447065ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762841183; x=1763445983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtUAvp6Km7e3ZaBIvZSsFUqK4Xw8uNGgBDf4kNA8Eso=;
        b=dDP6K9dgKGO5txfIh/J1t2MOTDtpqLmhGtbIfDV2f2BSvIx+m0Wxes3Qo4L6vHXRsL
         HI+SqB3/fGuqas8YaLbQM2mec0FCpPA3I2qRNylpcOVdGztSbctdqjcEsI/UdjqJjNx+
         JiP89ouNUtCUxsuD1bVMUeJFguteI9KGTNQPaTJvuO2dXwI4pk70Df/879cVX/xaDa+4
         AJslw6BI4sMpERHUm43JLVWAvZLJNpV2/K+9mUQ0n7dgcSLSmgQLZDj0AOlBmcE2m22e
         ZI27rggDftUGuus7VVHyvfN2cIpZtsD48LR9FkL4IOdM9/c9Hs64H16mcBXCTayF0m2H
         ooLA==
X-Gm-Message-State: AOJu0Yw4Wp64PzIWYaFbX0EZt3GRMuiXis4DK+CHC0MS2u3b5LIIQWWV
	aOjnmqNdOL3wFbHyQehbgd0HWyg3PQ0ruS3BoWOpGTR+XCxyt4bADcXQGF5wcgLj+57rXF6tfIu
	EdSl9nGyYhyT/X49rKi9gXSLFulu8etO9oofJMjy1H0FFjBEXmhBt5FSM+E0=
X-Google-Smtp-Source: AGHT+IGHqupUEmygYcWwDDF3I2tGCNVKJj4mfmYKC8mpQnDltkbK6Ew2DVdQHbIBkufD5vscWrR4zVeyBncKnFpeiPidKI0KmzHl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3389:b0:433:7c86:74ec with SMTP id
 e9e14a558f8ab-4337c867a2bmr108861505ab.23.1762841183191; Mon, 10 Nov 2025
 22:06:23 -0800 (PST)
Date: Mon, 10 Nov 2025 22:06:23 -0800
In-Reply-To: <69122a59.a70a0220.22f260.00fc.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912d25f.a70a0220.22f260.012a.GAE@google.com>
Subject: Forwarded: [PATCH] ocfs2: validate xattr entry count in ocfs2_validate_xattr_block
From: syzbot <syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ocfs2: validate xattr entry count in ocfs2_validate_xattr_block
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci


Add validation of xattr entry count when validating external xattr
blocks to catch corruption early before the block is used by the
system. This prevents corrupted xattr counts from causing out-of-bounds
access and use-after-free bugs when processing xattr entries.

The validation ensures that xh_count does not exceed the maximum number
of entries that can fit within the block. Without this check, a
corrupted filesystem image with an invalid xh_count can cause the code
to iterate beyond the allocated block boundary, potentially accessing
freed memory pages.

The check is added to ocfs2_validate_xattr_block() which is called when
reading xattr blocks from disk, providing protection for all code paths
that subsequently access the xattr entries. This follows the same
pattern as other validation checks in the function.

This patch complements the inline xattr validation added to
ocfs2_validate_inode_block(), providing comprehensive protection for
both inline and external xattr storage.

Reported-by: syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ab0ad25088673470d2d9
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/xattr.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index d70a20d29e3e..3d21f2b9966e 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -470,7 +470,23 @@ static int ocfs2_validate_xattr_block(struct super_block *sb,
 	trace_ocfs2_validate_xattr_block((unsigned long long)bh->b_blocknr);
 
 	BUG_ON(!buffer_uptodate(bh));
-
+	if (!(le16_to_cpu(xb->xb_flags) & OCFS2_XATTR_INDEXED)) {
+		struct ocfs2_xattr_header *header = &xb->xb_attrs.xb_header;
+		u16 xattr_count;
+		size_t max_entries;
+
+		xattr_count = le16_to_cpu(header->xh_count);
+		max_entries = (sb->s_blocksize -
+			       offsetof(struct ocfs2_xattr_block, xb_attrs.xb_header) -
+			       sizeof(struct ocfs2_xattr_header)) /
+			       sizeof(struct ocfs2_xattr_entry);
+		if (xattr_count > max_entries) {
+			return ocfs2_error(sb,
+					   "Extended attribute block #%llu has invalid xattr count %u (max %zu)\n",
+					   (unsigned long long)bh->b_blocknr,
+					   xattr_count, max_entries);
+		}
+	}
 	/*
 	 * If the ecc fails, we return the error but otherwise
 	 * leave the filesystem running.  We know any error is
-- 
2.43.0


