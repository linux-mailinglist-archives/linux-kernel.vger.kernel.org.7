Return-Path: <linux-kernel+bounces-754235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E92B19050
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 00:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A935F18934AA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 22:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B8627AC5A;
	Sat,  2 Aug 2025 22:19:31 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536227A47F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754173170; cv=none; b=Z3IUqEG1vzXZrcSOihog3A11lQI68bBoxMt6z4oC8vvFucSRA57FBOGdVsyzLYOBYFDTCAtC/XpA/aAHNydiZBer8QQYTEFDObhjXpy067OT0I98M5WIvQxVw8GM+jcrshgRMaCWbgJXQkJyiZmu+5jQClGznpzIeXTDxd0pTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754173170; c=relaxed/simple;
	bh=ik20PhQNU3HAmeJCWDDz2I5g0wdvQSto3QBrL3pbE+U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sbaeJELdZ1DCDIexc8mwhDF06HBMlNAlO2dh5tYBm1qzfAK46l9qqsJcDpAQ/Q3aNM9B59GseSlDkCTp6tHuLawj46Gn9MXcHH5hN4HA+C00LRlu2pAxU5UIptPIhkf1XtB/F3GVTaE5S/K4bc3x+DMtWCOUb5UQom2LY83ijGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e3d23d2e66so32944045ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 15:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754173168; x=1754777968;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7bQTpZXbu//7x+4wmyUFm6Wxctv7jk4X1m/pJIBHUI=;
        b=iiHx2ad9W+6E7k3pP9G6CS7whnCWHNG/xWUkucu7krjACjjopIxC8Nw9kAZgg242ZX
         AMT4054rX2M6kligSP4AbhntIgZq8XuDJ+gvoAlxB0bQVU5rfkhFnU29LxJMn01K9qmy
         piEPOsKvL+x+EvhYve9pZSDSrzN1EA5RXdspyELKIP50VVo2tbZqpsXlYzBWmQDmqKRw
         x7PS+f8uacPg/ooVagA7EGEmkQaRuso6MM31v6YSjHpahdX/gtGWc0yRf1QuSKsGMVw5
         KPLun1/14yzJfZ82Jpxs0dQfAMrwRWFo0gg+jNqatLntwyDT1NXaE6Co3zvsuwbxOmOl
         h2ng==
X-Forwarded-Encrypted: i=1; AJvYcCXJCZk7rFfbNErF7tCsOkvcJgsngzQY7jVuymgksMtdcOmfM0VNtmRUtgLoQ4S69S6R+X19ZqQYruOejzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmF07dSt689GAyIeF5TGEVJRfy/XlFiWHCSfkS9aQvststJcv5
	sLO4C/8CSEjaAWDPLx9q1qwbnhA2YWHKg/2oxzp649S0Mu7ACKFvUMVRIE6uYl7IcfJAI1XIedR
	zdQVThQDn2okpJO/Qyxdwhev0jj+Y/eJFHMQgRL1qukvXsnpZ+DTR4fFqf9I=
X-Google-Smtp-Source: AGHT+IGaaJMxXme2sTcpZbIFu0BKFYMoVUrXJ5eurk6w/mAhehGptwgqJxhLB+qU8I3c+YoZenSYX8hIckkkzoe8WoPQW/jUql/x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2302:b0:3e2:91bb:c075 with SMTP id
 e9e14a558f8ab-3e4161990d4mr76743745ab.22.1754173168358; Sat, 02 Aug 2025
 15:19:28 -0700 (PDT)
