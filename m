Return-Path: <linux-kernel+bounces-793212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC59B3D093
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 03:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C06A188F5A9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 01:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D5D1AA1D2;
	Sun, 31 Aug 2025 01:38:36 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8EF18E1F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756604315; cv=none; b=ffN5ddA8TQeVut1OuFrR4D8/2LWTNw8WY5bJpIAs7ntSvDEkSOeWUffyB8g09r0EG1L0Iend4Vw6H6AowBD5Nnhmdg3iDupJda0NuDDuzXlvfrt+5qBCpUYR65twJia9EMrcxyRAvRlJREeUdI1bO8AsfNSW8MsALLKv7wojaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756604315; c=relaxed/simple;
	bh=i3E4N/dEH7ZHtdyjgmR5Asv6gxVS8yEdRMX8FiFakWc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tyrPEnMvwqLXMUHH8f1S1r+CEiv2fa3OF9ORE8Dbry9S4suviBU6xjY6QP6pwvOHtldb11QK1oIk/h94TQ+LhaMsit0/xloeKN1s0ZQ090jOqIw3mlPyBG728IYfGilpA/v9BaLWDuHXSQRsmEnqUi/5yb5dcIEXrgGMMO8nVLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ed0ba44c87so39566555ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 18:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756604313; x=1757209113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXqKf1TodalArSEy9nNNji7pCJZUrhjs0Hbrg+c0Ztw=;
        b=J2FKzdSJWuSyxGVYf4Hx/mP9LjDB0c5YEnnWEdwuB6589uxyIX17DboCrqEbCYIjMA
         fZsz7lqAcOVLM3e2+fjJaAjhmkAlIJAFFwsJE12jgv/mUR4Y+08jQRgIN0/gGc4m41jf
         CvHhtRinwQlOd8xr8hQDRQViODq0ez9CrA84F+zWtncvCu+61+X1B1+tOI53tgzaFqbk
         J9jAZX8Fj8PaBoI1ipiNHf1XSzbzgsYurZIvkWMVliU46FTwcjQWXgsB/EgEEpzDfZGD
         F8tCkBQqUcdLKMibPnD9v2kgEGUXv13Uguub3HCMq4Ruyb567kz7G8A/jnm8CZqg3Vg+
         yCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4E/jVAdwjQBGYLoT6peJ0rwtsgU1nhpl19tTagm4t++TNAIdDWETQMPiJZTbMmZ9mutr1J8hnnAb6BWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8VGvXA1ZKi/7sqj44vDBzNA+P6cbKhy6E2JRkzA5aiQ/iEfmp
	JCR0zPQMcsfZ0DRqihL3gk9VXYSl+uXiZgq2fN98ZBS8UMFwlecbCvf3GD37nzvcRk71cmw6App
	32QA7lIAdR5J1YyFm7dpkMiT5V0ck9AgS1vVudfIlzIg/GylhDN7Odbe1eZM=
X-Google-Smtp-Source: AGHT+IHkVUDaiB0B/+kPsj41ewvQD1QXEUiG86vYShQceSKNjVoO+xB73ABpgh/j5KKO4yQ07Oi4JvYnMu3zIys4Jc0vdX61tmGS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c81:b0:3ec:d2db:9381 with SMTP id
 e9e14a558f8ab-3f4006752b6mr85022255ab.11.1756604313183; Sat, 30 Aug 2025
 18:38:33 -0700 (PDT)
Date: Sat, 30 Aug 2025 18:38:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b3a799.a00a0220.1337b0.0029.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in new_slab (2)
From: syzbot <syzbot+2f3c8569e4b7486452ae@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, 
	rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fab1beda7597 Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ad77bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fecbb496f75d3d61
dashboard link: https://syzkaller.appspot.com/bug?extid=2f3c8569e4b7486452ae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fab1beda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/813fdba24db0/vmlinux-fab1beda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/12a740d2c9a6/bzImage-fab1beda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f3c8569e4b7486452ae@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 10417 at mm/page_alloc.c:4619 __alloc_pages_slowpath mm/page_alloc.c:4619 [inline]
WARNING: CPU: 1 PID: 10417 at mm/page_alloc.c:4619 __alloc_frozen_pages_noprof+0x1f21/0x23f0 mm/page_alloc.c:5161
Modules linked in:
CPU: 1 UID: 0 PID: 10417 Comm: syz.1.1147 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_pages_slowpath mm/page_alloc.c:4619 [inline]
RIP: 0010:__alloc_frozen_pages_noprof+0x1f21/0x23f0 mm/page_alloc.c:5161
Code: 90 0f 0b 90 e9 0d f9 ff ff e8 bb d6 0c 00 e9 43 f1 ff ff 4c 89 ff e8 ae d6 0c 00 e9 1e f1 ff ff 90 0f 0b 90 e9 3b fb ff ff 90 <0f> 0b 90 e9 24 fb ff ff 89 b4 24 90 00 00 00 48 89 54 24 50 e8 56
RSP: 0018:ffffc90003a477f8 EFLAGS: 00010202
RAX: 0000000000008000 RBX: 0000000000000000 RCX: ffffc90003a4792c
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88803fffd9b8
RBP: 0000000000048cc0 R08: 0000000000004f8b R09: 00000000000043f1
R10: 0000000000000000 R11: ffffc90003a47920 R12: ffff88803fffbb80
R13: 1ffff92000748f14 R14: 0000000000000000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880975c3000(0063) knlGS:00000000f5484b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000326f2ffc CR3: 0000000070630000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab mm/slub.c:2663 [inline]
 new_slab+0x265/0x330 mm/slub.c:2709
 ___slab_alloc+0xcf2/0x1740 mm/slub.c:3891
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3981
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4391
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 xfs_init_fs_context+0x45/0x5e0 fs/xfs/xfs_super.c:2278
 alloc_fs_context+0x54d/0x9c0 fs/fs_context.c:318
 do_new_mount fs/namespace.c:3787 [inline]
 path_mount+0xbdd/0x2000 fs/namespace.c:4123
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount fs/namespace.c:4324 [inline]
 __ia32_sys_mount+0x28b/0x310 fs/namespace.c:4324
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7fa4579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f548455c EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000000080000140 RCX: 0000000080000040
RDX: 0000000080000080 RSI: 0000000002208004 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

