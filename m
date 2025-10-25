Return-Path: <linux-kernel+bounces-869867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8628DC08E50
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B6324E3DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD9B139D;
	Sat, 25 Oct 2025 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVH7LZN9"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D92D7DC3
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383816; cv=none; b=C4NR4FEy7dgWB6iOmEPm9ah6t5LO5Vf8F+Sy+iRNL8Jc+Ep8+e+tJgGz6VbGSdLqKPyQ0ZZtKP68VkW48WD89pTJKXtghEhklq/KG6IJ8sXQya55umDTjmv5PQ/INDwfCtl1UhY1qLJc7xLNs0EEf6+fYjrPrPiuCFCM3Aj60gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383816; c=relaxed/simple;
	bh=2Kt8HKOnLDb+wIsYYiemlbSQ6SKk+DUtP2d9idm6QFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcD1PAc5C16DbRF/z4ZKyPe+UJu/sMMLGiyGeX40GMIcHbW0PlcjO7F4jvB2jAulf3du2HNGnGCrpHkyP9lpW+M5RJhz3dt3e1L0m2TvMk9M+xK7pw7UrRSGIVosL+P4KeQj1tfWABQinDgsUsAAVEfZrdaKgYBK+rNYqO/umKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVH7LZN9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32ec291a325so2267879a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761383814; x=1761988614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njyZZntG8jB9oswagPq+Zbvv0EZXc75W/5WB5yROPws=;
        b=RVH7LZN9sI64hmlOe4FCfZpXu6Eka0NALaVNisVuxXGYH7pAbehcgFRBRild3lXweV
         ydfjTYX5Gksv/WTIz2XmNDKySZlws2h8Q8bYWjGXCOF06QZlV/cid9DwrbUK3bAkxYTh
         Cmcfr9G14E1S9RA5eY59z2MXrrCiOJ2MpeXcOEx+T9dDCUBcj8cCX+htf0LueRjyJ1du
         nn+2aKNUPnh/JRvwkTPOuTTvxIWhrLV6owa3SsDxCB820Ej/oinQDRCdYP84B05k4ki8
         esF9+TJWteSNG/or9FUssf8bQiLcuWEvJIa2aT2Hzz1yDPKtWDTYA4lYKwQq0VW1Q8Qr
         DcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761383814; x=1761988614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njyZZntG8jB9oswagPq+Zbvv0EZXc75W/5WB5yROPws=;
        b=o35A2EbI4ebnUaWiD7p15+qUrC1EE8vsU30n03JqX1NcLoQdhwuq1Hns7U/0SSq+xO
         S3vW8dQ0J0YLHpy9XiqgTcttHksv3oag0KKXizzANolRlw9Ten6bPBVlmu2JIX7ZvR3Q
         HXE1LpkrK9HGKVuZj5JBavudkJnjaZ5XLb3aXi/kOEv5lB2zte222pl/dpAw3ry0or3n
         UzEYaPU+fHimsdi8qPPRFeYQlU72UINU85dIrGwAgQVAnNQti4prTshpmlZR14A8nzPp
         C685Dp6dnlENsERkJL4GYB0VRwJyl97EgdrixIGYcplrthwVamefUF9nqVM5qtp+POHj
         VKcg==
X-Forwarded-Encrypted: i=1; AJvYcCVJksiZkHobUv6dj1jA5SP4xxKpI1YbsnVIMiNSFN2aQeMUYGXwZZGR482NI1kzHLfeWh+KKc249yNuw/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUduqES9JrDYdJHeSQbdOhrffJ5YI+1tL6d7vb9iLC+wWZqr9
	zNSiIz2e01yu4AYU+K3JPM/4Ti8bID2SPqehsVUDbCk3nqed8GRs+Nxq
X-Gm-Gg: ASbGncuCb0cXexYSi35TWKevU1K8KX5kVBCY5qj69GEDqlur0cj+xFtBs0RL2pDwgJw
	weKBUJ+tfHmDW3T5nSkhuAMzJkM1uk/lcfU9+lbf+JfnqN6h/ETdwBUj7I/wkH+I8YC4mosbB9x
	eJUv0xhuFvD5CGzbiDGWOMM+OISnsQ9lkS+a3iB/O57py5wZ1iJwCfGIbgvZ8nH1CYn2qxwoRXt
	WbxHYWidzKZ/vgQJ/5UBbDi7bbQLoBjDaSLNWW6p+AAjRmuQpZjAenOTg8+iR8Omra7YO/EYPtg
	x1eZ7cEMbuCUtL7nOpzU2ADdK+hOKkVA0uhPKmMh15gNmWGIhsAxWsBIC/sldTn2UK+jjwwZ/bZ
	68gcIyvbRyWQzNaRV4bBJ6f7j3NlDsWvqCz2PwF1Ju2waBULENINm3rmz3Kpp/O4ClnRtS2upNR
	LmWcP7oZPU33tr/Q==
