Return-Path: <linux-kernel+bounces-714560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B6AF6962
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 07:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6924E20F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 05:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99F428DF01;
	Thu,  3 Jul 2025 05:15:30 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFCB288C21
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 05:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519730; cv=none; b=HvLz1XfTbcGkvPQGXiDR+HFVmvoJbR+05yCln7ZCYOcP3savRCh4OoWAPpLtDwYxsoyja5NPgUrKdn1+w9em7aHpqiEgy/6eQW/50HZYi1XsE5uacdDCInOFRu/hOAtZjHQQ6vmKJObCdcpMne+ML4lQimOLQOm254pVp38UMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519730; c=relaxed/simple;
	bh=0LlX4jHh4R7b19i3jJjGb8y10eDDGSNistW34BSRzz0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=szSGj61NK8iGd0U4pgWht0c2Qhu7j+v/4lhIHoSYfmJVQ5yPHjstPC4Izbcs2Gq7xmVYT0NGCpo15qoOYvyTeKH3jcd3uGpIaTfGRjTmHX1W8jRTZ2Ia4eG/gyriuIxajF1Cj1onbNMOkO4qzmSuDv83G87imHOevqtC7xJpwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86cfe68a8bbso528573039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 22:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751519728; x=1752124528;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqjtuX+DTXfHvIASS5HImtIn8N4XEk7+RtcSzx0flnY=;
        b=r3hxWjhsW8A1m6Ldy8auOCLtYOUUMpn5SrOyy8tySEl9dHGTEd+AGmAHfnhZmH8az3
         8eG6yuz8cbm8mKqc4lQouVQ/Ly4VHOsQc9t+UvCLnHXc2Eri0Ldl0GeGptaFez4Lvdbv
         q21zCxHcZmkmlI/GZnKwI6GLIIuZGgfd5cd8ssRWnhFnBJdIzMy/2FkT2gTsmv6xORtt
         i+f9Qm5IPM2mpBSGj1PAJRTDCiS9mE6ieWgXHGouA8u4K6xMMMbNzMYb6pFPAiYhpPc9
         IXmkcDxASMoRa6IzM42ywBYvC+rl5yW/roU4UEJq+mKDmz/onTLYNsj1ngnA+WjfmR8i
         /e2w==
X-Forwarded-Encrypted: i=1; AJvYcCVeANgNgCP7MP8mtSQsFmnaaeGuPNTRhPQnGAPxwmQsJuSDY6mVZVBSYN8ezCwnWcOFr1XyS6tzIBfpL/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4mg7Pg6Bd+G3TB9JmwBrNTlf1AjB/CbTe0hsc81eTfKhvY0S8
	pKe6QchO/VtIwHqsxibmQuaMWqoAb3yYVi+f2KWyLPUEnJalFrJ3fFJW9fk/FutX0hiei3BQ5Dr
	oMqHIdMTBYxBj4NqOdmQ9jOPn5cDuqcFktPlksUbf6D1aj4wHXiksqHc14eg=
X-Google-Smtp-Source: AGHT+IE9Vohn9s6TZ/72oH4vZz/0xjaDmlwKigjhR4gQwr6x2rew0KXK0VYh6CXDCoYDNTRlPkYiIP9UT85OKnCwxxWBJbuTlVb1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640a:b0:873:47fb:a455 with SMTP id
 ca18e2360f4ac-876d1d91893mr296855939f.2.1751519727797; Wed, 02 Jul 2025
 22:15:27 -0700 (PDT)
