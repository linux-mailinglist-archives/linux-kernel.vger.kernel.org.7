Return-Path: <linux-kernel+bounces-885582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3FC33642
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57D218C4AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91AD32D451;
	Tue,  4 Nov 2025 23:35:33 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25782E3B08
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299333; cv=none; b=Kqfsafefx/S0nLFClzh3C9X18lGYrWPUZzXtZ7jDFG1IkPRBdflP09MJR2eAybtp+AZ10xDJM3ornK9ZZXk5q9xKl1w6fO1R+t8gOgRQS1Av1D/zVaoyoyD4UjzcD3MVgZTWilJ6+82IRTECbajLIYhCcCxSMiTjWfnhkG2C8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299333; c=relaxed/simple;
	bh=2VMQrsuAbBUhWoXwE0wY+gg7obNb5pNbBsIt1CiKuQw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q/cOqUQBqfFRKPJrNapbM75R8TmKqDP0lygkkU4XiQvxTyLDcfGlQnExYIoPHObcmLNGD/Tvmr4JVc2sRgaq/za72q5DmiZaa91kh8U1HuBaxMn0gKmG3ZdRlFhiWV2wJ6QWktt/MIB99RH2k9r4ErTTW1vZFtf8GqYBqlgQUJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-433316b78f4so22301875ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762299331; x=1762904131;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdyO4gh7iAlQFSoy5CIG4DgiFWF/85SRrg5mDm9g9P0=;
        b=LhTlVYSVF72v4QFmFvox405Gp6+82HoVye1CjQffNGsILoqYZ5N6NsNi6XkRUDy8iL
         MHHcFd7cmh3XfFVXZvqztL5EAeIKOdL9Klne2SQf+9Z8vXz+xjtl0WT5+Xy1H0yy4dCH
         dnFeOLL4X49sY/c9sS5zdbZnZSEzrDmMwrqpqrOCG46RDj84IOe0u6Z0QHlgGqSZ7E0i
         3PYRGb2fTXLOye9Piq9WtLzzwMYsIm5b3f5IC9JSBFgaS/lKRTdfAeNYipUfAwi338My
         +kR+FKNTL1QVuh+SH2hHo7zeWPbqt94l4ojDNH1ks2vO5whWBP0XvWLWjLB/kQsf95Pb
         x7nA==
X-Forwarded-Encrypted: i=1; AJvYcCVsK4h6uM3WMzqBMwh15e4bf7AdhO8b3BZMRhbL7cfp3LP2FsDe40Hs4oEdd0a14xxHEp08LTo7rA4p8TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kFPlyNHhDYkqA2PBGg0uq3Dbd+KQ6vr9WipPIGB9gPNkksOU
	pOK3hylGZ7vhSLPS/jRULVoD7FaFyPT2MJI00rox1GmHJU0bZXuD1GkVw87anCLVlehMvVLxuuA
	Ds7X92RIGF55UOywZjWFBR7qR2p+L8VrH2qSz/kKtE4+R/jdyyxof9M3SZa8=
X-Google-Smtp-Source: AGHT+IH6T+lKfQ6V0XGJrssHrVvl4K2lTnnaX2x+LBqWLou2vuLX+a7xgEa7XLvHl76HJdP0qxUDo2d0Xg7vLWcsNbDALNxYcSFU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:433:2dd5:f571 with SMTP id
 e9e14a558f8ab-433407eb3bcmr17291995ab.25.1762299330934; Tue, 04 Nov 2025
 15:35:30 -0800 (PST)
Date: Tue, 04 Nov 2025 15:35:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a8dc2.050a0220.3d0d33.0018.GAE@google.com>
Subject: [syzbot] [arm?] WARNING in fpsimd_restore_current_state
From: syzbot <syzbot+d4ab35af21e99d07ce67@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11a79704580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=d4ab35af21e99d07ce67
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115fdf34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1441d258580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae6bec0d0398/disk-dcb6fa37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcc732da66c3/vmlinux-dcb6fa37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/301d1bbdecc2/Image-dcb6fa37.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4ab35af21e99d07ce67@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6720 at arch/arm64/kernel/fpsimd.c:370 task_fpsimd_load arch/arm64/kernel/fpsimd.c:370 [inline]
WARNING: CPU: 0 PID: 6720 at arch/arm64/kernel/fpsimd.c:370 fpsimd_restore_current_state+0x4cc/0x708 arch/arm64/kernel/fpsimd.c:1746
Modules linked in:
CPU: 0 UID: 0 PID: 6720 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : task_fpsimd_load arch/arm64/kernel/fpsimd.c:370 [inline]
pc : fpsimd_restore_current_state+0x4cc/0x708 arch/arm64/kernel/fpsimd.c:1746
lr : task_fpsimd_load arch/arm64/kernel/fpsimd.c:370 [inline]
lr : fpsimd_restore_current_state+0x4cc/0x708 arch/arm64/kernel/fpsimd.c:1746
sp : ffff8000a1047de0
x29: ffff8000a1047de0 x28: ffff0000dcfd9ec0 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000008 x24: 0000000000000040
x23: 00000000000020ff x22: dfff800000000000 x21: 1fffe0001b9fb3d8
x20: 0000000000000000 x19: ffff0000dcfd9ec0 x18: 1fffe000337db690
x17: ffff80008ae011f8 x16: ffff80008052ae04 x15: 0000000000000001
x14: 1fffe0001b9fb3d8 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001b9fb3d9 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000dcfd9ec0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff8000801f8344
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 task_fpsimd_load arch/arm64/kernel/fpsimd.c:370 [inline] (P)
 fpsimd_restore_current_state+0x4cc/0x708 arch/arm64/kernel/fpsimd.c:1746 (P)
 arch_exit_to_user_mode_work arch/arm64/include/asm/entry-common.h:25 [inline]
 exit_to_user_mode_loop+0xe4/0x178 kernel/entry/common.c:46
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:103 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:747
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
irq event stamp: 129
hardirqs last  enabled at (127): [<ffff80008ae151bc>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (127): [<ffff80008ae151bc>] _raw_spin_unlock_irq+0x30/0x80 kernel/locking/spinlock.c:202
hardirqs last disabled at (129): [<ffff80008adecb80>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:434
softirqs last  enabled at (8): [<ffff8000801f95fc>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (128): [<ffff8000801f95c8>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
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

