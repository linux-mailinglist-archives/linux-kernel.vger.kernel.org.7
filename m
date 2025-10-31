Return-Path: <linux-kernel+bounces-880065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7806BC24C94
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A55F4E711D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DB8345CCA;
	Fri, 31 Oct 2025 11:31:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19283451DA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910265; cv=none; b=bFM4IKyyK1XIoNG1mMWmJDI/OtBjiYYOPqkVehApLomdqtDfMnYuJKaIaX+0jAh0gV8yM6KW0TuxvGcHZ/ctF4iGAEg5neub8SAUCotT0At1x4M5VJc2rDc9d9pNz7GsUcOAhRKhysTsLjHFy4277/6ArrViMPYtaKiCP05fUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910265; c=relaxed/simple;
	bh=15a9IScHu/gFUHl/yQcEbM3+6aphC6/HGCElm9xf2yI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EJge/3MsRsGL4wg38dFZNxOJW877bNwXuJy6r7lfwEcPIohln+XNk0z62Epqj9ZMbGQjsRCxERBPh7TSGxIrKk0CGlq7WcXA8tAF6Uugl8llyJbwfr1pAvEXyobD8JG5U4UH8eGd7jHwzT6S7HGwIwLZo9j/6dLICnwt7Pjb7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43300f41682so22115065ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910263; x=1762515063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErkKB/oq/E94iGnfIiDbwaTL+mu7b1vVlOZuJ6dBXt0=;
        b=s4lRt81jUkN+R5jaIzkO3yXOfCyfo4uq1Q7m5axfi9X0h7JLHzg4nWDOXtZd30B7U0
         o+PYHvr+SqNiTUgfIW3errHeztDL1XzMlul/ZWD6H2iEzR689x+T31+FZIFhNkhig+rl
         vfvxa3Law6hZMB2qjjTEcQ80og3nqkSoWSFGQghk2ZRVxm3yq58yAhg9wHvNsNDbYCjm
         XhqyFZFZShgAUv2FgWFwp3JdWNIwBQJdP3tSV+YvH04hrs2UxFsqPSY1ke7Nz/+vZUlv
         qBN6/RjWa7Edth+SeDOefLDrptUlXBpluxO+xcw4PujHwDwqPAeBlLckGVDADLgEVCDZ
         3WQg==
X-Gm-Message-State: AOJu0Yw0dmubpgOSiNvzVMytnJWzABZ+js1gB4Nf6TjG+g5zNIfHGYfF
	3Tx+0WY7dEAsrEom6xJAHsU6++mS/HaUANGA0axUOjnNJp6HDze94B5cfSs80yq7lq6Bz/AoQM+
	5J5Me442d9vxKortAjJRDDabhqpSF5H+wSZxvWRR1mRf2i1qARIRVSUvvfvw=
X-Google-Smtp-Source: AGHT+IEMRyEUtKQRBZyzUtKNLshaBGflTsWOuO4k6nT5H+MzrmQMfqRfSYe2mgrCjx7QyntKNI6R3E1eTFI5WGx3mMZvgfaKs1gV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168d:b0:431:da5b:9ef3 with SMTP id
 e9e14a558f8ab-4330d1cf1a5mr53974955ab.27.1761910262965; Fri, 31 Oct 2025
 04:31:02 -0700 (PDT)
Date: Fri, 31 Oct 2025 04:31:02 -0700
In-Reply-To: <aQSN9-E4Q7fdlQ2C@orbyte.nwl.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69049df6.050a0220.e9cb8.000c.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (9)
From: syzbot <syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, phil@nwl.cc, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in nf_hook_entry_head

------------[ cut here ]------------
WARNING: CPU: 0 PID: 36 at net/netfilter/core.c:329 nf_hook_entry_head+0x23e/0x2c0 net/netfilter/core.c:329
Modules linked in:
CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: netns cleanup_net
RIP: 0010:nf_hook_entry_head+0x23e/0x2c0 net/netfilter/core.c:329
Code: 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ff e8 7d b9 b6 f8 4d 39 37 74 36 e8 53 04 51 f8 90 <0f> 0b 90 31 db 48 89 d8 5b 41 5e 41 5f 5d c3 cc cc cc cc cc e8 39
RSP: 0018:ffffc90000ac7768 EFLAGS: 00010293
RAX: ffffffff896eff5b RBX: ffff888030a98000 RCX: ffff8881416b9e40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8881416b9e40 R09: 0000000000000006
R10: 000000000000000a R11: 0000000000000000 R12: ffff888020ec8000
R13: 0000000000000005 R14: ffff888020ec8000 R15: ffff888030a98108
FS:  0000000000000000(0000) GS:ffff88812613e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2e4b7156c0 CR3: 000000000dd38000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __nf_unregister_net_hook+0x74/0x700 net/netfilter/core.c:491
 nft_unregister_flowtable_ops net/netfilter/nf_tables_api.c:8977 [inline]
 __nft_unregister_flowtable_net_hooks net/netfilter/nf_tables_api.c:8992 [inline]
 __nft_release_hook+0x180/0x350 net/netfilter/nf_tables_api.c:11985
 __nft_release_hooks net/netfilter/nf_tables_api.c:11999 [inline]
 nf_tables_pre_exit_net+0xa7/0x110 net/netfilter/nf_tables_api.c:12150
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x990 net/core/net_namespace.c:234
 cleanup_net+0x4d8/0x820 net/core/net_namespace.c:696
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         0d0eb186 cxgb4: flower: add support for fragmentation
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=162a7fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5683686a5f7ee53f
dashboard link: https://syzkaller.appspot.com/bug?extid=78ac1e46d2966eb70fda
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

