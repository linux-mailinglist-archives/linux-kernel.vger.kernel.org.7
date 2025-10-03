Return-Path: <linux-kernel+bounces-840894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AD0BB5AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3052A4E9304
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E947261C;
	Fri,  3 Oct 2025 00:23:18 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB6EEA8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450997; cv=none; b=roAvs7BEg26k+iIdB7y2UwTdUkLj22NQqeCoJ3BC0yZp3m9aNCHX/AQRJO3CmD9qmR2HByj7gUOaex7xYmbI0DQGHd+6UsErvoSY3uoWWJr7rDkKN0CzTTV9zoES2ZjgjGIMKv8m6djApPKyf0xou9UcXM+iixJ6doyW088eI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450997; c=relaxed/simple;
	bh=llj3w0yP4Lyzycw+9bq5yWYauZYLLg92Fdq8utvyAUM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fnaU5UP9fHzbkZEjKTCiGZlcdfBJO24R5Rx0ZcF++xnLptkQOCIi58NkzwTQ6u1DOUB6UJKRTiU6Cbfxa6CJQbeVRXCDCHfODaGtz5ys0qPZKJ/GUusMnnSoPxMqB/y7+531BJbZSV8PPbYChWAkbKLlQW5U+T5+fwkBX+/v8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42e6e5c1d04so30672515ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450991; x=1760055791;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JZ/jTj1i9IorVunA/dKv2Myby8qBvknrzFw9/4eu+A=;
        b=Wdw1r4sJZv3XJN2WT7oZetItZ1VHKS4NqYPsn2bomeuaT5CkGu+gtfX7OTLGw42smb
         PlO9aZB9U9VPaMn2iDycGxjsOsA+rn3IhqWyDoIVblPH0GCisChty7pzoWC+xPHKzpKo
         4SncWn2tNJMMNCmIyN/EXWCICAPHmhYmZTFMlqIleU/pkFTHBa4vDOMyOhoQhISqDedE
         VncgJ535jD/83i9GC71VhK/iGXddv/7u+G0AJmOHTMR5LoTXUQmkrEk+jyGZkXNM2Mxs
         4v5ZqODy8gFflh09m+tKrNIU5gatxmwBZdkjU4tl05Sxf8ue49+o6TKHL7RSZjAEoxa1
         nYew==
X-Gm-Message-State: AOJu0YyKPtnE/jETi0WGD0gDXrPDy7X3hWPguzC8HL9FqNsWjP2IaAsH
	uA14E9EHivQr0BmgWGWWF9OVs1OMiqPSrQ3ZtWO2rD429DvTKgP+Mzmj/qGB8lxpK3JWs1UghLU
	We4cJ36JYq3C0PN7crGk4mJW5J/ys2WV5tgkTEpn3z6oWD/Vre8KdRPkUnBU=
X-Google-Smtp-Source: AGHT+IFbPJMTvjplkeJiBXh7ty3tDcd1ZK6f4IHZNZvRRiCsZ0w08igIaR5HLj7kZodRkifmXdF7fhwCU9DV6LWvNFzd5QZPPgLU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:b0:42d:8b1c:570f with SMTP id
 e9e14a558f8ab-42e7acd273fmr16476665ab.4.1759450991573; Thu, 02 Oct 2025
 17:23:11 -0700 (PDT)
Date: Thu, 02 Oct 2025 17:23:11 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df176f.050a0220.2c17c1.000b.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: fix use-after-free in ext4_search_dir via
 corrupted inline xattr
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: fix use-after-free in ext4_search_dir via corrupted inline xattr
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Add bounds validation for inline directory xattr data to prevent
use-after-free when accessing corrupted filesystems.

ext4_find_inline_entry() performs two directory searches: first in
the i_block area, then in the extended attribute (xattr) area of the
inode. When calculating inline_start for the xattr area via
ext4_get_inline_xattr_pos(), the function trusts the e_value_offs
field from disk without validating the resulting pointer stays within
the inode's boundaries.

A corrupted filesystem can craft a malicious e_value_offs value that
causes inline_start to point outside the inode's allocated space,
potentially into freed memory. When ext4_search_dir() attempts to
access this invalid pointer, it results in a KASAN use-after-free.

Fix this by validating that inline_start and inline_start + inline_size
remain within the inode's boundaries before calling ext4_search_dir().
Return -EFSCORRUPTED if the bounds check fails.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inline.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..28ac90a8d5a2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1617,7 +1617,15 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 
 	inline_start = ext4_get_inline_xattr_pos(dir, &is.iloc);
 	inline_size = ext4_get_inline_size(dir) - EXT4_MIN_INLINE_DATA_SIZE;
-
+	void *inode_start = ext4_raw_inode(&is.iloc);
+	void *inode_end = inode_start + EXT4_INODE_SIZE(dir->i_sb);
+
+	if (inline_start < inode_start ||
+	    inline_start >= inode_end ||
+	    inline_start + inline_size > inode_end) {
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	ret = ext4_search_dir(is.iloc.bh, inline_start, inline_size,
 			      dir, fname, 0, res_dir);
 	if (ret == 1)
-- 
2.43.0


