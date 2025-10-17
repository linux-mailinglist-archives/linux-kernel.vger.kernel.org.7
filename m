Return-Path: <linux-kernel+bounces-857474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A5BE6E49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1E442596C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13D30C61F;
	Fri, 17 Oct 2025 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTMTbUDu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B23112B0
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684931; cv=none; b=steidwz5zE7A8/IPtvvRXvLMb+gGNmdztoehaALyqAqlAHVfTKWXvBULKspXkhXC3hvwJAH5hYkD7VM4X12HaeRxQXYmdPhE31D00N28lhmqqNDcunYI0qfGO4esPo7Hlys8XZzYmtjDqCGqa+odV5jtjzcpAsOYcNTFUSNvwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684931; c=relaxed/simple;
	bh=8mjSi/l9ITQSFCQO4QdXl/U5xjcRVlpQHggGZHeK5Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qgta3TQOCBNxx1wZaP71T//Hq5IBavGUwt2u4yy+vzM2h3RqqY/eYL5StaoyPu9gHewHQbXBVT8RFNHrkSJwAZEGEXm35IsB8RT3iiqtjj28pJBZaJ6zS0pee9foA6c8wRBfJLccAfiQK/OLu62zSFHDpkwQ9ptFZKKoBs+lZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTMTbUDu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760684928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbGHQ6oN5O9OhzBbutw2WTO4S2CE1QxuxxDY+0YGQQI=;
	b=aTMTbUDuOlrutaMS1Z0CcNUF4vdz1deRjFzOMgL6jqOuQCh/Zhr+DOyyxbofmO6748Y7LM
	sHscJlod5PnlJNO158k/aSpBF/xZcSp887woz+Z7MnVEmz+bxZTy9I2XRMj/YdSFHIRzKZ
	ZO/ekN6Ft9549OE5SrBouFTIt8rkN/U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-jGpCymvZM7qnwqer3J800g-1; Fri, 17 Oct 2025 03:08:46 -0400
X-MC-Unique: jGpCymvZM7qnwqer3J800g-1
X-Mimecast-MFC-AGG-ID: jGpCymvZM7qnwqer3J800g_1760684926
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28c58e009d1so31699465ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760684926; x=1761289726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbGHQ6oN5O9OhzBbutw2WTO4S2CE1QxuxxDY+0YGQQI=;
        b=cPc3egUKclFBcdCJbHx6ofNuZo+8bGUtOcXotVcGsMUTBUvx4DPSfNFrBEPRKUJnWv
         VrCnwvHdEpvJMHXAyciEjIW3GICXMoWxRPFgQCOX70JIN+1z4TAfL5fJIUQr+QSPRLOJ
         xwwKvf59KYeiaDEZMlOXrcrDmS1tS+L7Bp338WOvrTh0kKZ2PtoLVbFnhqnJmThgqbl9
         T82U4TELiGIWFDayrkj2bmMxJubvLE3fwGS/ebdCMyH3KlcfQGQ9FujzXw1Hknsorh3F
         yMQapj4BqY9a3OQvDppfLBPnDPZRv5aE08GudqaIRgKNetnJa8W/ghTKfUd6sHJmjcA+
         bSCw==
X-Gm-Message-State: AOJu0YzqQpUJc/pjyZF2OeXjcLTM+eAmg7ehMLDbZX0FfmirTp8nMIpM
	/lMGmArNXuXGUG7QMxNu0altaPV+eHc3TKbuwejkeo9PmBWnZ0E1vWlwRjW3GSpqs9VZ/GAxmxL
	oMrfSuvxKUSrWqWLLCJZb93ArcCQm9y0Q8WK4pVgu/toHSJgFeH5eNkBvvB4mvUB4eE9bk6/zWb
	K3m6LvNG9OfZNR+4vFBr5NjFR5dx3xLagBQ0RCpniq
X-Gm-Gg: ASbGncuri9zE0RLdJQ4+FPQf1ZQlBhu2ja6nMRmdTFUg4J75dq8iHljbwf7hFbyer2G
	OCuFONqbyT59Fap2XM1a6k/UnJBRv0lRYkxGWB3+XuVBujPqjmbf0SjcsPx98JiAcGoHnUPewj/
	r+ERRrIVVUmFuYaPZF9MuQqeD10fyV1QqtTqyBIwcRgfAdnM/KnLasQHrp
