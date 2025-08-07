Return-Path: <linux-kernel+bounces-759111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A312B1D89B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976487B036B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EBF25A32E;
	Thu,  7 Aug 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/qL9ETq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A20258CD0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572124; cv=none; b=clqtZ30+0IefrBrJDdfjZSKNzmE/h7PsJ8LMLABoV3seiuMBbmp3D/zXhWBkPQPhThnf18OKh7db4etRsVWMGHH0wEiNh2iiYYukYCUy0JKgMYRV6EO7JTnZLXQTu5qCmES7Q2eyINlMuRb4XC88iN3Of4XnbE7eTlZ5ghl+Yhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572124; c=relaxed/simple;
	bh=URcEUoEdbL5TkgsWujjaYCJlh1NPKxZwcixR2gJRS0E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nf5oAbfRiSVvw/w4CYtmN8qEA41wdroOEeUjUjsuU03q5shXXe5jeTnH7VLQnlk7MVHLyv9LedXsitVl+ToOHQ4AjTwjbMK9ZtTvcmZ3ZlDWrS9okqShGYIEPF+8aIymdBa3ZOH1yyp4lTUlyQBlMwFwo8FkDOt6U38vrYNiitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/qL9ETq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754572121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQYgV0X5e6OdkcED4BPO2+bBh1IW+KXBCsjfdvvJSgg=;
	b=T/qL9ETqMSjoLr+PrWkKebElNMuvId1qhiB1UGDWpagKMZCRC5s4TPbfgAMP6CCPqamAcL
	h8YD4Egqx8Rp1em5f06tu21sM0hH6U53xbRrS3qzxl7/4En1tFd8wEMrIY90BfzuvDy8b8
	1RfzhJq6rvZ+YDJM1Fn/DhFpypyp/yc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-b1Q-CkfgOYuM5ogEHku-Ng-1; Thu, 07 Aug 2025 09:08:40 -0400
X-MC-Unique: b1Q-CkfgOYuM5ogEHku-Ng-1
X-Mimecast-MFC-AGG-ID: b1Q-CkfgOYuM5ogEHku-Ng_1754572120
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e809830338so323498885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754572120; x=1755176920;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQYgV0X5e6OdkcED4BPO2+bBh1IW+KXBCsjfdvvJSgg=;
        b=LUBMoHd/XVzXCcYzvTYlE87VpIHaBUPczgE6D5gMNf3b8Sio5/Du7F18ubeF3njQsK
         Fz/1UE4sWOTCZutEGgrsx+NMeHlBVgR3iJafsO/rcC67QHjkkIOw/+PsxmhO53fp+i7F
         uQ8FN9eQjmh6PY2Zm7nJCzoMLI8gLcjQQognbjLi8BbXVXuSYA6Ew2L3cfPSE33HtEFc
         jBXdxUesfAnj8SNas082faa535waiGkVppmdSm42etxlSWEvZJ65jTWGlTnHJGhKNtyj
         X/QZVjeiNeMuXkPZT9vWt8faYzz0EkEwruYoQa/C84WlqMvvd/7FKW/zGqJHpEhNeMy0
         wFcw==
X-Forwarded-Encrypted: i=1; AJvYcCUUSEcwf7sxp4xm+V5PExUadfPN6F+/soa6qa90BLTE6yYuqQZmmKhVD26X0JmbvpgHQYi8Y5FMmYcbVlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkV4VMFjnBWyFK7nrA8yNWFBr1YnEKDvJA4aBE4DKDpBNyeWTf
	HWXmkWxXLKFllby+erz0mydKn4WMcUFKvoyFYq8oXyRidjZ5rPY+3HLwDahjww7pQRVdyrmvcZP
	IeJU99fJThUS9PnbaRxkKj/ghGUQdRVvTs9uhi+ocVv2aQ9So+W+y8ZOH1SEEwn/L1w==
X-Gm-Gg: ASbGncsewLhMt3iulVLrwBNXJdmIIKB7H0nlPcpoM3snZgrCPu+zlEDm47ceismU94B
	TG5nQrkO6w32oqtAg03OrS+EgIMS3qXvrGxmNpvj/UFXHfj2Zv7SiSGU0xlSLI7KmQVFBhIDR57
	/TtXo54UQkeztbZJMZswEx6SbBnTK62zuPFiPkemMyNYo8FYF//ylflHyGpArebHrDrclgNwydD
	riNLtwwnqFoQSwRhzEQZaF8OlsH82/i14P77q0zsraeNaaSLQYtPR1edxAfyw4uZLOCC3BRP/bc
	HnDG/D7vkFmkaLihJ8WpePcC3z5LGsNg8eqPqL9HaqxxxlsyX8IMfN9sSxlt6lb8bJwox1Rqre8
	KXFatpXQO2w==
