Return-Path: <linux-kernel+bounces-860137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D687DBEF639
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1537C18901CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF62D238D;
	Mon, 20 Oct 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqGVXPqP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1512C0268
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940214; cv=none; b=dk1Gr97EAqA9sDEfhARBRw3worZRPKSoENSQdeC2s7C8YDUN8XhfRF1d8rcNF+KjwZ3PXe4FyHAECM55FoTZp2COm/NZj2+FwYaK21PXG9h2sXUIykVBWIt2LtlxbG9IEasDHrVGAtkgtvZy5if+AAjs6RZM7McjkIA0EFF6w7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940214; c=relaxed/simple;
	bh=eXa7wMXaYWnoBd8pKsYAWyM9TteYUKPN0CVgzTs8k+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laIeduaLCAJdvjjYLiF7lG8wu8/RFchUgoPVW1ppcZ6mCS59u+Wn4cN2ONBkE9O630bNx/0JLixVU+cOxAsrONKxnOXRvmSRJSvH86GJwHZnWyOyd3lDa2t00Tzjktt3hq8B/e6TQUv3A1UdzZt6GGDT53uOi7kW3iFsfFcBt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqGVXPqP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760940211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TpkEE1jORk5GPdwr/xbUGUOKOHZrQxuLP3cJKa/bGv0=;
	b=AqGVXPqPA10Jmwu1ze5ChNdQEG+B5Q/dHzI7krAGPIZo5f4YBxwMZb5jVPve+1vuvLGsEW
	vAdSoqjx3qvqbwTWCpyp0CenXWC/s65Vqk2l97wSag/TIl2ORjrPzUVk89/wt23tZ2aK2e
	s5BOekKtK2ONMJ5wh7hI9J6tSQ2+Oa0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-2jeTBPE5Mf6JFXycWZpkhg-1; Mon, 20 Oct 2025 02:03:30 -0400
X-MC-Unique: 2jeTBPE5Mf6JFXycWZpkhg-1
X-Mimecast-MFC-AGG-ID: 2jeTBPE5Mf6JFXycWZpkhg_1760940209
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so88811585e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760940209; x=1761545009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpkEE1jORk5GPdwr/xbUGUOKOHZrQxuLP3cJKa/bGv0=;
        b=IrkNbubbSD4q1jTpdqILb4fnrr1JmnxpRxIz/RVR7BSutQxT8hB0gtcI9iBZAjmQPw
         HNRCi7GVtutpPFoEEHxuxqNBRc71NckRkFNfy1UV/FJwnfFizMcqT/hrRlfu0zRh95xt
         dWvHXpjsElYFsZr0dE/lul6Iags4pfWaFL/HIyaIHZOSN27tbn1bYPGOQeI+0/6cCHFD
         lWhmrx6aXk0AJggTgGSPizukxmGIFzdVHt8y2xjsG08bMMa/ZvTazJ7iB5lKPhslpOmB
         AG/dx5Ih7gZ5NTgY/hrdHBMfqv7lAU9xQSN+LRs06zmU1zR4cK9vfL23GbIpaBFrX7JD
         5p3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfbp8RJvQKTZ3RkqhiVNlh88I82Qhl8Nw2qZEkRlpYSG4UvfiTCCXxv4Wlh94GCXdEVmE5WLWooPjtgAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+XYQkqMNxZ7Aouavf4cmNs4MoN5r0VZzzRMTYazmo9FcHh76
	LyKLV3vgdpCtOMoU2u3aaMEFbkvyXTaYW2Edrxl5jdbd9nCGRGkkMw+xD/Dy5CBD9nYACiAt+z7
	zCaNDqtZ/w61jcfijBMr0i6OfyYyBI6n7fpE6maI0xYjSmfqDhiH07HCDF9qrQyCsYw==
X-Gm-Gg: ASbGncvhVd6C33M+YeB2bHavA1RBk5RouLhN7881c6zKivDWQQdyx+ANgaKqlnLFfIm
	Kd3kvS8HFgZYsblumwvBrpbrn1jNOsFOk9EDbjJYSrlSFv81LkSA1rDpNpz7ex3hlfxKZRXGcsZ
	TZAngCgylbVhm+WTVUxepLNHRbNGYL8cM2w5zoaJ4CG3nok9vzn4f8eCN6NjCu/c82jvSfi1ULh
	IW325FoIt+oOWORaWkllsWgg3SRINFpLTWA3uAamnDSMsLCX4L3o7mIAY48/Mau6hXzFSMjlcbG
	+UIfU796UcipSQ/eEjszpC3YOf2tY6cG2xv6epJOfJFbgAq4aGceb4ferlo2OzYpq3Q/A0UXe5+
	3+8zJRd6We1ZKAAqoznoVMzHDXvfOSIs=
X-Received: by 2002:a05:600c:3550:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-471179141cfmr93725835e9.33.1760940208763;
        Sun, 19 Oct 2025 23:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnKJdfRAxnpHyZNK+RuCBA7yf/H4lW+bMTc6YJIB1Ac3H0geIz41XTcjl73ZA0GF3lbdlwdQ==
X-Received: by 2002:a05:600c:3550:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-471179141cfmr93725505e9.33.1760940208344;
        Sun, 19 Oct 2025 23:03:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711c487dfesm193476745e9.17.2025.10.19.23.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:03:27 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:03:25 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv3] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aPXQra4TWR0NVwDQ@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017122636.17671-1-piliu@redhat.com>
 <1b510c7e-6d48-4f3c-b3cb-8a7a0834784c@redhat.com>
 <aPWqsui-7HCUB5g-@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPWqsui-7HCUB5g-@fedora>

