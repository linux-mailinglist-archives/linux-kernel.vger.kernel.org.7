Return-Path: <linux-kernel+bounces-726984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63488B01399
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF0E174D64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6F21D5ABF;
	Fri, 11 Jul 2025 06:31:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997FFBA50
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752215465; cv=none; b=N8RLBGeafB+ZkKvjFEtzVswTzjn1OHCYjF8G14knxYgvbxDrUDCIP7B5BEiMUbixCS5mI3STxBKDut2EdSxY5rUV+N1s/iGRP6LqWHpqdVEesrEEplhaBG/ZD8k9uKw7jebCVWU7HyUouw0T4jMKiQXiPaKilGP7Zb50BreX3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752215465; c=relaxed/simple;
	bh=wESBP5VYY7a3QTcREKd3FKoQcQqoYT6q0uewOpFj6cs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ol9v1xec5cedDIAYcVGpOYs6Jwt5DwWRPRnEu9YJbKE/buKHkHdfgfXtQ2ZH3x8psxkMtWEYQkRXZeTJ0tLezUZYWQQOT7/QtHvcTK73QUsC4CpMoVEsH6SLDUc74ZUupSpAs3JXJGW3I0B2+1Z5Gc0P+iJ4QuTiJccE2lsa+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df2d0b7c7eso17352055ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752215463; x=1752820263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snqN0pQTJooiNXk/r3X1EVEBQCZs0ndGyzwk2y8GQOY=;
        b=HsK9dgmFB5FTrQy+7pwF7xzTRZiC7hKLn3WesF+wSMURvsm11hx3OEF01kqHYTLko/
         5ZtPjT+yuYKhWOADXRO1Mms79XVAdXcDlY9SMVHxyBHI+gNOFfVbNXegYRymDyzJESIO
         Q/vZakGceZZ4xpbh6YQCyVsXFc+usQpQcSOyB+ZEpU4CC5euqmVsLx/2TdOpXYbPOh6K
         g3n5r8OXCfxbVmjzW7ICi7TwIDicusJqBWRPVvoVoCBuGBX1s7ofDc9AoAXjuBcJpKtr
         HBHCzvMMxY0e6dSANepF9FY/D5F3qD3zZU/+yR0a+qacD5pvYiC9M+ZnlFGRWll8UaRB
         OR2g==
X-Forwarded-Encrypted: i=1; AJvYcCXS4/KARuiFx4u7uimV0gUuSivcZ3nfxA6b3yiLtqOst1OvCM5QMvp+67LNBMTsYYXH41/rNH96nY1de0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42ReWHYR3o2iAr+a/WasYT1KAxGNCUys1ZDFnzav/J4m6s/6B
	XkeOGDq6+ogFl3EN5ep/wgN7wRVu+JMBMYgbYje1OCHpPc4UdFRgsF/+pEKMbU4FwV3zG7AczLM
	9U0uV21x4CVNnxQBncwKwJZS5ECmfeHzhURXvaQkOaXbnDnfY68WcVh6uprY=
X-Google-Smtp-Source: AGHT+IHZgudUAop+0TWUZ3pVYa+SnAVu6Opv2k6lpIWjkthHPThZIxxRscfquwOGVi/s7VsQeE3yLbhyTr1c1CznfcyYi5NTBLe6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:398e:b0:3df:3598:7688 with SMTP id
 e9e14a558f8ab-3e25434f9bemr21055195ab.21.1752215462693; Thu, 10 Jul 2025
 23:31:02 -0700 (PDT)
