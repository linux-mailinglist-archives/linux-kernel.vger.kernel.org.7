Return-Path: <linux-kernel+bounces-869980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D936FC092C9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632503A752C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A99303A2B;
	Sat, 25 Oct 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGqEI4qD"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02419302CDE
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761407539; cv=none; b=GBSKyFV1XdYNnBVU80hQCYbuGkdTQ8IhVTOiL5p9EfMnqIRyx128rdsto0PWJ6CFkVPx2c3dY2UtUh45V1Nr71Tbtp9a4Q/hZa8fBA+J8iGjSPk37N8dw+BFklYe7ffELglX2hd/dliTlK7Bb6TaU37pXn00YOso3UHnuPbxUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761407539; c=relaxed/simple;
	bh=enMKIZRxCXaUP2r8MhFe2BpbbpOBpUHkCZIfHCSYs9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b61xA4cWR97d0N05GaSXHd2DFL3fYviQx+ZLz4/w7WJAyh8mHrewKtTLJjlXVWA+eoWuLKEcEw5RYE+GpSCNFQSCBhHxx/NJrRhYxDTsk8hofI94g6lAXqGjWkhGWi0J3k29s+ykEMDRmR3rKuV/g0e594alEwdJ6qxH5fyXbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGqEI4qD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e0798so44266295ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761407537; x=1762012337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/G5OIygkBFviJhEHCwC7irT8X1Sky8Y9qSJRyc+oiA=;
        b=eGqEI4qDdIMmOffpvosS6PKv/d1mVZDI6rdIlO4WKblnJY7ZYgDNSlyeBQ/44GdSky
         95tjIE7jLEq5a0mp1Ff9OLQ11pHMnXLBC3XIfScbMpaEz6O1JYWIiWhKpcHkDxjX6Vmm
         SOz5P7sGr7kaNlZcTQGHlA+I8WMFSC9gzKoRTzkOZ9Pwi+Ifa4LVA7WHitd/UhwAeRpJ
         idWhnJ9R3v9QqmLuh8S4jP8EUIfVpgWWg/9LzjBX6OvISNcwCYJqgkHMmedRkdV2Pc4G
         UUC43lYEvr0FBwuOk3u9TpqJqD+tkUv+2SPssHTPLxdIvG6p926G2jWk2/woHvLvRREp
         3jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761407537; x=1762012337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/G5OIygkBFviJhEHCwC7irT8X1Sky8Y9qSJRyc+oiA=;
        b=oTCnHNeOvBZBWmYsxCUZNHt4AG1X/sQOT3ebVm4QCjbFg8ZglW3YX+tgmGlUGvXFLO
         v1dDYw064pZwqBaHOU6i7zUBSdyeljGCIOa5f76vdTEs0ET3xBp0eLX2QVyUBGn86+XR
         4dt72KCfBcufMUQYDpjiyBOdceOxJPY7RQKnkNUniJnj1MsnSzdErNEjQkLgNCsMgpJ2
         qfj8A1PD3OgdKdWF9k8ODqu56587TiG31QiuGNTQopmNxSTx78tauIZbpNYGU40fHaM7
         t45z+52kyuOi9l8SWDlMewwQkJ+fcisdda2B10nygpa5QDPTirFBoBVrFWyajENbitmb
         wEqA==
X-Forwarded-Encrypted: i=1; AJvYcCVe9ntaTh4Hh+kFIKrjpzOzL1nSLolJyT9AhOpeiP1LN2M4QUYAzvwU1+ZZgQ7pVnphvoBxC4+yMxj5n6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZIF6wawBvhnzeIANqoZSBqkfSIjeoxZ9BFzZDtt88YE835moa
	SZ91GShlvN0tTeEE4L5JrbgAzX3BGc4VMH/Jhe64syVJmT2zb5nmHdwS
