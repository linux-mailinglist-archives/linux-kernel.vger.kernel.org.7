Return-Path: <linux-kernel+bounces-815005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D218B55DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E91585108
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B02C3D984;
	Sat, 13 Sep 2025 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd4R4ceV"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C658191484
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757732501; cv=none; b=KF8ywFWzOdAhQAbKTqFiytXL+yVUQYfMvawRS7Wqb/Mu8GpuL9k1iuFL6T8ni5N1sAzD+UxaLTknAbx2q1Dxur8iOC85TMAHExEgBot5bOCxKjmRbzsaBDV3jLKna6opCB8zsVjsejH/BRs7PYsh/1YmXKzck50lvoV/v0rRfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757732501; c=relaxed/simple;
	bh=Tqmy3RzN69T7WsAassez3x+szYhWb4TDPIz6UCoacb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrAaKyJEBIasC5nnTljdmTfE2pll7w9PxePvW+CiACuGca/QsuNdah01X6DCZQ50UqBibxR9s92gpMRSC1NJRONN4lv88Uqn5cHBn5w8zpcdpjQKl8ZRitWAgNJRuSKUR9Zw4n0Ah5HhowrJT2ZFOWK8xcJpcdGmUv9bYWnK+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd4R4ceV; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d60110772so20202327b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757732498; x=1758337298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uliSGbwbhsOvGzihBxvx6lyD+FSejHQfj2aem/BFtBo=;
        b=dd4R4ceVkXifY9HkOjM0GNEnRGQovCcW+38Bn8RRsTDuLC8PcXC+V8ALYUa2WUf8nO
         eWVXK4ILVx7qTshCEjgVXqqP/RfKFfQr3wsW8jAQiAkNVyxcLTIw++zozwKVWqnpd0g/
         kX2gISbjhG9x84y5zrzriLIsBekMZGFFFyJtdNc19AIjRg37TeXV4s0P2HkMrk9/ADVL
         cBIU0EhpNbAEZExpU55dMY2Enlu4yxiJJi3AtQ39yyRM7d6I0I3eYPHAkpgOGkDWr5K2
         C9pJp8a74vfBZE+MVOVQe5LnPtk2bQBYGx9k4rIhM/Xb0a3Fx12juGMQzbNgkKH6qmzQ
         QCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757732498; x=1758337298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uliSGbwbhsOvGzihBxvx6lyD+FSejHQfj2aem/BFtBo=;
        b=wXaUp6sGMXSeDRg57QICq94cWdtUSzINOK5r3Ks7C4zX83ENMcVL6lfcwH54vMFIrr
         RwXcsPBJP0B7LDJRHgECcnLZBS+IT9Fo7s7ySLEpGD6DN6o3goYh0/o1k/ndsh0UJBGt
         zyBgs/mPxUAZ71JBalC4p8Gfq6L+cEWLrZT4C/sOYnoVcRpz6c2OWLvgFbyxUZGc6WNA
         wISePQNjx36ZMzJkA1o2XWX3AWTkw0nOB7AUxqt5EGoMD7TSLqJjHvknrbDkcg+yRwFX
         nCZT6wxHo1vFyEif+uQIZjFAoP831CSQwuf63J15hEmrqjlXCbTDqePctLEGdCg9JpZA
         xQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY4ejFA3aE0BeEDnJLoaf8eqVfL1fuesGOd2dwHtejPT0BcfntyH3nRtE79btZ0OKa+xsg/qtY0YVEVYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jhA/mr+/84wxNGjt40XeQvwmSezn8eq8My5qDBcgITqgU4JH
	CSlcoeZuIoJfeVQ+xxVJl9wYa3cIb4WVvcB8Ah60aooCG5hvDTu2yNl4g7XTmIdNs4RmE2k+5AI
	VBjRmcFFygnXApnRGnxRs/zYd3fVrtto=
