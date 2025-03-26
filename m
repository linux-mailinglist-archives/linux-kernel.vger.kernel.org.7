Return-Path: <linux-kernel+bounces-577710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA8A7209B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 22:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0373BE8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1525FA31;
	Wed, 26 Mar 2025 21:13:31 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164A261373
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023610; cv=none; b=UHLm3ITILElNM59xhb/zx0YgcPQSwpdt7MUKi2LvW5V2hJAUMXeGWhcbQ/HtftNTPlKa7VuerbuOosxzJS6p1idq6FFeLgpxPMaw81W8oj3Df72dpt7TAKFPEoKFOw6JhzMRyCWMgENje8xMQoBkjOaqa71EUrVZ71QlMeOrRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023610; c=relaxed/simple;
	bh=/KWdbS8/joW2iD1JevCtRTM1rYNd6cf0i7F0cOqel4M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K8mgBLowvQyIhXSp3UHGL3cm0SrhS5G3kL8WRGGDRQoYlHucetIPFeAv0F/iGgWwsZaorQXRJ0brdmrNHNdCRWgbTaJzMPTx2wsUJNkwMPvBkt4s0SZLFjAWlVS4mbDsMTM0RgvPiR4msZIJBu1WZ9Gcb2ZUn153Wa7Gp9nt6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85da19887ebso71861239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023608; x=1743628408;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k79YQHIzUDhwHvSN4MUDlJaB44p7E+PisDw0heO3Hx4=;
        b=h2J8BkCeELRcIrOETxf8PHigaGBP+MwcnyL+bLZEuGx5W00iuepLIc24YJRC4bGqZy
         kSbRVskrpdtogU1f+wtnlgKH4V/RXSZ3Jg/x7wtPFhxqG3N79YMfIkqhfX5p8ARhYZVc
         L0WP/439jeAkTTuvoQs1vs0BqFs6JO9Aj/73jUQPZqZaI5GQnSsFdk2FlxAGsk3WRzxs
         d/vji5f/MsJ0isqJb2AInmQTnLL1VgvlVj6e9TFvYZmC/AuZM4S8Vj6x3a5auIdKnTUJ
         OxnwtijmBdfTirnwR+98WftYSg4aZXPa27dcJP28PPSwupAfQkJB30It6HVrTFvghK/R
         lrCA==
X-Forwarded-Encrypted: i=1; AJvYcCU9bQBhCdiipna5P62reOOa/AYd72YknAZ7x57rMxOHQ0k7r/x4cTO+ILQ0SVUNY5yK34HgbuT86fHW29g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//+x07+W6ZOmCS3i8qaYV+7OZI45SQhhizDLlSeaEkUAn4tTu
	db8lXHreEFyDB319yQ/6pYSP3acvYMzL6Ik8UbaT4FIavUWPMqqfOVcmMd+HlC028dvvliObEwx
	J8VVpFbG2NPMR0O1gQtFEMkXWztreLTmcPW4PR18YQ3l/o52b1X3EO4Y=
X-Google-Smtp-Source: AGHT+IGavhDViMeLVe1t3XTwp6jK7VmudcxvWFdBCzYiAbPtPVeiQmYWKwJqLXBlizUuOkKfY+2e4SDI1Cy/841LfZp8jcKMuGt9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:3d4:244b:db1d with SMTP id
 e9e14a558f8ab-3d5ccdd147amr15239435ab.6.1743023608083; Wed, 26 Mar 2025
 14:13:28 -0700 (PDT)
Date: Wed, 26 Mar 2025 14:13:28 -0700
In-Reply-To: <6755b44c.050a0220.2477f.002a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e46df8.050a0220.2f068f.000f.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bucket_alloc_trans
From: syzbot <syzbot+c761143a86b1640bc485@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2df0c02dab82 x86 boot build: make git ignore stale 'tools'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=135c6a4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afd286fb06ecc311
dashboard link: https://syzkaller.appspot.com/bug?extid=c761143a86b1640bc485
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10355804580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c86198580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4df46ef3da39/disk-2df0c02d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7585a408245b/vmlinux-2df0c02d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f16d3f20d29/bzImage-2df0c02d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e2708f9fb487/mount_5.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c761143a86b1640bc485@syzkaller.appspotmail.com

  fragmentation     0
  bp_start          8
  incorrectly set at freespace:0:31:0 (free 0, genbits 0 should be 0), fixing
=====================================================
BUG: KMSAN: uninit-value in try_alloc_bucket fs/bcachefs/alloc_foreground.c:297 [inline]
BUG: KMSAN: uninit-value in bch2_bucket_alloc_freelist fs/bcachefs/alloc_foreground.c:442 [inline]
BUG: KMSAN: uninit-value in bch2_bucket_alloc_trans+0x2191/0x3280 fs/bcachefs/alloc_foreground.c:574
 try_alloc_bucket fs/bcachefs/alloc_foreground.c:297 [inline]
 bch2_bucket_alloc_freelist fs/bcachefs/alloc_foreground.c:442 [inline]
 bch2_bucket_alloc_trans+0x2191/0x3280 fs/bcachefs/alloc_foreground.c:574
 bch2_bucket_alloc_set_trans+0x935/0x1620 fs/bcachefs/alloc_foreground.c:730
 __open_bucket_add_buckets+0x1e98/0x3130 fs/bcachefs/alloc_foreground.c:973
 open_bucket_add_buckets+0x32b/0x530 fs/bcachefs/alloc_foreground.c:1017
 bch2_alloc_sectors_start_trans+0x1839/0x32d0
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:322 [inline]
 bch2_btree_reserve_get+0x9eb/0x22b0 fs/bcachefs/btree_update_interior.c:532
 bch2_btree_update_start+0x22b8/0x2ec0 fs/bcachefs/btree_update_interior.c:1232
 bch2_btree_node_rewrite+0x1da/0x1af0 fs/bcachefs/btree_update_interior.c:2144
 async_btree_node_rewrite_trans fs/bcachefs/btree_update_interior.c:2217 [inline]
 async_btree_node_rewrite_work+0x74c/0x1aa0 fs/bcachefs/btree_update_interior.c:2253
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xc1d/0x1e80 kernel/workqueue.c:3319
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3400
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Local variable gen.i.i created at:
 bch2_bucket_alloc_freelist fs/bcachefs/alloc_foreground.c:442 [inline]
 bch2_bucket_alloc_trans+0x1fb2/0x3280 fs/bcachefs/alloc_foreground.c:574
 bch2_bucket_alloc_set_trans+0x935/0x1620 fs/bcachefs/alloc_foreground.c:730

CPU: 1 UID: 0 PID: 4283 Comm: kworker/u8:21 Not tainted 6.14.0-syzkaller-01103-g2df0c02dab82 #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: btree_node_rewrite async_btree_node_rewrite_work
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