Hi!

On 20/10/25 11:21, Pingfan Liu wrote:
> Hi Waiman,
> 
> I appreciate your time in reviewing my patch. Please see the comment
> belows.
> 
> On Fri, Oct 17, 2025 at 01:52:45PM -0400, Waiman Long wrote:
> > On 10/17/25 8:26 AM, Pingfan Liu wrote:
> > > When testing kexec-reboot on a 144 cpus machine with
> > > isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> > > encounter the following bug:
> > > 
> > > [   97.114759] psci: CPU142 killed (polled 0 ms)
> > > [   97.333236] Failed to offline CPU143 - error=-16
> > > [   97.333246] ------------[ cut here ]------------
> > > [   97.342682] kernel BUG at kernel/cpu.c:1569!
> > > [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> > > [   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_port cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresight_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor usbnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel coresight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetlink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme nvme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod
> > > [   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not tainted 6.12.0-41.el10.aarch64 #1
> > > [   97.413371] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 2.0 07/12/2024
> > > [   97.420400] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > > [   97.427518] pc : smp_shutdown_nonboot_cpus+0x104/0x128
> > > [   97.432778] lr : smp_shutdown_nonboot_cpus+0x11c/0x128
> > > [   97.438028] sp : ffff800097c6b9a0
> > > [   97.441411] x29: ffff800097c6b9a0 x28: ffff0000a099d800 x27: 0000000000000000
> > > [   97.448708] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb94aaaa8f218
> > > [   97.456004] x23: ffffb94aaaabaae0 x22: ffffb94aaaa8f018 x21: 0000000000000000
> > > [   97.463301] x20: ffffb94aaaa8fc10 x19: 000000000000008f x18: 00000000fffffffe
> > > [   97.470598] x17: 0000000000000000 x16: ffffb94aa958fcd0 x15: ffff103acfca0b64
> > > [   97.477894] x14: ffff800097c6b520 x13: 36312d3d726f7272 x12: ffff103acfc6ffa8
> > > [   97.485191] x11: ffff103acf6f0000 x10: ffff103bc085c400 x9 : ffffb94aa88a0eb0
> > > [   97.492488] x8 : 0000000000000001 x7 : 000000000017ffe8 x6 : c0000000fffeffff
> > > [   97.499784] x5 : ffff003bdf62b408 x4 : 0000000000000000 x3 : 0000000000000000
> > > [   97.507081] x2 : 0000000000000000 x1 : ffff0000a099d800 x0 : 0000000000000002
> > > [   97.514379] Call trace:
> > > [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> > > [   97.521769]  machine_shutdown+0x20/0x38
> > > [   97.525693]  kernel_kexec+0xc4/0xf0
> > > [   97.529260]  __do_sys_reboot+0x24c/0x278
> > > [   97.533272]  __arm64_sys_reboot+0x2c/0x40
> > > [   97.537370]  invoke_syscall.constprop.0+0x74/0xd0
> > > [   97.542179]  do_el0_svc+0xb0/0xe8
> > > [   97.545562]  el0_svc+0x44/0x1d0
> > > [   97.548772]  el0t_64_sync_handler+0x120/0x130
> > > [   97.553222]  el0t_64_sync+0x1a4/0x1a8
> > > [   97.556963] Code: a94363f7 a8c47bfd d50323bf d65f03c0 (d4210000)
> > > [   97.563191] ---[ end trace 0000000000000000 ]---
> > > [   97.595854] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > > [   97.602275] Kernel Offset: 0x394a28600000 from 0xffff800080000000
> > > [   97.608502] PHYS_OFFSET: 0x80000000
> > > [   97.612062] CPU features: 0x10,0000000d,002a6928,5667fea7
> > > [   97.617580] Memory Limit: none
> > > [   97.648626] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
> > > 
> > > Tracking down this issue, I found that dl_bw_deactivate() returned
> > > -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> > > When a CPU is inactive, its rd is set to def_root_domain. For an
> > > blocked-state deadline task (in this case, "cppc_fie"), it was not
> > > migrated to CPU0, and its task_rq() information is stale. As a result,
> > > its bandwidth is wrongly accounted into def_root_domain during domain
> > > rebuild.
> > 
> > First of all, in an emergency situation when we need to shutdown the kernel,
> > does it really matter if dl_bw_activate() returns -EBUSY? Should we just go
> > ahead and ignore this dl_bw generated error?
> > 
> 
> Ah, sorry - the previous test example was misleading. Let me restate it
> as an equivalent operation on a system with 144 CPUs:
>   sudo bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devices/system/cpu/cpu$i/online 2>/dev/null; done'
> 
> That extracts the hot-removal part, which is affected by the bug, from
> the kexec reboot process. It expects that only cpu0 is online, but in
> practice, the cpu143 refused to be offline due to this bug.

I confess I am still perplexed by this, considering the "particular"
nature of cppc worker that seems to be the only task that is able to
trigger this problem. First of all, is that indeed the case or are you
able to reproduce this problem with standard (non-kthread) DEADLINE
tasks as well?

I essentially wonder how cppc worker affinity/migration on hotplug is
handled. With your isolcpus configuration you have one isolated root
domain per isolated cpu, so if cppc worker is not migrated away from (in
the case above) cpu 143, then BW control might be right in saying we
can't offline that cpu, as the worker still has BW running there. This
is also why I fist wondered (and suggested) we remove cppc worker BW
from the picture (make it DEADLINE special) as we don't really seem to
have a reliable way to associate meaningful BW to it anyway.

Thanks,
Juri


