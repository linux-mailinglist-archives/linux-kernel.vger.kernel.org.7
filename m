Return-Path: <linux-kernel+bounces-869941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22987C090BA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96104E8CDF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BDE1DF759;
	Sat, 25 Oct 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC52dTeM"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73BDDD2
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761398435; cv=none; b=qLjwdt9q08QcbK2lx3O4JQqTxqhOO8ZjTKGzuCMd80UyBOjV5i/iHpU6zcgHglMibvFZMSLzZCI6Ma6Cjp0ujosPhzl3zaMAZbjjWOHdfz8o6BvX/yD05lEenwvXTAzcf9+2Uv22Fq3ztIX2hkfsVehDDZWkXVhGp+6lvwhcZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761398435; c=relaxed/simple;
	bh=W3K7YjOBhIQyl0bVvRBALwMaz5WMe12rmZW6ZbM5kMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZph7ogOhpfLaUXp0hWWeVRkqHEZ1WNsh9ypIZcX2PlqLb3+1uSUIO51PX9jFfQIYmfXX2QJIsj7Slyec7Jc5d2vXx7P5FD7qNyewwjhAY0BA9pNo5+jNwWwF/7UFnu8Hon88COBUWVCgnkepEhza8Us3h/QK32oWvsPvR7IsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC52dTeM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a28226dd13so2010473b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761398433; x=1762003233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PKiLH+RjjN646XXCQ4HfAAEe48a7xXF0BXJN5Md6pE=;
        b=MC52dTeMA8DcgeB3QRsyw3y+TrDDQjPQyBVtrzZOTkXzKPE9bmO9o3oK/zko/zNo31
         mwa7hqp2ccfMP+BSKms/upRp35zwjKJRb9TuVAc07O3PusGhnPeBAUKvsUO3lrg0BQER
         UgpCBPf1v/ho9IdUXN1CTGrbisH3ooew2ZdQVQYlFNRil3cgSo4/jxTeWFV0E6Gimkrd
         jyzKEocnfPWKu/w/QOHtWqPHW/+0Oocvi6w0rS0RGmsWp34gO0zztefutAxn/xUgj7qU
         wDRrb9zgekGh6hi6bb+HuXMAbjltLTPBjTF4apn+qCTig/HoonaDLYssQGSOZpGmYBPW
         Uh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761398433; x=1762003233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PKiLH+RjjN646XXCQ4HfAAEe48a7xXF0BXJN5Md6pE=;
        b=QI96dgnowwS7jbexbmYRLjPg3ls4GmG+dGMXotDvSf8H0q7wVMj/5lxLTQQuaiKTKx
         7izOY3fH5mir3rssB0C7Sx10NlSkEU2KZJtzp6GyXjse9/Ui4kc/Iog8v7teo5Himpcn
         Ymq/7uri9pLLpH7Edz5rNorWhH9EZ24qsM9f+wMyamXEdfxOZGsqyRA+PkWMqoXps9ox
         AO0W3ugZOGcETlQaxaqVJ1AaNkZAVBJ3AY7/sB1CkOvMjaZq28RpW4rR5GDsBs5EwOQw
         Fhn1qOrVuPM5dnc+15ysxGz6qPbEqJG4O/th0IeIS8xw6JtL2HKgFpjbLjwnxs64f2fD
         X7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk3YAW9sTm02GCk4LVqspzPfVk+yUd/gajieABLx5y9WebQSA8pgq9aYHUaOvAUjRQ5xX3lLJhIkQJ4UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMw6buuCqD4ipD6JC9ZVOhKujOQZilCHEtT6Uq3ITSgJuRPxD
	p9rScxzSi6GoP+/TbLXa9ebo9jk5Fz5EyHhcMOb/15hpQ4TySDym751v
X-Gm-Gg: ASbGncu862qZbG6DQgRH1XmRv2hcxsn29UXEOSNC1Iq6EY1Uy3wo3KeF6cW/E1bg31Y
	MAKJpFZrbUJ1zT87Gs/rvw6zSORjaIzvlHhqSmivJj8KRcSUotVGWuF8DBGZKyXKOAVGD9Wd1Z2
	wHVic7wBqcH5UgkyDKuoR+h3dXLZTOIvAb/mmyEgz/f4pKDwjEE7Qkh8Do3TQS2dG9JgyCJoHf5
	cMdBtaQ/rn4ju666L97OGux4hjWukFprrS0yL24AVwHxNUqD4HmGjY/RU9h7Nc4WOr3EIzjGI6l
	ntjuLb972yX8TZIEthPkVht4GkRWuVSRNhsgUbCUmnZc/On1lzeO4NC1g/aZVjUwYdUoKVDj6jX
	4/6ahduQbIn5uK2C78RNlKN8vH0vwrkJZ6psv8ilCQi6HBcN4494iRilN5wbHzWIlUoh3+abFEq
	4aX/M3l5GFWK7f1w==
X-Google-Smtp-Source: AGHT+IHJiC0aj6qmuZfdGIWKqbTfTXS9jpfedjPCPbxhWj8tHI0AEBJvmgejbKLVkiSn6jzWu51Gew==
X-Received: by 2002:a05:6a20:a10c:b0:33f:4e3d:aff3 with SMTP id adf61e73a8af0-33f4e3db2ebmr5654536637.24.1761398433012;
        Sat, 25 Oct 2025 06:20:33 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed80aa48sm2394595a91.13.2025.10.25.06.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 06:20:32 -0700 (PDT)
Date: Sat, 25 Oct 2025 18:50:29 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, rakie.kim@sk.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
Message-ID: <eycmv6nwd6yvi4y2xlvqsjfzzoq46tlmqhbdu3bxi7rxfyreov@m2liixvk4ugn>
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

Since the maximum packet size of the endpoint descriptor is a 16 bit
field, we can make sure that the io->length is never greater than 65535
bytes.

Resend the patch as earlier one was malformed.

#syz test

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b71680c58de6..00f5e697d321 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -667,6 +667,8 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
                return ERR_PTR(-EINVAL);
        if (!usb_raw_io_flags_valid(io->flags))
                return ERR_PTR(-EINVAL);
+       if (io->length > USB_RAW_IO_MAX_LENGTH)
+               return ERR_PTR(-EINVAL);
        if (get_from_user)
                data = memdup_user(ptr + sizeof(*io), io->length);
        else {
diff --git a/include/uapi/linux/usb/raw_gadget.h b/include/uapi/linux/usb/raw_gadget.h
index f0224a8dc858..effe8a543c75 100644
--- a/include/uapi/linux/usb/raw_gadget.h
+++ b/include/uapi/linux/usb/raw_gadget.h
@@ -106,6 +106,9 @@ struct usb_raw_ep_io {
 /* Maximum number of non-control endpoints in struct usb_raw_eps_info. */
 #define USB_RAW_EPS_NUM_MAX    30

+/* Maximum length for raw endpoint IO */
+#define USB_RAW_IO_MAX_LENGTH 65535
+
 /* Maximum length of UDC endpoint name in struct usb_raw_ep_info. */
 #define USB_RAW_EP_NAME_MAX    16


