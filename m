Return-Path: <linux-kernel+bounces-893173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533D5C46B41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5ADF18850F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078E30F946;
	Mon, 10 Nov 2025 12:52:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64130F54C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779129; cv=none; b=ujE7sIHql+a+SAIVgUv7MQfMAaXxySTiSMdoNlRwfrZPWZDhozeD/gOlvfDqBHoNzjcDAYx8kmrS77cimNM0fbItjmd0X3nsUd7BzU7HURJ1cqeTyxA2l3Ebe/R1LnafoPyhu7X1Seh7U1zBpMrj+lFXondLPT1oasYSWdBgHOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779129; c=relaxed/simple;
	bh=frL1ApzmAOkzAX1ve6DYVbqVKdjJL9+C0kdQGuPMOe0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pe4zagASxFesYPMjx0AA5v6rcdoGEHl5V1NO/UN6l5HkUIZypx5LNDj+UYe2ocJ/EGe6ggUfQAdrdBL9i2I2IIOl64rwZXbHLi8Vukcvd8ems5CKcPAQVQRRzsmgv1MP0Wy9HQRrdjXgwHFbSUF3IBpNKL1lmNMknwUjzhIHLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e7b0584c9so262369639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779125; x=1763383925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq7wGx0OQtZl7NB24ORBsesi1mVkc1sg34kpN7uZt/g=;
        b=BklnD3a6Un2mFr1CUci+Jgru6l3rX7v+i2XhIvqZBpXwuAgoup2ZifeXFypo6A8JOW
         917tvPhFluHVwmF1CBuqxtn6VItxozx3qWWSZ3X9MD19kqob/396jp3DjNBghuSOaV/v
         TUjuzQkrflwo9k3fXceFZxf2lYh5fnNjomUc6eUyhcAZnezzQeIh1lY+3RR+OZOSyOry
         PNcI/li62Q8wRrFWUZPPtJpDOjCMam37dvlgsKyVy149OcsGHwmF0n9nSwVYgbTCo2AZ
         z2erSHLO2KfKZyUmoCCSHxGi+E04NhZ+fHMYB1pd7phh5beydbRdR3wJdEn8A1Hz7zm0
         2zMA==
X-Forwarded-Encrypted: i=1; AJvYcCVFvzrTGQVYlgb3uX09/Pd4qr1eT+RdIlwzCJKBzKx4QocYKFjFCLnHpRVNVKEcQnwUdQdXeAmFDJDRCsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgMM+zucSNVFh/xLkPOGtQqp8x59xibiOc1FHhSEngWG0/YYR
	xNlYvCIBI/KYP55YDoybUHermTlwx32zrZi9iO8KR3lPkfCksOIPx/xAUUVl9Lty/swGdNZBWDr
	LC1BJgaXepvqYXCOADEqYUNWYF+picrgEfZrJOqEsnXFh1u0Z8xOHX3y3e6s=
X-Google-Smtp-Source: AGHT+IG4w8eQQYTKHfwx7rWZUfzGDBCxHD/1/s3Zdq7rVI0+SHq/aRL1iFtUfcbqQOA/BGsjE7vZZQK4YxkcNB7Y2fumlkJXKMqp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1747:b0:433:2072:9d2c with SMTP id
 e9e14a558f8ab-43367ddda84mr126894915ab.10.1762779125579; Mon, 10 Nov 2025
 04:52:05 -0800 (PST)
Date: Mon, 10 Nov 2025 04:52:05 -0800
In-Reply-To: <tencent_3C191ECFCB8DE725968D8112075DCF5D9507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911dff5.a70a0220.22f260.00ef.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
From: syzbot <syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in lbmIOWait

INFO: task syz-executor:6320 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21768 pid:6320  tgid:6320  ppid:1      task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 io_schedule+0x81/0xe0 kernel/sched/core.c:7871
 lbmIOWait+0x1e5/0x610 fs/jfs/jfs_logmgr.c:2152
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1863 [inline]
 lmLogShutdown+0x43e/0x850 fs/jfs/jfs_logmgr.c:1683
 lmLogClose+0x28a/0x520 fs/jfs/jfs_logmgr.c:1459
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab386c09f7
RSP: 002b:00007ffe632254d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fab38741d7d RCX: 00007fab386c09f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe63225590
RBP: 00007ffe63225590 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe63226620
R13: 00007fab38741d7d R14: 000000000002f114 R15: 00007ffe63226660
 </TASK>
INFO: task syz-executor:6321 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21768 pid:6321  tgid:6321  ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f86878b09f7
RSP: 002b:00007ffe3768bce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f8687931d7d RCX: 00007f86878b09f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe3768bda0
RBP: 00007ffe3768bda0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe3768ce30
R13: 00007f8687931d7d R14: 000000000002f508 R15: 00007ffe3768ce70
 </TASK>
