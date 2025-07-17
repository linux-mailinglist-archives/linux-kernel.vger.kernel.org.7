Return-Path: <linux-kernel+bounces-735251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A3EB08CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB9B1A68099
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B3E2BD035;
	Thu, 17 Jul 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbLDpq3S"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3F230981;
	Thu, 17 Jul 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755071; cv=none; b=iAJaF4EdxP5B817LoGFS0SqwgZUE35U4s/sBj1gGu7ymjiwGr/+ZVONyGuD/xhJZUbPbNDj2i7TBPin2TLH/XvlYONURaH4Pn8N70Sb1QgCxdldGSK5t6NzSnilvZjLoLyT6OM8DXZN/loEUCLNhw7q4UWq9US0kcJif/GhT9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755071; c=relaxed/simple;
	bh=EXX5lxyUJq77LsdJ9IFhmgYnQ8y0IACuJVdRXNvHGcQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RIUPclbSSpfwSUq6CWdcGsM2mp6bVND0CoTJLH52iMN8kMtekoNAq+IlDBMJD6AAZnrbg/FdYAmRW9h57XF/gVqee+v9PQW24W5fKbf8lmU6IaBW/GhhZv7bj4fXM9HXLKqeG0/NZul2mz+hBCMALv3E9cXg70+8EaO9tsJBUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbLDpq3S; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e82314f9a51so778934276.0;
        Thu, 17 Jul 2025 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752755068; x=1753359868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aYlxOM2fCOS0AzaJlp8J4ybm+qSBZg8GnBRHL3mOHk0=;
        b=dbLDpq3SMI0bTHpuj7k2TqwacyB/mUxxLfdZ1OWgrLNgCz36qhqGi/JUXzqiniUp4H
         JM7/rMAay07BDVMAm3qyhFC2K37P7gGj9fR1gUEk1j7i3OhVPdN03uUlypWpDTkv1e1Y
         tFJNwKVZLaTEkYXwxRXhCbH4jy3IP7NHapYKWdhzaBoxbvBT4msl14HeEYKAQPUcd2jx
         zrc5M4zikdwKWetLJYpOeMixvnge++EJYErZys3HaLDFqe9Y5+xHyaMIkAFVCKN+8RTL
         jT3jsjc+wgcf+wT4O3k4csGq/wITzaFCBS/dUzdpCxDbx3SE9ikref6F4iAZZoDoiGHx
         S8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755068; x=1753359868;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYlxOM2fCOS0AzaJlp8J4ybm+qSBZg8GnBRHL3mOHk0=;
        b=gC7v7wqPZXmXIa6cJKUzhSQBITN30yJtegJTCO4X8WQlRqa5c0XTBb6dUkV9cXRp+9
         q8b2WOAJLpZuG17u0UL/qPW4C5ZdFxsmCcyVRbPt48YO/utbwoaM+91i1eo41vcWw8g1
         R8zY+NvtWAvhQtg9qfqAfc0uQBUW0UIZN3YrrtO17W9WAEjZt6RtVQNJt3f7MmoLItA4
         J0RCCUCv8EmZsqDBje+CPZfWQtNX4i6M27Toiw95zvXYdz/N2sIUS4ZHXR05i1khQHou
         RG+q6cK0m/9SqB+3JNvZt3wHIiUpJoSEf28y30x2QM/Nw0maqgWgCk3eub07l+aZJptH
         QgGA==
X-Forwarded-Encrypted: i=1; AJvYcCWmLos9UBrYuIsbn/G3gQ9CxH2nFA17Pt8YIcLHDtn2y1iZHjGNlkSNODEWj0E8X9Z4QYe07qIG+8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4E5tt1T2yiyyThCwvPOLVKZeXhsGGu/zq0QhJxswMgezbBorW
	p3OJBLfGaMgr43o5qo1TgOWAQBP6B21LetIwMzNAVObFakcOZsginpuveA9Pq6qnzeHZm1VNKgd
	/9aSndkDWCkHWPPM6Sy2ovMCKtFG346A=
X-Gm-Gg: ASbGncula2tKwb84qu2dLMiPG/XSV1l3dbs47QkdUxROb5Q4naQOxr6BRhC2eVuTWQ1
	kfTaxx+GwYPVxzfhJdC1Km+uJbGFDV/fMcocecDz7RLoUQRxdvqWHf6zcotachj8cie8S2yznml
	xRQV2qB02SR7pouGSKMi7SP6bZpNOHVyy8ayFEVa3qFVCT7Omy3WCJyHkkLLB7Xm06TVHgUn1iR
	wAMAQ==
