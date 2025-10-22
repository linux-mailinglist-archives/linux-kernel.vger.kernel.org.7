Return-Path: <linux-kernel+bounces-865980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A9BFE796
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F7A3A58E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A10D2F2603;
	Wed, 22 Oct 2025 23:06:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766DB29AB05
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174368; cv=none; b=F053kuvvFj09d7ENzlC6uGXWcyLzjPQ4oPYrtf5WIzPc5oV9Te5NHVfO7CJkDUXix5yZEBOEfBZLVv8W9J2bFiN7qD4u68f9ZsSdVAvtxg9zuXuF8RJurD3ZRXS/CTZHuKeviU/Qph65uki2pq8IbiJkfnZ2Zpk8qxghNjE1l+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174368; c=relaxed/simple;
	bh=lpgjDxEI6nPbCkULvypgbFm47Rf+R8NLvY/nNytJvGw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tzn5+q38fVio3/rBmxONqw0YaRHPWLnkOwL9xcfXxspOqlLgdk3JkdiF2AhuMuecB68UoEQ9BFXGKoFW8oWo9nhxfWwtcQP3ZsI8vyGQ8Vmxeo/JyQWBHR2BzW29nnvhrhd3pXrDA3C/c3oMH8Xb6IZumJkiTHQvcqmmFOnhxvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so10563439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174365; x=1761779165;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmdyjHwCLvI4U011ziQjwB7UedsH6fZI8vnAoB2lm9A=;
        b=pPXidLMdmrs7oWncTmJthmtPIvFpWVHOGqQn53EOZIBOq1sZM3JJbc5MXX5ipMotz2
         Rh+mRybEJROIsBBmJQUzUfQKlgUTS0zq1BJJiP4CpNCa/f2dqycuxQpimFr69TWR1fdv
         EvQzfdRNr7EHFD5CBaSfHSU0WFHIHrcdMIXhNKpLTVJHbYtG9AnBUtQr9NEyuP9srIci
         nbUtpkX+ISO6eYs+0W7moOG27Bo6qOgDJxaIEMP3GSB9Wx4eCZwDmSR7ijxn6EkgnW3c
         B7MTPl81zrDrK1RzQJiUWUpBj4Edd8OVqLFKCSS8elcOwwDw2NGR46wCHuFQKfqk2/xa
         TXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLswdcHCRUNBiwVxucyDtjEe/pXiEX0wAgmzKu4fjsXgy0/p4wSzLLeHsHYNlbWhNZFZyGMb4pNj1bWPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8k9YVR2IauOrpsaCaHvEys9IW/a6N0u43n8XiFrwcBQ7BBpp
	fq5gsyEUwvygG2RFpeztxXYuUCb9BnaQhtE1G5WpujX+3LKFzf1HVdv8i75An6x8EXyNo8GPWPK
	xvlWMjP3PShDD1xtHaoUFVFb7bsV33W68N/2Vogl6YPYN5PQZDkBRRebyJwY=
X-Google-Smtp-Source: AGHT+IEfhwsaR35vEzzgw8+IPLkSYQ6zCiTG4qKvBMq+YgdyzLgZx29FgXQmR56hKoSfjz1qZVkCAMGagR9EmZ46cxnOSxiIFKOV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4801:b0:430:d1bd:2c4b with SMTP id
 e9e14a558f8ab-430d1bd2cc4mr223332955ab.32.1761174365596; Wed, 22 Oct 2025
 16:06:05 -0700 (PDT)
Date: Wed, 22 Oct 2025 16:06:05 -0700
In-Reply-To: <CAHc6FU7GK25PT5qCZV6iX_HYoJ+gtA9sejPB5Oz51Ji8Wj5CQw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9635d.a70a0220.3bf6c6.002b.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in do_xmote
From: syzbot <syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com>
To: agruenba@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in do_xmote

gfs2: fsid=syz:syz.0:  H: s:EX f:nW e:0 p:6520 [syz.0.22] alloc_dinode+0x16a/0x550 fs/gfs2/inode.c:414
gfs2: fsid=syz:syz.0:  R: n:8336 f:80000000 b:952/952 i:7 q:936 r:0 e:7001
gfs2: fsid=syz:syz.0:   B: n:9394 s:15443 f:936
------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:674!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 56 Comm: kworker/1:1H Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: gfs2-glock/syz:syz glock_work_func
RIP: 0010:do_xmote+0x706/0x750 fs/gfs2/glock.c:674
Code: 38 c1 0f 8c a9 fe ff ff 48 89 df e8 34 91 29 fe e9 9c fe ff ff e8 4a dc c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 fb e8 fe ff 90 <0f> 0b e8 33 dc c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 e4 e8 fe ff
RSP: 0018:ffffc9000131f9a0 EFLAGS: 00010246
RAX: bef9e87af17bd500 RBX: ffff8880601ed5e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: ffffffff8bb174e0 R08: ffff888075bc2bab R09: 1ffff1100eb78575
R10: dffffc0000000000 R11: ffffed100eb78576 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000015
FS:  0000000000000000(0000) GS:ffff888125e0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000663000 CR3: 00000000770dc000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 glock_work_func+0x2a8/0x580 fs/gfs2/glock.c:1002
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_xmote+0x706/0x750 fs/gfs2/glock.c:674
Code: 38 c1 0f 8c a9 fe ff ff 48 89 df e8 34 91 29 fe e9 9c fe ff ff e8 4a dc c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 fb e8 fe ff 90 <0f> 0b e8 33 dc c3 fd 31 ff 48 89 de ba 01 00 00 00 e8 e4 e8 fe ff
RSP: 0018:ffffc9000131f9a0 EFLAGS: 00010246
RAX: bef9e87af17bd500 RBX: ffff8880601ed5e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: ffffffff8bb174e0 R08: ffff888075bc2bab R09: 1ffff1100eb78575
R10: dffffc0000000000 R11: ffffed100eb78576 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000015
FS:  0000000000000000(0000) GS:ffff888125e0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000663000 CR3: 00000000770dc000 CR4: 00000000003526f0


Tested on:

commit:         a7f1196a gfs2: Get rid of had_lock in gfs2_drevalidate
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15179b04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=353de08f32ce69361b89
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

