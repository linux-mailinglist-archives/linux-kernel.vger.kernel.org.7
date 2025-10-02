Return-Path: <linux-kernel+bounces-840494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C007BB48B0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1103B04C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E22263F22;
	Thu,  2 Oct 2025 16:31:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7B1E3DCF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422666; cv=none; b=cilb5aX/oLBiK6gMpFnLS80YmQw56Gmcba7F+ZE7w17ByyOIdSn1MvzupUDNic7vW1CmgzXKSZp0IwTtU6NBunFd1cb4/GHmo1EBki+Rd2jN2x3rsOh5Sso7xbvrnVHDNd8jwM332zIBM4VfIPu+bBlL+c4Q3Au7FDg92e4Tt6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422666; c=relaxed/simple;
	bh=PP0pX6rgA5JGT8Vw9HCAJcKj0ABWCus8xUv3bZa5ZMA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YCwHYX5QR0up+Tj6jf7P1KiQvdluEEAJpd0WWSAQ/BpvprwkLrFupuknfhDPkjchOBtRZR8xiyxnuWxQfSCjsJde5KT6/12b+M5anZfa7s+q7yz1N6D1nEMwUWg8gB/J+hej1Efa/IdXR9cIqIr2PH/n8f/LudN7rxND/eEWvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42d8a0ce20aso18115655ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422664; x=1760027464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeFKT/7Ey6/Kc9/J0NxZR/hdvfpXgq9fYy75uQai+mU=;
        b=d5h2Hd46/1swvkHamPLK9vn2/256lvAjjoqhrCctvlO8BYNuMIRCpH8JuIG6LBpcjz
         du4vc9Ysx4cYE9LVLyhFkDmEChroocD8a8+cgkUTcgZo7d+RvacAVVwopc1rmAAeKzRz
         BJo1U+vXrLicv43evpkmvKSGmSUgANaQyMujdnNMmQ7qrQaeI/hfUF41W2WHKaXXv42J
         /9YdQ93ch9xPaGLZ39pGbZAu1lGNGJddCBNWWUOmwDUKcR40Mwt29XTL/NUKCQ0QsfjQ
         fXnC9cKHsnxNi3QoAJ7Lt5RawJsdr4HlH2crP+fcHy0V8EZFYixNfhO9GK5392XGHQ9Y
         jRmg==
X-Forwarded-Encrypted: i=1; AJvYcCWW79a9a1o+mXIGwW6jPCaTErqKszQQuEdBryWfBv8g5B03yJp1oB48328UOsRb3ChLWyn7je+rGclJdq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09N26Qxj5z0i7sMwR/3P+8NarZRqn3YCPXT4i4AJKIY9I1RjY
	M147vDz5LwpGjTDd/ycsDz9vCIXj4bpj2r6W62NKfzrzw0LOfPwKTi2snV3chkSZnCSZzlD/IsR
	SpEDWKGX+IC375H956YdOZgX3x8PNxgUV/34DNOAWgJeVncBggFnCss4bWG4=
X-Google-Smtp-Source: AGHT+IHI++pJy1HWaqBmhmspp99OJkMFDvzWt6I2r0ornTdRwh7AR5uO9XcvAFB8BEIQRkW4CL7+tX5E8y3gBV0xMu276XqiO24t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:42e:7ab6:ec89 with SMTP id
 e9e14a558f8ab-42e7adb4d1cmr1767025ab.32.1759422663701; Thu, 02 Oct 2025
 09:31:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 09:31:03 -0700
In-Reply-To: <aN6laD5P8zq0F5ns@Bertha>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dea8c7.050a0220.25d7ab.07ce.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
From: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To: contact@gvernon.com, damien.lemoal@opensource.wdc.com, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in hfs_write_inode

------------[ cut here ]------------
kernel BUG at fs/hfs/inode.c:444!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 1438 Comm: kworker/u8:9 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:hfs_write_inode+0x7c8/0x7d0 fs/hfs/inode.c:444
Code: c1 40 c2 05 99 80 e1 07 80 c1 03 38 c1 0f 8c 7d fe ff ff 48 c7 c7 40 c2 05 99 e8 e3 dc 8c ff e9 6c fe ff ff e8 a9 96 2d ff 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000534f180 EFLAGS: 00010293
RAX: ffffffff8290d517 RBX: ffff8880323301c8 RCX: ffff88802787d940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000534f310 R08: ffff88802787d940 R09: 0000000000000003
R10: 0000000000000100 R11: 0000000000000004 R12: dffffc0000000000
R13: 1ffff92000a69e34 R14: ffff888032330188 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881269bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff2f4ecb000 CR3: 0000000036660000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1525 [inline]
 __writeback_single_inode+0x6f1/0x1000 fs/fs-writeback.c:1745
 writeback_sb_inodes+0x6b7/0xf60 fs/fs-writeback.c:1976
 wb_writeback+0x43b/0xaf0 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x40e/0xf00 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_write_inode+0x7c8/0x7d0 fs/hfs/inode.c:444
Code: c1 40 c2 05 99 80 e1 07 80 c1 03 38 c1 0f 8c 7d fe ff ff 48 c7 c7 40 c2 05 99 e8 e3 dc 8c ff e9 6c fe ff ff e8 a9 96 2d ff 90 <0f> 0b 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000534f180 EFLAGS: 00010293
RAX: ffffffff8290d517 RBX: ffff8880323301c8 RCX: ffff88802787d940
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000534f310 R08: ffff88802787d940 R09: 0000000000000003
R10: 0000000000000100 R11: 0000000000000004 R12: dffffc0000000000
R13: 1ffff92000a69e34 R14: ffff888032330188 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881269bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff2f4ecb000 CR3: 0000000036660000 CR4: 00000000003526f0


Tested on:

commit:         e5f0a698 Linux 6.17
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.17
console output: https://syzkaller.appspot.com/x/log.txt?x=13b28458580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