X-Google-Smtp-Source: AGHT+IEtjXLxIAlIjZO1F0qr9WycSD1ZAPrbkUwiPLUtpTXeaqteOuMeKZjfZDr82aKTj9nVCd78+MNo+CuBei2N65c=
X-Received: by 2002:a05:6902:140b:b0:e84:2729:81a with SMTP id
 3f1490d57ef6-e8c5fa06625mr2842105276.38.1752755067905; Thu, 17 Jul 2025
 05:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cen zhang <zzzccc427@gmail.com>
Date: Thu, 17 Jul 2025 20:24:17 +0800
X-Gm-Features: Ac12FXxxT0LYCQXw8AR9D6NPfUurITVzUH1F8X1DteAgSdB7aVvMt5cyJXFyu3w
Message-ID: <CAFRLqsUZTDm0KAfX_qziTrn6E3+sRksF5ormxhHConqTKWvHBQ@mail.gmail.com>
Subject: [BUG] KASAN: slab-use-after-free Read in xhci_hub_control
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	zhenghaoran154@gmail.com, r33s3n6@gmail.com, linux-usb@vger.kernel.org, 
	gality365@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,

I've encountered a kernel crash in the xhci driver, which was found by
Syzkaller on kernel version 6.16.0-rc6 (commit 155a3c003e55).

The KASAN report points to a slab-use-after-free read within
xhci_hub_control. What we find puzzling is that the free operation
occurred in a completely different module, as indicated by the free
stack trace.

We suspect this might not be a false positive, but rather a complex
bug whose root cause is not a simple UAF within the same driver. We've
tried to trace how this could happen but are struggling to understand
the connection.

Could you possibly offer your expertise and help us understand if this
is a known issue or a new bug? Any insight you could provide would be
immensely helpful.

The full crash log and a C reproducer are attached. Please let me know
if any further information is needed.

The full KASAN crash report is attached. Below is the C reproducer.

==================================

Syzkaller hit 'KASAN: slab-use-after-free Read in xhci_hub_control' bug.

audit: type=1400 audit(1752748042.257:8): avc:  denied  { execmem }
for  pid=280 comm="syz-executor161"
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:system_r:kernel_t:s0 tclass=process permissive=1
==================================================================
BUG: KASAN: slab-use-after-free in xhci_get_port_status
drivers/usb/host/xhci-hub.c:1169 [inline]
BUG: KASAN: slab-use-after-free in xhci_hub_control+0x5c2b/0x5e20
drivers/usb/host/xhci-hub.c:1274
Read of size 8 at addr ffff88810505d640 by task syz-executor161/280

CPU: 0 UID: 0 PID: 280 Comm: syz-executor161 Not tainted
6.16.0-rc6-00002-g155a3c003e55 #6 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xab/0xe0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcb/0x5f0 mm/kasan/report.c:480
 kasan_report+0xb8/0xf0 mm/kasan/report.c:593
 xhci_get_port_status drivers/usb/host/xhci-hub.c:1169 [inline]
 xhci_hub_control+0x5c2b/0x5e20 drivers/usb/host/xhci-hub.c:1274
 rh_call_control drivers/usb/core/hcd.c:656 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:821 [inline]
 usb_hcd_submit_urb+0x165c/0x1d30 drivers/usb/core/hcd.c:1529
 usb_submit_urb+0x866/0x1650 drivers/usb/core/urb.c:581
 proc_do_submiturb+0x192c/0x3a60 drivers/usb/core/devio.c:1971
 proc_submiturb drivers/usb/core/devio.c:2003 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2703 [inline]
 usbdev_ioctl+0x2a6e/0x4000 drivers/usb/core/devio.c:2827
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xa8/0x270 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f57d9bf4b0d
Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3159b578 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff3159b778 RCX: 00007f57d9bf4b0d
RDX: 0000000020000040 RSI: 000000008038550a RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fff3159b778
R10: 000000000000001f R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff3159b768 R14: 00007f57d9c72530 R15: 0000000000000001
 </TASK>

