Return-Path: <linux-kernel+bounces-828166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4FBB9417B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BE73A77CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8521D3F3;
	Tue, 23 Sep 2025 03:22:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48543595C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597725; cv=none; b=VfYPLm9l1lmWrs2zdecNeqcKs72rqNV2Bg5NctyUhVwn49wO6zWKqRIPKAtCHbdUMVxHxwQGze1hD9/Nfczy3JdrD5Flt2ltsTnwQFviDdD07r59uZ7jNH+5oy7HMx6/LEXP1F8G7yro4qqYb6yM8XHXKlQa1zKU0BBoPRF7GQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597725; c=relaxed/simple;
	bh=562gofSO8JsUWnNqzH/LImZFB3rhtQOXqW6SuWpxnU0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OJ763J8WVD/LRR481h/ST3jwsKz4hxJt24xRerj6nazol+pK1QNevPAf8TKMkmFvoHPs5srJ43VciOcyAVD0QbhOBWWw6Azo4ou9oisyaMK9louS2szk0bIAOCTwxdrTQcj4CEqfhOw0wtvy1QREFd7le/OqEWHD6fFiBphg1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8876712ea4bso1102820539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758597723; x=1759202523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ox6EvNLyJyPKx54slj4FEz3fRATYFaBpRy4l3lbc2EE=;
        b=f11MfPPumSFdQlPlMXuG0gK/cNNsNDlWoSdie6zVWC0Q5sTCNUI90EWAB+Xkt6C2XI
         tifipbZ5IxeRfhMl6NHXvK+bJ7wsHbMjzkpHqdLj7wuzckpD2yTnkf45CpHe7WUqWMaS
         +Jf92DGCWVVjq6fmJQExGJ7oM2S+gc57lcXy25WbPG+K0n6LCYwRed3CbFGLY+bXstE1
         K+F8WuoYU4C8yXFZnXOzyBUnJ6x1/4KV5gQ/iOGkgwYy5T3awPafHhni6R2VkFiUihaV
         QihvFOWdIK96fAO2AR4XQuwWbiQEe/rCjTHud26zABtp1K5L5e3FzO+GeCfAGGLY+Ne6
         ILKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYPhIfrk4C7D0kcYdM7GVhszqKJZRH1Bk17WAJZXWEsE5ekt4PXLJAAsLBpJOelaiQ2BOCnU5BnRTqAAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUg6pFRh4vaL1mkSMGZr+c2fDFYQtOEsZ5MCCbI4OKJDqT34hF
	ZXoyUGTZiyAlIYKOPJmEQqYEAeD2yA92pNstv7PM5YytFD4pY2Ax0U/eE9lNRsxDfa8JFMgJ+b7
	8IxqEvUzIqRURfz3ndu7JEXx/cgwnh1yMB9JAgMVDmUMe6paf1IG6zSZIgQo=
X-Google-Smtp-Source: AGHT+IHqzatwtYsEBO8Eaeeoh+WHCV957e8iWVbccyF0lez1ElO0d0eUocOjn8bPJOHQeuhwK87krV+oClH3ZO24oExin0SVzuVh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d2:b0:88c:34c1:810e with SMTP id
 ca18e2360f4ac-8e21393448fmr203545539f.14.1758597722971; Mon, 22 Sep 2025
 20:22:02 -0700 (PDT)
Date: Mon, 22 Sep 2025 20:22:02 -0700
In-Reply-To: <20250923023148.1074924-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2125a.a70a0220.1b52b.0029.GAE@google.com>
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
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6732 at fs/ext4/xattr.c:1906 ext4_xattr_block_set+0x25b5/0x2ac0 fs/ext4/xattr.c:1906
Modules linked in:
CPU: 0 UID: 0 PID: 6732 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_xattr_block_set+0x25b5/0x2ac0 fs/ext4/xattr.c:1906
Code: 00 00 00 e8 ed 6f a2 ff f0 80 63 28 fd eb 28 e8 b1 26 43 ff 31 db 48 c7 44 24 20 00 00 00 00 e9 88 f1 ff ff e8 9c 26 43 ff 90 <0f> 0b 90 e9 0e dc ff ff e8 8e 26 43 ff 48 8b 5c 24 10 4c 8b 74 24
RSP: 0018:ffffc900046d7200 EFLAGS: 00010293
RAX: ffffffff827b47a4 RBX: ffffc900046d7540 RCX: ffff88802d373b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900046d7400 R08: 0000000000000000 R09: 0000000000000000
R10: ffff8880518b6400 R11: ffff8880518b6000 R12: 0000000000000000
R13: 1ffff920008daea9 R14: 1ffff920008daea8 R15: ffffc900046d7548
FS:  00007f40f60f66c0(0000) GS:ffff8881268bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7af07de000 CR3: 0000000033526000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
 ext4_expand_extra_isize_ea+0x12d5/0x1ea0 fs/ext4/xattr.c:2822
 __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6385
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6430 [inline]
 __ext4_mark_inode_dirty+0x4f3/0x780 fs/ext4/inode.c:6508
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
RIP: 0033:0x7f40f6a9034a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f40f60f5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f40f60f5ef0 RCX: 00007f40f6a9034a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f40f60f5eb0
RBP: 0000200000000180 R08: 00007f40f60f5ef0 R09: 000000000080078b
R10: 000000000080078b R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f40f60f5eb0 R14: 0000000000000473 R15: 0000200000000680
 </TASK>


Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1485f712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b4c27c580000


