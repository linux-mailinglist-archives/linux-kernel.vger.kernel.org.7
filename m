Return-Path: <linux-kernel+bounces-738389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8607B0B7CB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B1C1897C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEA1217730;
	Sun, 20 Jul 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="i+SdfdvW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC951AF0A7
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753037382; cv=none; b=kealv1bJlXfXWQ4IWdInh5kyr6jbnVMl4iJIF0rLPl+nbZmcj5kwGn+s5oCt9MRneOOAP4IxH2koW9Bbv9e96eMRy4+Edq1odnHY+7/s6vZ+zZnlrKZvqto6/Y4wSKqw7ktXYdQWSQGi00Y1+wn5T91VhGFlIolJdF90uLRHNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753037382; c=relaxed/simple;
	bh=DJt9x44QPZFAjmmVEvfgHPt23vB6tUePPX5WhJlw7eA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=e+7EMSl6oZCqzNDZkI8IWC0iYARw135Yq69XiPJZWDKdN5YmvFOnkAPJ2Iesuns0fq+uX8dEgQFhqyVSdua7jQznEOG/QSB1eMdYQyAYLIgjM0FEbwttrBeKjNDTlkUV+bYQZQL/inLCFSqaf1Od5V/jt9ZjIaRp8UTJy9Y4PcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=i+SdfdvW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2363616a1a6so30117625ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753037378; x=1753642178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFBbbGkZi2NVDYLzByzmjBIxiXbTBylqdEzUXwXkrb4=;
        b=i+SdfdvWYqMksBKoP6LYT7gHAiEmBXBq+g+hzecJwI9JApXojd4ap17QV0yvzrvPMs
         z8GtCIjA34g6T0c0VI5imA/n9YM2KDuVquBVsMaM78ydiWSEXCO6aCPJDrami+B4LtZZ
         62I5+jLANIUUWJLT+IGHx/OdEAk6zLvzpAWIX/Ah7b21Pua4OUDU+3XujNyBy2isxwkq
         RVfbexBidnPrcJ69PkblD7XvquURwlbE127jY6mGQmT3A7kXtEjzcHqKCQz1SKjDfvks
         Cr3kNSiX+ZSb8XO2sm10gnjgwA/6OqFq+tj35uC6JdjPCJmfAhjll1NgYc1euSCJ8TH+
         4bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753037378; x=1753642178;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFBbbGkZi2NVDYLzByzmjBIxiXbTBylqdEzUXwXkrb4=;
        b=hqdx+JKCPd0k6qIn7vmMLW5y721pEC2jk7e+/2l42UUnHo+eRLX56f/jPKbV7VjZL/
         Ur/6Cl7wE4WveEFHqJTHmD1K1MEw1dzjzUCIge4vQQUtaUjScAuZ9t3Xh1HH/4wt3Rs+
         4uQHDehbjma8eRpYtZQuop41Uoc9NP8ge7/Kw4HCJqMfHqwHwDvC6s9FffiXA5t3bab1
         Pby79MFuRsSlY1BxqaOUFuzM4mHhUeHWRvg2YTbkh6B5hVHnpfi/2Q0/lHQrtX3YGpk5
         wg7wnFvwQ4C8bK4T11JEdUU9XQVnZ2ksk1lvWsgwTo8bCjAbacnAj/g0x+PLkQQv7W4r
         MsqA==
X-Forwarded-Encrypted: i=1; AJvYcCWjVEYnm6dWBjJLa22WrY6ZE10Da5v1eZXx5Wta+W8/73xo1RTg2l3ouVOnDndAeFLqOSCNhMhKAPe2RAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+An818q2u+aUC3EZraOPf09AVZgQ5FrmDI7MHJLfuA/p7OXF
	7NbNmNmkQKJNjcThDxhVes2CQ8/i+Vdmmea/LtuZVSIuZtIyYnJAMCNp9UbkbKsN+3w=
X-Gm-Gg: ASbGncvwsZ52eC7jUaiIxH3HUPY1QESk8v2uFFGBD0KUSQklSi3k2UwJHc/UBY6Ff4a
	4QUlbWcfd1JcaC6B7RV7Bno7lXER7rIOx0yxG7Y2kAcqbq7wp9LX03qXa2ciNYBgVG+FsTnUSXD
	+GVoDISP2LotUvti6gSF37tzHQQYQWBzn4zVBlysbqrBG/4xsO3ovxTidcvXa6LYrrSdIuMpP95
	MYQhFTUkWZB93EWpe5/M8BdwcPG7DG4231rI95s86f13QnfxwEEA2b7cT4XMP6EjxQW6Ks5DpAx
	9bm/GVS//dfRBLOx6TBs/L0HmqmnyKZFq7Ix3+vETctvdUeSsrEyfJWTFIF2hDSAQVSfdA+pTI6
	7pIYYIGa90FwPqTD/ND+k5Wg=
