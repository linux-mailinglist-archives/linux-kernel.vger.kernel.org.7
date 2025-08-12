Return-Path: <linux-kernel+bounces-765341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED91B22EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98253BD1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C62FD1C9;
	Tue, 12 Aug 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qyt9hHwm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE872FD1DE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019219; cv=none; b=lL6nmnD+GgoZxtrxMDLkyQVnlB5E4+6datVtuhYry41uyGojqi+/d/CHtaX0CALzGTRjBMGyQw7xpMFplolNEFVFNzpCiLzT7rB2RQC8pPOyxuKekGF7cZoBTNTRDYp+kkuBuSL2y31+seb/TG8pe63EuA70jpdsXAO7b5F945w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019219; c=relaxed/simple;
	bh=lYfvyK1xMFjnRLWau7Rs0JMTOBTpI9neUTXQE7hRiz4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=GWZxX5dhbWUWTB8q42izCLlNQgc2yywnoxfH527f/YZWMEIHP64EUuZmjKb8ldQQ+WLCEHJ62MFD6epSsnTHCESxuJtBrAkk6eu4HycaHfHluCULI7RlbnVq/5VtDuhAkLFjWL357OQp9GN2ZuN+bG/QYfnMibRdbu0m4qEmi20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qyt9hHwm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755019216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlIhq4XvEAg19h097ofLj7fvRaPeRop6IC9VxAfNAOc=;
	b=Qyt9hHwmucr7j96hfkyGEaW14yNZr9LE5JBg4V+7Al+xX7R9QProa8SUpF3rPLliLAjNf2
	4dYF41qUGggZJNjUrTJHJWTknzR8YtdwNXpPQhphUw3Ap5mOB1MAoDeXyNKcX9kB2Iwzvn
	ki3uiNcPTMN4BBEFZsJkYfszACeYbo0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-20MBiwleMqmq-c5qcx3QHQ-1; Tue, 12 Aug 2025 13:20:15 -0400
X-MC-Unique: 20MBiwleMqmq-c5qcx3QHQ-1
X-Mimecast-MFC-AGG-ID: 20MBiwleMqmq-c5qcx3QHQ_1755019214
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e7fc5f1e45so1192247985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755019214; x=1755624014;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlIhq4XvEAg19h097ofLj7fvRaPeRop6IC9VxAfNAOc=;
        b=hfuwHXJLLvMn+uZXjUBzZNxZIdnVN4Lc0QvPBnCaIN04Fg797luVMm7RDf6sYp9j7X
         NZTtqLTfBYERxBpV6OHYkYsQmN2hX2FYwZtlDrKHhrcer0+DJz4lV5RU+T3/gVemJj3g
         QScAaHlVdEQ0vrwt7PpZeFv7/uQvrmAwTAwgbpgOlQrng8npLG4h/fbzo3nKXEEWFZpB
         b6OKHs6qQiSfv/DH/q6nK8y1/stjoPfjsBH2qDiTFqIu05veVconhSeIAQ5lT4ZvIV6B
         M9wgKUTpAgowC9XSXP/ESiRghA2X2LbS7W0VHMNF6GSECQIRCYkJ2QSVF+MMXy/nWZvQ
         CP7w==
X-Forwarded-Encrypted: i=1; AJvYcCUSeDHpWwwAZDK/OIPyMvDGupMH1xvz0yk5OIar7PWkXpQiRT9pNjoppbWd6ZLXX+iUiBbJWO8k+Azhgmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+cEaTndwwwaBJD4lXuZD7MwT8VdRiqNSMYglaazYSVIOuimZ
	1TlfUpCXdhOueCkSBCIe6OuSboPrfnLRXqE2Mr7OjDDFeUIqRIEeemRsQLlr31nVC2MRYY3xMOn
	TtWeLyzumEPqnDltBFeOYp6LvHRQXb3qLVLGPgxyI5IQkhBoGHFEuhgGx1liBJHcUpbUrL/v1+g
	==
X-Gm-Gg: ASbGncvEibSlA3qAxr5Fu5FS7cVtBYIoLJhwwUzAIL7GUtVwrmdJ1PXBfZZw7dcRcIN
	dYkVbSCGsWr42frA0tXI+fblaqyzm2kBupn0i6C0CHhNs7T62RJl42R/gxOubjzOFyfOLd+tCS5
	TyvJ1uXmUR0LMzrgsydlxl7epibFxixUSEAaJy8EnJra0G6U1Tvo5tZJeVKoWafMfGcDCadMu8o
	OoCGdJcztU8D1ESVVE+G84dfz2ehwfXNPIMAyZVUfeXYP8SSLmcYFiJ3JF3MjSd7ZWLUWDqEGbH
	IzlLW7pI3/C5hHIA5sq/ttu/JRT/ptukO8LnQgBT4Iryhz6c6iTGm4o9J5NuOXhG7QdBO4XG+p5
	9gc+2FtNAzg==
