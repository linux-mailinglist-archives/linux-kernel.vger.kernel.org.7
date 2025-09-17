Return-Path: <linux-kernel+bounces-821622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C2B81C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7406B482A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8F24395C;
	Wed, 17 Sep 2025 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/m62qAO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070FD27B358
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141033; cv=none; b=HMnJIRIfm0MjjP6rrfaChDLfT+78foydhQUO+sh0QLKutQQCDekMrh0tEDkiEIEHZbrq6ZesBUS2Qn0/gOo1slTAODHR3fIEDqbNDPl/F6k5aTmDgorfjR+pyNiQy0o/ydJufVYqynf76V0NJxphuf2lnoGCO+cF6qvd2elJ2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141033; c=relaxed/simple;
	bh=dk5zx77mpJJ4zSO9QP+mnL0268RtvLRSCRX1s15k0/8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fWYitRNaFVirFxZHl8UuEnp9WbZsW/Dj0NI+yeXOU1Hpi2319A5m0QfJXjI0fXyP4kWIh7guvBxsXUITAsverTEFj+Z/jgx6UrLlct4JuPVOxzEC6C9WC5CGP3UlFNxY4jeLvriLG1q24dBRt6zvPOcO6Gkw6jToPo2vOLOhSzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/m62qAO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758141030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IoZ6vgHUgGl8xPXxLnbZGS8X05iv6WeuWzJZo7OEtk=;
	b=W/m62qAOhi+ZUy8+9MaYC5rKaaP6w4Y4wx3469890Ix/d0PsedX+/gyMFgovwEnJCJxzT6
	FSWCmNAeg02M9rYfIzc0kmlA1ZbDjZNNGFVHKVLz19934tYN03W5tL4aZlHij949ZpsPiP
	zwHaVoZ6tooWlDr6KqkMwDLDirLlxN4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-xRk--yRIOrK_jgYOZwjExQ-1; Wed, 17 Sep 2025 16:30:29 -0400
X-MC-Unique: xRk--yRIOrK_jgYOZwjExQ-1
X-Mimecast-MFC-AGG-ID: xRk--yRIOrK_jgYOZwjExQ_1758141029
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32d323297so3958271cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141027; x=1758745827;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IoZ6vgHUgGl8xPXxLnbZGS8X05iv6WeuWzJZo7OEtk=;
        b=vWHcY1EDALon9u7IF0i8Sw4LCzEBr/U2yS8dGNkJPjZJWE4V6Ib9CWNmlzntI7dKR6
         S0fz7lT2qq0uwdPBKmeApqoCHRBdJBiQxPFGKkkKN0P9OOeNjUXcnZNzEdqaMG3XfsXm
         24pKk83i09fAi/aUFULfV49OJir693l3wA8V3XiIctQqkSEyY8+q0W20D60fMzNyK79J
         elUyXRHhrG7jbVfvtIl6RnKwiHt+3BYjQ0D0kdKZMETOz0P5Z9GgCKAnmTX9pQPJky00
         o9PNGH2qMCMxRaP4UI+1oc5MPQlHoczlTk04M1z0tKp0H6dh1vlD9kXAB0l45izzM0/6
         Ftnw==
X-Gm-Message-State: AOJu0YxM4d2SNCuTi/CxQOE7ApoEACRX0lyTz2isGxf4xHvHu/YCs9D7
	tFQpgRW8eF1zDq4zKjyJu8ixBGac8PHJm0p68m4u/SmXywd5j2p1J8oyDSS/JWUhKoH20fD5hXY
	s09qNxQWfFtQ94FjDfJsaYzyZWtVkR6GcfMyYDJPeEdRK6GI+IpyOo4Y22Ws5E5/7+rhSbGX4kQ
	==
X-Gm-Gg: ASbGncvAUW+g4Wh+B7xeYyl3nhBp9/CyHiNz2zym5Gm/2OXeQGNhewRuaJPCmWlPjp3
	cJOGsWnoOTZ8YfSTwFGeFpr53Bxaby7kHeQAFkBSf5GG3yxWnMyUJsayLOHsuxTPF9ufVjyLR04
	X4Gjl7joDD0+jJecxBO2M74iuvN1BNDhNqP9t8VwjU4EkLcvJ1VdQQm22S7XhfI6v43TEn0zygi
	422hsmstHRIy9ITgmY3FA26tOmvzo8Tma3qbxrHd6FpgfhSl5Q0w1DMholEDteO6+28qoBmdYr5
	c5WxYU4JEzgICWvtRqxjq3WKsvGntg1Y9yoEU35m5s7XA1zfQk4ryicuUDZlf6tAzW+YdLPGUef
	LMbmBmqD/ZA==
