Return-Path: <linux-kernel+bounces-893471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5D3C4782E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2ED044F1DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9955315D2A;
	Mon, 10 Nov 2025 15:17:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445D23D7DE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787827; cv=none; b=HjffosnioqGXJCO4Ha1hsmD85WodYo3tQH41tyDGi6zWSob0qxbvrybpODPlgwtt1EgP6ZIpFid98uBsp22OYC1ptSScBvVXfpyGoUI7iItknoV0mybn0rapsKWjMoo4YbnPPoLmg2mWnaec4A9kDxBlobCxhDUdOafxJ0Zemys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787827; c=relaxed/simple;
	bh=hTR2eRoA9IaD5SwCwC1XZAu15kpG3H/hpCJoeXY/NUc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rZuwaGlZcQilo9nT1sxEBMHay4NA9GaxLRA3Z9FSlLQ/QfLh6dTtgcXM/FoJU5TPXRqpgIGHsE9tkF/Z8nGG0NPBLC4N8cgbd28NXXBXh8AELkmZafCYx9RgC6yBLIfl9v+xuzj8u46devkYZmHG10IimisPmfX+WLx/8+g6qe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-94895e290f3so192362239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:17:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787824; x=1763392624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHAPnYIadeTRfoQn0fqCyJuowvxOpaPE7sm9AepTyPw=;
        b=RcfBFxOwUvaU1mmDgOfSOWpai0DHeZWYz6oiAIfm+0AVZXFyvlJpmEWvZuBBWCOM+w
         RS47nUiaoq9wJg89OwweWXEhc4dbYp6OgfGEUtSzt2CujhUHKnOy6x7iNdeDv/9XjhK8
         w/f7QF73nsLDYFA0FJxMDqcnteESaWslVvSsPBHctRCaD1Hs+K5+o+bLdvks9JWY8wx6
         mR2zRJG94C2cMvT8UR/VXG2meCOTaxo/Ic9LSWkSkBVi2/O5RijosF7e1fJgF7plU1EN
         4WrWlynv7YSXyiMNWKhwX3dnjZ+MbnYks2ncMLFC+vuGpTi+bn7PTwFCR5rMuvMMlQ15
         C2gg==
X-Forwarded-Encrypted: i=1; AJvYcCXzlUmIA2pZL0a4sTXyU0jDKNDX+Vdc4Ao5dNRV9c4ISmk0t9uR5zMSQc+Vq+8v3jUY4oujMFqOzPoc0EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmauTekPZhLJtm7KW/1QCzeX40/4jPkFkfoX/ENMvAkjXD3L7G
	VOJu0y5/kLHS670148dwaKBAeHTGIJjLNKf2dCg/x5e3kAMLwBYeK5Usix1jq2yjA+RHNfjLi6c
	IXAU9cFbOAuZsWdpYnSC0BwebDcpkb0RXrFLk6lzGP5MzFqHiyWZtvx+D5cQ=
X-Google-Smtp-Source: AGHT+IHdHpWt/oOhZg5oTnRUqcPDrPHKOLr/J02iuJtvpOzFzj/XRoCfZ2U/bUx/sbpCvI1hmrCp+hCtE22kgfIMp01jGA+HYe8r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1492:b0:948:a28c:fa00 with SMTP id
 ca18e2360f4ac-948a28cfd90mr608512939f.1.1762787824130; Mon, 10 Nov 2025
 07:17:04 -0800 (PST)
Date: Mon, 10 Nov 2025 07:17:04 -0800
In-Reply-To: <tencent_D1BC2D0D6C889484EB5AEC9ECC9C78766C0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691201f0.a70a0220.22f260.00f6.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
From: syzbot <syzbot+08df3e4c9b304b37cb04@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in lbmIOWait

INFO: task syz-executor:6322 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21000 pid:6322  tgid:6322  ppid:1      task_flags:0x400140 flags:0x00080003
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 io_schedule+0x81/0xe0 kernel/sched/core.c:7871
 lbmIOWait+0x189/0x6a0 fs/jfs/jfs_logmgr.c:2152
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
RIP: 0033:0x7f3488f909f7
RSP: 002b:00007fff27296f08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f3489011d7d RCX: 00007f3488f909f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff27296fc0
RBP: 00007fff27296fc0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff27298050
R13: 00007f3489011d7d R14: 000000000002bbc3 R15: 00007fff27298090
 </TASK>
INFO: task syz-executor:6326 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21768 pid:6326  tgid:6326  ppid:1      task_flags:0x400140 flags:0x00080003
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
RIP: 0033:0x7f00d3ed09f7
RSP: 002b:00007ffebb033f08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f00d3f51d7d RCX: 00007f00d3ed09f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffebb033fc0
RBP: 00007ffebb033fc0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffebb035050
R13: 00007f00d3f51d7d R14: 000000000002c600 R15: 00007ffebb035090
 </TASK>
