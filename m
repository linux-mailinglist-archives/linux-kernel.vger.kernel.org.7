Return-Path: <linux-kernel+bounces-874243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB2CC15D49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387281A2098E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A41F28D8DA;
	Tue, 28 Oct 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgyKnGKJ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D602367B0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668886; cv=none; b=i0LBwgTlIk8UYOWQqhTNIKQ2dxuoVAhXKnZ4NFSldSztzDAGNOh3OT9bjq3RYWGeAMizUMUs9osbizLaKFX9sNCsC4NJSpiXFpwF4ERPOW9v74txaiwnNvxpGnKYXKZoRRlirx0n1dD37dci5m8Gw+S9HhnhUqxRzCsrQZW+KNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668886; c=relaxed/simple;
	bh=Y2RKoD4v0RxsNS4j5bme/W2kI7vSJy73wt8xyiqB24E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTRO+XuoWM/+9z+s0zwlLL4YzXdoVfzNEp8b3smwIkMRMAKu7qwRbQTsc/GI6ooYEOgWMGgwCqLNNXHg/ATftIX6zr1DAoInyM0eefKvebl0AaocVlPrwE7ph7hkyQTc/49la7M45l3T7HaZCrforfB3duuDPLN70hcbYHelY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgyKnGKJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso5698354a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761668882; x=1762273682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpH4OZPnfyyaGId/GUkqaK3YoVR6iNW7qBGDUd27apA=;
        b=PgyKnGKJVzfuITdDA3rklBqGpagJCNDhWWZPmUjkgB90Q7qb+LKK/69+Hyjq/tDd7e
         ESBNzsFj2a/zQutmmRCIFZVSWRldrpheD62/B5kZE73bxJZ7BXW8U9sZHaAXMAC6dUG9
         +Le34pAbtaEBRt6UwEgz35I91sB3OgBl0t9XpGZ0DrbKYpx9H+9KSKw2DGeZZONP+NU1
         9B79Uk4f15BF2N8ctRWSwAIsVdBGX48l8WS+yHzo3Uw7zSPWpSj4IDXdqEbJPj4NeFy3
         dCIRuCrxsU1nKrCxvQxeTFJwoXLA1K/ZtkdMA7/zEkKLbeK3WXCdg9zOSzq1js7+qaRg
         IIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668882; x=1762273682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpH4OZPnfyyaGId/GUkqaK3YoVR6iNW7qBGDUd27apA=;
        b=K9vFg4HVmVcXMXzFnRXF5Y+pp0O/nFmdPsBFExkUCzRnq1S5Upq/pN8jmn3z7g/JMY
         rNBL8bRxBydbefdVLCp1McdpZUdQqrx4UBbjXOV2Npfb8hB5DJ07lGyzINPp+e2HP+X4
         r8/IUR2wtPrT+gUFeHmW223ugS+PM0QBl5jSX+PxOoHrTQZzmGzbDsmOqbG7J/eQEhAh
         rRiwDyfphQqQ7Ohde+XvOpbPMqOMsWsWVFlNAmyxL6NsF86ciK/+bHQVUadGMVwIzePM
         a+hLfBsevPwmQQRhNZyb8+NOnjspMGnLya4iftUkyvqHbIbYrHaBj1xjvierTGtcj11Q
         j9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUgt2+PNtyEz6OK87oIyRFPz7ljsMc/MZX6bih65qWLe+mFYH9WOWh3uE64B3Rpx3w9SE13DzLucPJad/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34nT4U86LXQndifefBN8WOUMoMorGsXZttd3Q8j1fZecRApT+
	Ho5C1a1W15tKjitf9EEI9TxCDWhq0scMoKmoEoGK9pvCYHi6amS9GSs2
