Return-Path: <linux-kernel+bounces-743483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CB5B0FF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554D454592B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269B71DF99C;
	Thu, 24 Jul 2025 03:38:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B6482FF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328289; cv=none; b=jvRjnqNM7hKlomiPaaBm9HYJCPC62cuGI4sDZqrNxKkLNmFKcXlgvAn/0So4BgEDwBX17yQoCfHlYOe6rUWE6Tv2Je0QlwDn4YLl4HkWS+9aZn9kY/WQz4wWNPf9QDwcr5T0k5ZkkoT5RfkHQI0CKHri99ITSuST4pvPVcZAqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328289; c=relaxed/simple;
	bh=19UHBccz5uzsUFSR3WHkbPrKJ36qEUN8cS0ftTHkDp4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jXfZ57Op37VzFxZPEJLef2rKX7qL3/PFUYxAHcM66Yn2uRUun0TgdrMx5wePbk/COAASRm5mtBHCx3jhetvt8zHqt4xkXBB3vAdM1GRQ6yGEXXgG/RZ3kmvb97gjNdJ0TXY/avH4eYeIYaHzc7ez8inZZJ0YUrOKvQHcGo3VvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c24b196cbso68764339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753328285; x=1753933085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKRzZw+WKv27qPnlZWwbMJmYPmOIp7Nng3+JryfNUJ8=;
        b=eqcutd6ixTmoBBUdrgjXvO293qt7dmUGPbnUoc2CiBDjBz3WV5koktc/2GEs5f45Xf
         soFzubHOU9CNcAKGtCplX+T8bEeIMI2zEawNWWOT//wyIoyOudLhpm9kYMEMUHc7kCdi
         MxY1DmYcSi9cEw18lAjguZ+NDKcD6OLV++C6P2FoAqvlAtjODNxnAPd8BvkSw2V7HXND
         7SD6nAUYfx60m8mlqLlZ0SX4kZspU0JLFmYZRJAXx9VYizTZcJA5fJbJHGbUCOdoOcr6
         O/AFbtPCfoEGQdVCEoSbovegpLCTX6KY6XQVOpVcT4Zj5JO0zCzkUVEjNve2UxYeLq4Z
         4IgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQxj4qS4j+pSiql+gdFX05dZly+GehgLcWMPn8HNzD+cWEpKLJSHjelgoHk8dQIR/+sTiwyLXNd02fp8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnRZa1iG7Bdom0zyzDbKPQejHIEza3kXfkUTqxdZpqAJhXfNH
	Ioe2K0DP4GrdQX7zIgX4N/pu7ACcLOgVq8bhxj397o3P32Oy8v+Pmrqh8SWRw7+3FXMmb+ds3QM
	KhSltPrDpyC0mRIy/a+BdfhqSsTRgb9zlpqZdK5d3piLtayO8Cq8+jGHEw7g=
X-Google-Smtp-Source: AGHT+IH7gsCKZd9tQRyvx92tvfU6dOV80bUU/qIKX8I/r4w0x4uNMu+86QblBeGm3fcgGjaNTo+lnNv5AEXDh2/4cTq+k8eygkEk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6403:b0:873:1a0e:a496 with SMTP id
 ca18e2360f4ac-87c6505de5dmr887372839f.10.1753328285183; Wed, 23 Jul 2025
 20:38:05 -0700 (PDT)
Date: Wed, 23 Jul 2025 20:38:05 -0700
In-Reply-To: <20250724031332.2898-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881aa9d.a00a0220.2f88df.000a.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] [input?] [usb?] INFO: task hung in
 io_wq_put_and_exit (5)
From: syzbot <syzbot+e328767eafd849df0a78@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in io_wq_put_and_exit

INFO: task syz.1.17:6773 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.17        state:D stack:26232 pid:6773  tgid:6771  ppid:6608   task_flags:0x400548 flags:0x00024006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x116a/0x5dd0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6879
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x2fc/0x4e0 kernel/sched/completion.c:116
 io_wq_exit_workers io_uring/io-wq.c:1319 [inline]
 io_wq_put_and_exit+0x271/0x8d0 io_uring/io-wq.c:1347
 io_uring_clean_tctx+0x10d/0x190 io_uring/tctx.c:203
 io_uring_cancel_generic+0x69c/0x9a0 io_uring/io_uring.c:3212
 io_uring_files_cancel include/linux/io_uring.h:19 [inline]
 do_exit+0x2ce/0x2bd0 kernel/exit.c:911
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1105
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d6a18e9a9
RSP: 002b:00007f8d6b0e0038 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: 0000000000008000 RBX: 00007f8d6a3b5fa0 RCX: 00007f8d6a18e9a9
RDX: 0000000000000000 RSI: 00000000000847ba RDI: 0000000000000004
RBP: 00007f8d6a210d69 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000000e R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8d6a3b5fa0 R15: 00007ffd107136e8
 </TASK>