X-Received: by 2002:a05:620a:4043:b0:7e6:211b:217a with SMTP id af79cd13be357-7e814e9a51fmr827517085a.43.1754572119717;
        Thu, 07 Aug 2025 06:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQYAus5qYLEVmfUEL8E4TfiRxMW8Y9h4TXOXPM9H13FxW8syk8V1fqHYb0D+NKKCK5hi3jZg==
X-Received: by 2002:a05:620a:4043:b0:7e6:211b:217a with SMTP id af79cd13be357-7e814e9a51fmr827510685a.43.1754572119107;
        Thu, 07 Aug 2025 06:08:39 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce37c01sm98732806d6.79.2025.08.07.06.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:08:38 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c2888d14-e01d-4d28-866e-edeac0532d2a@redhat.com>
Date: Thu, 7 Aug 2025 09:08:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at
 remote_partition_disable
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Cgroups <cgroups@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 kamalesh.babulal@oracle.com
References: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 4:27 AM, Naresh Kamboju wrote:
> Regressions noticed intermittently on AmpereOne while running selftest
> cgroup testing
> with Linux next-20250805 and earlier seen on next-20250722 tag also.
>
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Intermittent
>
> First seen on the next-20250722 and after next-20250805.
>
> Test regression: next-20250805 ampere WARNING kernel cgroup cpuset.c
> at remote_partition_disable
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Test log
> selftests: cgroup: test_cpuset_prs.sh
> Running state tRunning state transition test ...
> ransition test ...
> Running test 0 ...
> Running test 1 ...
> Running test 2 ...
> Running test 3 ...
> Running test 4 ...
> Running test 5 ...
> Running test 6 ...
> Running test 7 ...
> Running test 8 ...
> Running test 9 ...
> Running test 10 ...
> Running test 11 ...
> Running test 12 ...
> Running test 13 ...
> Running test 14 ...
> Running test 15 ...
> Running test 16 ...
> Running test 17 ...
> Running test 18 ...
> Running test 19 ...
> [  137.504549] psci: CPU2 killed (polled 0 ms)
> [  137.747094] Detected PIPT I-cache on CPU2
> [  137.747214] GICv3: CPU2: found redistributor 3500 region 0:0x0000400201cc0000
> [  137.747312] CPU2: Booted secondary processor 0x0000003500 [0xc00fac40]
>
> <>
>
> Running test 63 ...
> Running test 64 ...
> Running test 66 ...
> [  174.929535] psci: CPU3 killed (polled 0 ms)
> [  175.263087] Detected PIPT I-cache on CPU3
> [  175.263203] GICv3: CPU3: found redistributor 3501 region 0:0x0000400201d00000
> [  175.263300] CPU3: Booted secondary processor 0x0000003501 [0xc00fac40]
> [  175.434129] workqueue: Interrupted when creating a worker thread
> "kworker/u1028:0"
> ** replaying previous printk message **
> [  175.434129] workqueue: Interrupted when creating a worker thread
> "kworker/u1028:0"
> [  175.440230] ------------[ cut here ]------------
> [  175.440234] WARNING: kernel/cgroup/cpuset.c:1352 at
> remote_partition_disable+0x120/0x160, CPU#170: rmdir/33763
> [  175.467456] Modules linked in: cdc_ether usbnet sm3_ce sha3_ce nvme
> nvme_core xhci_pci_renesas arm_cspmu_module ipmi_devintf arm_spe_pmu
> ipmi_msghandler arm_cmn cppc_cpufreq fuse drm backlight
> [  175.484676] CPU: 170 UID: 0 PID: 33763 Comm: rmdir Not tainted
> 6.16.0-next-20250805 #1 PREEMPT
> [  175.493365] Hardware name: Inspur NF5280R7/Mitchell MB, BIOS
> 04.04.00004001 2025-02-04 22:23:30 02/04/2025
> [  175.503178] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> not ok 12 selftests: cgroup: test_cpuset_prs.sh TIMEOUT 45 seconds
> [  175.510130] pc : remote_partition_disable
> (kernel/cgroup/cpuset.c:1352 (discriminator 1)
> kernel/cgroup/cpuset.c:1342 (discriminator 1)
> kernel/cgroup/cpuset.c:1514 (discriminator 1))

The warning is caused by workqueue_unbound_exclude_cpumask() returning 
an error which should not normally happen. There is a "workqueue: 
Interrupted when creating a worker thread" which may cause problem in 
the workqueue code leading to this error. That particular error happens 
when kthread_create_on_node() fails to create the requested worker kthread.

The test itself uses the hotplug code rather heavily to offline/online 
CPUs to test the cpuset code related to hotplug. I don't know if that is 
part of the problem or not. Anyway, there isn't any big change in the 
cpuset code recently. I think the real bug may lie in other kernel areas 
used by the cpuset code.

Cheers,
Longman


