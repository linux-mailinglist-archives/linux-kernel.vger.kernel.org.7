Return-Path: <linux-kernel+bounces-785995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1ABB35349
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EB83AD879
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925242ED17B;
	Tue, 26 Aug 2025 05:27:34 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFF2ED144
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186054; cv=none; b=A/1Itf7q1kHX1henXc6VZhCWe/5mD83hLuSRY1uQJ+MZRZXFuX4Ij84bFQx9GtddosaP3jeGhhO1xS3Y50xDUuwySl05cV18E+epiES+aUJUysNOVMsNEyIXWgOP89X10oKHdEjypLoVpm72+UcPN22JtO8wSswsoO1HsFdutr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186054; c=relaxed/simple;
	bh=wC170smjIex9ZF7b1zSltTZJ8Hd35+Sge1x77JT6lis=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=guHe6Knaw2tw7G2T6c3HXdHK2VdlbbeZF5NC+ajbLxyEIhIMki1PJsBR4oojq0rIyKENvRt4eBYy90dJgYAvAAN9RLYJ2PLweF+MnTqw9xyUwMvxMQyQAGNJ4AELlwn5MvRNC8BhYqRIetoEZ99EAg2J/qCXLl1WiqgaIzQiSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3eed935cd97so2485085ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756186051; x=1756790851;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLMIt7cjsjEQe4jvLvyfMSwRYCWcqxa6uKclOUcmSPk=;
        b=cqtQZ0W0B6qVVpjF6rPpGvLtxKn1Qw2/qA9gD//0k9HNQ1TPrq6X4hbReOYMaEHVeP
         4lUNS5QeUOoAljC/BNTcNxE3+xrcpVYj/ZJh/k26081vnV8bfppWdLDjYD9trXAMBSkL
         aPErD4xTls9M0T0/pagEEhi+y8U6r1j0LylFswpdNc8IA7cpI8diqptzRZ6vGvfD6zXb
         dI/HOrhBNGltv0gmzkNs4sY2k7zhpJoKYrnmK2vVJ3JDqqQqLZgr3Jo5kuKq8usuWcEe
         1rVgiJa8GedezFAU6uukXzua0rW84ZQwIUXd4PsNrYIYEtkj4swX5kiEiTAl5DX72bQr
         l4dw==
X-Forwarded-Encrypted: i=1; AJvYcCUQnehHjbRYgqSXmZzILId2s8gCfdYjhtbxeoTNldyuVg9UkEsOUWQtwlnBRXC/B89MTZ0Q9rz6Kx+OB2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxpi/GLTsRSvMYnbrM4+yywsV8GLyk9I120jwwBObvV3kDNsJr
	ZqWcggpEeC4/tKbP/5Co3G7hyegMtlA8K+KIi2u6empNmXPerQ7TqTJloHb1mR8Sf2AgnGLsHhn
	MOMdGGKWYK/ivT8IZAlAzaPgqzUR/9oQo6xFouq3KBrcJVLV0VWQyaITnYtY=
X-Google-Smtp-Source: AGHT+IHl/QP/4MkKXKeeDQ3sTZsXP8WwsbUCuLz/zjk7+Zz1hCH3vaCNFxlM2mCJu2LmNwVGTmUHP+Lbwm5t+VIOXfessRytRtMc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1807:b0:3e9:e1fd:2fa with SMTP id
 e9e14a558f8ab-3e9e1fd23efmr177757595ab.30.1756186051193; Mon, 25 Aug 2025
 22:27:31 -0700 (PDT)
