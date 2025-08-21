Return-Path: <linux-kernel+bounces-779163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB6AB2EFE1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B34A188E7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC92E92BB;
	Thu, 21 Aug 2025 07:34:35 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE22E8DFD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761674; cv=none; b=SoMuQm5uicr9Gpkrsjzvfj9GX6YiDnkmjRsBC2XfZHrYoHtEBgT+FDusjDicWHulfZU0VwUhvghRHqK3Xc2MSD/NdK4T4KLxwx/50ZKoQ5LYUhYq+ZyKwKgtb2r2LRVPSbP95sz0EgqLc0OjpCdHTgMB8EBBJf7sVwU7ZjnOcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761674; c=relaxed/simple;
	bh=ASntg+FzeMCAkvx84pdc7YcBbDU476kae8asxaDrSlg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ddpWF1jhvjtRz9fNXLKYJ5n2in6WecHg4/7FNkM0ginlaKHKdG+yzIUYYqD3/snNyiiXm24NGWdyPjBkY3HY6LRRiuuMOCiTGYpCWQpyrRBSluiIMZxQKYefNoJfIDC8Qc4AZBN87y1ZqTpT1fb2yuCoczew+m+7exbVeHa55kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88428cc6d2fso219919639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761672; x=1756366472;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqlxwQTWCTdAKHonJQ7l64k7/UpJbVA+js8QT3A1hms=;
        b=ZuLXK0JlDmmc78CJwv6QnlHEefGhKzXA6P4icw6J15Bq1wxBzKIdF/EizIMGGsa7+s
         CJTVMhNaV3mn/yrdVptfG/IpOnvao+r9OWpY2ba34giqoyrGojq8PRS+3FD8abE9PM6t
         R4MQQfJ3Ga1oBz7qY1HGZ3V4M9P6VTpPlTvCAz4DXUlR/Ka1a/bIOCDohsnQ9fDemjW4
         +C+ytM9pA3jGBSjgdZBjx+1esXF12kQ0cK2Oz2S1xoDh8+Fx6s2HXrmM5CBuc8LpgEdy
         Mjv1i707ynhES3nEwMBpiDX+sZY9ZkaD6tjOPG9TTjnDgQdSUpx2Ax4d2bse77VIiC2O
         Nl2w==
X-Forwarded-Encrypted: i=1; AJvYcCXPiPsK6Zy87RwN3HH1t340yTamkbjG/VvYYBubT+rk/pUE2/GfPXpy3WfbK89EbJeRzTkdlDkqE3fu90k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7L95eo5YJZqAMfW8hlZGW/vZ/iHeOF4FFrM4JzlSc89f43FD
	jG+xWiCx8UCMHsvVr9CiELLEsZVXhDlPBxUd3TOD5viTa9ZS0Afo3id2ftQ0TaLvK87lUQPwK7o
	xEWQWnTLbVGteSYLy7aBFUuC/sPJkMSl20gYS24c7OnXWPI/6CpGNRBw2Xn0=
X-Google-Smtp-Source: AGHT+IEi7TeNQm1p3B7O+19KRVXPU+u+l9wAV21wZPhaM0O1W2+DUIDhZqreCUrCScCyEX3Vinx8xA2T6HtjlkGTx/rHLqbhdTQD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:3e6:81c3:21f9 with SMTP id
 e9e14a558f8ab-3e6d640f7b5mr27147425ab.3.1755761671789; Thu, 21 Aug 2025
 00:34:31 -0700 (PDT)
Date: Thu, 21 Aug 2025 00:34:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a6cc07.050a0220.3d78fd.001d.GAE@google.com>
Subject: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in cmp_fnames (2)
From: syzbot <syzbot+d77c546c60db651a389c@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90d970cade8e Merge tag 'ata-ata-6.17-rc2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ade3a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=d77c546c60db651a389c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/db659c83faa4/disk-90d970ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d736b8a5536/vmlinux-90d970ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ed0655ad73d/bzImage-90d970ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d77c546c60db651a389c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in cmp_fnames+0x292/0x2a0 fs/ntfs3/index.c:50
Read of size 2 at addr ffff88801f6da2dc by task syz.7.385/9323

