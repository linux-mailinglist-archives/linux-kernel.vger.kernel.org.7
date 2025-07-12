Return-Path: <linux-kernel+bounces-728459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C036DB0286E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9ED858378D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680B3A8C1;
	Sat, 12 Jul 2025 00:49:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9152628D
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281346; cv=none; b=ZGb3aTxcjA1z7YTxmysFRADp2VunNBPE5LkY7XXLHtQ4CiK0kayAU6xGmOv488iWO20F2IZScTzyy4+y99McjfgTmHXghyUnQ2h0RM0yo+UIoMjc3paXCZ805rT7Gzf/icDN0BJa2DFb9vY7+SGaxhCTYuMyo+Co65zjEWRtkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281346; c=relaxed/simple;
	bh=83gJBpbN4iPykGwHnvEGBUCaC7EWABnf++baHBn+2JA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A6PQwBcaLLzssfOVyHAJ08VFB2fQ/HYDm4eIgavccuafzlyYIbEgDc0xAomoqz5Sr/J/tJYGXSwZ5Rk8JRgQcpjUA7JNJV2I7ibjHO5T3ebCA0YQkSBlxS0OOEhj1OVPalevegj5g+PBoaXCtoF/VjGQFMvg+SoG7b3w3ZhoGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86d07944f29so520629639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281344; x=1752886144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhGY1YWOUu1ui8/V8g4iwgThJpcVEjr+kTblzqdnY7I=;
        b=CXvW6IpC0+dw4mi7Jl8eGDUs7vcO6rxuoWp/EZ5gsa65l9d4uHC6AnsmC0kjnze7+8
         eK4yh+A+Irot2u7t4QNdUX8JPGLCn75TCiMQ6DtBJapWQ41gzM5qV2OQIEqOnawBXfcq
         w+Dk1XoWb+ME+QbbI/XJlNcbShzWzEIsnENY6SqUawhFQu9mIIEAxrVGxVuHYo/UxN3m
         //SHrg0O+CBK0x8vdVnL+yfduWN7KUmfB4BALXmyvWLRhNULg6ukc8cbQjIxJF24veNS
         WD1TIQFctUMI03sqjDgOCit8k2VaoKMrVzajkvjlZsy+AZm6UUc8+3OY7KaBSSrNr30d
         Ay0w==
X-Forwarded-Encrypted: i=1; AJvYcCU0hENJi2RKWp+fJPsAMIYgMPtMZYZGRGt+ZF4OlmWu78ShReC6x3KiSRXhXC5m/9rZkTFA523dJLe1DEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdYhCaXw+IZ1WiZLeoCRj1C5s1kA6YISCYrWCs/IIIwCjc9CH
	3zIAMXM50iIccH1p0NGCdCZo4bM+MUsnWXtqxgQegcyiJvfnJTuGEMHNz9TrPTnDrwNkpveJ3BD
	LdxXMbfi+qHyO0yboO+3dgMQ7eNrG74PSXs98Xfp6wRzL4qN2AzbHMJUu7N4=
X-Google-Smtp-Source: AGHT+IHPqrgj7wzHwWhYDRVhbgih7TMqq+owi56O9Al/I0fBzFEba8D9Bgj+Ir3j843GXZtJqYNFHEjAq0xBVlFZ117ZFZfXwsuz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60ca:b0:86c:ef0b:3a52 with SMTP id
 ca18e2360f4ac-8797883ec84mr643942439f.11.1752281343996; Fri, 11 Jul 2025
 17:49:03 -0700 (PDT)
Date: Fri, 11 Jul 2025 17:49:03 -0700
In-Reply-To: <20250712002052.3539-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6871b0ff.a00a0220.26a83e.0065.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in kvfree_call_rcu

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 000000002053ae6c object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 7491 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 0 PID: 7491 at lib/debugobjects.c:615 debug_object_activate+0x344/0x460 lib/debugobjects.c:842
Modules linked in:
CPU: 0 UID: 0 PID: 7491 Comm: syz.0.17 Not tainted 6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
sp : ffff8000a0cd76d0
x29: ffff8000a0cd76d0 x28: ffff8000976d8000 x27: dfff800000000000
x26: ffff80008afc2440 x25: 0000000000000001 x24: ffff8000891ac400
x23: 0000000000000003 x22: ffff80008b5399e0 x21: 0000000000000000
x20: ffff80008afc2440 x19: ffff8000891ac400 x18: 0000000000000000
x17: 3665613335303230 x16: ffff80008aefc4e0 x15: 0000000000000001
x14: 1fffe000337d40e2 x13: 0000000000000000 x12: 0000000000000000
x11: ffff6000337d40e3 x10: 0000000000ff0100 x9 : 3a9c2e14942ed200
x8 : 3a9c2e14942ed200 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a0cd7018 x4 : ffff80008f766be0 x3 : ffff8000807bcfac
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
irq event stamp: 189
hardirqs last  enabled at (188): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (188): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (189): [<ffff80008aef6eac>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (136): [<ffff800089198d40>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (136): [<ffff800089198d40>] release_sock+0x14c/0x1ac net/core/sock.c:3776
softirqs last disabled at (164): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 000000002053ae6c object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 7491 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 0 PID: 7491 at lib/debugobjects.c:615 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
Modules linked in:
CPU: 0 UID: 0 PID: 7491 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
sp : ffff8000a0cd76c0
x29: ffff8000a0cd76d0 x28: ffff80008f671000 x27: dfff800000000000
x26: 0000000000000003 x25: 0000000000000000 x24: ffff0000d12b1150
x23: 0000000000000001 x22: ffff80008afc2440 x21: ffff80008b5399e0
x20: 0000000000000000 x19: ffff8000891ac400 x18: 0000000000000000
x17: 3530323030303030 x16: ffff80008ae63d88 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : 3a9c2e14942ed200
x8 : 3a9c2e14942ed200 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a0cd7018 x4 : ffff80008f766be0 x3 : ffff80008054d314
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
irq event stamp: 217
hardirqs last  enabled at (216): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (216): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (217): [<ffff80008aef6eac>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (136): [<ffff800089198d40>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (136): [<ffff800089198d40>] release_sock+0x14c/0x1ac net/core/sock.c:3776
softirqs last disabled at (164): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kvfree_call_rcu(): Double-freed call. rcu_head 000000002053ae6c
WARNING: CPU: 0 PID: 7491 at mm/slab_common.c:1956 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
Modules linked in:
CPU: 0 UID: 0 PID: 7491 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
lr : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
sp : ffff8000a0cd7730
x29: ffff8000a0cd7730 x28: 00000000fffffff5 x27: 1fffe00018f30aa3
x26: dfff800000000000 x25: ffff0000c798551e x24: ffff0000ebecec00
x23: ffff8000891ac400 x22: 00000000ffffffea x21: ffff8000891ac400
x20: ffff8000891ac400 x19: ffff80008afc2440 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008ae63d88 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : 3a9c2e14942ed200
x8 : 3a9c2e14942ed200 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a0cd7078 x4 : ffff80008f766be0 x3 : ffff80008054d314
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
irq event stamp: 243
hardirqs last  enabled at (242): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (242): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (243): [<ffff80008aef6eac>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (136): [<ffff800089198d40>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (136): [<ffff800089198d40>] release_sock+0x14c/0x1ac net/core/sock.c:3776
softirqs last disabled at (164): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1356e0f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10259e8c580000


