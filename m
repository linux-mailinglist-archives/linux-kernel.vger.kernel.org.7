Return-Path: <linux-kernel+bounces-748617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B66B143B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D89A17E687
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC4822A4F4;
	Mon, 28 Jul 2025 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HignA7MK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569CE273FE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736909; cv=none; b=AWeNMpn4vrioKXdX0nGVrtArAUsCcsHFOzZk7SF6VI0pvD3sZyjy4xtn9MrA6jg6gWpta1tAn0bAafVUIdC1hH0JjwSX2lUZrzCDlzE3TjmG0RUo6W2FQZOVMrTOMdfCNWBHN1dm+9Y0QMJix1IkB9B9wAe3LreJauUhIGr/Y8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736909; c=relaxed/simple;
	bh=8EEgDW6/RcHGmiG2NCg7tQMeIXZ1gt/z210A8m1EEm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hugLlC3aLk2WLFAjOhNblMoZEiGcTd17M5glDALvgY2AVMRCYpPryBp+LnyYNyu/i2gCv3MOSY5zokE8opus3h+sgvhkc9cn1TED9jqZPs1hmfBy6aAI1+1XDMbrFinmosqUDDUtZv4/JkbLxdrkBEBj7adHXaKyX7UZ1hfCn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HignA7MK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753736906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcBiW6OrDuRkE61U2oZHQtibrdiKqEiJ1zyfrij+HuE=;
	b=HignA7MK4ZhY7ZBk+lXkuz2MwKiyDFCfKz1YuXgPFzhS7Uom3wM9MyfrV+fK43NX0nSsx8
	pBqN8ORoIRfJKj/iYhvKTkDX/BYn8t8wWMPLBpmrSoYhIZMONydpAaGRlG6KVvY9h+zZqB
	yBE4qHQW0bvlxQoRGocK1XZ8OX/uMLs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-gdMFZ2bNMcWyMFbBV9ZHNQ-1; Mon, 28 Jul 2025 17:08:22 -0400
X-MC-Unique: gdMFZ2bNMcWyMFbBV9ZHNQ-1
X-Mimecast-MFC-AGG-ID: gdMFZ2bNMcWyMFbBV9ZHNQ_1753736902
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4aeb2e0cb98so31330521cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753736902; x=1754341702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcBiW6OrDuRkE61U2oZHQtibrdiKqEiJ1zyfrij+HuE=;
        b=jQO/OY2Kqsnq+OIxk4GPPnKOU8RFuuyDdhq2lqm0izyyIFSuyOfgm/LTGd9ioJ8k5M
         m8pWyp26O2nUxunb9WnYccM8PA8VyN9lSR2Dxq7MnvW6cOnXgGyTAL+D39JSoJJZ6ApU
         iLGlxOgs2p7KF/3ksjpVOVPVRaKqFfGihA0msl9V0Yb/UIATrLl8V7gM4jzex9kE7lHt
         3Rt5zhtWoRiyMKKPFtsNcEllHSG+xdrL9hjHMg359z++wc4q+I8k7NisGwhqlvJ0Mz+O
         1pkggP+K69+eA36aSrU17DGiic+KlLa1StOaga/86JvdHq0PEYvD7a7Y4sslycN0MH6h
         zQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsGI50NMGCknSNwb3pLU2ub7Urcsq6gmSHFdJmKVRjL/h2A7tbyyYbTs87DdJVbbdlC5RxWAsmfsupzj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyvqw/rUCJ/6FfNfWLoX8imWyDgyizCOkh15GtuR9OfX+Djfvo
	7kjcvOh14IJizO96TWEFYavp5aZlUAgBmQpZS66CjQ2dr7WiC2KuW69B2o5pvlDADq+2oreLHRL
	dZCyQ8a8wnCLsbODmqgtvFHpkMwiWWdIwTv39YOhslFh7WO6TN0gWtdULBfh+hjAhGA==
X-Gm-Gg: ASbGnctEEtjX6+rKkFs0EDAn5NO9hKBQ0H/lHYC0yBMcOwVCTyIha86y7XLoSPVj9/e
	LVu+2m2/XjY898xItBGn8XhyMzDEXouOrj4+rbeJqGXUqxU/mgcjSTaaV1ExGgRF1e8e0nZ1CiI
	El+7YAk4G/2kChza3jBpJ5r3V1gkUNzmO9euFzq6Xv5VD5mH15iA6S3oYVdlixiUrVeQ1zdSa2U
	RlRPbS8q4JQxonzVUxw1G8BfVK2LlfEZVtm2Jyia8pJ6Ul8TpYX5CH428bQiaTuclEi77dJcfdn
	mNjkdHQ6elYzeoKTfz8Gu6Xr9vigl5o=
