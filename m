Return-Path: <linux-kernel+bounces-893103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF3C4689E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5331E1886BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22FB30DD35;
	Mon, 10 Nov 2025 12:12:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F130214B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776724; cv=none; b=m71YbA+Ib93v+GByfUWWIoMkk5SBaNFsxxlL/5H/7pSdPTNM+bo/xKJyWnKOHQdvvlCsaV8zRrm2lwBAwHk8LYMkzWCbfFiT8Bu/CnFmHeo30VGhd0qVa3hVgg4YeHvuUWELlAlKN6dlzq18yeAypTxD1WcklIyIOzktu9caaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776724; c=relaxed/simple;
	bh=kGGSG8exyRIv+H/CZk5d7bgGJFQ1KT2GYaSG3fbMzEc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mv2A3GIE7gqB/NmKUbMdBUx72THBaOO5skv1/P4goXiOjRU4SH9mkvFD9e5M6a89esN9GRzs83s+7N8Ny2vINi04L/dBjm/WIpSSuUa2dkd5kBUJMvmDhRgzxdCMJ8+SE1gkiP76ANnvvYCQToLPsg2D2axCrbhEaI0GxJ/JL58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9486ebd1e4dso275264839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776722; x=1763381522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/AjLwdw2hcC2DY1nsTE8RvHzb5JV5jTVMSoB5vTOxA=;
        b=vwKLgFxBd8aHIjpHC3dL3gqGA1qK6OfZk7RtHw5Mtn6oZOHF1AM/ObWo0buVkX7Chi
         X4b6x6w3M2GUkYt6zIKmptyI4Z7Wr0CPxGTPFk0Fe9BQ4S50bSdS5ybM6117A2u5rdQx
         YnK3cT58fzVRO1lbhNoMTcSet5XGzTOy+rkd2cN3GyyOP80pMBNjJCMgNB1B5g6ZUKdZ
         bjJIYU0vzKgL6VEpM3F7TvzCh9+vYvxA5TR7qDbzanX5g8IHRV5V3lHCQVr25m6zcY8M
         oi8DEQ2CKrBK3IS4HNsamac0iUrAuNqWF++SoV2iQGJd8MyWMONR4GI6wtx5C9gRmU4k
         ciBw==
X-Gm-Message-State: AOJu0Yzs02Vzme2UOQ8e/xmRw6aArNXt+WZQIAEM0oheKfRcUjH9Wr6H
	dukZOO5EzkmtDw4LPng0OqI9h4L/SICBcJpk+TAXodqAA+F5cB6XyAjrX+zd92USfQwOBaruudj
	hcCrfarISJwPgLxuXpvKjwLqxjDZHjwhJLKdfnXMcCseVhV+09zwQ23CHRiU=
X-Google-Smtp-Source: AGHT+IFbUnaSfLcxgZk0G/4OSd8ar3FSatThyNWZTmatKCeL/jNUsRTikBHCFQdZyD87q3nsHB4M1cvCPoxm9X4+soiCZduttlPB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29d2:b0:940:d7cb:139a with SMTP id
 ca18e2360f4ac-94895fca436mr1186275939f.7.1762776722180; Mon, 10 Nov 2025
 04:12:02 -0800 (PST)
Date: Mon, 10 Nov 2025 04:12:02 -0800
In-Reply-To: <bf35b502-ca85-41a4-b47b-c3ae63155257@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911d692.a70a0220.22f260.00ea.GAE@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in dtInsertEntry

loop0: detected capacity change from 0 to 32768
UFO tlock:0xffffc900034d11f8
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:3707:8
index -1 is out of range for type 'struct dtslot[128]'
CPU: 0 UID: 0 PID: 6833 Comm: syz.0.56 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:455
 dtInsertEntry+0x936/0x1430 fs/jfs/jfs_dtree.c:3707
 dtInsert+0x931/0x6000 fs/jfs/jfs_dtree.c:894
 jfs_create+0x6c8/0xa80 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3796 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x1500/0x3840 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_creat fs/open.c:1530 [inline]
 __se_sys_creat fs/open.c:1524 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1524
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc0cd3bf6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc0cca2e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fc0cd615fa0 RCX: 00007fc0cd3bf6c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000580
RBP: 00007fc0cd441f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc0cd616038 R14: 00007fc0cd615fa0 R15: 00007ffc096fa2d8
 </TASK>
---[ end trace ]---


Tested on:

commit:         e9a6fb0b Linux 6.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108a1a92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=9489c9f9f3d437221ea2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13df260a580000


