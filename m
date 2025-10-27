Return-Path: <linux-kernel+bounces-872820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCAC121CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8283B4E76F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644482F6915;
	Mon, 27 Oct 2025 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfEUBEjv"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9FD1DDC37
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609420; cv=none; b=QBFXpMG/NuScCe4KQlvvbaVLEXTA9WWDGpWBx+KfBacXqDf7k8SUoRmgGMDKJv0qoXeC7jJL/NUfCZVgx15TIx/J1jvpDNeqnybEs2ze8epcS0RhVr3hJTbEj4HHY/apVk/CKg32l5GyHJcUTvU8r+WoK/9YiiXEjq0rp/MQbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609420; c=relaxed/simple;
	bh=wCKXRaygi2b/P15f+2M+sKzTvykJUTg4zsDIPBuKc5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsQEvoxMj7RL/jkjPHKr0K1W789NnowWIXweh+FCoVzaUj2uV64WUnVjimOwSPBfZZoOaVYzrnj1nSzh72LwFn8UHpQnc+2fZxBFnm8sNpmpXSZ8hYhJOfnFyT8ejxHUzgxKfaIh9WbkRkQ5zyg+ulOJ18Zd9p45UYYDTAKX8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfEUBEjv; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so4822991a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761609418; x=1762214218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pmO2Ks/d5kzSWvg4XCnqwnFkB+CHRKiMcRi15wDnNs=;
        b=YfEUBEjvqWM2jgSznnSSNUe1gJWbDWburOgGBjfm+xDNc+LoWSJ8LTbV7BEnxKov2b
         4p+1kLr7Y4Lg2b57oHdVo0m4+kzgpK9K5Qz6jrXWk+HInhWMDP9mabqXKSK68169VHfp
         bAqKtV3Ht1faySA3dit3EW56iY3tEHr0sI2/PlzqBKnSxmMN6j2mC63xGv4YDfpF8p03
         1TQYSU5wAqQb6RDoG8Qg1t7Y5d55jEEiqHsyit5V+E6+g/9oh+ZMFBT3VDVtCfyIKtyc
         ghdZkwkoZlGjnoq8/qwkQOhNkZSGohMrpxFRLorRoSRMi3rHvQpiL3iZ4CAkIX+zExZW
         Wxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609418; x=1762214218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pmO2Ks/d5kzSWvg4XCnqwnFkB+CHRKiMcRi15wDnNs=;
        b=pVFcQELgeRvCPf1BMJ8bkwk8zS1JuLwAqs8U8CZJFl7mxAbbXMUH5FwNNNbJ/zoueB
         SgICoYW0z7TylIUv9lIry5kDlC+7IHDWNczUb7fo9Z460beFghTBXHemrW+xyNFnD2G5
         e9HwOegYmV0+F1nUmRnCLqPxUQDG8unc0SdcyHblbsUgNbz2o76ACJp2LARTbGluMPIA
         YTp2hAbL+i+grTq2CxNqfo1iAy5KsotxF1o/aTgrPnGcvzdUIt/ULiA+f/sMRGPTxMY2
         Bkze15MGTNBsDTSD81c6JIF3AjCn9Y32Bh/yDDl9rLjLab9XToINgggOAo1nDblrKFsi
         iZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU56J+ACRdtMFrsYOGyLkskPUUdJL0zLJb3Yk4KCQ/ZbwUd/Zzrf8UYJg5fhYWR2SdeMlSk+mw4/r2cXOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZnjxF5UEL/tVfMngry9Ehjn9Hg/R2REQLONc+f+47w19yz84
	3NjA1D3rBf5fI7v09CB9I1f+dZDcA2pA1aM3QPAupZ85pBf7tQ5RO5HS
X-Gm-Gg: ASbGncscrG7q0sxTg4BHA1Pd70fUE4O0QSRYB/+4Zqvwot4rycSh/foEg3ZpxRnS9y9
	hwAizxsaPNnfakCb9OArbLnqpRViqBTK2iOCjCBqxXQMUp2oOsqzz2zR+mGDk7NkTGEQ0UquGA/
	oN+4kHI6BjPgj67wHhkIDov+DJL/qU+eobkk7sDU62RVkQPcfl+0av71gF/a0O7xBeFVVTan/Dl
	jKWKqQEWRbQpE1TBSskWfzgSP1Ike3TKEhwdi7skaeEwM74frzT5RiQhV2RPd2RiIy0nuiy+3HZ
	kO2c1pI26Db2N7zGy2Ew2Vd2Zr/Vmh6C/D9MqCjMzEIYSmD+INmn1s8a0Fsio5VbGCoapyoEoLj
	ff9HDrXE+v0ftkK5ljIzKOqpn6QUFdQRNXLlFP6m+KNpnjq4W4UDhg2jCDej68+Uo1TMRlgX3Vc
	pduQUMjoOav2TdJzJWbpDVOPGS
X-Google-Smtp-Source: AGHT+IFgQ0X5YV3xU7p5DTXnxiJ9uiTQF/LgohkVz16uml4TCI8ef3zNjJ7wT+p7VkosTHV2zIWRbw==
X-Received: by 2002:a17:903:1666:b0:267:bd8d:19e with SMTP id d9443c01a7336-294cb3d03c7mr20202885ad.22.1761609418155;
        Mon, 27 Oct 2025 16:56:58 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3405sm96781305ad.2.2025.10.27.16.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:56:57 -0700 (PDT)
Date: Tue, 28 Oct 2025 05:26:54 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: syzbot <syzbot+a894fe5447d0543e89c9@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, rakie.kim@sk.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: [syzbot] [mm?] WARNING in raw_alloc_io_data
Message-ID: <z742ziobbolobstu2ljazsv3hkp27pdpfghrtzj3vfr46w2v2s@jqdpqtdgy5qn>
References: <68ffe1a8.050a0220.3344a1.03a0.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ihf26owk5ldxigdu"
Content-Disposition: inline
In-Reply-To: <68ffe1a8.050a0220.3344a1.03a0.GAE@google.com>


--ihf26owk5ldxigdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

#syz test

--ihf26owk5ldxigdu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-raw_gadget-validate-io-length-in-raw_alloc_io_da.patch"

From ec93e88de10f0c0b02645e9caedad75323cf767c Mon Sep 17 00:00:00 2001
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
Date: Sat, 25 Oct 2025 20:48:56 +0530
Subject: [PATCH] usb: raw_gadget: validate io length in raw_alloc_io_data()

Not checking the urb buffer length can  allow very large allocations
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


--ihf26owk5ldxigdu--

