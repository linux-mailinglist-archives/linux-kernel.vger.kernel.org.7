Return-Path: <linux-kernel+bounces-793344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F59DB3D216
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95446189EB8F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B266C24DCE9;
	Sun, 31 Aug 2025 10:19:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48843169
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635544; cv=none; b=n9pMEnTGYBqmL2gJMvw1hDJg3GE0YOVZiJQubsiIfEHn7+ZiJiN0XS761WzWkK/ot3jNXMsY9zRVjlnDGVkU6v/RVYWJSvJQpnIvG0hVLh7fiNpYgqxK7N4ZowFNNjdh1SMyPiC6AdNkMLJUGqgD9VR7PoKkKbNUIXYB6hX3xWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635544; c=relaxed/simple;
	bh=RwQHnRYjV/1vKZ1PuwPUfN2604MKwMBwks15ba2icVE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BFiaZH9y0cukICMf5Sq4yEPn0YetEKKuVfj7h1r6c76gYrkUX5UAXC9yP0p4Z29c5bFCogtPtOkD+ZD66GnvTMn9MSw9q6WhgL665fsskGJ82rtLvGvBpB29fuBgTMv5Nk4TOEJ7FCGPlCmNUYXas3AUt9j3THIyLXQUcxKgQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f29a0a7671so25772515ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 03:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756635542; x=1757240342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wUanWJ9TFUpM54ILEtXgfjoYDPHC9UXWO0NyRChwpE=;
        b=aB8N4GfN/ESg3joIAEmGOX6dIjj8yYya6joeilFbVU3q5zG5rRiuS7k/Q13fdu7ZmM
         Vd+UgFQI2TJceSYB44ZIpfQJlNoBNDMhZN37e68z8cGUQwzbQuc/T/eusH8JLLS799Me
         f5miLtCAt89V2QtVCrlzuBMvjsBNBuLB+JUauqMbxpFsEql7tvQiXsCfvu5YuPMTs+ng
         6aTf7SVPfw655HI0uoJs+nZ1VGpiKReqOsDhM/5YSkTPd6Q3kF4VRzUBiWryQhIPqmt+
         vi5lzjcD1qgSut5kjjrt2XWtG6c6+Uu8uazWPYeSBqbMora8HfTgZKPjpCZFqHD+Lw6D
         2GzA==
X-Forwarded-Encrypted: i=1; AJvYcCWC5rb/vM22NUB35pEAeODMrJmraymY85VUsnLuBVM5EDRrkAoG6Oqqj0n0FAQPWAcqdbsISoyHsy+hf2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsEwcuOJ4/RBTtrfh/cKgKb0qUat0ZGyaGOppKoWv91i/Gw+3
	OL2YBwuCHInzLkKRd8YjNxU+jgKzMrO81uTQDIxmMTRORoFrDQ7fJGHHlt2hIoEy7anvhtdQPmc
	3AgIUcN7ChH8CCoPEEEImSC2RiqP+pEq5vxcv1oTlWBNAO3NAj6kVOlERLvg=
X-Google-Smtp-Source: AGHT+IGlSESnK/xm1j4DJ0slXKrny4chuiUI7BV8fgeneqMMUxjfgz2lGWrCoGYpAMuCBzA+5PNrTUDu+7WhgNc9Bq6d/287EMK/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8e:0:b0:3f2:9344:6f9e with SMTP id
 e9e14a558f8ab-3f400284ceemr104024655ab.13.1756635541987; Sun, 31 Aug 2025
 03:19:01 -0700 (PDT)
Date: Sun, 31 Aug 2025 03:19:01 -0700
In-Reply-To: <20250831095915.6269-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b42195.a00a0220.1337b0.0034.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] WARNING in nfc_rfkill_set_block
From: syzbot <syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com>
To: hdanton@sina.com, krzk@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, ysk@kzalloc.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: MAX_LOCKDEP_KEYS too low!

BUG: MAX_LOCKDEP_KEYS too low!
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 25225 Comm: syz.0.3616 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 register_lock_class+0x2e8/0x320 kernel/locking/lockdep.c:1332
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:3907
 __flush_workqueue+0x121/0x14b0 kernel/workqueue.c:3949
 drain_workqueue+0xd3/0x390 kernel/workqueue.c:4113
 destroy_workqueue+0xbb/0xc70 kernel/workqueue.c:5869
 nci_unregister_device+0xb1/0x240 net/nfc/nci/core.c:1316
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:172
 __fput+0x45b/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9bb98aebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffc624e4c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000063d39 RCX: 00007f9bb98aebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f9bb9ae7da0 R08: 0000000000000001 R09: 00000003c624e7bf
R10: 0000001b2c520000 R11: 0000000000000246 R12: 00007f9bb9ae5fac
R13: 00007f9bb9ae5fa0 R14: ffffffffffffffff R15: 00007fffc624e5e0
 </TASK>


Tested on:

commit:         c8bc81a5 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1226c1f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12dac1f0580000


