Return-Path: <linux-kernel+bounces-839827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF8BB280C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CE23ADD4D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77496248F72;
	Thu,  2 Oct 2025 05:09:17 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B18288AD
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759381757; cv=none; b=g2F5gtf1RVG3WGLjtJDy5tEI6b68lZ6t5O/SYKj+9t5x1bJJYU32msOPP0WprgOWENqRzYzmOuCplg+ob49p9olhZfaG0/b4bAMG/nygCHWIauDsqpuKEH9YfSjN5ZHMlUjs2eltatmXHh4b/Vcqvh28PL5TVPpDbFAVbNsqM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759381757; c=relaxed/simple;
	bh=llj3w0yP4Lyzycw+9bq5yWYauZYLLg92Fdq8utvyAUM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YDlQDIV6B4V6aHNVt1Ul3+N8T5jp8m4AU7+5KVYQdtbvjpFUWC8Hn00B1JTZvpKjjYICCgE+iVPos+KOK+DH6sFhD8KrlwOupkeF6y/YEg8MlH+hYMDeRas/HmTMTtm59VYK3btbs2LQn+oyeBnLYLHxt3s11AVp0r7wNQys6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9286199b46fso66274139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759381753; x=1759986553;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JZ/jTj1i9IorVunA/dKv2Myby8qBvknrzFw9/4eu+A=;
        b=Bk6KrSM0ZPap7sTj52x+mqNbFtt/MMjveOxUTgQoVkwvyGU4t5OO1VcKhMERurjsUS
         iddwVFSl9Hq8XsHyzTsfFsr2JvSYFJPCezr2rng7QS6lPm24reRNlHRMU8PxVVvk7eRu
         ZespH0uo1GvFXlC7I0BKp96iLAcEnAU1ah2vFpo1Ie/olRWbtO/ofQTi77zdIxPP9hhP
         ykX8KTFibdacCwklercoepFFwPOwkMfQsOMbbjx/S1jW9ukYJwOhoqQVmgsdM4LH/5Kd
         +CvXNEdv7nVYnDTAKvjs3YYwUTamq4GkkyzBxueGXzxur65+E5r9wxEE9BQKrkZXE5yC
         XiJg==
X-Gm-Message-State: AOJu0YzXMHuhkoMb55IaephtHGsApqR6ZApb/hGompEgY0aEljJbWMrt
	aP4nWv45UjBHNSu5It/WfXtW8YE7wLDEfKx+WlPhlMmARmHL4DucgGWP5kc9U4DHi/DUNsmWkza
	gvlWtVXCFU+wSABfbEw6Pmp0KFeDogeOIYaLfAImRffGlEVmAHR8dFzCWyNY=
X-Google-Smtp-Source: AGHT+IHRFXmHMqg4xxiPBxWAFlgPX2S2F2HFZKRfQD69wWHmHpjcJyfQHZhMLQZ1qXaNXZo5zqYqJWgvay7ZK+C4lGlrs+dDD4td
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:158d:b0:91e:3aef:cdd5 with SMTP id
 ca18e2360f4ac-9379f9b98a4mr838997039f.0.1759381753660; Wed, 01 Oct 2025
 22:09:13 -0700 (PDT)
Date: Wed, 01 Oct 2025 22:09:13 -0700
In-Reply-To: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de08f9.a00a0220.102ee.007a.GAE@google.com>
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


