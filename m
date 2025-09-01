Return-Path: <linux-kernel+bounces-794016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A8B3DB83
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CC7188D697
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFAC27F170;
	Mon,  1 Sep 2025 07:52:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005A2475C2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713124; cv=none; b=R31Xg4i5LRGvbrLDPpwP1kSHgniNA15vNaplVBtLdmEmJVLpux2u8Hj5KfCEvHtN6TS3QZ9Zjmoy444LNcwAsAHzdZ8kswfMAwlLjiv4XWtFZOF7xTxRJTswtmk2LeuEJj2glG6ZLqFtK4/lZmXRVFMgPk1hufDeVQZWIcYS9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713124; c=relaxed/simple;
	bh=QcZbd2wBa8znXCKEb3B3P4dOWUY2YKzZKy+k4ycUt9E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LlhQI+OBefS/8tClplILEsWC4SfI5zP+cYmJLSRqjtXa6jWoECqBx4vzgg+H9JgZMhGztfqAJzm5cue/9w8dqH6XTmxdCb0uglH+Na0awr1MYZUt0Q/5qym0Dj3mHB4oTr7LLSFJEIbeq52tNoPk5qsFZeLQSMUoi5/hOaduT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3efa61f3ab5so90609705ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713122; x=1757317922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tC+RnlGqxK0XL5Kr9k4mIpuEP2/N3INOHwuttHO3Xsk=;
        b=Tx0n6Fo2qxP9MysUDVFDHiQRH2QZSDOFLBgPGNHE/JtzsCk76wj48tFEdMuvlqkKb5
         Q5s8EH/oh5zYNrV7YDw+6pCB6kMpwknc/22ZGG53KFq1+K8bEEGEm/fuGeraZ/KjzagX
         sDtkXQ1t4lXaQGXbKnZLyN0a1JZ7HCl15rWOs/Q0pUC0zLFQcqBGOch+lu9SOvaL/nIe
         r+yUq3hQRjV/n74ZHo+s8RGlVmP63pA4C98cZAVJPCEa58qcpVZt9kx9BThIXFebYYSJ
         gDuOxJNTYls4Vl6/lYF5QCqTqcM8AADDpY0kGQlri6Qj5YrHgnccm6abDf5E/TGyFDMS
         2FNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4JMDFxSvX/ytuibB33E6JBtSP+dsCQn6G4X6vxbCoy3IcTOJs4VzDfgik7LVftXmkeBLOD1SrN1F8iRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zDZUYasGdN0dZmFR+LoUKbzqzgA2qaLke26Ip93ym3okwGpi
	UjiI+agzFLuTdc0hz0NNlQyY7ugyFgtN7i00M1gZxxlax0yC8NGUHKmFPhom7XB+EBc8ai82jyF
	OT0YPqV7QpY9oW4uwXaE5iiYjMGruyCme2Ii9g+NVuMhKx+uuOU+3LIomumI=
X-Google-Smtp-Source: AGHT+IGDbfDQb6Hlu6dqF5PgfcnVJmssI4FSoS6BH9VCDTwbtVfMrI15SJQKY46qjrSxYOkdzEgsdUZG/pl34xi6fqfIj6es2rk/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:3f3:bbda:d037 with SMTP id
 e9e14a558f8ab-3f4026bd7e1mr143545815ab.26.1756713122724; Mon, 01 Sep 2025
 00:52:02 -0700 (PDT)
Date: Mon, 01 Sep 2025 00:52:02 -0700
In-Reply-To: <697876e4-0b24-498a-8c4f-184077c3a1bc@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b550a2.a70a0220.1c57d1.0547.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_end_io
From: syzbot <syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com>
To: chao@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in f2fs_write_end_io

------------[ cut here ]------------
kernel BUG at fs/f2fs/data.c:362!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 1159 Comm: kworker/u8:9 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events_unbound nsim_dev_trap_report_work
RIP: 0010:f2fs_write_end_io+0xb52/0xb60 fs/f2fs/data.c:361
Code: e8 33 f1 14 fe e9 91 f6 ff ff 89 d9 80 e1 07 38 c1 0f 8c e3 f6 ff ff 48 89 df e8 a9 f1 14 fe e9 d6 f6 ff ff e8 8f b4 b3 fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000007d38 EFLAGS: 00010246
RAX: ffffffff840bf6a1 RBX: 0000000000000000 RCX: ffff888027291e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 000000000000000b
RBP: ffff8880744dd8c0 R08: ffffea0001685247 R09: 1ffffd40002d0a48
R10: dffffc0000000000 R11: fffff940002d0a49 R12: 0000000000000006
R13: ffffea0001685240 R14: 000000000000000b R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125c54000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2aab608000 CR3: 0000000033b1a000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 blk_update_request+0x57e/0xe60 block/blk-mq.c:989
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1151
 blk_complete_reqs block/blk-mq.c:1226 [inline]
 blk_done_softirq+0x107/0x160 block/blk-mq.c:1231
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:835 [inline]
 nsim_dev_trap_report_work+0x7c7/0xb80 drivers/net/netdevsim/dev.c:866
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_write_end_io+0xb52/0xb60 fs/f2fs/data.c:361
Code: e8 33 f1 14 fe e9 91 f6 ff ff 89 d9 80 e1 07 38 c1 0f 8c e3 f6 ff ff 48 89 df e8 a9 f1 14 fe e9 d6 f6 ff ff e8 8f b4 b3 fd 90 <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000007d38 EFLAGS: 00010246
RAX: ffffffff840bf6a1 RBX: 0000000000000000 RCX: ffff888027291e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 000000000000000b
RBP: ffff8880744dd8c0 R08: ffffea0001685247 R09: 1ffffd40002d0a48
R10: dffffc0000000000 R11: fffff940002d0a49 R12: 0000000000000006
R13: ffffea0001685240 R14: 000000000000000b R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125c54000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2aab608000 CR3: 0000000033b1a000 CR4: 00000000003526f0


Tested on:

commit:         e78352f9 f2fs: fix to do sanity check on node footer i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot
console output: https://syzkaller.appspot.com/x/log.txt?x=12306662580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8283cde63d6907
dashboard link: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