INFO: task syz.2.18:6840 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.18        state:D stack:26664 pid:6840  tgid:6838  ppid:6609   task_flags:0x400548 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x116a/0x5dd0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6879
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x2fc/0x4e0 kernel/sched/completion.c:116
 io_wq_exit_workers io_uring/io-wq.c:1319 [inline]
 io_wq_put_and_exit+0x271/0x8d0 io_uring/io-wq.c:1347
 io_uring_clean_tctx+0x10d/0x190 io_uring/tctx.c:203
 io_uring_cancel_generic+0x69c/0x9a0 io_uring/io_uring.c:3212
 io_uring_files_cancel include/linux/io_uring.h:19 [inline]
 do_exit+0x2ce/0x2bd0 kernel/exit.c:911
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1105
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2db898e9a9
RSP: 002b:00007f2db980e038 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: 0000000000008000 RBX: 00007f2db8bb5fa0 RCX: 00007f2db898e9a9
RDX: 0000000000000000 RSI: 00000000000847ba RDI: 0000000000000004
RBP: 00007f2db8a10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000000e R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2db8bb5fa0 R15: 00007fff6dbc8bc8
 </TASK>
INFO: task syz.0.16:9206 blocked for more than 144 seconds.
      Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.16        state:D stack:26744 pid:9206  tgid:9180  ppid:6603   task_flags:0x400548 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x116a/0x5dd0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6879
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x2fc/0x4e0 kernel/sched/completion.c:116
 io_wq_exit_workers io_uring/io-wq.c:1319 [inline]
 io_wq_put_and_exit+0x271/0x8d0 io_uring/io-wq.c:1347
 io_uring_clean_tctx+0x10d/0x190 io_uring/tctx.c:203
 io_uring_cancel_generic+0x69c/0x9a0 io_uring/io_uring.c:3212
 io_uring_files_cancel include/linux/io_uring.h:19 [inline]
 do_exit+0x2ce/0x2bd0 kernel/exit.c:911
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1105
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3c01d8e9a9
RSP: 002b:00007f3c02bf7038 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: 0000000000008000 RBX: 00007f3c01fb5fa0 RCX: 00007f3c01d8e9a9
RDX: 0000000000000000 RSI: 00000000000847ba RDI: 0000000000000004
RBP: 00007f3c01e10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000000e R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f3c01fb5fa0 R15: 00007ffe702637d8
 </TASK>
INFO: task syz.3.19:10135 blocked for more than 144 seconds.
      Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.19        state:D stack:26344 pid:10135 tgid:10115 ppid:6607   task_flags:0x400548 flags:0x00024006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x116a/0x5dd0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6879
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x2fc/0x4e0 kernel/sched/completion.c:116
 io_wq_exit_workers io_uring/io-wq.c:1319 [inline]
 io_wq_put_and_exit+0x271/0x8d0 io_uring/io-wq.c:1347
 io_uring_clean_tctx+0x10d/0x190 io_uring/tctx.c:203
 io_uring_cancel_generic+0x69c/0x9a0 io_uring/io_uring.c:3212
 io_uring_files_cancel include/linux/io_uring.h:19 [inline]
 do_exit+0x2ce/0x2bd0 kernel/exit.c:911
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1105
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8c01f8e9a9
RSP: 002b:00007f8c02df6038 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: 0000000000008000 RBX: 00007f8c021b5fa0 RCX: 00007f8c01f8e9a9
RDX: 0000000000000000 RSI: 00000000000847ba RDI: 0000000000000004
RBP: 00007f8c02010d69 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000000e R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8c021b5fa0 R15: 00007ffe7fdaf018
 </TASK>
INFO: task syz.4.20:13145 blocked for more than 144 seconds.
      Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.20        state:D
 stack:26328 pid:13145 tgid:13108 ppid:6618   task_flags:0x400548 flags:0x00024006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x116a/0x5dd0 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6879
 schedule_timeout+0x257/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x2fc/0x4e0 kernel/sched/completion.c:116
 io_wq_exit_workers io_uring/io-wq.c:1319 [inline]
 io_wq_put_and_exit+0x271/0x8d0 io_uring/io-wq.c:1347
 io_uring_clean_tctx+0x10d/0x190 io_uring/tctx.c:203
 io_uring_cancel_generic+0x69c/0x9a0 io_uring/io_uring.c:3212
 io_uring_files_cancel include/linux/io_uring.h:19 [inline]
 do_exit+0x2ce/0x2bd0 kernel/exit.c:911
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1105
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf4098e9a9
RSP: 002b:00007faf3fbfe038 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: 0000000000008000 RBX: 00007faf40bb5fa0 RCX: 00007faf4098e9a9
RDX: 0000000000000000 RSI: 00000000000847ba RDI: 0000000000000004
RBP: 00007faf40a10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000000e R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007faf40bb5fa0 R15: 00007ffffeb96db8
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/13:
 #0: 