> [  175.518032] lr : remote_partition_disable
> (kernel/cgroup/cpuset.c:1352 (discriminator 1)
> kernel/cgroup/cpuset.c:1514 (discriminator 1))
> [  175.525849] sp : ffff8000c853bb90
> [  175.529585] x29: ffff8000c853bb90 x28: ffff00017badc800 x27: 0000000000000000
> timeout set to 45
> [  175.536713] x26: 0000000000000000 x25: ffff00014c422540 x24: ffffb1c71020b000
> [  175.545489] x23: ffff000113769c00 x22: 0000000000000001 x21: ffffb1c71020b5c0
> [  175.552615] x20: ffff8000c853bbd0 x19: ffff000113769a00 x18: 00000000ffffffff
> selftests: cgroup: test_cpuset_v1_hp.sh
> [  175.559910] x17: 31752f72656b726f x16: 776b222064616572 x15: 68742072656b726f
> [  175.569900] x14: 0000000000000004 x13: ffffb1c70fb4f160 x12: 0000000000000000
> cpuset v1 mount point not found!
> [  175.577888] x11: 000002f6b9bf58c3 x10: 0000000000000023 x9 : ffffb1c70d6bdff8
> Test SKIPPED
> ok 13 selftests: cgroup: test_cpuset_v1_hp.sh #SKIP
> [  175.587877] x8 : ffff8000c853bad0 x7 : 0000000000000000 x6 : 0000000000000001
> [  175.597864] x5 : ffffb1c70e87a488 x4 : fffffdffc40a88e0 x3 : 000000000080007d
> [  175.607849] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffff4
> [  175.615578] Call trace:
> [  175.618013] remote_partition_disable (kernel/cgroup/cpuset.c:1352
> (discriminator 1) kernel/cgroup/cpuset.c:1342 (discriminator 1)
> kernel/cgroup/cpuset.c:1514 (discriminator 1)) (P)
> [  175.623057] update_prstate (include/linux/spinlock.h:376
> kernel/cgroup/cpuset.c:2963)
> [  175.626799] cpuset_css_killed (kernel/cgroup/cpuset.c:3598)
> [  175.630713] kill_css.part.0 (kernel/cgroup/cgroup.c:5968)
> [  175.634464] cgroup_destroy_locked (kernel/cgroup/cgroup.c:6058
> (discriminator 4))
> [  175.638810] cgroup_rmdir (kernel/cgroup/cgroup.c:6102)
> [  175.642376] kernfs_iop_rmdir (fs/kernfs/dir.c:1286)
> [  175.646203] vfs_rmdir (fs/namei.c:4461 fs/namei.c:4438)
> [  175.649515] do_rmdir (fs/namei.c:4516 (discriminator 1))
> [  175.652823] __arm64_sys_unlinkat (fs/namei.c:4690 (discriminator 2)
> fs/namei.c:4684 (discriminator 2) fs/namei.c:4684 (discriminator 2))
> [  175.656998] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:54)
> [  175.660738] el0_svc_common.constprop.0
> (include/linux/thread_info.h:135 (discriminator 2)
> arch/arm64/kernel/syscall.c:140 (discriminator 2))
> [  175.665431] do_el0_svc (arch/arm64/kernel/syscall.c:152)
> [  175.668735] el0_svc (arch/arm64/include/asm/irqflags.h:82
> (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
> 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
> arch/arm64/kernel/entry-common.c:169 (discriminator 1)
> arch/arm64/kernel/entry-common.c:182 (discriminator 1)
> arch/arm64/kernel/entry-common.c:880 (discriminator 1))
> [  175.671877] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:899)
> [  175.676052] el0t_64_sync (arch/arm64/kernel/entry.S:596)
> [  175.679705] ---[ end trace 0000000000000000 ]---
>
>
> ## Source
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: afec768a6a8fe7fb02a08ffce5f2f556f51d4b52
> * Git describe: next-20250805
> * Architectures: arm64
> * Toolchains: gcc-13
> * Kconfigs: defconfig+selftests/*/configs
>
> ## Build
> * Test log 1: https://qa-reports.linaro.org/api/testruns/29220998/log_file/
> * Test log 2: https://qa-reports.linaro.org/api/testruns/29395866/log_file/
> * LAVA log: https://lkft-staging.validation.linaro.org/scheduler/job/187100#L6621
> * Test history:
> https://regressions.linaro.org/lkft/linux-next-master-ampere/next-20250805/log-parser-test/exception-warning-kernelcgroupcpuset-at-remote_partition_disable/history/
> * Test plan: https://tuxapi.tuxsuite.com/v1/groups/ampere/projects/ci/tests/30rj0dIdTXUiGfYMA7suavpa77r
> * Build link: https://storage.tuxsuite.com/public/ampere/ci/builds/30rj0OYSDUMeT0cyTDioTe5XVOI/
> * Kernel config:
> https://storage.tuxsuite.com/public/ampere/ci/builds/30rj0OYSDUMeT0cyTDioTe5XVOI/config
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>


