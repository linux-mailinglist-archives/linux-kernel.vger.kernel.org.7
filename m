Return-Path: <linux-kernel+bounces-886730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC96FC365D9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B94A5017A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0ED33BBC7;
	Wed,  5 Nov 2025 15:20:42 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2933B960
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356041; cv=none; b=gfLKfpw444FI2cO5dbFYjMNgcVeQ542kp2jAMFOBp+DCwi7kEXtQ0YKJCxjpINn3o6z6PhIgpD82HUrt7Br3MElWAd626/fZWoYUfIHK754LL9h+0mZzdFwns+6rvZ5CcmFhbGRwEc+lQB4alAjGU+U0P0G61Plqsesm+lnBduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356041; c=relaxed/simple;
	bh=uEUrYYWjCkYSnb9OGnMMIzWzDF2bcruuWfTI0czAhgE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nkuNjBazEKjyxjXINomxu25a29l7crDv807HTI9fO2k9hnLLKO8rHyy8sx9ygI5uV02vSX19mKBZZuilOVxFMaPrGrLz7tBl6YiPmjh9m0hTJoMls1vg1GMr7pY4aXj1JPt0pUIsLZYYPFObPePKIBhb8M+w1d3NQ9dJcsfHOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43327c30cb1so37262755ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356039; x=1762960839;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2mtokqVMxIieQk/oFRmue39riC5tUMT/8caqlf8erY=;
        b=lsbVALTtFmPkN8Syxc3+VK9IHhOXW4X4xhl1R8pCJpy8reBscipyN2B1LDSTi9knRB
         A3x60DZq2hmf+W4JODCDwld47hmtntCp3oTZg4+GCNX/C5feQlezxHj5aCGBLSw2nNTN
         L2shdumX5He75NRiEJxu02YuYQyp5XLeZ3L5Zuut8N2p7VowyehTDv4D65MxnrD4aCw6
         pNhggqaCNo9gsEC8tBKq8G/EviXyMfWt2nE7SViJDPb6W3sHE0/eXgyPBWpSNgbY1CuL
         MvvB8D8ggla4b2X8qPYT39V9MJxvNbIwBrlGPmWT7CINkQ6Wx4OBwL23ktBR8kfUHv9D
         zrgw==
X-Gm-Message-State: AOJu0YxPxp69I4jPs+fEVKMWBNvrnoN/zrZOFLNKBEoYLQfSlvecY4Kz
	pJVwjVpNZ0SV84OKbu/JSEe63/z8YWHdEd6/rS5LMlb9R+vk9cSnuKJ/NoJbpReloQKSO2mQUR2
	a0s6G/EofAO6TVZ686nk8q9A5i/rDj86xh2Hl9t8Hvk23RyCVuxhXPaK0aeD44Q==
X-Google-Smtp-Source: AGHT+IEznQLXAFE2QpWOxdnkc28VsbmWRoDM9D+Nb1u6yTa/A3sbCKMYdxnVdw2JOD900ysYt5+OYxKc90Ogl072cAzHXNWvt1v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:433:2711:c5cc with SMTP id
 e9e14a558f8ab-433407d953bmr45918955ab.32.1762356038723; Wed, 05 Nov 2025
 07:20:38 -0800 (PST)
Date: Wed, 05 Nov 2025 07:20:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b6b46.050a0220.3d0d33.0054.GAE@google.com>
Subject: [syzbot] [sound?] [usb?] KASAN: slab-out-of-bounds Write in copy_to_urb
From: syzbot <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org, perex@perex.cz, syzkaller-bugs@googlegroups.com, 
	tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ba36dd5ee6fd Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1759afe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c74292580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107bffe2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ba36dd5e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3d081e7b0db/vmlinux-ba36dd5e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/612c239b909b/bzImage-ba36dd5e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461

