Return-Path: <linux-kernel+bounces-864571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7729BFB159
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1977D507741
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180AD309F06;
	Wed, 22 Oct 2025 09:09:42 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C0311C2A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124181; cv=none; b=jUEakg9VoKIrfPUwUytUc+DzwVknD/7yzezw8GJ5Ec0vDPTtEG93/B+8b1AMMiCLXKsn1lI7sZ7Y/zd91rAPLenD3lE2GFvrBKlua6/qHUTzOF73PgHvoM7xF5QVC7rR0mkoA4+0XbdujFEgDPH8gXIsU2CsPQINKGgJjRj7tIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124181; c=relaxed/simple;
	bh=YMlG45wnFs0BEGgQKpivhonctCjJdWNbFW9NANJGnP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oqPeHO2rvLLmhHjwIsRrTzL+4/+SmItta4cPJUehIPtgkX1c+llYPjsnzT898z4r8EvuN8LOyp3an0k9emnNhgQyRqLDq+xZno69rPuWAj8potjvzzHmbsjoKjYl0zQKzhlmf0GQnYyFftQNsLGJOvWUlVyQKrKdL1/UNtqOKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d8643856so1038975ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124179; x=1761728979;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlD0aDDhmNZ//udXCDwlq9YA/ubzgiVA7UJkXsHDBTA=;
        b=ECX3jcFEj8RoMukWFjcui2zwvZDtQDWid2rwtJ86KLMe1y8oZKuK3fyM1JHUjT3lop
         +dUvSC9rf7bZO8jMBEykz2YQT4f84Eyia5Mq0G3tvyOR0RkgHeWElbiPM213i7p+8BoS
         ga6krjDCQgSt6QfaB/FLam8/9REIhVAD7qHbSY8HMpomJp6Ud+vJe/xEDil5fQEsA/w3
         vgOHKOK0y66IVkIGnubW6Vn8gDbElgPyIzj0eIihgsthew486ecl1VpbGIAbzeNVGlkT
         uryNL0OnKyRnFr88SvGrk8AbrzIrx7Yo+YoHI6vsZa+L6V5FQaootmNKY9mXUKIQ+wtf
         LvCw==
X-Gm-Message-State: AOJu0Yys89qw+I+5NYaVUtMpzDAud9K2jaGMCT0rIb17tQO+Dw7G8WwX
	ULT5RXFcj/Mlruz6AxSYrZuT9Xjw5IYM58PWnJZWIn672eZTdWxX2YxWX9SujJXmYYNju9tWPnu
	Je4Zj2TCm2qUYli3quEgfkBDmlcZL+lSasI8R8+lpDcIl/onwhGZ6udCV2ig=
X-Google-Smtp-Source: AGHT+IHlOZPMdA2HnA+9i6DRsalrZMsQlzQ/Y3QrOQe93PusJCOAsvE7g8baea5/xSoPPlJesAI4eTLI3OcWEur9jQZe/tMIvA8L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4706:b0:430:e9e7:8660 with SMTP id
 e9e14a558f8ab-430e9e78894mr81913335ab.5.1761124179246; Wed, 22 Oct 2025
 02:09:39 -0700 (PDT)
Date: Wed, 22 Oct 2025 02:09:39 -0700
In-Reply-To: <68ed75c7.050a0220.91a22.01ef.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f89f53.050a0220.346f24.003a.GAE@google.com>
Subject: Forwarded: [PATCH] f2fs: add validation for directory depth in sanity_check_inode
From: syzbot <syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] f2fs: add validation for directory depth in sanity_check_inode
Author: kartikey406@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


F2FS can mount a corrupted filesystem with an invalid directory depth
value (i_current_depth). When this corrupted directory is accessed
during operations like rename, F2FS fails to properly locate and delete
directory entries, leading to inconsistent inode state.

This triggers a warning in drop_nlink() when attempting to decrement
i_nlink from 0, as directory entries persist even after the link count
reaches zero.

Add validation in sanity_check_inode() to reject inodes with
i_current_depth exceeding MAX_DIR_HASH_DEPTH (63). This prevents
mounting corrupted filesystems and avoids subsequent filesystem
inconsistencies.

Reproducer:
1. Mount corrupted F2FS image with i_current_depth = 16842753
2. Perform rename operations on files in the corrupted directory
3. System triggers WARNING in drop_nlink() due to i_nlink underflow

With this fix, the corrupted filesystem is rejected at mount time
with a clear error message.

Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=632cf32276a9a564188d
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/f2fs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8c4eafe9ffac..276adfbd5b30 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -294,6 +294,17 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 		return false;
 	}
 
+	/* Validate directory depth */
+	if (S_ISDIR(le16_to_cpu(ri->i_mode))) {
+		unsigned int current_depth = le32_to_cpu(ri->i_current_depth);
+
+		if (current_depth > MAX_DIR_HASH_DEPTH) {
+			f2fs_warn(sbi, "%s: corrupted inode i_ino=%lx has invalid i_current_depth: %u, max: %u, run fsck to fix.",
+				  __func__, inode->i_ino, current_depth, MAX_DIR_HASH_DEPTH);
+			return false;
+		}
+	}
+
 	if (f2fs_has_extra_attr(inode)) {
 		if (!f2fs_sb_has_extra_attr(sbi)) {
 			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
-- 
2.43.0


