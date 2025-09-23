Return-Path: <linux-kernel+bounces-829323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54DFB96CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B531690AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8C30F554;
	Tue, 23 Sep 2025 16:22:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004472701DC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644551; cv=none; b=KZdma0/VRChtq05pYmVWQSXlNsI718cf9jtgXAOAnv5eljCQco4l/8FnYujT83rRzh5h8kpXUFlX/txAlAi362kqG/E1emIlORAvLrcRfP7Hzv2CtG0O8WSa+NIkcLJvIYwMCuWPIcl7qgotNYJubzs9w4kmHjnpeqxrYryz+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644551; c=relaxed/simple;
	bh=zUt95NXzQVekPw1QiJmN+19DOtqkjLGuu95xE/jocbg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YCu/hcrrE4UG5WC3rCzCQwrT1rMJqAUddrnSyt6gBrIahndiRJfwJMlW226jcb7c9YAFJBWeBMPfaoZjsw3FcCMusLvJloKHR5GlA5eqp3TcieoG96O5BQxFv8saSpJHdvYuuj50cQvRkqeTcfyYcFNs8UweIvwHKPGHH8I3QyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4257a4638e0so31113995ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644548; x=1759249348;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fliOmompFcXDPLp5fyc4D6gMx/asPNTMNLo+cXzT8zs=;
        b=W/0tfCPHoH/WvJJ82IAiFC/iy/fTpkjDF0+NYmddP0Pegu9swn8cTlsqa1In1IthtN
         BbxkuXGL1B84Nmnag4X/w6EWxBNIxbvtolyzMmrUENy5fn1FXrmNWmGe+gWIYyHsO4xR
         EuinS2ZBTHzRwkg6L7QFEmhKP7YgN8+M3p20SWThd6+Nyy8juuQycVZiVWwZvqMJRGEg
         p562U7MF0DyXsn45PKMxALhfdth0ccJIM0Iao43Gqd8GViZ2TSYsgEeZyh+IbVnBvNYr
         cUzDg84s1A3A/zb0zVxopoA1V4GagZ1+bVTONLdwDW1bfiRoQ4q3hmsPt3Dh0FvK7O86
         Wspw==
X-Forwarded-Encrypted: i=1; AJvYcCUEW1H8SeVK6zcAOI4iMAxCAaThYBPIyQQ/1uatDQrdoKtibDxZvJqb6aUihLi5DDhx+65WWBRPkX5oCyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJxtP5yVZE9J3fvQ4Gvhd4hgAwfzPlDtZ440x38dCizolT1k7
	6rnz1Qta4ojNZjfq6Mm4LJ/KIA8cvSHDONeI2QuaIzUUMCZf4Ujolao810yCB3pcEm+/w5w2qrs
	z2PcWzXTo5W07QO3H+AJXZh0KDRLLig7BuqHV2SWvkUkY1D1GgSgnrS/B4yE=
X-Google-Smtp-Source: AGHT+IHfgRC8BMqPaFSbGMJttCZaLVnmtyUOI5o+nYBtHge6b9pil9feGS+SabO7G3WmYb+l+4tOu/L7GNki4CrWFHoNGql+MRnS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:425:6f0b:a1db with SMTP id
 e9e14a558f8ab-42581e28e41mr43633795ab.9.1758644547759; Tue, 23 Sep 2025
 09:22:27 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:22:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in memory_failure
From: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linmiaohe@huawei.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nao.horiguchi@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5db4add5e77 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10edb8e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2ae34a0711ff2f1
dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14160f12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361627c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6eee2232d5c1/disk-b5db4add.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8b00f2f1234/vmlinux-b5db4add.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc0d466f156c/Image-b5db4add.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com