INFO: task syz-executor:6328 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21544 pid:6328  tgid:6328  ppid:1      task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb668cf09f7
RSP: 002b:00007ffcd289ea18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fb668d71d7d RCX: 00007fb668cf09f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffcd289ead0
RBP: 00007ffcd289ead0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffcd289fb60
R13: 00007fb668d71d7d R14: 000000000002fbeb R15: 00007ffcd289fba0
 </TASK>
INFO: task syz-executor:6332 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21768 pid:6332  tgid:6332  ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcbed5509f7
RSP: 002b:00007ffda4a96418 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fcbed5d1d7d RCX: 00007fcbed5509f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffda4a964d0
RBP: 00007ffda4a964d0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffda4a97560
R13: 00007fcbed5d1d7d R14: 000000000002fc05 R15: 00007ffda4a975a0
 </TASK>
INFO: task syz-executor:6334 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21768 pid:6334  tgid:6334  ppid:1      task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7307
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
 jfs_umount+0x2ef/0x3c0 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x135/0x2c0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1722
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb21bf709f7
RSP: 002b:00007fffe5843fa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fb21bff1d7d RCX: 00007fb21bf709f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffe5844060
RBP: 00007fffe5844060 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffe58450f0
R13: 00007fb21bff1d7d R14: 000000000002ffbb R15: 00007fffe5845130
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/38:
 #0: ffffffff8d5aa840 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d5aa840 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8d5aa840 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5554:
 #0: ffff88823bf688a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e8b2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x444/0x1400 drivers/tty/n_tty.c:2222
2 locks held by syz-executor/6320:
 #0: ffff8880335d60d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880335d60d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880335d60d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6321:
 #0: ffff8880563d60d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880563d60d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880563d60d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6328:
 #0: ffff888026a7e0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888026a7e0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888026a7e0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6332:
 #0: ffff8880548c80d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880548c80d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880548c80d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6334:
 #0: ffff8880385d80d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880385d80d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880385d80d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6886:
 #0: ffff8880260e80d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880260e80d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880260e80d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6898:
 #0: ffff8880472520d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880472520d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880472520d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6904:
 #0: ffff8880596a40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880596a40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880596a40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6905:
 #0: ffff8880592f00d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880592f00d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880592f00d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6920:
 #0: ffff88805b3100d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88805b3100d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88805b3100d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
1 lock held by syz.4.211/7506:
1 lock held by syz.3.212/7508:
2 locks held by syz.0.213/7510:
2 locks held by syz.1.215/7514:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf60/0xfa0 kernel/hung_task.c:495
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 7514 Comm: syz.1.215 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:validate_chain+0x1c/0x2140 kernel/locking/lockdep.c:3864
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41 56 41 55 41 54 53 48 81 ec e0 00 00 00 49 89 cf 65 48 8b 05 c4 5c 06 10 <48> 89 84 24 d8 00 00 00 8b 46 20 89 c1 81 e1 00 80 04 00 81 f9 00
RSP: 0018:ffffc9000625ef30 EFLAGS: 00000086
RAX: 45c4b56d1d97b400 RBX: 0000000000000002 RCX: 2c8d01d5bb98a066
RDX: 0000000000000000 RSI: ffff88801dba8bb0 RDI: ffff88801dba8000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff81737c15
R10: ffffc9000625f298 R11: ffffffff81aadce0 R12: 00000000ea4a1b54
R13: ffff88801dba8b60 R14: ffff88801dba8bb0 R15: 2c8d01d5bb98a066
FS:  00007f0949f5e6c0(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000010000 CR3: 000000003936a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xc2/0x2390 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 save_stack+0xf7/0x1f0 mm/page_owner.c:156
 __set_page_owner+0x8d/0x4b0 mm/page_owner.c:332
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 folio_alloc_mpol_noprof+0x39/0xe0 mm/mempolicy.c:2435
 shmem_alloc_folio mm/shmem.c:1871 [inline]
 shmem_alloc_and_add_folio mm/shmem.c:1910 [inline]
 shmem_get_folio_gfp+0x633/0x1a70 mm/shmem.c:2533
 shmem_get_folio mm/shmem.c:2639 [inline]
 shmem_write_begin+0xef/0x2a0 mm/shmem.c:3289
 generic_perform_write+0x29d/0x8c0 mm/filemap.c:4242
 shmem_file_write_iter+0xfb/0x120 mm/shmem.c:3464
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5d5/0xb40 fs/read_write.c:686
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f094a8ee17f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007f0949f5ddf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 00007f094a8ee17f
RDX: 0000000001000000 RSI: 00007f0941b3e000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000005f6e
R10: 0000000000000778 R11: 0000000000000293 R12: 0000000000000003
R13: 00007f0949f5def0 R14: 00007f0949f5deb0 R15: 00007f0941b3e000
 </TASK>


Tested on:

commit:         e9a6fb0b Linux 6.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1284b412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cd07cd980000


