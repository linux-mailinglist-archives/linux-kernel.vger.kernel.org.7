Return-Path: <linux-kernel+bounces-889495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D68C3DC81
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C463318906F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B93559CD;
	Thu,  6 Nov 2025 23:14:32 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8024C06A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470871; cv=none; b=OeZOPOEidgcGNC92iF8txZIB+W4P8N5tRQcF3NA/s7nr58Mr5qxwVjylrGL1/qKujtxFrnS9RbXDnqJWvQzcpPFXtOX6ss3px4YHkijBwVJuACyTMIbjrDDwSCAZtuxMHHLmzNQR9FhPDDb8GpeicrW4r9NN0CJ+jhpoLARMrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470871; c=relaxed/simple;
	bh=KkuJTcka+8xp0DpDWc4kTontJXbDC9h/mzebBbfDgHM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G9QGfiOwG1VCOaW0pAR+UTus7iKcbIGCbamrTvEnoDmtqJezebrQgYxSOq6xcvdQ7WYOHOHINbKhYzu0sZr83MNoouabsfMNQpdKR+BbQvXiSdjf7/maQ2JmPhRYIoCUSq/j8PidkVSt4wZE0lN8b63zsFcq1KNzFZWzLdFMLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-43333f50556so4948855ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470869; x=1763075669;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fH2h5Xx2k3fHBHPqxx/rP0WBkMwA7jvWWW6DLmqDYEo=;
        b=dOOsfJt211+fXLJQwwLb2uyjoevrGPc8Gzl/8W292Quvd1mzB9eUf1b2SPRRLuDZ4h
         Gh+CHIzUuC1vEMQJPxdgKlAbzgPrh80oVXWMO0JgqU9GIDcVkNWkqFnh8vUApbpD7agf
         r4M5tyZa8cBD7a0hJZ35KG9cjjiD0eBZgLSggukZaz8P98zwKxkiGx5oBnFiN75XnwDI
         al6XfHy2FEQtGBEegjq3EvB3hyUvXpgSrUawO/W4QclhiJtsnPM8+lMs43icil3EM1jv
         zoIK1z99oTGXcHdcGMEfhcp6q+xPpWSjqMxZ81hjt133a9BFGcOkcguOr3E8Q7O6bZBQ
         Z24g==
X-Forwarded-Encrypted: i=1; AJvYcCXOLc5Koc377/d4i5gV9Azsp1KDxMk1urJDZWSXVjJMsGCsRMSA5Syj9dumwhWS+K+2f2KClUO3MS8pBCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMe8I6EV/c1R+xs7dbMQPv251FtnIAKYuqoixhte3Pu6MLbUvG
	3GP0XQf/OmW62T8PwRWnWnMZd/O48KonKrnOCMPH4ibu2qouWvpmk4tenu2fN1idFGwN7sWsImg
	hryerMtmfmIVy50cce/mPmAZ86MolrNL8Fi0F3HvwDqoOMa1TulxZCMMIwlI=
X-Google-Smtp-Source: AGHT+IF8qjkQWCmR0Q7YUfopt65SrIHO8TnsfPNAO54omAeyphaXJ+kUNh5eIP+SMFGQAE3pdEs5c0FeNBeOKphyQzrSnDG+A80X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349e:b0:433:4fc9:7b3d with SMTP id
 e9e14a558f8ab-4335f45b01bmr17807845ab.22.1762470869154; Thu, 06 Nov 2025
 15:14:29 -0800 (PST)
Date: Thu, 06 Nov 2025 15:14:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d2bd5.a70a0220.22f260.000f.GAE@google.com>
Subject: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
From: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2c2ccfd4ba7 Merge tag 'net-6.18-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151be114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=5216036fc59c43d1ee02
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11062a58580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e19084580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/121c46acc3df/disk-c2c2ccfd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb0aef8fb7a1/vmlinux-c2c2ccfd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2bba0757aa5/bzImage-c2c2ccfd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/03760a9baabf/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12084532580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 256
exFAT-fs (loop0): start_clu is invalid cluster(0x400)
------------[ cut here ]------------
rtmutex deadlock detected
WARNING: CPU: 0 PID: 6071 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock kernel/locking/rtmutex.c:1674 [inline]
WARNING: CPU: 0 PID: 6071 at kernel/locking/rtmutex.c:1674 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
WARNING: CPU: 0 PID: 6071 at kernel/locking/rtmutex.c:1674 __rt_mutex_slowlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.c:1760
Modules linked in:
CPU: 0 UID: 0 PID: 6071 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:rt_mutex_handle_deadlock kernel/locking/rtmutex.c:1674 [inline]
RIP: 0010:__rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
RIP: 0010:__rt_mutex_slowlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.c:1760
Code: 7c 24 20 dd 4c 8b b4 24 98 00 00 00 0f 85 fd 0a 00 00 48 8b 7c 24 10 e8 4c 50 28 09 90 48 c7 c7 60 fd ea 8a e8 ef 62 e7 ff 90 <0f> 0b 90 90 48 8b 9c 24 80 00 00 00 43 80 3c 3e 00 74 08 4c 89 e7
RSP: 0018:ffffc90003d87a20 EFLAGS: 00010246
RAX: 5bae39e042a2bb00 RBX: ffff88802472e4e0 RCX: ffff88802472da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003d87c10 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101710487b R12: ffff88802472f160
R13: ffff88802472da18 R14: 1ffff110048e5e2c R15: dffffc0000000000
FS:  00005555931b8500(0000) GS:ffff888126df9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffefdd79178 CR3: 000000003e14c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rt_mutex_slowlock+0xb5/0x160 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14f/0x750 kernel/locking/rwbase_rt.c:244
 inode_lock include/linux/fs.h:980 [inline]
 vfs_rmdir+0xf7/0x520 fs/namei.c:4537
 do_rmdir+0x25f/0x550 fs/namei.c:4603
 __do_sys_unlinkat fs/namei.c:4777 [inline]
 __se_sys_unlinkat fs/namei.c:4771 [inline]
 __x64_sys_unlinkat+0xc2/0xf0 fs/namei.c:4771
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f03a63ff6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1d6ca228 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007f03a6655fa0 RCX: 00007f03a63ff6c9
RDX: 0000000000000200 RSI: 0000200000000040 RDI: 0000000000000006
RBP: 00007f03a6481f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f03a6655fa0 R14: 00007f03a6655fa0 R15: 0000000000000003
 </TASK>


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

