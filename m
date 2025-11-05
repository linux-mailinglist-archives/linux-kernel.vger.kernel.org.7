Return-Path: <linux-kernel+bounces-887194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D0C3782B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D05BE344307
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CEB334C0C;
	Wed,  5 Nov 2025 19:38:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFE25EF87
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371489; cv=none; b=LBsUNeCIqVFD3dESMxbhztylto5CowEC8urwv+nUyN9xylUx44DK749uUp9yA99m0fauKbhwSgDVnvYq/gbabpFYoFNNqQSVkTY6QHG530rJOk28ggwssoORw/ipziZdkD6dBHzcx4wKuqK60ruxlu+qPuJWn0AGl85P4s2/SDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371489; c=relaxed/simple;
	bh=1PDg1CmlO+cVhtIKINwtYqMmJ/UcTCIKmaELE7ch+Ds=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c6CpH9S/3WkesiGW9ydX0/5lve6A7l7LTL1HSvRzzYtPgx6gOJPSinV2nzz5+rIuLqF9bEl0Hbewrjh7H5wp5dBTHttsEpIApnC5W+HdpKtnpl6HYa9aQSuykv/YhYEoRuJKzxzYUu/YCPBOBXm+IjFbMnHxnkRoZbrGtkVG7tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43328dcdac1so3380825ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371486; x=1762976286;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEUWlEwRjtU8+wKvFtOCXhD2/qfkw3QweZwrBKzGL7w=;
        b=krfiMG4u2pAuznPT1YMUVY9UcsfRG0klmKee3x4wypcX8mFmPkAR28EieJ7YhsIHyz
         tuNYHCAEFzN/LF+TsbRDmnmfYy29Pgi0TqVNzdC7kb21P6jzRmDwasKe8hc6BCaW1JJz
         AAJpR1lQ/vARFwM69N5bmoAQkLRBEQ4RdHhd3U6tL1bvpwzLp1ZETcstABCIXuP2yjaD
         QIyohvgsWbvaut0yRNw+mvrW/RUlOh0Oip8Te8fPCm2qVQSwg0d50pXXs383mrIb5YNe
         0cVJIC+oxgDuCCL3b8ZzyxwFEuAGLg7If8P3JJb0Yo4uOxfMY1szhpwkzCuh1Umk56vp
         kvlg==
X-Gm-Message-State: AOJu0YxVzYCFBtm0Ihub9rXH0Pxnm+VLsI8/U6NPJikQoHwNw1znDOpK
	Xbd+C13unJUJj57aTURw2Kd9kRQIjFCFICwmXGfAVkZ2lz7PUJMpttYHrym4OUcloPByx7OIsBJ
	6BjTPPT9kybrp4TtDqgnPShnltFG5AJOF951pSczzs6ov7zk0XjAnC06b/cc=
X-Google-Smtp-Source: AGHT+IGJXQCBdk2d794CVebmpenWZ9Hh1DaxkPUu8H494+GPrzH8zeWc+ECx92J/y/4NG9BNUlQDl8g7K0+nbyvCRVyBamBJk/2/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10:b0:431:d951:ab9b with SMTP id
 e9e14a558f8ab-4334061d166mr66057575ab.0.1762371486536; Wed, 05 Nov 2025
 11:38:06 -0800 (PST)
Date: Wed, 05 Nov 2025 11:38:06 -0800
In-Reply-To: <68d32659.a70a0220.4f78.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ba79e.050a0220.3d0d33.008a.GAE@google.com>
Subject: Forwarded: [PATCH v1] fs: Move might_sleep() annotation to iput_final()
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v1] fs: Move might_sleep() annotation to iput_final()
Author: mic@digikod.net

iput() don't directly call any sleepable code but mostly checks flags
and decrement a reference counter before calling iput_final() and then
evict().

Some code might call iput() with guarantees that iput_final() will not
be called.  This is the case for Landlock's hook_sb_delete() where the
inode counter must de decremented while holding it with another
reference, see comment above the first iput() call.

Move the new might_sleep() call from iput() to iput_final().  The
alternative would be to manually decrement the counter without calling
iput(), but it doesn't seem right.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: G=C3=BCnther Noack <gnoack@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>
Cc: Tingmao Wang <m@maowtm.org>
Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d32659.a70a0220.4f78.0012.GAE@google.=
com/
Fixes: 2ef435a872ab ("fs: add might_sleep() annotation to iput() and more")
Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
---

From hook_sb_delete():

	/*
	 * At this point, we own the ihold() reference that was
	 * originally set up by get_inode_object() and the
	 * __iget() reference that we just set in this loop
	 * walk.  Therefore the following call to iput() will
	 * not sleep nor drop the inode because there is now at
	 * least two references to it.
	 */
	iput(inode);

#syz test

---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 84f539497857..64120cb21e8b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1917,6 +1917,7 @@ static void iput_final(struct inode *inode)
 	const struct super_operations *op =3D inode->i_sb->s_op;
 	int drop;
=20
+	might_sleep();
 	WARN_ON(inode_state_read(inode) & I_NEW);
 	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) !=3D 0, inode);
=20
@@ -1969,7 +1970,6 @@ static void iput_final(struct inode *inode)
  */
 void iput(struct inode *inode)
 {
-	might_sleep();
 	if (unlikely(!inode))
 		return;
=20
--=20
2.51.0


