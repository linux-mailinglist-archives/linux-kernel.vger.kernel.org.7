Return-Path: <linux-kernel+bounces-762522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC2B207EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4063B8C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9652D29D0;
	Mon, 11 Aug 2025 11:31:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0A2D29C6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911866; cv=none; b=VaIF42FkgYFmI5yCNK9fJIws8nMdaVj3w/6bo/lDjclsBhiohTRxjM6pSeZW6xkFvaStSECNzLKUvskFFgJ9LoErdfZLikC2Z6pkTOLayresbyO0ZzkAcRR2XFF45mOkpql802aCw8HMT5DD7riVSeyzq5yEEXPpFnrfT8g0AJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911866; c=relaxed/simple;
	bh=fLFHL1N839KSfiEJbdBNFOa05Bp2PhFzGFEjljLxobI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AP0y1viezPrnwYWzK1cB+Di4jWlKEnPe5xLmN1uVJi9UOiILnWW0pmPkg5CYtRQ4kJXaeaZguuLVLtxIJ73mKTtfC5ZNvr5A5wp2nrwFpkMbZpnsgG92YKX+/adDzHACK1P6AK4iDREKapFCJEy/1vEd+yS7re9CbSWrPmrd/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e401ca74fbso54913925ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911863; x=1755516663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgE+EVvvkNLaua8JmwQ8plRkqVotGZgzKdk4lE6tbMQ=;
        b=QlLPTIEtE4XyWkbvODPK6ivo6ggerLwgAxICgNxDxOVkXUDIz81WMzzgsPwKar2zC9
         31zzoQ9TVlitFlLNpvAyp5ggdvX+V3nCtxQsPKb7rHg7xGeyvyfngRpEvYWHAutl2iue
         umZJPX6zVgYMorAlDO1gUjsqT40VhTUWABL/h7cpI3dXN7ujvmu/OpgU8Le/KzoGnHLb
         ncq2OhoQfiSAqeIMAFR4K/SHUFUPWpo69yMb7UZvZsOBqBhy3LBrIdqQNhHwAcBaBUsm
         X4UoSP88TXE5x3IXtxJZZArCmHx2VvhTELDrpe3NPIAARPFIeeGIj/mo2Jt7jUnIi9tA
         0fBA==
X-Forwarded-Encrypted: i=1; AJvYcCWiAVRELcN41olQgGBUIOls/5xiUg5XpHbZEuJpV/F9TYjN/RvgaBl55YLGbPZ5rB/8F/CEG2lYlcD29dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIjQYa+LofRXAesllum+z0axK7/j8r27kQ8Mbguad3fNiw3t5
	UGWmMRXHKeG3p8FZ3NrnpQnC5ph6nd+wWiaaIcqw6SaJDqK6u5Sh0sH51Ak8I0WW1aP3gaHMM8G
	ogKQ4XMpWnK7i278K4GoZxGe0ZYi/kmE0oVDA1k7iNgE1/InuAkBpOlSOSiY=
X-Google-Smtp-Source: AGHT+IEM9EUM2e51l5Z5ahh2OOI7tur559jbOo9/TloLI45WI5kBkGYPPpvIccush4rqKIkO7DX8SgIosUWhtbAsCjPinZCYghL0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe1:b0:3e5:5081:eb8f with SMTP id
 e9e14a558f8ab-3e55081ebb0mr41793155ab.11.1754911863367; Mon, 11 Aug 2025
 04:31:03 -0700 (PDT)
Date: Mon, 11 Aug 2025 04:31:03 -0700
In-Reply-To: <63224c9f-fb95-4aa4-b27e-56801d249771@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6899d477.050a0220.51d73.009b.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_end_io
From: syzbot <syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in f2fs_update_inode

INFO: task syz.2.18:6729 blocked for more than 143 seconds.
      Not tainted 6.17.0-rc1-syzkaller-g5344e5bb8255 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.18        state:D stack:23736 pid:6729  tgid:6728  ppid:6450   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1742/0x4c70 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b0/0xb90 mm/filemap.c:1317
 folio_wait_writeback+0xb0/0x100 mm/page-writeback.c:3124
 f2fs_folio_wait_writeback+0x16c/0x240 fs/f2fs/segment.c:4210
 f2fs_update_inode+0x65/0x2620 fs/f2fs/inode.c:668
 f2fs_update_inode_page+0x131/0x190 fs/f2fs/inode.c:783
 f2fs_evict_inode+0xd4a/0x19c0 fs/f2fs/inode.c:936
 evict+0x504/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 get_signal+0x11c5/0x1310 kernel/signal.c:2807
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f721d78e9a9
RSP: 002b:00007f721e541038 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: fffffffffffffffb RBX: 00007f721d9b5fa0 RCX: 00007f721d78e9a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f721d810d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f721d9b5fa0 R15: 00007ffe0a9ef388
 </TASK>
