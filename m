Return-Path: <linux-kernel+bounces-730155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BFEB040C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9353B0306
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20A525484A;
	Mon, 14 Jul 2025 13:57:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54D254841
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501427; cv=none; b=NNGMCM15dLKlbXbKyDYbFFepbFQiCFyYWj1PuAFEjMu85lH6OuCxp37RKkFmqcfnOqjw8g4sXjyKYKc9skJX4lSsGtvE+x341AHIMqF5mBOFMmvktosyHjrO7JLKEllVSjQmuyQfZ7S4p2642IEp67L0ZgG2evEZ1b3qgteIUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501427; c=relaxed/simple;
	bh=s9XWvhRU/IWd6idAfkAHoiVOtCG9TxLF7ZSJXMrjk5M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ducZm/Cl96t0Pbk1ScF8HpxjShV+Dihw/UUC94oxXCTvf0kc0RU4IXxJl73T8bzfbMKkluj440TPM+R+BZ0zCM7mIxLDziR+Nnu+OdvVWvW+iCBXFLC7SGYvSXv0ntzoQ8kp1RAlVaO/XVg8/n/QKRPETQCCp3q0lp8VrCiLUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8760733a107so486287339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501423; x=1753106223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8aBwdRb8R0U6yp5xl0s4FQYWTwK+Sjl1SXF++ygjOY=;
        b=DQCihr8YxoPVPpc9jrTOmL3iSwcCIkfUzHjdyzrhiNdUV/+jspER1LHyzJiyzXU6W+
         4U+v+tGUZf/qEBP3wCjminbYZ9OebvUZYb1XVGUnux/9DDI/GteZlwoJB8rkC3fIGkc3
         9s6DsrQRy+IDTs6TtOFIum+JGSnA3lcXuGXMfuvx270z1sn09qWxgRCpydU8FV33HC8C
         ZsdX9PSpo65439m6IePmuYYZ1M3NTTy4ZIegUnH8iaxRgrxZFtox0D8uiZPfLMTFVKUA
         hHwKVf4C+I1iyaer3FMbjpkbtZoiFITnU2D7QX9If4TTJsQry1+qtRYYcDyUjFoUBiMF
         BzgQ==
X-Gm-Message-State: AOJu0Yzpx+r07Ogq9ues9bpmRDf3S+OY0y7IlmTipfSTYdCa33lv9YSI
	ph8tvC7uW0l1EvdjAvHh841xa0DJqSvxUrrxMe31Jwn56nNOJJoCdk8MU9XRxsEBq4jU3KcktN2
	AL1GhkGTq6/v4EGO1qm4+IWA2no1UDmQuQbvbv69Pzt+BvukTFP/JPLaNR8A=
X-Google-Smtp-Source: AGHT+IFv1ZFAWlirFr+zruARcpanDyJ2H/9mVdv0dWDGmJTaJufNwscaMHHlHTgvEm7/k5AlFs8RWH+3YnG8CI/rOX0nEDfMJThV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:750c:b0:874:e108:8e3a with SMTP id
 ca18e2360f4ac-87977fe36fbmr1418443339f.12.1752501423028; Mon, 14 Jul 2025
 06:57:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 06:57:03 -0700
In-Reply-To: <CAH4c4jJvtLx6=uQeNGn6ndf9OQgYRzAV_0szcpBJzyTAOZXKGA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68750caf.050a0220.2efa37.001c.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in __kmap_local_page_prot
From: syzbot <syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pranav.tyagi03@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in _vm_unmap_aliases

