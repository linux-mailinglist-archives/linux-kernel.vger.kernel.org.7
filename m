Return-Path: <linux-kernel+bounces-720354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A987BAFBAAF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6BA420D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528242638B2;
	Mon,  7 Jul 2025 18:32:32 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0507DA6D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913151; cv=none; b=KuZYw8ZLUg/RSukWGh4gvHodJkwywCiY5aind8wgr053Ms/TPXBCrktwWAaUJBqpuJqOaBTEOHjonImjlIa6dsAX+qGqJiq11I6Kgq+aTkddnmir8Cpi0A/GAkUhuDOfsNNpxzA9Xq4bsSRSR51aNJNhMSqaQXCY0VclYt0m+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913151; c=relaxed/simple;
	bh=8GiBBHQtfHOqzVmO7ETkwvN+twiPkofVYk2vF8hzh38=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ReWqpZyb7JwFVC6GqFfd52bTVAgDWeQL5wh3pca0HkqaGW+SSVyomFZhelncNwcoAiRWmGKe77a/WviY9sR44hDBdlUUdQr5t5z4ACQ2cyvSDXWSJITbYPrqozHi8b049Sy4DUvYv0mL/0/bskO5LvYRiZ9/cIQNOE4LgFZsTXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-873fd6e896bso321263139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913149; x=1752517949;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlY8XzQoFKoWs7qfmY3eXvDw2cI1dpWN0OkxWj1+lnw=;
        b=tP3oCyGyA8uNY/5S/2Aif3kut7EiwYcOFGTDuw6TkpHHhWS+qxakCWfSyTrEa3xm8n
         Jz8xUq9CEZAr6RELlKobAbDBpyfOUUsCjt4mib9guXPcFNLt46LZcOc8xiBffIdUa0Hr
         /0Mm+qKN+Pa+m+F8M5peHwYq97MewZjlykFbi57Jg1ptt0YQjvT3ZGfLylKEgqJPjolB
         LCFP9ZFYzAnNlxipxNWLJbfh9+P3Tuyf4v3zsc/3XODi6GumIhELJE6BSb8+J8S6JJDt
         WK+K/Qt2zmYISN5jBeb32IdoDrTEIGoeJ7TTPfe3KPujD2kfD2LCTW6aZl7WV8ORdQ5E
         IA0g==
X-Forwarded-Encrypted: i=1; AJvYcCUYOwc17SZhfewaYggsCQZ93nJ0tW/lA6d/qozrJo6vUzELZxCb4XAtoJdD/DvkXMiL5L2k11J+5YVg9bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoltHEwRoHlLofBnjB9WvWl4AUU8gI+UvhBI7VqFtzrpA5Hy0
	onR7XcGzx1bbC5O5Pxk+aaMtuj46zl/NSoaBF5ezKCFDOkQyCYtH6n3PMNTT5FyyVcxE2kJs2Og
	ml/eplxKKYosRE6J6q3SfBjBiMvN6Jne5bD4UMr2vVPPfqW7sxhZosWiL1dY=
X-Google-Smtp-Source: AGHT+IG6yNnQ72xHq9NTlfxRXNyfzdNtSpzEJBPqaM6dD/lmZSg1jnqnnTf+VrJfGijBrgADT2S8rw8fC1g1TOPJdzRi1uKPNDgY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1587:b0:861:7d39:d4d3 with SMTP id
 ca18e2360f4ac-8794b431a8amr17982739f.3.1751913149022; Mon, 07 Jul 2025
 11:32:29 -0700 (PDT)
Date: Mon, 07 Jul 2025 11:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686c12bd.a70a0220.29fe6c.0b13.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in
 l2cap_sock_resume_cb (4)
From: syzbot <syzbot+e2df3a66f7d16fa6ec55@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7482bb149b9f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1597828c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
dashboard link: https://syzkaller.appspot.com/bug?extid=e2df3a66f7d16fa6ec55
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c4cbd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d11f70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f623d741d651/disk-7482bb14.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483e23ae71b1/vmlinux-7482bb14.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79b5baaa1b50/Image-7482bb14.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2df3a66f7d16fa6ec55@syzkaller.appspotmail.com

Bluetooth: hci0: unexpected event 0x06 length: 4 > 3
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
BUG: KASAN: null-ptr-deref in l2cap_sock_resume_cb+0xb4/0x17c net/bluetooth/l2cap_sock.c:1711
Write of size 8 at addr 0000000000000570 by task kworker/u9:0/52