X-Google-Smtp-Source: AGHT+IFjIxzCSd7vHDr58lswHi+jvMAjnTi6aIc5dM1LQTu8C0HpEJgg0uejHLpsir8p4hJ+muVwUg==
X-Received: by 2002:a17:902:db11:b0:277:71e6:b04d with SMTP id d9443c01a7336-290c9cf35e6mr380792355ad.3.1761383814449;
        Sat, 25 Oct 2025 02:16:54 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm17066255ad.12.2025.10.25.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 02:16:53 -0700 (PDT)
Date: Sat, 25 Oct 2025 14:46:51 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, rakie.kim@sk.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
Message-ID: <rdrijfoz5apghwj4zpymigdelzza4l3r5yzrwrpggd3nij3x7y@du4lgss3gexp>
References: <68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com>

On Fri, Oct 24, 2025 at 04:11:28PM -0700, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    72fb0170ef1f Add linux-next specific files for 20251024
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10fd0be2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e812d103f45aa955
> dashboard link: https://syzkaller.appspot.com/bug?extid=d8fd35fa6177afa8c92b
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119eae7c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140693e2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/be1fa3d1f761/disk-72fb0170.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/57302bf7af40/vmlinux-72fb0170.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/91c806bb2a2b/bzImage-72fb0170.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: mm/page_alloc.c:5190 at __alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5190, CPU#1: syz.0.17/6001
> Modules linked in:
> CPU: 1 UID: 0 PID: 6001 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> RIP: 0010:__alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5190
> Code: 74 10 4c 89 e7 89 54 24 0c e8 64 b9 0d 00 8b 54 24 0c 49 83 3c 24 00 0f 85 a5 fe ff ff e9 a6 fe ff ff c6 05 b1 7d 70 0d 01 90 <0f> 0b 90 e9 18 ff ff ff a9 00 00 08 00 48 8b 4c 24 10 4c 8d 44 24
> RSP: 0018:ffffc90003017920 EFLAGS: 00010246
> RAX: ffffc90003017900 RBX: 0000000000000013 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003017988
> RBP: ffffc90003017a18 R08: ffffc90003017987 R09: 0000000000000000
> R10: ffffc90003017960 R11: fffff52000602f31 R12: 0000000000000000
> R13: 1ffff92000602f28 R14: 0000000000040cc0 R15: dffffc0000000000
> FS:  000055558dedb500(0000) GS:ffff888125ddc000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffef4504a80 CR3: 0000000072ffa000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2418
>  ___kmalloc_large_node+0x5f/0x1b0 mm/slub.c:5583
>  __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:5614
>  __do_kmalloc_node mm/slub.c:5630 [inline]
>  __kmalloc_noprof+0x4c9/0x800 mm/slub.c:5654
>  kmalloc_noprof include/linux/slab.h:961 [inline]
>  raw_alloc_io_data drivers/usb/gadget/legacy/raw_gadget.c:673 [inline]
>  raw_ioctl_ep_read drivers/usb/gadget/legacy/raw_gadget.c:1162 [inline]
>  raw_ioctl+0x18fb/0x3be0 drivers/usb/gadget/legacy/raw_gadget.c:1325
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fccefd8efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffef4505ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fcceffe5fa0 RCX: 00007fccefd8efc9
> RDX: 00002000000000c0 RSI: 00000000c0085508 RDI: 0000000000000004
> RBP: 00007fccefe11f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fcceffe5fa0 R14: 00007fcceffe5fa0 R15: 0000000000000003
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

Lets first test with KMALLOC_MAX_SIZE as the upper bound for io->length
from userspace and then figure out the appropriate upper bound.

#syz test

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b71680c58de6..7b579a86c145 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -670,6 +670,8 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
        if (get_from_user)
                data = memdup_user(ptr + sizeof(*io), io->length);
        else {
+               if (io->length > KMALLOC_MAX_SIZE)
+                       return ERR_PTR(-EINVAL);
                data = kmalloc(io->length, GFP_KERNEL);
                if (!data)
                        data = ERR_PTR(-ENOMEM);

