Return-Path: <linux-kernel+bounces-704693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF3AEA08F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C085E4E3794
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B5813B58B;
	Thu, 26 Jun 2025 14:29:30 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94F20C48D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948169; cv=none; b=Y1Vi1Vzwb3KyKcEVlq6eV6se0XQsMVOnA2MTSpkvowoIGdBYB4akgc1FlordQkCiKJtPfqbp2FmNgtIVPFCz01tV9q2HihKD1/OWlYJvilx7Vxz7a1bLeDeFUbSoD5nkbLOFPgR6UWCP6W70UXnA1CrNuvZor3R90jScJvsi2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948169; c=relaxed/simple;
	bh=uvfxlfPOG2DPPqE9JOHJ3sMh4zTdY6u7VRpiP0y4xK8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bSRaB7s+efk7+ntJ5mZkZrdfqG8rcYzpvG6zunOQccIyKQrZronP+HSCgLrZBLDZRe+3fmUPigl+0jllqb6fkSYdfavDKWt4GjgregjEtmEY4nOtqwBlLAfNhBcDi6RHQF5Ze7jHH+MzW2SWE3qYVYGAIk0d+dsCwd89d/qKmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddd03db21cso14935565ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 07:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948167; x=1751552967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d805U0s54iQJcbspU9QBqOgnGmli7ealJcyIyATc5s8=;
        b=V/LsXZpptRihR4lxErt4X66uJxFNLYaOXN3mysce7uQEGCa03kZFb1vSetrfhXLhMk
         CdbrrjQpoaiT+wVPiFFnRUCMsn7O+xnhxwLwoUHiKgys7+uijYXjVoco2393k9KVyVq9
         qmDXeHD6/nHXMxrwozMOZN3Lznh66fRZBICRJht9B/45+9vtg8RQtwvSRCKbk+nW9OV0
         SIwBesRy4PuBtCqWEFQPr5N8nz9R3YtdIR8WCq/3MVKCEA5gdKu5Yklym4IPnBc2zGRu
         cMGQ+jwBMyLR4a6Pi7xqTS2DZLkXYgkIzlARcwJ4ugWVCz/XFaOahOVgrlROtHb2seeA
         RAfg==
X-Forwarded-Encrypted: i=1; AJvYcCXEKNEPpnu6LAsvJq4mGpO5jZEMxddN7MKez7/+Re61dAPZxntTDwBB/R+AXjCHUVWRTi51g62aOfAdNIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvdUXFL3BXu//5yFW5wC3dljgGxaluOtmXXDZyLo7s3MhphIWj
	sPhrRu7SDrUF1jPAh1r4N7oEjfx30zlr9DkJB1oTR0gmJDZKe9gZFb+kV/M0tuLcaFkU/JIfl4Z
	PrqtBSL18nJ+F6k+IxtADIV1qKKDMF0VVMCUtjZNCSKTy0pCWhx0Whsp4uQk=
X-Google-Smtp-Source: AGHT+IG30eUo7wifjgplwaSpb1C6RgXEdll/FthyW0f+yF54DNo0TGU3OI3/ebujSFQtzlSrcdomqhgzNKBkGGyl62W/2TzabCeN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:3df:3eeb:9dd7 with SMTP id
 e9e14a558f8ab-3df3eeba0e7mr46423385ab.19.1750948167206; Thu, 26 Jun 2025
 07:29:27 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:29:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685d5947.a00a0220.34b642.0111.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_split_extent_at (3)
