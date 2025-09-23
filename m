Return-Path: <linux-kernel+bounces-828647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DB2B9516A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59AC1904C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D16431E10C;
	Tue, 23 Sep 2025 08:55:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C931E0E3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617705; cv=none; b=W03o6cBVmO6GP5JfMZsWRMbJAlrX+Ti3GuMKPK7tfhG8zKCS6RhTDb3zk7+BBHHxiCwNKO1aQXPkuNjSRHrdWsFHKOH5sEboGC53JoihHAyiRSwatrbrLci+xQUTImZEL1mXdbtOI8pogoQMMwR6D5eRENFOZ7TRb5qqeXRCjvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617705; c=relaxed/simple;
	bh=DXQlJowcRFBZPhluBPiC1Zrx/U49JyzVn+5m9VxoX+4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N2xRs3rAFLMZT5e4Cb2YJWOGuOTbL6rwXDWAHXcjxqMG8YUN/ZkfUMGDsAt9RV1jQDPnp1bjS5Iaee2YivGCx3nbyJUTsYbYFhWH3iw7pZ0MiCQAaijutz5yLfbtBA57I+YLXOB3mGYaMP5d/nfUvemc1OEDPzrrlJmZ0MWWPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8df2aa81574so104912839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617702; x=1759222502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjoZQqw6CRZesjFTMqUfi5tAwGxISXqHyO5s/obJZWA=;
        b=kFszPlS1jWEWoqf8wmI1twBj9azm+R5ZKEuZFxRaPlGdGkOF3S9sG2cwbKaHnm9eex
         Xxrd1uqXa3FyhGhgHIN1tn9kcfTpI6eIh8PZ8fA3COaThmcmZClTzYr3wPhbvD62zMJ2
         jRfSdM6UBhPSGZuQZ9Hh0nBYXCCmFfNbrFCk6+hpGpNQam6V3hUbdZYJ+kMHmhznkP1J
         OPPKy1G2YT5qU+3Vpkvc7MN2K2T80CAV6N3wWxp6q7yD82nWLH2uW3/K3LPwd0nrofw2
         qNLo2i839pEo7VgG+k03knuXInVA6gijeFepQxghrlNPjg+vuOTxTJiYAkpFUeIZUla7
         Q9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnJWOAt958qF6+9E6D5QA9hTA3LYM9oUdCkTkc6GoZCVpzVwE7zmuiRsaaSEpH4W984otL+k1engo9Ukw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOXL/p/pOPZhcl9PkJoBMCxYTtqxXy7joUVY6xS8lA+Z+8WQh
	UZewinktAx3ZwgRLcTXXSp5Bl3WgLf8//l165S7agkh9vCX72wb44d/TlDkUOL4qmKUHebIHHKa
	mIhjQZvjqE2SIZ9ceQA06KwGzFQTDD/hu2YFYHGriiMXuJawRmIKJi6rU3Qg=
X-Google-Smtp-Source: AGHT+IFpBgMHseKozChNY0XMytOE9lxBERX10w7/i5gGoIF/y1MPiqBX80/S8wWyTBtFcCeH68/hy16sqcPUhnJ8jZXBXh/kcRhM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:8992:0:b0:887:45ad:fcc6 with SMTP id
 ca18e2360f4ac-8e202540344mr289049339f.15.1758617702389; Tue, 23 Sep 2025
 01:55:02 -0700 (PDT)
Date: Tue, 23 Sep 2025 01:55:02 -0700
In-Reply-To: <20250923083522.1086124-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d26066.050a0220.139b6.0025.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_block_set (3)
From: syzbot <syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ext4_xattr_inode_update_ref

loop0: detected capacity change from 0 to 512
EXT4-fs (loop0): orphan cleanup on readonly fs
EXT4-fs warning (device loop0): ext4_expand_extra_isize_ea:2851: Unable to expand inode 15. Delete some EAs or run e2fsck.
------------[ cut here ]------------
EA inode 11 i_nlink=2
WARNING: CPU: 1 PID: 6503 at fs/ext4/xattr.c:1053 ext4_xattr_inode_update_ref+0x534/0x5d0 fs/ext4/xattr.c:1051
Modules linked in:
CPU: 1 UID: 0 PID: 6503 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_xattr_inode_update_ref+0x534/0x5d0 fs/ext4/xattr.c:1051
Code: 00 00 00 00 00 fc ff df 41 0f b6 44 05 00 84 c0 0f 85 86 00 00 00 41 8b 14 24 48 c7 c7 e0 70 1f 8b 4c 89 fe e8 ed 87 07 ff 90 <0f> 0b 90 90 48 bb 00 00 00 00 00 fc ff df e9 bb fd ff ff e8 74 59
RSP: 0018:ffffc900042af2e0 EFLAGS: 00010246
RAX: ce552e21466e5d00 RBX: dffffc0000000000 RCX: ffff88802f2e8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900042af3d0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124863 R12: ffff888057ec8f58
R13: 1ffff1100afd91eb R14: 00000000ffffffff R15: 000000000000000b
FS:  00007f61d52b66c0(0000) GS:ffff8881269bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0c2b6a1000 CR3: 0000000025d4e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1076 [inline]
 ext4_xattr_inode_dec_ref_all+0x867/0xda0 fs/ext4/xattr.c:1218
 ext4_xattr_delete_inode+0xa4c/0xc10 fs/ext4/xattr.c:2945
 ext4_evict_inode+0xac9/0xee0 fs/ext4/inode.c:271
 evict+0x501/0x9c0 fs/inode.c:810
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5609 [inline]
 ext4_fill_super+0x57fa/0x60b0 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x40b/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f61d5c5066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f61d52b5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f61d52b5ef0 RCX: 00007f61d5c5066a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f61d52b5eb0
RBP: 0000200000000180 R08: 00007f61d52b5ef0 R09: 000000000080078b
R10: 000000000080078b R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f61d52b5eb0 R14: 0000000000000473 R15: 0000200000000680
 </TASK>


Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fd04e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132d04e2580000


