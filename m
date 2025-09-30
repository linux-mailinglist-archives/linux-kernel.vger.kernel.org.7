Return-Path: <linux-kernel+bounces-838242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D3BAEC52
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A731926EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA92D0634;
	Tue, 30 Sep 2025 23:27:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D72E40E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274827; cv=none; b=kmA4C6SWCrpBa7pYZuFbSGEx5EHA2i31H/flUln3m6bX3ib6g+66nFA4w4BGrDLMSHDQeEJcme3lIDJQDsw9dfOZ+55xhKUdZs8XU9NrdlR5TeGbQYXyUkJ4Ym4fLT99YaYoQsuRoT7N0iG8XXmG0c02nHhkhBfjhUh6sxkO5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274827; c=relaxed/simple;
	bh=8/307iZiwvKVZa7O3BSMmMErhiiifBJFKcg5Pn2qOUw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C/ArLUg8tek3XiPaEyOQlbV4LJA3rsYBzhP5ONvV9zet4nWAQO+wtnTbE1fAw2GJd+vwMZRXlqoE2QXep5VpGSJ9tfaom1FD8R521ZosMc0ACX3mbnJJaStlHE88skYBwWV/oG8rqXqxXddItaRHj54NTWO23O+yuCbZGRgNDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4297610aacaso48797255ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759274824; x=1759879624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+foTIgs1ZsePw+5KjTgDGUsxCzWpLWDrmj5AyRyoaI8=;
        b=bh1hdhGGTrurPF2xhG/oYJfFT6rcxEEb5n4Bnmmsvo1zXKY7YcsJUZG4Ugk//0QLet
         7YP7uLulOVyBMJHxl0tZA4I2JqOdtFbts0LoFbxrfcC9AEnpHg4Iolta/khX7nh3VRzy
         YmL2kLhJMzAHj456prQwxz2yyuV7o6Dpk/tDU3Zo5YWdBJNlTF0TKIGDukZg5geQV1gH
         QC4pMk9wfShTHC3FsrbMWesblm9Pi2ee2quMu3khey+ZxQcUQsDzDqnAifijDeJaMBJ4
         t9miDjjxjZMrZ/BZif5yXgcw9cfoE1E3ABpSp2hXCn6WrNwDvOqp2Vjv+ma4dTqcvaKh
         toFA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ3WY6yeV49MZS3LU6WdpRPp/jFdfW/NqJsb8GtXyIXbwu3FujqW0JCMSIGiu6/wVjpYGyaFkIoGHolII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04gCK6Vj7tCLq0jJWdKCu1A6HVGokdCtaGKQZoF5/CxPJeN6F
	8xvd3hSvVBLdxglaYJTLUm866mJ/ashKCJNVNnOGynVWwux2+emjb4snGJ3xdvbkFvko0QrRxc7
	DHVJMmGMwUjL7DJRDRvxcTHPlrcLt5cMkbbnyMogJoLoiuM0wCEjrorutxEQ=
X-Google-Smtp-Source: AGHT+IF9zIrHQkOoPhCwY0bLqtEDDDvtQEJhjKeyu3ibAamnkxciDsnFv6IGlFiSwy+nT+DPErw73A7ypKp2kQO0g7r6j6kL6sDS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:427:d62b:45f7 with SMTP id
 e9e14a558f8ab-42d81622cf2mr24021745ab.27.1759274823775; Tue, 30 Sep 2025
 16:27:03 -0700 (PDT)
Date: Tue, 30 Sep 2025 16:27:03 -0700
In-Reply-To: <20250930224931.907701-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc6747.050a0220.25d7ab.076a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_ext_insert_extent
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in ext4_ext_map_blocks

EXT4-fs (loop1): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
CPU: 1 UID: 0 PID: 6473 Comm: syz.1.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_ext_map_blocks+0x2a1/0x38f0 fs/ext4/extents.c:4212
Code: 24 58 45 0f b7 3f 31 ff 44 89 fe e8 59 a6 51 ff 45 85 ff 74 29 e8 af a2 51 ff 4b 8d 1c 7f c1 e3 04 48 83 c3 20 89 d8 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 f0 10 b5 ff 48 8b 1b eb 0c e8 86
RSP: 0018:ffffc90003e8f060 EFLAGS: 00010206
RAX: 000000000000000a RBX: 0000000000000050 RCX: ffff88807cc91e40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003e8f270 R08: ffffffff8f5ae037 R09: 1ffffffff1eb5c06
R10: dffffc0000000000 R11: fffffbfff1eb5c07 R12: ffffc90003e8f460
R13: 1ffff920007d1e24 R14: dffffc0000000000 R15: 0000000000000001
FS:  00007f8b97f5d6c0(0000) GS:ffff8881264d6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000004000 CR3: 000000007a25c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
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
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:798
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b9718e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8b97f5d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f8b973b5fa0 RCX: 00007f8b9718e969
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f8b97210ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8b973b5fa0 R15: 00007ffea2f11788
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ext_map_blocks+0x2a1/0x38f0 fs/ext4/extents.c:4212
Code: 24 58 45 0f b7 3f 31 ff 44 89 fe e8 59 a6 51 ff 45 85 ff 74 29 e8 af a2 51 ff 4b 8d 1c 7f c1 e3 04 48 83 c3 20 89 d8 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 f0 10 b5 ff 48 8b 1b eb 0c e8 86
RSP: 0018:ffffc90003e8f060 EFLAGS: 00010206
RAX: 000000000000000a RBX: 0000000000000050 RCX: ffff88807cc91e40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003e8f270 R08: ffffffff8f5ae037 R09: 1ffffffff1eb5c06
R10: dffffc0000000000 R11: fffffbfff1eb5c07 R12: ffffc90003e8f460
R13: 1ffff920007d1e24 R14: dffffc0000000000 R15: 0000000000000001
FS:  00007f8b97f5d6c0(0000) GS:ffff8881263d6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555839b2c950 CR3: 000000007a25c000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	24 58                	and    $0x58,%al
   2:	45 0f b7 3f          	movzwl (%r15),%r15d
   6:	31 ff                	xor    %edi,%edi
   8:	44 89 fe             	mov    %r15d,%esi
   b:	e8 59 a6 51 ff       	call   0xff51a669
  10:	45 85 ff             	test   %r15d,%r15d
  13:	74 29                	je     0x3e
  15:	e8 af a2 51 ff       	call   0xff51a2c9
  1a:	4b 8d 1c 7f          	lea    (%r15,%r15,2),%rbx
  1e:	c1 e3 04             	shl    $0x4,%ebx
  21:	48 83 c3 20          	add    $0x20,%rbx
  25:	89 d8                	mov    %ebx,%eax
  27:	c1 e8 03             	shr    $0x3,%eax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 f0 10 b5 ff       	call   0xffb51129
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	eb 0c                	jmp    0x4a
  3e:	e8                   	.byte 0xe8
  3f:	86                   	.byte 0x86


Tested on:

commit:         22bdd6e6 Merge tag 'x86_apic_for_v6.18_rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1664d05b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6899ea2dd30a3ed1
dashboard link: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14057c14580000


