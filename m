Return-Path: <linux-kernel+bounces-752482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE0AB17613
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550F1A8257E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AAC2C15B8;
	Thu, 31 Jul 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdkNIATD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618661E5B6A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753986338; cv=none; b=RgDLx14V3Qd5C/LB5MOB7UjgoWIcF9opNGlNVz8FtkLhgWIRU9Ww6rRi5Z5WWLqKk3T4Xt+zvxSWj+8F6hT2lCNRPheS5rEFG372Yg6DV5fUYeGIMqVJ0MMxUyaOi4oVPePkYl4rc6F31u84VnYxXLHN103TvS+hiMzPiYkGWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753986338; c=relaxed/simple;
	bh=yY5dXq14/rie7sFP1SaBCx59uDTJ52bxziaHDVcpNgw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=XHXoZZNODI5aVp/4H9fr/K/KRbx2/jSmyAELQTCS2txY4l/+/o0avjwJVExEyjI06RsDbvuQ5x72gPPQR3cRbm1OEJFTrsr1tCjHJ5WKRP7aNvWdeKCcRbTz+NV/XiTQoBoGN/NPUfJIFH2KpSke7S4bbkHbE9T8gGLVOslmxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdkNIATD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753986335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YqpW3Q6Os9vELO745LBTOMoU94muV81QvjlghSIE+c=;
	b=VdkNIATDl8so41jU4vj3IhNDtwVC+EKReNpKI7mKGVSZkkZhsq7LFEquBRh3BnQyYJapXb
	Gg7fgM2BXQQ3ylTWjBVHDbDv4mib39AoS7CYFDGZV2I80NkcPY/trUmPGuq2jCd/wNwVEH
	sY8WGObRHuk7YEEjWTwLw7LwTguIof0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-xcFcEJYaPXyhfIGXJg0SAw-1; Thu, 31 Jul 2025 14:25:33 -0400
X-MC-Unique: xcFcEJYaPXyhfIGXJg0SAw-1
X-Mimecast-MFC-AGG-ID: xcFcEJYaPXyhfIGXJg0SAw_1753986333
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7074bad051fso12540296d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753986333; x=1754591133;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YqpW3Q6Os9vELO745LBTOMoU94muV81QvjlghSIE+c=;
        b=ilScAhi3bi3HptIfDZgRaQsi4NJ7lVx0bl2h4qSBFUpzA/Ql88F1UhPOzIwffZyzq3
         JQ4EBc0QPeit8/sp4EhHZW/TvzEYMipBHmTxVf3QCPXLX49OLEXuEn82zgINWN+frLCf
         Lao19xln4WJsrufckxdQv+4xwhckjnWUh7Yw4H7pwuWZEX6Bq745Py2unBoL6FzGrlyl
         cfTLTiqJm36QxcgpltypODi4Ngaql53vEx5hzPTCMRGIql0xoKycdg1VUogYZ7nRDzTn
         eyPZaNtUQVRGYcHylXAyJk1A5zTIqo+jm5KT3MLpzc4COmY8u2IyeVnwgkjqd7GigUcy
         Z+/A==
X-Forwarded-Encrypted: i=1; AJvYcCUIJOe0kkEoDhp4T1zI0ZC9WsopgcZB+X0EAZv/Md+rYnBNz/bDWLqZvHdEOuqv/Fji5kY1TM/1OhwII0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rMA+63vkCQMc3jrK5G7JmVYXp8pzlbtObjOXs8rBhJYmTRp5
	prHPS9F9AkaYJ4zIE7UaAvdvrM9LJ60lFCX3UNanRBK8xiVvaf6V0H20n1LdHYmXFdKv825kVrd
	0HhE9qgmeklnWkOxYSE0AQL+DC0nVdDNUnLAKREHGG//wYap4OWAhW6HECABJkvS6Hw==
X-Gm-Gg: ASbGncsFtOHSJnS/U76UKkDKDMzn662em4t0XVRWdtRbLujad/bjus04Sw4FavKquF8
	g7+FW5WOopKeNjJ2v38YsoFH/uywMEWvsjcxQNLL20f2yqOMesuqtUm+Mn1q6iQaaYg6yHO5I2P
	4dlOmZBnPZkFwZXEBwyvMi7poRSnvyNfRT2Wr3r9WE5CgiRw6Hfg/MysEv94hAD6AH6NXfBIUnD
	nErkPxwVthPV1wbZGLb71L2ewbJvUTfgZHc7ZPKDgeqZ7K6F+x7fnKUdfVb3zYJep6lY0MSborJ
	RsPKwCPseB9YBytiaCkIzrHLvJg/h5WShTG9WrGUHYWL6iss3T8Bfi6foqw5SBpQpQbHJBNXb67
	u6ckWd9bLmg==
X-Received: by 2002:a05:6214:20ee:b0:707:5758:c0ae with SMTP id 6a1803df08f44-70767114bd8mr101580716d6.32.1753986332799;
        Thu, 31 Jul 2025 11:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvLW9rB8b3a6Ww2DjBoqq+8Mq9CCnOF+0O0MzSFVA6ZW/ZA/1qEllSVLRzydK5rAJ0SkAcGg==
X-Received: by 2002:a05:6214:20ee:b0:707:5758:c0ae with SMTP id 6a1803df08f44-70767114bd8mr101580196d6.32.1753986332140;
        Thu, 31 Jul 2025 11:25:32 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca1aa40sm10801436d6.24.2025.07.31.11.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 11:25:31 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <664fc8e7-98f6-410c-976e-2e497e5132f8@redhat.com>
Date: Thu, 31 Jul 2025 14:25:30 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] timers: Exclude isolated cpus from timer migration
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250730131158.101668-1-gmonaco@redhat.com>
 <20250730131158.101668-9-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250730131158.101668-9-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 9:11 AM, Gabriele Monaco wrote:
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
For the nohz_full list here, do you mean nohz_full housekeeping or 
non-housekeeping list?
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
>   kernel/time/timer_migration.c | 100 +++++++++++++++++++++++++++++++++-
>   3 files changed, 109 insertions(+), 3 deletions(-)
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
> index a946d85ce954..ff5b66abd047 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1392,6 +1392,9 @@ static void update_exclusion_cpumasks(bool isolcpus_updated)
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
> index 36e7f784ec60..5e66147fce11 100644
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
> @@ -436,6 +437,20 @@ static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
>   	return !(tmc->tmgroup && tmc->available);
>   }
>   
> +/*
> + * Returns true if @cpu should be excluded from the hierarchy as isolated.
> + * Domain isolated CPUs don't participate in timer migration, nohz_full
> + * CPUs are still part of the hierarchy but are always considered idle.
> + * This check is necessary, for instance, to prevent offline isolated CPU from
> + * being incorrectly marked as available once getting back online.
> + */
> +static inline bool tmigr_is_isolated(int cpu)
> +{
> +	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
> +		cpuset_cpu_is_isolated(cpu)) &&
> +	       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
> +}

Does that mean a CPU in the nohz_full non-housekeeping list is always 
considered not isolated WRT timer migration and hence will be made 
available for timer migration purpose?

Cheers,
Longman


