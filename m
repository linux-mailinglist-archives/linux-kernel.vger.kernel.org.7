Return-Path: <linux-kernel+bounces-838178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C97BAE9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AFC1943C14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C88127A929;
	Tue, 30 Sep 2025 21:17:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B1189B80
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759267027; cv=none; b=eYiaA3Jpkao1Kdsu1Fqrs7RZTNpPvSaxgaqrd0FNKIOHuFRDcek8UVGayFfMd0i0khsMdJxAfPod0salYE91nPdMHm7/+yuVN9Ha7Pc9NfOd4EqY7pGBa2krr4EY4OaqfZkxEertEyFj0ds78ecidY31yZs57DZ7bXMOP2fRMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759267027; c=relaxed/simple;
	bh=WW2e5XCtHEcWKZXo6K++06G2ULrw0ogVcLvEgSMAOX4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bo+oiJE5qdhKu82jO2CjF+Uwlek/EBI3VUhOujDwstWCdcvatqML06IaNall+fVPlkL2tIFu+j2TNOB5Zu33TILdekjDCH2DvhhCqKUBTPUvjsyZp1Nk52KCfkrIXUe4aqJ4KVcr56z+S6jd6J+edLMXEAYzEYugQq8eBZsIkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-925332ba890so594879139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759267024; x=1759871824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ndKSMTBACk7kpL/C+jZwwX2XO5VbVfgM+EZOsv1+90=;
        b=iuF3fKISeZpYd2krYN2YuLQNWvk952WwLOxeUXibKZrl9Gru7XFfVGPUfUd7VtKfDe
         16HmKt9maX24hDQaOC67x/Kr3I6ecG3j9SlHDYsSrSgbgxQUNEAcpZrs4z6xe8Yyv0hk
         oNQrWfwCVVIK6Qc5q8tXWqShGt+6hVmeoXAzrkxa7imy67sQUzUF+dtKBNuGUbcMYkDp
         61Y3mudXyt/qQD9yJuyEl3xLkJ3xw3tmQix9dDe967SVl6mx2Tk2JJX+oakBAJ82nAkR
         zc+IH+ZyWQyNbbwuXgK8LERAwpdDocmWuxX2Hya9WWDUqnsD7Q7H3SsAhBqqdGkfR7Zz
         zc9A==
X-Forwarded-Encrypted: i=1; AJvYcCV594WKSI8+n3FiXUN/P/Y5Vx0WzYzxZ5Tuu60fHg3Ef3KkRmlxDVEiEBc8te/E0YuVxjMp0LfiHyIODd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5ruDcd62Xe9U5R2xmytKFSYEh9WBKmEuXZnsJ9+9+qQyLUZo
	adgmvAZiKugMl5YbEkb4L1wMlj5Sh1LMmEM++kSejkVvOPE3VCGZHAC4q2EkLPceZYkzVCsrcET
	uzVqtAzG5mCe4Toxeytk0JCIpHVM8OaxTlLiCBn+20e/pk93jK14DXz6Hhlo=
X-Google-Smtp-Source: AGHT+IECb4O4JxSDjpwRZrWbQAHmJnSS3DKi5o9wBzanrY+CS7fVN1l5dWpnZdBorJeZN4ks/PXc7Zon+4xcgYFLIPGhnEyLj4jb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cd:b0:423:fd07:d3f6 with SMTP id
 e9e14a558f8ab-42d8167b2ccmr19515725ab.15.1759267024120; Tue, 30 Sep 2025
 14:17:04 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:17:04 -0700
In-Reply-To: <20250930205715.615436-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc48d0.a70a0220.10c4b.0160.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_ext_insert_extent
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in ext4_ext_correct_indexes

==================================================================
BUG: KASAN: use-after-free in ext4_ext_correct_indexes+0x72/0x5b0 fs/ext4/extents.c:1712
Read of size 8 at addr ffff888078dca350 by task syz.2.45/6689

CPU: 0 UID: 0 PID: 6689 Comm: syz.2.45 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_ext_correct_indexes+0x72/0x5b0 fs/ext4/extents.c:1712
 ext4_ext_insert_extent+0x1fdd/0x4af0 fs/ext4/extents.c:2188
 ext4_ext_map_blocks+0x1bbe/0x3880 fs/ext4/extents.c:4410
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x860/0x1740 fs/ext4/inode.c:811
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:910
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:943
 ext4_block_write_begin+0x990/0x1710 fs/ext4/inode.c:1198
 ext4_write_begin+0xc04/0x19a0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x445/0xda0 fs/ext4/inode.c:3129
 generic_perform_write+0x2c2/0x900 mm/filemap.c:4175
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c6/0xb30 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:798
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e7b78e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e7a9fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f9e7b9b5fa0 RCX: 00007f9e7b78e969
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f9e7b810ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9e7b9b5fa0 R15: 00007fff3dade2a8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888078dcadc0 pfn:0x78dca
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea00016119c8 ffffea00018708c8 0000000000000000
raw: ffff888078dcadc0 ffff888079136c60 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x440dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_COMP), pid 6328, tgid 6328 (syz-executor), ts 132604632127, free_ts 133183234936
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_frozen_pages_noprof mm/mempolicy.c:2487 [inline]
 alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2507
 pagetable_alloc_noprof include/linux/mm.h:2881 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:75 [inline]
 pte_alloc_one+0x21/0x170 arch/x86/mm/pgtable.c:18
 __pte_alloc+0x25/0x1a0 mm/memory.c:452
 copy_pte_range mm/memory.c:1107 [inline]
 copy_pmd_range+0x6a91/0x71d0 mm/memory.c:1261
 copy_pud_range mm/memory.c:1298 [inline]
 copy_p4d_range mm/memory.c:1322 [inline]
 copy_page_range+0xc14/0x1270 mm/memory.c:1410
 dup_mmap+0xf57/0x1ac0 mm/mmap.c:1834
 dup_mm kernel/fork.c:1485 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1537
 copy_process+0x1706/0x3c00 kernel/fork.c:2179
 kernel_clone+0x224/0x7c0 kernel/fork.c:2609
 __do_sys_clone kernel/fork.c:2752 [inline]
 __se_sys_clone kernel/fork.c:2736 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 920 tgid 920 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbb1/0xd20 mm/page_alloc.c:2895
 pagetable_free include/linux/mm.h:2898 [inline]
 pagetable_dtor_free include/linux/mm.h:2996 [inline]
 __tlb_remove_table+0x2d2/0x3b0 include/asm-generic/tlb.h:220
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:290
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
 sysvec_call_function_single+0xa3/0xc0 arch/x86/kernel/smp.c:266
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709

Memory state around the buggy address:
 ffff888078dca200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888078dca280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888078dca300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff888078dca380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888078dca400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         755fa5b4 Merge tag 'cgroup-for-6.18' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14fea42c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c0c1e13e3c8731f
dashboard link: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fb6942580000