INFO: task syz.1.17:6734 blocked for more than 144 seconds.
      Not tainted 6.17.0-rc1-syzkaller-g5344e5bb8255 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.17        state:D stack:24136 pid:6734  tgid:6733  ppid:6439   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1742/0x4c70 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b0/0xb90 mm/filemap.c:1317
 folio_wait_writeback+0xb0/0x100 mm/page-writeback.c:3124
 f2fs_folio_wait_writeback+0x16c/0x240 fs/f2fs/segment.c:4210
 f2fs_update_inode+0x65/0x2620 fs/f2fs/inode.c:668
 f2fs_update_inode_page+0x131/0x190 fs/f2fs/inode.c:783
 f2fs_evict_inode+0xd4a/0x19c0 fs/f2fs/inode.c:936
 evict+0x504/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 get_signal+0x11c5/0x1310 kernel/signal.c:2807
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa12df8e9a9
RSP: 002b:00007fa12ee9c038 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: fffffffffffffffb RBX: 00007fa12e1b5fa0 RCX: 00007fa12df8e9a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007fa12e010d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa12e1b5fa0 R15: 00007ffc4eecd1e8
 </TASK>
INFO: task syz.3.19:6741 blocked for more than 145 seconds.
      Not tainted 6.17.0-rc1-syzkaller-g5344e5bb8255 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.19        state:D stack:24600 pid:6741  tgid:6740  ppid:6451   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1742/0x4c70 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b0/0xb90 mm/filemap.c:1317
 folio_wait_writeback+0xb0/0x100 mm/page-writeback.c:3124
 f2fs_folio_wait_writeback+0x16c/0x240 fs/f2fs/segment.c:4210
 f2fs_update_inode+0x65/0x2620 fs/f2fs/inode.c:668
 f2fs_update_inode_page+0x131/0x190 fs/f2fs/inode.c:783
 f2fs_evict_inode+0xd4a/0x19c0 fs/f2fs/inode.c:936
 evict+0x504/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 get_signal+0x11c5/0x1310 kernel/signal.c:2807
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe96f58e9a9
RSP: 002b:00007fe9704b5038 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: fffffffffffffffb RBX: 00007fe96f7b5fa0 RCX: 00007fe96f58e9a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007fe96f610d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe96f7b5fa0 R15: 00007ffca3c68668
 </TASK>
INFO: task syz.4.20:6754 blocked for more than 147 seconds.
      Not tainted 6.17.0-rc1-syzkaller-g5344e5bb8255 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.20        state:D stack:24632 pid:6754  tgid:6753  ppid:6452   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1742/0x4c70 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b0/0xb90 mm/filemap.c:1317
 folio_wait_writeback+0xb0/0x100 mm/page-writeback.c:3124
 f2fs_folio_wait_writeback+0x16c/0x240 fs/f2fs/segment.c:4210
 f2fs_update_inode+0x65/0x2620 fs/f2fs/inode.c:668
 f2fs_update_inode_page+0x131/0x190 fs/f2fs/inode.c:783
 f2fs_evict_inode+0xd4a/0x19c0 fs/f2fs/inode.c:936
 evict+0x504/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 get_signal+0x11c5/0x1310 kernel/signal.c:2807
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff9cc98e9a9
RSP: 002b:00007ff9cd7f2038 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: fffffffffffffffb RBX: 00007ff9ccbb5fa0 RCX: 00007ff9cc98e9a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007ff9cca10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff9ccbb5fa0 R15: 00007ffee71ef8b8
 </TASK>
INFO: task syz.0.21:6781 blocked for more than 148 seconds.
      Not tainted 6.17.0-rc1-syzkaller-g5344e5bb8255 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.21        state:D stack:24136 pid:6781  tgid:6780  ppid:6438   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1742/0x4c70 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 io_schedule+0x81/0xe0 kernel/sched/core.c:7903
 folio_wait_bit_common+0x6b0/0xb90 mm/filemap.c:1317
 folio_wait_writeback+0xb0/0x100 mm/page-writeback.c:3124
 f2fs_folio_wait_writeback+0x16c/0x240 fs/f2fs/segment.c:4210
 f2fs_update_inode+0x65/0x2620 fs/f2fs/inode.c:668
 f2fs_update_inode_page+0x131/0x190 fs/f2fs/inode.c:783
 f2fs_evict_inode+0xd4a/0x19c0 fs/f2fs/inode.c:936
 evict+0x504/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 __fput+0x68e/0xa70 fs/file_table.c:476
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 get_signal+0x11c5/0x1310 kernel/signal.c:2807
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9d4a38e9a9
RSP: 002b:00007f9d4b2c5038 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: fffffffffffffffb RBX: 00007f9d4a5b5fa0 RCX: 00007f9d4a38e9a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f9d4a410d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9d4a5b5fa0 R15: 00007ffcd0c959d8
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/u8:1/13:
2 locks held by ksoftirqd/1/23:
 #0: ffff8880b8739e18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636
 #1: ffff8880b8724008 (psi_seq){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
1 lock held by khungtaskd/31:
 #0: ffffffff8e139ee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e139ee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e139ee0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
4 locks held by kworker/u8:2/36:
2 locks held by getty/5617:
 #0: ffff8880304d30a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