X-Gm-Gg: ASbGncsnFDD2mWTg+3K+k5kifdHL5R++dt8o13Bko0+9oj+Lbi4fNZgDjidbtbrBTgd
	aIIq8tvQUpwdIdC7dpdUXgh7YfWrmJipljzWK23aefmk0gclyNq0LyKMl5y08LXM3BnyCAQfcZy
	iuEuT0Zs0+zF+QxQOqqc7nlDTh2Z3QVnlf44ZBrjsoXoTOjq+UVRgV+X9eHtFZKUjHFFuYEBqX3
	dND2zdp7q1YTPWT
X-Google-Smtp-Source: AGHT+IF7lM80ofxl9uby0dTffjMvg+YkhDg0Gt/xUeKJW0MwA28xGC5rzQ6PFKetGJ5+XuhmXlirPVdi/5xICQYzzC4=
X-Received: by 2002:a05:690c:4989:b0:721:5b31:54bb with SMTP id
 00721157ae682-73063097308mr55415927b3.23.1757732498067; Fri, 12 Sep 2025
 20:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUfDuoMMCUmBuSkiV_b=VNn7CuYqJSc19bhyQ6Kims36w@mail.gmail.com>
 <CABBYNZ+PJuvWYk_XVw=esNj1hVMPESjTc70VLQH=LrKdSqD7ag@mail.gmail.com>
 <CAFRLqsUE84wW0JKbsh6Lw0USQbnCbokXd3PANc+4i_nsnEUMYA@mail.gmail.com>
 <CABBYNZ+xg05sbfU51VXo1M=PqPOktDtRpTe5yHwwUhF9ui+NPA@mail.gmail.com> <CAFRLqsVj28niHO9XejYrMu2g3fCrDXXgArshP-kr4CM=eV2smQ@mail.gmail.com>
In-Reply-To: <CAFRLqsVj28niHO9XejYrMu2g3fCrDXXgArshP-kr4CM=eV2smQ@mail.gmail.com>
From: cen zhang <zzzccc427@gmail.com>
Date: Sat, 13 Sep 2025 11:01:26 +0800
X-Gm-Features: Ac12FXzN8m70AXsZ_MHwW6LEpK6VSvv2st-TVbwslihDNu-HZZ47xPLGiBG-oNc
Message-ID: <CAFRLqsV4m5GNr9fHsSneJkxG=crm5R75rJJJO4w5yQUd324znA@mail.gmail.com>
Subject: Re: [BUG]: slab-use-after-free Read in mgmt_set_powered_complete
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com, r33s3n6@gmail.com, 
	linux-bluetooth@vger.kernel.org, "gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

I've just started testing the patch, and it seems to have introduced a
new issue. I've attached the detailed report below:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in mgmt_pending_valid+0x8f/0x7e0
net/bluetooth/mgmt_util.c:330
Read of size 8 at addr ffff888140eae198 by task kworker/u17:2/82