ffff88801b881148
 (
(wq_completion)events_unbound
){+.+.}-{0:0}
, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: 
ffffc90000127d10
 ((linkwatch_work).work
){+.+.}-{0:0}
, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: 
ffffffff9035e868
 (
rtnl_mutex){+.+.}-{4:4}
, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:303
1 lock held by khungtaskd/31:
 #0: 
ffffffff8e5c4e00
 (
rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6770
3 locks held by kworker/u8:3/37:
 #0: ffff88803193e948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90000ad7d10 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x120/0x14e0 net/ipv6/addrconf.c:4193
5 locks held by kworker/u8:4/61:
 #0: ffff88801c6f3948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc9000211fd10 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff90348810 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xad/0x890 net/core/net_namespace.c:662
 #3: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: ops_exit_rtnl_list net/core/net_namespace.c:174 [inline]
 #3: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: ops_undo_list+0x7e9/0xab0 net/core/net_namespace.c:249
 #4: ffffffff8e5d03f8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock+0x1a3/0x3c0 kernel/rcu/tree_exp.h:336
2 locks held by kworker/u8:5/1084:
 #0: ffff8880b853a2d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:606
 #1: ffffc90003b57d10 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
1 lock held by dhcpcd/5498:
 #0: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x26d/0x1f50 net/ipv4/devinet.c:1121
2 locks held by getty/5596:
 #0: ffff888032aa10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000333b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
3 locks held by kworker/0:6/26490:
 #0: ffff88801b878d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90004ca7d10 (deferred_process_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
1 lock held by syz-executor/5467:
 #0: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x600/0x2000 net/core/rtnetlink.c:4054
1 lock held by syz-executor/5515:
 #0: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: inet6_rtm_newaddr+0x4e4/0x1c70 net/ipv6/addrconf.c:5026
7 locks held by syz-executor/5629:
 #0: ffff888052826428 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff88802a1f6c88 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x510 fs/kernfs/file.c:325
 #2: ffff888028b55f08 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b2/0x510 fs/kernfs/file.c:326
 #3: ffffffff8f8e66a8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:216
 #4: ffff88802b32d0e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:884 [inline]
 #4: ffff88802b32d0e8 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff88802b32d0e8 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xa4/0x620 drivers/base/dd.c:1292
 #5: ffff888060fa3250 (&devlink->lock_key#41){+.+.}-{4:4}, at: nsim_drv_remove+0x4a/0x1d0 drivers/net/netdevsim/dev.c:1675
 #6: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #6: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_dev_lock+0x146/0x360 net/core/dev.c:2143
2 locks held by syz-executor/5665:
 #0: ffffffff90a98620 (&ops->srcu#2){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:161 [inline]
 #0: ffffffff90a98620 (&ops->srcu#2){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:253 [inline]
 #0: ffffffff90a98620 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x113/0x2c0 net/core/rtnetlink.c:574
 #1: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x600/0x2000 net/core/rtnetlink.c:4054
2 locks held by syz-executor/5703:
 #0: ffffffff90348810 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x286/0x5f0 net/core/net_namespace.c:570
 #1: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock_killable include/linux/rtnetlink.h:145 [inline]
 #1: ffffffff9035e868 (rtnl_mutex){+.+.}-{4:4}, at: register_netdev+0x18/0x50 net/core/dev.c:11218

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xf70/0x12c0 kernel/hung_task.c:470
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 2983 Comm: kworker/u8:9 Not tainted 6.16.0-rc7-syzkaller-g25fae0b93d1d-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: bat_events batadv_nc_worker
RIP: 0010:rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
RIP: 0010:rcu_is_watching+0x41/0xc0 kernel/rcu/tree.c:745
Code: d1 93 89 c5 83 f8 07 0f 87 82 00 00 00 48 8d 3c ed a0 dd f3 8d 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 <75> 5c 48 03 1c ed a0 dd f3 8d 48 b8 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc9000b9bfb10 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffffffff93d13228 RCX: ffffffff8b53bf1b
RDX: 1ffffffff1be7bb5 RSI: ffffffff8c1573e0 RDI: ffffffff8df3dda8
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124820000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bc7b350be0 CR3: 000000000e382000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rcu_read_lock include/linux/rcupdate.h:842 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0xc0d/0x1030 net/batman-adv/network-coding.c:719
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         25fae0b9 Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1487dfd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
dashboard link: https://syzkaller.appspot.com/bug?extid=e328767eafd849df0a78
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122bdfd4580000


