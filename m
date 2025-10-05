Return-Path: <linux-kernel+bounces-842251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8971BB955C
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 12:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F17424E38B6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2526056A;
	Sun,  5 Oct 2025 10:08:37 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D876235362
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759658917; cv=none; b=rIwe/W8G2KqvIzK/GC9+RMtBCGwjhJf1rsuEkUW1PRcvc5cwnsE53obu/jjUIGnfhgR0X3QvCaMzrnpxdhZ0t6MQYhegOleE9BEE6Ye0x6glfuxqoPsI6hDanQAHoAVCF09mBxGQnVeImiSAJwKOGvYYjdqUavq6iRuN7uFjsC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759658917; c=relaxed/simple;
	bh=hhWClXNgtDOZsmvJoCjapJJzFDw1Ryv+I2YDhlfT7cc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pFH9DA4pm+fn6A2QPB/27xplb0FzgHTvn5FZ40fMN8i/9i3nmN0TeDFuv0G2HPh/o+WQ4Ajd24tOiEkUzkecTP4TSDFhZWF/JAELoxHf9c71bWwAClZkPsJttx9iZAv0qRJIhU6B4lRP/5EjGxAeHzkprXJ6v4eItq38SbTZ9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42f6639fb22so11365995ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 03:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759658914; x=1760263714;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cp3XjUmOtiFA8gY7tVfMRGjcT/HT+3YZY/PIJ5r7NKs=;
        b=xLeVF7wbmrtcHu35rGbSAFCwdRfqzJ/RttNu1FGR/Qi1EFDZygJNoBr5Wx5cWFiaVJ
         q8hzeqUCOrlYqEq6qSfadZ12AWbysITl6PQT67KXDkag+puU64TPr8g+QMhlJTZEDRx7
         3rzKIRzE8r2nIl0Mm0nKD/2YGWwHnq8Ywus7w7wyH8XzGew9kBMpMcUjmPrdtRFoDZox
         nsJLcymumnJkOiwy7BZO23DDAkQ/JHv1L6Ww+68yR2p9qThXlBeWKl4YROxN0nm5pnHS
         oeLzltdituH5344g3egEpDML+GrLeO+V1DXzFBRQqah58MOaPfvIFwqOdnEP2l3lJ3oc
         AxnA==
X-Forwarded-Encrypted: i=1; AJvYcCXbAr/FAiUfhL9jBeqU9CU1b+fzQpfCf+F78wHJg1L0WgQcjXJam+D3kBWrwIre6u+UXih7rJrrNLQWtdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmjiIYg1t1GSD0PSrHZYX7kkWYhqSIg3SbltCnQ6KSwggbGcx
	h23XgQiTHBVfrm7jbYc5LQV/Hw/mxorjr1t5RWZMmZquGU4+h6wpqiPdG/nEGAr5kb/9qOoY7v3
	2DCX341va8ambqIKQ9KE3exrzQ9WKbo4SmjaUNpQ3gPhNrQuqMWd8b1kKXxM=
X-Google-Smtp-Source: AGHT+IGm/JYRZQbHt2y6Uy0su0YELwVNoEHUUf680jXFA3IO1LWGxEYP/KDF3JHXgTHB7zjHOe/yPpREngR5D9EnBRRNKnNOYjDU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:42e:7a9d:f5ff with SMTP id
 e9e14a558f8ab-42e7ad1c37bmr127936565ab.11.1759658914372; Sun, 05 Oct 2025
 03:08:34 -0700 (PDT)
Date: Sun, 05 Oct 2025 03:08:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e243a2.050a0220.1696c6.007d.GAE@google.com>
Subject: [syzbot] [bpf?] KASAN: invalid-access Write in do_bad_area
From: syzbot <syzbot+997752115a851cb0cf36@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cbf33b8e0b36 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163faee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b53c82f05ee6dcd3
dashboard link: https://syzkaller.appspot.com/bug?extid=997752115a851cb0cf36
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-cbf33b8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f5bb09b140b/vmlinux-cbf33b8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/89c21689077a/Image-cbf33b8e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+997752115a851cb0cf36@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: invalid-access in __memcpy+0xc/0x54 arch/arm64/lib/memcpy.S:250
Write at addr fcff8000832951b8 by task syz.0.3/3493
Pointer tag: [fc], memory tag: [fe]

