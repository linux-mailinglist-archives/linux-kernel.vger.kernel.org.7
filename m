Return-Path: <linux-kernel+bounces-802963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59430B458F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575D55844BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFEB352087;
	Fri,  5 Sep 2025 13:25:37 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C5342CB6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078737; cv=none; b=NpkAF/eiTYHfrPiicWy5tutRcau5mlGUHegjdCaKGoCXKMRoEGCxLWv/2U2euYfVOmpJsrRRSjQvEh9SSi8rfafI5wRKSLtMPUUaUGqTSc8j56BTspe+byJ/GbS3q//sAGmoipznlXYOfmZl9JSft7raGVxCvcLIzNvQSJhiCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078737; c=relaxed/simple;
	bh=tGO4cCRapMvGI0EUV64jUXVAQdqrOE8X7PZsB2baUOs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BTXFU8/LkDkXzJfsjnHUHwzCHOZ9KJ4iks9FzttregD/4RpXCSfNgJYMlAlQMkYPMMrR+D4G8iqY0Ho6pTD4rTokVu8HzVZXTkKFfSiXYmeRiI2wAJfKmGOtlJsqlSnvjkpmQ5IOqmRmRu605Klaq0XCNZ2wNN2MOoS4Sbr5FCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f29a0a7643so21793425ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757078735; x=1757683535;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4Elh7QOytx4ZZgIek2zTHwssf7pXDqP3udNq6JZzVo=;
        b=b2YA5jDmybbnH4XEhZlzPnk6sVeCPqvO36RyAqmixCUnbtjDOn7Mv3LYXzjAXPs1mM
         OWzYExzRn5/N08ydA3mZBtIb4IyXcv/fMMX1BRjInvD2t1UZ2VjfelPLrqJcJYYOPupc
         clNkuUaGGdtzj0ZM9Ei0P/YNEsRESviVh1/qgjsv/7CeGL0hWvG163/W/rV3Z3pO8hxn
         f1FbSxLUSuQUELEvYbfxvKe2Afl67D/DZezldCv0iHmVpVTsYGGGdobcQyLhF/Of/RPg
         ClTJ0PZlk/fPkAwCMm7yWrhrRtdxOSs4FPopBypAGmVxailTZmXHFOjKYWUUzEropOhW
         zttA==
X-Forwarded-Encrypted: i=1; AJvYcCWezRL7IS1f4YEBSdsdgBmx10Vkryyj55Iz8B7RmJ+65OvJKTdYkcqXXC6HUlmHGaBZ5AGXg5EWB1szmsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1LhD6qEAxziS/5mdvcP6Ba+MhIvK/wjkwt/bT3B5yO9LXdtf
	Fgt1ukzLkIA1e/wP6PM9OQDQcLlUcDlu35e045unT1QLbzLtcclu4Q0JhMFpya/4DlSuro5G3m+
	/swUFiQXCazVhwXLakxNd9G5g2dcxZpY5MFE44uaFGoJC6Vcs+TOnpxBIOJs=
X-Google-Smtp-Source: AGHT+IHwnwdRge0T4S8uURmNjM4GphB5kqRkJAS0qTVE25vmjSTY4Dd9PV0NRYsZElZozbPfLsk9iw1nBRpF7YF20+/HvE18CegU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:228f:b0:3f9:6c36:ca1e with SMTP id
 e9e14a558f8ab-3f96c36cc58mr21575495ab.4.1757078734659; Fri, 05 Sep 2025
 06:25:34 -0700 (PDT)
Date: Fri, 05 Sep 2025 06:25:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bae4ce.a00a0220.eb3d.0014.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in unpin_user_page_range_dirty_lock
From: syzbot <syzbot+0d2f32dad7098551e15d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, jgg@ziepe.ca, 
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	peterx@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4ac65880ebca Add linux-next specific files for 20250904
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=138b087c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbc16d9faf3a88a4
dashboard link: https://syzkaller.appspot.com/bug?extid=0d2f32dad7098551e15d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a8a134580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159de962580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/36645a51612c/disk-4ac65880.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bba80d634bef/vmlinux-4ac65880.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e58dd70dfd0f/bzImage-4ac65880.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d2f32dad7098551e15d@syzkaller.appspotmail.com

mmap: syz.0.17 (6062) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 6062 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
RIP: 0010:gup_folio_range_next mm/gup.c:241 [inline]
RIP: 0010:unpin_user_page_range_dirty_lock+0x63/0x4e0 mm/gup.c:369
Code: 45 31 ed 4c 89 74 24 18 4c 89 6c 24 10 49 c1 e5 06 4b 8d 1c 2e 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 ff 3e 1c 00 4d 01 f5 4c 8b 23 4c 89
RSP: 0018:ffffc9000413f6d0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffea0002d10037 R09: 1ffffd40005a2006
R10: dffffc0000000000 R11: fffff940005a2007 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555587af6500(0000) GS:ffff8881259fa000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 0000000074024000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 batch_unpin+0x3eb/0x560 drivers/iommu/iommufd/pages.c:691
 iopt_pages_unpin_xarray drivers/iommu/iommufd/pages.c:1711 [inline]
 iopt_pages_unfill_xarray+0x813/0xaa0 drivers/iommu/iommufd/pages.c:1747
 iopt_area_remove_access+0x2c4/0x3f0 drivers/iommu/iommufd/pages.c:2196
 iommufd_access_unpin_pages+0x33b/0x4e0 drivers/iommu/iommufd/device.c:1357
 iommufd_test_access_unmap+0x28c/0x300 drivers/iommu/iommufd/selftest.c:1448
 iommufd_test_staccess_release+0x6a/0xb0 drivers/iommu/iommufd/selftest.c:1489
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd6e78ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd897539d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000019b27 RCX: 00007fdd6e78ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000789753ccf
R10: 0000001b31420000 R11: 0000000000000246 R12: 00007fdd6e9c5fac
R13: 00007fdd6e9c5fa0 R14: ffffffffffffffff R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
RIP: 0010:gup_folio_range_next mm/gup.c:241 [inline]
RIP: 0010:unpin_user_page_range_dirty_lock+0x63/0x4e0 mm/gup.c:369
Code: 45 31 ed 4c 89 74 24 18 4c 89 6c 24 10 49 c1 e5 06 4b 8d 1c 2e 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 ff 3e 1c 00 4d 01 f5 4c 8b 23 4c 89
RSP: 0018:ffffc9000413f6d0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffea0002d10037 R09: 1ffffd40005a2006
R10: dffffc0000000000 R11: fffff940005a2007 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555587af6500(0000) GS:ffff8881259fa000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 0000000074024000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	45 31 ed             	xor    %r13d,%r13d
   3:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
   8:	4c 89 6c 24 10       	mov    %r13,0x10(%rsp)
   d:	49 c1 e5 06          	shl    $0x6,%r13
  11:	4b 8d 1c 2e          	lea    (%r14,%r13,1),%rbx
  15:	48 83 c3 08          	add    $0x8,%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 ff 3e 1c 00       	call   0x1c3f37
  38:	4d 01 f5             	add    %r14,%r13
  3b:	4c 8b 23             	mov    (%rbx),%r12
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89


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

