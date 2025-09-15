Return-Path: <linux-kernel+bounces-817912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D78B58883
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD51AA842E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB82DC32D;
	Mon, 15 Sep 2025 23:46:33 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE752DA76A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979992; cv=none; b=bemugKhDTEEyHAry2SfPnFfE9mdrf35jUfFuo5RgTFCl+15wYjtz6MBh7oKzI5Nqhv3nb46Jy3IgQ6MJWyPwKW4ac02cMYZNbHmviUiOon1Qr5MZ4GpzlkhSfJYmbTOR6UioK4KS2I7VcWvcAzRyzB2S430gwA9Xorwd/KZqVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979992; c=relaxed/simple;
	bh=MnFYuAEn33wJLxLN1nIDMasehO+lUx1cgckask6jpPk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=umPMI5xFLE1Naq8ONU+LWzkiqfi2kth80hDLT9oLtNRnInR6bgS8sch8aMjEutesXVXPTI+G8iZcxEVvNuFRL6NqagA3Ip/OZzc/yY2D6+WsajrIFzQZjxgJn8YYGZ8HcLMn468FMrlnBPtMcPoQlNCZ3p4M1n6ackfjL7L9BME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-400bb989b1aso158081155ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757979990; x=1758584790;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxkRSaEI9pzMUdH38ycDe6tZ7GPxP5ZO+AkLqPcEh2k=;
        b=RB9p4opu8kY12piiDogkaLXjhsMdBgqTpJ0tyM6/73iQeC91B0VY5/txYFfwrSyfPF
         78KvhuZXbh7nxJhWf4ePtS0WNVGTa0omUSBbpg2QcRMy+3VSnS5xhe04a+EL49eMLX9p
         9HeuuSedgelsDrsB5Mr80VWvr/fY8s8yXSXAOtPPoj//llANfUzvMqIqFTlKJWqVGpO1
         ZeI+hykq3rrOsq/Uj80NLb0hIvd+TdUiPQ8sz6S37RbqgkOXNia0XIppZXJrp28TSGr1
         SN545rirkoSwhTdbBihmtZNfqF+13Q96/AKlr/8sQJsjqDA/e9//FR0J//r27UlTIL6T
         Lfug==
X-Forwarded-Encrypted: i=1; AJvYcCUotNj8eurWaxQbD5wx7+tPQ9TN9zELCv6Qf1lStM34QGCuD61RJvZ1hielHZfI6G9Idf0VJDg+06dS7xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylcZotbhLok38vQIRXqmR8BetV0kdKwjunK/dojqTAUpjKZzit
	B09oUsU1ZLDXQQM8nTkyqTHelnrHSCdxhj1A4lO2MUXZmjuLO09HQwDyQ/qggA0fmhgNkb4cZaG
	4ib4lhTibiMcaamZRkcmNyRVm39dEBLILjxDwHmfeJDR2eCcKYKOf8wlW6JM=
X-Google-Smtp-Source: AGHT+IH1ocBX3NQo78mSvjN+yIDAfRzxIpd5nD1bXpJ/K9oj4cElrVK6tdvt0ZvLHnQdhMx1M3DgPNa5iwmTEwerldu2OZdsDFVG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0f:0:b0:424:7bb:775c with SMTP id
 e9e14a558f8ab-42407bb7949mr43715965ab.31.1757979990306; Mon, 15 Sep 2025
 16:46:30 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:46:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8a556.050a0220.2ff435.03b6.GAE@google.com>
Subject: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_copygc (2)
From: syzbot <syzbot+ccfda19732868508d917@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10547b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=ccfda19732868508d917
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f83ec76b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16b6888b2528/vmlinux-f83ec76b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f228e7d0456a/bzImage-f83ec76b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccfda19732868508d917@syzkaller.appspotmail.com

bcachefs (loop0): Detected missing backpointers in bucket 34, now have 1/128 with missing
  running recovery pass check_extents_to_backpointers (17), currently at resume_logged_ops (39)
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in bch2_bucket_bitmap_test fs/bcachefs/backpointers.h:194 [inline]
BUG: KASAN: slab-use-after-free in bch2_bucket_is_movable fs/bcachefs/movinggc.c:78 [inline]
BUG: KASAN: slab-use-after-free in bch2_copygc_get_buckets fs/bcachefs/movinggc.c:157 [inline]
BUG: KASAN: slab-use-after-free in bch2_copygc+0x105d/0x4510 fs/bcachefs/movinggc.c:221
Read of size 8 at addr ffff8880558596a0 by task bch-copygc/loop/5366

CPU: 0 UID: 0 PID: 5366 Comm: bch-copygc/loop Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 bch2_bucket_bitmap_test fs/bcachefs/backpointers.h:194 [inline]
 bch2_bucket_is_movable fs/bcachefs/movinggc.c:78 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:157 [inline]
 bch2_copygc+0x105d/0x4510 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x97a/0xe00 fs/bcachefs/movinggc.c:409
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5366:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kvmalloc_node_noprof+0x30d/0x5f0 mm/slub.c:5067
 kvmalloc_array_node_noprof include/linux/slab.h:1065 [inline]
 bch2_bucket_bitmap_set+0x9a/0x1d0 fs/bcachefs/backpointers.c:1351
 check_bucket_backpointer_mismatch+0x1bdf/0x23a0 fs/bcachefs/backpointers.c:964
 check_bucket_backpointer_pos_mismatch fs/bcachefs/backpointers.c:1193 [inline]
 bch2_check_bucket_backpointer_mismatch+0x36c/0x690 fs/bcachefs/backpointers.c:1205
 __bch2_move_data_phys+0x17a7/0x1c50 fs/bcachefs/move.c:922
 bch2_evacuate_bucket+0x228/0x3a0 fs/bcachefs/move.c:1082
 bch2_copygc+0x3be3/0x4510 fs/bcachefs/movinggc.c:234
 bch2_copygc_thread+0x97a/0xe00 fs/bcachefs/movinggc.c:409
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880558596a0
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
 freed 16-byte region [ffff8880558596a0, ffff8880558596b0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x55859
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801a841640 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5354, tgid 5353 (syz.0.0), ts 76068484835, free_ts 0
 create_dummy_stack mm/page_owner.c:94 [inline]
 register_dummy_stack+0x89/0xe0 mm/page_owner.c:100
 init_page_owner+0x2e/0x620 mm/page_owner.c:118
 invoke_init_callbacks mm/page_ext.c:148 [inline]
 page_ext_init+0x511/0x550 mm/page_ext.c:486
 mm_core_init+0x56/0x70 mm/mm_init.c:2789
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888055859580: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
 ffff888055859600: fa fb fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
>ffff888055859680: 00 00 fc fc fb fb fc fc 00 00 fc fc fa fb fc fc
                               ^
 ffff888055859700: fa fb fc fc 00 00 fc fc fa fb fc fc fa fb fc fc
 ffff888055859780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

