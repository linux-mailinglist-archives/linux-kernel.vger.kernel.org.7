Return-Path: <linux-kernel+bounces-728880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52885B02E5D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 03:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9959D17D081
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5E35947;
	Sun, 13 Jul 2025 01:45:34 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E30139E
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752371134; cv=none; b=WKg8fqX9egIToH1/qYWIaRQUJeSAeJfiMyiafVzsTGtRUIlSuR/NneuOv+rOZ0ZdUxcOH4a/7tUNr/y5gaH2S4H+qaTHwuTqA7KgxrX5rPB2KnaU8MSxdQkilItRXTuZfKdhXobM2V1/mQvyanLsk4hCnu5kuH1P9lAYXSgnYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752371134; c=relaxed/simple;
	bh=eoEh3oxsADw2BAYz8I74j6iJxp7vLr+TlBGjrBmT/Fw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n59ZfOIHj2f12pJChJNUkw/80jTQ4dKnAylbTh9pRTZFzY0pwQzx3XKG4cpVcPlFdaY6ooEhfMENaW1lH+Z9I8wZppQccYiPdsLbSBZ0l2vvoSjiRtlNLilLzJBqLScmRACJBcTW4YjVQFHt4qgCA/biYT8Wh5R7T3FN6zLgq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-875b64cccd6so635226639f.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752371131; x=1752975931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KYu7kvPbnFBl2H27Mp1FgBe7+XHwEpS35yIEIH8+q0=;
        b=Vr9apQjVNgbeJQcecqx8jNMCgjysfWA7t63a3O2JWr+NPKt19vd5Hl9VUPN4wRnbhE
         qrPk+lfBCvgn0eMlJho0weOekSYsKGfzTV/LJwxvgWCBkWjEk07SZbZROmWel82fa2Uf
         KHVxHh3B4clyUXCeg/Fm75XVNKjOVPSUe3psq6DGD222sp5a1fORKHhJI021hC4u5fo/
         x3XArjt2Q/tcPT1SVc05GGos2ICgfYurSymutHTeJT7yn3nJoor5Ci1ZXt0kWwKKxjz7
         IWKo9vNyiyd02M61QRQNQoaDEMIzFnwEWClCN+NL8hss4PbZBjXLD0QLyVZGQkyeltRM
         mOZA==
X-Forwarded-Encrypted: i=1; AJvYcCWzBpcE0WgQ+rOW5pvU1dEj7J/NqWHPyKLnhhLk7FYHXAlIW9xY5p6bkBww7qtz0p/NEwQy4gseoSanU9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VrMh1aNiZ04ULLBg8NX4D4TPDNe8fB4F7yIq+ZgPzMq7zcS5
	XmNX3biEoL7obBz5ilmimOOKVLfmu8U7tH1xyjdV4ONx+DEOeDWcjKlRGt5LG/eGvhc6UhOre/h
	1l3NqVuuAijIRVcW5f2VJbvsQ+oJePsPGNRTxIk/9g/Dw42qeEJL2oAcIe0A=
X-Google-Smtp-Source: AGHT+IG9ACa4nl2F7Dncd1ZLo1PjOlBkrioceOUwRFcDhYkili36jGeqjT/qkPP9NY3LonOExrSipKOwt0a6NWSajCh84qctgzbw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c6:b0:875:d450:9297 with SMTP id
 ca18e2360f4ac-87977f735e1mr991684039f.5.1752371131633; Sat, 12 Jul 2025
 18:45:31 -0700 (PDT)
Date: Sat, 12 Jul 2025 18:45:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68730fbb.a70a0220.3b380f.001a.GAE@google.com>
Subject: [syzbot] [kvmarm?] WARNING in pend_sync_exception
From: syzbot <syzbot+4e09b1432de3774b86ae@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, suzuki.poulose@arm.com, 
	syzkaller-bugs@googlegroups.com, will@kernel.org, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15724a984643 Merge branch 'kvm-arm64/doublefault2' into kv..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=13e26a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82bd3cd421993314
dashboard link: https://syzkaller.appspot.com/bug?extid=4e09b1432de3774b86ae
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17137582580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e26a8c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-15724a98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec0f03d375a1/vmlinux-15724a98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a36232f8c6dd/Image-15724a98.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e09b1432de3774b86ae@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3595 at arch/arm64/kvm/inject_fault.c:63 pend_sync_exception+0x198/0x5ac arch/arm64/kvm/inject_fault.c:63
Modules linked in:
CPU: 0 UID: 0 PID: 3595 Comm: syz.2.16 Not tainted 6.16.0-rc3-syzkaller-g15724a984643 #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
pstate: 81402009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : pend_sync_exception+0x198/0x5ac arch/arm64/kvm/inject_fault.c:63
lr : pend_sync_exception+0x198/0x5ac arch/arm64/kvm/inject_fault.c:63
sp : ffff80008e7378c0
x29: ffff80008e7378c0 x28: 0000000000000063 x27: 63f000001d7702a8
x26: 0000000000000063 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000063 x21: 63f000001d770e81
x20: 0000000000000007 x19: efff800000000000 x18: 0000000000000000
x17: 0000000000000041 x16: ffff800080011d9c x15: 00000000200000c0
x14: ffffffffffffffff x13: 0000000000000028 x12: 00000000000000cc
x11: ccf000001d756de4 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ccf000001d755880 x7 : ffff800080b08704 x6 : ffff80008e737a88
x5 : ffff80008e737a88 x4 : 0000000000000001 x3 : ffff8000801a2e80
x2 : 0000000000000000 x1 : 0000000000000002 x0 : 0000000000000000
Call trace:
 pend_sync_exception+0x198/0x5ac arch/arm64/kvm/inject_fault.c:63 (P)
 inject_abt64 arch/arm64/kvm/inject_fault.c:115 [inline]
 __kvm_inject_sea+0x268/0x96c arch/arm64/kvm/inject_fault.c:207
 kvm_inject_sea+0x98/0x72c arch/arm64/kvm/inject_fault.c:229
 kvm_inject_sea_dabt arch/arm64/include/asm/kvm_emulate.h:54 [inline]
 __kvm_arm_vcpu_set_events+0x134/0x238 arch/arm64/kvm/guest.c:847
 kvm_arm_vcpu_set_events arch/arm64/kvm/arm.c:1698 [inline]
 kvm_arch_vcpu_ioctl+0xed8/0x16b0 arch/arm64/kvm/arm.c:1810
 kvm_vcpu_ioctl+0x5c4/0xc2c virt/kvm/kvm_main.c:4632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x18c/0x244 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x90/0x2b4 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x180/0x2f4 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x58/0x74 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x160 arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 2626
hardirqs last  enabled at (2625): [<ffff80008653cb88>] __raw_read_unlock_irqrestore include/linux/rwlock_api_smp.h:241 [inline]
hardirqs last  enabled at (2625): [<ffff80008653cb88>] _raw_read_unlock_irqrestore+0x44/0xbc kernel/locking/spinlock.c:268
hardirqs last disabled at (2626): [<ffff800086517e08>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:511
softirqs last  enabled at (2576): [<ffff8000800c988c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (2574): [<ffff8000800c9858>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

