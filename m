Return-Path: <linux-kernel+bounces-728889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E892FB02E84
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 04:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531584A1E47
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CB515442A;
	Sun, 13 Jul 2025 02:59:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347184414
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752375548; cv=none; b=eJQLoQ5u+XNpc5ukI5iUryUlbWSHYVILhPFzb5QZZjSfQtq+JdT5GNo/G4MrdKFXyb2cjClQ2a3ffbOtdt5yPH7piFQsh0VsALCpMaBRXrLwqCPjNoERBP7YwVgGNzOXCILDxYNli1YgfW38kKH/LmfQHc/zzdMQz66tM+BHrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752375548; c=relaxed/simple;
	bh=bNImPHvpt11Y/R7Xm/Oq6zJB3/jSYbX8lVke7+114iI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fB6r12xc263fLDUU+daWwEDqBPLPkdN5gZAy0ZTGsNTofkdJHp4cNtS80ZGz2jwmR+CI1jawsAaPolwMYTNt+OFVH1iOWaJ12EXjsVYneAqBZJ/FT7gFcCXd/UqpVO/uItJes/2mzxG4FNaXyxTBBAHv642GTT99waI5CDO/GQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cfea700daso316986939f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 19:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752375545; x=1752980345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0+nkX5sbyYcbvxA/dmp1LS3h3TjqpJFSJau0ZDPu9A=;
        b=BkTA20IzVYEkzDEBEvO5SV+iOiRCfynZw3/nWJqA65Tv4MFx1CEUyfpk2mv+2pHUgP
         TXlG9cgs9x0yfiyJuRWkOj035hhtWFnOe2omsTHSMOkUPFdDHF3XrYBJOtixhGc3HUxx
         LZ2QcX6d6O7OCcpaMXU0QbA3Kt4mCrIElKEZkG8I8zcvDs3SOaOn5jQ1fXOAXfrBeO2I
         cbN5Wb0hd2MCrN3n4mfujtjLZULUL2c6Xbeh2hQN4fCUGGc70ejrRJalkYlSn6FxONvT
         pZGvCOPHtN+XAK5KOYObTcOr8xpCnSQ9Wy7IcaZ3bp6MJ3FKZCIG8jNdYKAU0uUSw47z
         MX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzEjZ2ZUtHFjdv8uRMcgBSluqg4oHDafm5ykooDcAzNdhciwyHEnGyhtcHWoKynrtJ7CQuyFiVXEa1f5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdfXGWNoGy+4g6e1nfAp8/xOQNYGRP5Uif1+LTZQDAP5QmUdW
	OS7qtv9HlIDjiksPmEnbkuMiHt/ct9+RsmXlnhxBhrI7PTI4QAh9mqEz5jS5r2gIhRnpPV2XMmT
	+s0B/5LdAXBYSKul8Vs5Nvyc2lT4k86vCvJkxhhoC5EbQV3fWozmtgrC+UVI=
X-Google-Smtp-Source: AGHT+IGWkUlnSHunvNdaEN23Zd7uiwu8popSx6gr02onjuIvKiiABMzS36rNHovuIPbTXItdK9QKIht22NKcOaRK4rIdt89SU/z3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160a:b0:867:6c90:4867 with SMTP id
 ca18e2360f4ac-87978fec056mr939275839f.14.1752375545259; Sat, 12 Jul 2025
 19:59:05 -0700 (PDT)