CPU: 0 UID: 0 PID: 9323 Comm: syz.7.385 Tainted: G        W           6.17.0-rc1-syzkaller-00211-g90d970cade8e #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 cmp_fnames+0x292/0x2a0 fs/ntfs3/index.c:50
 hdr_find_e+0x3c6/0x630 fs/ntfs3/index.c:762
 indx_find+0x516/0xba0 fs/ntfs3/index.c:1186
 dir_search_u+0x15f/0x2c0 fs/ntfs3/dir.c:254
 ntfs_lookup+0xfb/0x1f0 fs/ntfs3/namei.c:85
 lookup_one_qstr_excl+0x12e/0x360 fs/namei.c:1697
 filename_create+0x224/0x3c0 fs/namei.c:4140
 do_mknodat+0x184/0x4d0 fs/namei.c:4272
 __do_sys_mknodat fs/namei.c:4313 [inline]
 __se_sys_mknodat fs/namei.c:4310 [inline]
 __x64_sys_mknodat+0xa7/0xc0 fs/namei.c:4310
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f763f38ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f763d5d5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000103
RAX: ffffffffffffffda RBX: 00007f763f5b6090 RCX: 00007f763f38ebe9
RDX: 00000000000021c0 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007f763f411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000103 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f763f5b6128 R14: 00007f763f5b6090 R15: 00007ffca1693878
 </TASK>

Allocated by task 9322:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x1a8/0x320 mm/slub.c:4396
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __ntfs_init_fs_context fs/ntfs3/super.c:1761 [inline]
 ntfs_init_fs_context+0x54/0x4c0 fs/ntfs3/super.c:1806
 alloc_fs_context+0x659/0x7e0 fs/fs_context.c:318
 do_remount fs/namespace.c:3299 [inline]
 path_mount+0xc25/0xfe0 fs/namespace.c:4112
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9322:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kfree+0x195/0x550 mm/slub.c:4879
 put_fs_context+0x123/0x790 fs/fs_context.c:524
 do_remount fs/namespace.c:3326 [inline]
 path_mount+0xe57/0xfe0 fs/namespace.c:4112
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801f6da2c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 28 bytes inside of
 freed 32-byte region [ffff88801f6da2c0, ffff88801f6da2e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f6da
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff888019841780 ffffea0000904f40 dead000000000002
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5202, tgid 5202 (S10udev), ts 18194384145, free_ts 18168222435
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2119/0x21b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0x8d1/0xdd0 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x145/0x430 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2132 [inline]
 tomoyo_supervisor+0xbd5/0x1480 security/tomoyo/common.c:2204
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x149/0x1e0 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x15d1/0x1aa0 security/tomoyo/domain.c:888
 tomoyo_bprm_check_security+0x11d/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x89/0x270 security/security.c:1302
 search_binary_handler fs/exec.c:1660 [inline]
 exec_binprm fs/exec.c:1702 [inline]
 bprm_execve+0x8ee/0x1450 fs/exec.c:1754
 do_execveat_common+0x510/0x6a0 fs/exec.c:1860
 do_execve fs/exec.c:1934 [inline]
 __do_sys_execve fs/exec.c:2010 [inline]
 __se_sys_execve fs/exec.c:2005 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:2005
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
page last free pid 5200 tgid 5200 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xb59/0xce0 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2753 [inline]
 __put_partials+0x159/0x1a0 mm/slub.c:3218
 __slab_free+0x2b3/0x390 mm/slub.c:4550
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x143/0x310 mm/slub.c:4236
 getname_flags+0xb8/0x540 fs/namei.c:146
 user_path_at+0x24/0x60 fs/namei.c:3126
 do_fchownat+0x105/0x270 fs/open.c:816
 __do_sys_chown fs/open.c:842 [inline]
 __se_sys_chown fs/open.c:840 [inline]
 __x64_sys_chown+0x82/0xa0 fs/open.c:840
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801f6da180: fa fb fb fb fc fc fc fc 00 00 01 fc fc fc fc fc
 ffff88801f6da200: fa fb fb fb fc fc fc fc 00 00 03 fc fc fc fc fc
>ffff88801f6da280: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                                    ^
 ffff88801f6da300: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88801f6da380: 00 00 01 fc fc fc fc fc fa fb fb fb fc fc fc fc
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

