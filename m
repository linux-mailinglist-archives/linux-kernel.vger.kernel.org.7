Return-Path: <linux-kernel+bounces-872857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D06FC1235A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A84564F2B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A681DF97C;
	Tue, 28 Oct 2025 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjfVM18J"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A771AA7BF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612063; cv=none; b=aWcqWbjFrZkODjECdfEMjTvO/vu7ftefxVqFYk2nIENBYU0kbsqpayUrURQ8GGtdk1Ce778wI/n+7bbRVupzW4/u6OvQ53odPgdRYzJTppWti8vZ6/DVx+4IQISTPcbN0/0J/eXBXTBHWxlu4dgXYZw16TKuZWlYKCSiUnJ+X7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612063; c=relaxed/simple;
	bh=brKZFPh+o8a3k5gkScpt5/KBmfhJ8nEc1UixOwSLkAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ5BSyepwxmKGix0WcIrRkQaNapVkoGcSvROWER01Zs4jhi30sLjvvFN86srEhY0twEzjimoT+D3KsrzSCH9QzAMLX8xpcUND/cl93plgwuRTBsy+bcrBcaQn2xPHymxI7OjH1s0EiiFomRDob5UOkaskvm9N+zz1W+Zm5W9nr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjfVM18J; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so2791888b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761612061; x=1762216861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oTZKuu154COSpnPLl48ObswEBLGYmmXP2lWfLIZHQnI=;
        b=ZjfVM18JVXo+PgInvEXpeGW+y9SNjZCUmSwIUpRfg5TWaEJCCvF5duEn1hEzP/HRuv
         uO/49inaKSZ74AE3dT5iC23/AF07XHAGEbMQNqxlRYWTpl/m+typVlSREDs9TnoXaWD9
         1xLMsudlRTF8gwqFwQn+fTKwwznQFTDA3Gq0SPFk6BFh5mWX1m4LnvQr328lNury/f8k
         hHtx6w9f0o0lq0LMyP+kgU5VuUWsq+OKN1wX8Uy68l7Zv4EY3gcHr13WgyYU8O5KbJVF
         NvHXZ4UfJL1zpmTMHQN9+TlUf8LLFHp8d/XQop0b/5l+dN7lzZqMJ8EoY4eMklTN7aKb
         A1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761612061; x=1762216861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTZKuu154COSpnPLl48ObswEBLGYmmXP2lWfLIZHQnI=;
        b=HghDcnHf3XIoawyMVN8oJmHlg1m4LFKVqeUxXE10v3+Yikhe9Y1SA0soJmkx2Zdp3H
         r8hO+LjdLTYF7xOn7XVTFzIcTaQn1ctYeUAsT2ILDienyLswvQ4e2oXMUcdjP8cueuFu
         d3vE/331P27bqlSNACQ3aTOFB/Pjv8vJo+8VCicE265WEJlcwV/A8QL8qiVqrjqnL92B
         J7xefJdgHZYiDiUJQe98hH1Eh99JxUFs9FnQUVKOFFiagkl1ttRegOj170zWDm40Jt8B
         8swxTycDYhcqFHYVRcWtj+iTSXWEB4aIr1YSV521BqPUlAH3wb1t0XM5FdfFEcEb12md
         Pavg==
X-Forwarded-Encrypted: i=1; AJvYcCWoyf57xMwKlKHh2Fe7kJVByij9D0O2GoFGG6nommNu4fVBfmlIn6KN+RYWWmUB8ihj4fkUo0wjI8lPwyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmYYBwGKbE2lqGMZ4olf/TT/IWNcLNiUKj5htFUIx9TeyfYhm
	7jix5NjU9SQn2e18xv8AYB3f1AGy/sGDUve93NipK6gAU7jWfxMMu4GG
X-Gm-Gg: ASbGncvctYHq8fmSXqAFgtmbq5vwNIq/+AiJD1xtuQIqo40kDLaITYqh7bhLu3Z1zbC
	Ulkwyfc4scqbfhmIBx5A28l/meFwdQUnDdxK/cdeQI3heovGfJuPtuQPcpOKHdIye2YMV1rJ8P/
	oS/ymXJA5jvSc5n+o4RmEriDW6rlX75x9EXbNqKQzNOS1bAhTy77wtlvAaOMTdCJmInpaFTJIcv
	Mu875+mwPT9AOe8ZJnDAVwRVQTaTUFAaj7KjeYWg0LI8o6paly0YubR0WdTT17LCqLEklgJTrys
	jJP9pxccz7Q/K7zg6bddUhvjRvtw7CN5/mVYl/dWeZau/p8MnyMPt+do1dID5MEkbftZ1RzH9td
	w2G/AguDXH/nYdlGrTNf40sBzxKUlOdGw7cQn5X3v02+PwU2kz1NkALnksvccQK93Idb2/M5242
	xDsmE=