From: syzbot <syzbot+99e33c5c0a4aebb2eb72@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    739a6c93cc75 Merge tag 'nfsd-6.16-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11729b0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=99e33c5c0a4aebb2eb72
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f5a65b9fc0ed/disk-739a6c93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f1b70f2f048/vmlinux-739a6c93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8ab27807c85/bzImage-739a6c93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99e33c5c0a4aebb2eb72@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:3206!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 10105 Comm: syz.7.991 Not tainted 6.16.0-rc2-syzkaller-00318-g739a6c93cc75 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ext4_split_extent_at+0xf42/0xf70 fs/ext4/extents.c:3206
Code: 89 f9 80 e1 07 fe c1 38 c1 0f 8c 50 fb ff ff 4c 89 ff e8 51 f7 b4 ff e9 43 fb ff ff e8 87 79 51 ff 90 0f 0b e8 7f 79 51 ff 90 <0f> 0b e8 77 79 51 ff 90 0f 0b e8 6f 79 51 ff 90 0f 0b e8 67 79 51
RSP: 0018:ffffc90005166960 EFLAGS: 00010283
RAX: ffffffff826ee301 RBX: 0000000000000016 RCX: 0000000000080000
RDX: ffffc900213d9000 RSI: 00000000000369aa RDI: 00000000000369ab
RBP: ffffc90005166ab8 R08: 0000000000000003 R09: ffffc90005166a40
R10: dffffc0000000000 R11: fffff52000a2cd49 R12: ffff88814cbf7f00
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000030
FS:  00007fa0ec4006c0(0000) GS:ffff888125c51000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000000a000 CR3: 000000003489c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_split_extent+0x23f/0x6e0 fs/ext4/extents.c:3406
 ext4_split_convert_extents fs/ext4/extents.c:3743 [inline]
 ext4_ext_handle_unwritten_extents fs/ext4/extents.c:3915 [inline]
 ext4_ext_map_blocks+0x1db2/0x6ac0 fs/ext4/extents.c:4274
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x931/0x18d0 fs/ext4/inode.c:813
 mpage_map_one_extent fs/ext4/inode.c:2348 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2401 [inline]
 ext4_do_writepages+0x212f/0x3f30 fs/ext4/inode.c:2863
 ext4_writepages+0x205/0x350 fs/ext4/inode.c:2953
 do_writepages+0x32e/0x550 mm/page-writeback.c:2636
 filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
 __filemap_fdatawrite_range mm/filemap.c:419 [inline]
 file_write_and_wait_range+0x22c/0x330 mm/filemap.c:794
 generic_buffers_fsync_noflush+0x6c/0x180 fs/buffer.c:609
 ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
 ext4_sync_file+0x332/0xb20 fs/ext4/fsync.c:147
 generic_write_sync include/linux/fs.h:3031 [inline]
 ext4_buffered_write_iter+0x2ca/0x3a0 fs/ext4/file.c:305
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 do_iter_readv_writev+0x56e/0x7f0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_pwritev fs/read_write.c:1153 [inline]
 __do_sys_pwritev2 fs/read_write.c:1211 [inline]
 __se_sys_pwritev2+0x179/0x290 fs/read_write.c:1202
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa0eb58e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa0ec400038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007fa0eb7b6080 RCX: 00007fa0eb58e929
RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000007
RBP: 00007fa0eb610b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000005412 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa0eb7b6080 R15: 00007fffa0000688
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_split_extent_at+0xf42/0xf70 fs/ext4/extents.c:3206
Code: 89 f9 80 e1 07 fe c1 38 c1 0f 8c 50 fb ff ff 4c 89 ff e8 51 f7 b4 ff e9 43 fb ff ff e8 87 79 51 ff 90 0f 0b e8 7f 79 51 ff 90 <0f> 0b e8 77 79 51 ff 90 0f 0b e8 6f 79 51 ff 90 0f 0b e8 67 79 51
RSP: 0018:ffffc90005166960 EFLAGS: 00010283
RAX: ffffffff826ee301 RBX: 0000000000000016 RCX: 0000000000080000
RDX: ffffc900213d9000 RSI: 00000000000369aa RDI: 00000000000369ab
RBP: ffffc90005166ab8 R08: 0000000000000003 R09: ffffc90005166a40
R10: dffffc0000000000 R11: fffff52000a2cd49 R12: ffff88814cbf7f00
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000030
FS:  00007fa0ec4006c0(0000) GS:ffff888125d51000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c33fb2d CR3: 000000003489c000 CR4: 0000000000350ef0


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

