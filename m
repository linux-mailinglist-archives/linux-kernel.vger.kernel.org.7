Return-Path: <linux-kernel+bounces-858548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BCBEB1F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 620284E2F87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8132C93B;
	Fri, 17 Oct 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpiDswJ1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEB72C21D4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723573; cv=none; b=tDGqoTFMtlZrNPNkjt+9BmHa8n8ONwTG7QQsJri9aefdKRYMdfkK4ic9X9dSr4BQcQAbfzm6MxqyZCoD1g4A4OfABVneJVRFz3QC1bsPrzP+1Hwi2WYK09fjQSr7wP9nnz43xk0RMp9IqbBpl2sr+yctVB8NbgusjyZRNOarwvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723573; c=relaxed/simple;
	bh=g88HbHHTSRSg4gKlhrfAykhenuBvTbK02JjqS/jVAfk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pvh2YNeFndhZ0MdpsLRlSDugbZE8PtHNAjPjjhQAB61dLBp9lZZh+EPhlHcAZEORNGT0TI7MLd7SDPKhQ5E0AQXfcD4qwAaewWejKd5QLKMyHs55rm+Xdj3SVlMrF+thzMwInmzckUXJiqayRdYivzIqiD1ydO9VHjypHYNaJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpiDswJ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760723570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uFNgRkQxgrcaDrhBce90BY6iLcFw7TEYkoT72st+3g=;
	b=gpiDswJ1gVOrTVjpiq/NcD4aVwMUB9eYZjuQeL7iyX14W+dhUqgYlyx06iVbXBCB3PlGnU
	I4rauNsxxSKz1V/w+cru/1Tb/wO6ex0jY2H7DooFVGjdJFACjOO47/G3nAG+Bgaklc5nMa
	lE8LvLD78mxZfsFxNA9RdKy2e2urCLI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-J02HhmqkMQeywCSnkVZ1WA-1; Fri, 17 Oct 2025 13:52:48 -0400
X-MC-Unique: J02HhmqkMQeywCSnkVZ1WA-1
X-Mimecast-MFC-AGG-ID: J02HhmqkMQeywCSnkVZ1WA_1760723568
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29085106b99so23084025ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760723568; x=1761328368;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uFNgRkQxgrcaDrhBce90BY6iLcFw7TEYkoT72st+3g=;
        b=VjL01z0am1Zm3AAuKfOQULlGdXsFphbsiyExu62TwRRt2EDhY0TJjCNC5m5PxBwfcZ
         RIFPUD60aUeoKr0SxbewxcMobrygTnCcaRZWIgb2bcRiIvj0BI2Au/5avS3/O5SN/3UC
         6ur6ucSmDPMuEOE0E5aifgLHg1IL7TmG1fIAqHYyXOd/LuBWF6UfnchwLbWNxeZT/Nmy
         kqybCKkMzmxYKkeX9LzRZCytsPpgcWvveWvn0X895/HMOgNhIrnGIXEE9ao0lu2Vj86a
         eHI6CH5jEDxcu0vS10nxXTlPqAf0+iTp+HfCJJmiYtYhiQZnWpw/3zkdILRDyWfQmSxO
         0TAg==
X-Forwarded-Encrypted: i=1; AJvYcCXxX6i1R94bVpsF+NtXNDNfClCbXttYUQ0uzgccQTYvvsz8SHGtUCzq/U6pZbZQBrLIUiBkHCRPQI1QVf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1kxqr4rSd51QcR13XRslbjZgzJBPcGas9qqYLmJuR5fa8pRRU
	xgL58GN/kJD9yeUnuGMsXfIs8hoqbwSPeJJGVYXHF7hDqPnteQ13BVMGxpHEn/eRy3QX2uPfa79
	BKBtZstcVOYYrkL4g+jR/LRKxTiuXueUiVomd2kDoYADfoqMJtaHuEqXMZ2me+atCSA==
X-Gm-Gg: ASbGncudwNEOX10GaBkI0ntGXhiSMndxM9p75E5dzP4S5uNwGC9zRRY9luIU7hEvQLr
	6LEkwTJk8zkrx2jT24ixabnSQjz0q6LS+N5lBDREZV4a3F5dUvwsunRBdem/fb9104nzLbNwXHY
	1X7EC2L+8dbmBdjvzNI3LjRiEjCErn0HQi2Dzu5Hz+JL4JU1rQ8aZ7Rr340t1FjEsioqImt0fvf
	tV/Fhj3m5hhm6tdDvr0ThsACmIrR+EbsjiNq8smHTin09wPLlbhWnUwUxWqQOd47fwcRddrM+0S
	0RNw6SZeBwT4UZ814YqZel9uICR6ulSqmksOKvsZCPtWYjwUsRIB33TLIfeXSBZeQCweGXIgG0J
	rWyNF3DphYkntHKZhjN0kU3zx0jkwXKNwD7k0dhAJIt+zuA==
