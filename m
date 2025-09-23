Return-Path: <linux-kernel+bounces-828255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896E4B94446
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8172A76BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02830DD00;
	Tue, 23 Sep 2025 05:02:14 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D732594B9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603733; cv=none; b=taWPdQ4jDQfTJIO48l+r9KQiIB1e17IdfyOVy5ncoRH5lAGV0urFEyxQFdpKvqgAaIooQzxfaEYPzP4KwQJjFo8CdW/mmgVs9jPZTwNbq4xOi2FzZXQn7UWCnNvttcfxucFyBCE1CGGKv7rEUAYl4NgXgPSjRrPKKMgM3TtvgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603733; c=relaxed/simple;
	bh=0Gz0GZP6milVJYdXDS0YlBvYq6R48Ix10Jdx3hEsEME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oQ0BtxS31eeraz94IN7t1XiO/eboN/Vz4v/D+puL6UnlPmyGaqi7bkw6uzIbr3TpoJxY0qSn+PQtXpfOdQrNNk7XosDAs1fLUxcI5qQ/a+13Nuvzk1mC2eLJtLMim24+HIRX0E6LZa0i/I12f1D8QyCkd8EcV4fEX+XliWN1H64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-425745467d1so29581415ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758603731; x=1759208531;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCLnnymTGswt6uMOM9G22A8ODEAb1YKDnVoU6cDwTEs=;
        b=vt0eYWOWFfeZPCpyFS4HHbUCRhuMaAZCUhbq9HHEYdiNq3hYOaXpa+TwJy1T+TODlO
         XDAQQQzKFZTpeDzhtlGPeWU30HAoAinUXqrP43pSJl6pWehvH2UW/CZVCtm5wK4QQfAy
         /HkPmPdAOrejk6EhMrlxKfvXXtbN0npMRwM+ka0h9dPioa6CRu+xPz7qcZUQv9m9X8y9
         gm30MQkK9vR8Sn3dmQYV/qI3xX4ETo0VumjjNVWyUM9W7EKtIdhw/OwSjtLcy9DbH3pL
         oZbGfwYMQYEIVvYiRviOyh6Z03k34CVk8qiC1vEZ3/TdxMAiF4Jc6GXcT6NGGMHvJkX8
         nCSw==
X-Gm-Message-State: AOJu0YznDkrlTXpyBwILO3iVrwIrKv9LlPD7G8IYS6MRx9gRsNL3C1L/
	8Tv0kQd/AEPnxqjQJJB5EuIsE3Z+g307w2bYuhz5D2JIWgt1toaMk7I6Okrj9bHnwC+rpe4eORq
	R3IwczV85v72jS4y63HO+InRrixW07zRNeWEEM+GDFRScHzhB4gwPIoLLgyU=
X-Google-Smtp-Source: AGHT+IGIksMOSL95JQWZE4nK45m3y1mPdIM+TCozZhYRIEX6bY89YqihrdDl5IRP3B9Juh5XDmyrb5tB/CkJ26KWNklEaU6+sXfW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:407:dc0b:7ba2 with SMTP id
 e9e14a558f8ab-42581e116a1mr20726905ab.3.1758603731467; Mon, 22 Sep 2025
 22:02:11 -0700 (PDT)
Date: Mon, 22 Sep 2025 22:02:11 -0700
In-Reply-To: <68c9c3fc.050a0220.3c6139.0e66.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d229d3.a70a0220.1b52b.004e.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: skip inode expansion on  readonly filesystems
From: syzbot <syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: skip inode expansion on  readonly filesystems
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Fix WARNING in ext4_xattr_block_set() during orphan cleanup on readonly
filesystems when debug_want_extra_isize mount option is used.
The issue occurs when ext4_try_to_expand_extra_isize() attempts to modify
inodes on readonly filesystems during orphan cleanup, leading to warnings
when encountering invalid xattr entries. Add a readonly check to skip
expansion in this case.

Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..ff51a4567c4f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6345,7 +6345,8 @@ static int __ext4_expand_extra_isize(struct inode *inode,
 	unsigned int inode_size = EXT4_INODE_SIZE(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int error;
-
+	if (sb_rdonly(inode->i_sb))
+		return 0;
 	/* this was checked at iget time, but double check for good measure */
 	if ((EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize > inode_size) ||
 	    (ei->i_extra_isize & 3)) {
@@ -6403,6 +6404,8 @@ static int ext4_try_to_expand_extra_isize(struct inode *inode,
 					  struct ext4_iloc iloc,
 					  handle_t *handle)
 {
+	if (sb_rdonly(inode->i_sb))
+		return 0;
 	int no_expand;
 	int error;
 
-- 
2.43.0


