Return-Path: <linux-kernel+bounces-838685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C8BAFEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05FF1894E69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B828B407;
	Wed,  1 Oct 2025 09:52:38 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2F238D42
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759312358; cv=none; b=AyW9SPSfvEj4pcIlVrH7OVT2o9J6La0y3XYjaSavdh0xwy0bYVzsRVRTM5XpYdv5+DsDroEqBoveXVuSf1AwRtoTiQ8Vk9p/ysWg9vyrGG/8Nc1LwnLkdvYfQbnfF+RvTQ4H4+pIl2/780JWJa2G2GgXOiqAYbs+3gMoPRM/Pb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759312358; c=relaxed/simple;
	bh=ZvNjuBIWetmZgMgkVH98f3kni70B1lUqu4gu6U4p/II=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mhKdVWuHPS7O63nW46oIk9UuZukPTK0RzT7nBVYt1FWU6D2tVUg0wTaF/f4Fu3+3I7DuQVmf46MHgjkJ66wROfG7dRocl6ddO6HyCb8/SnJusgnZ6uDK9iHgv+i4ciB5g4xKsI3gYOGdsjPF8hgGPFnowdQ9RFDyRHmAROou724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-426cea3f07eso191105125ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759312356; x=1759917156;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUPEEtMc3DMtN1d8jhk56MJLu/z9nXEU7Qzz7X5zZEc=;
        b=EocSmD81YF1EkQ41MhusgRfuqS9rFqxy+33+8TPY4k3qU4hYe/D/DIfL8LOIc8ExrX
         AuJKF4VxjlBk+gNX9zI0tWkG1rWlbrJbz9LK/q/WXZLkyMdGR3DlORJlqYIYYQwj7lwc
         ZEy0AyfMxmtj3PLaLDoLCEjeIJfNgHpRazNH+8U2OwwI0ckbw7Jnsh/tZt3p/DzGNxVa
         MkIlsUj2MZLYVXT2vSSxH0d9FRMfrlV1tetpD8Nmypd+OcO3Bvc+iLYtysfFsZ0mh4cY
         svVFvvXwwIAsZHKyKiOPLZSPmcNYNvk2ZVFAeVuzTTSIYO67F8qvcePfSarlKlzoNlHv
         6ZSg==
X-Forwarded-Encrypted: i=1; AJvYcCXNgMb9TGN6DElPYtGEf48S5Klvt7aB1nFkT2ZkD2cndDIhQw5iPnG9S8ILyb84a9XJ177q72OccDhv59M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHFMhN/Osk883MgoB53DIOy344plKDe85Wy65/+a9Dw2Da4s86
	20/X6Ak5HzI2uhfEnJD6EvCk4fm9fDn8JHMqOpnvmP13LBHTOvHvltdhK9Qm71sKgrbsKI4Bt5T
	GM2Iaj7Gv7jPsqCmv2T301QZrPSZsNYHlsN/xi3/PTpLr2xBqrH6fRRo1lfQ=
X-Google-Smtp-Source: AGHT+IH+IV63aA9VhXmOzGXFy2AdiNX3YA8kp1TuLbHVjPG4x4keqZpdrqtLdkXKvZTbPHN32/qJpnTV/7U8WcWkA27i9j7Wbp2v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178f:b0:429:6c5a:61df with SMTP id
 e9e14a558f8ab-42d816011edmr42654615ab.3.1759312355923; Wed, 01 Oct 2025
 02:52:35 -0700 (PDT)
Date: Wed, 01 Oct 2025 02:52:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dcf9e3.a00a0220.102ee.0057.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_fs_free (2)
From: syzbot <syzbot+f2fb0a1f147a67cd3ac1@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fec734e8d564 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14df3142580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=f2fb0a1f147a67cd3ac1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c50776ae92ae/disk-fec734e8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1489b275504/vmlinux-fec734e8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b4c062dc0ea/bzImage-fec734e8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2fb0a1f147a67cd3ac1@syzkaller.appspotmail.com

bcachefs (loop0): error in recovery: EINTR
  emergency read only at seq 11
bcachefs (loop0): bch2_fs_start(): error starting filesystem EINTR
bcachefs (loop0): shutting down
------------[ cut here ]------------
kernel BUG at fs/bcachefs/super.c:725!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 4520 Comm: syz.0.7943 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:bch2_fs_free+0x59c/0x5a0 fs/bcachefs/super.c:725
Code: e8 f9 d4 c9 fd e9 16 fc ff ff 89 d9 80 e1 07 38 c1 0f 8c 72 ff ff ff 48 89 df e8 df d4 c9 fd e9 65 ff ff ff e8 d5 57 66 fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41
RSP: 0018:ffffc90004b7f918 EFLAGS: 00010246
RAX: ffffffff8459631b RBX: 0000000000000002 RCX: 0000000000080000
RDX: ffffc9000c0d1000 RSI: 000000000007ffff RDI: 0000000000080000
RBP: ffff888056a36000 R08: ffff888056a36047 R09: 1ffff1100ad46c08
R10: dffffc0000000000 R11: ffffed100ad46c09 R12: 1ffff11013ec00f0
R13: 0000000000000000 R14: ffffffff8e7a84a0 R15: ffff88809f600782
FS:  00007f88c92746c0(0000) GS:ffff888125c12000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000057030 CR3: 0000000061ea0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 bch2_fs_get_tree+0xb6e/0x1520 fs/bcachefs/fs.c:2604
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f88c839066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f88c9273e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f88c9273ef0 RCX: 00007f88c839066a
RDX: 0000200000000200 RSI: 0000200000000000 RDI: 00007f88c9273eb0
RBP: 0000200000000200 R08: 00007f88c9273ef0 R09: 0000000001800402
R10: 0000000001800402 R11: 0000000000000246 R12: 0000200000000000
R13: 00007f88c9273eb0 R14: 0000000000005962 R15: 0000200000000540
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_fs_free+0x59c/0x5a0 fs/bcachefs/super.c:725
Code: e8 f9 d4 c9 fd e9 16 fc ff ff 89 d9 80 e1 07 38 c1 0f 8c 72 ff ff ff 48 89 df e8 df d4 c9 fd e9 65 ff ff ff e8 d5 57 66 fd 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41
RSP: 0018:ffffc90004b7f918 EFLAGS: 00010246
RAX: ffffffff8459631b RBX: 0000000000000002 RCX: 0000000000080000
RDX: ffffc9000c0d1000 RSI: 000000000007ffff RDI: 0000000000080000
RBP: ffff888056a36000 R08: ffff888056a36047 R09: 1ffff1100ad46c08
R10: dffffc0000000000 R11: ffffed100ad46c09 R12: 1ffff11013ec00f0
R13: 0000000000000000 R14: ffffffff8e7a84a0 R15: ffff88809f600782
FS:  00007f88c92746c0(0000) GS:ffff888125c12000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000057030 CR3: 0000000061ea0000 CR4: 0000000000350ef0


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