X-Received: by 2002:a17:902:ce8d:b0:27e:dc53:d239 with SMTP id d9443c01a7336-290caf84628mr52931085ad.35.1760723567605;
        Fri, 17 Oct 2025 10:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtHI8zEiYjDKM4Y0n1dEzB5SaaQjotwDpGDbW63VJ9IKLOCmrbNidjMc/GBXbcWjXcLUPAwg==
X-Received: by 2002:a17:902:ce8d:b0:27e:dc53:d239 with SMTP id d9443c01a7336-290caf84628mr52930715ad.35.1760723567190;
        Fri, 17 Oct 2025 10:52:47 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdce3sm981955ad.90.2025.10.17.10.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 10:52:46 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1b510c7e-6d48-4f3c-b3cb-8a7a0834784c@redhat.com>
Date: Fri, 17 Oct 2025 13:52:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] sched/deadline: Walk up cpuset hierarchy to decide root
 domain when hot-unplug
To: Pingfan Liu <piliu@redhat.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20251017122636.17671-1-piliu@redhat.com>
Content-Language: en-US
In-Reply-To: <20251017122636.17671-1-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/25 8:26 AM, Pingfan Liu wrote:
> When testing kexec-reboot on a 144 cpus machine with
> isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> encounter the following bug:
>
> [   97.114759] psci: CPU142 killed (polled 0 ms)
> [   97.333236] Failed to offline CPU143 - error=-16
> [   97.333246] ------------[ cut here ]------------
> [   97.342682] kernel BUG at kernel/cpu.c:1569!
> [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> [   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_port cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresight_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor usbnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel coresight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetlink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme nvme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod
> [   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not tainted 6.12.0-41.el10.aarch64 #1
> [   97.413371] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 2.0 07/12/2024
> [   97.420400] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [   97.427518] pc : smp_shutdown_nonboot_cpus+0x104/0x128
> [   97.432778] lr : smp_shutdown_nonboot_cpus+0x11c/0x128
> [   97.438028] sp : ffff800097c6b9a0
> [   97.441411] x29: ffff800097c6b9a0 x28: ffff0000a099d800 x27: 0000000000000000
> [   97.448708] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb94aaaa8f218
> [   97.456004] x23: ffffb94aaaabaae0 x22: ffffb94aaaa8f018 x21: 0000000000000000
> [   97.463301] x20: ffffb94aaaa8fc10 x19: 000000000000008f x18: 00000000fffffffe
> [   97.470598] x17: 0000000000000000 x16: ffffb94aa958fcd0 x15: ffff103acfca0b64
> [   97.477894] x14: ffff800097c6b520 x13: 36312d3d726f7272 x12: ffff103acfc6ffa8
> [   97.485191] x11: ffff103acf6f0000 x10: ffff103bc085c400 x9 : ffffb94aa88a0eb0
> [   97.492488] x8 : 0000000000000001 x7 : 000000000017ffe8 x6 : c0000000fffeffff
> [   97.499784] x5 : ffff003bdf62b408 x4 : 0000000000000000 x3 : 0000000000000000
> [   97.507081] x2 : 0000000000000000 x1 : ffff0000a099d800 x0 : 0000000000000002
> [   97.514379] Call trace:
> [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> [   97.521769]  machine_shutdown+0x20/0x38
> [   97.525693]  kernel_kexec+0xc4/0xf0
> [   97.529260]  __do_sys_reboot+0x24c/0x278
> [   97.533272]  __arm64_sys_reboot+0x2c/0x40
> [   97.537370]  invoke_syscall.constprop.0+0x74/0xd0
> [   97.542179]  do_el0_svc+0xb0/0xe8
> [   97.545562]  el0_svc+0x44/0x1d0
> [   97.548772]  el0t_64_sync_handler+0x120/0x130
> [   97.553222]  el0t_64_sync+0x1a4/0x1a8
> [   97.556963] Code: a94363f7 a8c47bfd d50323bf d65f03c0 (d4210000)
> [   97.563191] ---[ end trace 0000000000000000 ]---
> [   97.595854] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [   97.602275] Kernel Offset: 0x394a28600000 from 0xffff800080000000
> [   97.608502] PHYS_OFFSET: 0x80000000
> [   97.612062] CPU features: 0x10,0000000d,002a6928,5667fea7
> [   97.617580] Memory Limit: none
> [   97.648626] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
>
> Tracking down this issue, I found that dl_bw_deactivate() returned
> -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> When a CPU is inactive, its rd is set to def_root_domain. For an
> blocked-state deadline task (in this case, "cppc_fie"), it was not
> migrated to CPU0, and its task_rq() information is stale. As a result,
> its bandwidth is wrongly accounted into def_root_domain during domain
> rebuild.

First of all, in an emergency situation when we need to shutdown the 
kernel, does it really matter if dl_bw_activate() returns -EBUSY? Should 
we just go ahead and ignore this dl_bw generated error?


> The key point is that root_domain is only tracked through active rq->rd.
> To avoid using a global data structure to track all root_domains in the
> system, we need a way to locate an active CPU within the corresponding
> root_domain.
>
> The following rules stand for deadline sub-system and help locating the
> active cpu
>    -1.any cpu belongs to a unique root domain at a given time
>    -2.DL bandwidth checker ensures that the root domain has active cpus.
>
> Now, let's examine the blocked-state task P.
> If P is attached to a cpuset that is a partition root, it is
> straightforward to find an active CPU.
> If P is attached to a cpuset that has changed from 'root' to 'member',
> the active CPUs are grouped into the parent root domain. Naturally, the
> CPUs' capacity and reserved DL bandwidth are taken into account in the
> ancestor root domain. (In practice, it may be unsafe to attach P to an
> arbitrary root domain, since that domain may lack sufficient DL
> bandwidth for P.) Again, it is straightforward to find an active CPU in
> the ancestor root domain.
>
> This patch groups CPUs into isolated and housekeeping sets. For the
> housekeeping group, it walks up the cpuset hierarchy to find active CPUs
> in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.
>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Michal Koutný" <mkoutny@suse.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> To: cgroups@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> ---
>   include/linux/cpuset.h  | 18 ++++++++++++++++++
>   kernel/cgroup/cpuset.c  | 27 +++++++++++++++++++++++++++
>   kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
>   3 files changed, 69 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2ddb256187b51..7c00ebcdf85d9 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -130,6 +130,7 @@ extern void rebuild_sched_domains(void);
>   
>   extern void cpuset_print_current_mems_allowed(void);
>   extern void cpuset_reset_sched_domains(void);
> +extern void task_get_rd_effective_cpus(struct task_struct *p, struct cpumask *cpus);
>   
>   /*
>    * read_mems_allowed_begin is required when making decisions involving
> @@ -276,6 +277,23 @@ static inline void cpuset_reset_sched_domains(void)
>   	partition_sched_domains(1, NULL, NULL);
>   }
>   
> +static inline void task_get_rd_effective_cpus(struct task_struct *p,
> +		struct cpumask *cpus)
> +{
> +	const struct cpumask *hk_msk;
> +	struct cpumask msk;
> +
> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> +		if (!cpumask_and(&msk, p->cpus_ptr, hk_msk)) {
> +			/* isolated cpus belong to a root domain */
> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> +			return;
> +		}
> +	}
> +	cpumask_and(cpus, cpu_active_mask, hk_msk);
> +}

The size of struct cpumask can be large depending on the extra value of 
NR_CPUS. For a x86-64 RHEL kernel, it is over 1 kbytes. We can actually 
eliminate the use of a struct cpumask variable by replacing 
cpumask_and() with cpumask_intersects().

You said that isolated CPUs belong to a root domain. In the case of CPUs 
within an isolated partition, the CPUs are in a null root domain which I 
don't know if it is problematic or not.

We usually prefix an externally visible function from cpuset with the 
cpuset prefix to avoid namespace collision. You should consider doing 
that for this function.

Also I am still not very clear about the exact purpose of this function. 
You should probably add comment about this.

> +
>   static inline void cpuset_print_current_mems_allowed(void)
>   {
>   }
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675d..f7b18892ed093 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1102,6 +1102,33 @@ void cpuset_reset_sched_domains(void)
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> +/* caller hold RCU read lock */
> +void task_get_rd_effective_cpus(struct task_struct *p, struct cpumask *cpus)
> +{
> +	const struct cpumask *hk_msk;
> +	struct cpumask msk;
> +	struct cpuset *cs;
> +
> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> +		if (!cpumask_and(&msk, p->cpus_ptr, hk_msk)) {
> +			/* isolated cpus belong to a root domain */
> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> +			return;
> +		}
> +	}
> +	/* In HK_TYPE_DOMAIN, cpuset can be applied */
> +	cs = task_cs(p);
> +	while (cs != &top_cpuset) {
> +		if (is_sched_load_balance(cs))
> +			break;
> +		cs = parent_cs(cs);
> +	}
> +
> +	/* For top_cpuset, its effective_cpus does not exclude isolated cpu */
> +	cpumask_and(cpus, cs->effective_cpus, hk_msk);
> +}
> +

Similar problems with the non-CONFIG_CPUSETS version in cpuset.h.

Cheers,
Longman


