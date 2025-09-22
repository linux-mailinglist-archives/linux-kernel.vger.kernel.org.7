Return-Path: <linux-kernel+bounces-827652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3275B9250A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE602A6322
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F631194F;
	Mon, 22 Sep 2025 16:54:31 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621531194A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560071; cv=none; b=i8/OzMMuY4EUgQU5Qw6TVop5GZjD8V9pFrKP3+ezknMdN2Al45f8XPuf+TZrx5vO8roDm/ANh94Y0Yv3FxpQKW3IKyW25SyPJnKtEV2eUd9JlgK0DmDoYmiR+kCLEL3Bqu/ByGsVF7oL311RTTj8ruExYatMfIeO3XeCDe+r250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560071; c=relaxed/simple;
	bh=0PoIjQ7OMGRHJ65EHL03KYjX/jRrnZ6uxiYLKRBpQi0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fPztuonXkCi722/2OmG5yye3sDt1561k/5uaqZcaaPxFruP4YurDXNpGV6HsCg86Qx9HE/ZwcmbmF8Dkf+R5BIOU9ygWcCpcKgmLqjJMJECbGXW5nFGvWOFOp2SPchNaS7Znr2sLmzE4PVyUmVtqj/CVxiuDH4kdihdZKmeFGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42571449766so34139975ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758560068; x=1759164868;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkyQ0G/GYp6D/Frk0y+BiFU8FL/TnbApWZ0LcRyxL34=;
        b=iZp0JO4AnYWAvF5ve2CKf6zUs3wOc2VikV9aNKuq6R4/VWWx1wtdvdGHKLxnRVcKhY
         J3tJeRc2Y+2k4ex2mqEnGqrEqiiv0cBD2kAy/UFnFGY/TFGMAKW3CjgQTFsmhsfDwOq7
         YxYIWxBPQ2OcZQ5DOZozTJE8gkIzOwlUaLvlD6AEzdsmbBdkXjHoG2uZoBaSBjpvzhx4
         54rzbbWr7DxYQ8JNiaeMrqvUS1Vk2XUBHds0qdSwzvdBKx6sZBnH1T4gbl0XdPSaK8xQ
         mSy9kXhB3M7aOLe7QCiZVCiMx3aJXM2A9n5as1HxppGQeeCX7iKnqZ1GtvqrATmyBuS9
         hvrg==
X-Forwarded-Encrypted: i=1; AJvYcCXySMqSsVEtHM9O/EkTorCC4w0ZF+qCVVIjmKZHr4NtV/0zBqdGyeMHW12ltxp+olhZ6cgk2DBBT9nEZ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVNE3gj+tS2OkgLL3PabuVSGN8wlWjzmuKRhb38iA5kR9P3l5
	4gyCjFIEkqvZf9L3FaWoq5VQL8jwh25vBKU5Icp7TESn5ovV1D+kPmyXg3LviqMZLqjsbJ+/WJf
	HEmHRrGRWAY/eDIo5O1HXyJp191UwRg+le5aqMD0u7SLPfAtThEfFuaU3Mec=
X-Google-Smtp-Source: AGHT+IF9O55Lh+p8JZ6zsgfeJd2VODUez5Tp8sknhwVcR64xUUSQN7gm0Y9gOu44n/P0v7UMeRpXHuwgGcBNvMPQpmt3DRDzflp0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1947:b0:424:80f2:299 with SMTP id
 e9e14a558f8ab-424819955bbmr230968455ab.27.1758560068378; Mon, 22 Sep 2025
 09:54:28 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:54:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d17f44.050a0220.13cd81.05b7.GAE@google.com>
