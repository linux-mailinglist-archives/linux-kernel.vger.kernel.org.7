Return-Path: <linux-kernel+bounces-830358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1779B9976F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E90D3BD05F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB152E03FE;
	Wed, 24 Sep 2025 10:43:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18942DFF3F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710588; cv=none; b=kHWVvAvtvkxeM/DEK6gO8Y3574afmXbQv8fjN/dl9xK9quuC37QncRq7Pyp2gimvR8OCtATCAh5Al92AmzsWdbb/TSmbfKpySsxeOgfumYfjiahIawbLdKFMYoQ04M3/29oigE151BN/+i/ySpeq/k9DWHex0Vq02pRWg/sJkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710588; c=relaxed/simple;
	bh=Vq6GH37+T0oNb07dpjUv51rQsO9w2R7pL9KQX/uzQWA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HDFAs24Hyqd9SOtgTTbPIfRagmkgSHcz8nNYXzJMlSJkueAdPNEvf26hCEBefMKR0co+65u2c1qVQFmV/9rNFjVGbjX1/W6QokbHqBAkpFdpq6n9k+DBAQ277jTF2X/wGt2aK9qmESKl6d00czATwjJng7Bl2QcTwOoRr3L+O/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42577be9d9fso40346535ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710585; x=1759315385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fOJ3omG9/U8XIHjiHrQO3kEUgEtNLRv4B099C1tLH4=;
        b=evyDWtFLYWtLBM9UYDqMfBIKur0NnUsl09vQDPPQ7DdLgoYmUDWxqCrE0C24phvT96
         9xUMCBhZrs2lrqfoUv1OH2BEFtreob89s5iZ0caC2akdwnp5+D1SSLSZ5Fu6YWtDfrtm
         mvQ67m5mGiZVlqPSQlc5BI5wDfTDCSV8eEElDriKy97iONY9LxNBLgFVpcI4s6+kp9vj
         nROOllBLlADD4dCflBDZtUnrjykoK/0N9Aqt1faUej/2aEQhyy0WjgE+esvnEhDwVLGo
         yf8M0zQ3ViY2hJrkQNqkATOVwFcSIYNruU1m5jWbUrNykaGew5TiK9vnF/8YMAbs3sGj
         Ac9g==
X-Forwarded-Encrypted: i=1; AJvYcCVBN0+IF2hLuuflK4gGw39vJ7d40+Xge+93hGGyYT9aDALPZvXPK4SFRRgEBMdGeEEaSp3a2ZIJPeDNfSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7tzLYSaLZ+JSmuprjn8n36pnJp3F9qmnSwcs4FGrDXE/wQeaI
	nqVV33s700uxUhv9DMCrjN4nfWKx8dg14cj8LpNGZ9Fzqqg0jt9S9Xtc1aaHXkaX7cKIq5w91G1
	+6gscb7antjgbYGjDsrvK6DX16XLhG98mPmHrQ9FSj4a5TVr4CIDgYgzjz2Y=
X-Google-Smtp-Source: AGHT+IFimsRxIjZpQBbqxiWneKeAN+rLFlEt4WPeLx7akWYFaJ9w+KvGuVyNkwobF1A516kxCwDSvzxp5+YlEZtM/W+oDK0AcuC2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0e:b0:424:6c8e:616b with SMTP id
 e9e14a558f8ab-42581e252ffmr91363775ab.13.1758710585093; Wed, 24 Sep 2025
 03:43:05 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:43:05 -0700
In-Reply-To: <tencent_A1A361297E23A6644BD76A577B66DD336005@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3cb39.a70a0220.1b52b.02c6.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in hook_sb_delete

BUG: sleeping function called from invalid context at fs/inode.c:1928
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6514, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz.0.17/6514:
 #0: ffff8880306a20e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff8880306a20e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff8880306a20e0 (&type->s_umount_key#48){+.+.}-{4:4}, at: deactivate_super+0xa9/0xe0 fs/super.c:505
 #1: ffff8880306a2998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff8880306a2998 (&s->s_inode_list_lock){+.+.}-{3:3}, at: hook_sb_delete+0xae/0xbc0 security/landlock/fs.c:1405
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 6514 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8960
 iput+0x2b/0xc50 fs/inode.c:1928
 hook_sb_delete+0x6b7/0xbc0 security/landlock/fs.c:1468
 security_sb_delete+0x80/0x150 security/security.c:1467
 generic_shutdown_super+0xaa/0x2c0 fs/super.c:634
 kill_anon_super fs/super.c:1281 [inline]
 kill_litter_super+0x76/0xb0 fs/super.c:1291
 deactivate_locked_super+0xbc/0x130 fs/super.c:473
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1327
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6d878eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe6d961c038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fe6d89e5fa0 RCX: 00007fe6d878eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000002c0
RBP: 00007fe6d8811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe6d89e6038 R14: 00007fe6d89e5fa0 R15: 00007ffc5011e858
 </TASK>


Tested on:

commit:         ce7f1a98 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=128f94e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e2cce2580000


