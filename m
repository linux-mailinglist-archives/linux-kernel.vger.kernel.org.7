Return-Path: <linux-kernel+bounces-728501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF578B02917
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F26166CB5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C201E5B97;
	Sat, 12 Jul 2025 03:13:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29519366
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752289984; cv=none; b=orPH4z1QUnUP9h3S8DvuBRqTJyJDm0fZAy7nbimdBNE6beZGpmqko7ZM2M95lFrUSr6WgWy/ftbkndETvdTDMe7l1F7ObCqzJdCJcfOmgx2jvvTki6uS6FjrQYwFXDIAkZjtAzhzN85C83ZeHqdrsEeYLpnaYxQM1lUJ4Cluh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752289984; c=relaxed/simple;
	bh=/+GZyBPScwhjzMiVIDag/YDpugRDW2eoehsB3eIDca8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z3ZhvA3+/VmBc9+M3JtM93Dx6Zsn85Cx86qEi8FIuL9soDIvXLksprqRmDIw+wx2IwGMEjMF90ENGYdyXIaygFn/6UmQVYS/FixlxuX6WobPThLz9Q8wfgIZFCiXW03UlB3suJhbbbL6FMB8/7cgOOOVHiJWiirsOvKW1YgxkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df33d97436so41345855ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752289982; x=1752894782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3U3nkIcE8/HxN15l9rYvVbPru57Boa++n2x0cEqWWw=;
        b=dAs4d0kLhs+5wwvRiJdIK5xC166myWGBLJdkjC8qO6T5Pp+6dAkP9og9b0i2Z7JWt2
         vbb8M0ec5Qfu1sB0xetMxYjsouTyqZvZN9W2KnTgj/dO7oQqJkjbtWmSINi9i3Qgi3Xm
         lLwM0n+nxI/IaxkoC5r6CAd6tEEgv2RHYX3I4Z42o9QnTkRx3gaRBLnkxmYnbe2Afclk
         qheX5BvITeoNaPTEoix064onhB0mloa7JLxOSZUCiqeSKw1237gALqr1PNZaxVfBuVJ+
         wEHSofN6BpRWDga3Qg3gHhYuGzDin9f58LDh7Sa9NReqbMH561AAzKpZGHd5csOqH6Ip
         aHhA==
X-Forwarded-Encrypted: i=1; AJvYcCVoxYVtniiXYBOoCEb2F8MiG9BC0QAV3hxvzCOhclguZ3lfvzZY7mZUY2+TNaK2PcW2w9UbnajKo7NoviE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZSSydYdmYPCsrtFJ5gLyNmT/wxm3N4RgH26ZMskdZY2P0m2K
	DjfK2K0FfhTOs9e5obi6L3bfWHmeqJFQ/zvdlqYBrbMPEyH0dAFffZ4y+7f1obD56VKmOzjjgSP
	8xDy1M0oF3z6xYxUnIaLX3C0t8mZGIY2awEOQc80nxlE70V50wN1ie9L6hcE=
X-Google-Smtp-Source: AGHT+IGYY8TcnFXC+I57BLNdz99IHvRA1lKHohHS/8qaSmn2+J/82nLOmNmphdgmjfhvBBUQwDJbMmtwdsdTdT+cIYeoGHuswoB/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:440e:20b0:3e1:3491:e873 with SMTP id
 e9e14a558f8ab-3e244714c56mr80446255ab.10.1752289982220; Fri, 11 Jul 2025
 20:13:02 -0700 (PDT)
Date: Fri, 11 Jul 2025 20:13:02 -0700
In-Reply-To: <20250712015455.3638-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871d2be.a00a0220.26a83e.006c.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in kvfree_call_rcu

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 00000000a7543a3e object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 7506 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 0 PID: 7506 at lib/debugobjects.c:615 debug_object_activate+0x344/0x460 lib/debugobjects.c:842
Modules linked in:
CPU: 0 UID: 0 PID: 7506 Comm: syz.0.17 Not tainted 6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
sp : ffff80009dfa76d0
x29: ffff80009dfa76d0 x28: ffff8000976d8000 x27: dfff800000000000
x26: ffff80008afc2440 x25: 0000000000000001 x24: ffff8000891ac400
x23: 0000000000000003 x22: ffff80008b5399e0 x21: 0000000000000000
x20: ffff80008afc2440 x19: ffff8000891ac400 x18: 00000000ffffffff
x17: 3361333435376130 x16: ffff80008aefc4e0 x15: 0000000000000001
x14: 1fffe000337d40e2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000337d40e3 x10: 0000000000ff0100 x9 : 5a9d706c208ebc00
x8 : 5a9d706c208ebc00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009dfa7018 x4 : ffff80008f766be0 x3 : ffff8000807bcfac
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
irq event stamp: 677
hardirqs last  enabled at (676): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (676): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (677): [<ffff80008aef6eac>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (152): [<ffff8000801fd5e4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (652): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 00000000a7543a3e object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 7506 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 0 PID: 7506 at lib/debugobjects.c:615 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
Modules linked in:
CPU: 0 UID: 0 PID: 7506 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
sp : ffff80009dfa76c0
x29: ffff80009dfa76d0 x28: ffff80008f671000 x27: dfff800000000000
x26: 0000000000000003 x25: 0000000000000000 x24: ffff0000d4905c40
x23: 0000000000000001 x22: ffff80008afc2440 x21: ffff80008b5399e0
x20: 0000000000000000 x19: ffff8000891ac400 x18: 00000000ffffffff
x17: 3537613030303030 x16: ffff80008ae63d88 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : 5a9d706c208ebc00
x8 : 5a9d706c208ebc00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009dfa7018 x4 : ffff80008f766be0 x3 : ffff80008054d314
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
irq event stamp: 705
hardirqs last  enabled at (704): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (704): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (705): [<ffff80008aef6eac>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (152): [<ffff8000801fd5e4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (652): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kvfree_call_rcu(): Double-freed call. rcu_head 00000000a7543a3e
WARNING: CPU: 0 PID: 7506 at mm/slab_common.c:1956 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
Modules linked in:
CPU: 0 UID: 0 PID: 7506 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
lr : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
sp : ffff80009dfa7730
x29: ffff80009dfa7730 x28: 00000000fffffff5 x27: 1fffe0001c73d6c3
x26: dfff800000000000 x25: ffff0000e39eb61e x24: ffff0000ecbc8000
x23: ffff8000891ac400 x22: 00000000ffffffea x21: ffff8000891ac400
x20: ffff8000891ac400 x19: ffff80008afc2440 x18: 00000000ffffffff
x17: 0000000000000000 x16: ffff80008ae63d88 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : 5a9d706c208ebc00
x8 : 5a9d706c208ebc00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009dfa7078 x4 : ffff80008f766be0 x3 : ffff80008054d314
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
irq event stamp: 729
hardirqs last  enabled at (728): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (728): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (729): [<ffff80008aef6eac>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (152): [<ffff8000801fd5e4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (652): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=157b9e8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c39e8c580000


