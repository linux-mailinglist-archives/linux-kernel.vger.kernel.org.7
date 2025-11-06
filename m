Return-Path: <linux-kernel+bounces-887957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B61C3971A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD29019E01DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B252882D7;
	Thu,  6 Nov 2025 07:47:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C85B1DDC1D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415230; cv=none; b=KQRXM6pw30kxR1Ob7dghjErRo31CYvjrSN7Ro0yj1SVpsOgdI7aGE2k0CWHb2zO++clzTDPNi53EBgNerLG5GAxGVR+UCyXArx9+1ZZ21L29t/fGKIILrn2Q/BmCizwpf4n81cypl/AoiI3movzrvCtMauuCzrC10grZCDGQ6Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415230; c=relaxed/simple;
	bh=3IaofT5U/bZkMf0viMkYv5ezQzW2qDfkr/NnpJgsaS0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iyfHlEg+44qPog7BMZ5wgn2mWcFE/bp9A2q5xE+SncqwYgWzhXb0xRq+V59aoerL6wCJ5PWBMQpefYf4CQcQmjqAcE0+Dza+DMh3an19LMAlltGkyHzl1xkD5oBPPFFonxl2LSXzhkdf7jKV+TfUknzLFpqRx6ChO0M+7PAl1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9484c2ac07cso5506439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 23:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415224; x=1763020024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJcodqgnYvKB3G136kgRVz5eRTS7MhJJJz1SlDRIH3g=;
        b=IYorSrYKUxF/mqAl9MzCLTd96kIon3E1NK6euc3W4J4PS68TCC9Xk6vBW0+A0/JVw3
         v2bfJxd4MfBBQrletQBKO9fKNPse2Z8nPZC0PQ9VNkC4QPSGcaSnJmiPXGEBWnzaTIZL
         Sct0NjsWWT4CTZ9Mui78fzhkqH8NSQFK/ddBPi5F2rhglzvjpC25/yPNZ9wULLWBlu2C
         CE+a3xpHB6vmpKwc+tvy/M2Sivs4oR0T+3yQ/+5MvdmWOt++JOHCkm0GQdZIEX+bWicy
         wkD0rT1CVBvgMhA0TMBQjLFRpAQS755w1mqCR2NCNPVQDiwMm4gSd1T92bDXDcsNlp6Z
         btxA==
X-Gm-Message-State: AOJu0YxkeWiqgeV4pH3jfWAqPp3hQfvZMWfiWtNXtFcL2h1ATK46MIec
	yz9h8yOAqsS9TsbnhKYPMrM+pE2wTZD0i8Uxa+iFsVoy92rCYS5HjHobfC209DM8erDYnXSjvNL
	5/WuSIAXAnv95emfgr1F1EHYsCBaXEMexGva+3SRWEsaVv/89rsSv1X4Kfew=
X-Google-Smtp-Source: AGHT+IEAvlWMQv/wtaVNm1LsYZkNy9DK1d3sfZW3aieu1ym+7jGiD2a1GSjSoXjsHGgndKd5/3gny0IcGt6oWB1aMo+cdVWhOnVS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:433:3102:b0f5 with SMTP id
 e9e14a558f8ab-433407d4fc6mr82967065ab.30.1762415224609; Wed, 05 Nov 2025
 23:47:04 -0800 (PST)
Date: Wed, 05 Nov 2025 23:47:04 -0800
In-Reply-To: <20251106072648.2607754-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c5278.050a0220.1e8caa.00b8.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref (2)
From: syzbot <syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ext4_xattr_inode_update_ref

loop0: detected capacity change from 0 to 512
EXT4-fs warning (device loop0): ext4_xattr_inode_get:546: inode #11: comm syz.0.17: ea_inode file size=0 entry size=6
EXT4-fs warning (device loop0): ext4_expand_extra_isize_ea:2853: Unable to expand inode 15. Delete some EAs or run e2fsck.
------------[ cut here ]------------
EA inode 11 i_nlink=2
WARNING: CPU: 0 PID: 6694 at fs/ext4/xattr.c:1058 ext4_xattr_inode_update_ref+0x51a/0x5b0 fs/ext4/xattr.c:1056
Modules linked in:
CPU: 0 UID: 0 PID: 6694 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ext4_xattr_inode_update_ref+0x51a/0x5b0 fs/ext4/xattr.c:1056
Code: 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 80 00 00 00 41 8b 17 48 c7 c7 00 9b ff 8a 4c 89 e6 e8 97 9a 03 ff 90 <0f> 0b 90 90 4c 8b 6c 24 28 e9 59 fe ff ff e8 33 f6 40 08 44 89 f9
RSP: 0018:ffffc90003a4f240 EFLAGS: 00010246
RAX: 9784c33726edfd00 RBX: 0000000000000001 RCX: ffff888020bb8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003a4f330 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101710487b R12: 000000000000000b
R13: ffff888059283f88 R14: 1ffff1100b2507d7 R15: ffff888059283eb8
FS:  00007f0477f2e6c0(0000) GS:ffff888126df9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7f5e2ee440 CR3: 0000000028ad6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1081 [inline]
 ext4_xattr_inode_dec_ref_all+0x867/0xda0 fs/ext4/xattr.c:1223
 ext4_xattr_delete_inode+0xa4c/0xc10 fs/ext4/xattr.c:2947
 ext4_evict_inode+0xac9/0xee0 fs/ext4/inode.c:271
 evict+0x504/0x9c0 fs/inode.c:810
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:470
 __ext4_fill_super fs/ext4/super.c:5617 [inline]
 ext4_fill_super+0x593b/0x61f0 fs/ext4/super.c:5736
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04788c076a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0477f2de68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0477f2def0 RCX: 00007f04788c076a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f0477f2deb0
RBP: 0000200000000180 R08: 00007f0477f2def0 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f0477f2deb0 R14: 000000000000046c R15: 0000200000000680
 </TASK>


Tested on:

commit:         dc77806c Merge tag 'rust-fixes-6.18' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b64a92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=76916a45d2294b551fd9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1731617c580000


