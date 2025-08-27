Return-Path: <linux-kernel+bounces-787730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F5B37A51
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB23721BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB192D5C6A;
	Wed, 27 Aug 2025 06:27:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C032C8B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276025; cv=none; b=Kx4xefd0rePhznEHGU9qzQTiVJ8X9+GlOi115tnhviV3WpW/pZEZmQQT6je3xo51QExUkpFWl87REr4Vz3LPVUBkK8BOLOY68tpgRO4/GyDOVEDOTSsA5nCz1GTozAWFEicnuHi7Zjl32nR59LWFYhFHt4CuxUaTTQVQq0mDnto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276025; c=relaxed/simple;
	bh=BaOB2wUgO6wT4K9E8CZxA/a3ccVoHvo5aEmQcyss6l4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tjXyP2lwObDry1+y4lJqkIfDjdMibCXQJy/b495Mi0QfLTovnRSqHnzdIxOYhAn6RYQdjtV+ZCyu/Zdk4CYhd1TAuZcDWQqwHlVjlhJ4g7Z/AsHIlHcvueoDu+yO3tC4E7bfViWzgbq7yLL1cNQP2egH2VsC1Gwn1TQScqmnkiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-886e2e808e8so538913339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756276023; x=1756880823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9hVNUdnN+NU1jMeEzo+F9uGj3CFUUWuep/0sPD7asw=;
        b=w6y+HdBLZTWkUuGnB+MAlLN70o2vQfZW3T1HWKJLkXBbeLzrbhfxpvOgw2fNAWt+kz
         koDe6KTV9yEI4jMPIxDvzqLw1x5QHo4eL4x9bsh285cJRT+bbOS81vey9Lw2qBlPIMb7
         F79EWDme5FAeg3KLrRgiOk7+q8OwMen7rIgpJ4kjBNpPVqiZSu4Mb08ev65t+l/bq4gH
         JjHz7vBxWLJx34bFG2BXUHMjQRXLaON0sah11k341yNN+JMjaS+Y3L6J0UtIIAx3XIVo
         wd3f8NOsxB202l6bY3aFliIO/QEsG/eYKx3+JDRgC7UZKb18WGOCnCAjlgU5Zry8fUn5
         Y78w==
X-Forwarded-Encrypted: i=1; AJvYcCWFakpnxO+bDB23HyWjifi9LyTHaqcI9FaIRovbjKDRZfcNShtcvh95o3zKA78f3QKHx1/okUF6Zdmu+vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfuZ9tW0AxbPG4mfhXqVegCN8fXTjKF8p4RpNR7JeFXfdI10AW
	tNpCb9hlIMb/yGnV7QHuG6kL+w+5k9Lbr3VZeyYQi0g3vLSCor1NrdYFNtXM7ZgbfhLcPh69+ac
	lpYVawQAqtQJLgpI3+BuY9uoQ6psT9quWshh80SyzLqPPN3jD84XZbhFSs+s=
X-Google-Smtp-Source: AGHT+IFDf34OszhBNcx/LVD+3QbB0WkaN+B2vGPIHagvnsh0WNMvJFpTNRV7B1ONi8ibjJVlfzGW47J8rz34v6hHEFM3EE784mOr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c11:b0:880:f288:e8e5 with SMTP id
 ca18e2360f4ac-886bd14efd8mr3023221839f.5.1756276023429; Tue, 26 Aug 2025
 23:27:03 -0700 (PDT)
Date: Tue, 26 Aug 2025 23:27:03 -0700
In-Reply-To: <20250827045138.5764-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aea537.a70a0220.3cafd4.000d.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in xfrm_state_flush

------------[ cut here ]------------
WARNING: CPU: 1 PID: 13 at net/xfrm/xfrm_state.c:801 __xfrm_state_destroy net/xfrm/xfrm_state.c:801 [inline]
WARNING: CPU: 1 PID: 13 at net/xfrm/xfrm_state.c:801 xfrm_state_put include/net/xfrm.h:929 [inline]
WARNING: CPU: 1 PID: 13 at net/xfrm/xfrm_state.c:801 xfrm_state_flush+0x7d9/0x910 net/xfrm/xfrm_state.c:950
Modules linked in:
CPU: 1 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:__xfrm_state_destroy net/xfrm/xfrm_state.c:801 [inline]
RIP: 0010:xfrm_state_put include/net/xfrm.h:929 [inline]
RIP: 0010:xfrm_state_flush+0x7d9/0x910 net/xfrm/xfrm_state.c:950
Code: bd 1d 9f f7 90 0f 0b 90 e9 33 fd ff ff e8 af 1d 9f f7 4c 89 e7 be 03 00 00 00 e8 32 6d a7 fa e9 01 fe ff ff e8 98 1d 9f f7 90 <0f> 0b 90 e9 50 fe ff ff e8 8a 1d 9f f7 4c 89 e7 be 03 00 00 00 e8
RSP: 0018:ffffc90000127820 EFLAGS: 00010293
RAX: ffffffff8a208d98 RBX: ffff88807a6fddc0 RCX: ffff88801cec8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000005
RBP: 0000000000000001 R08: ffff88807a6fde2b R09: 1ffff1100f4dfbc5
R10: dffffc0000000000 R11: ffffed100f4dfbc6 R12: ffff88807a6fde28
R13: ffff88807a6fdef0 R14: dffffc0000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125d1a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ca06d5e9c CR3: 0000000074866000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 xfrm6_tunnel_net_exit+0x3c/0x100 net/ipv6/xfrm6_tunnel.c:337
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13939ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150ca462580000


