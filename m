Return-Path: <linux-kernel+bounces-590302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A19A7D162
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 03:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73110188CC6E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED50E1BC58;
	Mon,  7 Apr 2025 01:06:27 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC111CA0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743987987; cv=none; b=TMZdQbTd8qUs/UbvddZpc3u4BywNNNd6RZxk1fLHbZTBulG0TmCvGzByI8nS/2Th4ksfY8nkS0t8/X5wIv+Iwy+DSTzMdWwU26NuzV2gDSTGAfqmPPy/NJ7v7YRfcRNG0qYjtofXtJzJWOdXTst/DhZub/+rlHOmBVzmmnSlVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743987987; c=relaxed/simple;
	bh=oG+W4yapIK3Feidhv8pALwRvGWLdU3rSxYb/QFVa8Y8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fkJSJSuNutHZpvLRgQYzNigHdxAkxYmIqmXnFGBbp8ye3Hm+qSRhqEToYCZ05ZS1oC6eg7cT4Gm7h0Qlm/ipyPk589eh/5HlObv9Ao/OqvN9jNB3Kwpiz7msasK+jxQhNybSia8an201zkWSoV6kQdnsJNvSYfKmNpPNx72NXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8610d7ec4d3so769095439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Apr 2025 18:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743987985; x=1744592785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4WGIauPyxCTdCJdh0mMztUYysxQLeZVbSB6lnW873E=;
        b=ENU4wGDneXsmPi0cl94ssDQCpAK3OOmtvvC+D96CU4R023LFSKGDrM8qeeSD+LGI/e
         u+jUOmLV+EbyERN3JRwgx0L7UrEhUWVVW6TrzLxc1/ln+bN7Tmf/OezBg3cV69dgEFJe
         +9Tx/dnPwBszxahMdg69U5orE6nVz8zc2kr0wCUKPBnk0/kqJTu2VyzF5P9ejKqNSw5G
         hQz+h2Y6nSK9QfGWHG/Oh9lfS5pzflXx1cp2TjpG5tIoQ1EyJSHm3hs+E3T+8zlGBH5B
         GWwjq6XSyuL/Zmsr4K2m4OR0pA7EcdzQK+NEBgkYQZjWAe38wArJ38tKgksx2LL6Kkbb
         lehg==
X-Forwarded-Encrypted: i=1; AJvYcCXC8oJy7prwNtHRKwawAqb1rzth3T4eqwPt2CAAhN2oNeCZ8a7Y6kktWfUzB4wy03C+qJ5xdgjJbrHOze8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gXarN612ylu31M4ficZnNsFsZ0UMxWClNqulsCi2h30qYdQp
	jUMKNAGeXHfU6zVvUsJokk+PXYWjz/AMAqBbzcusFsesPIff69BOH3/xlKAzryVjMjgcbUAlbDP
	cSSj7Kt8vnC3a0BG+IXbz1HnhR0v3lqgQLXlOfuYCsSrlGGR2RwmnYH4=
X-Google-Smtp-Source: AGHT+IG03Us3uLwOoBy+Gddsv8lkn3h1/O0z/LCbSoF1ocMFbal+dTen0+phvfG+N3HgzqvDidT/6iYPuDWj+ioQboupuDa+GFyA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4401:20b0:3d4:38a4:388e with SMTP id
 e9e14a558f8ab-3d6e52ee9c1mr81698615ab.1.1743987984916; Sun, 06 Apr 2025
 18:06:24 -0700 (PDT)
Date: Sun, 06 Apr 2025 18:06:24 -0700
In-Reply-To: <0000000000001e20c30621e8d767@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f32510.050a0220.0a13.0278.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_dio_wr_get_block
From: syzbot <syzbot+f8b081be889b639423bb@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17abdb4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66996a2350ef05e0
dashboard link: https://syzkaller.appspot.com/bug?extid=f8b081be889b639423bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14160c04580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5923f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0af2f6be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fcfb8eefe4d/vmlinux-0af2f6be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e06a39be2bd8/bzImage-0af2f6be.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2b9582c348c6/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1755923f980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8b081be889b639423bb@syzkaller.appspotmail.com