INFO: task syz-executor:6328 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21672 pid:6328  tgid:6328  ppid:1      task_flags:0x400140 flags:0x00080003
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
RIP: 0033:0x7ff3df4b09f7
RSP: 002b:00007ffd1a51e4a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007ff3df531d7d RCX: 00007ff3df4b09f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd1a51e560
RBP: 00007ffd1a51e560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd1a51f5f0
R13: 00007ff3df531d7d R14: 000000000002bde0 R15: 00007ffd1a51f630
 </TASK>
INFO: task syz-executor:6332 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21000 pid:6332  tgid:6332  ppid:1      task_flags:0x400140 flags:0x00080003
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
RIP: 0033:0x7fee8a9909f7
RSP: 002b:00007ffd370c5f48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fee8aa11d7d RCX: 00007fee8a9909f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd370c6000
RBP: 00007ffd370c6000 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd370c7090
R13: 00007fee8aa11d7d R14: 000000000002c444 R15: 00007ffd370c70d0
 </TASK>
INFO: task syz-executor:6334 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21128 pid:6334  tgid:6334  ppid:1      task_flags:0x400140 flags:0x00080002
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
RIP: 0033:0x7f54847409f7
RSP: 002b:00007ffffb9ab768 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f54847c1d7d RCX: 00007f54847409f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffffb9ab820
RBP: 00007ffffb9ab820 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffffb9ac8b0
R13: 00007f54847c1d7d R14: 000000000002c760 R15: 00007ffffb9ac8f0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/38:
 #0: ffffffff8d5aa840 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d5aa840 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8d5aa840 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5556:
 #0: ffff88823bf520a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e8b2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x444/0x1400 drivers/tty/n_tty.c:2222
2 locks held by syz-executor/6322:
 #0: ffff8880378700d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880378700d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880378700d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6326:
 #0: ffff8880234ac0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880234ac0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880234ac0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6328:
 #0: ffff88805973a0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88805973a0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88805973a0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6332:
 #0: ffff8880322ce0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880322ce0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880322ce0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6334:
 #0: ffff8880591020d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880591020d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880591020d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6887:
 #0: ffff8880326a40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880326a40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880326a40d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6890:
 #0: ffff88803ba640d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff88803ba640d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff88803ba640d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6910:
 #0: ffff8880387200d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880387200d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880387200d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6911:
 #0: ffff8880570960d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880570960d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880570960d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by syz-executor/6912:
 #0: ffff888061dcc0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888061dcc0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888061dcc0d0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffffffff8d9dfab8 (jfs_log_mutex){+.+.}-{4:4}, at: lmLogClose+0xb4/0x520 fs/jfs/jfs_logmgr.c:1443
2 locks held by kworker/u8:11/7073:
5 locks held by kworker/u8:12/7077:
2 locks held by syz.4.255/7597:
3 locks held by syz.3.256/7599:
2 locks held by syz.0.257/7601:
2 locks held by syz.1.258/7603:
2 locks held by syz.2.259/7605:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 7077 Comm: kworker/u8:12 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events_unbound nsim_dev_trap_report_work
RIP: 0010:arch_irqs_disabled_flags arch/x86/include/asm/irqflags.h:146 [inline]
RIP: 0010:check_preemption_disabled+0x5c/0x120 lib/smp_processor_id.c:19
Code: 04 e2 06 48 3b 4c 24 08 0f 85 cc 00 00 00 48 83 c4 10 5b 41 5e 41 5f 5d e9 d1 a3 03 00 cc 48 c7 04 24 00 00 00 00 9c 8f 04 24 <f7> 04 24 00 02 00 00 74 c8 65 4c 8b 3c 25 08 90 a2 91 41 f6 47 2f
RSP: 0018:ffffc9000598f2c0 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000080000000
RDX: 0000000000000000 RSI: ffffffff8cda17fc RDI: ffffffff8b3ddd60
RBP: ffffffff81737c15 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc9000598f4c8 R11: fffff52000b31ea5 R12: 0000000000000002
R13: ffffffff8d5aa840 R14: 0000000000000000 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff888126ef7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2cf74bd000 CR3: 000000003573c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lockdep_recursion_inc kernel/locking/lockdep.c:465 [inline]
 lock_acquire+0xe7/0x360 kernel/locking/lockdep.c:5867
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xc2/0x2390 arch/x86/kernel/unwind_orc.c:479
 __unwind_start+0x5b9/0x760 arch/x86/kernel/unwind_orc.c:758
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe4/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6634 [inline]
 kfree+0x197/0x950 mm/slub.c:6841
 skb_release_data+0x62d/0x7c0 net/core/skbuff.c:1087
 skb_release_all net/core/skbuff.c:1152 [inline]
 __kfree_skb net/core/skbuff.c:1166 [inline]
 consume_skb+0x9e/0xf0 net/core/skbuff.c:1398
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:836 [inline]
 nsim_dev_trap_report_work+0x7fa/0xbc0 drivers/net/netdevsim/dev.c:866
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         e9a6fb0b Linux 6.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b79a58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152e1a92580000


