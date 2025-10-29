Return-Path: <linux-kernel+bounces-875824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726FC19E47
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21BD5504463
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1F30ACFD;
	Wed, 29 Oct 2025 10:53:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9C2DBF73
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735185; cv=none; b=qLawkdPF+SRMlL4xHVeRgznuW9pTkhf5HHsKhUMtEQldElAuhV8zo5+pRDzHJPO1ncGVTMzSKBaaH0zVyHtUWihXgtTycGjIXUUd6MVF/SfkAQwSEE4W0jJnPWcobixrA/YtQwBuhyJXRu4qLPOtHUA3O4vkImONhD/ez6nQNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735185; c=relaxed/simple;
	bh=uJua2anUILPjE8vB2NpFDAD61wDcDo6Uf6Pl9zHeTto=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N355Egyf1nnWMaeWpOTYxiYQZ6KlCde4ejMLwIOYix5QOYIrfE3yVNB1FzsLa1cLyCpKvTdNq8zIlePCC0FW3kQEzVVvRLz+kbmwOIlxASsd6KXTnGn5YqZkKbLw4HVWiFq7P7mtH+BdHQAHISqanhzYTlhlwU6kds66O/HkrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d789ee5aso91792215ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761735183; x=1762339983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NA3i7c8W4rMjzEXGsZSL4aXPgrhGLfmIypWWmxikqg=;
        b=KUD/vKHYFKT9PgUTQgyuLGU7DaPIkffyEflh/EaYorJMmnQiqIA5QYf+wvfmTVT0ng
         LFmmwmhQ0DWPVgXM6JvCsQMuRQ1kQwklAMHaP3mEKXXfK4H1Ka2j0rNPp2GwxK4eoaRh
         wQ+LvjrZ2k6mWokfhdgR6FbNWlywgJPIqQKAzXXpLhfNwC+FWciMjgSHXY/HMYnfjN0a
         YHwYwCZqFOzs3aVGHkwUZqDJkXBe0ZNVVvpOT9wBypF1Blv/VXvci9/t71f1wc/XasEr
         TOqvZqYmYosvHEo/BEeAlmzq/pNt+EIyEYTl71vC1XW0kADaoynKpTHpO+us3bU4BxUT
         8xiA==
X-Gm-Message-State: AOJu0Yz6EpTnI48pPNC8fMa3bbYGjgH9uS+xVc233Hr7YKJymiXvrNYu
	INhsj942OTEcSIKJN2q4LLUduirLnYLD7uEioGqs5GLuK2X1oHAbS4ma9LLI3YgJ/wE7ATLKUvZ
	FFBCGXYGcs7LDd9UqnahvdJIHudf3Wh9HTVWKBoBCEDERPDhMSMlg9F/hbYs=
X-Google-Smtp-Source: AGHT+IFeoHGmxJeVZYbwuNxxJ0kEy44rD9TZcaY5P95MfWiWxaBRy6vwEjiva5GNZyOUXIdiyXc6jVv/cPggPHurwux/tTBODcn+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194c:b0:430:9f96:23b9 with SMTP id
 e9e14a558f8ab-432f8f94257mr35561565ab.3.1761735183180; Wed, 29 Oct 2025
 03:53:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 03:53:03 -0700
In-Reply-To: <CAMz+-CPDh3FF3Fso8UjYyd0=uyV2hJvYQLTVracNyo896rsF1A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901f20f.050a0220.32483.020c.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in chown_common

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff888040e85058, owner = 0x0, curr 0xffff888000f0a480, list empty
WARNING: CPU: 0 PID: 5805 at kernel/locking/rwsem.c:1381 __up_write kernel/locking/rwsem.c:1380 [inline]
WARNING: CPU: 0 PID: 5805 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Modules linked in:
CPU: 0 UID: 0 PID: 5805 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 20 ff 6a 8b 48 c7 c6 40 01 6b 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 f3 35 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 94 24 7d 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc9000cd5fc10 EFLAGS: 00010292
RAX: 137f67c4e7e18000 RBX: ffff888040e85058 RCX: ffff888000f0a480
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bba650 R12: 0000000000000000
R13: ffff888040e850b0 R14: ffff888040e85058 R15: 1ffff110081d0a0c
FS:  00007f716bd5d6c0(0000) GS:ffff88808d733000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000041ac2000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:990 [inline]
 chown_common+0x406/0x5b0 fs/open.c:-1
 do_fchownat+0x161/0x270 fs/open.c:825
 __do_sys_fchownat fs/open.c:840 [inline]
 __se_sys_fchownat fs/open.c:837 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:837
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f716af8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f716bd5d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007f716b1e6090 RCX: 00007f716af8efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f716b011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f716b1e6128 R14: 00007f716b1e6090 R15: 00007fff5b24d448
 </TASK>


Tested on:

commit:         e53642b8 Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13031258580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12051258580000


