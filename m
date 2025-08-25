Return-Path: <linux-kernel+bounces-784679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F54B33F90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EF17B2EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649F1DA21;
	Mon, 25 Aug 2025 12:33:13 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83E347DD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125187; cv=none; b=tAeBZcbUPkzPqQ8H8Bn1EqlH0MYWGmvfnDKSiHtbQi0CS0kFMGoQL3nFpABkFgN33X3+DHI3R1ZkXQ2UGvB2E92vBOqlMa2KxI1Bj5fqpOxpfIPdRmafPi/x58QfC4BDS5yNc9gw+0bK7AtcXo56rKtbMvF11dMG/vs2BGeMx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125187; c=relaxed/simple;
	bh=1dkzrKoWco8mURj0KXhtzIpIFF9goh8qAvoFPHF6blE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QvqOKdwnIQNj2l0A4vU86MSR0zsefOVvQSmLbZgElOFvwoMiefSQjdC7v1xsbirxHCamiYJU4ZGkGXJr9iLQzhxiGnwgtGaQ3MNtsF/qdVSTGSt17I1U4xg1yiwol2rinIAodpaBKQPQz/6iMzd3aK00bER8ZPltkjG1OCJmKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e683419b91so45347495ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756125184; x=1756729984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4JlXADJT/gv8jfnLAIZ/EYSDzj2kQ3x8y2Qi80Rfo0=;
        b=AsZwi+Pw65bhJ0d1aLCvO5Z0RmScjicz1BZ8DrlULZAKEk9HjQJBbku800wy5gR5XE
         eelxiSc+ywfI5kA/h3Gkjj7mdeuM+2O33Mw395P/GCJhTAwGdycYA9WjigWPJatYIn2F
         RATNCxbNlrzFiW1NRxx4nOYTrlG/6OLZqzesWL4sQFnyoXtQYhpglvPOrx+lxEtrCq7G
         gR7rQAnbxRztq3z7jpAhrboHgKsp56Zug6+ZO+9KT7dTR2WCUIrLOk9zCZIvvRoHuqEk
         NvPlqSeCnNy2rb/BX5wfhTLuqjShtXYCTrs7XYTpuo7TFFz0tR3FQYJCWe1JJpjnOWkK
         6MxA==
X-Forwarded-Encrypted: i=1; AJvYcCXQa/Ho9gQllvcE/DCCHvRAXPRfb/li/+DFd4RQuU/Cj7w05fF31owGIe7cQClXdJEg23ikZuy6KGoKoHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UT87EzQkw/5RcRapN5jPc9wo/HOqUG5xQ9jdcFvKsQ0Djdh2
	qOXxB8FfqssUTt3ozt4m2leTjLZdfqjd56QPcsQPYd6jhMQyije3xrlYJR1bVx2Wt+8Tf7cqxaF
	dhaonL8h46ARweqGmmnJOePWqVn6zkencEw5/sRKsEuo1R8DA2bbN7GvXUuY=
X-Google-Smtp-Source: AGHT+IHsxzCSgA5ebCMltqxLeQhV3ZW0iGYGQHwYk+Yep+zB7v4FvoFfA2WzwfXB7eI4xrNoiHRxnnVIizB0Y7ggHh/Ok+x2JgwQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:3e5:62a1:c9d0 with SMTP id
 e9e14a558f8ab-3e922316114mr178369875ab.16.1756125184258; Mon, 25 Aug 2025
 05:33:04 -0700 (PDT)
Date: Mon, 25 Aug 2025 05:33:04 -0700
In-Reply-To: <20250825045125.5372-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac5800.a70a0220.303e5.0000.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: corrupted list in __xfrm_state_delete

 non-paged memory
list_del corruption, ffff88805ae82758->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events xfrm_state_gc_task
RIP: 0010:__list_del_entry_valid_or_report+0x10e/0x190 lib/list_debug.c:56
Code: 00 3a e3 8b 48 89 de e8 d0 79 57 fc 90 0f 0b 4c 89 e7 e8 f5 ff 31 fd 48 c7 c7 60 3a e3 8b 48 89 de 4c 89 e2 e8 b3 79 57 fc 90 <0f> 0b 4c 89 e7 e8 d8 ff 31 fd 48 c7 c7 c0 3a e3 8b 48 89 de 4c 89
RSP: 0018:ffffc900000e7900 EFLAGS: 00010246
RAX: 000000000000004e RBX: ffff88805ae82758 RCX: 684aa0a479b90900
RDX: 0000000000000000 RSI: 0000000000000202 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: dead000000000100
R13: dffffc0000000000 R14: dead000000000100 R15: dead000000000122
FS:  0000000000000000(0000) GS:ffff888125c18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562559a41950 CR3: 000000007bf98000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 __xfrm_state_delete+0xc2/0xca0 net/xfrm/xfrm_state.c:821
 xfrm_state_delete net/xfrm/xfrm_state.c:858 [inline]
 xfrm_state_gc_destroy net/xfrm/xfrm_state.c:619 [inline]
 xfrm_state_gc_task+0x54f/0x700 net/xfrm/xfrm_state.c:636
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x10e/0x190 lib/list_debug.c:56
Code: 00 3a e3 8b 48 89 de e8 d0 79 57 fc 90 0f 0b 4c 89 e7 e8 f5 ff 31 fd 48 c7 c7 60 3a e3 8b 48 89 de 4c 89 e2 e8 b3 79 57 fc 90 <0f> 0b 4c 89 e7 e8 d8 ff 31 fd 48 c7 c7 c0 3a e3 8b 48 89 de 4c 89
RSP: 0018:ffffc900000e7900 EFLAGS: 00010246
RAX: 000000000000004e RBX: ffff88805ae82758 RCX: 684aa0a479b90900
RDX: 0000000000000000 RSI: 0000000000000202 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: dead000000000100
R13: dffffc0000000000 R14: dead000000000100 R15: dead000000000122
FS:  0000000000000000(0000) GS:ffff888125c18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562559a41950 CR3: 000000007bf98000 CR4: 00000000003526f0


Tested on:

commit:         b1c92cdf Merge branch 'net-wangxun-complete-ethtool-co..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15a39862580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10077a34580000


