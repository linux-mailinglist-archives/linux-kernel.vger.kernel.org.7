Return-Path: <linux-kernel+bounces-773118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77512B29B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5503AB3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE82F1FE5;
	Mon, 18 Aug 2025 08:05:35 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9E288C38
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504335; cv=none; b=oyIZff+6G8w7l/bCf+adWQdJfUCyX/LPbZo9jyI1aHnzpVgmXam7eRPtMeEzVRcKT2n17W88MIQheXcQaSkjJshCVP6fUtuu0ofo5Di0yRnmxnqS8qS7FAfucpilqM4kPYHO2iCy2kB5Rn/J8NM391hc4IMyroCxeTTQj6a+Xwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504335; c=relaxed/simple;
	bh=a4ZBaeaat81TbA/Os+ZdroZtm4SKDP4fgmzuH2GFWGE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pv6ndcVsGkf650qUAALAs835IPYnBeW6oZZooWPCH9QHa8nvmtvOydP8lMvibiEzS2vVyN6x+IjNQi9R046vNLGDleFq/txt1RZZ5D9YMMS7D7NzEmZHtYehX55vVywOTnG92TrTmsWXIf6/2kxn8cnk8dIlAoscXz3Prn144lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88432cb438cso1144340639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504333; x=1756109133;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hoYnq8tu/f/pp+xS/pUvHudRCpPlyvqj0ATPUuugBE=;
        b=QslsiRpYW9h6SFCUC7ArgKZ5uBbRrSQZKyZq9pA5nR2flO9Xrg8k5Awqob9cyLrnzC
         WB9vp+t/NG9FWLkfMSu6TGNOcDStoe+E5hAFuwm7BurEQ0Pizs3G7HrEzKujcDtw4Skp
         3netlBnEHq61Ca0Y+znecAM6lXxp3Lj/nQNnez0roaWb+yr0rWxHK3pc962gdMcniT/O
         yohyAOTW/FKLViWVjezIUnqKha+7rhHTkemuxMYMkfc22iEW9VqU7oAek2xFS6RPWw+f
         sbFH8qxz1qTOe5bMobO8V/qRzU20T6N8HOzMN1AoqoxmxxTDnvZ6dr81lamtgg6OV5ZK
         F85A==
X-Forwarded-Encrypted: i=1; AJvYcCXXU5oqH1Pyuzgw1khmPB7JREId3Um6R+iuJsHBE91kCDs/V2BscJ3gG5PQVsvMxv3wqyKs6quyC3uUBcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh79Q0yY3UKi2sfY3k17pCddNxl+9db5wNJA0Y38zJHNLOnLVo
	gsDDpCgjbR0Rgb32i0t+qpk2expvXY2Pv1X36d5PyIusvD3jff1acN3kcsv+kM0yS3qxdDdjUyA
	EvxwFahnkldfSAJnM6ngKtptV145C2+qXFttDZ+oQz+n5M64UtvKEXQPcBM8=
X-Google-Smtp-Source: AGHT+IGSvbbyXY8sid+gEvXSSHKzTgTJErXPd2b7Tin3C8sQLEiyA39Ij1byV/0ci7p3FB0T9y+AG8lAsCN+mkzCRwk25qEzaTeN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c93:b0:87c:2e82:5a6a with SMTP id
 ca18e2360f4ac-8843e3507edmr2378776739f.4.1755504333075; Mon, 18 Aug 2025
 01:05:33 -0700 (PDT)
Date: Mon, 18 Aug 2025 01:05:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2decd.050a0220.e29e5.009a.GAE@google.com>
Subject: [syzbot] [fs?] BUG: sleeping function called from invalid context in
 vfree (2)
From: syzbot <syzbot+f65a2014305525a9f816@syzkaller.appspotmail.com>
To: andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15232442580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=f65a2014305525a9f816
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14cbaba2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1157faf0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f65a2014305525a9f816@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/vmalloc.c:3409
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6664, name: syz-executor
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
no locks held by syz-executor/6664.
Preemption disabled at:
[<ffff80008b015088>] __schedule_loop kernel/sched/core.c:7042 [inline]
[<ffff80008b015088>] schedule+0xac/0x230 kernel/sched/core.c:7058
CPU: 0 UID: 0 PID: 6664 Comm: syz-executor Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 __might_resched+0x348/0x4c4 kernel/sched/core.c:8957
 __might_sleep+0x94/0x110 kernel/sched/core.c:8886
 vfree+0xa0/0x3dc mm/vmalloc.c:3409
 kvfree+0x24/0x40 mm/slub.c:5093
 futex_hash_free+0x84/0x9c kernel/futex/core.c:1742
 __mmdrop+0x2c0/0x4ec kernel/fork.c:692
 mmdrop include/linux/sched/mm.h:55 [inline]
 mmdrop_sched include/linux/sched/mm.h:83 [inline]
 mmdrop_lazy_tlb_sched include/linux/sched/mm.h:110 [inline]
 finish_task_switch+0x4a0/0x5a4 kernel/sched/core.c:5250
 context_switch kernel/sched/core.c:5360 [inline]
 __schedule+0x13b4/0x2864 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:7058
 do_nanosleep+0x174/0x508 kernel/time/hrtimer.c:2100
 hrtimer_nanosleep+0x154/0x2a4 kernel/time/hrtimer.c:2147
 common_nsleep+0xa0/0xb8 kernel/time/posix-timers.c:1353
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1399 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1376 [inline]
 __arm64_sys_clock_nanosleep+0x328/0x364 kernel/time/posix-timers.c:1376
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

