Return-Path: <linux-kernel+bounces-837856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D305BADBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335323266E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1523043B8;
	Tue, 30 Sep 2025 15:20:35 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F86302CD6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245634; cv=none; b=GaSZlZSggPXh78i7T99RMuRB7Wxd6d+N87ZnhzvDtlT0Ywi0Lgs5FE5+rt5yx10WieMFA03QBihWnQnVJbUW7BvkK3wa71+jH7XnS277L/6r3PDAlU8ZwUzE3rq6Rt6aMk8Tpr1HOp4EFrD19kLnxmc7zvIDsDoRp3eHZQ7/QXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245634; c=relaxed/simple;
	bh=A8Aj5PtDGM+iqZKLhFsoeH42iFQ7tPw68t9mJZcPGrc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DXDCL7Af4znHhZICAdzCZPb7WLeWEKtVqehQvGgZmGdmVTYmUkdixkG2LlsH/UEqno0ybo/TAycTjgnKOJd8vtuDdo0Y485KSeoK1Z5RDKov7ksVIjTnpP3zyJ8n6C2tTtlrJYo5fWCN8xg5LCtlSa63qFfeV70C0gBwHHfobHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-934b5bec52cso83108139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759245631; x=1759850431;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67QXoVbdT+ERqk0ipS/Tza5znpbaiV6UHc5aLhsrwFU=;
        b=VI/UUjcQF2I9B91LPWv3sDnKM2psnwSCfIlNyyti7pdDLXKfebeAQCr5y1ZPCmFaiL
         v8MxWLvYAvonEMp0gWGQqRnQaIlWMLm9YOAwJvlzsuZrfXQVRThQLjPfLMH1cWTMhTy2
         xxGU0ZKJ/OVj5njVs2jtgaYN2mW9C4wMIsrLC88yOb+ZUqo9mbg17ir/HOJpRWfTAGYJ
         Owp3FEFtYjUIBYqehTi/0T3H/1ul3BLHJSuUsrbo0o4lAikjUikWpyFgHyi9k0qOurE/
         1K+CxhrA2eKdH8qpv7qC/F+/7rvuF0y1n7BVDce5ZctH3EwHCJrmWqR7/dTf1VAv7HpF
         th2w==
X-Gm-Message-State: AOJu0Ywd2/0tWWu1cgHJ7KAT3HYKT3Gh+2SQ6AAFp/QjMX9zOXQf0Qr1
	CDwIzhw1IfxH/OOZkv8kZ5fOUuH3GuacUTi+JN/KgM6ltN2sIAyHpuBzmAONt05xYXPxwwtgHHO
	lPBoh38WEpdYLywEhE6KW0KEd2xDu9wJuJG4qOJQ0ncqADE3NHE6rpYHPW+0=
X-Google-Smtp-Source: AGHT+IHJPBEZN+PHCoWoJxVT0vijyc9isrvWqgJpD4IpOkLlu9BKsYvSC4+BRKvHVDBwHf9zMf9/LXiHcThL29WPSihjXB+F6iur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3790:b0:424:86d:7bb9 with SMTP id
 e9e14a558f8ab-42d814dab7cmr5158565ab.0.1759245631400; Tue, 30 Sep 2025
 08:20:31 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:20:31 -0700
In-Reply-To: <68335d8e.a70a0220.253bc2.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dbf53f.a00a0220.102ee.004a.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: fix use-after-free in ext4_ext_insert_extent()
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: fix use-after-free in ext4_ext_insert_extent()
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

syzbot reported a use-after-free bug in ext4_ext_insert_extent() where
fex->ee_block is accessed after the extent header has been freed. This
occurs when the extent header is corrupted or freed by a concurrent
thread during a write operation.

The issue is triggered when multiple threads perform concurrent writes
to the same file. After commit 665575cff098 ("filemap: move prefaulting
out of hot write path"), the write path no longer prefaults pages,
creating a race window where:

1. Thread A enters ext4_ext_insert_extent() and gets extent header pointer
2. Thread B modifies the extent tree, potentially freeing the header
3. Thread A dereferences fex->ee_block from the freed header, causing UAF

Fix this by validating the extent header's magic number and ensuring it
has valid entries before dereferencing the last extent pointer.

Reported-by: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..d71b0fff41cc 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2083,6 +2083,12 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	/* probably next leaf has space for us? */
 	fex = EXT_LAST_EXTENT(eh);
 	next = EXT_MAX_BLOCKS;
+	if (le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC ||
+	   le16_to_cpu(eh->eh_entries) == 0) {
+		EXT4_ERROR_INODE(inode, "corrupted extent header");
+		 err = -EFSCORRUPTED;
+		goto errout;
+	}
 	if (le32_to_cpu(newext->ee_block) > le32_to_cpu(fex->ee_block))
 		next = ext4_ext_next_leaf_block(path);
 	if (next != EXT_MAX_BLOCKS) {
-- 
2.43.0


