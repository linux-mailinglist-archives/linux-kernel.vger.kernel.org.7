Return-Path: <linux-kernel+bounces-787597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD1B3786A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894A2361850
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBF2BF01E;
	Wed, 27 Aug 2025 03:03:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE6280330
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756263786; cv=none; b=KU8GDl/JNAwI/vLSXDemi3xyCKCuQXjOw9m0TBttIdzrj063AuPV4mpCBz9tS5KOInAK68FAQWx6PNwLmzf8PJEMIqeMLVbih0PEsK6rUY2CGtS1tX+VcyMQGoko22cgAxj09UtFtsOHMsaMO6uUQ44d2jAxau0ibecFb3nMhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756263786; c=relaxed/simple;
	bh=MCZaek7/73Mbf67awWwWzyG/c1bRfgViaF9mbBdNQQU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p2e7W5Va2hCjWdICZrHTQEc5juEyFiTm9yE5bN+ymjqeAR0ouOWQ9wLmPSeu+k2gN7590cieBFvUWpKsoA63QNyLQ3HdfPLBH7NDQzK3uHzP0zKvfvCr7QW2xa9Xk/B/FNNQifjcBbk4HtyKWzjckPLfkkAo7iY3ocUe27L7XnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3eed935cd97so17821915ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756263783; x=1756868583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTIIztX8TABs9J2+7NMorePJMfwGAjefCOpDk/sbvAQ=;
        b=fAwVVmjc/xQdBQcP0Vpnvxn8L2OtpE1wSS/ezdgiilLH+nVARksbHIOGIw6N+erF26
         pxKWwX40Y3eTPuIt2i47UVYBOEp46PZbFWH3RH+cfWZan0PjX7BBgVorVerr4a2XMoDn
         Lkb+LXZLwFZO6kIA5Bfl9jU3gXdrKfV3WfD7N/XxWR6HKz2BS5TAEcQ6HhWbAgyetXwk
         Sa4EI58VIkzh3vTbW3q4gllVBa1LvcEyXpQxOG69SCBQX/dXh/MWRGm989NiR1MAYu3U
         QTbuayDlUpTur5MsXUDfjl5zZyTNwWDqG2va77hfnXUCV72i/SA3t7b3MJQmLE25+Eqm
         N3nw==
X-Forwarded-Encrypted: i=1; AJvYcCX1ib+KZ7uXlSHd6j1BkS9VAHa7nbhm32LZZFPx4y6V//cuWaIQIaPFZZj8kkAgUUsX07CxCdoVTYS9Oac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA2flGXZOnUZj9C9NhUay+KnzeqaG3vuM0/AMo3YauNdyko/jI
	lwM1Oy7AALq1jv9DU7nhVe6DTNMAAk432taW+X+P438xtg8xA6r+8WT0zX8//ypV2tCOFL5Yl2Y
	Xv9oybah7+S1CEfq34yXv1jQDZs46FEx83JszYxQg2W2ELrh/TwIu2yscf+I=
X-Google-Smtp-Source: AGHT+IFD986FgoEH3+lDaXRnoxr4fYrJITbSQtbvgVtRTLriO4wUGLrv6/YkTwCIZPH5d5zB4TOQOZ1W8Mh5+4iH6Vb37I98QrQd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:480a:b0:3e9:4547:5e03 with SMTP id
 e9e14a558f8ab-3e945479d7dmr213267125ab.10.1756263783150; Tue, 26 Aug 2025
 20:03:03 -0700 (PDT)
Date: Tue, 26 Aug 2025 20:03:03 -0700
In-Reply-To: <tencent_B2496343B244447773976D66CD936C237A05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ae7567.a70a0220.3cafd4.0006.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in xfrm_state_fini

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3658 at net/xfrm/xfrm_state.c:3301 xfrm_state_fini+0x26d/0x2f0 net/xfrm/xfrm_state.c:3301
Modules linked in:
CPU: 1 UID: 0 PID: 3658 Comm: kworker/u8:14 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:xfrm_state_fini+0x26d/0x2f0 net/xfrm/xfrm_state.c:3301
Code: c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 6b b2 00 f8 48 8b 3b 5b 41 5c 41 5d 41 5e 41 5f 5d e9 29 73 e1 f7 e8 84 46 9d f7 90 <0f> 0b 90 e9 fd fd ff ff e8 76 46 9d f7 90 0f 0b 90 e9 60 fe ff ff
RSP: 0018:ffffc9000c5c7898 EFLAGS: 00010293
RAX: ffffffff8a2264ac RBX: ffff888033aa8000 RCX: ffff888030f70000
RDX: 0000000000000000 RSI: ffffffff8be33660 RDI: ffffffff84d05cc3
RBP: ffffc9000c5c79b0 R08: ffffffff8fa38437 R09: 1ffffffff1f47086
R10: dffffc0000000000 R11: fffffbfff1f47087 R12: ffffffff8f631480
R13: 1ffff920018b8f40 R14: ffff888033aa9480 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125d1a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67e456d480 CR3: 0000000079c90000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4354
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15d69ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142d77bc580000