X-Google-Smtp-Source: AGHT+IFPGIaaT31rgByZeuo6mdgWS+1om9EfCrYWAMJHZ/X/OJLGf80fauYfoo07QLA5lCHOAtUKYQ==
X-Received: by 2002:a17:902:c409:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23e256848f5mr204819855ad.6.1753037378198;
        Sun, 20 Jul 2025 11:49:38 -0700 (PDT)
Received: from [100.74.100.100] ([12.129.159.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d1ce0sm44678575ad.149.2025.07.20.11.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 11:49:37 -0700 (PDT)
Message-ID: <ede52bb4-c418-45c0-b133-4b5fb6682b04@kernel.dk>
Date: Sun, 20 Jul 2025 12:49:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in
 io_poll_remove_entries
From: Jens Axboe <axboe@kernel.dk>
To: syzbot <syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, abbotti@mev.co.uk,
 hsweeten@visionengravers.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <687bd5fe.a70a0220.693ce.0091.GAE@google.com>
 <9385a1a6-8c10-4eb5-9ab9-87aaeb6a7766@kernel.dk>
Content-Language: en-US
In-Reply-To: <9385a1a6-8c10-4eb5-9ab9-87aaeb6a7766@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/20/25 12:24 PM, Jens Axboe wrote:
> On 7/19/25 11:29 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    4871b7cb27f4 Merge tag 'v6.16-rc6-smb3-client-fixes' of gi..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1288c38c580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa738a4418f051ee
>> dashboard link: https://syzkaller.appspot.com/bug?extid=01523a0ae5600aef5895
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1688c38c580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166ed7d4580000
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4871b7cb.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/4a9dea51d821/vmlinux-4871b7cb.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/f96c723cdfe6/bzImage-4871b7cb.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
>> BUG: KASAN: slab-use-after-free in _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
>> Read of size 1 at addr ffff88803c6f42b0 by task kworker/2:2/1339
>>
>> CPU: 2 UID: 0 PID: 1339 Comm: kworker/2:2 Not tainted 6.16.0-rc6-syzkaller-00253-g4871b7cb27f4 #0 PREEMPT(full) 
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> Workqueue: events io_fallback_req_func
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:94 [inline]
>>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>>  print_address_description mm/kasan/report.c:378 [inline]
>>  print_report+0xcd/0x610 mm/kasan/report.c:480
>>  kasan_report+0xe0/0x110 mm/kasan/report.c:593
>>  __kasan_check_byte+0x36/0x50 mm/kasan/common.c:557
>>  kasan_check_byte include/linux/kasan.h:399 [inline]
>>  lock_acquire kernel/locking/lockdep.c:5845 [inline]
>>  lock_acquire+0xfc/0x350 kernel/locking/lockdep.c:5828
>>  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
>>  _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
>>  spin_lock_irq include/linux/spinlock.h:376 [inline]
>>  io_poll_remove_entry io_uring/poll.c:146 [inline]
>>  io_poll_remove_entries.part.0+0x14e/0x7e0 io_uring/poll.c:179
>>  io_poll_remove_entries io_uring/poll.c:159 [inline]
>>  io_poll_task_func+0x4cd/0x1130 io_uring/poll.c:326
>>  io_fallback_req_func+0x1c7/0x6d0 io_uring/io_uring.c:259
>>  process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
>>  process_scheduled_works kernel/workqueue.c:3321 [inline]
>>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>>  kthread+0x3c5/0x780 kernel/kthread.c:464
>>  ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>  </TASK>
>>
>> Allocated by task 6154:
>>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
>>  kmalloc_noprof include/linux/slab.h:905 [inline]
>>  kzalloc_noprof include/linux/slab.h:1039 [inline]
>>  __comedi_device_postconfig_async drivers/comedi/drivers.c:664 [inline]
>>  __comedi_device_postconfig drivers/comedi/drivers.c:721 [inline]
>>  comedi_device_postconfig+0x2cb/0xc80 drivers/comedi/drivers.c:756
>>  comedi_device_attach+0x3cf/0x900 drivers/comedi/drivers.c:998
>>  do_devconfig_ioctl+0x1a7/0x580 drivers/comedi/comedi_fops.c:855
>>  comedi_unlocked_ioctl+0x15bb/0x2e90 drivers/comedi/comedi_fops.c:2136
>>  vfs_ioctl fs/ioctl.c:51 [inline]
>>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Freed by task 6156:
>>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
>>  poison_slab_object mm/kasan/common.c:247 [inline]
>>  __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>>  kasan_slab_free include/linux/kasan.h:233 [inline]
>>  slab_free_hook mm/slub.c:2381 [inline]
>>  slab_free mm/slub.c:4643 [inline]
>>  kfree+0x2b4/0x4d0 mm/slub.c:4842
>>  comedi_device_detach_cleanup drivers/comedi/drivers.c:171 [inline]
>>  comedi_device_detach+0x2a4/0x9e0 drivers/comedi/drivers.c:208
>>  do_devconfig_ioctl+0x46c/0x580 drivers/comedi/comedi_fops.c:833
>>  comedi_unlocked_ioctl+0x15bb/0x2e90 drivers/comedi/comedi_fops.c:2136
>>  vfs_ioctl fs/ioctl.c:51 [inline]
>>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>>  __se_sys_ioctl fs/ioctl.c:893 [inline]
>>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> I took a quick look at this, and surely looks like a comedi bug. If you
> call the ioctl part (do_devconfig_ioctl()) with a NULL arg, it just does
> a detach and frees the device, regardless of whether anyone has it
> opened or not?! It's got some odd notion of checking whether it's busy
> or not. For this case, someone has a poll active on the device, yet it
> still happily frees it.
> 
> CC'ing some folks, as this looks utterly broken.

Case in point, I added:

diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 376130bfba8a..4d5fde012558 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -167,6 +167,7 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
 				kfree(s->private);
 			comedi_free_subdevice_minor(s);
 			if (s->async) {
+				WARN_ON_ONCE(waitqueue_active(&s->async->wait_head));
 				comedi_buf_alloc(dev, s, 0);
 				kfree(s->async);
 			}

and this is the first thing that triggers:

WARNING: CPU: 1 PID: 807 at drivers/comedi/drivers.c:170 comedi_device_detach+0x510/0x720
Modules linked in:
CPU: 1 UID: 0 PID: 807 Comm: comedi Not tainted 6.16.0-rc6-00281-gf4a40a4282f4-dirty #1438 NONE 
Hardware name: linux,dummy-virt (DT)
pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : comedi_device_detach+0x510/0x720
lr : comedi_device_detach+0x1dc/0x720
sp : ffff80008aeb7880
x29: ffff80008aeb7880 x28: 1fffe00020251205 x27: ffff000101289028
x26: ffff00010578a000 x25: ffff000101289000 x24: 0000000000000007
x23: 1fffe00020af1437 x22: 1fffe00020af1438 x21: 0000000000000000
x20: 0000000000000000 x19: dfff800000000000 x18: ffff0000db102ec0
x17: ffff80008208e6dc x16: ffff80008362e120 x15: ffff800080a47c1c
x14: ffff8000826f5aec x13: ffff8000836a0cc4 x12: ffff700010adcd15
x11: 1ffff00010adcd14 x10: ffff700010adcd14 x9 : ffff8000836a105c
x8 : ffff800085bc0cc0 x7 : ffff00000b035b50 x6 : 0000000000000000
x5 : 0000000000000000 x4 : ffff800080960e08 x3 : 0000000000000001
x2 : ffff00000b4bf930 x1 : 0000000000000000 x0 : ffff0000d7e2b0d8
Call trace:
 comedi_device_detach+0x510/0x720 (P)
 do_devconfig_ioctl+0x37c/0x4b8
 comedi_unlocked_ioctl+0x33c/0x2bd8
 __arm64_sys_ioctl+0x124/0x1a0
 invoke_syscall.constprop.0+0x60/0x2a0
 el0_svc_common.constprop.0+0x148/0x240
 do_el0_svc+0x40/0x60
 el0_svc+0x44/0xe0
 el0t_64_sync_handler+0x104/0x130
 el0t_64_sync+0x170/0x178

Not sure what the right fix for comedi is here, it'd probably be at
least somewhat saner if it only allowed removal of the device when the
ref count would be 1 (for the ioctl itself). Just ignoring the file ref
and allowing blanket removal seems highly suspicious / broken.

As there's no comedi subsystem in syzbot, moving it to kernel:

#syz set subsystems: kernel

-- 
Jens Axboe

