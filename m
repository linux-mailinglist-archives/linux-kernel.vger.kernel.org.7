Return-Path: <linux-kernel+bounces-852205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703EBD86FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BE694FAAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8E52E8DF5;
	Tue, 14 Oct 2025 09:29:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760192080C1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434149; cv=none; b=DwwaAILOlriNQJ1OP9iMCSuLaecAbPYprR8cGIiMRBCn+OObLZhcskkHQ3iHifq5CyDq1hrCD8MiaxUOLKFhCBnJ1RxM25kAEMQtopsb96RPRxCBjdyYlaCJ/sG8U+esYb6c4ZOEWzpBH7uwb6HZRbQUJmUlRHwllbiL4vlMGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434149; c=relaxed/simple;
	bh=ZJkyyPyIYXY+/kxjbAG+paU+m/2qxR5sNNI80ZmnYBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MrLmcA2mYTTGi69XglqSb0eo/FhpSMjLdMslJq8CgY3NLvopE50amgRDp4hF+TPEm5us7RH87pK4ZiyU9V7MpS3i+CX+dq/jAhfIC9UHFEI7em6CAJbLaXKUKzxo2U4V5NvR3jIs9FpI6WNEhW2Vs5P3g12qtowqIXmz2zxmhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e4fb07e1eso88422139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434146; x=1761038946;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tTCtEw5+0ieUcIgQ0mxoprNheACSg+ZZzWyiqe3FhU=;
        b=MmaAhzao0qEtEF7oLksGsRYfsx93sQGIl+ETQH+1wUiiPZ8TTH5QlGcHMob68YStlj
         fMW7/NLu9FqbFk/eDp8mOovkKe2HYgJS5CRAGo1VY2sVAlMYCzFaNdw1jOK0EILuGwUD
         UTZCbXBkFa65y0zU/c8qW3ZzT1CRdoLVAsKAxkgC7446ccFqEbzeTfbBx4MfwLM8K2ZT
         BQB0HYMIhsTA2rZpHH+iveGJ/UDSeJ1YvIIBbJRWkLE+9j3XlkDx4VcJJzmZI0mtUEad
         gyx6Q/tPeStG40MflAmOREgHXA4t0xPjzlesm/Jjdv/NdIhLrk+nuPfZaK9+IwBw5sGz
         0R3g==
X-Forwarded-Encrypted: i=1; AJvYcCXM9VRz0Jt5W1PwbqTnoNHGYLPOjXuBcQrKajly0vKLei0Hqn7Rbu0EF1v5cPf+20YysbPrQ+ixcju9d1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkwW3MVn0zSum7k8pGG4VNX0tkDXynZHBuRLwYyV95iQey+gI
	wMjJWxOcpEG1ZJoqxm4B9IsohaAXt7WD/Tkk0AnA2vH99UPuQlOGnCxMC/zP9v+BvuPZbKVN/C4
	4UL27aSlNDYLGJFvWHAyVinkHbTiTUGXmmMz9YdyrKqbGkdNp7X7wvXNTTO8=
X-Google-Smtp-Source: AGHT+IGwvu9pafAHh//SXOYhItJTzxtSFlphYUV6C1r2X7uBlsFX/PItkClLdkHQZUgonvyuuN8GM8NR68HIiAqlGVq52BEVd2dB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2785:b0:42f:9eb7:7595 with SMTP id
 e9e14a558f8ab-42f9eb7762amr141559765ab.22.1760434146727; Tue, 14 Oct 2025
 02:29:06 -0700 (PDT)
Date: Tue, 14 Oct 2025 02:29:06 -0700
In-Reply-To: <20251014090554.628056-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee17e2.050a0220.ac43.00e7.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_setattr
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: trying to register non-static key in ntfs_setattr

ntfs3(loop0): DEBUG: deepanshu  Read inode 2, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 6, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 8, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 4, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 10, S_ISREG=1, run_lock_init=1
ntfs3(loop0): DEBUG: deepanshu  Read inode 9, S_ISREG=1, run_lock_init=1
ntfs_setattr: testing by deepanshu 
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 6640 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0x105/0x320 kernel/locking/lockdep.c:1299
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
 ntfs_truncate fs/ntfs3/file.c:483 [inline]
 ntfs_setattr+0x71a/0xbf0 fs/ntfs3/file.c:807
 notify_change+0xc18/0xf60 fs/attr.c:546
 do_truncate+0x1a4/0x220 fs/open.c:68
 vfs_truncate+0x493/0x520 fs/open.c:118
 do_sys_truncate+0xdb/0x190 fs/open.c:141
 __do_sys_truncate fs/open.c:153 [inline]
 __se_sys_truncate fs/open.c:151 [inline]
 __x64_sys_truncate+0x5b/0x70 fs/open.c:151
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8a9079eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8a8fe06038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f8a909f5fa0 RCX: 00007f8a9079eec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00002000000013c0
RBP: 00007f8a90821f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8a909f6038 R14: 00007f8a909f5fa0 R15: 00007fff603a7228
 </TASK>


Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e905e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d225e2580000


