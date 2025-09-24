Return-Path: <linux-kernel+bounces-830402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF143B998F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE187A1BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A782E6CA7;
	Wed, 24 Sep 2025 11:19:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565AB2AE68
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712749; cv=none; b=PadITubrqh7/MPCjdGamlWbBbyfqY1gUfQmrh5om2xBqeu6b/0warXefVrQvp2k2FT1xpRvxFa8SpGcClll03uNcYgwDWl9ricBzrKSjOtl4PQ1cSK912E7TeizAFLT4US5ZY132/J4qZhVnHVbhSTD0cvhiQZTFW2kuE9wqoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712749; c=relaxed/simple;
	bh=YknrDcOpf/SvyMml11gRcWZN+uxcgDYSCkSDE8ulFL0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZBGRWdeiiF9UfXHqallHl+M9r6+0ZBkZDf1HvtJwhwdUUpNqzoU0VdOxmRD2speq2rSsD5wibwhXtGtnwMzlxb9SvwPuJQ+IRG7Roqg+PiDm9F1wXQ+E+8BWUmmuRJNJeNGC/VJEzSXVu6MkFEwmr6U0mqmYOCRFR/3hnJn0Yvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4247661a0c9so83616155ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758712743; x=1759317543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRK+TFZFSl/pCk/ND6mdOdAey833TmhbyTIAiPEk3PE=;
        b=Nj8m7hJXD5V9uZfSk4vOd/ewtIefbxJjAv2HVIR35osVNaOV7r5jzgCRcJDACOjWEA
         4MDfRdVgRAbtOv0CtEaQkIA3j8MXokKJNRAOurGBU+6+DiSPEpIgucYWFoLqMtfBw6la
         wy2jlJOFGIIRdQ2TjhUWQGr+8EGT+txW3HKEy37YF8Okl7X3E4FyodDgxYArmDR5BS19
         gjI3DmY+UVrlZf+Pa3BBD5vi3ygSz+uh9LUX5Xc4Ec4OtyQaKTvSKnleRnoleOlBP9ed
         gw21ndAPQOclbev99UH5PzInd4bwPb4v6ba1UNKjLGurIAiHmvGLxNjZ8b2n7RpNLcEz
         RDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPPT7Y3phjQxJqozAnU01g5dXBoIpH/uj88Y7JplbusGsNC+qNHffB+e+X66XhgzHCDs4B1DbS1hm86w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztbROq2cMFVkPU+MgXMAZukybgWVD3ruMUyLN2oZPIcIiKnygC
	CHNOWg6J1x2XvrOus/TcRkHLq3RR0Njz91aZld5Lpf00pmZThB3vrs7PDT0sGDjAbAb7aqWsbrV
	1Gr8SBc3GtBtByQamtSE77Q7YAGKBKG/CJAgV7dByA4vK7jUgbAK9dXSU53E=
X-Google-Smtp-Source: AGHT+IGmYbY9poSwwRZ75wJ3lggbvx84fR6SBmnSzFYvkbaRVu1nsRZpDUkkI+k5F2SwKb2v+al5ipAYvwKLlLHtjy5nkjI01fy0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3804:b0:424:8120:546 with SMTP id
 e9e14a558f8ab-42581eca60cmr91654955ab.32.1758712743368; Wed, 24 Sep 2025
 04:19:03 -0700 (PDT)
Date: Wed, 24 Sep 2025 04:19:03 -0700
In-Reply-To: <tencent_7784EEC92ECA4CBAE7CAC6F592CEC6728906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3d3a7.a70a0220.4f78.001c.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in hook_sb_delete

BUG: sleeping function called from invalid context at fs/inode.c:1928
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6483, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz.0.17/6483:
 #0: ffff888028f400e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff888028f400e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff888028f400e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffff888028f40998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff888028f40998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: hook_sb_delete+0xae/0xbc0 security/landlock/fs.c:1405
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 6483 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8960
 iput+0x2b/0xc50 fs/inode.c:1928
 hook_sb_delete+0x6b7/0xbc0 security/landlock/fs.c:1468
 security_sb_delete+0x80/0x150 security/security.c:1467
 generic_shutdown_super+0xaa/0x2c0 fs/super.c:634
 kill_anon_super fs/super.c:1281 [inline]
 kill_litter_super+0x76/0xb0 fs/super.c:1291
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
RIP: 0033:0x7f8b7e78eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8b7f714038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f8b7e9e5fa0 RCX: 00007f8b7e78eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000002c0
RBP: 00007f8b7e811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8b7e9e6038 R14: 00007f8b7e9e5fa0 R15: 00007ffe75b4a848
 </TASK>


Tested on:

commit:         ce7f1a98 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13644f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11724d34580000


