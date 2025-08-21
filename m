Return-Path: <linux-kernel+bounces-778794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B621B2EB22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B03188168A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26C22D979E;
	Thu, 21 Aug 2025 02:14:34 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70591DD543
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755742474; cv=none; b=QTPt3NrwvGyUeaBqgLwtd0+YoeSTBsJ12lTyMnKKu1GZ57lCrcL2AgSbGd0sNO+ZZP/JGJGDiQtVgescAzx9d0rkqRUtW3v9QemsZJAOVhFkSta/+Nklrc8fxDV31g1mBkd/42ifhXvBrPqbv8LPtAq2HvPRow+yajDgqyvc1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755742474; c=relaxed/simple;
	bh=c1JzjzcqhHeqb50RUyDDT9Y98mtiHK/L6+DIp7oHAW8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e32VpbwiUAdgftwRcxfP+hE0kgL2gc8T0clBhs/d0Va/Q5jC/jm74AHDow2gX8PVXwXEqBvX9huxptIiFz8NLaybn5XuSipycrrB+QclQ64jfNe9umh917qol4doWytZ2D+kXyIThkhzjhc7mGnRCPNVvCZZmdzqF4JBc798FEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3e6e61caf71so5957685ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755742472; x=1756347272;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQxHRgeChNTxbLV3131Rwb52VhDI/1dYJc8+5cwgx30=;
        b=Sz/RN2GpzagDFOcQUnudi4eh2ctYt/WVfbCAHlU4+UMa4eld2TqUcAVbLgAi7SNaOc
         kBm4PvmJjTmXU4frxi+BV9aTxz38ZG6XC0WwSQJa4J9L2ZvoYNEZLoFqt4ii1JGR1E/O
         d7GUwgrzVmIlVnE2olto1ee+Vh+P0985zkLa9asjV9ZsdSoSdQ+RLruo0xMjNjf0CWhz
         x7PnHCfXCpSnD6MY+foNhrXxOts48ItQjcfSZkjta1X7MJdbB/NT8PD3nYPRuXAlOHWn
         nIeONksRCyYsZG3qoRzrYHJOiGZ6FRhV+QwiPSIT5Z1i2+9UYky26fzKMY0qid+FADF0
         uTWA==
X-Forwarded-Encrypted: i=1; AJvYcCVavxT/D/TfjRBgBWdAQC1WDARy/YjpnuEMLr8wp3dTxzI49QcmHhBm+GmS/hBEmrZr7yiCUpVnyz4/k8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73HlpJha8H5v0mCwo9ffDC5kJuOUkpRQuH7Z35QUKE/2dtJUz
	2J8526JHsiEZHBFoCSkj7u+54NvQyhgXztcc6LZSRdY3Yd7ABcfptklqQoGlprb8YEgmcLrxHE0
	nsGz408+yWsWWCypGrnJ7ofoAzcrRlfmNLKpLhn3JPfLJgLNIheyG3Wmu56w=
X-Google-Smtp-Source: AGHT+IHGC44FrRLwYHhyTjthukMc8igcR3mKads8/zioUjdqWD2TAcdwPDOGULm4I7iJqaRzfo/oKWobKAXoZpW4bMxv5gyafIMf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:158b:b0:3e5:8249:e973 with SMTP id
 e9e14a558f8ab-3e6d7b4aa01mr14110555ab.16.1755742471892; Wed, 20 Aug 2025
 19:14:31 -0700 (PDT)
Date: Wed, 20 Aug 2025 19:14:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a68107.050a0220.1f0557.0000.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in hub_event (2)
From: syzbot <syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90d970cade8e Merge tag 'ata-ata-6.17-rc2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1193b3a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5d01e11121d45
dashboard link: https://syzkaller.appspot.com/bug?extid=039eab266c6321a174bd
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/104fc9d3de89/disk-90d970ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/59eb5344d41f/vmlinux-90d970ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0bed540b10c/bzImage-90d970ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+039eab266c6321a174bd@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P9643/1:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=87629, q=1145 ncpus=2)
task:kworker/1:13    state:R  running task     stack:22384 pid:9643  tgid:9643  ppid:2      task_flags:0x4288060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
 irqentry_exit+0x36/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:185 [inline]
RIP: 0010:write_comp_data+0x3c/0x90 kernel/kcov.c:246
Code: 8b 05 58 b3 1a 12 a9 00 01 ff 00 74 1d f6 c4 01 74 67 a9 00 00 0f 00 75 60 a9 00 00 f0 00 75 59 8b 82 3c 16 00 00 85 c0 74 4f <8b> 82 18 16 00 00 83 f8 03 75 44 48 8b 82 20 16 00 00 8b 92 1c 16
RSP: 0000:ffffc90004fdf430 EFLAGS: 00000246
RAX: 0000000080000000 RBX: 0000000000000004 RCX: ffffffff822dbf07
RDX: ffff88802883a440 RSI: 0000000000000004 RDI: 0000000000000006
RBP: 0000000000000003 R08: 0000000000000006 R09: 0000000000000004
R10: 0000000000000003 R11: 00000000000082fe R12: ffff8880200096f0
R13: ffff8880200096ec R14: 0000000000000002 R15: dffffc0000000000
 __page_table_check_zero+0x207/0x5d0 mm/page_table_check.c:139
 page_table_check_free include/linux/page_table_check.h:43 [inline]
 free_pages_prepare mm/page_alloc.c:1396 [inline]
 __free_frozen_pages+0x7b7/0x10f0 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2753 [inline]
 __put_partials+0x165/0x1c0 mm/slub.c:3218
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_node_noprof+0x1d5/0x3b0 mm/slub.c:4281
 __alloc_skb+0x2b2/0x380 net/core/skbuff.c:659
 alloc_skb include/linux/skbuff.h:1336 [inline]
 alloc_uevent_skb+0x7d/0x210 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 kobject_uevent_env+0xca4/0x1870 lib/kobject_uevent.c:608
 device_del+0x623/0x9f0 drivers/base/core.c:3896
 usb_disable_device+0x355/0x7d0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x9c0 drivers/usb/core/hub.c:2344
 hub_port_connect drivers/usb/core/hub.c:5406 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
 port_event drivers/usb/core/hub.c:5870 [inline]
 hub_event+0x1c81/0x4fe0 drivers/usb/core/hub.c:5952
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

