Return-Path: <linux-kernel+bounces-750191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B942B15868
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94BD07A9A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9C1CD215;
	Wed, 30 Jul 2025 05:16:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C118B0F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753852565; cv=none; b=tefbmlUSWnLvjZLE7r9RpK2ZICMqlCEusBQ+kP4weQSLlLY6X/Z3kaHlS7DRR3MkcmkCWxCjI64JWJ0ME3l3Idm7i//UC0Ioq7Q0HecYEL+AKGL7KhHOZ7uwUKyXOZJbigSzyoBZJGps83D+XrjefoKit503jLvrNqJu1mfEA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753852565; c=relaxed/simple;
	bh=SuZnQg61RA6A6E5v2vE9vWqX2SlNrG31RBAOng4RsxE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oEdctjSf2dAjUVj1V6tfL7QhzGa+7R8sB6MdToTrvc+fWAN4HIXHLHOevkiPnTpJMOK/QS3JsRFwxZKQxOEskHtFXMtZPI/PTqMA8zLzl/8hsGT+Z/v0dFZLn5NFbKyyvl3L90P8D9GIA3GyDH5l7vLLU6d+UWeBBHUpEgdOPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c467931c1so1316385239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753852563; x=1754457363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2QqUMhck+bz1DpmGO9sj46KpfeYh6ypuZlZRE808UM=;
        b=O2Yg48MHKXlrZJnWO+LXoDcRlX7OM1p3o1wx2mOX9fdJEqhJOsIqRZlAtfPe+09ZnT
         L7VAsHAUxWDmBN7C6RLdZ3VqD0cJY6YG/BmfI2D/q9XwTAu8GcCTZfyrDB5UVGX4pnJn
         0IRv5bP/BIjlrZTPWDxUDu9LPibOdLgWDlfi4u9U0M6pxHbRQ2UrlQxsUd/qHCoInVQn
         +rPPVeOxj1HsfV3s5lr6bX4eDcxGA80B+PGyzcJPrEg1TmL9dLeZ39brhRCa68lEaX1r
         aNWdsDPrIdYAvCepQtyokN0l7vxMBvPwWuuBCmXSNMO6XP+SAQj9SIgkRYdziNw/Z6iP
         VUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBlHlQIMGlNRup8OScJvETNln/QmpqgrddzgEqyAmsMMEM1hHzjv/CNz8bYJmYkE00taJ8WGqU1MiAuHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwFbMtFu55B6nGifIHjbVFkibOkAZOQLXNkplEShs0lRmGeh5
	sKTNoenWVs5iWnIGy/MPA1LL5zer/5+gw6C1pnrRZkWalvikpDbVAJvEhdomvlEiTi9dbRL5kyJ
	aT9HqM6JYtoC/zU5j4E7doO2cAzm891uHLxW8vSqjuhMVhZYtZacN7VF7l3o=
X-Google-Smtp-Source: AGHT+IF+4U1To/u4Zyxatyjoc5L94k1rlBcT4BzYFQsp53wZtUea/cKzQt8+ak7CfbdsA+b6NjYnc00kNHX2C77s4JS8NCMNMljg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c91:b0:87c:3990:5d27 with SMTP id
 ca18e2360f4ac-8813861fd16mr358461839f.9.1753852563520; Tue, 29 Jul 2025
 22:16:03 -0700 (PDT)
Date: Tue, 29 Jul 2025 22:16:03 -0700
In-Reply-To: <20250730020318.3428-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6889aa93.a00a0220.26d0e1.0019.GAE@google.com>
Subject: Re: [syzbot] [fuse?] WARNING: refcount bug in process_scheduled_works
From: syzbot <syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in mddev_put

------------[ cut here ]------------
kernel BUG at drivers/md/md.c:641!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 6615 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-gbeb6c8326eb4-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__mddev_put drivers/md/md.c:641 [inline]
RIP: 0010:mddev_put+0x1e9/0x1f0 drivers/md/md.c:660
Code: f9 e9 3f ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 6d ff ff ff 4c 89 f7 e8 12 f3 e0 f9 e9 60 ff ff ff e8 48 e0 7e f9 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002ee7cb0 EFLAGS: 00010293
RAX: ffffffff8840dae8 RBX: ffff888033654000 RCX: ffff88802f4bda00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888033654133 R09: 1ffff110066ca826
R10: dffffc0000000000 R11: ffffed10066ca827 R12: ffff888027267000
R13: ffff888148c55090 R14: ffff888033654130 R15: dffffc0000000000
FS:  0000555567c20500(0000) GS:ffff888125d86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000007 CR3: 0000000075a4e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 bdev_release+0x536/0x650 block/bdev.c:-1
 blkdev_release+0x15/0x20 block/fops.c:699
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe9c578e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe99d6fa48 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000002511a RCX: 00007fe9c578e9a9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fe9c59b7ba0 R08: 0000000000000001 R09: 0000000899d6fd3f
R10: 00007fe9c5600000 R11: 0000000000000246 R12: 00007fe9c59b5fac
R13: 00007fe9c59b5fa0 R14: ffffffffffffffff R15: 00007ffe99d6fb60
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__mddev_put drivers/md/md.c:641 [inline]
RIP: 0010:mddev_put+0x1e9/0x1f0 drivers/md/md.c:660
Code: f9 e9 3f ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 6d ff ff ff 4c 89 f7 e8 12 f3 e0 f9 e9 60 ff ff ff e8 48 e0 7e f9 90 <0f> 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002ee7cb0 EFLAGS: 00010293
RAX: ffffffff8840dae8 RBX: ffff888033654000 RCX: ffff88802f4bda00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888033654133 R09: 1ffff110066ca826
R10: dffffc0000000000 R11: ffffed10066ca827 R12: ffff888027267000
R13: ffff888148c55090 R14: ffff888033654130 R15: dffffc0000000000
FS:  0000555567c20500(0000) GS:ffff888125d86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000007 CR3: 0000000075a4e000 CR4: 0000000000350ef0


Tested on:

commit:         beb6c832 Merge tag 'uml-for-linux-6.17-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152d0834580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dea300d7050f7861
dashboard link: https://syzkaller.appspot.com/bug?extid=9921e319bd6168140b40
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a3b1bc580000


