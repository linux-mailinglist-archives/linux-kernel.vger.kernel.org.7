Return-Path: <linux-kernel+bounces-838135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB61BAE850
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C800F32553C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33627AC3D;
	Tue, 30 Sep 2025 20:18:34 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC7246335
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263514; cv=none; b=udvd9y/3IoJ+hjss4xlOHo1c94zjhlPMrGdBGTGB8IF73MCjMd/gH87kdOmRO/+rUv/RZkAz4EWBGCgCmX6EL/FvodxuGg78ieIahd8HujaIsElLFuRZWEYqgfgQixES+yutE06S5oygvol+64u22LovF35SJTH+nAkAq4K9NJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263514; c=relaxed/simple;
	bh=T+yH3xlB5AS2G/zCdwTXzVmb/MrWsfzWQV70ETDV9CU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DIUsCo4N2ksHXyl6kNb99ha/tOSroyPoenJa8Cd7yAKsbn7uLDDj7hy95jbsBSZgzSMlYl2yU65fq9g1Q4b5eHYrpUGvvnpbb+eL++hsJR8TigEJmVpfZny1j2zRCF2OWERJl1yIG1zNeyuRR6R41X3fXq/BSQpb1mxwUAuZwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42571803464so162510435ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263512; x=1759868312;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wvyed+hkAOlVOf3CdR75dVyqRRKIjxQYnIqpTCgeQoM=;
        b=JBwUbcHz1+icgdlAulaYs2chRI29HWCY9X48pxb4CL1p6oaf6+Qt1bsMOHkzJ/uj//
         YG+vQwIwxQY1mTVTmOcoMHBODlO7xxqQSa4GqSaTu8ch0gXOfX2HPjX7m+KoWBGJ3pRM
         aDZ7o2oXSn3JhbK1hM76HL/8yPGViOzaZLetWhPsr94gyzYfowjqsLTw/iZBBFDjQkAz
         HetbOE8eS1ONtF6GZ5xsF9KC0Hg1vCOXqd7DbQLZ2wXOqhtiwhIE46jgulymRX/dWEaX
         dgb6AHpRASWJLPNThwEBFO4CFs2KdPvfxDUqiDje3Ya3SdI3WAutBNxsMN1YVEyoM1li
         inNg==
X-Gm-Message-State: AOJu0Yz6pDCqHRd5UJeNXDaRaxguPDEWfLhn2mOVXf3agsYihdZEUZwy
	gpId2mfzTTwE1N4QrOSIvF14fnTihqCftn4F9SaGnthRvCoXcqSXQx1m9Fa9HUGJRCFWifpXAUg
	EXJ97uO1JzgFG9z90WIBq9Tk5rgBYhH9R07EPu+smZQ+7oci2bafONM3YK/RTyQ==
X-Google-Smtp-Source: AGHT+IHJihiOJ4NgM6cupXTzDmHsENYfzv+6ZiZ3IxdkUptOrcQqKaUmCoeNnZMcfdGHUrgH4TxzQ2bqwtTa8v5KTERPSTSfBA10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:42d:7d0c:ed16 with SMTP id
 e9e14a558f8ab-42d81697506mr20941785ab.29.1759263511793; Tue, 30 Sep 2025
 13:18:31 -0700 (PDT)
Date: Tue, 30 Sep 2025 13:18:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc3b17.a70a0220.10c4b.015e.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING in destroy_pid_namespace_work
From: syzbot <syzbot+c16fb4c2be8fc4be5b73@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1896ce8eb6c6 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10262334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6affe6c860798581
dashboard link: https://syzkaller.appspot.com/bug?extid=c16fb4c2be8fc4be5b73
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3063d52d3981/disk-1896ce8e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/56d7a00c40cb/vmlinux-1896ce8e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/525645c8455b/bzImage-1896ce8e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c16fb4c2be8fc4be5b73@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=948 which is not allocated.
WARNING: CPU: 1 PID: 43 at lib/idr.c:592 ida_free+0x1f9/0x2e0 lib/idr.c:592
Modules linked in:
CPU: 1 UID: 0 PID: 43 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: events destroy_pid_namespace_work
RIP: 0010:ida_free+0x1f9/0x2e0 lib/idr.c:592
Code: 76 f6 41 83 fe 3e 76 72 e8 74 cf 76 f6 48 8b 7c 24 28 4c 89 ee e8 d7 33 0d 00 90 48 c7 c7 e0 5f cf 8c 89 ee e8 08 5f 35 f6 90 <0f> 0b 90 90 e8 4e cf 76 f6 48 b8 00 00 00 00 00 fc ff df 48 01 c3
RSP: 0018:ffffc90000b37b58 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 1ffff92000166f6c RCX: ffffffff81796e88
RDX: ffff8880216f2440 RSI: ffffffff81796e95 RDI: 0000000000000001
RBP: 00000000000003b4 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: fffffffffffcb3a0 R12: ffff88801eec8000
R13: 0000000000000293 R14: 00000000000003b4 R15: ffff88801eec8070
FS:  0000000000000000(0000) GS:ffff888124f81000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d91ccb8b48 CR3: 000000000df80000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 destroy_pid_namespace kernel/pid_namespace.c:155 [inline]
 destroy_pid_namespace_work+0x6e/0x120 kernel/pid_namespace.c:170
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x56a/0x730 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

