Return-Path: <linux-kernel+bounces-809627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD3B51024
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4227C7B3061
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836030E0D2;
	Wed, 10 Sep 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVDKA8WC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33E30DEA5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491089; cv=none; b=gm6+hH0CnIWfnxRzFQZ15h6BXuIPtpoX5C+XKlOkNGpccxTyuHfljTBUVlzn80WuA5dn9esTk+bIw8WX0uGiSkcQroZBivrlP5LwczRmBOZh4ZUxSkIpBwlGP3qyuvciRK9ipJvhW6tUt0RmYIdpt4Ur4Z3CAASV6u0GSeJoTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491089; c=relaxed/simple;
	bh=LztD8EweTcKzQwfThVrDf5vHXn1Xuy8jy9vRPLZPWHM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lfzxx2Txk//QK7b2GRwxzVaiIfjQ9E/8reFdSkfJLDaDZ6uZNryXk9wwGqGKWFGcG4xBqGUO1xwDP0t9dkvOEon/QFmbAt8Xh2VEB8wNyugyha44r7Dsu47+HWkszkBAb8IehnJWJ/QQLUuxnZT/jtJswRsehDVxcP+q7a+/cHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVDKA8WC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6E9C4CEF5;
	Wed, 10 Sep 2025 07:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757491088;
	bh=LztD8EweTcKzQwfThVrDf5vHXn1Xuy8jy9vRPLZPWHM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jVDKA8WCeQzXTghD9Y1h1TXSnVLZ4wu1cJ+PPuTu199VG9c0tr4UAOE1K6LU6OrgM
	 ryfbrgQd9aXCZy46bOYE6+XS4AiNEdgfqXcX/j9FgmPF7b3NO88SBRjI700becCoYM
	 8EFn/LbIyOz/Ugq9SK9Qz+XvRWrk08+L6sSyVJM/G5hQSnV3Mrw3E1Ss1itZp1cy4b
	 wcu2VJX63oU3u3AvcJrgA+Z4Bes1BH39V4/dBROfUI54NYdBJrbyiDSciEzslU+5+T
	 xYXz93Q9cUG5d5/99JDJdmXuBloeq66YyNsfRzLqM80z55TpRCqx//rQ4CZpcfVt00
	 LzmIPaIfC1R2g==
Message-ID: <8ccaa1f0-3263-41a9-b2e5-bf540be979c7@kernel.org>
Date: Wed, 10 Sep 2025 15:58:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [syzbot] [f2fs?] kernel BUG in clear_inode (4)
To: syzbot <syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <68c09802.050a0220.3c6139.000e.GAE@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <68c09802.050a0220.3c6139.000e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot

On 9/10/25 05:11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f777d1112ee5 Merge tag 'vfs-6.17-rc6.fixes' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=124dad62580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
> dashboard link: https://syzkaller.appspot.com/bug?extid=90266696fe5daacebd35
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a43562580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164dad62580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/860ff2f591a4/disk-f777d111.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/31f4ca3a76d4/vmlinux-f777d111.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c534fac91a74/bzImage-f777d111.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/6c7a25c90276/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11a43562580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 40427
> F2FS-fs (loop0): Wrong SSA boundary, start(3584) end(4096) blocks(3072)
> F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
> F2FS-fs (loop0): invalid crc value
> F2FS-fs (loop0): f2fs_convert_inline_folio: corrupted inline inode ino=3, i_addr[0]:0x1601, run fsck to fix.
> ------------[ cut here ]------------
> kernel BUG at fs/inode.c:753!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 6097 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:clear_inode+0x169/0x190 fs/inode.c:753
> Code: 4c 89 f7 e8 59 7a ec ff e9 60 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 7c c0 4c 89 f7 e8 2f 7b ec ff eb b6 e8 28 40 8d ff 90 <0f> 0b e8 20 40 8d ff 90 0f 0b e8 18 40 8d ff 90 0f 0b e8 10 40 8d
> RSP: 0018:ffffc9000408f890 EFLAGS: 00010293
> RAX: ffffffff82311f78 RBX: ffff888022059300 RCX: ffff888024ced940
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000408fa00 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1e3ab47 R12: dffffc0000000000
> R13: ffff888022059300 R14: ffff888022059558 R15: 0000000000000001
> FS:  000055557dd70500(0000) GS:ffff8881268bf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055738e9e8660 CR3: 0000000029a1c000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  evict+0x504/0x9c0 fs/inode.c:810
>  f2fs_fill_super+0x5612/0x6fa0 fs/f2fs/super.c:5047
>  get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
>  vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
>  do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
>  do_mount fs/namespace.c:4136 [inline]
>  __do_sys_mount fs/namespace.c:4347 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4324
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f865d77038a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc62ec72e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffc62ec7370 RCX: 00007f865d77038a
> RDX: 0000200000000140 RSI: 00002000000000c0 RDI: 00007ffc62ec7330
> RBP: 0000200000000140 R08: 00007ffc62ec7370 R09: 0000000000000008
> R10: 0000000000000008 R11: 0000000000000246 R12: 00002000000000c0
> R13: 00007ffc62ec7330 R14: 0000000000005531 R15: 00002000000056c0
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:clear_inode+0x169/0x190 fs/inode.c:753
> Code: 4c 89 f7 e8 59 7a ec ff e9 60 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 7c c0 4c 89 f7 e8 2f 7b ec ff eb b6 e8 28 40 8d ff 90 <0f> 0b e8 20 40 8d ff 90 0f 0b e8 18 40 8d ff 90 0f 0b e8 10 40 8d
> RSP: 0018:ffffc9000408f890 EFLAGS: 00010293
> RAX: ffffffff82311f78 RBX: ffff888022059300 RCX: ffff888024ced940
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000408fa00 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1e3ab47 R12: dffffc0000000000
> R13: ffff888022059300 R14: ffff888022059558 R15: 0000000000000001
> FS:  000055557dd70500(0000) GS:ffff8881268bf000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055738e9e8660 CR3: 0000000029a1c000 CR4: 00000000003526f0
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


