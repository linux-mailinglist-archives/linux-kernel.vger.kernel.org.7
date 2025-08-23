Return-Path: <linux-kernel+bounces-782869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D26B3262D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09E104E2AAC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F3A191F9C;
	Sat, 23 Aug 2025 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OnCzMbG8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66428F4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911814; cv=none; b=feKIrg31RFt5w5izg1ph3NM7LQuyamuy6T8lLjVt2oFKsIlK4nUKgZO+jvauSUQ+vCfDjqmlTcOaZ5o3G303XrMZ8NgOeQSiOIh8a8b8riYHEP1h2k4ANB+RcujECVQFAeEfV5KLu9T3PZD0KrN3NqrOPNmJcv3yl/8PucrmSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911814; c=relaxed/simple;
	bh=rfoy8dUwVIazm6d2GUzv32yXVdoTMdUG6m95Bx7lLD4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HcXgAmIVr9He/BUAVOCItKjSOlFjlouCTezeLq41GoHYpAsPiVMfVTDbE/jXImXwyrkdrvMqeOH8jKCy5mc49Ov3poUsu5MI3fHZp8crRajJCLHoQv2C7vUqa5p6hKxwCIjdeuhW5MlbM8hwFGI7FZ7ohaiu16ZUYNBZbWNrsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OnCzMbG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFFCC4CEED;
	Sat, 23 Aug 2025 01:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755911814;
	bh=rfoy8dUwVIazm6d2GUzv32yXVdoTMdUG6m95Bx7lLD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OnCzMbG8BtPUs5b7VgQBWOaxM9mYQLdnuvEtBt5p69Z+QYGc0QnWZHVbikSJ1455z
	 reI6IDL2IFI5hbKcDqyxgzY+gmbD9A6ihJ8o6kMgi7ISKmVGt8Yi8ojcBK5PUvOvtw
	 DHq+SPW8KSTwsJRAmk2MQKh1qOfmHQ9PLas+3Rlc=
Date: Fri, 22 Aug 2025 18:16:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com, Andrew
 Donnellan <ajd@linux.ibm.com>
Subject: Re: [syzbot] [mm?] kernel BUG in page_table_check_set
Message-Id: <20250822181653.cd2024360870ef94cdb7db07@linux-foundation.org>
In-Reply-To: <68a7ef20.050a0220.37038e.004d.GAE@google.com>
References: <68a7ef20.050a0220.37038e.004d.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 21:16:32 -0700 syzbot <syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f926f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> dashboard link: https://syzkaller.appspot.com/bug?extid=49a796ed2c9709652f1e
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15faa7a2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144143bc580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+49a796ed2c9709652f1e@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at mm/page_table_check.c:118!

Thanks.

Presumably due to the series "Support page table check on PowerPC". 
Andrew, could you please take a look?

The series has been in mm.git for a week so I guess the impact of this
is small.  I won't drop it at this time, but prompt attention would be
appreciated.

> Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 6740 Comm: syz.0.17 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
> pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : page_table_check_set+0x584/0x590 mm/page_table_check.c:118
> lr : page_table_check_set+0x584/0x590 mm/page_table_check.c:118
> sp : ffff80009c9674c0
> x29: ffff80009c9674d0 x28: ffff80008fae0000 x27: 0000000000000002
> x26: ffff0000c079ca80 x25: 0000000000000001 x24: 0000000000000001
> x23: ffff0000c079ca80 x22: 000000000012b950 x21: 0000000000000001
> x20: 0000000000000003 x19: 1ffff00012eb65b0 x18: 0000000000000000
> x17: 0000000000000000 x16: ffff800080528a28 x15: 0000000000000001
> x14: 1fffe000180f3950 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff6000180f3951 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000cdb05b80 x7 : ffff800080d16554 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080d15b5c
> x2 : 0000000000000001 x1 : 0000000000000002 x0 : 0000000000000001
> Call trace:
>  page_table_check_set+0x584/0x590 mm/page_table_check.c:118 (P)
>  __page_table_check_ptes_set+0x2a8/0x2e0 mm/page_table_check.c:209
>  page_table_check_ptes_set include/linux/page_table_check.h:76 [inline]
>  __set_ptes_anysz arch/arm64/include/asm/pgtable.h:709 [inline]
>  __set_ptes+0x4a0/0x504 arch/arm64/include/asm/pgtable.h:741
>  contpte_set_ptes+0x120/0x188 arch/arm64/mm/contpte.c:464
>  set_ptes arch/arm64/include/asm/pgtable.h:1794 [inline]
>  modify_prot_commit_ptes+0x4e4/0x694 arch/arm64/mm/mmu.c:1556
>  prot_commit_flush_ptes mm/mprotect.c:197 [inline]
>  commit_anon_folio_batch mm/mprotect.c:246 [inline]
>  set_write_prot_commit_flush_ptes mm/mprotect.c:273 [inline]
>  change_pte_range mm/mprotect.c:354 [inline]
>  change_pmd_range mm/mprotect.c:570 [inline]
>  change_pud_range mm/mprotect.c:633 [inline]
>  change_p4d_range mm/mprotect.c:659 [inline]
>  change_protection_range mm/mprotect.c:687 [inline]
>  change_protection+0x1e84/0x3ff0 mm/mprotect.c:721
>  mprotect_fixup+0x504/0x744 mm/mprotect.c:837
>  do_mprotect_pkey+0x864/0xb30 mm/mprotect.c:993
>  __do_sys_mprotect mm/mprotect.c:1014 [inline]
>  __se_sys_mprotect mm/mprotect.c:1011 [inline]
>  __arm64_sys_mprotect+0x80/0x98 mm/mprotect.c:1011
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
>  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
> Code: d4210000 97e865fd d4210000 97e865fb (d4210000) 
> ---[ end trace 0000000000000000 ]---
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

