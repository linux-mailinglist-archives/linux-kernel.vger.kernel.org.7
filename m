Return-Path: <linux-kernel+bounces-593571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB9A7FAB3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 12:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9450F3AEAD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C526B2BE;
	Tue,  8 Apr 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNjw2z+p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10853267728
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106023; cv=none; b=QqytI1aGvbT88GGWbTetXgpt1nwg+UUHD0pVPVuafPFqoXHg0xBPk/LdWtJ17QKZQ7pQPecu6iN44Ose31qPSoWQRD7hkfikYSJqQaBHAJhaPvXYgXtGU0kDa7FSXcUZEkDM8hxS7V13g/4ATP/PlPkpPc4l/D6zaYJ1Ide1QP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106023; c=relaxed/simple;
	bh=Un5FbVEQDYZeyrKPINyeNUCUHc2k1TW1tXcbkQrOuHo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ngft3b2sYh0QMZByuviFULdgEXXa7daVi0t2vvRMU/qHh5wCYABlI1k1x8PCa3chyl+C4auk1YS6ZYzOk1J+nD4/UfA1vB7HCxSJ0edYNFjDH2EMxfivk0dk+gdHcb+Jg7mnori3N2WDybQL1UWZB3Rje7IFtXkV7JhBas9jSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNjw2z+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634ACC4CEE5;
	Tue,  8 Apr 2025 09:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744106022;
	bh=Un5FbVEQDYZeyrKPINyeNUCUHc2k1TW1tXcbkQrOuHo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NNjw2z+p2Ku+kXMqS1NxPGUiCYSPkN121tjcrXgyeaA7bWEwFJU8MUhODtJ0DNnw/
	 dK9qTvu2a0tosKHVUmFDuSURpFvBRUj4U6XUeuYBxbhpOVR8Ch9TQ0D80/iKQR3KDs
	 luxOd12NjO1nGHii/A4CdI+VdLreZ9zSPcPlP165px5xAKqepQcw5aqEvSiNqfOeab
	 dHjI7N/qt/dQFMQLvbm3SEJSVj0Tq28wkrFYIlFRyskCLak277YxtIcHBjYtTlP0xF
	 T6FJDkGp0FyGU6+nzJe/7RcxgItz3UJ8H7lEs+vLWIN+APYwnckVoXbDiAwk0y/DNU
	 3PTQV2VVCQFZg==
Message-ID: <9cef1559-43a6-4968-9b86-1077a833c7a3@kernel.org>
Date: Tue, 8 Apr 2025 17:53:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [syzbot] [f2fs?] kernel BUG in dec_valid_block_count
To: syzbot <syzbot+8b376a77b2f364097fbe@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67f3c0b2.050a0220.396535.0547.GAE@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <67f3c0b2.050a0220.396535.0547.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot

On 4/7/25 20:10, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a1b5bd45d4ee Merge tag 'usb-6.15-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=174ffc3f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe3b5e6a2cb1cc2
> dashboard link: https://syzkaller.appspot.com/bug?extid=8b376a77b2f364097fbe
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148427cf980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c9f7b0580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-a1b5bd45.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8b14e02f603d/vmlinux-a1b5bd45.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cc06cac05b38/bzImage-a1b5bd45.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/697f78a4edc0/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10ffca74580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8b376a77b2f364097fbe@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/f2fs.h:2521!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5312 Comm: syz-executor407 Not tainted 6.14.0-syzkaller-12886-ga1b5bd45d4ee #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:dec_valid_block_count+0x3b2/0x3c0 fs/f2fs/f2fs.h:2521
> Code: 8a 01 fe e9 80 fd ff ff e8 db 64 97 fd 48 c7 c7 60 6e 31 8f 4c 89 e6 48 89 da e8 39 aa 14 01 e9 73 fe ff ff e8 bf 64 97 fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc9000d39f078 EFLAGS: 00010293
> RAX: ffffffff842bf2c1 RBX: 00000000fffffcda RCX: ffff88801f41a440
> RDX: 0000000000000000 RSI: 00000000000003fa RDI: 00000000000000d4
> RBP: 1ffff110082999f4 R08: ffffffff842bef72 R09: fffff52001a73e00
> R10: dffffc0000000000 R11: fffff52001a73e00 R12: ffff8880414ccfa4
> R13: dffffc0000000000 R14: ffff8880414cc000 R15: 00000000000003fa
> FS:  00007f5c4fc216c0(0000) GS:ffff88808c599000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5c4fc00d58 CR3: 0000000043b00000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  f2fs_truncate_data_blocks_range+0xc8c/0x11a0 fs/f2fs/file.c:695
>  truncate_dnode+0x417/0x740 fs/f2fs/node.c:973
>  truncate_nodes+0x3ec/0xf50 fs/f2fs/node.c:1014
>  f2fs_truncate_inode_blocks+0x8e3/0x1370 fs/f2fs/node.c:1197
>  f2fs_do_truncate_blocks+0x840/0x12b0 fs/f2fs/file.c:810
>  f2fs_truncate_blocks+0x10d/0x300 fs/f2fs/file.c:838
>  f2fs_truncate+0x417/0x720 fs/f2fs/file.c:888
>  f2fs_setattr+0xc4f/0x12f0 fs/f2fs/file.c:1112
>  notify_change+0xbca/0xe90 fs/attr.c:552
>  do_truncate+0x222/0x310 fs/open.c:65
>  handle_truncate fs/namei.c:3466 [inline]
>  do_open fs/namei.c:3849 [inline]
>  path_openat+0x2e4f/0x35d0 fs/namei.c:4004
>  do_filp_open+0x284/0x4e0 fs/namei.c:4031
>  do_sys_openat2+0x12b/0x1d0 fs/open.c:1429
>  do_sys_open fs/open.c:1444 [inline]
>  __do_sys_creat fs/open.c:1522 [inline]
>  __se_sys_creat fs/open.c:1516 [inline]
>  __x64_sys_creat+0x124/0x170 fs/open.c:1516
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5c4fc6c839
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5c4fc21218 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 00007f5c4fcf8608 RCX: 00007f5c4fc6c839
> RDX: 00007f5c4fc6c839 RSI: 0000000000000009 RDI: 0000200000000080
> RBP: 00007f5c4fcf8600 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5c4fcc58f4
> R13: 0000200000000100 R14: 0031656c69662f2e R15: 0000200000000080
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:dec_valid_block_count+0x3b2/0x3c0 fs/f2fs/f2fs.h:2521
> Code: 8a 01 fe e9 80 fd ff ff e8 db 64 97 fd 48 c7 c7 60 6e 31 8f 4c 89 e6 48 89 da e8 39 aa 14 01 e9 73 fe ff ff e8 bf 64 97 fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc9000d39f078 EFLAGS: 00010293
> RAX: ffffffff842bf2c1 RBX: 00000000fffffcda RCX: ffff88801f41a440
> RDX: 0000000000000000 RSI: 00000000000003fa RDI: 00000000000000d4
> RBP: 1ffff110082999f4 R08: ffffffff842bef72 R09: fffff52001a73e00
> R10: dffffc0000000000 R11: fffff52001a73e00 R12: ffff8880414ccfa4
> R13: dffffc0000000000 R14: ffff8880414cc000 R15: 00000000000003fa
> FS:  00007f5c4fc216c0(0000) GS:ffff88808c599000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5c4fc00d58 CR3: 0000000043b00000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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


