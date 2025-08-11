Return-Path: <linux-kernel+bounces-762461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E3B206D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465763B8261
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899012BE64E;
	Mon, 11 Aug 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teqqIOa6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387E29A300
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910315; cv=none; b=Q0iIOyDB+3hFjEtLUr1KI267GQV5uUGabJpaSWCQnkzYIiiIY3j/KcuhYgGDl+ppVS7rNoDpfaeMHS9EVSnuY8Kq0rWjrcyOr8llnKbcIhuM7A/ad4AmeZPmvluWfPrVMBSpDgKmx5+Wy59WBhIrkPYMCrgcj4UHhyV+zUS6iUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910315; c=relaxed/simple;
	bh=zUpaZvR3LQEZeQi8NwqiAzj3ihUiOSHvoNtQpuWRYQ0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N/Ya3E5Jop7yox1HFLz4N9Tve66RfZ+ze56d7tjUHK7i6X0X5E7JY1CMIQPs2oqrlm6RWZVhI/VZNvwYnG6AfPBJ+p6xcu5YKhNvbe37061aGewa0rDhFhL2vu4X/5KkAEc/EAQVRYCTYpuwaIZ0QSPFMtakYQrhVu4RjTQ3kk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teqqIOa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347CDC4CEED;
	Mon, 11 Aug 2025 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754910314;
	bh=zUpaZvR3LQEZeQi8NwqiAzj3ihUiOSHvoNtQpuWRYQ0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=teqqIOa62CRt3zCausdzCDXqss++uH+y9awBNb6jckHxKi/qfAcIqRBoqhQg/YMAT
	 Wp0rQwgKa8hdTSUwYoqk/YBXu2qZW4IxlB+dvmwo8W60yVFIPXnUFBJpdoEhszZV7X
	 Vf0MQOdqD+X4xI5Cdg3ehTTKvBdue/GUNT9ehSx4CbIBjh4aUUSXtSe3dQhKD1NbCe
	 ft5IWiwEwjppxDbZE25szoQjTG6VsPo8RZoj7TuymKagRkGp6sJ2Kfbv6YMRJv0uBu
	 yxt2W/jnpLsjyicIneINvkRVqMzUhaBvFbMIu00Hqv4BMIn/yyVojSTOZjm/sItf4Z
	 qHGUZ3yFNfZtA==
Message-ID: <63224c9f-fb95-4aa4-b27e-56801d249771@kernel.org>
Date: Mon, 11 Aug 2025 19:05:09 +0800
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
References: <67fe69c5.050a0220.186b78.0002.GAE@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <67fe69c5.050a0220.186b78.0002.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/common

On 4/15/25 22:14, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    834a4a689699 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10051a3f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a972ee73c2fcf8ca
> dashboard link: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145a2fe4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13382470580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-834a4a68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4454365a3050/vmlinux-834a4a68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2d99dbd9f6f4/bzImage-834a4a68.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/89819a66cafe/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13420b98580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/data.c:358!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 1033 Comm: kworker/u4:5 Not tainted 6.15.0-rc2-syzkaller-00037-g834a4a689699 #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: loop0 loop_rootcg_workfn
> RIP: 0010:f2fs_write_end_io+0x77a/0x790 fs/f2fs/data.c:357
> Code: e8 fb d8 f0 fd e9 a2 fa ff ff 89 d9 80 e1 07 38 c1 0f 8c fe fa ff ff 48 89 df e8 81 d8 f0 fd e9 f1 fa ff ff e8 d7 9e 86 fd 90 <0f> 0b e8 9f 0a f4 07 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
> RSP: 0000:ffffc90002597320 EFLAGS: 00010093
> RAX: ffffffff843cb659 RBX: 0000000000000000 RCX: ffff888035d74880
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
> RBP: ffffc90002597430 R08: ffffffff843cb306 R09: 1ffffd4000219d7d
> R10: dffffc0000000000 R11: fffff94000219d7e R12: 0000000000000001
> R13: dffffc0000000000 R14: 000000000000000a R15: ffffea00010cebc0
> FS:  0000000000000000(0000) GS:ffff88808c593000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7f3f420000 CR3: 00000000430fc000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  blk_update_request+0x5e5/0x1160 block/blk-mq.c:983
>  blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1145
>  blk_flush_complete_seq+0x6bd/0xcf0 block/blk-flush.c:191
>  flush_end_io+0xab4/0xdc0 block/blk-flush.c:250
>  __blk_mq_end_request+0x492/0x5d0 block/blk-mq.c:1135
>  loop_handle_cmd drivers/block/loop.c:1960 [inline]
>  loop_process_work+0x1bdf/0x21d0 drivers/block/loop.c:1978
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
>  worker_thread+0x870/0xd50 kernel/workqueue.c:3400
>  kthread+0x7b7/0x940 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:f2fs_write_end_io+0x77a/0x790 fs/f2fs/data.c:357
> Code: e8 fb d8 f0 fd e9 a2 fa ff ff 89 d9 80 e1 07 38 c1 0f 8c fe fa ff ff 48 89 df e8 81 d8 f0 fd e9 f1 fa ff ff e8 d7 9e 86 fd 90 <0f> 0b e8 9f 0a f4 07 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
> RSP: 0000:ffffc90002597320 EFLAGS: 00010093
> RAX: ffffffff843cb659 RBX: 0000000000000000 RCX: ffff888035d74880
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
> RBP: ffffc90002597430 R08: ffffffff843cb306 R09: 1ffffd4000219d7d
> R10: dffffc0000000000 R11: fffff94000219d7e R12: 0000000000000001
> R13: dffffc0000000000 R14: 000000000000000a R15: ffffea00010cebc0
> FS:  0000000000000000(0000) GS:ffff88808c593000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7f3f420000 CR3: 00000000430fc000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


