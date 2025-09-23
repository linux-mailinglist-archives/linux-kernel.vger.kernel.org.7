Return-Path: <linux-kernel+bounces-828406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F0B948F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E187A49C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91C530F7E9;
	Tue, 23 Sep 2025 06:29:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4230F54A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608946; cv=none; b=FqD7QhmLaficnATF9kPFG9WsnBhyvdxeCWjWHzFMeV/f/N5esPNxUmZhSNTLRvTweHjUGAIZZoWuvJkPzaEg2GKaPcnQFZ5wbDUK9Zz6giil6AQY1Wrzx8xlgpi7DHvrqpj/9fpRstrGDw9mSjBPI1NpmIltZy9wKN9KMYGG9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608946; c=relaxed/simple;
	bh=dqRJvwf0AulXjKjEtFGCKDyTIrRWQfc5ipJSKyWGAPg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gLUq0qOibZdmLwYcgB9Ac2d0SkGs3lJ4vir0Lcoe5UCPdFTWzqHtuuAyTmsrHnKmQR4hXSK3fYQt5Nu7apOqBlYGR+D+nnXXnuZm+Sm0UGEuX9Jp2FcEflIOv1UIzzRnV6Oino4Qi7WOhpvdCL7jgqs/rVCGmt9kwZA5R5rz670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-893658a9aceso583815839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758608944; x=1759213744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87ALTYy1lLwUMAX2/apQoa4puSzp0dc6zJ4UcKrWGgY=;
        b=sUwG/Op/hDgtBH9SaqsToXPBVTyIAYbLnuAdTUgWTyGtbAavD5sWcIXPwg9GXDlcAM
         SMgkcjJAj+Fc/1b0bc9rynaXdir4WnFNpu32hnUV3bVuDP3eLCdSl7ONGyJbb/tlH90P
         UQuW/dRf0gO7FxxEmzpzkDf4wjdR5xyhbq3e1REhda7FbxYW5Hho3vcWoR7O2dk6SBOC
         D90hgzRzMSt54PAmhdr5wU9zvZlNmWcYDQBoXKEC186Yu75VuEts72aAlXg3bKBqBEx8
         z/j5MiyCEZcQmJxbQqtCslSyBsmtFxy8GppyXA9akG/vHGhW2vdENpWRo/4tq7tF0SC7
         j0yA==
X-Forwarded-Encrypted: i=1; AJvYcCUJaMLMg/YZs0lq42n23LWtLSKZcOSkStLUG7rC7EcFda6Wee2q2BvHJva5QmCS16rJzp2Txw4Z0X9mnWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzX+Zm9/tCEYT48IEEU6N7MJCXzpfkJTGlmT9fVYV1fSGNmZfF
	7dPiX9v7kvHGN9vlwQocZjfnVQIi3WZ6jNI5YAv1+rG6cB7gnWJ5CHmbvsX3vpXJgnUs5dk3As1
	gFTYILX4FMBhyQO85HXJhkbwn+RnhPjiIsJah19uvfQedrJhEZSz05wl/akE=
X-Google-Smtp-Source: AGHT+IG50VVMj+8Vd1q2ninsFgFbfy58icuZLWh+TF9ytzSukshOM1cSvqRuVjuxItteeEyrHFRpPbeTvHWDLElz5QKSggOH5jnE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:140c:b0:8de:f891:eecb with SMTP id
 ca18e2360f4ac-8e2179368dbmr242478639f.12.1758608943863; Mon, 22 Sep 2025
 23:29:03 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:29:03 -0700
In-Reply-To: <20250923061138.1081531-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d23e2f.a70a0220.1b52b.0053.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_block_set (3)
From: syzbot <syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ext4_xattr_block_set

loop0: detected capacity change from 0 to 512
EXT4-fs (loop0): orphan cleanup on readonly fs
------------[ cut here ]-[  169.204299][ T6620] ------------[ cut here ]------------
WARNING: CPU: 0 PID: 6620 at fs/ext4/xattr.c:1906 ext4_xattr_block_set+0x25b5/0x2ac0 fs/ext4/xattr.c:1906
Modules linked in:
CPU: 0 UID: 0 PID: 6620 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_xattr_block_set+0x25b5/0x2ac0 fs/ext4/xattr.c:1906
Code: 00 00 00 e8 fd 6f a2 ff f0 80 63 28 fd eb 28 e8 c1 26 43 ff 31 db 48 c7 44 24 20 00 00 00 00 e9 88 f1 ff ff e8 ac 26 43 ff 90 <0f> 0b 90 e9 0e dc ff ff e8 9e 26 43 ff 48 8b 5c 24 10 4c 8b 74 24
RSP: 0018:ffffc9000403f220 EFLAGS: 00010293
RAX: ffffffff827b4794 RBX: ffffc9000403f548 RCX: ffff88802f6f3b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000403f408 R08: 0000000000000000 R09: 0000000000000000
R10: ffff88803f7fd400 R11: ffff88803f7fd000 R12: 0000000000000000
R13: 1ffff92000807eaa R14: 1ffff92000807ea9 R15: ffffc9000403f550
FS:  00007f2f4637e6c0(0000) GS:ffff8881268bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1a8a1c1000 CR3: 000000003b234000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
 ext4_expand_extra_isize_ea+0x12d5/0x1ea0 fs/ext4/xattr.c:2822
 __ext4_expand_extra_isize+0x35b/0x470 fs/ext4/inode.c:6394
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6437 [inline]
 __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6515
 ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
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
RIP: 0033:0x7f2f46d1066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f4637de68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2f4637def0 RCX: 00007f2f46d1066a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f2f4637deb0
RBP: 0000200000000180 R08: 00007f2f4637def0 R09: 000000000080078b
R10: 000000000080078b R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f2f4637deb0 R14: 0000000000000473 R15: 0000200000000680
 </TASK>


Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1397f712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e518e2580000