X-Received: by 2002:a05:622a:13d3:b0:4ab:c00c:250b with SMTP id d75a77b69052e-4ae8f0ddb39mr185285221cf.40.1753736902128;
        Mon, 28 Jul 2025 14:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUd/cHhjwzB9/l8otidGgToOpAIoiGahsj8p23nz+4w2+2F/XUHPOFR0hUr0kib0c+Eh6EjA==
X-Received: by 2002:a05:622a:13d3:b0:4ab:c00c:250b with SMTP id d75a77b69052e-4ae8f0ddb39mr185284811cf.40.1753736901647;
        Mon, 28 Jul 2025 14:08:21 -0700 (PDT)
Received: from x1.local ([142.189.11.29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99516482sm39780351cf.7.2025.07.28.14.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 14:08:18 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:08:15 -0400
From: Peter Xu <peterx@redhat.com>
To: syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 move_pages
Message-ID: <aIfmv-qSxKxWgzur@x1.local>
References: <68794b5c.a70a0220.693ce.0050.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68794b5c.a70a0220.693ce.0050.GAE@google.com>

Copy Lokesh and Suren.

On Thu, Jul 17, 2025 at 12:13:32PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e8352908bdcd Add linux-next specific files for 20250716
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17f81382580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b7b0e60e17dc5717
> dashboard link: https://syzkaller.appspot.com/bug?extid=b446dbe27035ef6bd6c2
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10041382580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eb158c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ae8cc81c1781/disk-e8352908.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/57aaea991896/vmlinux-e8352908.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/feb871619bd4/bzImage-e8352908.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: ffffea6000391008
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 13fff8067 P4D 13fff8067 PUD 0 
> Oops: Oops: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5860 Comm: syz-executor832 Not tainted 6.16.0-rc6-next-20250716-syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b 48 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  userfaultfd_move fs/userfaultfd.c:1923 [inline]
>  userfaultfd_ioctl+0x2e8b/0x4c80 fs/userfaultfd.c:2046
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff3570d6519
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff35708f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ff357160308 RCX: 00007ff3570d6519
> RDX: 0000200000000180 RSI: 00000000c028aa05 RDI: 0000000000000003
> RBP: 00007ff357160300 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff35712d074
> R13: 0000200000000180 R14: 0000200000000188 R15: 00002000002b9000
>  </TASK>
> Modules linked in:
> CR2: ffffea6000391008
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:_compound_head include/linux/page-flags.h:284 [inline]
> RIP: 0010:move_pages+0xbe6/0x1430 mm/userfaultfd.c:1824
> Code: c1 ec 06 4b 8d 1c 2c 48 83 c3 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 9a 30 f4 ff <48> 8b 1b 48 89 de 48 83 e6 01 31 ff e8 59 70 8f ff 48 89 d8 48 83
> RSP: 0018:ffffc90003f778a8 EFLAGS: 00010246
> RAX: 1ffffd4c00072201 RBX: ffffea6000391008 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffff520007eef00 R12: 0000006000391000
> R13: ffffea0000000000 R14: 200018000e4401fd R15: 00002000003ab000
> FS:  00007ff35708f6c0(0000) GS:ffff8881258aa000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffea6000391008 CR3: 0000000074390000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>    0:	c1 ec 06             	shr    $0x6,%esp
>    3:	4b 8d 1c 2c          	lea    (%r12,%r13,1),%rbx
>    7:	48 83 c3 08          	add    $0x8,%rbx
>    b:	48 89 d8             	mov    %rbx,%rax
>    e:	48 c1 e8 03          	shr    $0x3,%rax
>   12:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
>   19:	fc ff df
>   1c:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
>   20:	74 08                	je     0x2a
>   22:	48 89 df             	mov    %rbx,%rdi
>   25:	e8 9a 30 f4 ff       	call   0xfff430c4
> * 2a:	48 8b 1b             	mov    (%rbx),%rbx <-- trapping instruction
>   2d:	48 89 de             	mov    %rbx,%rsi
>   30:	48 83 e6 01          	and    $0x1,%rsi
>   34:	31 ff                	xor    %edi,%edi
>   36:	e8 59 70 8f ff       	call   0xff8f7094
>   3b:	48 89 d8             	mov    %rbx,%rax
>   3e:	48                   	rex.W
>   3f:	83                   	.byte 0x83
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
> 

-- 
Peter Xu


