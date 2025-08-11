Return-Path: <linux-kernel+bounces-762529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7412CB2080D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2BC1887CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD62D23B5;
	Mon, 11 Aug 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA1H4Rgy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DE2D239F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912468; cv=none; b=eLDIGBVUW7DxLMeLY00NRmsxjrnGaY1KbKV8io/Q9U1aA3Dl3+q6eCsudSMtdiiCKiRV3WaJ783fFtLgEYOGZrBvjO5Q4kJF0WThSjpqONrhvL1924iwIhnqTD4y2Sor8LbTyVjVwHfSiHWwS619+pMJy6zU7RCc71WJ04kYg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912468; c=relaxed/simple;
	bh=se0LPPpyvdXaamX2AlSPQPdigMuM5TEAMp+uNnvVCyg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c5yXsjOWiP9DTB3ABrU5KUlt5/oav4TJUofuhBETLGZsEueTzaB/iJrOYObBh5ocbgh9pc26gkGN1RrYxaZjvwxe/59L8PQr7wPRlg5/6V7aos5GSDlO7A6RVX0QBbnCz0c6C0cYOS3ftKJm1FAwo0DUZDQWP4zZvqeLAbtWMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA1H4Rgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A34C4CEED;
	Mon, 11 Aug 2025 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754912468;
	bh=se0LPPpyvdXaamX2AlSPQPdigMuM5TEAMp+uNnvVCyg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=OA1H4RgyN2tdzhWdheQAv6OvMSfeervu1u8BNowQlTKKupXq2BnBECnlmb8JnQ24y
	 cgik0aEOuzz9gXvFH8wmenWcAp5I357hFCUlMJNGb8CABr2Qf92GEczJDwZg8jart9
	 8lKqwAtG5koeVdvTXBiRx9Hk13fWzLf1fnvTrupAkq0smQFk4O0ArNsNjgBumv5Xhx
	 Pbxp7nD+VUztoVhrFkiWl59AoKOsE33plxTgv4Hm9uvgDeHM5d2WYUg4GXnIrO+YGO
	 Lp4XCcRkZaaVxl6ydYSUDcKGiQii4dpLb5YtLB0N468Lg7fEhHG+D8BXC3RUUIYKWG
	 Nt1VGPS0OjYtw==
Message-ID: <5a259275-e284-49b5-80d4-929c60b5c1cc@kernel.org>
Date: Mon, 11 Aug 2025 19:41:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_end_io
To: syzbot <syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67ec7e14.050a0220.31979b.0031.GAE@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <67ec7e14.050a0220.31979b.0031.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/common

On 4/2/25 08:00, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4e82c87058f4 Merge tag 'rust-6.15' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17007198580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4253e469c0d32ef6
> dashboard link: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5e6f1c2744e3/disk-4e82c870.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5c1a60744d62/vmlinux-4e82c870.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/228bbd75bd12/bzImage-4e82c870.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/data.c:358!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Not tainted 6.14.0-syzkaller-10892-g4e82c87058f4 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:f2fs_write_end_io+0x77a/0x790 fs/f2fs/data.c:357
> Code: e8 8b 01 f2 fd e9 a2 fa ff ff 89 d9 80 e1 07 38 c1 0f 8c fe fa ff ff 48 89 df e8 11 01 f2 fd e9 f1 fa ff ff e8 87 92 8b fd 90 <0f> 0b e8 8f d4 ed 07 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
> RSP: 0018:ffffc900001d79c0 EFLAGS: 00010246
> RAX: ffffffff8437d9e9 RBX: 0000000000000000 RCX: ffff88801da85a00
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 000000000000000a
> RBP: ffffc900001d7ac8 R08: ffffffff8437d696 R09: 1ffffd400012b785
> R10: dffffc0000000000 R11: fffff9400012b786 R12: 0000000000000001
> R13: dffffc0000000000 R14: 000000000000000a R15: ffffea000095bc00
> FS:  0000000000000000(0000) GS:ffff8881250e5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd1b21f9438 CR3: 000000007b684000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  blk_update_request+0x5e5/0x1160 block/blk-mq.c:983
>  blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1145
>  blk_complete_reqs block/blk-mq.c:1220 [inline]
>  blk_done_softirq+0x100/0x150 block/blk-mq.c:1225
>  handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:579
>  run_ksoftirqd+0xcf/0x130 kernel/softirq.c:968
>  smpboot_thread_fn+0x576/0xaa0 kernel/smpboot.c:164
>  kthread+0x7b7/0x940 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:f2fs_write_end_io+0x77a/0x790 fs/f2fs/data.c:357
> Code: e8 8b 01 f2 fd e9 a2 fa ff ff 89 d9 80 e1 07 38 c1 0f 8c fe fa ff ff 48 89 df e8 11 01 f2 fd e9 f1 fa ff ff e8 87 92 8b fd 90 <0f> 0b e8 8f d4 ed 07 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
> RSP: 0018:ffffc900001d79c0 EFLAGS: 00010246
> RAX: ffffffff8437d9e9 RBX: 0000000000000000 RCX: ffff88801da85a00
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 000000000000000a
> RBP: ffffc900001d7ac8 R08: ffffffff8437d696 R09: 1ffffd400012b785
> R10: dffffc0000000000 R11: fffff9400012b786 R12: 0000000000000001
> R13: dffffc0000000000 R14: 000000000000000a R15: ffffea000095bc00
> FS:  0000000000000000(0000) GS:ffff8881250e5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd1b21f9438 CR3: 000000007b684000 CR4: 00000000003526f0
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


