Return-Path: <linux-kernel+bounces-891809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56577C438B9
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 06:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3069188C069
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 05:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90D419F137;
	Sun,  9 Nov 2025 05:17:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D61D27E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762665424; cv=none; b=SyDcjEcDzMim1E6T1+S5ijuW+eEhQU3J425f76+MIIDcscEKovpSYvqSoUFpAkQ0qeO+Jh7olMNXGhozaDtQN+dQgZ7vmiNj5u78bjdGaerTW6otWo+SO2CTvMY6dahyQoZCacwav7EBvG+SLa+8mMlQOL2GzRoynOafzBVR5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762665424; c=relaxed/simple;
	bh=99rPMWzEdCShft3iDULaYNtZp+Z4P1Q/uZ4GyrHun80=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KIXslMA6NGFQzu5eFQhUOdzu6HELeU6jR9vptk00CtWEcRnACb9FUUyE72d0ewiO9n6DGS0Vu4PGS+G+BXHkmAPZ2HhVdguMakh4c13neZ3MmnyvF1KYSEUPVTUQTee8Br3C3SV9Vnzl9JKEWnXsfn1izvHqQGRGHorcWSoKIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so238939739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 21:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762665422; x=1763270222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0IjPH0kWVG4Gvdd8W1Xr+xNy0rMGnCLIzuUpku3hag=;
        b=glkARd34y1gYNZHAhRw4VYDRUsetgFqVyOiMfC6KxrGyu7g0UB7QVlRFmNM0rUzrar
         GTH2Bx30oyKVb8luoXYFtLPkdMRnC7PsMYevFqVn+k9SUbwVKfG1wFip9bFVHwzgenAF
         MjZMhYEOk0TEyWdbrJnh1YIB0Jg1osYvk1nTdhqR9V731MnXOD/xA44uUBYRsv0XuHAm
         VbZsiTMMLPZEUr8ziceKqVr4Sa0Vdxa+4voMu+7cUdcHS602hUJCP30nXIB8uckHbJXD
         NwqJK8oEdfhrElPKPqZcbyH5fvVB2ZYrbJgA0ROX0TdvtxlKaUA9eCvGqFJa3quqNJS4
         GCgw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/IpdhLxdls7PaCYG5rUwj9DCffdWgfNlej+gd3dJfzdL+Zr4YpYM5w2qtp59srNyMpPso+abCSqJmZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGH24Yuo5u8RdcUeIFAt5OUANoMjEiq0CB6QAadfIR7e14ZTr
	0PWebPbuypQ85g4tr3uEPg1z7RlO5iLXbWChfBlYnS0DwO6uDbiBdAyVQK9CUBC09enzY+QfU8s
	lErCsae77kPjbkRC0F9OhgyYJftBTCse4EF8IbaAAXsjOnNRi+3zoaSWtDlc=
X-Google-Smtp-Source: AGHT+IFlRuy6FBy1GePIwH2KGHGqtGxzaPLBXJF7hMbJ9a2yjYFq3NgtvyqIoYkB45KCzON44RgutKbW878fJM4L45cDHHgl5avw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15cf:b0:948:7c51:1977 with SMTP id
 ca18e2360f4ac-94895f83afemr677750139f.4.1762665421997; Sat, 08 Nov 2025
 21:17:01 -0800 (PST)
Date: Sat, 08 Nov 2025 21:17:01 -0800
In-Reply-To: <20251109050218.648149-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691023cd.a70a0220.22f260.009d.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in chown_common

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff88804066a898, owner = 0x0, curr 0xffff88803347c900, list empty
WARNING: CPU: 0 PID: 5867 at kernel/locking/rwsem.c:1381 __up_write kernel/locking/rwsem.c:1380 [inline]
WARNING: CPU: 0 PID: 5867 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Modules linked in:
CPU: 0 UID: 0 PID: 5867 Comm: syz.0.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 20 ff 6a 8b 48 c7 c6 40 01 6b 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 c3 35 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 94 33 7d 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc9000ceafc30 EFLAGS: 00010296
RAX: a13d96110bebcb00 RBX: ffff88804066a898 RCX: ffff88803347c900
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bba684 R12: 0000000000000000
R13: ffff88804066a8f0 R14: ffff88804066a898 R15: 1ffff110080cd514
FS:  00007f07520966c0(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004e9f3000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:990 [inline]
 chown_common+0x3f1/0x5b0 fs/open.c:801
 do_fchownat+0x161/0x270 fs/open.c:833
 __do_sys_fchownat fs/open.c:848 [inline]
 __se_sys_fchownat fs/open.c:845 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:845
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f075118efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0752096038 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007f07513e6090 RCX: 00007f075118efc9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f0751211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f07513e6128 R14: 00007f07513e6090 R15: 00007ffd9054c3d8
 </TASK>


Tested on:

commit:         439fc29d Merge tag 'drm-fixes-2025-11-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133c6a92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140c8412580000


