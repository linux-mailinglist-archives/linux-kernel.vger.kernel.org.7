Return-Path: <linux-kernel+bounces-785969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A8B35305
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91693B139A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A572E7F0B;
	Tue, 26 Aug 2025 05:12:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D0215077
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185126; cv=none; b=N1M2oQ7p/C7T9fv0dV4rg6iqJAN64HJ2tgcQK7YLWfcHcb9bSyJ8CBxyBNWdQGICewAjzA87zcpzkyKpNnQXwyZRHRIvxQqppoz/KJ++ACOgUrOWtKEGKztZb4PTsmvSnWcUEPGXgtlFMDwF+5xWdns4m4YaZKGnY3m17E/vp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185126; c=relaxed/simple;
	bh=zLSXYvsh8Sq5AKGpaJnLgcwVzrHuW8Iy+Ms6qjywEW0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WUAJCF2stnAjwHcjqKqdv2rS+Ins9+YlPjoDc3c067d++4AihlyuxFMHLoKDkm8XTzGOzGHWsemd70D84aIJQDkG2GuWTCZe8VHJlJPynN75fQL590z5kwG6r7DQPT9N2Ax1HDYRsUNu+hvQ6g4JcSSM68GAi+eV8YcRhLA8d/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-886b58db928so503425339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756185123; x=1756789923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9uE85j9ouv7Y7aaHkK86UdlmyVJK2M3usk2vJEmdps=;
        b=Ykxw5YUTl/3fVYYfl8/OZFSy19JHGlCKidV9foxCNz/tO/+3zXPqTUwWsnbOk0hcV8
         Q0JM79egR3LEIlz31Ycr3HBIXuFmjjZBZ/r+R1e7FWDkU5/FnTZf/TYWgyaF2NDz+RfF
         O/u6oekij9mbvqTPd17Lp9tqEUmtzoyhvv3m9NkpvkfT2IUYMVHkaP9wZVmd9koZhBpq
         DzFeLlZltl3pA/tlG05wZGjjXNCAnJbqZmMygt62hXyaRhxYq7KZV8B8QZGoWZ3PmmR2
         +uJpidFweL8WJu9vn33bgFvAdECDCEjjwJxvZLH51K1qqXLvAkRamDg0xTZkSpY1kJMm
         l97g==
X-Forwarded-Encrypted: i=1; AJvYcCU964QpI4GLACvhGBvWmRmE/Dg9TaniBMburhpS9b9Ml3T/DH8uUNhBb9FHbI7hkvKJmpE3i/3IU5Xv248=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtSlGZqmUybZo9ItEDP+C9ieHW0xZ71DhVcF0Usr2Q6ZLp399
	l3SXCv9Icfe9c+B99B/UKPuNtx1HTN/My+Jm5RzGE0e4h6kEJNhqSpZA7xvAtfchRTTnVi5r9jN
	zzHEs7ZJ+koIVcuVl3xQK7NB6Y0v3E/BjBAP6saBco1+1E1Oz3EwOtqdeiyA=
X-Google-Smtp-Source: AGHT+IH+5g/0GE5zecPIJXVNzzeNuSYw+BG6fLrBoJs8YUsQN+aJxfUZt0tspkdZ6fsoWh3Jr3v/PmpuLcYCuNRJR1rvWcQzDZCp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184c:b0:3ec:2c8a:f33 with SMTP id
 e9e14a558f8ab-3ec2c8a121dmr78548195ab.4.1756185123702; Mon, 25 Aug 2025
 22:12:03 -0700 (PDT)
Date: Mon, 25 Aug 2025 22:12:03 -0700
In-Reply-To: <20250826041656.5633-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad4223.050a0220.37038e.00a4.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __xfrm_state_destroy

------------[ cut here ]------------
WARNING: CPU: 1 PID: 36 at net/xfrm/xfrm_state.c:801 __xfrm_state_destroy+0x15f/0x190 net/xfrm/xfrm_state.c:801
Modules linked in:
CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:__xfrm_state_destroy+0x15f/0x190 net/xfrm/xfrm_state.c:801
Code: 48 c7 c2 00 34 63 8f 5b 41 5c 41 5d 41 5e 41 5f 5d e9 25 89 69 f7 e8 70 33 9f f7 90 0f 0b 90 e9 00 ff ff ff e8 62 33 9f f7 90 <0f> 0b 90 e9 20 ff ff ff 44 89 f1 80 e1 07 38 c1 0f 8c c6 fe ff ff
RSP: 0018:ffffc90000ac77f0 EFLAGS: 00010293
RAX: ffffffff8a2077ce RBX: ffff88807cc9c008 RCX: ffff8881404e1e00
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
RBP: 0000000000000005 R08: ffff88807cc9c06b R09: 1ffff1100f99380d
R10: dffffc0000000000 R11: ffffed100f99380e R12: dffffc0000000000
R13: 1ffff1100f993802 R14: ffff88807cc9c010 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125d18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055eb8c9a1008 CR3: 0000000027f28000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 xfrm_state_put include/net/xfrm.h:928 [inline]
 xfrm_state_flush+0x4fd/0x6c0 net/xfrm/xfrm_state.c:945
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

commit:         df534e75 net: phylink: remove stale an_enabled from doc
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d69c42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10aaeef0580000


