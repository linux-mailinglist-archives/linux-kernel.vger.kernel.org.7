Return-Path: <linux-kernel+bounces-815644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3302AB5695B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7891F189D46B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF2918FDBE;
	Sun, 14 Sep 2025 13:31:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9BE1FB3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856691; cv=none; b=EMW19jAx5aj9UUZN4135RfGj+A6UFFdfKJNxOOGPZhjK6yMLeauM5yhBitOEeDDGNysgXjVQe2sL8it3+mqDNgObBkSmZfBYMd1S/aFVWDVXoH9B9wElHSFLG5HRAbRZ3WUPuBaL51nCGizBtj7MBfwqnQAseRx16cAbjJ5OaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856691; c=relaxed/simple;
	bh=qM33VcJHnoued2jhqS6UwNT/N3B90PY1mfHd3MSUd4U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oh56YM/qhbaY2+IwPxlWMHJUxyU2y4F05c6C4eGuwbeOQXG9CDjgXyaOdBNRXrhMm1578VJhWJESLG0THr2+ZNpqlJdM4eU4qOeURV1Me6Di5LF6M3HiZlGW9y9LZuI3qa8qD2u9XLIMPoCF6ynouzYQWRbErGErqx4t7UH3VkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-423f9d1ea61so26280655ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856689; x=1758461489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zgls9ZimgHy4wHWReJ1r51htTF+RAz8C6gjsT9MZbaI=;
        b=AUupxooRmpwD7NWO9IG5yl/KEib1lqr6s1rJhDzHlDDU3AKsxjRyeAeI1r8ZcV+ppr
         6jVCgPpIf8n+83zlWZ7uPVgJMiT8pV31rbTBOLX/UKkZZe1VsQlz62LyUOJjAiM2jiz6
         F4q9hA2v0QiLMaaIR238kqkxmDo9r+aarZaLEJ3GaQniVzV4DqMwvhKZxLmPaTXFCjsy
         7BOI9cY1Iyxbqi+KrHYPzsaWjEtI3R9/q8pXG18n3vQl6YxLTFGNB4EoMg8UYmrD92y7
         8k9fHk/RZu4//J3ebQcuUA7gM2FOZtgw0DOL716dX9007s/jY8zLeeIOIVDBJtJfs4Zt
         gaQA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1B224gjdo+yIbLxZSqhM3ln+y/zAcwgDSnuX641j1me2Nj3NBa03jB/nFSu6yBzvgPhocAheI0a465U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLYKZwBUU1083gLqzq7h1CLoLjZT3EfYoF8WAoRjo/tPIvvaz
	5uWswIntJUmQfOSLae+ZuLL9SxJxLY1S+Ly3MjveXD7bhdXIkTrvUAkuyCpsJMYgz0ryjnFr9XE
	bLwM4ubw20hcGoxjmA0kVultBNXKp/FQF6kI4AUJKwXefJVN40onxTWE6CQs=
X-Google-Smtp-Source: AGHT+IFZT6RD7X4X8i9idp4Je+qWg96IedQUb4Ym/2nrCds+hGFbp4kJflFC0YysPo4rvAMGlwxxCsGiR3NOoAbBDrjq0H5g2L1u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cd:b0:424:71:32e5 with SMTP id
 e9e14a558f8ab-42400713e12mr16331255ab.31.1757856689189; Sun, 14 Sep 2025
 06:31:29 -0700 (PDT)
Date: Sun, 14 Sep 2025 06:31:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c6c3b1.050a0220.2ff435.0382.GAE@google.com>
Subject: [syzbot] [kernel?] kernel BUG in qlist_free_all (2)
From: syzbot <syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9dd1835ecda5 Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1663cb12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0bea6c0b97a2002
dashboard link: https://syzkaller.appspot.com/bug?extid=8715dd783e9b0bef43b1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bd34622db2f/disk-9dd1835e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/673ef735e573/vmlinux-9dd1835e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb16aa1b210d/bzImage-9dd1835e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 456 Comm: syz-executor Tainted: G     U              syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__phys_addr+0xfa/0x180 arch/x86/mm/physaddr.c:28
Code: 48 d3 e8 48 89 c3 48 89 c6 e8 82 80 4e 00 48 85 db 75 11 e8 08 85 4e 00 48 89 e8 5b 5d 41 5c c3 cc cc cc cc e8 f7 84 4e 00 90 <0f> 0b e8 ef 84 4e 00 48 c7 c0 10 b0 3a 8e 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc9000c6f74b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 3fffff890062e864 RCX: ffffffff816c85f3
RDX: ffff8880255bda00 RSI: ffffffff816c8679 RDI: 0000000000000006
RBP: 400077088062e864 R08: 0000000000000006 R09: 3fffff890062e864
R10: 400077088062e864 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc9000c6f7508 R15: ffff888022aa0001
FS:  0000555589044500(0000) GS:ffff8881247bd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1fea5056c0 CR3: 0000000076f3e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1180 [inline]
 virt_to_slab mm/slab.h:187 [inline]
 qlink_to_cache mm/kasan/quarantine.c:131 [inline]
 qlist_free_all+0x65/0x120 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x1cb/0x3b0 mm/slub.c:4247
 ptlock_alloc+0x1f/0x70 mm/memory.c:7161
 ptlock_init include/linux/mm.h:2953 [inline]
 pagetable_pte_ctor include/linux/mm.h:3002 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:78 [inline]
 pte_alloc_one+0x82/0x3a0 arch/x86/mm/pgtable.c:18
 __pte_alloc+0x6d/0x3c0 mm/memory.c:452
 copy_pte_range mm/memory.c:1107 [inline]
 copy_pmd_range mm/memory.c:1261 [inline]
 copy_pud_range mm/memory.c:1298 [inline]
 copy_p4d_range mm/memory.c:1322 [inline]
 copy_page_range+0x3b83/0x5c80 mm/memory.c:1410
 dup_mmap+0xe88/0x21d0 mm/mmap.c:1834
 dup_mm kernel/fork.c:1485 [inline]
 copy_mm kernel/fork.c:1537 [inline]
 copy_process+0x4081/0x7690 kernel/fork.c:2175
 kernel_clone+0xfc/0x930 kernel/fork.c:2605
 __do_sys_clone+0xce/0x120 kernel/fork.c:2748
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1fe9785413
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffd86810ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1fe9785413
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 00005555890447d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 0000000000164bcc R15: 00007ffd86810d40
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0xfa/0x180 arch/x86/mm/physaddr.c:28
Code: 48 d3 e8 48 89 c3 48 89 c6 e8 82 80 4e 00 48 85 db 75 11 e8 08 85 4e 00 48 89 e8 5b 5d 41 5c c3 cc cc cc cc e8 f7 84 4e 00 90 <0f> 0b e8 ef 84 4e 00 48 c7 c0 10 b0 3a 8e 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc9000c6f74b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 3fffff890062e864 RCX: ffffffff816c85f3
RDX: ffff8880255bda00 RSI: ffffffff816c8679 RDI: 0000000000000006
RBP: 400077088062e864 R08: 0000000000000006 R09: 3fffff890062e864
R10: 400077088062e864 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc9000c6f7508 R15: ffff888022aa0001
FS:  0000555589044500(0000) GS:ffff8881247bd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000800000 CR3: 0000000076f3e000 CR4: 00000000003526f0


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