Date: Sat, 02 Aug 2025 15:19:28 -0700
In-Reply-To: <683e2b6d.a00a0220.d8eae.005b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e8ef0.050a0220.f0410.0144.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in do_qc
From: syzbot <syzbot+bad65435361712796381@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    eacf91b0c78a Merge tag 'fbdev-for-6.17-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162a3834580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbdefbf39cb79f7e
dashboard link: https://syzkaller.appspot.com/bug?extid=bad65435361712796381
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c03cf0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112a3834580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-eacf91b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/51416a3bb992/vmlinux-eacf91b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa2684a00ab0/bzImage-eacf91b0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d4ede27f2613/mount_1.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=151c7f82580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bad65435361712796381@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
gfs2: fsid=syz:syz.0: found 1 quota changes
gfs2: fsid=syz:syz.0: fatal assertion failed
------------[ cut here ]------------
kernel BUG at fs/gfs2/quota.c:320!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5780 Comm: syz.0.38 Not tainted 6.16.0-syzkaller-11129-geacf91b0c78a #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__qd_hold fs/gfs2/quota.c:320 [inline]
RIP: 0010:do_qc+0x5c1/0x5e0 fs/gfs2/quota.c:705
Code: 00 00 00 00 00 fc ff df 48 8b 0c 24 80 3c 01 00 74 0a 48 8b 7c 24 10 e8 bd fd 28 fe 48 8b 44 24 10 48 8b 38 e8 70 e2 2e fd 90 <0f> 0b e8 f8 2b c4 fd 48 8b 7c 24 10 e8 5e e2 2e fd 90 0f 0b 66 66
RSP: 0018:ffffc9000d68f348 EFLAGS: 00010246
RAX: 000000000000002c RBX: 1ffff1100860680e RCX: 05e99f5eed550400
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffc9000d68f067 R09: 1ffff92001ad1e0c
R10: dffffc0000000000 R11: fffff52001ad1e0d R12: ffff888043034000
R13: ffff888043034070 R14: ffff888043034090 R15: 0000000000000000
FS:  00007faa59d406c0(0000) GS:ffff88808d21f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb33a2f7000 CR3: 000000003f713000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_quota_change+0x394/0x800 fs/gfs2/quota.c:1304
 gfs2_alloc_blocks+0x18bc/0x2080 fs/gfs2/rgrp.c:2494
 alloc_dinode+0x258/0x550 fs/gfs2/inode.c:422
 gfs2_create_inode+0xbbc/0x1560 fs/gfs2/inode.c:807
 gfs2_atomic_open+0xd2/0x220 fs/gfs2/inode.c:1395
 atomic_open fs/namei.c:3568 [inline]
 lookup_open fs/namei.c:3679 [inline]
 open_last_lookups fs/namei.c:3807 [inline]
 path_openat+0xf63/0x3830 fs/namei.c:4043
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa58f8eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faa59d40038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007faa591b5fa0 RCX: 00007faa58f8eb69
RDX: 0000000000105042 RSI: 0000200000000080 RDI: ffffffffffffff9c
RBP: 00007faa59011df1 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001ff R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007faa591b5fa0 R15: 00007ffdf5ca1658
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__qd_hold fs/gfs2/quota.c:320 [inline]
RIP: 0010:do_qc+0x5c1/0x5e0 fs/gfs2/quota.c:705
Code: 00 00 00 00 00 fc ff df 48 8b 0c 24 80 3c 01 00 74 0a 48 8b 7c 24 10 e8 bd fd 28 fe 48 8b 44 24 10 48 8b 38 e8 70 e2 2e fd 90 <0f> 0b e8 f8 2b c4 fd 48 8b 7c 24 10 e8 5e e2 2e fd 90 0f 0b 66 66
RSP: 0018:ffffc9000d68f348 EFLAGS: 00010246
RAX: 000000000000002c RBX: 1ffff1100860680e RCX: 05e99f5eed550400
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffc9000d68f067 R09: 1ffff92001ad1e0c
R10: dffffc0000000000 R11: fffff52001ad1e0d R12: ffff888043034000
R13: ffff888043034070 R14: ffff888043034090 R15: 0000000000000000
FS:  00007faa59d406c0(0000) GS:ffff88808d21f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb33a2f7000 CR3: 000000003f713000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

