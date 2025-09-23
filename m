Return-Path: <linux-kernel+bounces-828364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC1FB9476B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4153F1900F46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAEA224F6;
	Tue, 23 Sep 2025 05:43:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB340AD5A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606185; cv=none; b=opJ1XXp840Z6WXr99GMAp4DlJSjif2rj4Zf7y6+oYL6V3txQsMyWcoaAyxVBiqk2LtMBDJ5af4Xhuc3vSPnPetJhy6orwPKAtdjL8qo2g3AVo6UOy+B9yrjsKEOVNIk1lpC0KWiDLJ5vz+dkpZ28YSjGzL0PTjmwLwZjS8rAeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606185; c=relaxed/simple;
	bh=z7x/tFGNtaGgH89roWnngettAnUco9UW8c7L028VWb0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZNYh1gA2HOvOpn8bMrLJpZt2GjH7A3z5S5midvxWj1YbjfltjV+2FO0fVmQWzhBpe+PnZ+zF2r9E6PrHvy+RRh+1EKywf8rARsymlKgqTNG//3NTtIWl6XdKWVOIYXnFuG7dNKdqq1NRzZHf2nosofAt55BFaV5+ut1iJuLmGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-424861a90dfso39548695ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758606183; x=1759210983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0A2VTgG6GeJq5FeUHIcpEVZPFfTheY53QZnJb/dLnU=;
        b=wFHkzvG/EIlLLRPHf+OPYyJlAFHuwoj+bdKnHYnaFJfB4sQ48MbKclalQOrgIgFfG+
         kLtD2tzdXjciSigXAIUCe0ySJilU+MTrutspGjz/6S4BhLE5b9XO8hXGe+K8jZwORlai
         +KfZRPXewPSDw//9PUFQ4RYA4JmIvi5ug1ixT/rjBAJEno5T0uwaPlcBCfqNQAU9si96
         IQfQShqFxPzn9yt3Eq02zmiGdE8KHxdyp5tmGg5/4zo8ukICGccmkSuwUp3+KwiJVxcV
         enIbl74P15WgtxW6fLeM1KqGbtYNWj4y4WwGapjirEZpoP3gbhWZxCGBD/56NfCJjbHf
         7cFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXeA/XeLaWt6P2W6OghctONcGdYub2CPfhRct6B/HHiR7F9tusxKovtt3x3LxZBeeEyFA2yoM7nKYaVzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4ROyQqwOqQO30o6yiIRHx53LCstBkNcpiptImeCyKjZk5loc
	K6CUTbJtW5uG8Y/F8ur4eguE9GAzW06RneTQ5EYBFJdi8lmTH0gW+vx48yy/zdRgNOfTXeRIrpb
	a6LxRfvFvrve/0mmmTFPxVEKfgSQLvfwwXQ+I4gxHQ3cCbJ7qzFoOs3RKZMo=
X-Google-Smtp-Source: AGHT+IHV0/4TQ9/vqxJ+zdLCDlwqsiozyyxWnaY4+yb+DkcDmgX/3TkK37YHfXdV1BQ3BRy6L4wLsJR3TKZHRrBeq5zu5QoGjWRG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:424:7633:9e72 with SMTP id
 e9e14a558f8ab-42581eb0215mr21810565ab.30.1758606183152; Mon, 22 Sep 2025
 22:43:03 -0700 (PDT)
Date: Mon, 22 Sep 2025 22:43:03 -0700
In-Reply-To: <20250923050202.1078052-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d23367.a70a0220.1b52b.0050.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_block_set (3)
From: syzbot <syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in ext4_xattr_block_set

loop0: detected capacity change from 0 to 512
EXT4-fs (loop0): orphan cleanup on readonly fs
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6741 at fs/ext4/xattr.c:1906 ext4_xattr_block_set+0x25b5/0x2ac0 fs/ext4/xattr.c:1906
Modules linked in:
CPU: 0 UID: 0 PID: 6741 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_xattr_block_set+0x25b5/0x2ac0 fs/ext4/xattr.c:1906
Code: 00 00 00 e8 8d 6f a2 ff f0 80 63 28 fd eb 28 e8 51 26 43 ff 31 db 48 c7 44 24 20 00 00 00 00 e9 88 f1 ff ff e8 3c 26 43 ff 90 <0f> 0b 90 e9 0e dc ff ff e8 2e 26 43 ff 48 8b 5c 24 10 4c 8b 74 24
RSP: 0018:ffffc90003a8f220 EFLAGS: 00010293
RAX: ffffffff827b4804 RBX: ffffc90003a8f548 RCX: ffff888028990000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003a8f408 R08: 0000000000000000 R09: 0000000000000000
R10: ffff888048888400 R11: ffff888048888000 R12: 0000000000000000
R13: 1ffff92000751eaa R14: 1ffff92000751ea9 R15: ffffc90003a8f550
FS:  00007f9e5efd66c0(0000) GS:ffff8881268bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1005681000 CR3: 000000002f6d2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
 ext4_expand_extra_isize_ea+0x12d5/0x1ea0 fs/ext4/xattr.c:2822
 __ext4_expand_extra_isize+0x365/0x460 fs/ext4/inode.c:6386
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6431 [inline]
 __ext4_mark_inode_dirty+0x4f3/0x780 fs/ext4/inode.c:6509
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
RIP: 0033:0x7f9e5f97066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e5efd5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f9e5efd5ef0 RCX: 00007f9e5f97066a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f9e5efd5eb0
RBP: 0000200000000180 R08: 00007f9e5efd5ef0 R09: 000000000080078b
R10: 000000000080078b R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f9e5efd5eb0 R14: 0000000000000473 R15: 0000200000000680
 </TASK>


Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126bf712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179118e2580000