CPU: 1 UID: 0 PID: 3493 Comm: syz.0.3 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x78/0x90 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x108/0x61c mm/kasan/report.c:482
 kasan_report+0x88/0xac mm/kasan/report.c:595
 report_tag_fault arch/arm64/mm/fault.c:326 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:338 [inline]
 __do_kernel_fault+0x170/0x1c8 arch/arm64/mm/fault.c:380
 do_bad_area+0x68/0x78 arch/arm64/mm/fault.c:480
 do_tag_check_fault+0x34/0x44 arch/arm64/mm/fault.c:853
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:929
 el1_abort+0x44/0x68 arch/arm64/kernel/entry-common.c:325
 el1h_64_sync_handler+0x50/0xac arch/arm64/kernel/entry-common.c:459
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:591
 __memcpy+0xc/0x54 arch/arm64/lib/memcpy.S:250 (P)
 convert_ctx_accesses+0x694/0xb28 kernel/bpf/verifier.c:21478
 bpf_check+0x1338/0x2a24 kernel/bpf/verifier.c:24683
 bpf_prog_load+0x63c/0xcd4 kernel/bpf/syscall.c:3062
 __sys_bpf+0x2e0/0x1a88 kernel/bpf/syscall.c:6134
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __arm64_sys_bpf+0x24/0x34 kernel/bpf/syscall.c:6242
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0x10c arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596

The buggy address belongs to a 1-page vmalloc region starting at 0xfcff800083295000 allocated at bpf_check+0x8c/0x2a24 kernel/bpf/verifier.c:24529
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xf00000000 pfn:0x499eb
flags: 0x1ffcc0000000000(node=0|zone=0|lastcpupid=0x7ff|kasantag=0x3)
raw: 01ffcc0000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000f00000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
Unable to handle kernel paging request at virtual address ffff800083294f00
Mem abort info:
  ESR = 0x0000000096000007
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 52-bit VAs, pgdp=0000000042981000
[ffff800083294f00] pgd=1000000042ed3003, p4d=1000000042ed4003, pud=1000000042ed5003, pmd=1000000043129403, pte=0000000000000000
Internal error: Oops: 0000000096000007 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 3493 Comm: syz.0.3 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
pstate: 624020c9 (nZCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
pc : mte_get_mem_tag arch/arm64/include/asm/mte-kasan.h:101 [inline]
pc : kasan_metadata_fetch_row+0xc/0x28 mm/kasan/report_hw_tags.c:62
lr : print_memory_metadata mm/kasan/report.c:458 [inline]
lr : print_report+0x29c/0x61c mm/kasan/report.c:483
sp : ffff8000892335e0
x29: ffff8000892335e0 x28: faf000000a58a580 x27: faff80008328d060
x26: 0000000000000058 x25: ffff800082448bd0 x24: ffff800082448bd8
x23: ffff8000832951b8 x22: ffff800082419660 x21: ffff800083295000
x20: 00000000fffffffe x19: ffff800083294f00 x18: 0000000000000010
x17: ffff8000828ffa60 x16: 0000000000006200 x15: ffff800089233460
x14: ffff80008923365c x13: ffff800089233649 x12: ffff8000829ff3c0
x11: 0000000000000001 x10: 0000000000000001 x9 : 000000000002ffe8
x8 : faf000000a58a580 x7 : 0000000000000010 x6 : ffff800081c70640
x5 : 0000000000000030 x4 : 0000000000000002 x3 : ffff800083295000
x2 : ffff800083294f00 x1 : ffff800083294f10 x0 : ffff800089233638
Call trace:
 kasan_metadata_fetch_row+0xc/0x28 mm/kasan/report_hw_tags.c:61 (P)
 kasan_report+0x88/0xac mm/kasan/report.c:595
 report_tag_fault arch/arm64/mm/fault.c:326 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:338 [inline]
 __do_kernel_fault+0x170/0x1c8 arch/arm64/mm/fault.c:380
 do_bad_area+0x68/0x78 arch/arm64/mm/fault.c:480
 do_tag_check_fault+0x34/0x44 arch/arm64/mm/fault.c:853
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:929
 el1_abort+0x44/0x68 arch/arm64/kernel/entry-common.c:325
 el1h_64_sync_handler+0x50/0xac arch/arm64/kernel/entry-common.c:459
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:591
 __memcpy+0xc/0x54 arch/arm64/lib/memcpy.S:250 (P)
 convert_ctx_accesses+0x694/0xb28 kernel/bpf/verifier.c:21478
 bpf_check+0x1338/0x2a24 kernel/bpf/verifier.c:24683
 bpf_prog_load+0x63c/0xcd4 kernel/bpf/syscall.c:3062
 __sys_bpf+0x2e0/0x1a88 kernel/bpf/syscall.c:6134
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __arm64_sys_bpf+0x24/0x34 kernel/bpf/syscall.c:6242
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0x10c arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:763
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596
Code: d65f03c0 91040023 aa0103e2 91004021 (d9600042) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d65f03c0 	ret
   4:	91040023 	add	x3, x1, #0x100
   8:	aa0103e2 	mov	x2, x1
   c:	91004021 	add	x1, x1, #0x10
* 10:	d9600042 	ldg	x2, [x2] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