Subject: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
From: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
To: clemens@ladisch.de, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b08f56fbbb9 Merge tag 'x86-urgent-2025-09-20' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176950e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=927198eca77e75d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14006712580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e950e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/459cbf9146bd/disk-3b08f56f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6836a598801b/vmlinux-3b08f56f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92e1bc34a72e/bzImage-3b08f56f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:snd_usbmidi_do_output+0x22d/0x570 sound/usb/midi.c:310
Code: f8 48 c1 e8 03 42 80 3c 28 00 0f 85 14 03 00 00 89 d8 48 c1 e0 04 4c 8b 64 05 08 49 8d 84 24 88 00 00 00 48 89 c2 48 c1 ea 03 <42> 0f b6 14 2a 84 d2 74 09 80 fa 03 0f 8e ad 02 00 00 48 8b 74 24
RSP: 0018:ffffc90000007b80 EFLAGS: 00010016
RAX: 0000000000000088 RBX: 0000000000000000 RCX: ffffffff894338b8
RDX: 0000000000000011 RSI: ffffffff894338c6 RDI: ffff88805e0fc008
RBP: ffff88805e0fc000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffed100bc1f80f R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881246b3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32d63fff CR3: 000000007e1d5000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 snd_usbmidi_error_timer+0x119/0x410 sound/usb/midi.c:362
 call_timer_fn+0x19a/0x620 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers+0x6ef/0x960 kernel/time/timer.c:2372
 __run_timer_base kernel/time/timer.c:2384 [inline]
 __run_timer_base kernel/time/timer.c:2376 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2393
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2403
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 1d 63 02 e9 9e 5a 7d f5 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 16 17 00 fb f4 <e9> 77 5a 7d f5 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8e207e08 EFLAGS: 000002c2
RAX: 00000000000ab2b9 RBX: 0000000000000000 RCX: ffffffff8b92fb49
RDX: 0000000000000000 RSI: ffffffff8de5156d RDI: ffffffff8c163a00
RBP: fffffbfff1c52ef8 R08: 0000000000000001 R09: ffffed1017086655
R10: ffff8880b84332ab R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff8e2977c0 R14: ffffffff90abad90 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:757
 default_idle_call+0x6d/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x391/0x510 kernel/sched/idle.c:330
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:428
 rest_init+0x16b/0x2b0 init/main.c:744
 start_kernel+0x3ee/0x4d0 init/main.c:1097
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:307
 x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:288
 common_startup_64+0x13e/0x148
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:snd_usbmidi_do_output+0x22d/0x570 sound/usb/midi.c:310
Code: f8 48 c1 e8 03 42 80 3c 28 00 0f 85 14 03 00 00 89 d8 48 c1 e0 04 4c 8b 64 05 08 49 8d 84 24 88 00 00 00 48 89 c2 48 c1 ea 03 <42> 0f b6 14 2a 84 d2 74 09 80 fa 03 0f 8e ad 02 00 00 48 8b 74 24
RSP: 0018:ffffc90000007b80 EFLAGS: 00010016
RAX: 0000000000000088 RBX: 0000000000000000 RCX: ffffffff894338b8
RDX: 0000000000000011 RSI: ffffffff894338c6 RDI: ffff88805e0fc008
RBP: ffff88805e0fc000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffffed100bc1f80f R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881246b3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32d63fff CR3: 000000007e1d5000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	f8                   	clc
   1:	48 c1 e8 03          	shr    $0x3,%rax
   5:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   a:	0f 85 14 03 00 00    	jne    0x324
  10:	89 d8                	mov    %ebx,%eax
  12:	48 c1 e0 04          	shl    $0x4,%rax
  16:	4c 8b 64 05 08       	mov    0x8(%rbp,%rax,1),%r12
  1b:	49 8d 84 24 88 00 00 	lea    0x88(%r12),%rax
  22:	00
  23:	48 89 c2             	mov    %rax,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	42 0f b6 14 2a       	movzbl (%rdx,%r13,1),%edx <-- trapping instruction
  2f:	84 d2                	test   %dl,%dl
  31:	74 09                	je     0x3c
  33:	80 fa 03             	cmp    $0x3,%dl
  36:	0f 8e ad 02 00 00    	jle    0x2e9
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	74 24                	je     0x64


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

