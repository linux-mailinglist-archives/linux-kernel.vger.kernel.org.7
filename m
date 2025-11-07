Return-Path: <linux-kernel+bounces-889883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E8C3EC17
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65E034EB6D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F393090E4;
	Fri,  7 Nov 2025 07:30:32 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8327B4FB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500631; cv=none; b=R27uK/6Pc46eyDik24V+dpdk8lDCUfbfvjfiJqWuU+YRqtWjUYeCye7ljVyPyNpKDgakVUiDDj2lB2u+ZevcM3WoUC0vle6OrQ/M3WBafJTcutsq0bB1Xrdld/ea3bl/CnIeDisbFxdf/UmaD59sEb48xgzmW50LKqVcbE8r+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500631; c=relaxed/simple;
	bh=PmuoT3c8H1nbh0QIg54m2H7tK1X89lomLu0DJ4gC6vk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BsFvsaAZk88CTS7ErJXeyvlfcwi3nJHZsFB85asJA2qmFffj/d3VJcpNHKUR9+/TWFEHlblLqYOJUxVZ+s+nHxu7+tFOx7A45vhtsFH2xSAPKBn0rUirbhYkuJbMqg66X6uCArzJ/7LzxwIICpEhNPiut9J7oqPirIEFx8oX+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-431d84fdb91so9625585ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500628; x=1763105428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvhS3yJ5RI+iBD3kWFB7/BHHupDd3V14Ik9agSFoCEU=;
        b=JKDe1xYAPdF5E+5OH0FfwTayTWQa+jiv+QbA8I3PgJc/tcff/QZaSUSYJV1aS3o1vB
         OCqUtwzC/8mCr4rL50RMxZ+NmcEpi5EP9mUZFiHPg2dI+gdP2AXvoFg7mHz/H8oyw+f6
         FCxxW77vYMXbjKoekQMTMO93HavkqOTuaRZwL5VsVd+JXW9BZDnsKDjVCNcqcnVHZPQK
         w6yxSn49xHIc9ald0+zFyVx+pXtREQPVw9Cht0l6wLNmO/EYWoZkxHoR0wvOCuE0XMzC
         z7LHHpvljvYeDvJqssVAlaGXXll6Fs3GCO17d5qjl8kCG2Ax03bTR+vfHfchnULA+s2E
         P0CA==
X-Forwarded-Encrypted: i=1; AJvYcCUyKKGH6GxiffsN9aUeClGaRkUzwZNCFCmQlCAUH135tK5j7Qle4p2ShD1j7DbnbQmOrX8mn42EFhamLmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxGhrweZ45syV7+8Xx6f99rWXa1nS8bsNsFxcL3i1I7qKD2Xd
	x5WloDQHgWAQ7WMOVIxuA788z/O9ZzJ0CJb0UVSxWeLmrpbka9P/uuXDuRJbMZqcPtCQ73staoo
	OxxIgNvSjf/o7sQewnFMaOEkTd4pXVfdHSsyyyLP/wJdCK2MLOh2qoSt4/ho=
X-Google-Smtp-Source: AGHT+IFJk0Ewu+jeYb+KnQD2z6NrRThAVFqW/pLK+NL0wuCeR3kb4YjsvP6XIDWgVBnDoviUPxi+rly+NBHelhzxQuqwhXQ+GFhj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2283:b0:433:4f00:5d0c with SMTP id
 e9e14a558f8ab-4335f441229mr27971185ab.20.1762500628341; Thu, 06 Nov 2025
 23:30:28 -0800 (PST)
Date: Thu, 06 Nov 2025 23:30:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690da014.a70a0220.22f260.0026.GAE@google.com>
Subject: [syzbot] [cifs?] memory leak in smb3_fs_context_parse_param
From: syzbot <syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com>
To: bharathsm@microsoft.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	samba-technical@lists.samba.org, sfrench@samba.org, sprasad@microsoft.com, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2c2ccfd4ba7 Merge tag 'net-6.18-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127d2a58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=72afd4c236e6bc3f4bac
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104c7012580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1206e17c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0451ba3fe41/disk-c2c2ccfd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3e8c67119ab/vmlinux-c2c2ccfd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d8e176e5054/bzImage-c2c2ccfd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com