Date: Sat, 12 Jul 2025 19:59:05 -0700
In-Reply-To: <20250713023853.3772-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687320f9.a70a0220.3b380f.001c.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in kvfree_call_rcu

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 00000000c37e5253 object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 7470 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 1 PID: 7470 at lib/debugobjects.c:615 debug_object_activate+0x344/0x460 lib/debugobjects.c:842
Modules linked in:
CPU: 1 UID: 0 PID: 7470 Comm: syz.0.17 Not tainted 6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
sp : ffff80009c7b76d0
x29: ffff80009c7b76d0 x28: ffff8000976d8000 x27: dfff800000000000
x26: ffff80008afc2440 x25: 0000000000000001 x24: ffff8000891ac400
x23: 0000000000000003 x22: ffff80008b5399e0 x21: 0000000000000000
x20: ffff80008afc2440 x19: ffff8000891ac400 x18: 0000000000000000
x17: 3532356537336330 x16: ffff80008aefc498 x15: 0000000000000001
x14: 1fffe000337d88e2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000337d88e3 x10: 0000000000ff0100 x9 : 6dd603b02563fa00
x8 : 6dd603b02563fa00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c7b7018 x4 : ffff80008f766be0 x3 : ffff8000807bcfac
x2 : 0000000000000001 x1 : 0000000100000201 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:612 [inline] (P)
 debug_object_activate+0x344/0x460 lib/debugobjects.c:842 (P)
 debug_rcu_head_queue kernel/rcu/rcu.h:236 [inline]
 kvfree_call_rcu+0x4c/0x3f0 mm/slab_common.c:1953
 cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
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
irq event stamp: 179
hardirqs last  enabled at (178): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (178): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (179): [<ffff80008aef6e64>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (126): [<ffff800089198d40>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (126): [<ffff800089198d40>] release_sock+0x14c/0x1ac net/core/sock.c:3776
softirqs last disabled at (154): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 00000000c37e5253 object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 7470 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 1 PID: 7470 at lib/debugobjects.c:615 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
Modules linked in:
CPU: 1 UID: 0 PID: 7470 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
sp : ffff80009c7b76c0
x29: ffff80009c7b76d0 x28: ffff80008f671000 x27: dfff800000000000
x26: 0000000000000003 x25: 0000000000000000 x24: ffff0000efd288f8
x23: 0000000000000001 x22: ffff80008afc2440 x21: ffff80008b5399e0
x20: 0000000000000000 x19: ffff8000891ac400 x18: 0000000000000000
x17: 3733633030303030 x16: ffff80008ae63d48 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : 6dd603b02563fa00
x8 : 6dd603b02563fa00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c7b7018 x4 : ffff80008f766be0 x3 : ffff80008054d314
x2 : 0000000000000000 x1 : 0000000100000201 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:612 [inline] (P)
 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064 (P)
 debug_rcu_head_queue kernel/rcu/rcu.h:237 [inline]
 kvfree_call_rcu+0x64/0x3f0 mm/slab_common.c:1953
 cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
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
irq event stamp: 205
hardirqs last  enabled at (204): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (204): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (205): [<ffff80008aef6e64>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (126): [<ffff800089198d40>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (126): [<ffff800089198d40>] release_sock+0x14c/0x1ac net/core/sock.c:3776
softirqs last disabled at (154): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kvfree_call_rcu(): Double-freed call. rcu_head 00000000c37e5253
WARNING: CPU: 1 PID: 7470 at mm/slab_common.c:1956 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
Modules linked in:
CPU: 1 UID: 0 PID: 7470 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
lr : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
sp : ffff80009c7b7730
x29: ffff80009c7b7730 x28: 00000000fffffff5 x27: 1fffe00018c336a3
x26: dfff800000000000 x25: ffff0000d49487ee x24: 0000000000000017
x23: ffff8000891ac400 x22: 00000000ffffffea x21: ffff8000891ac400
x20: ffff8000891ac400 x19: ffff80008afc2440 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008ae63d48 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : 6dd603b02563fa00
x8 : 6dd603b02563fa00 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c7b7078 x4 : ffff80008f766be0 x3 : ffff80008054d314
x2 : 0000000000000000 x1 : 0000000000000201 x0 : 0000000000000000
Call trace:
 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955 (P)
 cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
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
irq event stamp: 229
hardirqs last  enabled at (228): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (228): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (229): [<ffff80008aef6e64>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (126): [<ffff800089198d40>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (126): [<ffff800089198d40>] release_sock+0x14c/0x1ac net/core/sock.c:3776
softirqs last disabled at (154): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16a8018c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b0018c580000