CPU: 1 UID: 0 PID: 82 Comm: kworker/u17:2 Not tainted
6.17.0-rc5-ge5bbb70171d1-dirty #8 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xca/0x130 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x171/0x7f0 mm/kasan/report.c:482
 kasan_report+0x139/0x170 mm/kasan/report.c:595
 mgmt_pending_valid+0x8f/0x7e0 net/bluetooth/mgmt_util.c:330
 mgmt_set_powered_complete+0x81/0xf20 net/bluetooth/mgmt.c:1326
 hci_cmd_sync_work+0x8df/0xaf0 net/bluetooth/hci_sync.c:334
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
 worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
 kthread+0x3d4/0x800 kernel/kthread.c:463
 ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 195:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x72/0x90 mm/kasan/common.c:405
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 mgmt_pending_new+0xcd/0x580 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x54/0x410 net/bluetooth/mgmt_util.c:296
 set_powered+0x8c6/0xea0 net/bluetooth/mgmt.c:1406
 hci_mgmt_cmd+0x1ee4/0x33f0 net/bluetooth/hci_sock.c:1719
 hci_sock_sendmsg+0xcb0/0x2510 net/bluetooth/hci_sock.c:1839
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 sock_write_iter+0x1b7/0x250 net/socket.c:1179
 do_iter_readv_writev+0x598/0x760
 vfs_writev+0x3c8/0xd20 fs/read_write.c:1057
 do_writev+0x105/0x270 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 82:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x41/0x50 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2428 [inline]
 slab_free mm/slub.c:4701 [inline]
 kfree+0x189/0x390 mm/slub.c:4900
 mgmt_pending_free net/bluetooth/mgmt_util.c:311 [inline]
 mgmt_pending_foreach+0x6c4/0x8a0 net/bluetooth/mgmt_util.c:257
 mgmt_power_on+0x43d/0x5e0 net/bluetooth/mgmt.c:9448
 hci_dev_open_sync+0x44fa/0x5060 net/bluetooth/hci_sync.c:5137
 hci_power_on_sync net/bluetooth/hci_sync.c:5376 [inline]
 hci_set_powered_sync+0x43e/0xfa0 net/bluetooth/hci_sync.c:5768
 set_powered_sync+0x1e0/0x2c0 net/bluetooth/mgmt.c:1369
 hci_cmd_sync_work+0x798/0xaf0 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
 worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
 kthread+0x3d4/0x800 kernel/kthread.c:463
 ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888140eae180
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff888140eae180, ffff888140eae1e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000
index:0xffff888140eae200 pfn:0x140eae
flags: 0x200000000000200(workingset|node=3D0|zone=3D2)
page_type: f5(slab)
raw: 0200000000000200 ffff888100042280 ffffea0004763ad0 ffffea0004763a90
raw: ffff888140eae200 000000000020001f 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888140eae080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888140eae100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff888140eae180: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff888140eae200: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888140eae280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Best regards,
Cen Zhang

cen zhang <zzzccc427@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8813=E6=97=A5=
=E5=91=A8=E5=85=AD 10:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Luiz,
>
> Thanks for your patch! It not only addresses the TOCTOU issue we
> discussed but may also fix another bug I reported
> (https://lore.kernel.org/linux-bluetooth/CAFRLqsWWMnrZ6y8MUMUSK=3DtmAb3r8=
_jfSwqforOoR8_-=3DXgX7g@mail.gmail.com/T/#u).
>
> I will test it soon to confirm.
>
> Thanks again for the great work.
>
> Best regards,
>
> Cen Zhang
>
> Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=
=9C=8813=E6=97=A5=E5=91=A8=E5=85=AD 02:29=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi Cen,
> >
> > On Fri, Sep 12, 2025 at 11:59=E2=80=AFAM cen zhang <zzzccc427@gmail.com=
> wrote:
> > >
> > > Hi Luiz,
> > >
> > > Thank you for your quick response and the important clarification
> > > about hci_cmd_sync_dequeue().
> > >
> > > You are absolutely correct - I was indeed referring to the TOCTOU
> > > problem in pending_find(), not the -ECANCELED check. The
> > > hci_cmd_sync_dequeue() call in cmd_complete_rsp() is a crucial detail
> > > that I initially overlooked in my analysis.
> > >
> > > After examining the code more carefully, I can see that while
> > > hci_cmd_sync_dequeue() does attempt to remove pending sync commands
> > > from the queue, but it cannot prevent the race condition we're seeing=
.
> > > The fundamental issue is that hci_cmd_sync_dequeue() can only remove
> > > work items that are still queued, but cannot stop work items that are
> > > already executing or about to execute their completion callbacks.
> > >
> > > The race window occurs when:
> > > 1. mgmt_set_powered_complete() is about to execute (work item has bee=
n dequeued)
> > > 2. mgmt_index_removed() -> mgmt_pending_foreach() -> cmd_complete_rsp=
() executes
> > > 3. hci_cmd_sync_dequeue() removes queued items but cannot affect the
> > > already-running callback
> > > 4. mgmt_pending_free() frees the cmd object
> > > 5. mgmt_set_powered_complete() still executes and accesses freed cmd-=
>param
> > >
> > > I am sorry that I haven't get a reliable reproducer from syzkaller fo=
r
> > > this bug may be due to it is timing-sensitive.
> >
> > Let's try to fix all instances then, since apparently there is more
> > than one cmd with this pattern, please test with the attached patch.

