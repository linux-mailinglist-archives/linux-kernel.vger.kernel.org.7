Return-Path: <linux-kernel+bounces-720219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43912AFB8AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83A44A2AA4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB322578C;
	Mon,  7 Jul 2025 16:32:35 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EED1F8AC8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905955; cv=none; b=ApyNC52WGGzDkmuG4fBs8OBBLQA7XrPpeNQfaIufiiJTI3KmA24EESEseHRPH4RuYqV6jLHVclb2TI2Dbzho7rYykkWCiHED6B7vawEw4v56EPPooNt9DSzzSE/+YWUyzCaqZLOGK3hLzEriWhwEUo5fWjv4nzrUIoKKFJZ2D24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905955; c=relaxed/simple;
	bh=y+i+Ranqf6OG1iQXgmpthwSHPW70a1cBAzZ/739T2pA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pUzIjkC/FJTujwm9Sm67JQfIr39Iu58v/rDPFminYVqH5Q/W4sW21IJw+FsU3CSBqq4QKW4VI7WQeEjJG3y8A/Oh2RuvgyK2ogd+keYa24EqWnppuiNaWwLD+S+/LNfUkWEF46bw7g8Wfut8dESpiSlAXesEl1kCYwQ8BRh02sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3df393bf5f2so34511075ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905953; x=1752510753;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFBDqnvaNNRhui7ANIEe6AwQqm/bPubwvFwSS3+qT8k=;
        b=YBZdHW3gItOSNYO6qpvgNNVKUcWmQUfzjrpxrKmRYT5A5t8zEWE7yj75gvcEmTkl2d
         SwDtaVoQcCjBr33DYXggFznosmSJ+HykDSXSnKEg0QJCKwsOepGwNo+xSFQjl5rwDoRT
         Z0HarfMkv0hzMmZNOxO+9sg+3jzcnKN8/TGy3YzEaKjeuuGIoJOpRIfyq4qhxIFpI3nt
         noAO1QFupiQYEvxH43mzHjI7XErpYOBsQDN/hhVpT/c3B8lpQV8nXoPlWs4v9ULsZAOi
         z2l3bdp56JcvuGvDJBRV+sFua4TLJ6bI6BWkDXBnT34lYHr0Cs2sR9wtJRNn/zSOlt7U
         ZX0g==
X-Forwarded-Encrypted: i=1; AJvYcCXMPZLN6225oaqTvNWSnpEQj9VixUMBhkWQQ5G9UMi0fL2sNY1rQ4tyM2Xn6hJAVf23zrlPbfUQ9k6MXkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8bWg+2EdEI0krJ09/zIUSsmyMs6lrWmHN1vNRZmNcQjmaAoB
	U7+hpYRQMI78ezAR3bdisXT/DDHy65ilQitdTUKBr5WJ58bjp/udjRtElBVpX7uhjZV41r1gWTH
	A9U5/HQ/ZiuAtYvck9Biqvad4zeU6P549l2lVyFqnFhla6tvriAdGQT/bCUg=
X-Google-Smtp-Source: AGHT+IGKKsGEorLguEvKJx8RLXhH0LAEyEsvpUhmXgRf1jTaNqXkp9P1y4+TX7th9jroDsBE2i3BVsHy+LCQJHp2Xxs41r3kdd2N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d86:b0:3df:2d65:c27a with SMTP id
 e9e14a558f8ab-3e13545d5f6mr125096315ab.1.1751905952625; Mon, 07 Jul 2025
 09:32:32 -0700 (PDT)
Date: Mon, 07 Jul 2025 09:32:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686bf6a0.a00a0220.b087d.01f3.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_update_inline_data
From: syzbot <syzbot+544248a761451c0df72f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    772b78c2abd8 Merge tag 'sched_urgent_for_v6.16_rc5' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1747ef70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=930b74448cb4593a
dashboard link: https://syzkaller.appspot.com/bug?extid=544248a761451c0df72f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120e828c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160e828c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-772b78c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a1257ea2c00/vmlinux-772b78c2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff01d2c78ebd/bzImage-772b78c2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f97118969515/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1581628c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
fscrypt: AES-256-XTS using implementation "xts-aes-aesni-avx"
loop0: detected capacity change from 512 to 64
------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:357!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5499 Comm: syz.0.16 Not tainted 6.16.0-rc4-syzkaller-00348-g772b78c2abd8 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_update_inline_data+0x4e8/0x4f0 fs/ext4/inline.c:357
Code: ff ff ff 48 8b 4c 24 18 80 e1 07 fe c1 38 c1 0f 8c 32 ff ff ff 48 8b 7c 24 18 e8 33 59 b1 ff e9 23 ff ff ff e8 e9 d5 4d ff 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002abf4a0 EFLAGS: 00010293
RAX: ffffffff82725017 RBX: ffff8880123cf558 RCX: ffff88800020c880
RDX: 0000000000000000 RSI: 00000000ffffffc3 RDI: 0000000000000000
RBP: ffffc90002abf5f0 R08: ffff88800020c880 R09: 0000000000000002
R10: 00000000ffffffc3 R11: 0000000000000000 R12: 00000000ffffffc3
R13: 000000000000004a R14: ffffc90002abf500 R15: ffffc90002abf528
FS:  0000555558bce500(0000) GS:ffff88808d21d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055795b748950 CR3: 000000003f98a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ext4_prepare_inline_data+0x141/0x1d0 fs/ext4/inline.c:415
 ext4_generic_write_inline_data+0x207/0xc90 fs/ext4/inline.c:692
 ext4_try_to_write_inline_data+0x80/0xa0 fs/ext4/inline.c:763
 ext4_write_begin+0x2d8/0x1680 fs/ext4/inode.c:1281
 generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f32a778e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd1fdeb38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f32a79b5fa0 RCX: 00007f32a778e929
RDX: 000000000000004a RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007f32a7810b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f32a79b5fa0 R14: 00007f32a79b5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_update_inline_data+0x4e8/0x4f0 fs/ext4/inline.c:357
Code: ff ff ff 48 8b 4c 24 18 80 e1 07 fe c1 38 c1 0f 8c 32 ff ff ff 48 8b 7c 24 18 e8 33 59 b1 ff e9 23 ff ff ff e8 e9 d5 4d ff 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90002abf4a0 EFLAGS: 00010293
RAX: ffffffff82725017 RBX: ffff8880123cf558 RCX: ffff88800020c880
RDX: 0000000000000000 RSI: 00000000ffffffc3 RDI: 0000000000000000
RBP: ffffc90002abf5f0 R08: ffff88800020c880 R09: 0000000000000002
R10: 00000000ffffffc3 R11: 0000000000000000 R12: 00000000ffffffc3
R13: 000000000000004a R14: ffffc90002abf500 R15: ffffc90002abf528
FS:  0000555558bce500(0000) GS:ffff88808d21d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563842271138 CR3: 000000003f98a000 CR4: 0000000000352ef0


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