INFO: task kworker/0:0:9 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:0     pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:df83dd84 r8:00000002 r7:60000013 r6:df83dd8c r5:82e36000
 r4:82e36000
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:82e36000 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:df83de08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84692a40
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18005 r8:82e36000 r7:00000000 r6:82c18000 r5:00001000 r4:7f02b000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfa4b000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:8416af8c r4:8416ac00
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:dddced40 r6:82c18000 r5:8416af8c r4:82cb7400
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:82e36000 r8:82cb742c r7:82604d40 r6:dddced40 r5:dddced60
 r4:82cb7400
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:82cb7400 r8:8027e8dc r7:df819e48 r6:82cb7480 r5:82e36000
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf83dfb0 to 0xdf83dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:82cb6180
INFO: task kworker/0:0:9 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: e929f000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
INFO: task kworker/1:1:43 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:0     pid:43    tgid:43    ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:df911d84 r8:00000002 r7:60000013 r6:df911d8c r5:82f48c00
 r4:82f48c00
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:82f48c00 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:df911e08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eaff80
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:82f48c00 r7:00000000 r6:82c18200 r5:00001000 r4:7f029000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfa01000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84f20b8c r4:84f20800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84f20b8c r4:82fbb000
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:82f48c00 r8:82fbb02c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:82fbb000
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:82fbb000 r8:8027e8dc r7:df879e60 r6:82fbb080 r5:82f48c00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf911fb0 to 0xdf911ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:82fa9f00
INFO: task kworker/1:1:43 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: ea606000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
INFO: task kworker/1:2:44 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:0     pid:44    tgid:44    ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:df915d84 r8:00000002 r7:60000113 r6:df915d8c r5:82f49800
 r4:82f49800
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:82f49800 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:df915e08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84ebc440
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:82f49800 r7:00000000 r6:82c18200 r5:00001000 r4:7f00b000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dff73000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84e9b78c r4:84e9b400
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84e9b78c r4:82fbb200
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:82f49800 r8:82fbb22c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:82fbb200
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:82fbb200 r8:8027e8dc r7:df911e60 r6:82fbb400 r5:82f49800
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf915fb0 to 0xdf915ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:82fbc100
INFO: task kworker/1:2:44 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: ea78b000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
INFO: task kworker/0:5:3828 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:0     pid:3828  tgid:3828  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:dfdd5d84 r8:00000002 r7:60000013 r6:dfdd5d8c r5:84dea400
 r4:84dea400
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:84dea400 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfdd5e08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84d99140
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18005 r8:84dea400 r7:00000000 r6:82c18000 r5:00001000 r4:7f029000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfa32000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84ce7f8c r4:84ce7c00
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:dddced40 r6:82c18000 r5:84ce7f8c r4:84689700
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84dea400 r8:8468972c r7:82604d40 r6:dddced40 r5:dddced60
 r4:84689700
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84689700 r8:8027e8dc r7:eb8e9e60 r6:84689c00 r5:84dea400
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfdd5fb0 to 0xdfdd5ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84d849c0
INFO: task kworker/0:5:3828 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: eb094000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
INFO: task kworker/0:35:4078 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:35    state:D stack:0     pid:4078  tgid:4078  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:dfc2dd84 r8:00000002 r7:60000013 r6:dfc2dd8c r5:84e5ec00
 r4:84e5ec00
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:84e5ec00 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfc2de08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84ebe2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18005 r8:84e5ec00 r7:00000000 r6:82c18000 r5:00001000 r4:7f04b000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfbc3000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84e9a38c r4:84e9a000
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:dddced40 r6:82c18000 r5:84e9a38c r4:84eb8480
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e5ec00 r8:84eb84ac r7:82604d40 r6:dddced40 r5:dddced60
 r4:84eb8480
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84eb8480 r8:8027e8dc r7:dfaa5e60 r6:84d41880 r5:84e5ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfc2dfb0 to 0xdfc2dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84eb9ec0
INFO: task kworker/0:35:4078 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: eb094000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
INFO: task kworker/1:67:4097 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:67    state:D stack:0     pid:4097  tgid:4097  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:dfd79d84 r8:00000002 r7:60000013 r6:dfd79d8c r5:834a8000
 r4:834a8000
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:834a8000 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfd79e08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eae040
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:834a8000 r7:00000000 r6:82c18200 r5:00001000 r4:7f063000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfe4f000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:8418678c r4:84186400
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:8418678c r4:84d41f80
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:834a8000 r8:84d41fac r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f80
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f80 r8:8027e8dc r7:dfd55e60 r6:84eb8980 r5:834a8000
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd79fb0 to 0xdfd79ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebcc40
INFO: task kworker/1:67:4097 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: eb48c000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
INFO: task kworker/1:69:4104 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:69    state:D stack:0     pid:4104  tgid:4104  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:dfe59d84 r8:00000002 r7:60000013 r6:dfe59d8c r5:84e12400
 r4:84e12400
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:84e12400 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfe59e08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84ebc380
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e12400 r7:00000000 r6:82c18200 r5:00001000 r4:7f061000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfe3d000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:8418638c r4:84186000
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:8418638c r4:84d41480
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e12400 r8:84d414ac r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41480
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41480 r8:8027e8dc r7:dfd79e60 r6:84eb8880 r5:84e12400
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfe59fb0 to 0xdfe59ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc440
INFO: task kworker/1:69:4104 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: eb48c000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
INFO: task kworker/1:70:4105 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:70    state:D stack:0     pid:4105  tgid:4105  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:dfe69d84 r8:00000002 r7:60000113 r6:dfe69d8c r5:84e13000
 r4:84e13000
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:84e13000 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfe69e08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eae500
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e13000 r7:00000000 r6:82c18200 r5:00001000 r4:7f065000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfe95000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84186b8c r4:84186800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84186b8c r4:84d40000
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e13000 r8:84d4002c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d40000
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d40000 r8:8027e8dc r7:dfd79e60 r6:84eb8a00 r5:84e13000
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfe69fb0 to 0xdfe69ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84eae0c0
INFO: task kworker/1:70:4105 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: eb72c000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
INFO: task kworker/1:71:4107 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:71    state:D stack:0     pid:4107  tgid:4107  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:dfd7dd84 r8:00000002 r7:60000013 r6:dfd7dd8c r5:84e11800
 r4:84e11800
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:84e11800 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfd7de08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eaeb00
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e11800 r7:00000000 r6:82c18200 r5:00001000 r4:7f06b000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfeed000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:8418778c r4:84187400
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:8418778c r4:84d40080
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e11800 r8:84d400ac r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d40080
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d40080 r8:8027e8dc r7:dfe69e60 r6:84eb8b00 r5:84e11800
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd7dfb0 to 0xdfd7dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84eae3c0
INFO: task kworker/1:71:4107 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: eba55000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
INFO: task kworker/1:72:4109 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:72    state:D stack:0     pid:4109  tgid:4109  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:dfebdd84 r8:00000002 r7:60000113 r6:dfebdd8c r5:84e14800
 r4:84e14800
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:84e14800 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:dfebde08
 r4:00000000