Date: Mon, 25 Aug 2025 22:27:31 -0700
In-Reply-To: <68a2184c.050a0220.e29e5.0070.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad45c3.050a0220.37038e.00a6.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_withdraw (2)
From: syzbot <syzbot+901524eae72170197041@syzkaller.appspotmail.com>
To: agruenba@redhat.com, anprice@redhat.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b6add54ba618 Merge tag 'pinctrl-v6.17-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174cf862580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7016efe6aaa498c
dashboard link: https://syzkaller.appspot.com/bug?extid=901524eae72170197041
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dc8634580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dc8634580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b6add54b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a6e94bac86a3/vmlinux-b6add54b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c9cbb4d239d/bzImage-b6add54b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/df6a4ddf7d5b/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13dcc462580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+901524eae72170197041@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.s: fatal: invalid metadata block - bh = 19 (type: exp=4, found=1), function = gfs2_meta_buffer, file = fs/gfs2/meta_io.c, line = 499
gfs2: fsid=syz:syz.s: about to withdraw this file system
------------[ cut here ]------------
kernel BUG at fs/gfs2/util.c:331!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5528 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:gfs2_withdraw+0x137b/0x1430 fs/gfs2/util.c:331
Code: ff ff 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c 55 fb ff ff 48 8b 7c 24 18 e8 90 56 25 fe e9 46 fb ff ff e8 06 6a c0 fd 90 <0f> 0b 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c ab fb ff ff 48
RSP: 0018:ffffc90002bff2a0 EFLAGS: 00010293
RAX: ffffffff83ff513a RBX: ffffc90002bff360 RCX: ffff8880003f2440
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc90002bff430 R08: ffff88801fc24253 R09: 1ffff11003f8484a
R10: dffffc0000000000 R11: ffffed1003f8484b R12: dffffc0000000000
R13: 1ffff9200057fe68 R14: 1ffff110066ba015 R15: 0000000000000004
FS:  0000555589e6b500(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa802461000 CR3: 00000000346f0000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 gfs2_metatype_check_ii+0x78/0x90 fs/gfs2/util.c:514
 gfs2_metatype_check_i fs/gfs2/util.h:129 [inline]
 gfs2_meta_buffer+0x25e/0x300 fs/gfs2/meta_io.c:499
 gfs2_meta_inode_buffer fs/gfs2/meta_io.h:70 [inline]
 gfs2_inode_refresh fs/gfs2/glops.c:484 [inline]
 inode_go_instantiate+0xdf/0x1260 fs/gfs2/glops.c:509
 gfs2_instantiate+0x165/0x220 fs/gfs2/glock.c:468
 gfs2_glock_holder_ready fs/gfs2/glock.c:1332 [inline]
 gfs2_glock_wait+0x1d4/0x2a0 fs/gfs2/glock.c:1352
 gfs2_glock_nq_init fs/gfs2/glock.h:248 [inline]
 check_journal_clean+0x11c/0x310 fs/gfs2/util.c:61
 init_journal+0x17f8/0x2260 fs/gfs2/ops_fstype.c:793
 init_inodes+0xdb/0x320 fs/gfs2/ops_fstype.c:851
 gfs2_fill_super+0x1923/0x20d0 fs/gfs2/ops_fstype.c:1253
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1692
 gfs2_get_tree+0x51/0x1e0 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbbb439038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffccc5a4b98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffccc5a4c20 RCX: 00007fbbb439038a
RDX: 0000200000000400 RSI: 0000200000012500 RDI: 00007ffccc5a4be0
RBP: 0000200000000400 R08: 00007ffccc5a4c20 R09: 0000000000200000
R10: 0000000000200000 R11: 0000000000000246 R12: 0000200000012500
R13: 00007ffccc5a4be0 R14: 00000000000125bb R15: 0000200000000f40
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_withdraw+0x137b/0x1430 fs/gfs2/util.c:331
Code: ff ff 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c 55 fb ff ff 48 8b 7c 24 18 e8 90 56 25 fe e9 46 fb ff ff e8 06 6a c0 fd 90 <0f> 0b 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c ab fb ff ff 48
RSP: 0018:ffffc90002bff2a0 EFLAGS: 00010293
RAX: ffffffff83ff513a RBX: ffffc90002bff360 RCX: ffff8880003f2440
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc90002bff430 R08: ffff88801fc24253 R09: 1ffff11003f8484a
R10: dffffc0000000000 R11: ffffed1003f8484b R12: dffffc0000000000
R13: 1ffff9200057fe68 R14: 1ffff110066ba015 R15: 0000000000000004
FS:  0000555589e6b500(0000) GS:ffff88808d210000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc5ba20d000 CR3: 00000000346f0000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