Date: Wed, 02 Jul 2025 22:15:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686611ef.a70a0220.5d25f.0833.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in __btree_trans_update_by_path
From: syzbot <syzbot+8deb6ff4415db67a9f18@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c8770a42fa Add linux-next specific files for 20250702
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1191aebc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d831c9dfe03f77ec
dashboard link: https://syzkaller.appspot.com/bug?extid=8deb6ff4415db67a9f18
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1311d3d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1770f982580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb40fda2e0ca/disk-50c8770a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cba4d214940c/vmlinux-50c8770a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b23ed647866/bzImage-50c8770a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cd313604f9e1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8deb6ff4415db67a9f18@syzkaller.appspotmail.com

  while marking u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 1db8f60c84bb244c written 8 min_key POS_MIN durability: 1 ptr: 0:42:0 gen 0, fixing
 done
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_update.c:339!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5842 Comm: syz-executor286 Not tainted 6.16.0-rc4-next-20250702-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__btree_trans_update_by_path+0x1fd3/0x2010 fs/bcachefs/btree_update.c:339
Code: f6 ff ff 48 8b 7c 24 28 e8 ca dd f5 fd 48 ba 00 00 00 00 00 fc ff df e9 3d f6 ff ff e8 a6 c9 91 fd 90 0f 0b e8 9e c9 91 fd 90 <0f> 0b e8 96 c9 91 fd 90 0f 0b e8 8e c9 91 fd 90 0f 0b e8 86 c9 91
RSP: 0018:ffffc9000413ea18 EFLAGS: 00010293
RAX: ffffffff842e0b42 RBX: 0000000000008542 RCX: ffff88802ea71e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888031194010 R08: ffffffff84518baa R09: 0000000000000002
R10: 0000000000000003 R11: 0000000000000000 R12: ffff888074e00000
R13: ffff888031194000 R14: 0000000000000088 R15: 1ffff11006232802
FS:  000055555e045380(0000) GS:ffff888125c1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e03c677168 CR3: 0000000078920000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 bch2_trans_update_by_path fs/bcachefs/btree_update.c:454 [inline]
 bch2_trans_update_ip+0x8f6/0x1f00 fs/bcachefs/btree_update.c:546
 bch2_trans_update fs/bcachefs/btree_update.h:123 [inline]
 bch2_journal_replay_key+0x4c1/0xb50 fs/bcachefs/recovery.c:311
 bch2_journal_replay+0x171d/0x2630 fs/bcachefs/recovery.c:396
 bch2_run_recovery_pass fs/bcachefs/recovery_passes.c:484 [inline]
 __bch2_run_recovery_passes+0x392/0x1010 fs/bcachefs/recovery_passes.c:539
 bch2_run_recovery_passes+0x184/0x210 fs/bcachefs/recovery_passes.c:610
 bch2_fs_recovery+0x2690/0x3a50 fs/bcachefs/recovery.c:1005
 bch2_fs_start+0xaaf/0xda0 fs/bcachefs/super.c:1212
 bch2_fs_get_tree+0xb39/0x1540 fs/bcachefs/fs.c:2488
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f878cb709ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc9f662588 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc9f6625a0 RCX: 00007f878cb709ba
RDX: 00002000000000c0 RSI: 0000200000000080 RDI: 00007ffc9f6625a0
RBP: 0000200000000080 R08: 00007ffc9f6625e0 R09: 00000000000059b9
R10: 0000000000818001 R11: 0000000000000282 R12: 00002000000000c0
R13: 0000000000000004 R14: 0000000000000003 R15: 00007ffc9f6625e0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__btree_trans_update_by_path+0x1fd3/0x2010 fs/bcachefs/btree_update.c:339
Code: f6 ff ff 48 8b 7c 24 28 e8 ca dd f5 fd 48 ba 00 00 00 00 00 fc ff df e9 3d f6 ff ff e8 a6 c9 91 fd 90 0f 0b e8 9e c9 91 fd 90 <0f> 0b e8 96 c9 91 fd 90 0f 0b e8 8e c9 91 fd 90 0f 0b e8 86 c9 91
RSP: 0018:ffffc9000413ea18 EFLAGS: 00010293
RAX: ffffffff842e0b42 RBX: 0000000000008542 RCX: ffff88802ea71e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888031194010 R08: ffffffff84518baa R09: 0000000000000002
R10: 0000000000000003 R11: 0000000000000000 R12: ffff888074e00000
R13: ffff888031194000 R14: 0000000000000088 R15: 1ffff11006232802
FS:  000055555e045380(0000) GS:ffff888125d1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f8b3a1796 CR3: 0000000078920000 CR4: 00000000003526f0


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