[<819c2328>] (__mutex_lock_slowpath) from [<819c237c>] (mutex_lock+0x3c/0x40 kernel/locking/mutex.c:278)
[<819c2340>] (mutex_lock) from [<804e431c>] (_vm_unmap_aliases+0x68/0x240 mm/vmalloc.c:2912)
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:84eae780
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e14800 r7:00000000 r6:82c18200 r5:00001000 r4:7f067000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfea7000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84186f8c r4:84186c00
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84186f8c r4:84d40180
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e14800 r8:84d401ac r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d40180
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d40180 r8:8027e8dc r7:dfd7de60 r6:84eb8a80 r5:84e14800
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfebdfb0 to 0xdfebdff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84eae840
INFO: task kworker/1:72:4109 is blocked on a mutex likely owned by task kworker/1:66:4095.
task:kworker/1:66    state:R  running task     stack:0     pid:4095  tgid:4095  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf7d8>] (preempt_schedule_irq+0x40/0xa8 kernel/sched/core.c:7109)
 r10:8260c9b4 r9:84e1ec00 r8:80200be4 r7:dfd61d54 r6:ffffffff r5:84e1ec00
 r4:00000000
[<819bf798>] (preempt_schedule_irq) from [<80200c04>] (svc_preempt+0x8/0x18)
Exception stack(0xdfd61d20 to 0xdfd61d68)
1d20: ebea6000 ecfd7000 00000001 80239a78 7f029000 00000001 828b51c4 828b45a0
1d40: 7f029000 ecfd7000 8260c9b4 dfd61d9c dfd61da0 dfd61d70 802309b0 80239a90
1d60: 80000013 ffffffff
 r5:80000013 r4:80239a90
