Return-Path: <linux-kernel+bounces-728999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE7B03057
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F256D17B8EC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BAC248F58;
	Sun, 13 Jul 2025 09:09:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFA6FC3
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752397744; cv=none; b=nvDdRc0W00M4SisEkFFuuMxTcxOW0LmR18uJbteAEXBYHhtdMHyfoPrRYBntx40g4UT6CPWDvmgV9lIEfII45q1Gf0nlY22h2eqSBJzG6e1Ycv8fLIyq/56WL2lcU0zyBtrNXcbNtv783B/ewvHtwzSm0bVBtjAuyWXXYMRuJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752397744; c=relaxed/simple;
	bh=vkuthEa7femFXOieEOQFvaHz784gwEOgOQHrWP/292g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HxmiF9TnWzKe93N6IgTH5dNeYev+sl45lxvQnMKYv0LidHYAITISVvUikWtG2IXFtQm0LsUAv6Xr+5BFX02J9OOUM32ESXHBzT4MIIwvXZhEGtaGJ66qjznerva97kNTph24zSPJ/2M1AbYAcAQ89R+CnYwcVe+rHudryNugojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d07944f29so742427839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 02:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752397742; x=1753002542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cSm7cR443f6rJWXPG1SdTuh0cVV1NZ2JUgX0uh6gss=;
        b=rR0qBYbGK2oVdfCxhA7ZNX21NmDAslwQRpcMkg18WJHsnAHdvmkQZJp2UnbJYUWaW3
         wCmcUrJdhizT42MoZ1te3lUjiS179p5gWGQAvwchy8FqX0bua4Ow/kJ3dhsNWnVj3nup
         MCjdqU8T4lMCI05ne/9ZbZzMuuci50OhZ05DsGabmJf2ijOsZWrMGbPB7tuFkgAxeyTo
         tDtgKSrU2OFWvzOTBLVMfEdNhvDahZ/cyocylXGLU+/pLoKovwKlXgO/qPvzXoXDtbF5
         JosvCpzTxPZ0LSwuSJMrYQ97sjX3f88Wp7m8MyN/33zWo7SVawm2CZ74AQDtN+1QXMIK
         lhXA==
X-Forwarded-Encrypted: i=1; AJvYcCXP0sjCr1xWqm8YfzFwIAhr45CQH0iecF8a92TOY/3VM4XV43kIXhXEn/GMXnmxShiveF5op4FsJV3httI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkKcvM4lvKagU+LWqAzTqQXo1hhBg9xpbSbXQufEhoALwRkul
	XQ4xwQsQXy3wkVYeaAKnFXqHdKwSyPFqd54q6QjwQIauutuJRr6LLMnHMIRaekj+Uq4eqqH3NCV
	zJOy8kNlX8gyLw7SZ7iVkZtwa9+yfl2RxE07Me5pbl/nUltK/j+oWqsiSXJQ=
X-Google-Smtp-Source: AGHT+IES4HnRYI+C0TZYUVn5UgouvbpbdtRJMnbKibf6V8QFZwI2Oi9sVNGiJjm8h4T7M6M3XWHIWhkMay1zTI2o0Ryi3QBqbLFT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3e93:b0:85b:3c49:8811 with SMTP id
 ca18e2360f4ac-879787bcf13mr990428839f.4.1752397742151; Sun, 13 Jul 2025
 02:09:02 -0700 (PDT)
Date: Sun, 13 Jul 2025 02:09:02 -0700
In-Reply-To: <20250713084309.3912-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687377ae.a70a0220.3b380f.0028.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in kvfree_call_rcu

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 00000000997a22ca object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 7463 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 1 PID: 7463 at lib/debugobjects.c:615 debug_object_activate+0x344/0x460 lib/debugobjects.c:842
Modules linked in:
CPU: 1 UID: 0 PID: 7463 Comm: syz.0.17 Not tainted 6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
sp : ffff80009cb876d0
x29: ffff80009cb876d0 x28: ffff8000976d8000 x27: dfff800000000000
x26: ffff80008afc2440 x25: 0000000000000001 x24: ffff8000891ac400
x23: 0000000000000003 x22: ffff80008b5399e0 x21: 0000000000000000
x20: ffff80008afc2440 x19: ffff8000891ac400 x18: 00000000ffffffff
x17: 6332326137393930 x16: ffff80008ae63d48 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : b4ca56aa78726000
x8 : b4ca56aa78726000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009cb87018 x4 : ffff80008f766be0 x3 : ffff80008054d314
x2 : 0000000000000000 x1 : 0000000100000201 x0 : 0000000000000000
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
irq event stamp: 203
hardirqs last  enabled at (202): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (202): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (203): [<ffff80008aef6e74>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (152): [<ffff8000801fd5e4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (176): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 00000000997a22ca object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 7463 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 1 PID: 7463 at lib/debugobjects.c:615 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
Modules linked in:
CPU: 1 UID: 0 PID: 7463 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
sp : ffff80009cb876c0
x29: ffff80009cb876d0 x28: ffff80008f671000 x27: dfff800000000000
x26: 0000000000000003 x25: 0000000000000000 x24: ffff0000dbef40e0
x23: 0000000000000001 x22: ffff80008afc2440 x21: ffff80008b5399e0
x20: 0000000000000000 x19: ffff8000891ac400 x18: 00000000ffffffff
x17: 3739393030303030 x16: ffff80008ae63d48 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : b4ca56aa78726000
x8 : b4ca56aa78726000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009cb87018 x4 : ffff80008f766be0 x3 : ffff80008054d314
x2 : 0000000000000000 x1 : 0000000000000201 x0 : 0000000000000000
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
irq event stamp: 233
hardirqs last  enabled at (232): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (232): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (233): [<ffff80008aef6e74>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (152): [<ffff8000801fd5e4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (176): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kvfree_call_rcu(): Double-freed call. rcu_head 00000000997a22ca
WARNING: CPU: 1 PID: 7463 at mm/slab_common.c:1956 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
Modules linked in:
CPU: 1 UID: 0 PID: 7463 Comm: syz.0.17 Tainted: G        W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
lr : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
sp : ffff80009cb87730
x29: ffff80009cb87730 x28: 00000000fffffff5 x27: 1fffe0001b3f0863
x26: dfff800000000000 x25: ffff0000dc6b87ee x24: 0000000000000017
x23: ffff8000891ac400 x22: 00000000ffffffea x21: ffff8000891ac400
x20: ffff8000891ac400 x19: ffff80008afc2440 x18: 00000000ffffffff
x17: 0000000000000000 x16: ffff80008ae63d48 x15: ffff700011ede144
x14: 1ffff00011ede144 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede144 x10: 0000000000ff0100 x9 : b4ca56aa78726000
x8 : b4ca56aa78726000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009cb87078 x4 : ffff80008f766be0 x3 : ffff80008054d314
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
irq event stamp: 259
hardirqs last  enabled at (258): [<ffff800080554800>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (258): [<ffff800080554800>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (259): [<ffff80008aef6e74>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (152): [<ffff8000801fd5e4>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (176): [<ffff800082c87490>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1000ce8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156f4e8c580000