X-Gm-Gg: ASbGncukNcV7WVtw+qSCGab4WBj7736UOOjQCwC86ZOMJncUSMp4ggrO+w/5uP+bj64
	Uniz/NYsVtRLfxF1GnXCtsnPnZdaQibD7StLgfnF6zBqttWxHYZXdpyewOEIDdTvTlZVzix3Y65
	UsVOgVzGd0/13VNlhol5MUGE9Y5j9xFu8XLEkkIV8NTq3Sk5rzOZ/lmR12iMX6MWrI58fCNpxb/
	CzV4a1rgmUDmDjqDXG9viopOvsxR9Uc6R6TFy3k02wVJZJ15BrLu6EApMTzz9x1tqmqO24IsT7a
	S1qTNUvXiijUQi8mGDrmZSZ2LcNwSMtqK7yFA5KD5xEvZBXD7kLk0Ob75TsB3SuSqzXNdVXQ1oQ
	42bnuSsL1Uo1lE3Ey2E4pNscsYLbkuxrtca3tAMRk3x4PVG0XXVhcHtXWKnnlDSukXCAWWm6ozU
	xSokLjJjFt7KaAfMO4w8pLmxU0
X-Google-Smtp-Source: AGHT+IEhyK8NPE+GeBL8Nk7M6rEMwtjl7+2UMd2puyrSw7MC6zF3PkKy2fcSzfiXgmhFNVN3kLPSSA==
X-Received: by 2002:a17:902:c94a:b0:25d:5b09:a201 with SMTP id d9443c01a7336-2948b9c00c5mr84166735ad.27.1761407536907;
        Sat, 25 Oct 2025 08:52:16 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3f4asm26661525ad.11.2025.10.25.08.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 08:52:16 -0700 (PDT)
Date: Sat, 25 Oct 2025 21:22:12 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, rakie.kim@sk.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
Message-ID: <hmzw6ng2gv6ctvgjhpttxuodpxriz63kpcnu7keywc2aioiw3v@x5xcenq5whr7>
References: <68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ovxwxiyonj66htjx"
Content-Disposition: inline
In-Reply-To: <68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com>


--ovxwxiyonj66htjx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

I misunderstood what io->data is and thought of it as a buffer for
storing one packet which dosent make any sense. Since io->data is the
raw data for the transfer itself in memory, it is possible that the
transfer length is several kilo bytes in size. This is also
documented by Andrey Konovalov in his patch [1], which dropped the
transfer length checks because there can be problems with USB devices
whose configuration descriptor exceeds PAGE_SIZE in length.

But since this value comes from userspace, it is possible that the user
passes a very large value (as in syzbot's case) which would be invalid
and raise warnings in the allocator. Therefore I think we should
validate the length in raw_alloc_io_data and prevent invalid values
(values which is greater than KMALLOC_MAX_SIZE) to prevent warnings from
the allocator. 

[1] : https://lore.kernel.org/all/a6024e8eab679043e9b8a5defdb41c4bda62f02b.1761085528.git.andreyknvl@gmail.com/

#syz test


--ovxwxiyonj66htjx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-raw_gadget-validate-io-length-in-raw_alloc_io_da.patch"

From ec93e88de10f0c0b02645e9caedad75323cf767c Mon Sep 17 00:00:00 2001
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
Date: Sat, 25 Oct 2025 20:48:56 +0530
Subject: [PATCH] usb: raw_gadget: validate io length in raw_alloc_io_data()

Not checking the io buffer length can  allow very large allocations
which cannot be handled by the allocators and can result in warning by
the allocators. Therefore for sizes larger than KMALLOC_MAX_SIZE we
return -EINVAL.

For testing

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b71680c58de6..c922ab42b0ca 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -667,6 +667,8 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
 		return ERR_PTR(-EINVAL);
 	if (!usb_raw_io_flags_valid(io->flags))
 		return ERR_PTR(-EINVAL);
+	if (io->length > KMALLOC_MAX_SIZE)
+		return ERR_PTR(-EINVAL);
 	if (get_from_user)
 		data = memdup_user(ptr + sizeof(*io), io->length);
 	else {
-- 
2.43.0


--ovxwxiyonj66htjx--