CPU: 1 UID: 0 PID: 52 Comm: kworker/u9:0 Not tainted 6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci0 hci_rx_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:501 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_report+0x58/0x84 mm/kasan/report.c:524
 kasan_report+0xb0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:189
 __kasan_check_write+0x20/0x30 mm/kasan/shadow.c:37
 instrument_atomic_write include/linux/instrumented.h:82 [inline]
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:41 [inline]
 l2cap_sock_resume_cb+0xb4/0x17c net/bluetooth/l2cap_sock.c:1711
 l2cap_security_cfm+0x524/0xea0 net/bluetooth/l2cap_core.c:7357
 hci_auth_cfm include/net/bluetooth/hci_core.h:2092 [inline]
 hci_auth_complete_evt+0x2e8/0xa4c net/bluetooth/hci_event.c:3514
 hci_event_func net/bluetooth/hci_event.c:7511 [inline]
 hci_event_packet+0x650/0xe9c net/bluetooth/hci_event.c:7565
 hci_rx_work+0x320/0xb18 net/bluetooth/hci_core.c:4070
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3402
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
==================================================================
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000570
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000121d3b000
[0000000000000570] pgd=0800000121d58403, p4d=0800000121d58403, pud=0800000121d81403, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 52 Comm: kworker/u9:0 Tainted: G    B               6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci0 hci_rx_work
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lse_atomic64_andnot arch/arm64/include/asm/atomic_lse.h:131 [inline]
pc : arch_atomic64_andnot arch/arm64/include/asm/atomic.h:64 [inline]
pc : raw_atomic64_andnot include/linux/atomic/atomic-arch-fallback.h:3675 [inline]
pc : raw_atomic_long_andnot include/linux/atomic/atomic-long.h:964 [inline]
pc : arch_clear_bit include/asm-generic/bitops/atomic.h:25 [inline]
pc : clear_bit include/asm-generic/bitops/instrumented-atomic.h:42 [inline]
pc : l2cap_sock_resume_cb+0xc0/0x17c net/bluetooth/l2cap_sock.c:1711
lr : __lse_atomic64_andnot arch/arm64/include/asm/atomic_lse.h:131 [inline]
lr : arch_atomic64_andnot arch/arm64/include/asm/atomic.h:64 [inline]
lr : raw_atomic64_andnot include/linux/atomic/atomic-arch-fallback.h:3675 [inline]
lr : raw_atomic_long_andnot include/linux/atomic/atomic-long.h:964 [inline]
lr : arch_clear_bit include/asm-generic/bitops/atomic.h:25 [inline]
lr : clear_bit include/asm-generic/bitops/instrumented-atomic.h:42 [inline]
lr : l2cap_sock_resume_cb+0xbc/0x17c net/bluetooth/l2cap_sock.c:1711
sp : ffff8000991975b0
x29: ffff8000991975b0 x28: ffff0000d89f6000 x27: dfff800000000000
x26: ffff700013232ec8 x25: 0000000000000001 x24: ffff80008db6f6c0
x23: ffff0000d89f6480 x22: dfff800000000000 x21: 0000000000000002
x20: 0000000000000570 x19: 0000000000000000 x18: 1fffe000337d8876
x17: 0000000000000000 x16: ffff80008ae642c8 x15: 0000000000000001
x14: 1ffff000125d90f8 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7000125d90f9 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000002 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800099196e18 x4 : ffff80008f766c20 x3 : ffff8000803b80e0
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __lse_atomic64_andnot arch/arm64/include/asm/atomic_lse.h:-1 [inline] (P)
 arch_atomic64_andnot arch/arm64/include/asm/atomic.h:64 [inline] (P)
 raw_atomic64_andnot include/linux/atomic/atomic-arch-fallback.h:3675 [inline] (P)
 raw_atomic_long_andnot include/linux/atomic/atomic-long.h:964 [inline] (P)
 arch_clear_bit include/asm-generic/bitops/atomic.h:25 [inline] (P)
 clear_bit include/asm-generic/bitops/instrumented-atomic.h:42 [inline] (P)
 l2cap_sock_resume_cb+0xc0/0x17c net/bluetooth/l2cap_sock.c:1711 (P)
 l2cap_security_cfm+0x524/0xea0 net/bluetooth/l2cap_core.c:7357
 hci_auth_cfm include/net/bluetooth/hci_core.h:2092 [inline]
 hci_auth_complete_evt+0x2e8/0xa4c net/bluetooth/hci_event.c:3514
 hci_event_func net/bluetooth/hci_event.c:7511 [inline]
 hci_event_packet+0x650/0xe9c net/bluetooth/hci_event.c:7565
 hci_rx_work+0x320/0xb18 net/bluetooth/hci_core.c:4070
 process_one_work+0x7e8/0x155c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3402
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
Code: 977fc1f2 d503201f 977fc0f7 52800048 (f828129f) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	977fc1f2 	bl	0xfffffffffdff07c8
   4:	d503201f 	nop
   8:	977fc0f7 	bl	0xfffffffffdff03e4
   c:	52800048 	mov	w8, #0x2                   	// #2
* 10:	f828129f 	stclr	x8, [x20] <-- trapping instruction


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