1 lock held by syz.2.18/6729:
 #0: ffff8880628e4618 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x898/0x19c0 fs/f2fs/inode.c:892
1 lock held by syz.1.17/6734:
 #0: ffff888026c9a618 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x898/0x19c0 fs/f2fs/inode.c:892
1 lock held by syz.3.19/6741:
 #0: ffff888029132618 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x898/0x19c0 fs/f2fs/inode.c:892
1 lock held by syz.4.20/6754:
 #0: ffff88802c33e618 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x898/0x19c0 fs/f2fs/inode.c:892
1 lock held by syz.0.21/6781:
 #0: ffff888059ebe618 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x898/0x19c0 fs/f2fs/inode.c:892
4 locks held by syz.6.23/7017:
 #0: ffff888062b55478 (&sbi->gc_lock){+.+.}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2296 [inline]
 #0: ffff888062b55478 (&sbi->gc_lock){+.+.}-{4:4}, at: f2fs_issue_checkpoint+0x3a8/0x610 fs/f2fs/checkpoint.c:1902
 #1: ffff888062b54318 (&sbi->cp_global_sem){+.+.}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2296 [inline]
 #1: ffff888062b54318 (&sbi->cp_global_sem){+.+.}-{4:4}, at: f2fs_write_checkpoint+0x27f/0x2440 fs/f2fs/checkpoint.c:1672
 #2: ffff888062b543b0 (&sbi->cp_rwsem){++++}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2296 [inline]
 #2: ffff888062b543b0 (&sbi->cp_rwsem){++++}-{4:4}, at: f2fs_lock_all fs/f2fs/f2fs.h:2376 [inline]
 #2: ffff888062b543b0 (&sbi->cp_rwsem){++++}-{4:4}, at: block_operations fs/f2fs/checkpoint.c:1221 [inline]
 #2: ffff888062b543b0 (&sbi->cp_rwsem){++++}-{4:4}, at: f2fs_write_checkpoint+0x55f/0x2440 fs/f2fs/checkpoint.c:1687
 #3: ffff888062b54448 (&sbi->node_write){++++}-{4:4}, at: f2fs_down_write fs/f2fs/f2fs.h:2296 [inline]
 #3: ffff888062b54448 (&sbi->node_write){++++}-{4:4}, at: block_operations fs/f2fs/checkpoint.c:1271 [inline]
 #3: ffff888062b54448 (&sbi->node_write){++++}-{4:4}, at: f2fs_write_checkpoint+0xe29/0x2440 fs/f2fs/checkpoint.c:1687
1 lock held by syz.5.22/7014:
 #0: ffff88802ffba618 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x898/0x19c0 fs/f2fs/inode.c:892
1 lock held by syz.7.24/7016:
 #0: ffff88807dda4618 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x898/0x19c0 fs/f2fs/inode.c:892
1 lock held by syz.8.25/7019:
 #0: ffff88805beaa618 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x898/0x19c0 fs/f2fs/inode.c:892
1 lock held by syz.9.26/7021:
 #0: ffff8880339fe618 (sb_internal#2){.+.+}-{0:0}, at: f2fs_evict_inode+0x898/0x19c0 fs/f2fs/inode.c:892
1 lock held by syz.2.497/8114:
 #0: ffff8880b8739e18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636
2 locks held by syz.4.499/8118:
2 locks held by syz.1.500/8120:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.17.0-rc1-syzkaller-g5344e5bb8255 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 16 Comm: rcu_preempt Not tainted 6.17.0-rc1-syzkaller-g5344e5bb8255 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:lookup_object lib/debugobjects.c:423 [inline]
RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:662 [inline]
RIP: 0010:debug_object_assert_init+0xf8/0x380 lib/debugobjects.c:1008
Code: fd 4c 89 34 24 4c 8b 6d 00 45 31 f6 eb 07 4d 8b 6d 00 41 ff c6 4d 85 ed 74 3c 4d 8d 65 18 4c 89 e0 48 c1 e8 03 42 80 3c 38 00 <74> 08 4c 89 e7 e8 0e b4 58 fd 49 39 1c 24 0f 84 ef 00 00 00 4c 89
RSP: 0018:ffffc900001578b8 EFLAGS: 00000046
RAX: 1ffff110082b7c26 RBX: ffffc90000157a80 RCX: dffffc0000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc900001577a0
RBP: ffffffff99d4d290 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200002aef4 R12: ffff8880415be130
R13: ffff8880415be118 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125d54000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f449da77000 CR3: 0000000076c48000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 debug_timer_assert_init kernel/time/timer.c:803 [inline]
 debug_assert_init kernel/time/timer.c:848 [inline]
 __try_to_del_timer_sync+0x29/0x3a0 kernel/time/timer.c:1457
 __timer_delete_sync+0x1fe/0x2d0 kernel/time/timer.c:1620
 schedule_timeout+0x133/0x270 kernel/time/sleep_timeout.c:100
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         5344e5bb f2fs: cover f2fs_update_inode_page() w/ node_..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/common
console output: https://syzkaller.appspot.com/x/log.txt?x=1683f9a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f6e4cb78ac1b7bb
dashboard link: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.

