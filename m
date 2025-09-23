Return-Path: <linux-kernel+bounces-828617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF222B95032
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7832E1F32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8331CA7F;
	Tue, 23 Sep 2025 08:35:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942D42EDD5D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616534; cv=none; b=n3H4ByRkubVEpXu1x5ynGzvgFWU7vaXxQSXXsmwQbxB0zbclt4A3ovBO4ExyCN4+KANJj5GxQBkaXmXU6kDGbZG5MItBDQyVC7cP+7nVbSMfA40sCEBBBqcYteJ+jibx9d4VeS4j0iXdJeMgp5JUxQypGyGAHgO4AuGB9qhVaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616534; c=relaxed/simple;
	bh=vq/Kmgg1ohwaEHifYYxc9bB1vO/9JcO+iFfVc7MNLis=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ldocOWi7LY/pPvTgcOmNFbsbmGdtXhJN3S/9USuhuLL1y2tClup2peQsUcHB5LFv/y9QBuTod0L4gJstGxiQmdBkb41WR9sJwXhf7lFgWqxCxjZ5PpRonyGfYc+zTgJHfgSOs1Xc4Hb80ex1e9MThd5jd5NOmENQBqfb3h34kUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42574804553so62820995ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616532; x=1759221332;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/riP79cS0h1j15FszEwfdxnzZGHbLIb1Iva5ZOeWTY4=;
        b=kL9ft22u75k2yGtui9IGm6NeYhheNExTnyk4Ktu3WG5TxCO1u1SfWmC34pFzRBPg/R
         EQoxIhHKy3hAHhkW+WpFOrzmJANaxtQK88cjAJjsolv1/SIlFl8vlZbtJdHoUWyC7P6O
         sVmRuAZSZ5MqakWR0oLUDrghOb3GG6MZcN1WztW6fKjFX4sQh8mRqF1D/TpfPam8bh2C
         KajATusnuMWSHDNPuk9r54WByrM3qWXQG6VDHc8cqCKvgSSTYvHIHJFH0c+UpBVHlHjh
         bT3KKWF9G3Gf4EUlRHdL3c8yw4FcmB3pE2AyK1rp8HoY9AryPbGG9P6i761tEBd97Tle
         Bo9w==
X-Gm-Message-State: AOJu0YxbVIG/DgwMKwvDDL3sdcMdQwv3qsVOZPFRPkCtusLWP7hdj8oT
	q/6uQGCX1Q2rG2QRU5zFMU5aQ6V5qYIaX1gTJteLiMxjfFj3AxbYB2zMYc6HqRNjgFJWc7Y/80X
	fs0zq9Q+mOM/qj8HIvUWDusKcMowIKQqB/CuFQ1zDmxvXoQJ4QXQh8mPhTQY=
X-Google-Smtp-Source: AGHT+IELIuBqfKEG+pAGyJbwVM5Y1yyHPV6OxuNqzS8lyXB04j+VA6LObhPl55AfxR0cJX/Iz2JLP9Vow45sT9PpigNlMNsgDP0c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:470d:b0:425:8744:de9b with SMTP id
 e9e14a558f8ab-4258744e101mr6435835ab.18.1758616531776; Tue, 23 Sep 2025
 01:35:31 -0700 (PDT)
Date: Tue, 23 Sep 2025 01:35:31 -0700
In-Reply-To: <68c9c3fc.050a0220.3c6139.0e66.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d25bd3.050a0220.139b6.0023.GAE@google.com>
Subject: Forwarded: [PATCH] ext4: handle corrupted xattr entries in ext4_xattr_move_to_block
From: syzbot <syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ext4: handle corrupted xattr entries in ext4_xattr_move_to_block
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

During inode expansion, ext4_xattr_move_to_block() can encounter corrupted
xattr entries where e_value_size is zero but e_value_inum is non-zero,
indicating the entry claims to store its value in a separate inode but
has no actual value. This leads to a WARNING in ext4_xattr_block_set()
when it hits WARN_ON_ONCE(!i->value_len).

Add validation in ext4_xattr_move_to_block() to detect this corruption
pattern early and return -EFSCORRUPTED instead of allowing the invalid
data to propagate and trigger warnings.

Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..cbe06d7e3bb6 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2607,7 +2607,10 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
 	int needs_kvfree = 0;
 	int error;
-
+	if (value_size == 0 && entry->e_value_inum != 0) {
+	    error = -EFSCORRUPTED;
+	goto out;
+	}
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
 	bs = kzalloc(sizeof(struct ext4_xattr_block_find), GFP_NOFS);
 	b_entry_name = kmalloc(entry->e_name_len + 1, GFP_NOFS);
-- 
2.43.0