[<8023094c>] (flush_tlb_kernel_range) from [<804e40e0>] (__purge_vmap_area_lazy+0x284/0x458 mm/vmalloc.c:2336)
 r4:828b51e4
[<804e3e5c>] (__purge_vmap_area_lazy) from [<804e4498>] (_vm_unmap_aliases+0x1e4/0x240 mm/vmalloc.c:2951)
 r10:00000000 r9:00000000 r8:00000000 r7:ffffffff r6:dfd61dc0 r5:dfd61e08
 r4:dfd61dc0
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vm_reset_perms mm/vmalloc.c:3343 [inline])
[<804e42b4>] (_vm_unmap_aliases) from [<804e820c>] (vfree+0x16c/0x210 mm/vmalloc.c:3422)
 r10:82c16070 r9:00000001 r8:00000000 r7:ffffffff r6:00000000 r5:8443a2c0
 r4:00000000
[<804e80a0>] (vfree) from [<8054627c>] (execmem_free+0x30/0x50 mm/execmem.c:399)
 r9:82c18205 r8:84e1ec00 r7:00000000 r6:82c18200 r5:00001000 r4:7f045000
[<8054624c>] (execmem_free) from [<803c6018>] (bpf_jit_free_exec+0x10/0x14 kernel/bpf/core.c:1077)
 r5:00001000 r4:dfdcb000
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_binary_free kernel/bpf/core.c:1123 [inline])
[<803c6008>] (bpf_jit_free_exec) from [<803c63f8>] (bpf_jit_free+0x68/0xe4 kernel/bpf/core.c:1246)
[<803c6390>] (bpf_jit_free) from [<803c7484>] (bpf_prog_free_deferred+0x14c/0x164 kernel/bpf/core.c:2891)
 r5:84185b8c r4:84185800
[<803c7338>] (bpf_prog_free_deferred) from [<8027de90>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r7:ddde2d40 r6:82c18200 r5:84185b8c r4:84d41f00
[<8027dcdc>] (process_one_work) from [<8027ead8>] (process_scheduled_works kernel/workqueue.c:3321 [inline])
[<8027dcdc>] (process_one_work) from [<8027ead8>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3402)
 r10:61c88647 r9:84e1ec00 r8:84d41f2c r7:82604d40 r6:ddde2d40 r5:ddde2d60
 r4:84d41f00
[<8027e8dc>] (worker_thread) from [<80285b04>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:84d41f00 r8:8027e8dc r7:dfd55e60 r6:84eb8780 r5:84e1ec00
 r4:00000001
[<802859d8>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdfd61fb0 to 0xdfd61ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:802859d8
 r4:84ebc6c0
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task kworker/1:73:4110 blocked for more than 430 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:73    state:D stack:0     pid:4110  tgid:4110  ppid:2      task_flags:0x4208060 flags:0x00000000
Workqueue: events bpf_prog_free_deferred
Call trace: 
[<819be41c>] (__schedule) from [<819bf3a4>] (__schedule_loop kernel/sched/core.c:6864 [inline])
[<819be41c>] (__schedule) from [<819bf3a4>] (schedule+0x2c/0x130 kernel/sched/core.c:6879)
 r10:82718544 r9:dfec1d84 r8:00000002 r7:60000013 r6:dfec1d8c r5:84e15400
 r4:84e15400
[<819bf378>] (schedule) from [<819bf78c>] (schedule_preempt_disabled+0x18/0x24 kernel/sched/core.c:6936)
 r5:84e15400 r4:82718540
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock_common kernel/locking/mutex.c:679 [inline])
[<819bf774>] (schedule_preempt_disabled) from [<819c1e70>] (__mutex_lock.constprop.0+0x300/0x6f8 kernel/locking/mutex.c:747)
[<819c1b70>] (__mutex_lock.constprop.0) from [<819c233c>] (__mutex_lock_slowpath+0x14/0x18 kernel/locking/mutex.c:1035)
 r10:8260c960 r9:00000001 r8

Tested on:

commit:         347e9f50 Linux 6.16-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ba7d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=796037e82809246d
dashboard link: https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153547d4580000