Date: Thu, 10 Jul 2025 23:31:02 -0700
In-Reply-To: <20250711061146.3438-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6870afa6.a00a0220.26a83e.003d.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in kvfree_call_rcu

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 00000000d15d938c object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 7470 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 0 PID: 7470 at lib/debugobjects.c:615 debug_object_activate+0x344/0x460 lib/debugobjects.c:842
Modules linked in:
CPU: 0 UID: 0 PID: 7470 Comm: syz.0.17 Not tainted 6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
sp : ffff80009c3b76d0
x29: ffff80009c3b76d0 x28: ffff8000976d8000 x27: dfff800000000000
x26: ffff80008afc2440 x25: 0000000000000001 x24: ffff8000891ac400
x23: 0000000000000003 x22: ffff80008b5399e0 x21: 0000000000000000
x20: ffff80008afc2440 x19: ffff8000891ac400 x18: 0000000000000000
x17: 3833396435316430 x16: ffff80008aefc458 x15: 0000000000000001
x14: 1fffe000337d40e2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000337d40e3 x10: 0000000000ff0100 x9 : 5688875a670f5200
x8 : 5688875a670f5200 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c3b7018 x4 : ffff80008f766be0 x3 : ffff8000807bcfac
x2 : 0000000000000001 x1 : 0000000100000202 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:612 [inline] (P)
 debug_object_activate+0x344/0x460 lib/debugobjects.c:842 (P)
 debug_rcu_head_queue kernel/rcu/rcu.h:236 [inline]
 kvfree_call_rcu+0x4c/0x3f0 mm/slab_common.c:1953
 cipso_v4_sock_setattr+0x2fc/0x40c net/ipv4/cipso_ipv4.c:1916
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 183
hardirqs last  enabled at (182): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (182): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (183): [<ffff80008aef6e24>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (138): [<ffff8000801fd5e4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (154): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 00000000d15d938c object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 7470 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 0 PID: 7470 at lib/debugobjects.c:615 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
Modules linked in:
CPU: 0 UID: 0 PID: 7470 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
sp : ffff80009c3b76c0
x29: ffff80009c3b76d0 x28: ffff80008f671000 x27: dfff800000000000
x26: 0000000000000003 x25: 0000000000000000 x24: ffff0000d8051c08
x23: 0000000000000001 x22: ffff80008afc2440 x21: ffff80008b5399e0
x20: 0000000000000000 x19: ffff8000891ac400 x18: 0000000000000000
x17: 3531643030303030 x16: ffff80008ae63d08 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : 5688875a670f5200
x8 : 5688875a670f5200 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c3b7018 x4 : ffff80008f766be0 x3 : ffff80008054d314
x2 : 0000000000000000 x1 : 0000000000000202 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:612 [inline] (P)
 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064 (P)
 debug_rcu_head_queue kernel/rcu/rcu.h:237 [inline]
 kvfree_call_rcu+0x64/0x3f0 mm/slab_common.c:1953
 cipso_v4_sock_setattr+0x2fc/0x40c net/ipv4/cipso_ipv4.c:1916
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 211
hardirqs last  enabled at (210): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (210): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (211): [<ffff80008aef6e24>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (138): [<ffff8000801fd5e4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (154): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kvfree_call_rcu(): Double-freed call. rcu_head 00000000d15d938c
WARNING: CPU: 0 PID: 7470 at mm/slab_common.c:1956 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
Modules linked in:
CPU: 0 UID: 0 PID: 7470 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
lr : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
sp : ffff80009c3b7730
x29: ffff80009c3b7730 x28: 00000000fffffff5 x27: 1fffe000199fd6e3
x26: dfff800000000000 x25: ffff0000d20c136e x24: 0000000000000017
x23: ffff8000891ac400 x22: 00000000ffffffea x21: ffff8000891ac400
x20: ffff8000891ac400 x19: ffff80008afc2440 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008ae63d08 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : 5688875a670f5200
x8 : 5688875a670f5200 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c3b7078 x4 : ffff80008f766be0 x3 : ffff80008054d314
x2 : 0000000000000000 x1 : 0000000000000202 x0 : 0000000000000000
Call trace:
 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955 (P)
 cipso_v4_sock_setattr+0x2fc/0x40c net/ipv4/cipso_ipv4.c:1916
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 233
hardirqs last  enabled at (232): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (232): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (233): [<ffff80008aef6e24>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (138): [<ffff8000801fd5e4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (154): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=114d5bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1080a0f0580000