X-Received: by 2002:a05:622a:5517:b0:4b6:5fe:6c93 with SMTP id d75a77b69052e-4ba6b93edf8mr46154841cf.71.1758141027263;
        Wed, 17 Sep 2025 13:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlGMvVwgHD29RYPFfysvvC3axBOmMnRbYIOTl9MRwjES1rh4kgPFl8ORTbFCgeqfT7sqA4yg==
X-Received: by 2002:a05:622a:5517:b0:4b6:5fe:6c93 with SMTP id d75a77b69052e-4ba6b93edf8mr46154371cf.71.1758141026753;
        Wed, 17 Sep 2025 13:30:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b4b94sm3199281cf.26.2025.09.17.13.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:30:26 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c3fd1a11-fdba-4dae-a733-435a9296c2e1@redhat.com>
Date: Wed, 17 Sep 2025 16:30:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
To: Frederic Weisbecker <frederic@kernel.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250917161958.178925-1-gmonaco@redhat.com>
 <aMrpiMTzvLW_eR3A@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aMrpiMTzvLW_eR3A@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/17/25 1:02 PM, Frederic Weisbecker wrote:
> Le Wed, Sep 17, 2025 at 06:19:49PM +0200, Gabriele Monaco a écrit :
>> The timer migration mechanism allows active CPUs to pull timers from
>> idle ones to improve the overall idle time. This is however undesired
>> when CPU intensive workloads run on isolated cores, as the algorithm
>> would move the timers from housekeeping to isolated cores, negatively
>> affecting the isolation.
>>
>> Exclude isolated cores from the timer migration algorithm, extend the
>> concept of unavailable cores, currently used for offline ones, to
>> isolated ones:
>> * A core is unavailable if isolated or offline;
>> * A core is available if non isolated and online;
>>
>> A core is considered unavailable as isolated if it belongs to:
>> * the isolcpus (domain) list
>> * an isolated cpuset
>> Except if it is:
>> * in the nohz_full list (already idle for the hierarchy)
>> * the nohz timekeeper core (must be available to handle global timers)
>>
>> CPUs are added to the hierarchy during late boot, excluding isolated
>> ones, the hierarchy is also adapted when the cpuset isolation changes.
>>
>> Due to how the timer migration algorithm works, any CPU part of the
>> hierarchy can have their global timers pulled by remote CPUs and have to
>> pull remote timers, only skipping pulling remote timers would break the
>> logic.
>> For this reason, prevent isolated CPUs from pulling remote global
>> timers, but also the other way around: any global timer started on an
>> isolated CPU will run there. This does not break the concept of
>> isolation (global timers don't come from outside the CPU) and, if
>> considered inappropriate, can usually be mitigated with other isolation
>> techniques (e.g. IRQ pinning).
>>
>> This effect was noticed on a 128 cores machine running oslat on the
>> isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
>> and the CPU with lowest count in a timer migration hierarchy (here 1
>> and 65) appears as always active and continuously pulls global timers,
>> from the housekeeping CPUs. This ends up moving driver work (e.g.
>> delayed work) to isolated CPUs and causes latency spikes:
>>
>> before the change:
>>
>>   # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>>   ...
>>    Maximum:     1203 10 3 4 ... 5 (us)
>>
>> after the change:
>>
>>   # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>>   ...
>>    Maximum:      10 4 3 4 3 ... 5 (us)
>>
>> The same behaviour was observed on a machine with as few as 20 cores /
>> 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
>>
>> The first 5 patches are preparatory work to change the concept of
>> online/offline to available/unavailable, keep track of those in a
>> separate cpumask cleanup the setting/clearing functions and change a
>> function name in cpuset code.
>>
>> Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
>> nohz_full from covering all CPUs not leaving any housekeeping one. This
>> can lead to problems with the changes introduced in this series because
>> no CPU would remain to handle global timers.
>>
>> Patch 9 extends the unavailable status to domain isolated CPUs, which
>> is the main contribution of the series.
>>
>> Changes since v12:
>> * Pick and adapt patch by Yury Norov to initialise cpumasks
>> * Reorganise accesses to tmigr_available_cpumask to avoid races
>>
>> Changes since v11:
>> * Rename isolcpus_nohz_conflict() to isolated_cpus_can_update()
>> * Move tick_nohz_cpu_hotpluggable() check to tmigr_is_isolated()
>> * Use workqueues in tmigr_isolated_exclude_cpumask() to avoid sleeping
>>    while atomic
>> * Add cpumask initialiser to safely use cpumask cleanup helpers
>>
>> Changes since v10:
>> * Simplify housekeeping conflict condition
>> * Reword commit (Frederic Weisbecker)
>>
>> Changes since v9:
>> * Fix total housekeeping enforcement to focus only on nohz and domain
>> * Avoid out of bound access in the housekeeping array if no flag is set
>> * Consider isolated_cpus while checking for nohz conflicts in cpuset
>> * Improve comment about why nohz CPUs are not excluded by tmigr
>>
>> Changes since v8 [1]:
>> * Postpone hotplug registration to late initcall (Frederic Weisbecker)
>> * Move main activation logic in _tmigr_set_cpu_available() and call it
>>    after checking for isolation on hotplug and cpusets changes
>> * Call _tmigr_set_cpu_available directly to force enable tick CPU if
>>    required (this saves checking for that on every hotplug change).
>>
>> Changes since v7:
>> * Move tmigr_available_cpumask out of tmc lock and specify conditions.
>> * Initialise tmigr isolation despite the state of isolcpus.
>> * Move tick CPU check to condition to run SMP call.
>> * Fix descriptions.
>>
>> Changes since v6 [2]:
>> * Prevent isolation checks from running during early boot
>> * Prevent double (de)activation while setting cpus (un)available
>> * Use synchronous smp calls from the isolation path
>> * General cleanup
>>
>> Changes since v5:
>> * Remove fallback if no housekeeping is left by isolcpus and nohz_full
>> * Adjust condition not to activate CPUs in the migration hierarchy
>> * Always force the nohz tick CPU active in the hierarchy
>>
>> Changes since v4 [3]:
>> * use on_each_cpu_mask() with changes on isolated CPUs to avoid races
>> * keep nohz_full CPUs included in the timer migration hierarchy
>> * prevent domain isolated and nohz_full to cover all CPUs
>>
>> Changes since v3:
>> * add parameter to function documentation
>> * split into multiple straightforward patches
>>
>> Changes since v2:
>> * improve comments about handling CPUs isolated at boot
>> * minor cleanup
>>
>> Changes since v1 [4]:
>> * split into smaller patches
>> * use available mask instead of unavailable
>> * simplification and cleanup
>>
>> [1] - https://lore.kernel.org/lkml/20250714133050.193108-9-gmonaco@redhat.com
>> [2] - https://lore.kernel.org/lkml/20250530142031.215594-1-gmonaco@redhat.com
>> [3] - https://lore.kernel.org/lkml/20250506091534.42117-7-gmonaco@redhat.com
>> [4] - https://lore.kernel.org/lkml/20250410065446.57304-2-gmonaco@redhat.com
>>
>> Frederic Weisbecker (1):
>>    timers/migration: Postpone online/offline callbacks registration to
>>      late initcall
>>
>> Gabriele Monaco (7):
>>    timers: Rename tmigr 'online' bit to 'available'
>>    timers: Add the available mask in timer migration
>>    timers: Use scoped_guard when setting/clearing the tmigr available
>>      flag
>>    cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to
>>      update_exclusion_cpumasks()
>>    sched/isolation: Force housekeeping if isolcpus and nohz_full don't
>>      leave any
>>    cgroup/cpuset: Fail if isolated and nohz_full don't leave any
>>      housekeeping
>>    timers: Exclude isolated cpus from timer migration
>>
>> Yury Norov (1):
>>    cpumask: Add initialiser to use cleanup helpers
>>
>>   include/linux/cpumask.h                |   2 +
>>   include/linux/timer.h                  |   9 ++
>>   include/trace/events/timer_migration.h |   4 +-
>>   kernel/cgroup/cpuset.c                 |  78 +++++++++-
>>   kernel/sched/isolation.c               |  23 +++
>>   kernel/time/timer_migration.c          | 205 ++++++++++++++++++++-----
>>   kernel/time/timer_migration.h          |   2 +-
>>   7 files changed, 278 insertions(+), 45 deletions(-)
>>
>>
>> base-commit: 320475fbd590dc94a0a3d9173f81e0797ee1a232
> So what is the best way to route this? Timers or cgroups tree?

As the majority of the code changes are in timers code, it will be 
better to route through the timers tree. BTW, this patch set will have 
some minor conflict with the current cgroup/for-6.18 branch, that should 
be easily resolved.

Cheers,
Longman