X-Gm-Gg: ASbGncurms6RfQPhgIIWLY6ebPE7WveB8mK8A00zEd2RFhaZIyKeKt8D7A8wdSvjMI1
	oy9K2EuA7zxSULqUgW5MRQGyOHE/9ReGmHPC4h/uKaycE/kcUUQ/sHDu5lOv/GWbL1B0Rq3egM5
	kApnTImI3N2b7AA986iSCpwFhs9ua0MG02jrsfgLCJxjwIS8vqfUbJN5vTFk9AvTPazdgzJKoOS
	QWONTvg3LD3o8DaOI4/rqV93YEbnZheVGAv34OFnFKKfUFrdMz0i8QcVJA6J5g21/sQIFPgZSx3
	aTovH13eOFqWsVk0eh7w2pRrRscncNhnFsp0r0ge9fQfKyRhq1KKUIm15FgNGbPiJaknA7vl3Cb
	eCvwrDDK5maP5vVs6lXI6zXaKfd7mpRITGNkbtGJUkqPRBprloV+f3qCZU5/0DNxyNqBWQf2emB
	RvhgE=
X-Google-Smtp-Source: AGHT+IG1DvQPt8gv7ypNW4eJAFL+/pZTY2Li7wlh6Z99CzzF1GPSYmRMS1mrHhgQN4o7AoaWMw4ELg==
X-Received: by 2002:a17:902:e5c4:b0:273:1516:3ed2 with SMTP id d9443c01a7336-294cb51bec5mr51970185ad.50.1761668882078;
        Tue, 28 Oct 2025 09:28:02 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3405sm124241585ad.2.2025.10.28.09.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:28:01 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:57:58 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: syzbot <syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, rakie.kim@sk.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: [syzbot] [mm?] WARNING in raw_ioctl
Message-ID: <njddimio6m6pi3bcfyixizrfzjfflqvqe32xlfwn24vtzk67j4@3cijvucydtb5>
References: <68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xmwrvot3vihfxbiv"
Content-Disposition: inline
In-Reply-To: <68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com>


--xmwrvot3vihfxbiv
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

#syz test

--xmwrvot3vihfxbiv
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-raw-gadget-cap-raw_io-transfer-length-to-KMALLOC.patch"

From a483c5673cef7995e74dc3556196e25344b5e434 Mon Sep 17 00:00:00 2001
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
Date: Tue, 28 Oct 2025 20:18:04 +0530
Subject: [PATCH] usb: raw-gadget: cap raw_io transfer length to
 KMALLOC_MAX_SIZE
To: andreyknvl@gmail.com,
    gregkh@linuxfoundation.org
Cc: snovitoll@gmail.com,
    linux-usb@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    skhan@linuxfoundation.org,
    david.hunter.linux@gmail.com,
    khalid@kernel.org,
    linux-kernel-mentees@lists.linux.dev,
    syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com

The previous commit removed the PAGE_SIZE limit on transfer length of
raw_io buffer in order to avoid any problems with emulating USB devices
whose full configuration descriptor exceeds PAGE_SIZE in length. However
this also removes the upperbound on user supplied length, allowing very
large values to be passed to the allocator.

syzbot on fuzzing the transfer length with very large value (1.81GB)
results in kmalloc() to fall back to the page allocator, which triggers
a kernel warning as the page allocator cannot handle allocations more
than MAX_PAGE_ORDER/KMALLOC_MAX_SIZE.

Since there is no limit imposed on the size of buffer for both control
and non control transfers, cap the raw_io transfer length to
KMALLOC_MAX_SIZE and return -EINVAL for larger transfer length to
prevent any warnings from the page allocator.

Fixes: 37b9dd0d114a ("usb: raw-gadget: do not limit transfer length")
Tested-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68fc07a0.a70a0220.3bf6c6.01ab.GAE@google.com/
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b71680c58de6..46f343ba48b3 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -40,6 +40,7 @@ MODULE_LICENSE("GPL");
 
 static DEFINE_IDA(driver_id_numbers);
 #define DRIVER_DRIVER_NAME_LENGTH_MAX	32
+#define USB_RAW_IO_LENGTH_MAX KMALLOC_MAX_SIZE
 
 #define RAW_EVENT_QUEUE_SIZE	16
 
@@ -667,6 +668,8 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
 		return ERR_PTR(-EINVAL);
 	if (!usb_raw_io_flags_valid(io->flags))
 		return ERR_PTR(-EINVAL);
+	if (io->length > USB_RAW_IO_LENGTH_MAX)
+		return ERR_PTR(-EINVAL);
 	if (get_from_user)
 		data = memdup_user(ptr + sizeof(*io), io->length);
 	else {
-- 
2.43.0


--xmwrvot3vihfxbiv--