X-Google-Smtp-Source: AGHT+IFmsoh3DyzGhCitu8owq5rBNWE8sw68jDqRcZrbgvaDViF9SipBAufhFBd1b7TwfZB4Yh4BiA==
X-Received: by 2002:a05:6a20:4321:b0:342:a7cd:9221 with SMTP id adf61e73a8af0-344d228acadmr1888008637.20.1761612060915;
        Mon, 27 Oct 2025 17:41:00 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm8846839a12.5.2025.10.27.17.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:41:00 -0700 (PDT)
Date: Tue, 28 Oct 2025 06:10:57 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: syzbot <syzbot+a894fe5447d0543e89c9@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, rakie.kim@sk.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: [syzbot] [mm?] WARNING in raw_alloc_io_data
Message-ID: <szusm242ai65p5eox3sblk225p6njf4kfahcgn4hkocwwvzh7l@3pfzgljcwzll>
References: <68ffe1a8.050a0220.3344a1.03a0.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ffe1a8.050a0220.3344a1.03a0.GAE@google.com>

On Mon, Oct 27, 2025 at 02:18:32PM -0700, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=160597e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=609c87dcb0628493
> dashboard link: https://syzkaller.appspot.com/bug?extid=a894fe5447d0543e89c9
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11af27e2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c2d614580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dcb6fa37.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/61176fd888a1/vmlinux-dcb6fa37.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/84e7e9924c22/bzImage-dcb6fa37.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a894fe5447d0543e89c9@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 6091 at mm/page_alloc.c:5159 __alloc_frozen_pages_noprof+0x309/0x2470 mm/page_alloc.c:5159
> Modules linked in:
> CPU: 3 UID: 0 PID: 6091 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:__alloc_frozen_pages_noprof+0x309/0x2470 mm/page_alloc.c:5159
> Code: f0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 83 fe 0a 0f 86 0c fe ff ff 80 3d d4 63 52 0e 00 75 0b c6 05 cb 63 52 0e 01 90 <0f> 0b 90 45 31 f6 eb 81 4d 85 f6 74 22 44 89 fa 89 ee 4c 89 f7 e8
> RSP: 0018:ffffc9000371f9f8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000014 RDI: 0000000000040cc0
> RBP: 0000000000000014 R08: 0000000000000005 R09: 0000000000000009
> R10: 0000000000000014 R11: 0000000000000001 R12: 0000000000040cc0
> R13: 1ffff920006e3f55 R14: ffffffff9ab2c464 R15: 0000000000000014
> FS:  000055557bf92500(0000) GS:ffff8880d6d0a000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f84d9710300 CR3: 0000000032452000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
>  ___kmalloc_large_node+0xed/0x160 mm/slub.c:5583
>  __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:5614
>  __do_kmalloc_node mm/slub.c:5630 [inline]
>  __kmalloc_noprof.cold+0xc/0x62 mm/slub.c:5654
>  kmalloc_noprof include/linux/slab.h:961 [inline]
>  raw_alloc_io_data drivers/usb/gadget/legacy/raw_gadget.c:673 [inline]
>  raw_alloc_io_data+0x12c/0x1a0 drivers/usb/gadget/legacy/raw_gadget.c:659
>  raw_ioctl_ep0_read drivers/usb/gadget/legacy/raw_gadget.c:776 [inline]
>  raw_ioctl+0x1397/0x2c30 drivers/usb/gadget/legacy/raw_gadget.c:1313
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f84d938efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe768729f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f84d95e5fa0 RCX: 00007f84d938efc9
> RDX: 0000200000000080 RSI: 00000000c0085504 RDI: 0000000000000006
> RBP: 00007f84d9411f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f84d95e5fa0 R14: 00007f84d95e5fa0 R15: 0000000000000003
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

#syz dup: [syzbot] [mm?] WARNING in raw_ioctl 