(syz-executor555,5473,0):__ocfs2_journal_access:705 ERROR: Error -30 getting 1 access to buffer!
(syz-executor555,5473,0):ocfs2_write_end_nolock:1942 ERROR: status = -30
(syz-executor555,5473,0):ocfs2_commit_trans:382 ERROR: status = -5
------------[ cut here ]------------
kernel BUG at fs/ocfs2/aops.c:2252!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5473 Comm: syz-executor555 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_dio_wr_get_block+0x18c1/0x18d0 fs/ocfs2/aops.c:2252
Code: 23 8f 4c 89 f2 e8 ff b9 7f 01 e9 38 f6 ff ff e8 45 6d 6f 08 e8 60 41 02 fe 90 0f 0b e8 58 41 02 fe 90 0f 0b e8 50 41 02 fe 90 <0f> 0b e8 48 41 02 fe 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000da3ece0 EFLAGS: 00010293
RAX: ffffffff83c113d0 RBX: 0000000000002000 RCX: ffff888000524880
RDX: 0000000000000000 RSI: 0000000000002000 RDI: 00000000ffffffe2
RBP: ffffc9000da3eed0 R08: ffffffff83c10e6d R09: 1ffffffff20bfbee
R10: dffffc0000000000 R11: fffffbfff20bfbef R12: 1ffff110023a150d
R13: dffffc0000000000 R14: 00000000ffffffe2 R15: ffff88804451cbd0
FS:  00007fb0138136c0(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb01389ad10 CR3: 0000000042406000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 get_more_blocks fs/direct-io.c:648 [inline]
 do_direct_IO fs/direct-io.c:936 [inline]
 __blockdev_direct_IO+0x1add/0x4540 fs/direct-io.c:1243
 ocfs2_direct_IO+0x255/0x2c0 fs/ocfs2/aops.c:2438
 generic_file_direct_write+0x1e8/0x400 mm/filemap.c:4036
 __generic_file_write_iter+0x126/0x230 mm/filemap.c:4205
 ocfs2_file_write_iter+0x190f/0x20d0 fs/ocfs2/file.c:2469
 iter_file_splice_write+0xbdf/0x1530 fs/splice.c:738
 do_splice_from fs/splice.c:935 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1158
 splice_direct_to_actor+0x595/0xc90 fs/splice.c:1102
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x281/0x3d0 fs/splice.c:1227
 do_sendfile+0x582/0x8c0 fs/read_write.c:1368
 __do_sys_sendfile64 fs/read_write.c:1429 [inline]
 __se_sys_sendfile64+0x17e/0x1e0 fs/read_write.c:1415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb01385ee19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb013813218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fb0138ea6c8 RCX: 00007fb01385ee19
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00007fb0138ea6c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080000013 R11: 0000000000000246 R12: 00007fb0138b7510
R13: 00002000000001c0 R14: 6f6f6c2f7665642f R15: 0000200000000140
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_dio_wr_get_block+0x18c1/0x18d0 fs/ocfs2/aops.c:2252
Code: 23 8f 4c 89 f2 e8 ff b9 7f 01 e9 38 f6 ff ff e8 45 6d 6f 08 e8 60 41 02 fe 90 0f 0b e8 58 41 02 fe 90 0f 0b e8 50 41 02 fe 90 <0f> 0b e8 48 41 02 fe 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000da3ece0 EFLAGS: 00010293
RAX: ffffffff83c113d0 RBX: 0000000000002000 RCX: ffff888000524880
RDX: 0000000000000000 RSI: 0000000000002000 RDI: 00000000ffffffe2
RBP: ffffc9000da3eed0 R08: ffffffff83c10e6d R09: 1ffffffff20bfbee
R10: dffffc0000000000 R11: fffffbfff20bfbef R12: 1ffff110023a150d
R13: dffffc0000000000 R14: 00000000ffffffe2 R15: ffff88804451cbd0
FS:  00007fb0138136c0(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005597594ba008 CR3: 0000000042406000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

