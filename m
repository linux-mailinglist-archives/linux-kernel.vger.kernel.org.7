Return-Path: <linux-kernel+bounces-894463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B4C4AAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5385C34CADD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4169D343D85;
	Tue, 11 Nov 2025 01:31:03 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E112342CAF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824662; cv=none; b=TLZWM2C8vH8C2LZFPDaRrtYnE6HEdPOpXS8QCPcsJ6bsZwnWFK8/Gk+V3ZehoglUQ/4s1Yxne+gq1mEYJmqHDXrSo9FzMqxVwJY9TDwPKaye8anLVfFB85LAWHkIvz0E6zoaYu1n+P8/i+9W/T/TZWdW8glgfpA9IofLqPlKfWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824662; c=relaxed/simple;
	bh=jiiD3V90MONLbaXxxEUaYWxSoeMnvx0VOxSTY4c3r/0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jald97NME7KC32fownHerBs4lC9dWZIjV5iW4eEHlOGCYf8RExBTH1WDJCxBUgXA5oxM62HNg2x47NJC8fKouCU6XCFppCXOTYYqsD48lc740koptee4tvg53oeIKxuMytOiDcNMxod7RVxQXDrN2JmWY6VOYXdFys7PK+iq9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9486f0954daso539230839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762824660; x=1763429460;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTYxwPgpTHu+PAz9i37u1pruccbdWixrA41TpPVmNLg=;
        b=VN4zZw7vgvjIh84anTIue67GqOgTQYp4E4qoDdOP/O/oRzZ5sEfRJGWxXA6gh9APuX
         6P5namIl9gg4pLWTyuH5jNv9509u36HGEY4FDvKtTt+WunXkhsIx8D/qQm7LKvBhBqqr
         2QD68ihRLXB4tH6AC1RBRKzrT7L2yOVX7XEuJJ/NJveICze0rsh67v+DtrzGLzn5XR8D
         2/PVq0CBE+AUmWH+CZkzIVKDIZWd9Wd0AZd7ziTqpF8mDXWSCkzkzQNol1u7MwCFn9ka
         4/dcjGSClyDXnl6S9k3nB9bjFFugAPMcmBcJrfuYebHIeIKf8SXrkM2fSbKs9QbHoFzB
         uCFA==
X-Gm-Message-State: AOJu0YyPjTWM691KzUqHqT80Obrhs/HoqtafANF3iNwX3FhnHD3Q7Oek
	A5+FlBEwhS8mM21WTI17TKdiuZzobPm41KmxB+nehnYqVUCpMVzWDeFPKPv2Y/3Q5vNRqiHdCG2
	5GUp0cp+I94Zko3EDN9o/gnx0W5EFjB0pYaSG10gsjtpuwbyBGBGAbvg2wM0=
X-Google-Smtp-Source: AGHT+IFxkzJwP1NVxoB3EHtm/fmQwYDr1lN4siSZjGlHsuLKKXaiMRy0PVhm4L6tau3/V/Gh8QWbGB0pv1M74WtPGSI5NhT94yGq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:de44:0:b0:433:74c1:2edb with SMTP id
 e9e14a558f8ab-43374c12f6bmr101995595ab.14.1762824660366; Mon, 10 Nov 2025
 17:31:00 -0800 (PST)
Date: Mon, 10 Nov 2025 17:31:00 -0800
In-Reply-To: <69122a59.a70a0220.22f260.00fc.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691291d4.a70a0220.22f260.011b.GAE@google.com>
Subject: Forwarded: [PATCH] ocfs2: validate xattr entry count to prevent use-after-free
From: syzbot <syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ocfs2: validate xattr entry count to prevent use-after-free
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci

The ocfs2_xattr_list_entries() function does not validate the
xh_count field read from the on-disk xattr header. When processing
a corrupted filesystem image, an invalid xh_count value causes the
loop to iterate beyond the bounds of the allocated block. This leads
to out-of-bounds memory access, potentially reaching freed pages and
triggering use-after-free bugs detected by KASAN.

The issue occurs because:
1. xh_count is read directly from disk without validation
2. The loop uses this value to access header->xh_entries[i]
3. When xh_count exceeds the block capacity, entry pointers extend
   beyond the allocated memory
4. Accessing these out-of-bounds pointers can reach freed memory

Fix this by validating that xh_count does not exceed the maximum
number of entries that can fit within the block before accessing
the entries array. Calculate the maximum as:
  (block_size - header_size) / entry_size

If validation fails, log an error and return -EUCLEAN to indicate
filesystem corruption.

Reported-by: syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ab0ad25088673470d2d9
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/xattr.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index d70a20d29e3e..db352df00101 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -928,8 +928,20 @@ static int ocfs2_xattr_list_entries(struct inode *inode,
 	size_t result = 0;
 	int i, type, ret;
 	const char *name;
-
-	for (i = 0 ; i < le16_to_cpu(header->xh_count); i++) {
+	u16 count;
+	size_t max_entries;
+	struct super_block *sb = inode->i_sb;
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


