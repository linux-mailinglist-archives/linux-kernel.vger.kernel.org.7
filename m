Return-Path: <linux-kernel+bounces-843734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A7BC01AA
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85E454F2400
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7B1BC41;
	Tue,  7 Oct 2025 03:33:30 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0334BA3A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759808010; cv=none; b=UAd+nqYx/vluP179inh5EmqIY0LwBw8q2dSYt4rTMvORDv4MQ06fKMJNwMve9xHUNFIxP9gB4ODs9v7LFfwXtJrBeC/r5snXjEeDSc5mBk/MgjSyIX1TNkR6emhSwQlvmYp1/346Cwu0SJp5oIkhmKaT0Em5pVvZ0U5im/jnVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759808010; c=relaxed/simple;
	bh=Qo152Ck+YxuMOkvgcNAkaVmRHYF98a6hzVfseUr0S40=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UeDsGgqPJor/Z8qMIq2gJAzbNxlkW8d7AQRjUCsFpn/tnOCIRoLN1l9vnnBTOy+ugxajIkGDlKlwke8peccpz0X0XGT2rWUcEmZ9xuAaADpOQgldhn3iXLPl8nygVZzmKEGYgm8evMZTQBNW2nJC0TNz+zB4xg538udsNWkd3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42f7adbd951so5685425ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759808007; x=1760412807;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=952owU/EqtMgqLf+gZ7Jn7cvNDb68sFa+jvCW3cWFcw=;
        b=bUC8fnvF9xSQCtb74JNAMWA5c7Qe+SC+q9A+nExOYkUtLkMfHXpc/pzpEF9H5y4Rcg
         giQimfizFZWIGvlXl7Bm9Xdu7KvjLDn25hAwPP1I7xDcgABizWVrr2fhQdXZVY5MNUne
         rq9nA9kmcFj5eISjL/VNUw/5XM77HDnBCZcEbxA2iK9qY9xa5NckpxJMVa5oVWTEHhcn
         oCavwnOKIkrBNcj0Ja228et6N5Kn2vSuUw/+82+F/xI2GSx76asbqc9yWTG3F02ba8jx
         H/0raB2FuCVEplBpqS2e9DVjwYHVVTNWRsogLp/zB2GtNJw2ArMjOg0hNMbMeOFXHhJq
         Mqgw==
X-Forwarded-Encrypted: i=1; AJvYcCWKh1rb+DBpxj+RMWacfoLVOsPCSsaAB8BIPxtyH5Ai9o604Ultm54Dqet8YUdvPe0iUbSo840kJb9LTB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypIMl4bIuYMZEJewRpLysvKHL7wIkXM+uXBXrXeLAfRvvpL58o
	8k25eA2QkD7Yez82rVljaMC+khuRxHf6KUX42nyhxYFHSi+Ir3RpK018FJT/SPWs3sPcKMhqzSQ
	CFKxxJ27vajbKxZC9Aov2/QUyY7sakCt2uHZ70xSNgJo3GCFSI3+McSZ1HeU=
X-Google-Smtp-Source: AGHT+IHQ10nqe4mSpqPwa3nNHorUsWgHZKJ2FqxJQeZOaMmqnrsm53K08Tu0e1xbDfvom7tMXDbULT8NHg7BXiVrLem8dRi8ZQ8j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:423:feda:f14f with SMTP id
 e9e14a558f8ab-42e7ad018aemr243117805ab.12.1759808007446; Mon, 06 Oct 2025
 20:33:27 -0700 (PDT)
Date: Mon, 06 Oct 2025 20:33:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e48a07.050a0220.256323.0014.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: vmalloc-out-of-bounds Read in kcov_remote_stop
From: syzbot <syzbot+90984d3713722683112e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fd94619c4336 Merge tag 'zonefs-6.18-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c381e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2b03b8b7809165e
dashboard link: https://syzkaller.appspot.com/bug?extid=90984d3713722683112e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/201636e25a0b/disk-fd94619c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b63e3832240c/vmlinux-fd94619c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11fc378734e8/bzImage-fd94619c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90984d3713722683112e@syzkaller.appspotmail.com

usb 5-1: config 0 descriptor??
appletouch 5-1:0.85: Failed to read mode from device.
appletouch 5-1:0.85: probe with driver appletouch failed with error -5
usb 5-1: USB disconnect, device number 31
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __list_add_valid_or_report+0x4e/0x130 lib/list_debug.c:29
Read of size 8 at addr ffffc9000ffa1008 by task kworker/1:1/44

CPU: 1 UID: 0 PID: 44 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __list_add_valid_or_report+0x4e/0x130 lib/list_debug.c:29
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add include/linux/list.h:177 [inline]
 kcov_remote_area_put kernel/kcov.c:156 [inline]
 kcov_remote_stop+0x52d/0x660 kernel/kcov.c:1060
 hub_event+0x45d2/0x4a20 drivers/usb/core/hub.c:5997
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc9000ffa0f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000ffa0f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc9000ffa1000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                      ^
 ffffc9000ffa1080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000ffa1100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


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

