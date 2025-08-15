Return-Path: <linux-kernel+bounces-770365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78026B27A03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD071CC3F33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD42BEC45;
	Fri, 15 Aug 2025 07:21:34 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE85294A0C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242494; cv=none; b=HxSF67Wa4YaHo1IXk8rxbeDteSizuAqFcAZlZ6NskMJzFP8NjSH7bRnqQiiyxThYAoVLgOizJQ+YmTwLW0PyrlzsXD1Orrk/FWNkF4xtrefd1QNn1fc1NhWYF5nyCUaI7QmI9ZezSZFqcxxPgiyfoMauNM1Jvd0kJVr0woQE8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242494; c=relaxed/simple;
	bh=fGnNaPLHv1065p92mYwir5desSpze/4dajrSAkqs790=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JpeYqWnT3wPxmoHm4NlDMMObjuPgS13QfMESZOtCJO6oOsNLN+/FS+hFF43xdtX+NcIqZoTlmTf/Gs/trXROive3ad3HY8E9PqYKZAsdE25/pMZvtJ0BxcrdtWy7KYTJ+zw7/rix4ccNspVkFF6H8VlYlQx+MJixQ+cTuwkZIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432da0cfdso412296639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755242491; x=1755847291;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HnOcC1n4YieCsGDPq4S0swovBIbxANVuaGgW8ov97s=;
        b=H370xwy6zI23cMmT/H/VmwJJVqjl2blbry23vv8G6Rm2V/uJfnyFJC6hPrsG9ISUNa
         h5h0yEtUsHiC9E7myV1agryIh42Mxr6DXkLo+YAbdz6cwdQGBxNm40+dxMubZCDucvMZ
         M+OQu6xCU+JIrUsmI+j4spzU8Rt2k5HtjW2H/lyHC5Cp8N67mJdqMZMNCxstWAMXxoij
         kZ0+RevqUl8L/eGo8bbBZ5Wv0Y/fG0GwDA7k4Bb5FSH3oMhoOuO6hdmMToNBKK0XSR6w
         3OEEzdXuuFB4LeQ1878EsUSh1TaoYhyrGRfK+4qXyfdoTkGLMbv2kOpMIlAApFKKegXO
         rq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYAcvcjuJX3VGYhA3IxGOt8c8h5cdLrtwDv3NxdYGKO4phd/dGFbott7lZ+vctguCTzSdYs9WaAB5dVRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HLe6u9qCrVeOtu/n4nGND72q4XPA1rE5tS+bZpB4goKJHage
	p1nuCTzfIwYrhO6Gu4JNHUmSm11LyANt9oe5PEY+Ztt8/CPgtu65K0jwKJLkjGZLucwQuHJUN0w
	RdjbUl4bkAA1ComwiKxQLf6jJn0OyMz1Or70F/6Fce2G0QQ2xJ30ia81IBtk=
X-Google-Smtp-Source: AGHT+IG90PWJ817Ow/RrPGqo+8dwolIp3MbLRQXrzfqCMDmNELqE1GTuQtCbNYGtp1F/FyknqLGujeE9pS7BQbJXhnWJ46aJ3v6H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2705:b0:3e5:5937:e576 with SMTP id
 e9e14a558f8ab-3e57e8a895dmr19413985ab.13.1755242491675; Fri, 15 Aug 2025
 00:21:31 -0700 (PDT)
Date: Fri, 15 Aug 2025 00:21:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689edffb.050a0220.e29e5.000d.GAE@google.com>
Subject: [syzbot] [gfs2?] WARNING in do_mknodat (3)
From: syzbot <syzbot+0cee785b798102696a4b@syzkaller.appspotmail.com>
To: brauner@kernel.org, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24ea63ea3877 Merge tag 'acpi-6.17-rc2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116d7c34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=0cee785b798102696a4b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143ceda2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123ceda2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-24ea63ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/307e082b78f2/vmlinux-24ea63ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a771414670e3/bzImage-24ea63ea.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5942750c2b7f/mount_3.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=11a503a2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0cee785b798102696a4b@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff8880425214e8, owner = 0x0, curr 0xffff88801f694880, list empty
WARNING: CPU: 0 PID: 5554 at kernel/locking/rwsem.c:1381 __up_write kernel/locking/rwsem.c:1380 [inline]
WARNING: CPU: 0 PID: 5554 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Modules linked in:
CPU: 0 UID: 0 PID: 5554 Comm: syz.0.17 Not tainted 6.17.0-rc1-syzkaller-00111-g24ea63ea3877 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 60 ec 8a 8b 48 c7 c6 80 ee 8a 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 d3 56 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 74 cf a3 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc90002b3fd90 EFLAGS: 00010296
RAX: 7dddbd5471d56900 RBX: ffff8880425214e8 RCX: ffff88801f694880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: ffff88801fc24253 R09: 1ffff11003f8484a
R10: dffffc0000000000 R11: ffffed1003f8484b R12: 0000000000000000
R13: ffff888042521540 R14: ffff8880425214e8 R15: 1ffff110084a429e
FS:  00007f8883b116c0(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001600 CR3: 0000000059612000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:879 [inline]
 done_path_create fs/namei.c:4177 [inline]
 do_mknodat+0x428/0x4d0 fs/namei.c:4300
 __do_sys_mknodat fs/namei.c:4313 [inline]
 __se_sys_mknodat fs/namei.c:4310 [inline]
 __x64_sys_mknodat+0xa7/0xc0 fs/namei.c:4310
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8882d8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8883b11038 EFLAGS: 00000246 ORIG_RAX: 0000000000000103
RAX: ffffffffffffffda RBX: 00007f8882fb6180 RCX: 00007f8882d8ebe9
RDX: 0000000000000000 RSI: 0000200000001600 RDI: 0000000000000005
RBP: 00007f8882e11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000700 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8882fb6218 R14: 00007f8882fb6180 R15: 00007ffdd8050568
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