2025/11/07 05:48:37 executed programs: 5
BUG: memory leak
unreferenced object 0xffff888108910420 (size 96):
  comm "syz.0.17", pid 6085, jiffies 4294942570
  hex dump (first 32 bytes):
    2f 2f f2 62 06 08 ba df 58 6f dc ea 95 9a 9b 2f  //.b....Xo...../
    51 39 f9 0d 6d 44 94 29 55 db 15 58 2e 49 0a 7d  Q9..mD.)U..X.I.}
  backtrace (crc 79c9c7ba):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_node_track_caller_noprof+0x3aa/0x6b0 mm/slub.c:5751
    __kmemdup_nul mm/util.c:64 [inline]
    kstrdup+0x3c/0x80 mm/util.c:84
    smb3_fs_context_parse_param+0x229b/0x36c0 fs/smb/client/fs_context.c:1444
    vfs_parse_fs_param+0xf4/0x190 fs/fs_context.c:146
    vfs_fsconfig_locked fs/fsopen.c:303 [inline]
    __do_sys_fsconfig+0x7d3/0x900 fs/fsopen.c:473
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888128afa060 (size 96):
  comm "syz.0.18", pid 6087, jiffies 4294942571
  hex dump (first 32 bytes):
    2f 2f f2 62 06 08 ba df 58 6f dc ea 95 9a 9b 2f  //.b....Xo...../
    51 39 f9 0d 6d 44 94 29 55 db 15 58 2e 49 0a 7d  Q9..mD.)U..X.I.}
  backtrace (crc 79c9c7ba):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_node_track_caller_noprof+0x3aa/0x6b0 mm/slub.c:5751
    __kmemdup_nul mm/util.c:64 [inline]
    kstrdup+0x3c/0x80 mm/util.c:84
    smb3_fs_context_parse_param+0x229b/0x36c0 fs/smb/client/fs_context.c:1444
    vfs_parse_fs_param+0xf4/0x190 fs/fs_context.c:146
    vfs_fsconfig_locked fs/fsopen.c:303 [inline]
    __do_sys_fsconfig+0x7d3/0x900 fs/fsopen.c:473
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888128afa300 (size 96):
  comm "syz.0.19", pid 6090, jiffies 4294942572
  hex dump (first 32 bytes):
    2f 2f f2 62 06 08 ba df 58 6f dc ea 95 9a 9b 2f  //.b....Xo...../
    51 39 f9 0d 6d 44 94 29 55 db 15 58 2e 49 0a 7d  Q9..mD.)U..X.I.}
  backtrace (crc 79c9c7ba):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    smb3_fs_context_fullpath+0x70/0x1b0 fs/smb/client/fs_context.c:629
    smb3_fs_context_parse_param+0x2266/0x36c0 fs/smb/client/fs_context.c:1438
    vfs_parse_fs_param+0xf4/0x190 fs/fs_context.c:146
    vfs_fsconfig_locked fs/fsopen.c:303 [inline]
    __do_sys_fsconfig+0x7d3/0x900 fs/fsopen.c:473
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888128afa360 (size 96):
  comm "syz.0.19", pid 6090, jiffies 4294942572
  hex dump (first 32 bytes):
    2f 2f f2 62 06 08 ba df 58 6f dc ea 95 9a 9b 2f  //.b....Xo...../
    51 39 f9 0d 6d 44 94 29 55 db 15 58 2e 49 0a 7d  Q9..mD.)U..X.I.}
  backtrace (crc 79c9c7ba):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_node_track_caller_noprof+0x3aa/0x6b0 mm/slub.c:5751
    __kmemdup_nul mm/util.c:64 [inline]
    kstrdup+0x3c/0x80 mm/util.c:84
    smb3_fs_context_parse_param+0x229b/0x36c0 fs/smb/client/fs_context.c:1444
    vfs_parse_fs_param+0xf4/0x190 fs/fs_context.c:146
    vfs_fsconfig_locked fs/fsopen.c:303 [inline]
    __do_sys_fsconfig+0x7d3/0x900 fs/fsopen.c:473
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888112c7d900 (size 96):
  comm "syz.0.21", pid 6128, jiffies 4294943114
  hex dump (first 32 bytes):
    2f 2f f2 62 06 08 ba df 58 6f dc ea 95 9a 9b 2f  //.b....Xo...../
    51 39 f9 0d 6d 44 94 29 55 db 15 58 2e 49 0a 7d  Q9..mD.)U..X.I.}
  backtrace (crc 79c9c7ba):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
    kmalloc_noprof include/linux/slab.h:961 [inline]
    smb3_fs_context_fullpath+0x70/0x1b0 fs/smb/client/fs_context.c:629
    smb3_fs_context_parse_param+0x2266/0x36c0 fs/smb/client/fs_context.c:1438
    vfs_parse_fs_param+0xf4/0x190 fs/fs_context.c:146
    vfs_fsconfig_locked fs/fsopen.c:303 [inline]
    __do_sys_fsconfig+0x7d3/0x900 fs/fsopen.c:473
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888112c7d420 (size 96):
  comm "syz.0.21", pid 6128, jiffies 4294943114
  hex dump (first 32 bytes):
    2f 2f f2 62 06 08 ba df 58 6f dc ea 95 9a 9b 2f  //.b....Xo...../
    51 39 f9 0d 6d 44 94 29 55 db 15 58 2e 49 0a 7d  Q9..mD.)U..X.I.}
  backtrace (crc 79c9c7ba):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4975 [inline]
    slab_alloc_node mm/slub.c:5280 [inline]
    __do_kmalloc_node mm/slub.c:5641 [inline]
    __kmalloc_node_track_caller_noprof+0x3aa/0x6b0 mm/slub.c:5751
    __kmemdup_nul mm/util.c:64 [inline]
    kstrdup+0x3c/0x80 mm/util.c:84
    smb3_fs_context_parse_param+0x229b/0x36c0 fs/smb/client/fs_context.c:1444
    vfs_parse_fs_param+0xf4/0x190 fs/fs_context.c:146
    vfs_fsconfig_locked fs/fsopen.c:303 [inline]
    __do_sys_fsconfig+0x7d3/0x900 fs/fsopen.c:473
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

