Return-Path: <linux-kernel+bounces-881411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB0AC28264
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF973AECAD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421C02253B0;
	Sat,  1 Nov 2025 16:18:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DD34D396
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013885; cv=none; b=OG5LbAG3Ldxxd3uzjlkLmx8qcx644GFrxl+SoACxLnd4+6kvONyuV+BroPta9n1eCUaARosaMAE2eKJUKIK6hypK+3zTCdoSUnf29wIiA5cl8CBnBWHS27Kytx99Lh8UOfKm/M1H0YjC2nsVgnrlgzV4WNqyqvyjfc+vNehb2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013885; c=relaxed/simple;
	bh=XSm3vC2ez/AEyBB2DTeOKkGbpZYTNfhdf4JmzWztjVI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q7q9z8qh4HkcX+2wjGjyBr3/QJDr8bWI8XVawK+zBiaXmkSU5/0/GG+haFu/axNsXcmytAZe6PWfYGbK/spOq/Y2OofAiIHsIL1u7WjNFwPrqNkRS8yafWZpGRYdp9GiRVj3WNgjJJKnxLKCFd85QdSs1N8IIgHCcBY8D8JTqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9483f60a7adso29370139f.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 09:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762013883; x=1762618683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKG7IWuIMo2y1Jyaaa7H2mRRBpXwYBQJcngycYZ1wvE=;
        b=BgUK4ZcGvNmxjPSOunsJXCc4qCnq6UHY9BV3nE98h9ITA3bVs3CFy+wHnoGtpjpTt/
         A9PPtdTxLUW8xKDeBYzCwpBGgAP120jNjw6DDuIQa8wjcYQX+sgTbJfv19zcMXwzgKlY
         Fp6fp2FdjX6GdxOdFsafg7D3QafeM6KT4a/gAti95yzVGoxRLvbnmtvN3bGxjcrW1YSM
         vIpz+GieyzdxOCamoGmxIkwi0QMZYfyX9tGfGO0C8mjMML+uNU2QW9qZ2rWx2KpYlhPR
         zdLJOmNYBDhyCSXigytCytcqq3OQ+V+aD4IS79qUzLDotuK4E5UuEoZ2Fud5MVlpy6T7
         HqQg==
X-Gm-Message-State: AOJu0YzEuIGTU41afPifb3jRC/tCS0VyuzQJ2nVUVn/v0JxPsuLJ+cNT
	12+6zIqB0H6R+j7J38IyJiMmnClmTl0fPqZJvOKrfDU5dXhfI27Tetlrnwu9GPBF3QaWjIAbuhV
	a2nPtm6/vzsvEVg080shjAdmsJ6rEKlFikXk9oHm6LSTMLMC6ZzN6KWVohK8=
X-Google-Smtp-Source: AGHT+IGssXTfkIPCFTKLE5Zzdy1LArvxmvRJbOW9XQAntxAzLu1PKhvuNvqlRb2P9pqzgBbpxum93YC2UdIwpUHeYzdmdrKoX7OR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:461a:b0:433:24c4:7697 with SMTP id
 e9e14a558f8ab-43324c47965mr14908785ab.21.1762013883399; Sat, 01 Nov 2025
 09:18:03 -0700 (PDT)
Date: Sat, 01 Nov 2025 09:18:03 -0700
In-Reply-To: <20251101153157.837686-1-m@maowtm.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690632bb.050a0220.29fc44.0005.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, m@maowtm.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in get_data

Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
------------[ cut here ]------------
WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278, CPU#1: kworker/u9:1/5147
Modules linked in:
CPU: 1 UID: 0 PID: 5147 Comm: kworker/u9:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: hci0 hci_rx_work
RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 b7 d6 1e 00 90 <0f> 0b 90 eb 05 e8 ac d6 1e 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
RSP: 0018:ffffc9000ed9eec0 EFLAGS: 00010293
RAX: ffffffff81a1ef09 RBX: 00003fffffffffff RCX: ffff888035008000
RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
RBP: 0000000000000012 R08: 0000000000000ea9 R09: 0000005832e2457e
R10: 0000005832e2457e R11: 0000141b82000035 R12: 0000000000000012
R13: 0000000000000000 R14: ffffc9000ed9f008 R15: 1ffffffff1c0ab06
FS:  0000000000000000(0000) GS:ffff888125dd3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffea26700c0 CR3: 0000000075b8a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 copy_data kernel/printk/printk_ringbuffer.c:1857 [inline]
 prb_read kernel/printk/printk_ringbuffer.c:1966 [inline]
 _prb_read_valid+0x672/0xa90 kernel/printk/printk_ringbuffer.c:2143
 prb_read_valid+0x3c/0x60 kernel/printk/printk_ringbuffer.c:2215
 printk_get_next_message+0x15c/0x7b0 kernel/printk/printk.c:2978
 console_emit_next_record kernel/printk/printk.c:3062 [inline]
 console_flush_one_record kernel/printk/printk.c:3194 [inline]
 console_flush_all+0x4cc/0xb10 kernel/printk/printk.c:3268
 __console_flush_and_unlock kernel/printk/printk.c:3298 [inline]
 console_unlock+0xbb/0x190 kernel/printk/printk.c:3338
 vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
 _printk+0xcf/0x120 kernel/printk/printk.c:2448
 bt_warn+0x10b/0x160 net/bluetooth/lib.c:276
 hci_cc_func net/bluetooth/hci_event.c:4192 [inline]
 hci_cmd_complete_evt+0x493/0xa80 net/bluetooth/hci_event.c:4216
 hci_event_func net/bluetooth/hci_event.c:7629 [inline]
 hci_event_packet+0x78f/0x1260 net/bluetooth/hci_event.c:7686
 hci_rx_work+0x45d/0xfc0 net/bluetooth/hci_core.c:4099
 process_one_work+0x94a/0x15d0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3350 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3431
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         98bd8b16 Add linux-next specific files for 20251031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a8e32f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90be0b22166ec0b9
dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1430e32f980000