Allocated by task 133:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x59/0x70 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0xf2/0x320 mm/slub.c:4204
 vm_area_alloc+0x20/0x140 mm/vma_init.c:31
 do_brk_flags+0x2a4/0xec0 mm/vma.c:2753
 vm_brk_flags+0x39d/0x580 mm/mmap.c:1242
 elf_load+0x32a/0x720 fs/binfmt_elf.c:439
 load_elf_binary+0xd6c/0x4f10 fs/binfmt_elf.c:1173
 search_binary_handler fs/exec.c:1670 [inline]
 exec_binprm fs/exec.c:1702 [inline]
 bprm_execve fs/exec.c:1754 [inline]
 bprm_execve+0x7de/0x1210 fs/exec.c:1730
 do_execveat_common.isra.0+0x4bf/0x630 fs/exec.c:1860
 do_execve fs/exec.c:1934 [inline]
 __do_sys_execve fs/exec.c:2010 [inline]
 __se_sys_execve fs/exec.c:2005 [inline]
 __x64_sys_execve+0x8e/0xb0 fs/exec.c:2005
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xa8/0x270 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x38/0x50 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free_after_rcu_debug+0xb1/0x270 mm/slub.c:4693
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0x5f3/0x1a20 kernel/rcu/tree.c:2832
 handle_softirqs+0x176/0x530 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu kernel/softirq.c:680 [inline]
 irq_exit_rcu+0xaf/0xe0 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0x70/0x80 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_record_aux_stack+0x8c/0xa0 mm/kasan/generic.c:548
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4643 [inline]
 kmem_cache_free+0xdd/0x380 mm/slub.c:4745
 exit_mmap+0x3dc/0x8f0 mm/mmap.c:1309
 __mmput kernel/fork.c:1121 [inline]
 mmput+0x6e/0x320 kernel/fork.c:1144
 exit_mm kernel/exit.c:581 [inline]
 do_exit+0x713/0x2740 kernel/exit.c:952
 do_group_exit+0xc7/0x280 kernel/exit.c:1105
 __do_sys_exit_group kernel/exit.c:1116 [inline]
 __se_sys_exit_group kernel/exit.c:1114 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1114
 x64_sys_call+0xf76/0x18a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xa8/0x270 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88810505d600
 which belongs to the cache vm_area_struct of size 192
The buggy address is located 64 bytes inside of
 freed 192-byte region [ffff88810505d600, ffff88810505d6c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10505d
flags: 0x200000000000000(node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000000 ffff888100199400 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810505d500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810505d580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88810505d600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88810505d680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88810505d700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 UID: 0 PID: 280 Comm: syz-executor161 Tainted: G    B
    6.16.0-rc6-00002-g155a3c003e55 #6 PREEMPT(voluntary)
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:xhci_get_usb3_port_status drivers/usb/host/xhci-hub.c:1051 [inline]
RIP: 0010:xhci_get_port_status drivers/usb/host/xhci-hub.c:1195 [inline]
RIP: 0010:xhci_hub_control+0x647/0x5e20 drivers/usb/host/xhci-hub.c:1274
Code: fe 83 4c 24 08 10 e8 a8 56 0b fe 48 8b 44 24 10 48 83 c0 10 48
89 c2 48 89 44 24 70 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
02 00 0f 85 71 52 00 00 48 8b 44 24 10 44 89 eb 44 89 e6 bf
RSP: 0018:ffff888115a0f900 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffffb2e15c18
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff88810675e000 R08: 0000000000000001 R09: fffffbfff6cece0c
R10: 0000000000000000 R11: 6e696c6261736944 R12: 0000000000000040
R13: 0000000000001203 R14: ffff88810675ac58 R15: ffff88810675a000
FS:  000055556b2073c0(0000) GS:ffff8882408fe000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000090 CR3: 0000000104f44001 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 rh_call_control drivers/usb/core/hcd.c:656 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:821 [inline]
 usb_hcd_submit_urb+0x165c/0x1d30 drivers/usb/core/hcd.c:1529
 usb_submit_urb+0x866/0x1650 drivers/usb/core/urb.c:581
 proc_do_submiturb+0x192c/0x3a60 drivers/usb/core/devio.c:1971
 proc_submiturb drivers/usb/core/devio.c:2003 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2703 [inline]
 usbdev_ioctl+0x2a6e/0x4000 drivers/usb/core/devio.c:2827
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xa8/0x270 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f57d9bf4b0d
Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3159b578 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff3159b778 RCX: 00007f57d9bf4b0d
RDX: 0000000020000040 RSI: 000000008038550a RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fff3159b778
R10: 000000000000001f R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff3159b768 R14: 00007f57d9c72530 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:xhci_get_usb3_port_status drivers/usb/host/xhci-hub.c:1051 [inline]
RIP: 0010:xhci_get_port_status drivers/usb/host/xhci-hub.c:1195 [inline]
RIP: 0010:xhci_hub_control+0x647/0x5e20 drivers/usb/host/xhci-hub.c:1274
Code: fe 83 4c 24 08 10 e8 a8 56 0b fe 48 8b 44 24 10 48 83 c0 10 48
89 c2 48 89 44 24 70 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
02 00 0f 85 71 52 00 00 48 8b 44 24 10 44 89 eb 44 89 e6 bf
RSP: 0018:ffff888115a0f900 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffffb2e15c18
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff88810675e000 R08: 0000000000000001 R09: fffffbfff6cece0c
R10: 0000000000000000 R11: 6e696c6261736944 R12: 0000000000000040
R13: 0000000000001203 R14: ffff88810675ac58 R15: ffff88810675a000
FS:  000055556b2073c0(0000) GS:ffff8882408fe000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000090 CR3: 0000000104f44001 CR4: 0000000000770ef0
PKRU: 55555554
note: syz-executor161[280] exited with irqs disabled
note: syz-executor161[280] exited with preempt_count 1
journal-offline (281) used greatest stack depth: 25016 bytes left
----------------
Code disassembly (best guess):
   0: fe 83 4c 24 08 10     incb   0x1008244c(%rbx)
   6: e8 a8 56 0b fe       call   0xfe0b56b3
   b: 48 8b 44 24 10       mov    0x10(%rsp),%rax
  10: 48 83 c0 10           add    $0x10,%rax
  14: 48 89 c2             mov    %rax,%rdx
  17: 48 89 44 24 70       mov    %rax,0x70(%rsp)
  1c: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  23: fc ff df
  26: 48 c1 ea 03           shr    $0x3,%rdx
* 2a: 80 3c 02 00           cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e: 0f 85 71 52 00 00     jne    0x52a5
  34: 48 8b 44 24 10       mov    0x10(%rsp),%rax
  39: 44 89 eb             mov    %r13d,%ebx
  3c: 44 89 e6             mov    %r12d,%esi
  3f: bf                   .byte 0xbf


Syzkaller reproducer:
# {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1
Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
Fault:false FaultCall:0 FaultNth:0}}
r0 = syz_open_dev$usbfs(&(0x7f0000000080), 0x200, 0x1)
ioctl$USBDEVFS_SUBMITURB(r0, 0x8038550a,
&(0x7f0000000040)=@urb_type_control={0x2, {}, 0x0, 0x0,
&(0x7f0000000000)={0xa3, 0x0, 0x0, 0x8001}, 0x8, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0})


