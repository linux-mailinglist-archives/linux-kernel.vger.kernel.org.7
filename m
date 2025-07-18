Return-Path: <linux-kernel+bounces-736784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9EB0A1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170437A4F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B42D6415;
	Fri, 18 Jul 2025 11:19:10 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0BD28B41A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837550; cv=none; b=fLrW78F2bC+OvvlEypxGzBqNN+AlndQEPbZyd7ZxfL1lo9ui0dYRFkg6Wzt/fNHeQYCyASTCFfHiEuUG+i8ce8SEHWsLFM1kHWCRG1t4eia//U20Qz0k3w0fWcLg/2vJ4vi9Ues599MSh/5y7gmHIO2kCCNwsVJ1UroyAlUmdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837550; c=relaxed/simple;
	bh=e7UwLrY9p0bFW3RKvPLhQeqR6oKmd8e7kQ+Gx7xUm8c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HBnGbjeoFGiveJpJtyTheU3trvGz/9uSgPHk2Aepo5oNn3RL8AspgJ7on0DJSTymkHXFz3ZLHuCAm5tCFdcjNEqwONDaMqocZoCi4CmRj/EivqPorOqJQM4SeABA+sr9rX18OJMqdv3PK4p8qPIM+Yn5osLYTJ7cEWM8BjjbnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c18a52977so2408939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752837548; x=1753442348;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbIiFRvZ3PhGmEP+5Sz2mkrZI7HOfBsm9dmfxY0hgMs=;
        b=CtoqouUV+wf0SYFtaa1DsmwScmtCgEb0NuEiOstGZTG9yFHAN/j0AzCcoloxBnjID9
         YDaCBlT0ABk+/L+1wm/k3qMB9E4wq/f+6R1fibJD9sKMB0uw51swKi0mQrrK9TLM3S9n
         /Ak6ny4hArG0RaA1A+AOirG01fliM4HbECjX1Icw7qBpgcg4ZwFifTp8eo/6tPrI/07v
         g4pZVDAgbkHHk4L2VLhW/gaSbjJbalfbZX8mj2ynx/lqZoCCv/pP1xYtkL7nXbNs4JB4
         NcRVqhltJdJE2UniyQ6ujcgpGGxMhcKqF81iseuZnC8RtSyWuUtLOooPt42rew8FiuZS
         Q4BQ==
X-Gm-Message-State: AOJu0YzCDvk/sjA30yoq8J4WRqe/bLDJm8W9wC7BnCJAO/OuI8Se7wyn
	ruiqVEJT5kyys0cHkc57kWPhxhWoiuUlGF7Mp8OKhQ5FgAFqN4JNdW5uek7SP3Fd4lDMnZUeroB
	Z+5ihhxB2qYv71qizov66zFEpUyp9tssvqYn3Dav8+SHF5jO5DxP56omG3Ug=
X-Google-Smtp-Source: AGHT+IEZUoN3QbCtqRsqwg+cUYOigurE8sHYkEpylEQ49umyp0ZTCmTJKKYYKDkXmajSlcgPsImQlUrlAiPC+BSlNkdSM3p3gOIT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3603:b0:86a:84f:7a45 with SMTP id
 ca18e2360f4ac-87c0f0b6d94mr271542939f.8.1752837547969; Fri, 18 Jul 2025
 04:19:07 -0700 (PDT)
Date: Fri, 18 Jul 2025 04:19:07 -0700
In-Reply-To: <20250718105849.484227-1-richard120310@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687a2dab.a00a0220.3af5df.0028.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_rename
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, richard120310@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in minix_rename

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6941 at fs/inode.c:417 drop_nlink+0xc5/0x110 fs/inode.c:417
Modules linked in:
CPU: 1 UID: 0 PID: 6941 Comm: syz.1.17 Not tainted 6.16.0-rc3-syzkaller-00042-g78f4e737a53e-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
Code: 78 07 00 00 be 08 00 00 00 e8 c7 35 e8 ff f0 48 ff 83 78 07 00 00 5b 41 5c 41 5e 41 5f 5d e9 42 01 29 09 cc e8 fc da 86 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc900037afa30 EFLAGS: 00010293
RAX: ffffffff82397124 RBX: ffff888058536fc8 RCX: ffff88805e4e1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f9fe1f7 R09: 1ffffffff1f3fc3e
R10: dffffc0000000000 R11: fffffbfff1f3fc3f R12: 1ffff1100b0a6e02
R13: ffff888058536fc8 R14: ffff888058537010 R15: dffffc0000000000
FS:  00007f6555c806c0(0000) GS:ffff888125d83000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2e9a57000 CR3: 0000000031f34000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2634 [inline]
 minix_rename+0x41d/0x780 fs/minix/namei.c:227
 vfs_rename+0xb99/0xec0 fs/namei.c:5137
 do_renameat2+0x878/0xc50 fs/namei.c:5286
 __do_sys_rename fs/namei.c:5333 [inline]
 __se_sys_rename fs/namei.c:5331 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5331
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6554d8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6555c80038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f6554fb6080 RCX: 00007f6554d8e929
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000200000001980
RBP: 00007f6554e10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f6554fb6080 R15: 00007ffd76fa1978
 </TASK>


Tested on:

commit:         78f4e737 Merge tag 'for-6.16/dm-fixes' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1619b382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=296f8ec27963edb9
dashboard link: https://syzkaller.appspot.com/bug?extid=a65e824272c5f741247d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f1b382580000


