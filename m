Return-Path: <linux-kernel+bounces-859253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B1BED217
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B9942650B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF461FF61E;
	Sat, 18 Oct 2025 15:12:03 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC11FECBA
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800320; cv=none; b=t3Z3TwyPZiVDHC/pMvT7Dx9mnttGwn+LHBQOQysb/COzLWWHFk0H35IFngKdYyXYAY0F8vK5aEerlLkgUYKeOIsT9FlE7Okt4oIVg00wvLUsIzStPrSy+lv4ql23z53YJZfC10IYB8JUyIgu97ukGx/c6AeZnW+0b9t4sfuZpGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800320; c=relaxed/simple;
	bh=iC8oVgOPymdhybg9SiHcOU9s4yAV4rZVRx92pX88b6I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T8GYYCIerQlIYM2u8MfnryhMPPDoMNFxfZoRuP2RGLxTdsTk4OB0qdZnOSHli8LPUjU71DgXcYJEqhxDX9kWnBzrt9IfRpuU/OObCjP1z7Gb70msvjuYEHmgIPyp+msgbowCM5wHzB0WQA7vH64Wx4FoOUQp2w08e4+PbVQqC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e85344382so282922439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800316; x=1761405116;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ9p6etm/ABkz6Yzw2RZdCyXqM7TW/gu6XpToM2EUCA=;
        b=EMFP1VRZcYF8rboZheOWAzyKdE8A9gCxPkub1X4cm8imHNxvNVgzsd18SfW6FrNWGa
         +R7femRN7Gh1grcHlVMaB4R7EI1ZnyINc9YuMMXctSbBAjL0rhjWxcwy3bMuJZ8DrUjB
         PtQd9wohWp9tLsWg9Z/K72GaTbleBDRIkvGwHf4X4n0Fw4DuwJRJCTn1g4rv8z9XVa2T
         zY1KuBBKxRNkTiDQJvUZaVZOokwswzr6lGg4bXUUNARtwlBZac0OUUgse3E76FtpyeB1
         vqblXxauBzVNhCcGKPeAsJ4DeUxtIK6fbIIJKJjcd/bzrF+swaO/KMRE2rKhKNioPGbo
         S+Fg==
X-Gm-Message-State: AOJu0Yy2UUDuj12tu/ec9WKtEYrINa8J4QMxD7gWtpw1x4BPL574qtuk
	ENdiO+01SOSplbdJXrayu72Pgko6csRUmcBvzYysTbMHmbE21x+GuBXGHjVrtnVWEa94rpFaCN7
	uQzU3joR+PCJocF31Z8snJA+si49DaKiEoWyUD92MGyK7foFF36TXxoeNAz4=
X-Google-Smtp-Source: AGHT+IEgm4p4FabgGK2Ladq5vLTR7fs2/BnjjJd1ZiVERiy3OVzQP5IkSZ9Wso4keH+vVj66XBbMEBnBmmIdvX71l7jL9QCeXSR8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:608c:b0:906:c3ea:3fb7 with SMTP id
 ca18e2360f4ac-93e763cf783mr1087658839f.12.1760800316100; Sat, 18 Oct 2025
 08:11:56 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:11:56 -0700
In-Reply-To: <68c58bfa.050a0220.3c6139.04d2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f3ae3c.050a0220.91a22.0432.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: fix inline data overflow when xattr value is empty
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: fix inline data overflow when xattr value is empty
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

When a file has inline data with an xattr entry but e_value_size is 0,
ext4_prepare_inline_data() incorrectly uses the theoretical maximum
inline size (128 bytes) instead of the actual current capacity (60 bytes
from i_block only). This causes it to accept writes that exceed the
actual capacity, leading to a kernel crash in ext4_write_inline_data_end()
when the BUG_ON(pos + len > EXT4_I(inode)->i_inline_size) is triggered.

This scenario occurs when:
1. A file is created with inline data
2. The file is truncated, leaving an xattr entry with e_value_size=0
3. A write is attempted that exceeds i_block capacity (>60 bytes)

The bug occurs because ext4_prepare_inline_data() calls
ext4_get_max_inline_size() which returns the theoretical maximum (128)
even when the xattr value space is not allocated. This leads to:
- ext4_prepare_inline_data() thinks the write will fit (120 < 128)
- Does not return -ENOSPC
- Inline write path is taken
- ext4_write_inline_data_end() detects overflow and crashes

The fix checks e_value_size in ext4_prepare_inline_data():
- If e_value_size is 0: xattr exists but has no data, cannot expand,
  use actual current capacity (i_inline_size)
- If e_value_size > 0: xattr has data, expansion possible,
  use theoretical maximum (ext4_get_max_inline_size)
- If no xattr entry: use theoretical maximum

This ensures the capacity check accurately reflects available space,
triggering proper conversion to extents when needed and preventing
the overflow crash.

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inline.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..3a3aa2d803db 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -413,7 +413,30 @@ static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
 	if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
 		return -ENOSPC;
 
-	size = ext4_get_max_inline_size(inode);
+	if (ei->i_inline_off) {
+		struct ext4_iloc iloc;
+		struct ext4_inode *raw_inode;
+		struct ext4_xattr_entry *entry;
+
+		ret = ext4_get_inode_loc(inode, &iloc);
+		if (ret)
+			return ret;
+
+		raw_inode = ext4_raw_inode(&iloc);
+		entry = (struct ext4_xattr_entry *)
+			((void *)raw_inode + ei->i_inline_off);
+
+		if (le32_to_cpu(entry->e_value_size) == 0) {
+			ext4_find_inline_data_nolock(inode);
+			size = ei->i_inline_size;
+		} else {
+			size = ext4_get_max_inline_size(inode);
+		}
+
+		brelse(iloc.bh);
+	} else {
+		size = ext4_get_max_inline_size(inode);
+	}
 	if (size < len)
 		return -ENOSPC;
 
-- 
2.43.0