X-Received: by 2002:a05:620a:4e04:b0:7e8:63bb:86a8 with SMTP id af79cd13be357-7e8646349dcmr51226985a.58.1755019213977;
        Tue, 12 Aug 2025 10:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE8TOUtUKcQLFFi6qYb6Y1plR84ZE9G+5Cvz2NkMPx3tJSEVYO8cprLBhaEzG8ci6vHXGVMA==
X-Received: by 2002:a05:620a:4e04:b0:7e8:63bb:86a8 with SMTP id af79cd13be357-7e8646349dcmr51223585a.58.1755019213294;
        Tue, 12 Aug 2025 10:20:13 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5947e9sm1796627585a.1.2025.08.12.10.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 10:20:12 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4b99074a-af21-4d14-b995-a4e62275a62f@redhat.com>
Date: Tue, 12 Aug 2025 13:20:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] timers: Exclude isolated cpus from timer
 migration
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250808160142.103852-1-gmonaco@redhat.com>
 <20250808160142.103852-9-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250808160142.103852-9-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 12:01 PM, Gabriele Monaco wrote:
> The timer migration mechanism allows active CPUs to pull timers from
> idle ones to improve the overall idle time. This is however undesired
> when CPU intensive workloads run on isolated cores, as the algorithm
> would move the timers from housekeeping to isolated cores, negatively
> affecting the isolation.
>
> Exclude isolated cores from the timer migration algorithm, extend the
> concept of unavailable cores, currently used for offline ones, to
> isolated ones:
> * A core is unavailable if isolated or offline;
> * A core is available if non isolated and online;
>
> A core is considered unavailable as isolated if it belongs to:
> * the isolcpus (domain) list
> * an isolated cpuset
> Except if it is:
> * in the nohz_full list (already idle for the hierarchy)
> * the nohz timekeeper core (must be available to handle global timers)
>
> CPUs are added to the hierarchy during late boot, excluding isolated
> ones, the hierarchy is also adapted when the cpuset isolation changes.
>
> Due to how the timer migration algorithm works, any CPU part of the
> hierarchy can have their global timers pulled by remote CPUs and have to
> pull remote timers, only skipping pulling remote timers would break the
> logic.
> For this reason, prevent isolated CPUs from pulling remote global
> timers, but also the other way around: any global timer started on an
> isolated CPU will run there. This does not break the concept of
> isolation (global timers don't come from outside the CPU) and, if
> considered inappropriate, can usually be mitigated with other isolation
> techniques (e.g. IRQ pinning).
>
> This effect was noticed on a 128 cores machine running oslat on the
> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
> and the CPU with lowest count in a timer migration hierarchy (here 1
> and 65) appears as always active and continuously pulls global timers,
> from the housekeeping CPUs. This ends up moving driver work (e.g.
> delayed work) to isolated CPUs and causes latency spikes:
>
> before the change:
>
>   # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>   ...
>    Maximum:     1203 10 3 4 ... 5 (us)
>
> after the change:
>
>   # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>   ...
>    Maximum:      10 4 3 4 3 ... 5 (us)
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/linux/timer.h         |   9 +++
>   kernel/cgroup/cpuset.c        |   3 +
>   kernel/time/timer_migration.c | 103 +++++++++++++++++++++++++++++++++-
>   3 files changed, 112 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index 0414d9e6b4fc..62e1cea71125 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -188,4 +188,13 @@ int timers_dead_cpu(unsigned int cpu);
>   #define timers_dead_cpu		NULL
>   #endif
>   
> +#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
> +extern int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask);
> +#else
> +static inline int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
> +{
> +	return 0;
> +}
> +#endif
> +
>   #endif
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7b66ccedbc53..2e73fc450a81 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1393,6 +1393,9 @@ static void update_exclusion_cpumasks(bool isolcpus_updated)
>   
>   	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
>   	WARN_ON_ONCE(ret < 0);
> +
> +	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
> +	WARN_ON_ONCE(ret < 0);
>   }
>   
>   /**
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 0a3a26e766d0..07b63be18f83 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -10,6 +10,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/timerqueue.h>
>   #include <trace/events/ipi.h>
> +#include <linux/sched/isolation.h>
>   
>   #include "timer_migration.h"
>   #include "tick-internal.h"
> @@ -436,6 +437,23 @@ static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
>   	return !(tmc->tmgroup && tmc->available);
>   }
>   
> +/*
> + * Returns true if @cpu should be excluded from the hierarchy as isolated.
> + * Domain isolated CPUs don't participate in timer migration, nohz_full CPUs
> + * are still part of the hierarchy but become idle (from a tick and timer
> + * migration perspective) when they stop their tick. This lets the timekeeping
> + * CPU handle their global timers. Marking also isolated CPUs as idle would be
> + * too costly, hence they are completely excluded from the hierarchy.
> + * This check is necessary, for instance, to prevent offline isolated CPUs from
> + * being incorrectly marked as available once getting back online.
> + */
> +static inline bool tmigr_is_isolated(int cpu)
> +{
> +	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
> +		cpuset_cpu_is_isolated(cpu)) &&
> +	       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
> +}
> +
>   /*
>    * Returns true, when @childmask corresponds to the group migrator or when the
>    * group is not active - so no migrator is set.
> @@ -1451,6 +1469,8 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
>   
>   	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
>   	scoped_guard(raw_spinlock_irq, &tmc->lock) {
> +		if (!tmc->available)
> +			return 0;
>   		tmc->available = false;
>   		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
>   
> @@ -1470,7 +1490,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
>   	return 0;
>   }
>   
> -static int tmigr_set_cpu_available(unsigned int cpu)
> +static inline int _tmigr_set_cpu_available(unsigned int cpu)
>   {
>   	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
>   
> @@ -1480,6 +1500,8 @@ static int tmigr_set_cpu_available(unsigned int cpu)
>   
>   	cpumask_set_cpu(cpu, tmigr_available_cpumask);
>   	scoped_guard(raw_spinlock_irq, &tmc->lock) {
> +		if (tmc->available)
> +			return 0;
>   		trace_tmigr_cpu_available(tmc);
>   		tmc->idle = timer_base_is_idle();
>   		if (!tmc->idle)
> @@ -1489,14 +1511,89 @@ static int tmigr_set_cpu_available(unsigned int cpu)
>   	return 0;
>   }
>   
> +static int tmigr_set_cpu_available(unsigned int cpu)
> +{
> +	if (tmigr_is_isolated(cpu))
> +		return 0;
> +	return _tmigr_set_cpu_available(cpu);
> +}
> +
> +static bool tmigr_should_isolate_cpu(int cpu, void *ignored)
> +{
> +	/*
> +	 * The tick CPU can be marked as isolated by the cpuset code, however
> +	 * we cannot mark it as unavailable to avoid having no global migrator
> +	 * for the nohz_full CPUs.
> +	 */
> +	return tick_nohz_cpu_hotpluggable(cpu);
> +}
We may have to update the cpuset code to fail isolated partition 
formation if it includes the nohz_full tick CPU as that CPU cannot be 
fully isolated. That will also make this patch simpler.
> +
> +static void tmigr_cpu_isolate(void *ignored)
> +{
> +	tmigr_clear_cpu_available(smp_processor_id());
> +}
> +
> +static void tmigr_cpu_unisolate(void *ignored)
> +{
> +	tmigr_set_cpu_available(smp_processor_id());
> +}
> +
> +static void tmigr_cpu_unisolate_force(void *ignored)
> +{
> +	/*
> +	 * Required at boot to restore the tick CPU if nohz_full is available.
> +	 * Hotplug handlers don't check for tick CPUs during runtime.
> +	 */
> +	_tmigr_set_cpu_available(smp_processor_id());
> +}
> +
> +int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
> +{
> +	cpumask_var_t cpumask;
> +
> +	lockdep_assert_cpus_held();
> +
> +	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	cpumask_and(cpumask, exclude_cpumask, tmigr_available_cpumask);
> +	cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
> +	on_each_cpu_cond_mask(tmigr_should_isolate_cpu, tmigr_cpu_isolate, NULL,
> +			      1, cpumask);
> +
> +	cpumask_andnot(cpumask, cpu_online_mask, exclude_cpumask);
> +	cpumask_andnot(cpumask, cpumask, tmigr_available_cpumask);
> +	on_each_cpu_mask(cpumask, tmigr_cpu_unisolate, NULL, 1);
> +
> +	free_cpumask_var(cpumask);
> +	return 0;
> +}
> +
>   /*
>    * NOHZ can only be enabled after clocksource_done_booting(). Don't
>    * bother trashing the cache in the tree before.
>    */
>   static int __init tmigr_late_init(void)
>   {
> -	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
> -				 tmigr_set_cpu_available, tmigr_clear_cpu_available);
> +	int cpu, ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
> +				tmigr_set_cpu_available, tmigr_clear_cpu_available);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * The tick CPU may not be marked as available in the above call, this
> +	 * can occur only at boot as hotplug handlers are not called on the
> +	 * tick CPU. Force it enabled here.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		if (!tick_nohz_cpu_hotpluggable(cpu)) {
> +			ret = smp_call_function_single(
> +				cpu, tmigr_cpu_unisolate_force, NULL, 1);
> +			break;
> +		}
> +	}
> +	return ret;
>   }
Can you integrate the 
tick_nohz_cpu_hotpluggable/tmigr_should_isolate_cpu check into 
tmigr_set_cpu_available() instead of special-casing the tick CPU here?

Cheers,
Longman


