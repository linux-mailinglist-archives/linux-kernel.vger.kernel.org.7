Return-Path: <linux-kernel+bounces-730274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE1B04234
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E647D3A8B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9925A2B2;
	Mon, 14 Jul 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRREs258"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DB19047A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504764; cv=none; b=dmqhpaa5U50ZioRG/Frs4mlRxY3ljdiGze2ezCZPE7wg2xJE5sL370kmNzYUZKMCbwOSMFnwvi4SIi47+9Y+4y8LyoNIirucrKT9969QPHfchKMNmj2L2oPFeiR/CdhmjHlUr0+3Dq+fIYJtF+im18no17k30aNcrk6lVeHRtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504764; c=relaxed/simple;
	bh=mzzJD8n7z+13tmDlx1HenLVTXKmm5fvYc5wPRCiaCS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DN3Jc6L6j2gtv/KkAa2CDicGbqo5NYxVZg2KSPKGG8yTEvcY7byO/uEOM/TbF1qWPskp6mhmuXisE7nm2yuTKD8/eDVOM8OnE448IeeCKIzJgfftn+T+jHobS7ERwEQ7SIH9E8ISQys1RlXwPKS2l47bG58kHGwLhuNaxFFwdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRREs258; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-555024588b1so4974374e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752504758; x=1753109558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pl6yLFDRG/p7Pm6WUAo0ZPGWY2e4xkA7pFNk9ihXcs=;
        b=TRREs2583Pnb2SYabHdZp4SlAd7cbncvdgSRZDfiC3Wr6o3Wd5jPvdrS4BVgGlk4wL
         kmqCNXBhTy14EI0/dtP9qg/Tvr636zkig+UIdk0ZV5mBzNh8jp7EQ2ya+ejIwEC7UopL
         UpEgq1Tc8//ZWRuGwl/4bH8RNOpfDIPIZ4XRcXDvaS6kgI6rabMC6ubgm3KiNAJqGpQl
         vo4UX240jDd6QWARUmbl3ZreA3rcnrTqAJ4p9QMuyoX41I4cfbYcndN763qiJUA40BHh
         0zNuZdfp6qpd7H9ROhep7OKOXP985ARJOOG4w8IltKLF9ByIG8+UdRwsYn1URiLDOygE
         no9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504758; x=1753109558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Pl6yLFDRG/p7Pm6WUAo0ZPGWY2e4xkA7pFNk9ihXcs=;
        b=QPavvVynDpR0twvVe7+3S9QFA13l73e0Tk7vHL1liHrsRlcNjGL3TOwc7P0Y6DH/Ox
         mpZKqqtpn/mDHjkzCwrLLoxVoaatT/UYWBm0WyIvi+ow1RTXHxmqVhO5Dl3mn4B9W+K1
         C8/THNVhVmgHkz0XH/LeDTiUwC6IpNkJsApWx965eR46i50p2vqSJRp6tYdH/7dEv0bc
         pNlFIV32kZtMpgvCxKzmjrLjk0XN7W3N9QHUeTlLfg15BYsq/YsPvpGJcyxEsbS0CYj9
         bc2h7m4HmF4yESywtRgFK/mrcWarx2skdJBybPJ6GMI5X+jxT8WeWBD2qB/wp+YHfg22
         tZfg==
X-Gm-Message-State: AOJu0YyPY2L4Fy16iMQ+MK7gHxFdS/xZf5wYa4ZfM1bLzMU/tbF++qSY
	GivavvRUZkodoc3CCgVDE2HAS8vsPrlAQzhFbbIqodOv0y/NJwY+HlD+9TIG/HrY30hS5bdG4TV
	FpvwuXzMsGxAy+sYwgIgL26HKBKGqXfU=
X-Gm-Gg: ASbGncsIxCWRYX/OQcN7cGKavzNeED0R5SPhPeE9GDvNd64hdRL5y8PFycY1ztCuWFc
	oE6WldNzubaSdw8zJFraw7odQMfT8HtHrnguGrmag1O9ybZCD7IO0gnSV4MyMEdz6xBi5Dp79QP
	KfHMO60oTmJhWlajgrRGwNQDxmAywc1sPpF41aZoqvPuASM3NFx7tElWOwJcFeCAHLfYWAxnQIr
	9qYFOa4HA6WCxyygrvxbYmeXmtIgRyn4gysJIjLVA==