Injecting memory failure for pfn 0x104000 at process virtual address 0x20000000
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6700 at mm/memory-failure.c:2391 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
Modules linked in:
CPU: 1 UID: 0 PID: 6700 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
lr : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
sp : ffff8000a41478c0
x29: ffff8000a41479a0 x28: 05ffc00000200868 x27: ffff700014828f20
x26: 1fffffbff8620001 x25: 05ffc0000020086d x24: 1fffffbff8620000
x23: fffffdffc3100008 x22: fffffdffc3100000 x21: fffffdffc3100000
x20: 0000000000000023 x19: dfff800000000000 x18: 1fffe00033793888
x17: ffff80008f7ee000 x16: ffff80008052aa64 x15: 0000000000000001
x14: 1fffffbff8620000 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8620001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d7eedb80 x7 : ffff800080428910 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff800080cf5438
x2 : 0000000000000001 x1 : 0000000000000040 x0 : 0000000000000000
Call trace:
 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391 (P)
 madvise_inject_error mm/madvise.c:1475 [inline]
 madvise_do_behavior+0x2c8/0x7c4 mm/madvise.c:1875
 do_madvise+0x190/0x248 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __arm64_sys_madvise+0xa4/0xc0 mm/madvise.c:1985
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 1544
hardirqs last  enabled at (1543): [<ffff80008b042cd0>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (1543): [<ffff80008b042cd0>] _raw_spin_unlock_irq+0x30/0x80 kernel/locking/spinlock.c:202
hardirqs last disabled at (1544): [<ffff80008b01a1ac>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (1528): [<ffff8000803da960>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (1528): [<ffff8000803da960>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (1397): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---
Memory failure: 0x104000: recovery action for huge page: Recovered
Injecting memory failure for pfn 0x131e00 at process virtual address 0x20200000
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6700 at mm/memory-failure.c:2391 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
Modules linked in:
CPU: 1 UID: 0 PID: 6700 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
lr : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
sp : ffff8000a41478c0
x29: ffff8000a41479a0 x28: 05ffc00000200868 x27: ffff700014828f20
x26: 1fffffbff878f001 x25: 05ffc0000020086d x24: 1fffffbff878f000
x23: fffffdffc3c78008 x22: fffffdffc3c78000 x21: fffffdffc3c78000
x20: 0000000000000023 x19: dfff800000000000 x18: 00000000ffffffff
x17: ffff80009353a000 x16: ffff80008052aa64 x15: 0000000000000001
x14: 1fffffbff878f000 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff878f001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d7eedb80 x7 : ffff800080a549a8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080cf5438
x2 : 0000000000000001 x1 : 0000000000000040 x0 : 0000000000000000
Call trace:
 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391 (P)
 madvise_inject_error mm/madvise.c:1475 [inline]
 madvise_do_behavior+0x2c8/0x7c4 mm/madvise.c:1875
 do_madvise+0x190/0x248 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __arm64_sys_madvise+0xa4/0xc0 mm/madvise.c:1985
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 2162
hardirqs last  enabled at (2161): [<ffff800080ca8720>] __folio_split+0xf7c/0x1438 mm/huge_memory.c:3856
hardirqs last disabled at (2162): [<ffff80008b01a1ac>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (1726): [<ffff8000803da960>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (1726): [<ffff8000803da960>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (1547): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---
Memory failure: 0x131e00: recovery action for huge page: Recovered
Injecting memory failure for pfn 0x134200 at process virtual address 0x20400000
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6700 at mm/memory-failure.c:2391 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
Modules linked in:
CPU: 1 UID: 0 PID: 6700 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
lr : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
sp : ffff8000a41478c0
x29: ffff8000a41479a0 x28: 05ffc00000200868 x27: ffff700014828f20
x26: 1fffffbff87a1001 x25: 05ffc0000020086d x24: 1fffffbff87a1000
x23: fffffdffc3d08008 x22: fffffdffc3d08000 x21: fffffdffc3d08000
x20: 0000000000000023 x19: dfff800000000000 x18: 1fffe00033793888
x17: 646461206c617574 x16: ffff80008052aa64 x15: 0000000000000001
x14: 1fffffbff87a1000 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff87a1001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d7eedb80 x7 : ffff800080a549a8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080cf5438
x2 : 0000000000000001 x1 : 0000000000000040 x0 : 0000000000000000
Call trace:
 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391 (P)
 madvise_inject_error mm/madvise.c:1475 [inline]
 madvise_do_behavior+0x2c8/0x7c4 mm/madvise.c:1875
 do_madvise+0x190/0x248 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __arm64_sys_madvise+0xa4/0xc0 mm/madvise.c:1985
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 2768
hardirqs last  enabled at (2767): [<ffff800080ca8720>] __folio_split+0xf7c/0x1438 mm/huge_memory.c:3856
hardirqs last disabled at (2768): [<ffff80008b01a1ac>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (2364): [<ffff8000803da960>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (2364): [<ffff8000803da960>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (2321): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---
Memory failure: 0x134200: recovery action for huge page: Recovered
Injecting memory failure for pfn 0x129000 at process virtual address 0x20600000
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6700 at mm/memory-failure.c:2391 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
Modules linked in:
CPU: 1 UID: 0 PID: 6700 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
lr : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
sp : ffff8000a41478c0
x29: ffff8000a41479a0 x28: 05ffc00000200868 x27: ffff700014828f20
x26: 1fffffbff8748001 x25: 05ffc0000020086d x24: 1fffffbff8748000
x23: fffffdffc3a40008 x22: fffffdffc3a40000 x21: fffffdffc3a40000
x20: 0000000000000023 x19: dfff800000000000 x18: 1fffe00033793888
x17: 646461206c617574 x16: ffff80008052aa64 x15: 0000000000000001
x14: 1fffffbff8748000 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8748001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d7eedb80 x7 : ffff800080a549a8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080cf5438
x2 : 0000000000000001 x1 : 0000000000000040 x0 : 0000000000000000
Call trace:
 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391 (P)
 madvise_inject_error mm/madvise.c:1475 [inline]
 madvise_do_behavior+0x2c8/0x7c4 mm/madvise.c:1875
 do_madvise+0x190/0x248 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __arm64_sys_madvise+0xa4/0xc0 mm/madvise.c:1985
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 3024
hardirqs last  enabled at (3023): [<ffff800080ca8720>] __folio_split+0xf7c/0x1438 mm/huge_memory.c:3856
hardirqs last disabled at (3024): [<ffff80008b01a1ac>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (2986): [<ffff8000803da960>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (2986): [<ffff8000803da960>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (2771): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---
Memory failure: 0x129000: recovery action for huge page: Recovered
Injecting memory failure for pfn 0x134600 at process virtual address 0x20800000
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6700 at mm/memory-failure.c:2391 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
Modules linked in:
CPU: 1 UID: 0 PID: 6700 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
lr : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
sp : ffff8000a41478c0
x29: ffff8000a41479a0 x28: 05ffc0000020086c x27: ffff700014828f20
x26: 1fffffbff87a3001 x25: 05ffc0000020186d x24: 1fffffbff87a3000
x23: fffffdffc3d18008 x22: fffffdffc3d18000 x21: fffffdffc3d18000
x20: 0000000000000023 x19: dfff800000000000 x18: 1fffe00033793888
x17: ffff80009353a000 x16: ffff80008052aa64 x15: 0000000000000001
x14: 1fffffbff87a3000 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff87a3001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d7eedb80 x7 : ffff800080a549a8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080cf5438
x2 : 0000000000000001 x1 : 0000000000000040 x0 : 0000000000000000
Call trace:
 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391 (P)
 madvise_inject_error mm/madvise.c:1475 [inline]
 madvise_do_behavior+0x2c8/0x7c4 mm/madvise.c:1875
 do_madvise+0x190/0x248 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __arm64_sys_madvise+0xa4/0xc0 mm/madvise.c:1985
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 3462
hardirqs last  enabled at (3461): [<ffff800080ca8720>] __folio_split+0xf7c/0x1438 mm/huge_memory.c:3856
hardirqs last disabled at (3462): [<ffff80008b01a1ac>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (3064): [<ffff8000803da960>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (3064): [<ffff8000803da960>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (3027): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---
Memory failure: 0x134600: recovery action for huge page: Recovered
Injecting memory failure for pfn 0x134800 at proces
Injecting memory failure for pfn 0x134800 at process virtual address 0x20a00000
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6700 at mm/memory-failure.c:2391 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
Modules linked in:
CPU: 0 UID: 0 PID: 6700 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
lr : memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391
sp : ffff8000a41478c0
x29: ffff8000a41479a0 x28: 05ffc0000020086c x27: ffff700014828f20
x26: 1fffffbff87a4001 x25: 05ffc0000020186d x24: 1fffffbff87a4000
x23: fffffdffc3d20008 x22: fffffdffc3d20000 x21: fffffdffc3d20000
x20: 0000000000000023 x19: dfff800000000000 x18: 1fffe0003378f088
x17: ffff80008f7ee000 x16: ffff80008052aa64 x15: 0000000000000001
x14: 1fffffbff87a4000 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff87a4001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d7eedb80 x7 : ffff800080a549a8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800080cf5438
x2 : 0000000000000001 x1 : 0000000000000040 x0 : 0000000000000000
Call trace:
 memory_failure+0x18ec/0x1db4 mm/memory-failure.c:2391 (P)
 madvise_inject_error mm/madvise.c:1475 [inline]
 madvise_do_behavior+0x2c8/0x7c4 mm/madvise.c:1875
 do_madvise+0x190/0x248 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __arm64_sys_madvise+0xa4/0xc0 mm/madvise.c:1985
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 3538
hardirqs last  enabled at (3537): [<ffff800080ca8720>] __folio_split+0xf7c/0x1438 mm/huge_memory.c:3856
hardirqs last disabled at (3538): [<ffff80008b01a1ac>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (3500): [<ffff8000803da960>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (3500): [<ffff8000803da960>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (3465): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---
Memory failure: 0x134800: recovery action for huge page: Recovered


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