C reproducer:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#define BITMASK(bf_off,bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type,htobe,addr,val,bf_off,bf_len)
*(type*)(addr) = htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off),
(bf_len))) | (((type)(val) << (bf_off)) & BITMASK((bf_off),
(bf_len))))

static long syz_open_dev(volatile long a0, volatile long a1, volatile long a2)
{
if (a0 == 0xc || a0 == 0xb) {
char buf[128];
sprintf(buf, "/dev/%s/%d:%d", a0 == 0xc ? "char" : "block",
(uint8_t)a1, (uint8_t)a2);
return open(buf, O_RDWR, 0);
} else {
char buf[1024];
char* hash;
strncpy(buf, (char*)a0, sizeof(buf) - 1);
buf[sizeof(buf) - 1] = 0;
while ((hash = strchr(buf, '#'))) {
*hash = '0' + (char)(a1 % 10);
a1 /= 10;
}
return open(buf, a2, 0);
}
}

uint64_t r[1] = {0xffffffffffffffff};

int main(void)
{
syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul,
/*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
/*prot=*/7ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul,
/*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
intptr_t res = 0;
memcpy((void*)0x20000080, "/dev/bus/usb/00#/00#\000", 21);
res = -1;
res = syz_open_dev(/*dev=*/0x20000080, /*id=*/0x200, /*flags=*/1);
if (res != -1)
r[0] = res;
*(uint8_t*)0x20000040 = 2;
STORE_BY_BITMASK(uint8_t, , 0x20000041, 0, 0, 7);
STORE_BY_BITMASK(uint8_t, , 0x20000041, 0, 7, 1);
*(uint32_t*)0x20000044 = 0;
*(uint32_t*)0x20000048 = 0;
*(uint64_t*)0x20000050 = 0x20000000;
*(uint8_t*)0x20000000 = 0xa3;
*(uint8_t*)0x20000001 = 0;
*(uint16_t*)0x20000002 = 0;
*(uint16_t*)0x20000004 = 0x8001;
*(uint16_t*)0x20000006 = 0;
*(uint32_t*)0x20000058 = 8;
*(uint32_t*)0x2000005c = 0;
*(uint32_t*)0x20000060 = 0;
*(uint32_t*)0x20000064 = 0;
*(uint32_t*)0x20000068 = 0;
*(uint32_t*)0x2000006c = 0;
*(uint64_t*)0x20000070 = 0;
syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x8038550a, /*arg=*/0x20000040ul);
return 0;
}

=======================================================

