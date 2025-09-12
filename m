Return-Path: <linux-kernel+bounces-814734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EC5B557ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E81892CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC03064BF;
	Fri, 12 Sep 2025 20:50:06 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6615C0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710206; cv=none; b=ScO9/+iBGp+Qbf7inomL8AiLVU2AD95RIdzogmwh/oEFT/2kyDVvyHUUO8g0KPjUroT68vgfUqEV1JbQ7lr7d1z2K81Xhd5hQiLTdyNCXRq5JFe88oveNJBMDC0/YNJC5LX+a20EZ47KiW5dsO7r7VtATRhXWqRVd++t6708eqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710206; c=relaxed/simple;
	bh=nhiWUvsEIbHOLAxNGs3fHx2M8NaIN9MpVAGWWlrD1qU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HoZjlx0vTsLoPOUMZOli1iQDTXJ78Wsrahh81b7D3jL8j0/Js49aM8nqYH5WASlr+5A/9pecxm5SS/iXxXkAwmU2hYei6qdokW7BjvpiQcnIff1dUhR3B7Ro/MO3xsGTYUX/hEn4/IzUA4JKyWS50aa6zDDpNXR8CiwMIoDws8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f736aa339aso57991665ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757710203; x=1758315003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5CH0bLEHjWP8pxMu+Aqj+/elVavAboBURVC3N1l6/o=;
        b=U58N4U0JSGNd8ZqjFzNHk2/qf5szIgNurajfYnGJBGdSoxrYcSniGgfzI2Qux/jp3M
         zj/RMoXeJtU+H1OoRQhp5ERwF0Iw4cAuA5q/rA+4nLMwRK2+9D0ECWcjN3Ll0W8lCAW/
         Quu878pQKiPpim+ldDtCzVI8hnQ6hsA1ICzi33eocDgNQKHBXcWSGekF+aWQKq0jPRYl
         5P1rJbc6LVN1nPghpZooizrdFos0ebhu7MWAX2CB4q1qLDzQdLR8BIzkMuSQNJaPIZtE
         sRYUsKyFbPRjfqWYj4PmCLC/HopBRrgAyrM00X49JjR0yvoaZk9EtnnzbWLJ+5IiL2Vj
         3BEA==
X-Gm-Message-State: AOJu0Yzw8EKWIRiMgRqSZ+j1EjebWbs5Fzoto4b8VkJiJ7T8C9SRIMKx
	442Mo7BsI4xaziAXMw3VPXUIkIJ0HGIHYjXFhXNkZ2SKKtIzMST4zdrM3D08dSASRpZyyyX1Wje
	6GRtYHgFB7vuYE/ebWF8TDNE7l6ib9Exd+fx2RTy3fFBcbjEs5XjQG4sHtgqGRw==
X-Google-Smtp-Source: AGHT+IEw4nKwErgJneNFFcfg7jRXdlfUsdfkgnzmym6riyA0oik7NArEzmwSGipc/rkQo+7E3dv8822AkbA8p8XbrezERTyZC82s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3fd:a540:9352 with SMTP id
 e9e14a558f8ab-420a3026147mr69174945ab.17.1757710203640; Fri, 12 Sep 2025
 13:50:03 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:50:03 -0700
In-Reply-To: <68232e7b.050a0220.f2294.09f6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c4877b.050a0220.2ff435.0362.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Author: yanjun.zhu@linux.dev

#syz test: https://github.com/zhuyj/linux.git 
v6.17_fix_gid_table_release_one

On 9/11/25 8:34 AM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    5f540c4aade9 Add linux-next specific files for 20250910
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=157dab12580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5ed48faa2cb8510d
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b52362580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b41642580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/df0dfb072f52/disk-5f540c4a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/20649042ae30/vmlinux-5f540c4a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4c16358268b8/bzImage-5f540c4a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> GID entry ref leak for dev syz1 index 2 ref=615
> WARNING: drivers/infiniband/core/cache.c:809 at release_gid_table drivers/infiniband/core/cache.c:806 [inline], CPU#0: kworker/u8:2/36
> WARNING: drivers/infiniband/core/cache.c:809 at gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886, CPU#0: kworker/u8:2/36
> Modules linked in:
> CPU: 0 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> Workqueue: ib-unreg-wq ib_unregister_work
> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
> RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
> Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 a0 43 91 8c 4c 89 e6 44 89 fa e8 fb 67 f5 f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
> RSP: 0018:ffffc90000ac7908 EFLAGS: 00010246
> RAX: 621d731dcb27e200 RBX: ffff88806241b8d8 RCX: ffff888141289e40
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 1ffff1100c48371b R08: ffff8880b8724253 R09: 1ffff110170e484a
> R10: dffffc0000000000 R11: ffffed10170e484b R12: ffff888027503e00
> R13: ffff88806241b800 R14: ffff8880289a2400 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff8881259f0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555569847588 CR3: 00000000338c8000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>   device_release+0x99/0x1c0 drivers/base/core.c:-1
>   kobject_cleanup lib/kobject.c:689 [inline]
>   kobject_release lib/kobject.c:720 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   kobject_put+0x228/0x480 lib/kobject.c:737
>   process_one_work kernel/workqueue.c:3263 [inline]
>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>   kthread+0x711/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


