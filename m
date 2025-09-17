Return-Path: <linux-kernel+bounces-821378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7460B81195
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B6316EAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E92FB635;
	Wed, 17 Sep 2025 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4FFPYB+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0062F7AB1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128524; cv=none; b=dITRsb3xeNRU1m9US4wv1bqFrfJEMk+73dCR26uTGFOHNHps5XcDqy+eBHRbF4S5G0DyrEDtwxIKB7JVA5hQ2EXjM6SOmREcI+jEBspRUq/eMfKUH6S54byvrxhwd+MOUKfmIJ8nhg7efzECUNfCnV08YehkLGUlNW773N/1pTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128524; c=relaxed/simple;
	bh=KiS/9oO2llifD17emDEwPJHpkWwnjkTWX1OPZ0anfqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbElyzQIl2Tfwp4XCEQUWu7phVlQWuO/EHK6oI0ZzxKb/kKX6Fe3eX6x0rrdLzdcS/SeUwy3k1lMZn7CForwUtROepOFVs3BecXNvgByn4KWR8UA+v0uJH5W1vTjxdhVu3UA0FdMfNiWnKP7yDKV5ThAiJ/2DhyXRTbl4vdfiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4FFPYB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DA1C4CEE7;
	Wed, 17 Sep 2025 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758128524;
	bh=KiS/9oO2llifD17emDEwPJHpkWwnjkTWX1OPZ0anfqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4FFPYB+zECbZXPvxHQidHtOcTsR+dZOmIhqoent65+yTz1nSPXJlC9zDEGmbCpfd
	 uYdv3DnTGAXSJbzaf7iw8f17uHHu14EzgIskvhtL4jt/l5hYlBqdOoospl0xHEjHjg
	 k+raAH8yPPm+D6tVb5XZFtaKPhyZyWYO40UszteC6dlbQq/f0UwHhqSgpWzGdbHo+q
	 HV0nAPH7u3739an4X389PMQ2UtOWmeI2iyRWavNyOteLgG2c1eCXS1Vp/VsQ7dI/Hu
	 oJrnnBYD8ykLYrGcQmuJcnJ3udmLGdIDvkjFgeqCcg6sJoNfR2yLvwikDbYfwVvfvi
	 XY3s0GsKA+rvQ==
Date: Wed, 17 Sep 2025 19:02:00 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aMrpiMTzvLW_eR3A@localhost.localdomain>
References: <20250917161958.178925-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917161958.178925-1-gmonaco@redhat.com>

