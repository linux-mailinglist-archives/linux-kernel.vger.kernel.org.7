Return-Path: <linux-kernel+bounces-740227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1769B0D198
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288F71C23328
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AFE28CF56;
	Tue, 22 Jul 2025 06:03:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17028C000
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164187; cv=none; b=uVa8YsBvEXyc0bHa7ExJp/Fc/M2+LvuRJCYPirt/6En6gzP7peRXinspusK6wDMrOsqHvBp3zPn/U+8ytlEEdbVCEb8j6oKKVh6IfTdwjkT2agfpTtiva81oTUtc4hlNjZEqwa4NKa1diJLHTb2qtGll2bKwpnuQkQmQT27qssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164187; c=relaxed/simple;
	bh=IQDlbN0b0ogcK7/GdmGKU7CZ87Opdm9yoKNmRXaJlao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RcaFDfC1TtlX74p9kORMyg3XBlG6Mh+EJdzVtwg3EOyi4c4iZ+g3YA7DJpIYShtRClt1K+perLzjL0BsGvsTREOF0i2SzsTi2Vp4lsU0d592XLlxpcOgg80ZcagfjNZE6Y4EILNK8PEWHGgHYrqyyPtcNPr2S4Wod86ZDJGMgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c3902f73fso210348539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753164184; x=1753768984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jx3dkqpflrybn++fpEE8HXDbBVG9p5IhOoxxSLn734s=;
        b=WdQMCoYvD0jgs4ta6PH7COedE3OZe5rZFCISvbmTQO5Edm9uol1OIGztwK1wRJIm2z
         juoEkLZJoS4C9vciQ+rxO1TL+ofEP8AgLDkraDeVrrlKopaLwdf1/xOURT81e34Dpudh
         Aw8cWza1jhU8ikYwsgn3VPjfEfjwfi1+QjRFnnE2s0UbYdnBqxI3zgkgChTinG1XT1yK
         O7FDLCfN65KimAHDfCcXnynidlkIns29lbqqkfAc6X0ooc9nL8BPMpQcG0xQmWkiJH7Q
         wntEthDBAfbjBQgWseCKXRZwC6U3Q85vRgxidO388Q89QCLfWw/Oo1QMW+b6H8iEHnj7
         NrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwOMwbq6v15FcFylXkW8gdzYBziXYWD7SDEP2wmYGdyQsMu+WUAge41Q8W4bDuf4cwXAvg8Oaa9XxSscw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZxrKmVdQqvuR5vUcwOlGA35WsMR9j67AqeoPRP2/yLmTUTbXC
	PgxSZn4YoLnNdKxnSiyy8mIpbWLee1KS5In3uGFSG36dtmfWPJmIvaR/VgpeaCNkKK7r2Wqn1b9
	xBkElTAGEvTnp58tg6RJ1ZgaEC+QW0AXgJdbQAWmQyjUQPu0rPd6+v0cI+kU=
X-Google-Smtp-Source: AGHT+IGqKsfEeaYEw4llvKvbptOhiyfElwamw7OjLbYzk1ReyjIK/8c3RTKnj80kvk8U0WO8atd7tcZB6Yw3extG7IHhK50v2tNc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:6816:0:b0:876:737:85da with SMTP id
 ca18e2360f4ac-87c536913a2mr317372639f.0.1753164184480; Mon, 21 Jul 2025
 23:03:04 -0700 (PDT)
Date: Mon, 21 Jul 2025 23:03:04 -0700
In-Reply-To: <ank5qnbeu55cd7vktzjd2iagozehy62m4v7bbapnmsbxcks5zv@xb6nlrhtsk6x>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687f2998.a70a0220.693ce.00f7.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_cmd_complete_evt
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: ipravdin.official@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hci_cmd_complete_evt

=====================================================
BUG: KMSAN: uninit-value in hci_cmd_complete_evt+0xca3/0xe90 net/bluetooth/hci_event.c:4210
 hci_cmd_complete_evt+0xca3/0xe90 net/bluetooth/hci_event.c:4210
 hci_event_func net/bluetooth/hci_event.c:7515 [inline]
 hci_event_packet+0xce2/0x1e40 net/bluetooth/hci_event.c:7572
 hci_rx_work+0x9a8/0x12b0 net/bluetooth/hci_core.c:4068
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb97/0x1d90 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd59/0xf00 kernel/kthread.c:464
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 hci_cmd_complete_evt+0xc9c/0xe90 net/bluetooth/hci_event.c:4210
 hci_event_func net/bluetooth/hci_event.c:7515 [inline]
 hci_event_packet+0xce2/0x1e40 net/bluetooth/hci_event.c:7572
 hci_rx_work+0x9a8/0x12b0 net/bluetooth/hci_core.c:4068
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb97/0x1d90 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd59/0xf00 kernel/kthread.c:464
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was stored to memory at:
 hci_cmd_complete_evt+0x775/0xe90 net/bluetooth/hci_event.c:-1
 hci_event_func net/bluetooth/hci_event.c:7515 [inline]
 hci_event_packet+0xce2/0x1e40 net/bluetooth/hci_event.c:7572
 hci_rx_work+0x9a8/0x12b0 net/bluetooth/hci_core.c:4068
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xb97/0x1d90 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd59/0xf00 kernel/kthread.c:464
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4153 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4248
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:578
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:669
 alloc_skb include/linux/skbuff.h:1337 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:509 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:488 [inline]
 vhci_write+0x125/0x960 drivers/bluetooth/hci_vhci.c:608
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0xb34/0x1560 fs/read_write.c:684
 ksys_write fs/read_write.c:736 [inline]
 __do_sys_write fs/read_write.c:747 [inline]
 __se_sys_write fs/read_write.c:744 [inline]
 __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:744
 x64_sys_call+0x38c3/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 53 Comm: kworker/u9:0 Not tainted 6.15.0-rc6-syzkaller-01366-g0ba714749722 #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci0 hci_rx_work
=====================================================


Tested on:

commit:         0ba71474 Bluetooth: hci_event: Mask data status from L..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13122f22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38456bfd5c806d6d
dashboard link: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.

