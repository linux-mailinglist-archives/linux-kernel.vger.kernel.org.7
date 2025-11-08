Return-Path: <linux-kernel+bounces-891586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA304C4300E
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E8A3B113E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E41C84DF;
	Sat,  8 Nov 2025 16:46:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F034D3AE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762620364; cv=none; b=O9q5itNdjTvX2G3XhxQBhMaPLIxcYch8CxiXfwekG52WQle3tUQe6oiqFLUOk4nogTMwM380qrjjdoeBAVQF2G7SynV6dngnGQVvA6EoBQO1BlmsuRywF4rKLjCyHbHxDrwhG7toFkVC4GYYOlD97vCkBqKf0C5l5WI4E4+78GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762620364; c=relaxed/simple;
	bh=jaxrEV+3+CNG5CJYAOj5Wepnzw1M+GAIJfHgMkpVN1o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xvs4xFNmdvFftQEqOHIlWPQHNMTxwPVAXKkbsYaAT50B4T6WlIh8UHE46aMwitYcdepOQhWCT2lNtb1izjn082qBzDT2YD6JAN/Pqdqa3gzHfpTGPuj/NjLR2StOnTI0NTgRirFDmf4t3wAiDGAc3NmVYCzLwoPAIZh104ZxdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4331d49b5b3so59076245ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762620362; x=1763225162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MeY1e6+wjdp76SuigCBQZGNLFMOr2X0xPwuMBUVyrs=;
        b=lVL19jf2vSqEswS8NygGzqfSB3kXwSY0a30I3OilQA0OQM5qqccQBTkd3IxJiqVRtS
         DGvY7tbvnshHXvGbidyVApnO9a/roUyebrNR8UKsnP3zYFIyhVkRzIBUnwDwbsto3/PT
         w6jir1UYNbZnfM6VTmEoptKXSXRG0HsZfky0z+bF0FdqmXlsJH3P3iJ9Dz2oS8Pf4Z10
         qsHYdOzUC9VmMef2mG2GqBuJvvjmJKX8bnyGIKVWxQZOco6hYxLxnYVBNhrYnKFH9W5b
         hY6Afj4wT1XBj0wCRkiUE4DPURXeuaG1qGxpvrXe5JLdE7Vdk3tcrI1C3Qn8ZyvBeheg
         sUxg==
X-Gm-Message-State: AOJu0YwTcaOE8QKj+z0rWqfgBAZIDcJ59eYv7Ne4ggZPAUBCQ65yIWiG
	kTUxKqEskhucJKL+3CyvtSBr/MQTdqo6saH9PkUTRY7+JG4HwsXoGfqvWumehdw1FHlpsW4PzCL
	e0gAVKaZs7k2Ck9LB3T4aK3Dz0Nhi2LheIJEwxZcwmV8lrCPLTPhRoPs0vt0=
X-Google-Smtp-Source: AGHT+IHXsFjlcal/7KWsU8BgKQGWkK+9ep07yTSC9FYjjZogEHhgmwxnuqUYc5q9SXpYVkjbdDT6cLv49U8DMdOyLJCoLHK4Tg/c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cccd:0:b0:433:7310:f5bf with SMTP id
 e9e14a558f8ab-4337310f94amr13433275ab.22.1762620362377; Sat, 08 Nov 2025
 08:46:02 -0800 (PST)
Date: Sat, 08 Nov 2025 08:46:02 -0800
In-Reply-To: <SJ5PPF2F7FC4EE603CDF9A16121B88A38C09FC0A@SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f73ca.a70a0220.22f260.0087.GAE@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in dtInsertEntry

loop0: detected capacity change from 0 to 32768
UFO tlock:0xffffc900034f91f8
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:3700:8
index -1 is out of range for type 'struct dtslot[128]'
CPU: 1 UID: 0 PID: 6705 Comm: syz.0.55 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:455
 dtInsertEntry+0x936/0x1430 fs/jfs/jfs_dtree.c:3700
 dtInsert+0x931/0x5f40 fs/jfs/jfs_dtree.c:894
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
RIP: 0033:0x7f67e06af6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f67dfd16038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f67e0905fa0 RCX: 00007f67e06af6c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000580
RBP: 00007f67e0731f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f67e0906038 R14: 00007f67e0905fa0 R15: 00007fff0aaff588
 </TASK>
---[ end trace ]---


Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cf0b42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=9489c9f9f3d437221ea2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17eaaa92580000