X-Received: by 2002:a17:903:19cf:b0:27b:472e:3a22 with SMTP id d9443c01a7336-290cc6da03emr32365235ad.56.1760684925753;
        Fri, 17 Oct 2025 00:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBbZhj5TqC6m2b5cR5DaBYczI0tujdLeSy5IpqGZDSKH/M8dCYXHyQBGsp9RNxMSMa+SDXYTxsWBP+3i0T1PE=
X-Received: by 2002:a17:903:19cf:b0:27b:472e:3a22 with SMTP id
 d9443c01a7336-290cc6da03emr32364985ad.56.1760684925345; Fri, 17 Oct 2025
 00:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016120041.17990-1-piliu@redhat.com> <91eb613a-2e29-4e1d-b78f-741c5fb88e90@arm.com>
In-Reply-To: <91eb613a-2e29-4e1d-b78f-741c5fb88e90@arm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 17 Oct 2025 15:08:34 +0800
X-Gm-Features: AS18NWDvpPmdf41uKV_lb8refzQjHwOiXRSI-JL1PxiQD6Vv6QDChMA-VNGJ4wA
Message-ID: <CAF+s44QOQHwjaaCiFzi_vJRXvDusJCKpEyr85=ZHNjnD7JSO4w@mail.gmail.com>
Subject: Re: [PATCHv2] sched/deadline: Walk up cpuset hierarchy to decide root
 domain when hot-unplug
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierre,

Thanks for your careful test and analysis. Please see the comments below.

