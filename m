Return-Path: <linux-kernel+bounces-882509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE06C2AA01
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD7B34ED3FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6952E1C56;
	Mon,  3 Nov 2025 08:45:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE02E1F0D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159506; cv=none; b=ci/tRZDc5uTMz/XDg9OjTvgsCm3y3c80bJLkJ/zWRCO3wUiWXs8ad6jSx3OokCZ1RndMeUHSlEipPxqG/+qW0jQdWMlskG9mUnHEhSowwxzwfpAnRpbsEW2ZVutBCOPr8SQ+73pIUw4T+de6Py9w3hTDcFQvsW53ZezxNImixYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159506; c=relaxed/simple;
	bh=4kizDDbfHDFjIip255vHRHrBx+Eu33seHv4iJNcN1hM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Iapw5QYG+ZsxvnksfKpFvnAvbxyS+hXIM7qw8maNhOkHVZDzWIicQADFMkKPexxNM7arnORNwtrwaZ+pkys3xXrwJIsDvgf//uCkzLbjMjVqodEOxXsRIaw8/fLkwfFuYzykyxY+Lcho+7fdscxUC0jJc7bbI6AXGGhx3gts7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43322fcfae7so15069355ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:45:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159504; x=1762764304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+b1oqau84HhEmM3+AbMVAJafBBxOYJa+zwUSherqbw=;
        b=r4dVBf9nYJBTxl8B2Hg8PUcHPAztViiY4cs6BtBiaiIQtR/NHYc7vCzXSSzOn1gXvv
         c33U/FT7FgJvJK2i5w9m+xiWdf/93hflHrTmP0P7ceOm4w27vYubHseVptSGgNC+WEcH
         ehqWaGBVsRMU68NXCaVHfzoyDS4DgZe/tkAS9HRYKwuvnXv0RaWHrOpas74z/KaskRsg
         fZxK5Dm2hBHIx8ZtAYTvjTn2/uqbwZrlve4jyKgiHL4OReVz7LkoZKdX7305cIc/ZAy0
         YEBUWdOxu4GAR8dyGqXs9O4sM/3Vx7je+FPTLNpvi002y2AFcoRbwg2/wIhmRBGq1tRk
         cq4A==
X-Gm-Message-State: AOJu0YzMNOcraH6MYa5WmyTULXz3Nf3hSF4DNMFpnwHGhm82vVhf2OBm
	2cXWwdA6aBNynnt64PPdCCNzayFvcZvHL4EZ3zo6oMGUfFJm/VTcGUcyYu4FMvh52N+3lgfhw/R
	WgQW5HsufDs1G35v30uY0+C9VfbpmkCcfUiWJNxxBQb6hmmFGhe/kvmm+YG8=
X-Google-Smtp-Source: AGHT+IEswicG0SsuxgPH32d5hShhqpiJAZux4CkcdF3gYVzTtKUl5mWjs2Msai8uftc6ZZH7/95S9ftC6hLDDPR9ZCZw2tTE7BFA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:470e:b0:433:22fc:bb9a with SMTP id
 e9e14a558f8ab-43322fcc5d4mr84614165ab.13.1762159504410; Mon, 03 Nov 2025
 00:45:04 -0800 (PST)
Date: Mon, 03 Nov 2025 00:45:04 -0800
In-Reply-To: <20251103082353.294139-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69086b90.050a0220.29fc44.0038.GAE@google.com>
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
EXT4-fs warning (device loop0): ext4_expand_extra_isize_ea:2860: Unable to expand inode 15. Delete some EAs or run e2fsck.
------------[ cut here ]------------
EA inode 11 i_nlink=2
WARNING: CPU: 0 PID: 6567 at fs/ext4/xattr.c:1065 ext4_xattr_inode_update_ref+0x51a/0x5b0 fs/ext4/xattr.c:1063
Modules linked in:
CPU: 0 UID: 0 PID: 6567 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ext4_xattr_inode_update_ref+0x51a/0x5b0 fs/ext4/xattr.c:1063
Code: 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 80 00 00 00 41 8b 17 48 c7 c7 00 9b ff 8a 4c 89 e6 e8 97 9a 03 ff 90 <0f> 0b 90 90 4c 8b 6c 24 28 e9 59 fe ff ff e8 33 f6 40 08 44 89 f9
RSP: 0018:ffffc900015af240 EFLAGS: 00010246
RAX: eaaccfe6fa323400 RBX: 0000000000000001 RCX: ffff88803a701e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900015af330 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101710487b R12: 000000000000000b
R13: ffff8880411b1028 R14: 1ffff110082361eb R15: ffff8880411b0f58
FS:  00007f83656ee6c0(0000) GS:ffff888126df9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3c433ce000 CR3: 000000002b77c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1088 [inline]
 ext4_xattr_inode_dec_ref_all+0x867/0xda0 fs/ext4/xattr.c:1230
 ext4_xattr_delete_inode+0xa4c/0xc10 fs/ext4/xattr.c:2954
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
RIP: 0033:0x7f836608076a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f83656ede68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f83656edef0 RCX: 00007f836608076a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f83656edeb0
RBP: 0000200000000180 R08: 00007f83656edef0 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f83656edeb0 R14: 000000000000046c R15: 0000200000000680
 </TASK>


Tested on:

commit:         6146a0f1 Linux 6.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10062292580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=76916a45d2294b551fd9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c0c532580000


