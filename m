Return-Path: <linux-kernel+bounces-893850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCA1C487E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808951892510
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132403191BE;
	Mon, 10 Nov 2025 18:10:42 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356BE31960F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798237; cv=none; b=rkdFbRMkm3kbKRfq8BsC1lGN0bTqfRLDbJHyIFr5WZPauGk0oIv4droEHOXAMk3aSlY81GAUo3KHZsBRhQr8c9UdyrW+HSICE51WXT44pcrQoQoVD0dkPScyfb0FXQD4wbrdg3fNJecklB01mOtitRAp/5B7kUFvR+PR87zXUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798237; c=relaxed/simple;
	bh=Czu2oYSCiZK2bhRQTbkfiIfr1I3qTJcXPJ6oKAA36Cc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m4jrEuEn0rnEs+V/0gT1yiakkeS6AtQnFrVPfNsWOuxzGOEP7nApbef9Sct/EGeJZp9fVz1Op2r0GSvLs7+SFOorvMlTkzy/opN/x1i1SficP3ZQzATBdQqj1wKiWL9o+cXBdXBE4Cm7GbFr+aRrfwPQyyxtZknZSHxPnVcep74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-433817220f5so152235ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762798230; x=1763403030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yh7L+mAl5mS9jaQD99IfxkIeM8YY5cwL5wIHPUv2+o=;
        b=qVvONQJrfhIf0JFJ0sY0QTZTbCS9KyVlqoszhMOCYTDqwWxUGRGphSJm5E1BemSqo5
         dy7NXmxU4vOBFueasapV/atws5pp9l0PQJxL/lwA3IgKr8I8Qg2izRXYdEjDKER2kjx/
         Eq72s4dnQ3G/uUxfmygzGoB4SzyLqVQhjZkGA14reW+aszSjqYEZgYUClKZhWfZ1uPqM
         78NIrossFwSMabJJI0JfA48tDbHH04o1/tBijCWc03CO7iwoBAmRc2gxDYyOYrgNCGtl
         6NYIe10bF0OkldvbL6Lpuu7uAeCT0QXIR3eA0edcTeAC9EWzCqJ/rHny9RikmFd/27W6
         ADGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2MpmvUCs7YAeE2z3tjTbn5Dp/I1ZFoi5IvFOdOdy+w7GXx2ArWgUB2AV7ikwgYgQTVeI/DpXTFWSILvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgS3QQ+jf4TjKVwsTCQLhCebNZpHGvaaqzDvl1jWa4HPL/dy7
	oXqTRoIDBYbG2uys1bAFVge84Aj2emDx0pBUnuNtu239E4379W1bzV2HGPm6O7PErPbzkuDpOVS
	pHOlnY4etCE0gnnirsEG/WJq1KLLTX8IB74KDlSLPLnuoCtGxGj0KY8L7XDY=
X-Google-Smtp-Source: AGHT+IE64XWmIGKQw8awLMhbp90LC0oJTjLEnQvJXhzsSoAuvsJGYP3WK4TUpZNMtz7yzunQCMw6Q/SnzIdL/9LzAr4y9JuaCDpc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:68c:b0:433:2a39:1b98 with SMTP id
 e9e14a558f8ab-4338befd24amr3374715ab.15.1762798230249; Mon, 10 Nov 2025
 10:10:30 -0800 (PST)
Date: Mon, 10 Nov 2025 10:10:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69122a96.a70a0220.22f260.00fe.GAE@google.com>
Subject: [syzbot] [ntfs3?] memory leak in ni_add_subrecord
From: syzbot <syzbot+3932ccb896e06f7414c9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e811c33b1f13 Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1590ea58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=3932ccb896e06f7414c9
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1431bbcd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16250412580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc3290299f36/disk-e811c33b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/987fe9401d05/vmlinux-e811c33b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23be5a0e8ba6/bzImage-e811c33b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a2535f9cc9c1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3932ccb896e06f7414c9@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888110bef280 (size 128):
  comm "syz.0.17", pid 6082, jiffies 4294944677
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 48 37 28 81 88 ff ff  .........H7(....
  backtrace (crc 126a088f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    ni_add_subrecord+0x31/0x180 fs/ntfs3/frecord.c:317
    ntfs_look_free_mft+0xf0/0x790 fs/ntfs3/fsntfs.c:715
    ni_ins_attr_ext+0x40c/0x6a0 fs/ntfs3/frecord.c:988
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
unreferenced object 0xffff888109093400 (size 1024):
  comm "syz.0.17", pid 6082, jiffies 4294944677
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
    ni_ins_attr_ext+0x40c/0x6a0 fs/ntfs3/frecord.c:988
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
unreferenced object 0xffff888110bef680 (size 128):
  comm "syz.0.18", pid 6093, jiffies 4294944686
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 48 37 28 81 88 ff ff  .........H7(....
  backtrace (crc ada06205):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    ni_add_subrecord+0x31/0x180 fs/ntfs3/frecord.c:317
    ntfs_look_free_mft+0xf0/0x790 fs/ntfs3/fsntfs.c:715
    ni_ins_attr_ext+0x40c/0x6a0 fs/ntfs3/frecord.c:988
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
unreferenced object 0xffff8881135d2000 (size 1024):
  comm "syz.0.18", pid 6093, jiffies 4294944686
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
    ni_ins_attr_ext+0x40c/0x6a0 fs/ntfs3/frecord.c:988
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
unreferenced object 0xffff888110bef780 (size 128):
  comm "syz.0.19", pid 6099, jiffies 4294944695
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 30 25 0f 81 88 ff ff  .........0%.....
  backtrace (crc 6428af85):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4979 [inline]
    slab_alloc_node mm/slub.c:5284 [inline]
    __kmalloc_cache_noprof+0x3a6/0x5b0 mm/slub.c:5762
    kmalloc_noprof include/linux/slab.h:957 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    ni_add_subrecord+0x31/0x180 fs/ntfs3/frecord.c:317
    ntfs_look_free_mft+0xf0/0x790 fs/ntfs3/fsntfs.c:715
    ni_ins_attr_ext+0x40c/0x6a0 fs/ntfs3/frecord.c:988
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

