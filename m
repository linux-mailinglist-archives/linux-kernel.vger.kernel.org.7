Return-Path: <linux-kernel+bounces-894452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDD7C4AB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3439B3BB1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981933EB0B;
	Tue, 11 Nov 2025 01:20:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213028688E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824005; cv=none; b=R1jtKRQi1XiMV96qyK8K6dQWgNEY/5aqAEhNuhRZJlhCz6S/zXKirO1v4aUGPC8DstXSZisNozK5UWWAV8XReSEmbkMNv7lwAU2vrmxlmfTPBTeqmGj5NXquxsXbFHrceHo3qihVyjdsUpeDmeBOBDNN6uNbTRASI6tRzjaVQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824005; c=relaxed/simple;
	bh=/gPwd1PolENXEYou2u3Zc6lvE8KTqroGtk/YHcv6ILo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HVGBkR6lHntBcmycdjm7jJOzjJgMIrGmGEWTfMxLcX00lk55RVYbPRMDVGy5VP5wJ8ArXAmKYKg1QMGVfxNKM9tO/RwG2XrEY8mIYlQSnajU8lzEQ3EniYhidsfDC3KoCC+jc+HSrHGZ9hshP1z8z7Uz+80dJuxofv1Xzx+VH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433270dad0dso4559205ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762824003; x=1763428803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4H82Gg/MOrkCZYSMzlqBfKTN+0FDGpo5+e6GJZMrfSA=;
        b=c2i5akPnTPUz5jXdJp8rBnCxdTashYzdlrO+n3VlPkW7ui/wPhauWC6vTqI/EUjfaD
         OyTJ3a1kMo/7G9qXtQFG/74gXZ0WzBIVeZagkBghJE4oM/G4mEmP6rlSxeJV6j01C5Nc
         p6fWvd7oqPdBIr4IwEFKGUb14dOFs28+BWh7zNFQUN4abQ7hamYevgaLMjcgKnryFSZh
         +ftzRqG057l15/UvhkPDYAQnWHYevbhvbPxIh2TOKtbZwMaMCcZRKq8mZPxg9/yguB7g
         /rma62oCD8JkY1Rt0T3ORWBC0DUS7EwDAfurTPIStv5MvsQT0t/gmxZASvcYf4mBukyv
         sDHA==
X-Forwarded-Encrypted: i=1; AJvYcCWESKWpe6q9QfS5RAKmK31YzUXacHEQeG+WnXARIK++Fw8JxAcnOsf+DGsKYHT1JnkIQwKvhEWmrWCmgho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUs74x9IsThdbJ/89u9Uj5iol3b48deW58sBNStykPngbOcarE
	BxexC30U/JPllPsnhZN84pzVv6PJbUq6WViZM50fx0wCZvAE+j35OpPEB+P54XErx0Dbyoztdzc
	/K7S/+sCjSnS+nVOSJvC5AABoq9yodaY5arkCxc6uliNesYYP2Pd6EAOehbA=
X-Google-Smtp-Source: AGHT+IEm43BPynBsjKZioDT5tHQMOC6Nt9VRh+PSBJJP1Y6NUuCXyud5fw6DXQb2XmibQviKbgrslBWTugxjwmrch66Br8cKaZv6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1:b0:433:7c9a:e8b6 with SMTP id
 e9e14a558f8ab-4338becc429mr25466785ab.9.1762824002789; Mon, 10 Nov 2025
 17:20:02 -0800 (PST)
Date: Mon, 10 Nov 2025 17:20:02 -0800
In-Reply-To: <tencent_56925ADDFB5DC999044FF38DF625928D8507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69128f42.a70a0220.22f260.0119.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] memory leak in ni_add_subrecord
From: syzbot <syzbot+3932ccb896e06f7414c9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in ni_add_subrecord