X-Google-Smtp-Source: AGHT+IFuWwikKQcOFnwlTfM1Kgj9lO9ZX1kIE823HRbDnS8vDGADNowzTwGy/8JCBHmMZ6W1+WuIEwjKrS5oKPcPREk=
X-Received: by 2002:a05:6512:32d1:b0:553:24b7:2f6f with SMTP id
 2adb3069b0e04-55a0464f653mr2905201e87.51.1752504757115; Mon, 14 Jul 2025
 07:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH4c4jJvtLx6=uQeNGn6ndf9OQgYRzAV_0szcpBJzyTAOZXKGA@mail.gmail.com>
 <68750caf.050a0220.2efa37.001c.GAE@google.com>
In-Reply-To: <68750caf.050a0220.2efa37.001c.GAE@google.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Mon, 14 Jul 2025 20:22:25 +0530
X-Gm-Features: Ac12FXxz639kNOOI-ItDmLwHWQtKP9SYFedQBZEIadf9VrWyJm0zCNNVBlcGNz8
Message-ID: <CAH4c4jLBVi5PTgPup4ZPZTKmz1LnVcHHaeN36DBfoajh-BvXgg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in __kmap_local_page_prot
To: syzbot <syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 7:30=E2=80=AFPM syzbot
<syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> INFO: task hung in _vm_unmap_aliases
>
> INFO: task kworker/0:0:9 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:df83dd84 r8:00000002 r7:60000013 r6:df83dd8c r5:82e36000
>  r4:82e36000
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:82e36000 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:df83de08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84692a40
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18005 r8:82e36000 r7:00000000 r6:82c18000 r5:00001000 r4:7f02b000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfa4b000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:8416af8c r4:8416ac00
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:dddced40 r6:82c18000 r5:8416af8c r4:82cb7400
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:82e36000 r8:82cb742c r7:82604d40 r6:dddced40 r5:dddced60
>  r4:82cb7400
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:82cb7400 r8:8027e8dc r7:df819e48 r6:82cb7480 r5:82e36000
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdf83dfb0 to 0xdf83dff8)
> dfa0:                                     00000000 00000000 00000000 0000=
0000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:82cb6180
> INFO: task kworker/0:0:9 is blocked on a mutex likely owned by task kwork=
er/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: e929f000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> INFO: task kworker/1:1:43 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:1     state:D stack:0     pid:43    tgid:43    ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:df911d84 r8:00000002 r7:60000013 r6:df911d8c r5:82f48c00
>  r4:82f48c00
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:82f48c00 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:df911e08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eaff80
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:82f48c00 r7:00000000 r6:82c18200 r5:00001000 r4:7f029000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfa01000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84f20b8c r4:84f20800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84f20b8c r4:82fbb000
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:82f48c00 r8:82fbb02c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:82fbb000
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:82fbb000 r8:8027e8dc r7:df879e60 r6:82fbb080 r5:82f48c00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdf911fb0 to 0xdf911ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:82fa9f00
> INFO: task kworker/1:1:43 is blocked on a mutex likely owned by task kwor=
ker/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: ea606000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> INFO: task kworker/1:2:44 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:2     state:D stack:0     pid:44    tgid:44    ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:df915d84 r8:00000002 r7:60000113 r6:df915d8c r5:82f49800
>  r4:82f49800
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:82f49800 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:df915e08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84ebc440
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:82f49800 r7:00000000 r6:82c18200 r5:00001000 r4:7f00b000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dff73000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84e9b78c r4:84e9b400
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84e9b78c r4:82fbb200
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:82f49800 r8:82fbb22c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:82fbb200
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:82fbb200 r8:8027e8dc r7:df911e60 r6:82fbb400 r5:82f49800
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdf915fb0 to 0xdf915ff8)
> 5fa0:                                     00000000 00000000 00000000 0000=
0000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:82fbc100
> INFO: task kworker/1:2:44 is blocked on a mutex likely owned by task kwor=
ker/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: ea78b000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> INFO: task kworker/0:5:3828 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:5     state:D stack:0     pid:3828  tgid:3828  ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:dfdd5d84 r8:00000002 r7:60000013 r6:dfdd5d8c r5:84dea400
>  r4:84dea400
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:84dea400 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfdd5e08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84d99140
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18005 r8:84dea400 r7:00000000 r6:82c18000 r5:00001000 r4:7f029000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfa32000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84ce7f8c r4:84ce7c00
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:dddced40 r6:82c18000 r5:84ce7f8c r4:84689700
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84dea400 r8:8468972c r7:82604d40 r6:dddced40 r5:dddced60
>  r4:84689700
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84689700 r8:8027e8dc r7:eb8e9e60 r6:84689c00 r5:84dea400
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfdd5fb0 to 0xdfdd5ff8)
> 5fa0:                                     00000000 00000000 00000000 0000=
0000
> 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84d849c0
> INFO: task kworker/0:5:3828 is blocked on a mutex likely owned by task kw=
orker/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: eb094000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> INFO: task kworker/0:35:4078 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:35    state:D stack:0     pid:4078  tgid:4078  ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:dfc2dd84 r8:00000002 r7:60000013 r6:dfc2dd8c r5:84e5ec00
>  r4:84e5ec00
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:84e5ec00 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfc2de08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84ebe2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18005 r8:84e5ec00 r7:00000000 r6:82c18000 r5:00001000 r4:7f04b000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfbc3000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84e9a38c r4:84e9a000
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:dddced40 r6:82c18000 r5:84e9a38c r4:84eb8480
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e5ec00 r8:84eb84ac r7:82604d40 r6:dddced40 r5:dddced60
>  r4:84eb8480
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84eb8480 r8:8027e8dc r7:dfaa5e60 r6:84d41880 r5:84e5ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfc2dfb0 to 0xdfc2dff8)
> dfa0:                                     00000000 00000000 00000000 0000=
0000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84eb9ec0
> INFO: task kworker/0:35:4078 is blocked on a mutex likely owned by task k=
worker/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: eb094000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> INFO: task kworker/1:67:4097 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:67    state:D stack:0     pid:4097  tgid:4097  ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:dfd79d84 r8:00000002 r7:60000013 r6:dfd79d8c r5:834a8000
>  r4:834a8000
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:834a8000 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfd79e08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eae040
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:834a8000 r7:00000000 r6:82c18200 r5:00001000 r4:7f063000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfe4f000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:8418678c r4:84186400
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:8418678c r4:84d41f80
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:834a8000 r8:84d41fac r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f80
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f80 r8:8027e8dc r7:dfd55e60 r6:84eb8980 r5:834a8000
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd79fb0 to 0xdfd79ff8)
> 9fa0:                                     00000000 00000000 00000000 0000=
0000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebcc40
> INFO: task kworker/1:67:4097 is blocked on a mutex likely owned by task k=
worker/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: eb48c000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> INFO: task kworker/1:69:4104 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:69    state:D stack:0     pid:4104  tgid:4104  ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:dfe59d84 r8:00000002 r7:60000013 r6:dfe59d8c r5:84e12400
>  r4:84e12400
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:84e12400 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfe59e08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84ebc380
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e12400 r7:00000000 r6:82c18200 r5:00001000 r4:7f061000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfe3d000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:8418638c r4:84186000
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:8418638c r4:84d41480
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e12400 r8:84d414ac r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41480
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41480 r8:8027e8dc r7:dfd79e60 r6:84eb8880 r5:84e12400
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfe59fb0 to 0xdfe59ff8)
> 9fa0:                                     00000000 00000000 00000000 0000=
0000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc440
> INFO: task kworker/1:69:4104 is blocked on a mutex likely owned by task k=
worker/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: eb48c000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> INFO: task kworker/1:70:4105 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:70    state:D stack:0     pid:4105  tgid:4105  ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:dfe69d84 r8:00000002 r7:60000113 r6:dfe69d8c r5:84e13000
>  r4:84e13000
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:84e13000 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfe69e08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eae500
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e13000 r7:00000000 r6:82c18200 r5:00001000 r4:7f065000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfe95000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84186b8c r4:84186800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84186b8c r4:84d40000
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e13000 r8:84d4002c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d40000
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d40000 r8:8027e8dc r7:dfd79e60 r6:84eb8a00 r5:84e13000
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfe69fb0 to 0xdfe69ff8)
> 9fa0:                                     00000000 00000000 00000000 0000=
0000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84eae0c0
> INFO: task kworker/1:70:4105 is blocked on a mutex likely owned by task k=
worker/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: eb72c000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> INFO: task kworker/1:71:4107 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:71    state:D stack:0     pid:4107  tgid:4107  ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:dfd7dd84 r8:00000002 r7:60000013 r6:dfd7dd8c r5:84e11800
>  r4:84e11800
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:84e11800 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfd7de08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eaeb00
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e11800 r7:00000000 r6:82c18200 r5:00001000 r4:7f06b000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfeed000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:8418778c r4:84187400
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:8418778c r4:84d40080
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e11800 r8:84d400ac r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d40080
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d40080 r8:8027e8dc r7:dfe69e60 r6:84eb8b00 r5:84e11800
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd7dfb0 to 0xdfd7dff8)
> dfa0:                                     00000000 00000000 00000000 0000=
0000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84eae3c0
> INFO: task kworker/1:71:4107 is blocked on a mutex likely owned by task k=
worker/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: eba55000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> INFO: task kworker/1:72:4109 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:72    state:D stack:0     pid:4109  tgid:4109  ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:dfebdd84 r8:00000002 r7:60000113 r6:dfebdd8c r5:84e14800
>  r4:84e14800
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:84e14800 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfebde08
>  r4:00000000
> [<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0=
x40 kernel/locking/mutex.c:278)
> [<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240=
 mm/vmalloc.c:2912)
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eae780
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e14800 r7:00000000 r6:82c18200 r5:00001000 r4:7f067000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfea7000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84186f8c r4:84186c00
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84186f8c r4:84d40180
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e14800 r8:84d401ac r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d40180
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d40180 r8:8027e8dc r7:dfd7de60 r6:84eb8a80 r5:84e14800
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfebdfb0 to 0xdfebdff8)
> dfa0:                                     00000000 00000000 00000000 0000=
0000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84eae840
> INFO: task kworker/1:72:4109 is blocked on a mutex likely owned by task k=
worker/1:66:4095.
> task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid=
:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0x=
a8 kernel/sched/core.c:7109)
>  r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
>  r4:00000000
> [<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x=
18)
> Exception stack(0xdfd61d20 to 0xdfd61d68)
> 1d20: ebea6000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b=
45a0
> 1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 8023=
9a90
> 1d60: 80000013 ffffffff
>  r5:80000013 r4:80239a90
> [<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_are=
a_lazy+0x284/0x458 mm/vmalloc.c:2336)
>  r4:828b51e4
> [<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliase=
s+0x1e4/0x240 mm/vmalloc.c:2951)
>  r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
>  r4:dfd61dc0
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vma=
lloc.c:3343 [inline])
> [<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/=
vmalloc.c:3422)
>  r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
>  r4:00000000
> [<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem=
.c:399)
>  r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
> [<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x1=
4 kernel/bpf/core.c:1077)
>  r5:00001000 r4:dfdcb000
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free k=
ernel/bpf/core.c:1123 [inline])
> [<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe=
4 kernel/bpf/core.c:1246)
> [<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x1=
4c/0x164 kernel/bpf/core.c:2891)
>  r5:84185b8c r4:84185800
> [<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work=
+0x1b4/0x4f4 kernel/workqueue.c:3238)
>  r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_work=
s kernel/workqueue.c:3321 [inline])
> [<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x=
3d8 kernel/workqueue.c:3402)
>  r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
>  r4:84d41f00
> [<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kerne=
l/kthread.c:464)
>  r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
>  r4:00000001
> [<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/ar=
m/kernel/entry-common.S:137)
> Exception stack(0xdfd61fb0 to 0xdfd61ff8)
> 1fa0:                                     00000000 00000000 00000000 0000=
0000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
>  r4:84ebc6c0
> Future hung task reports are suppressed, see sysctl kernel.hung_task_warn=
ings
> INFO: task kworker/1:73:4110 blocked for more than 430 seconds.
>       Not tainted 6.16.0-rc6-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:73    state:D stack:0     pid:4110  tgid:4110  ppid:2     =
 task_flags:0x4208060 flags:0x00000000
> Workqueue: events bpf_prog_free_deferred
> Call trace:
> [<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched=
/core.c:6864 [inline])
> [<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/s=
ched/core.c:6879)
>  r10:82718544 r9:dfec1d84 r8:00000002 r7:60000013 r6:dfec1d8c r5:84e15400
>  r4:84e15400
> [<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18=
/0x24 kernel/sched/core.c:6936)
>  r5:84e15400 r4:82718540
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_=
common kernel/locking/mutex.c:679 [inline])
> [<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.=
constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
> [<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_s=
lowpath+0x14/0x18 kernel/locking/mutex.c:1035)
>  r10:8260c960 r9:00000001 r8
>
> Tested on:
>
> commit:         347e9f50 Linux 6.16-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13ba7d8258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D796037e828092=
46d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db18872ea9631b5d=
cef3b
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D153547d458=
0000
>
>

#syzbot, the original NULL pointer dereference in __kmap_local_page_prot
appears fixed. The remaining issue (task hang in _vm_unmap_aliases)
seems unrelated and part of a different bug path.

