Return-Path: <linux-kernel+bounces-812828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0FB53D32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914987A9EED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773C62C2361;
	Thu, 11 Sep 2025 20:39:35 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533A274B2E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623175; cv=none; b=Z1CyUXAOS+UJS1ilIDYzBcii2/aXKrG8exg1qmsc+dXoz+c/HxTWLEwEvjQHOiTvDZ7mGR0FwRT2NPSmDe5h9eAwNaOsjTXQWL+JVjWTq2TkoikvCRiev1iv4S4brM7n9oWflb2eOB3+/RHBupD4kPc/UlsysnJ63u8FupLNdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623175; c=relaxed/simple;
	bh=sE7Xhd4nymptzNrbw8FwvycuTvZ9DppJQbty0Pc23PE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CM4+ysyM9WhwLwVSbynf+W1Z1R1q8PdpTQoxHfcfpZVb7KGBRrazM+96mWDqW5zUrMcIaWXi9PUf1z2SleDGfRqZW+dXF+MDjCjzJkRMdHweNlLoRHlSXLAn6uIMLC4z0F7gdxTZtLIoDdl+wTiIaw+mWt0T687cgseRCuRyj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-888acb964c8so282084539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757623171; x=1758227971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jJzln9Oxv++8k8GF8gqWoPMM+xkj0dtehYwHya0GB4=;
        b=oqrId7CQb6JbXPNtUfIfLNuZGWY/vOyqbxA/O9gGb5KUiOuKBxGpAeRSTdVaBVIS10
         UXlfp8SFcTsF/y0gMUHX5zxjHI+/JQp3SCE0V3LkCc0fHiIVXXdGfWfAB4yaQUJ6C+QY
         d0AxX2dkGthGJ+fIRp/GAyk5aADDDk2HlG7IcbFXS9Pd8mODjzTPnML7W8XtlgeAmMAN
         v2wUWGo2KygCOJyhCeNmcFwnrxtsXzpqnezIQVB8wakkF7WG3zGnDNQbc7EO80/dqN3B
         J1TOhjJ8Qp/ttjnxY0fge04WvHg65/euJnsdycB1PQ0EbiSPAbQSCZZZs1hSzp/I83J1
         LFSA==
X-Forwarded-Encrypted: i=1; AJvYcCWIdpSLMyay4ZTGW8oFotjntTjpdb0+3qcjxE8kTeqDc1Q3o6K12jRlQ/lbvztJ09/roIc28dqwYpZabQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzs7RiSJXP0l0qDzNysVCvKamuJDBrn4CWyePs1OQMqDzHXQul
	oOXhAgqEXKr0M9qtzhs+LBcfCGItssDS9FLFX/udKm2mcsr3VSVrn3VVNpGPtpTA8yL5CU+LPA/
	kA/+/q+U4Xe1ej3VsBhcrpnj2vJjZHLOPn6qjpMHk8ykyAh7temkRfuv/RqY=
X-Google-Smtp-Source: AGHT+IEKo2i6gsqDbr7f9ef/ZJegwOu6Gj24s140BtY1OYu2xELtUBOFNc9xaY32a8rWUzDw0ng4jgtQUocBmXi78ZBwSUD05pvY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4806:b0:421:3a23:7099 with SMTP id
 e9e14a558f8ab-4213a2373f9mr3572755ab.19.1757623171591; Thu, 11 Sep 2025
 13:39:31 -0700 (PDT)
Date: Thu, 11 Sep 2025 13:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c33383.050a0220.2ff435.024c.GAE@google.com>
Subject: [syzbot] [jfs?] kernel BUG in lbmIODone (3)
From: syzbot <syzbot+a5bcc0f04f7131679010@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b320789d6883 Linux 6.17-rc4
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13ea0642580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39f8a155475bc42d
dashboard link: https://syzkaller.appspot.com/bug?extid=a5bcc0f04f7131679010
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c497ec86c8e2/disk-b320789d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1d08f5d7b1c/vmlinux-b320789d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a27a997250a/Image-b320789d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5bcc0f04f7131679010@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_logmgr.c:2303 assert(bp->l_flag & lbmRELEASE)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_logmgr.c:2303!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : lbmIODone+0x1294/0x12e8 fs/jfs/jfs_logmgr.c:2303
lr : lbmIODone+0x1294/0x12e8 fs/jfs/jfs_logmgr.c:2303
sp : ffff800097c678d0
x29: ffff800097c67960 x28: 1fffe00018c38ca1 x27: 0000000000000020
x26: 1fffe0001a4f064f x25: dfff800000000000 x24: 0000000000000000
x23: ffff0000c61c6508 x22: ffff0000d2783278 x21: 0000000000000000
x20: 0000000000000020 x19: ffff0000c61c6500 x18: 1fffe00033797688
x17: ffff80008f7de000 x16: ffff80008b00ff28 x15: 0000000000000001
x14: 1ffff00012f8ce90 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700012f8ce91 x10: 0000000000ff0100 x9 : 4257e84271db6d00
x8 : 4257e84271db6d00 x7 : ffff800080563d2c x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff8000807de8f0
x2 : 0000000000000001 x1 : 0000000100000101 x0 : 000000000000003f
Call trace:
 lbmIODone+0x1294/0x12e8 fs/jfs/jfs_logmgr.c:2303 (P)
 bio_endio+0x858/0x894 block/bio.c:1651
 blk_update_request+0x474/0xba8 block/blk-mq.c:989
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1151
 lo_complete_rq+0x124/0x274 drivers/block/loop.c:314
 blk_complete_reqs block/blk-mq.c:1226 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1231
 handle_softirqs+0x328/0xc88 kernel/softirq.c:579
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:968
 smpboot_thread_fn+0x4d8/0x9cc kernel/smpboot.c:160
 kthread+0x5fc/0x75c kernel/kthread.c:463
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
Code: f004c2c3 911c0063 52811fe2 9793a804 (d4210000) 
---[ end trace 0000000000000000 ]---


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

