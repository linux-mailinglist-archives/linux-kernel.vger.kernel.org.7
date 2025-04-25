Return-Path: <linux-kernel+bounces-619346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4ACA9BBBE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 02:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704F14A80C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE6117BBF;
	Fri, 25 Apr 2025 00:20:33 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D22C2FA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540432; cv=none; b=cX/YSwxl0jfRX6Hoq/eetX5Hs0il8rnYJ2oTzzD6Gihu+IWYN4EXDRIGnP5F+1q+//C0IIhgoSS2edGk7dm0wNMw41NI5lDelQHvQ+5HtXQOAWx1is+9CfvFetZk5F7G9sjy8WoQKyPk2obNZghSNpdtP04FWpMlnNnXQAmDiXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540432; c=relaxed/simple;
	bh=IhV9V8da/hlbvjJ5ejoAVOB9Vwae0EAfLQHtuNKEBDk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oGxIHFB2CH6oS0T5V8jw1NZcSUQbmMQXBeL7ihyqnSdRH5iIuNukn6AhCXZdG3pC1V7gn2BD8GMbQwNF3Y3DCQhQRpcnRtaDnxvp3LXwcONbO/L3ikJog9dH97yMpR2auM2ebDL6nVFBt1guyzuEro13ntdLwq5TNCDuDLIujBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d5da4fb5e0so19696245ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 17:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745540430; x=1746145230;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNWk4FjJIk4/cX31UhQJ9RDIJysRwZEcY6Dr8H2oWjM=;
        b=hEM5ShSDjB4VX3PGa+ek7F42dQSJkwrQpvTUDSStVZYh7OmOjKHu7if5OoiTy9CwA0
         4AGFpJr+lOkf2zne2Vxi+0zC8TntG7KjnMJTNjExOOJc7d+a3GqriusIDgGZ3piH3Pe8
         zOpHULvsWa/B3FZ8iQS8adM+kwT2cdEYJ/gbx2U60LOiuyR7YNz+TjTjkNZWOMTCVFHq
         TNxPplpSNpZFDWPS66s1f08QO6LSaBPDhd+VfVX8lg1o1vplOgv4NOZadv2ka3ML82Eo
         PoeM5cUZ3SbiPCDnRxkI2PeYk9yJyKqFcEP6ZbpKFAO2Ee4mpmlFkY03gqcIIF8Oya9v
         qnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHM08qCQ3cZYQkMjj7yrdAhLH8hgQKv809K5iECXwXYQVKTTZEUbrP4nt5CCysJ8+Ngf1j86s4sl+e4gM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn3bTatLpq6EdBts8j4ulQY9iqHW0AkJu1EjSchc24UOHKemkM
	U4gPIKfMufYFXT7wBwuss4Vf9yvod40A59hj/7AkqzUl2XayHfAThiMxYv3rUFHqIikH5ay1KuX
	Lxk9RPugemmMUPpyoFAykE+QA3lwfXaW5mt7HS15cArfaBmtPmV7Yn5o=
X-Google-Smtp-Source: AGHT+IHZPc7+Q2a+lj9DKKziStr4VAFNkn7eUO3PdAucmKBvZs5EfblexTW4EDLD64ZFXj4DOdOeWwtBOoIPI00UlMTy6dBcfYbS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:250c:b0:3d8:2178:5c63 with SMTP id
 e9e14a558f8ab-3d93b39950bmr2963895ab.4.1745540429964; Thu, 24 Apr 2025
 17:20:29 -0700 (PDT)
Date: Thu, 24 Apr 2025 17:20:29 -0700
In-Reply-To: <680001d8.050a0220.5cdb3.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680ad54d.050a0220.2c0118.0c70.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_inode_update_after_write (2)
From: syzbot <syzbot+af878a66b6ed801e9515@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e72e9e693307 Merge tag 'net-6.15-rc4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d62574580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f9c44a22d09fd53
dashboard link: https://syzkaller.appspot.com/bug?extid=af878a66b6ed801e9515
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13de9574580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100fbfcf980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e72e9e69.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2bee8b8591c3/vmlinux-e72e9e69.xz
kernel image: https://storage.googleapis.com/syzbot-assets/97a6564905c3/bzImage-e72e9e69.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f6755d6568aa/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af878a66b6ed801e9515@syzkaller.appspotmail.com

bcachefs (loop0): dirent to missing inode:
  u64s 7 type dirent 4096:189491840996961599:U32_MAX len 0 ver 0: file0 -> 4098 type dir
  
------------[ cut here ]------------
kernel BUG at fs/bcachefs/fs.c:61!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5307 Comm: syz-executor242 Not tainted 6.15.0-rc3-syzkaller-00076-ge72e9e693307 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bch2_inode_update_after_write+0xac0/0xad0 fs/bcachefs/fs.c:61
Code: 48 89 df 49 89 df 48 89 d3 49 89 c6 e8 a9 83 f0 fd 4c 89 f0 4c 8b 74 24 18 48 89 da 4c 89 fb e9 7a fc ff ff e8 71 8e 8e fd 90 <0f> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc9000d4bf940 EFLAGS: 00010293
RAX: ffffffff84313f0f RBX: 1ffff92001a97f34 RCX: ffff888000b68000
RDX: 0000000000000000 RSI: 0000000000001005 RDI: 0000000000001002
RBP: ffffc9000d4bfa70 R08: 0000000000001000 R09: 00000000ffffffff
R10: 0000000000001000 R11: 00000000ffffffff R12: dffffc0000000000
R13: ffff8880119e0000 R14: 0000000000001005 R15: 0000000000001002
FS:  000055558e7f7380(0000) GS:ffff88808d2a3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feb125c0100 CR3: 00000000441b8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bch2_unlink+0x428/0x4c0 fs/bcachefs/fs.c:818
 bch2_unlink+0xb1/0xf0 fs/bcachefs/fs.c:841
 vfs_unlink+0x391/0x650 fs/namei.c:4579
 do_unlinkat+0x350/0x560 fs/namei.c:4643
 __do_sys_unlink fs/namei.c:4689 [inline]
 __se_sys_unlink fs/namei.c:4687 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4687
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feb12543c99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf96100b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007feb12543c99
RDX: 00007feb12543c99 RSI: 0000000000000000 RDI: 0000200000000500
RBP: 0030656c69662f2e R08: 000055558e7f84c0 R09: 000055558e7f84c0
R10: 000055558e7f84c0 R11: 0000000000000246 R12: 00007ffcf96100e0
R13: 00007ffcf9610308 R14: 431bde82d7b634db R15: 00007feb1258c03b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_inode_update_after_write+0xac0/0xad0 fs/bcachefs/fs.c:61
Code: 48 89 df 49 89 df 48 89 d3 49 89 c6 e8 a9 83 f0 fd 4c 89 f0 4c 8b 74 24 18 48 89 da 4c 89 fb e9 7a fc ff ff e8 71 8e 8e fd 90 <0f> 0b 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
RSP: 0018:ffffc9000d4bf940 EFLAGS: 00010293
RAX: ffffffff84313f0f RBX: 1ffff92001a97f34 RCX: ffff888000b68000
RDX: 0000000000000000 RSI: 0000000000001005 RDI: 0000000000001002
RBP: ffffc9000d4bfa70 R08: 0000000000001000 R09: 00000000ffffffff
R10: 0000000000001000 R11: 00000000ffffffff R12: dffffc0000000000
R13: ffff8880119e0000 R14: 0000000000001005 R15: 0000000000001002
FS:  000055558e7f7380(0000) GS:ffff88808d2a3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feb125c0100 CR3: 00000000441b8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

