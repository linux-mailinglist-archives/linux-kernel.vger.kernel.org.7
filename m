Return-Path: <linux-kernel+bounces-882462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F44C2A84A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68A8E4E1D60
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344472D94A2;
	Mon,  3 Nov 2025 08:15:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022572D879C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157706; cv=none; b=Zkzk+PrNEeu/3Xi+HQswHygKuShwV/26mDU8tg0rXgmy5uv6cRr4X4b8nJ1dsSPxjg6IM+HSmQjmVZkoJCtfWERdN/3pAE3PxxuGb6Pvvr8ItjyBEGUwXr3j9nEGYEBIQGnN+waICbTHQdAHamau7d6i8CQWu+Mp2ke335zgSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157706; c=relaxed/simple;
	bh=bZEA471zCgAF4gjsMtkrrk90WpX3fVKd8IdRRUTzAh0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P7QQhLDyczVbWa8hWmbghuAD7ekF4wf3kVAbtoDt/1X5AL8Sk84AaHiAeF+aWhKmWBeBMllhtAqQHlpddsWBEG4uOsSNF3e8aygQ4K2fVuHE9r6F47Vv3E4LrGLarchuim2cQM6sEyKjtQrz8IRGVqDN4PB7tnNNsGggBC7EvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-432f8352633so120709585ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762157704; x=1762762504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7Mp2x/t1WVI7p41xyEH55Yf/RBW+4oZEe83BuIzBQQ=;
        b=q502gA5Ct9TBHmOimRm99Gi2SgyV0UbACjWevaHibtez/jzhHBMFyr8zxsJs7IvakI
         3iPTycbT8yHDic2aJvVYhhzgAqvGmZFmbhB5+7zTeKIkAZHkcF4EnuPidS9y4UU+ZMOe
         1hbnQmweNrugAhQXCp+ryje7fhDuyz4wvDN/E2ZARZpeCQ6RVxi8fNzy+03OhO8FQoXM
         NIC2tILLdDxVDA5YVK7YW8Qhz6ohPsQfOoXQ4zCODoHJtedwPmoA/5dwd99MXc0ZaH8D
         oACzL/R0xJEK5ADWIG4wVMqJ+Sxp8dCe1uC/ddEibVLV0zoXUooBoinwvdaXt3/LIHQx
         Qb7Q==
X-Gm-Message-State: AOJu0YwRXkaIcyMz+vQqyMGik0j87V1jnTcWGTS5jbwJ0+hpY3YBWDEN
	4LsFieqn4Mzb2agEYJKaMeG70CwmxHsgBiSHDF1S4XE8u3NIRRXZQ3pUjRwSKXZYOflAU6n+3n+
	W9T2Tmawun6+r8FLQE4feE2l6dmT8Ejx+8TJ3wdG2gCuwnsXf6APLnjGFC98=
X-Google-Smtp-Source: AGHT+IFIdXg7yMlW4FDL5eXNwhLrMgPxT2qi5aoAdLT3SCzQVZASL7wBbZ91VS8AhtymN9NGSEJjW66LLj+H/frccFbzBemRZppA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:97:b0:430:cf18:e1e5 with SMTP id
 e9e14a558f8ab-4330d206074mr170832085ab.31.1762157704179; Mon, 03 Nov 2025
 00:15:04 -0800 (PST)
Date: Mon, 03 Nov 2025 00:15:04 -0800
In-Reply-To: <20251103074641.4160652-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69086488.050a0220.29fc44.0036.GAE@google.com>
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
WARNING: CPU: 0 PID: 6571 at fs/ext4/xattr.c:1065 ext4_xattr_inode_update_ref+0x51a/0x5b0 fs/ext4/xattr.c:1063
Modules linked in:
CPU: 0 UID: 0 PID: 6571 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ext4_xattr_inode_update_ref+0x51a/0x5b0 fs/ext4/xattr.c:1063
Code: 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 80 00 00 00 41 8b 17 48 c7 c7 00 9b ff 8a 4c 89 e6 e8 97 9a 03 ff 90 <0f> 0b 90 90 4c 8b 6c 24 28 e9 59 fe ff ff e8 33 f6 40 08 44 89 f9
RSP: 0018:ffffc90004067240 EFLAGS: 00010246
RAX: 07a0f86583ac9f00 RBX: 0000000000000001 RCX: ffff888026411e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004067330 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101710487b R12: 000000000000000b
R13: ffff8880412ca7d8 R14: 1ffff110082594e1 R15: ffff8880412ca708
FS:  00007f06408966c0(0000) GS:ffff888126df9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f186f706000 CR3: 0000000053790000 CR4: 00000000003526f0
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
RIP: 0033:0x7f064123076a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0640895e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0640895ef0 RCX: 00007f064123076a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f0640895eb0
RBP: 0000200000000180 R08: 00007f0640895ef0 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f0640895eb0 R14: 000000000000046c R15: 0000200000000680
 </TASK>


Tested on:

commit:         6146a0f1 Linux 6.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10037932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=76916a45d2294b551fd9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11386012580000