On Thu, Oct 16, 2025 at 11:30=E2=80=AFPM Pierre Gondois <pierre.gondois@arm=
.com> wrote:
>
> Hello Pingfan,
>
> On 10/16/25 14:00, Pingfan Liu wrote:
> > When testing kexec-reboot on a 144 cpus machine with
> > isolcpus=3Dmanaged_irq,domain,1-71,73-143 in kernel command line, I
> > encounter the following bug:
> >
> > [   97.114759] psci: CPU142 killed (polled 0 ms)
> > [   97.333236] Failed to offline CPU143 - error=3D-16
> > [   97.333246] ------------[ cut here ]------------
> > [   97.342682] kernel BUG at kernel/cpu.c:1569!
> > [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> > [   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_p=
ort cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresigh=
t_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor us=
bnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel cor=
esight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetl=
ink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme n=
vme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_m=
sghandler dm_mirror dm_region_hash dm_log dm_mod
> > [   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not ta=
inted 6.12.0-41.el10.aarch64 #1
> > [   97.413371] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 2.0 07/1=
2/2024
> > [   97.420400] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BT=
YPE=3D--)
> > [   97.427518] pc : smp_shutdown_nonboot_cpus+0x104/0x128
> > [   97.432778] lr : smp_shutdown_nonboot_cpus+0x11c/0x128
> > [   97.438028] sp : ffff800097c6b9a0
> > [   97.441411] x29: ffff800097c6b9a0 x28: ffff0000a099d800 x27: 0000000=
000000000
> > [   97.448708] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb94=
aaaa8f218
> > [   97.456004] x23: ffffb94aaaabaae0 x22: ffffb94aaaa8f018 x21: 0000000=
000000000
> > [   97.463301] x20: ffffb94aaaa8fc10 x19: 000000000000008f x18: 0000000=
0fffffffe
> > [   97.470598] x17: 0000000000000000 x16: ffffb94aa958fcd0 x15: ffff103=
acfca0b64
> > [   97.477894] x14: ffff800097c6b520 x13: 36312d3d726f7272 x12: ffff103=
acfc6ffa8
> > [   97.485191] x11: ffff103acf6f0000 x10: ffff103bc085c400 x9 : ffffb94=
aa88a0eb0
> > [   97.492488] x8 : 0000000000000001 x7 : 000000000017ffe8 x6 : c000000=
0fffeffff
> > [   97.499784] x5 : ffff003bdf62b408 x4 : 0000000000000000 x3 : 0000000=
000000000
> > [   97.507081] x2 : 0000000000000000 x1 : ffff0000a099d800 x0 : 0000000=
000000002
> > [   97.514379] Call trace:
> > [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> > [   97.521769]  machine_shutdown+0x20/0x38
> > [   97.525693]  kernel_kexec+0xc4/0xf0
> > [   97.529260]  __do_sys_reboot+0x24c/0x278
> > [   97.533272]  __arm64_sys_reboot+0x2c/0x40
> > [   97.537370]  invoke_syscall.constprop.0+0x74/0xd0
> > [   97.542179]  do_el0_svc+0xb0/0xe8
> > [   97.545562]  el0_svc+0x44/0x1d0
> > [   97.548772]  el0t_64_sync_handler+0x120/0x130
> > [   97.553222]  el0t_64_sync+0x1a4/0x1a8
> > [   97.556963] Code: a94363f7 a8c47bfd d50323bf d65f03c0 (d4210000)
> > [   97.563191] ---[ end trace 0000000000000000 ]---
> > [   97.595854] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > [   97.602275] Kernel Offset: 0x394a28600000 from 0xffff800080000000
> > [   97.608502] PHYS_OFFSET: 0x80000000
> > [   97.612062] CPU features: 0x10,0000000d,002a6928,5667fea7
> > [   97.617580] Memory Limit: none
> > [   97.648626] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal e=
xception ]
> >
> > Tracking down this issue, I found that dl_bw_deactivate() returned
> > -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> > When a CPU is inactive, its rd is set to def_root_domain. For an
> > blocked-state deadline task (in this case, "cppc_fie"), it was not
> > migrated to CPU0, and its task_rq() information is stale. As a result,
> > its bandwidth is wrongly accounted into def_root_domain during domain
> > rebuild.
> >
> > The following rules stand for deadline sub-system:
> >    -1.any cpu belongs to a unique root domain at a given time
> >    -2.DL bandwidth checker ensures that the root domain has active cpus=
.
> > And for active cpu, cpu_rq(cpu)->rd always tracks a valid root domain.
> >
> > Now, let's examine the blocked-state task P.
> > If P is attached to a cpuset that is a partition root, it is
> > straightforward to find an active CPU.
> > If P is attached to a cpuset which later has changed from 'root' to 'me=
mber',
> > the active CPUs are grouped into the parent root domain. Naturally, the
> > CPUs' capacity and reserved DL bandwidth are taken into account in the
> > parent root domain. (In practice, it may be unsafe to attach P to an
> > arbitrary root domain, since that domain may lack sufficient DL
> > bandwidth for P.) Again, it is straightforward to find an active CPU in
> > the parent root domain. (parent root domain means the first ancestor
> > cpuset which is partition root)
> >
> > This patch walks up the cpuset hierarchy to find the active CPUs in P's
> > root domain and retrieves valid rd from cpu_rq(cpu)->rd.
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Pierre Gondois <pierre.gondois@arm.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > To: linux-kernel@vger.kernel.org
> > ---
> >   include/linux/cpuset.h  |  6 ++++++
> >   kernel/cgroup/cpuset.c  | 15 +++++++++++++++
> >   kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
> >   3 files changed, 45 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index 2ddb256187b51..478ae68bdfc8f 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -130,6 +130,7 @@ extern void rebuild_sched_domains(void);
> >
> >   extern void cpuset_print_current_mems_allowed(void);
> >   extern void cpuset_reset_sched_domains(void);
> > +extern struct cpumask *cpuset_task_rd_effective_cpus(struct task_struc=
t *p);
> >
> >   /*
> >    * read_mems_allowed_begin is required when making decisions involvin=
g
> > @@ -276,6 +277,11 @@ static inline void cpuset_reset_sched_domains(void=
)
> >       partition_sched_domains(1, NULL, NULL);
> >   }
> >
> > +static inline struct cpumask *cpuset_task_rd_effective_cpus(struct tas=
k_struct *p)
> > +{
> > +     return cpu_active_mask;
> > +}
> > +
> >   static inline void cpuset_print_current_mems_allowed(void)
> >   {
> >   }
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 27adb04df675d..25356d3f9d635 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1102,6 +1102,21 @@ void cpuset_reset_sched_domains(void)
> >       mutex_unlock(&cpuset_mutex);
> >   }
> >
> > +/* caller hold RCU read lock */
> > +struct cpumask *cpuset_task_rd_effective_cpus(struct task_struct *p)
> > +{
> > +     struct cpuset *cs;
> > +
> > +     cs =3D task_cs(p);
> > +     while (cs !=3D &top_cpuset) {
> > +             if (is_sched_load_balance(cs))
> > +                     break;
> > +             cs =3D parent_cs(cs);
> > +     }
> > +
> > +     return cs->effective_cpus;
> > +}
> > +
> >   /**
> >    * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the =
cpuset.
> >    * @cs: the cpuset in which each task's cpus_allowed mask needs to be=
 changed
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 72c1f72463c75..fe0aec279c19a 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2884,6 +2884,8 @@ void dl_add_task_root_domain(struct task_struct *=
p)
> >       struct rq_flags rf;
> >       struct rq *rq;
> >       struct dl_bw *dl_b;
> > +     unsigned int cpu;
> > +     struct cpumask *msk;
> >
> >       raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> >       if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
> > @@ -2891,16 +2893,32 @@ void dl_add_task_root_domain(struct task_struct=
 *p)
> >               return;
> >       }
> >
> > -     rq =3D __task_rq_lock(p, &rf);
> > -
> > +     /* prevent race among cpu hotplug, changing of partition_root_sta=
te */
> > +     lockdep_assert_cpus_held();
> > +     /*
> > +      * If @p is in blocked state, task_cpu() may be not active. In th=
at
> > +      * case, rq->rd does not trace a correct root_domain. On the othe=
r hand,
> > +      * @p must belong to an root_domain at any given time, which must=
 have
> > +      * active rq, whose rq->rd traces the valid root domain.
> > +      */
> > +     msk =3D cpuset_task_rd_effective_cpus(p);
>
> For the cppc_fie worker, msk doesn't seem to exclude the isolated CPUs.

You are right. I am distracted from the cpuset.partition_root_state.
But root_domain can be created from two sources:
cpuset.partition_root_state and isolcpus=3D"domain" cmdline. My patch
overlooks the latter one. And finally it returns
top_cpuset.effective_cpus.

I think before diving into cpuset,
housekeeping_cpumask(HK_TYPE_DOMAIN) should be used as the first
filter. With it, isolated cpus are put aside and the left cpus will
obey the control of cpuset.

> The patch seems to work on my setup, but only because the first active
> CPU is selected. CPU0 is likely the primary CPU which is offlined last.
>
> IIUC, this patch should work even if we select the last CPU of resulting
> mask,
> but it fails on my setup:
>
> cpumask_and(msk, cpu_active_mask, msk0);
> cpu =3D cpumask_last(msk);
>

Good catch, again I really appreciate your careful test and analysis.

> ------
>
> Also, just to note (as this might be another topic), but the patch
> doesn't solve
> the case where many deadline tasks are created first:
>    chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &
>
> and we then kexec to another Image
>

Yes, it is not fixed in this patch. And I have another draft patch for
that issue.


Thanks,

Pingfan

> > +     cpu =3D cpumask_first_and(cpu_active_mask, msk);
> > +     /*
> > +      * If a root domain reserves bandwidth for a DL task, the DL band=
width
> > +      * check prevents CPU hot removal from deactivating all CPUs in t=
hat
> > +      * domain.
> > +      */
> > +     BUG_ON(cpu >=3D nr_cpu_ids);
> > +     rq =3D cpu_rq(cpu);
> > +     /*
> > +      * This point is under the protection of cpu_hotplug_lock. Hence
> > +      * rq->rd is stable.
> > +      */
> >       dl_b =3D &rq->rd->dl_bw;
> >       raw_spin_lock(&dl_b->lock);
> > -
> >       __dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
> > -
> >       raw_spin_unlock(&dl_b->lock);
> > -
> > -     task_rq_unlock(rq, p, &rf);
> > +     raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> >   }
> >
> >   void dl_clear_root_domain(struct root_domain *rd)
>