CPU: 0 UID: 0 PID: 5461 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
 prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
 prepare_outbound_urb+0x377/0xc50 sound/usb/endpoint.c:333
 snd_usb_endpoint_start+0x4d8/0x14a0 sound/usb/endpoint.c:1591
 start_endpoints+0xa1/0x280 sound/usb/pcm.c:291
 snd_usb_substream_playback_trigger+0x3e0/0x7a0 sound/usb/pcm.c:1711
 snd_pcm_do_start+0xb7/0x180 sound/core/pcm_native.c:1454
 snd_pcm_action_single sound/core/pcm_native.c:1310 [inline]
 snd_pcm_action+0xe7/0x240 sound/core/pcm_native.c:1393
 __snd_pcm_lib_xfer+0x1762/0x1ce0 sound/core/pcm_lib.c:2405
 snd_pcm_oss_write3+0x1bc/0x320 sound/core/oss/pcm_oss.c:1241
 snd_pcm_plug_write_transfer+0x2cb/0x4c0 sound/core/oss/pcm_plugin.c:630
 snd_pcm_oss_write2 sound/core/oss/pcm_oss.c:1373 [inline]
 snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1439 [inline]
 snd_pcm_oss_write+0xb9c/0x1190 sound/core/oss/pcm_oss.c:2794
 vfs_write+0x27e/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff91798efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee4c24fc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ff917be5fa0 RCX: 00007ff91798efc9
RDX: 00000000000005ce RSI: 0000200000000e00 RDI: 0000000000000004
RBP: 00007ff917a11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff917be5fa0 R14: 00007ff917be5fa0 R15: 0000000000000003
 </TASK>

Allocated by task 5461:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5642 [inline]
 __kmalloc_noprof+0x411/0x7f0 mm/slub.c:5654
 data_ep_set_params sound/usb/endpoint.c:1242 [inline]
 snd_usb_endpoint_set_params+0x1610/0x29a0 sound/usb/endpoint.c:1374
 snd_usb_hw_params+0xb12/0x1280 sound/usb/pcm.c:576
 snd_pcm_hw_params+0x89d/0x1d30 sound/core/pcm_native.c:804
 snd_pcm_oss_change_params_locked+0x21cb/0x3e40 sound/core/oss/pcm_oss.c:965
 snd_pcm_oss_make_ready_locked sound/core/oss/pcm_oss.c:1186 [inline]
 snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1404 [inline]
 snd_pcm_oss_write+0x2fb/0x1190 sound/core/oss/pcm_oss.c:2794
 vfs_write+0x27e/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801107b400
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 allocated 54-byte region [ffff88801107b400, ffff88801107b436)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1107b
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a0418c0 ffffea000045fc80 dead000000000005
raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5341, tgid 5341 (syz-executor), ts 97923846546, free_ts 97738761799
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3055 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3228
 new_slab mm/slub.c:3282 [inline]
 ___slab_alloc+0xe94/0x18a0 mm/slub.c:4651
 __slab_alloc+0x65/0x100 mm/slub.c:4770
 __slab_alloc_node mm/slub.c:4846 [inline]
 slab_alloc_node mm/slub.c:5268 [inline]
 __do_kmalloc_node mm/slub.c:5641 [inline]
 __kmalloc_noprof+0x471/0x7f0 mm/slub.c:5654
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x28b/0x550 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x58d/0x5d0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x1c1/0x3b0 security/tomoyo/file.c:771
 security_file_open+0xb1/0x270 security/security.c:3183
 do_dentry_open+0x384/0x13f0 fs/open.c:942
 vfs_open+0x3b/0x340 fs/open.c:1097
 do_open fs/namei.c:3975 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4134
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
page last free pid 5331 tgid 5331 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 vfree+0x25a/0x400 mm/vmalloc.c:3440
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x2300 kernel/exit.c:966
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1107
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0xa0/0x790 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x72/0x130 kernel/entry/common.c:40
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801107b300: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff88801107b380: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff88801107b400: 00 00 00 00 00 00 06 fc fc fc fc fc fc fc fc fc
                                     ^
 ffff88801107b480: 00 00 00 00 00 00 06 fc fc fc fc fc fc fc fc fc
 ffff88801107b500: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


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