BUG: memory leak
unreferenced object 0xffff888126a90e00 (size 128):
  comm "syz.0.17", pid 6726, jiffies 4294946753
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 b8 51 13 81 88 ff ff  ..........Q.....
  backtrace (crc 5c7e5ed8):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    ni_add_subrecord+0x31/0x180 fs/ntfs3/frecord.c:317
    ntfs_look_free_mft+0xf0/0x790 fs/ntfs3/fsntfs.c:715
    ni_ins_attr_ext+0x40c/0x690 fs/ntfs3/frecord.c:988
    ni_insert_attr+0x1d1/0x480 fs/ntfs3/frecord.c:1091
    ni_insert_resident+0x85/0x140 fs/ntfs3/frecord.c:1475
    ni_add_name+0x15b/0x2e0 fs/ntfs3/frecord.c:2987
    ni_rename+0x4c/0x100 fs/ntfs3/frecord.c:3026
    ntfs_rename+0x46c/0x5d0 fs/ntfs3/namei.c:332
    vfs_rename+0x94b/0x1340 fs/namei.c:5216
    do_renameat2+0x5f5/0x870 fs/namei.c:5364
    __do_sys_rename fs/namei.c:5411 [inline]
    __se_sys_rename fs/namei.c:5409 [inline]
    __x64_sys_rename+0x42/0x50 fs/namei.c:5409
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888108b8c400 (size 1024):
  comm "syz.0.17", pid 6726, jiffies 4294946753
  hex dump (first 32 bytes):
    46 49 4c 45 2a 00 03 00 00 00 00 00 00 00 00 00  FILE*...........
    03 00 00 00 30 00 01 00 88 02 00 00 00 04 00 00  ....0...........
  backtrace (crc 7197c55e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __do_kmalloc_node mm/slub.c:5645 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5658
    kmalloc_noprof include/linux/slab.h:961 [inline]
    mi_init+0x2b/0x50 fs/ntfs3/record.c:105
    mi_format_new+0x40/0x220 fs/ntfs3/record.c:422
    ni_add_subrecord+0x6b/0x180 fs/ntfs3/frecord.c:321
    ntfs_look_free_mft+0xf0/0x790 fs/ntfs3/fsntfs.c:715
    ni_ins_attr_ext+0x40c/0x690 fs/ntfs3/frecord.c:988
    ni_insert_attr+0x1d1/0x480 fs/ntfs3/frecord.c:1091
    ni_insert_resident+0x85/0x140 fs/ntfs3/frecord.c:1475
    ni_add_name+0x15b/0x2e0 fs/ntfs3/frecord.c:2987
    ni_rename+0x4c/0x100 fs/ntfs3/frecord.c:3026
    ntfs_rename+0x46c/0x5d0 fs/ntfs3/namei.c:332
    vfs_rename+0x94b/0x1340 fs/namei.c:5216
    do_renameat2+0x5f5/0x870 fs/namei.c:5364
    __do_sys_rename fs/namei.c:5411 [inline]
    __se_sys_rename fs/namei.c:5409 [inline]
    __x64_sys_rename+0x42/0x50 fs/namei.c:5409
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812586cb00 (size 128):
  comm "syz.0.18", pid 6736, jiffies 4294946763
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 e8 f5 0e 81 88 ff ff  ................
  backtrace (crc db17ea11):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    ni_add_subrecord+0x31/0x180 fs/ntfs3/frecord.c:317
    ntfs_look_free_mft+0xf0/0x790 fs/ntfs3/fsntfs.c:715
    ni_ins_attr_ext+0x40c/0x690 fs/ntfs3/frecord.c:988
    ni_insert_attr+0x1d1/0x480 fs/ntfs3/frecord.c:1091
    ni_insert_resident+0x85/0x140 fs/ntfs3/frecord.c:1475
    ni_add_name+0x15b/0x2e0 fs/ntfs3/frecord.c:2987
    ni_rename+0x4c/0x100 fs/ntfs3/frecord.c:3026
    ntfs_rename+0x46c/0x5d0 fs/ntfs3/namei.c:332
    vfs_rename+0x94b/0x1340 fs/namei.c:5216
    do_renameat2+0x5f5/0x870 fs/namei.c:5364
    __do_sys_rename fs/namei.c:5411 [inline]
    __se_sys_rename fs/namei.c:5409 [inline]
    __x64_sys_rename+0x42/0x50 fs/namei.c:5409
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff8881275a6000 (size 1024):
  comm "syz.0.18", pid 6736, jiffies 4294946763
  hex dump (first 32 bytes):
    46 49 4c 45 2a 00 03 00 00 00 00 00 00 00 00 00  FILE*...........
    03 00 00 00 30 00 01 00 88 02 00 00 00 04 00 00  ....0...........
  backtrace (crc 7197c55e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __do_kmalloc_node mm/slub.c:5645 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5658
    kmalloc_noprof include/linux/slab.h:961 [inline]
    mi_init+0x2b/0x50 fs/ntfs3/record.c:105
    mi_format_new+0x40/0x220 fs/ntfs3/record.c:422
    ni_add_subrecord+0x6b/0x180 fs/ntfs3/frecord.c:321
    ntfs_look_free_mft+0xf0/0x790 fs/ntfs3/fsntfs.c:715
    ni_ins_attr_ext+0x40c/0x690 fs/ntfs3/frecord.c:988
    ni_insert_attr+0x1d1/0x480 fs/ntfs3/frecord.c:1091
    ni_insert_resident+0x85/0x140 fs/ntfs3/frecord.c:1475
    ni_add_name+0x15b/0x2e0 fs/ntfs3/frecord.c:2987
    ni_rename+0x4c/0x100 fs/ntfs3/frecord.c:3026
    ntfs_rename+0x46c/0x5d0 fs/ntfs3/namei.c:332
    vfs_rename+0x94b/0x1340 fs/namei.c:5216
    do_renameat2+0x5f5/0x870 fs/namei.c:5364
    __do_sys_rename fs/namei.c:5411 [inline]
    __se_sys_rename fs/namei.c:5409 [inline]
    __x64_sys_rename+0x42/0x50 fs/namei.c:5409
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888125f77780 (size 128):
  comm "syz.0.19", pid 6746, jiffies 4294946771
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 c8 51 13 81 88 ff ff  ..........Q.....
  backtrace (crc af0a413f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    ni_add_subrecord+0x31/0x180 fs/ntfs3/frecord.c:317
    ntfs_look_free_mft+0xf0/0x790 fs/ntfs3/fsntfs.c:715
    ni_ins_attr_ext+0x40c/0x690 fs/ntfs3/frecord.c:988
    ni_insert_attr+0x1d1/0x480 fs/ntfs3/frecord.c:1091
    ni_insert_resident+0x85/0x140 fs/ntfs3/frecord.c:1475
    ni_add_name+0x15b/0x2e0 fs/ntfs3/frecord.c:2987
    ni_rename+0x4c/0x100 fs/ntfs3/frecord.c:3026
    ntfs_rename+0x46c/0x5d0 fs/ntfs3/namei.c:332
    vfs_rename+0x94b/0x1340 fs/namei.c:5216
    do_renameat2+0x5f5/0x870 fs/namei.c:5364
    __do_sys_rename fs/namei.c:5411 [inline]
    __se_sys_rename fs/namei.c:5409 [inline]
    __x64_sys_rename+0x42/0x50 fs/namei.c:5409
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         4427259c Merge tag 'riscv-for-linus-6.18-rc6' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1771960a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=3932ccb896e06f7414c9
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167e960a580000