Le Wed, Sep 17, 2025 at 06:19:49PM +0200, Gabriele Monaco a écrit :
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
>  # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>  ...
>   Maximum:     1203 10 3 4 ... 5 (us)
> 
> after the change:
> 
>  # oslat -c 1-31,33-63,65-95,97-127 -D 62s
>  ...
>   Maximum:      10 4 3 4 3 ... 5 (us)
> 
> The same behaviour was observed on a machine with as few as 20 cores /
> 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
> 
> The first 5 patches are preparatory work to change the concept of
> online/offline to available/unavailable, keep track of those in a
> separate cpumask cleanup the setting/clearing functions and change a
> function name in cpuset code.
> 
> Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
> nohz_full from covering all CPUs not leaving any housekeeping one. This
> can lead to problems with the changes introduced in this series because
> no CPU would remain to handle global timers.
> 
> Patch 9 extends the unavailable status to domain isolated CPUs, which
> is the main contribution of the series.
> 
> Changes since v12:
> * Pick and adapt patch by Yury Norov to initialise cpumasks
> * Reorganise accesses to tmigr_available_cpumask to avoid races
> 
> Changes since v11:
> * Rename isolcpus_nohz_conflict() to isolated_cpus_can_update()
> * Move tick_nohz_cpu_hotpluggable() check to tmigr_is_isolated()
> * Use workqueues in tmigr_isolated_exclude_cpumask() to avoid sleeping
>   while atomic
> * Add cpumask initialiser to safely use cpumask cleanup helpers
> 
> Changes since v10:
> * Simplify housekeeping conflict condition
> * Reword commit (Frederic Weisbecker)
> 
> Changes since v9:
> * Fix total housekeeping enforcement to focus only on nohz and domain
> * Avoid out of bound access in the housekeeping array if no flag is set
> * Consider isolated_cpus while checking for nohz conflicts in cpuset
> * Improve comment about why nohz CPUs are not excluded by tmigr
> 
> Changes since v8 [1]:
> * Postpone hotplug registration to late initcall (Frederic Weisbecker)
> * Move main activation logic in _tmigr_set_cpu_available() and call it
>   after checking for isolation on hotplug and cpusets changes
> * Call _tmigr_set_cpu_available directly to force enable tick CPU if
>   required (this saves checking for that on every hotplug change).
> 
> Changes since v7:
> * Move tmigr_available_cpumask out of tmc lock and specify conditions.
> * Initialise tmigr isolation despite the state of isolcpus.
> * Move tick CPU check to condition to run SMP call.
> * Fix descriptions.
> 
> Changes since v6 [2]:
> * Prevent isolation checks from running during early boot
> * Prevent double (de)activation while setting cpus (un)available
> * Use synchronous smp calls from the isolation path
> * General cleanup
> 
> Changes since v5:
> * Remove fallback if no housekeeping is left by isolcpus and nohz_full
> * Adjust condition not to activate CPUs in the migration hierarchy
> * Always force the nohz tick CPU active in the hierarchy
> 
> Changes since v4 [3]:
> * use on_each_cpu_mask() with changes on isolated CPUs to avoid races
> * keep nohz_full CPUs included in the timer migration hierarchy
> * prevent domain isolated and nohz_full to cover all CPUs
> 
> Changes since v3:
> * add parameter to function documentation
> * split into multiple straightforward patches
> 
> Changes since v2:
> * improve comments about handling CPUs isolated at boot
> * minor cleanup
> 
> Changes since v1 [4]:
> * split into smaller patches
> * use available mask instead of unavailable
> * simplification and cleanup
> 
> [1] - https://lore.kernel.org/lkml/20250714133050.193108-9-gmonaco@redhat.com
> [2] - https://lore.kernel.org/lkml/20250530142031.215594-1-gmonaco@redhat.com
> [3] - https://lore.kernel.org/lkml/20250506091534.42117-7-gmonaco@redhat.com
> [4] - https://lore.kernel.org/lkml/20250410065446.57304-2-gmonaco@redhat.com
> 
> Frederic Weisbecker (1):
>   timers/migration: Postpone online/offline callbacks registration to
>     late initcall
> 
> Gabriele Monaco (7):
>   timers: Rename tmigr 'online' bit to 'available'
>   timers: Add the available mask in timer migration
>   timers: Use scoped_guard when setting/clearing the tmigr available
>     flag
>   cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to
>     update_exclusion_cpumasks()
>   sched/isolation: Force housekeeping if isolcpus and nohz_full don't
>     leave any
>   cgroup/cpuset: Fail if isolated and nohz_full don't leave any
>     housekeeping
>   timers: Exclude isolated cpus from timer migration
> 
> Yury Norov (1):
>   cpumask: Add initialiser to use cleanup helpers
> 
>  include/linux/cpumask.h                |   2 +
>  include/linux/timer.h                  |   9 ++
>  include/trace/events/timer_migration.h |   4 +-
>  kernel/cgroup/cpuset.c                 |  78 +++++++++-
>  kernel/sched/isolation.c               |  23 +++
>  kernel/time/timer_migration.c          | 205 ++++++++++++++++++++-----
>  kernel/time/timer_migration.h          |   2 +-
>  7 files changed, 278 insertions(+), 45 deletions(-)
> 
> 
> base-commit: 320475fbd590dc94a0a3d9173f81e0797ee1a232

So what is the best way to route this? Timers or cgroups tree?

Thanks.

> -- 
> 2.51.0
> 

-- 
Frederic Weisbecker
SUSE Labs

