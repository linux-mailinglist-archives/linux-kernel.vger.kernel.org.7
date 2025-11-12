Return-Path: <linux-kernel+bounces-897790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11844C53C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41F6A548656
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093BA3446A9;
	Wed, 12 Nov 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHIaYFFR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16934026B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966749; cv=none; b=BpUO6aLVqAOedUYIEOQ1lL+Ev0k7ZHwlprsDd9RkrCovGrFY8pSdHKkOkMaL/GfeMWxIq0GR/6QhMDT7ZG8GY+78XfASyiTlZEe0GyC3Ht53aKQjGHrZuUOdxi7JgV1yHc0mvGHq/IZZeHZ9eNljaA89PEHSQwxEOSSWPq/uVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966749; c=relaxed/simple;
	bh=Gtw8WnjiQ67IbQYdWWT5PAdlDPwEe6AHPvauYraz+/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9wah4KF/yWKHrmA0nAViZCeCut8QhDdLDvzQUiA30chYJYf+9sXwVZBez4qecj9n8DZnTrIZpBcZVI21IYqHmKaKCA1a+b20iR9CQGGpYR6iivK1eP6tIAeVfWpfAqV/IgzOOMM4Ubt1s7wd0Id0m6kRl6sxdas+CxaTo2t9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHIaYFFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9B5C16AAE;
	Wed, 12 Nov 2025 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762966746;
	bh=Gtw8WnjiQ67IbQYdWWT5PAdlDPwEe6AHPvauYraz+/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHIaYFFRxH+SLA7aR/j1RlGT5cUtaYdHPJCiGhtbRfOBG1WX1wIUsJ4OUDRoHQajY
	 brSSiKwINFXFDAjomKiE7aI232Q2LGA1d0qcjmMd10mVS3bUUBIbQ9fWjDfnlU1BQw
	 KJophXCKauDu7I40QVjE5177KPjd0XjurahbnThngRTsTXyrVB7oeGorVu8cPZaZD0
	 GjiuFDaKfUjga5M2IvUim72qiqvV/wDoIONNG+NwvsjTrXtn5mgwOnyQ8HMNSusRML
	 LSFo4X1dzEj4aPy9u7iisBiditG+ap2dRx/lBCSw9ieVehgjuiIaarWph2bF8CKh21
	 7BPmfmsNFUC3A==
Date: Wed, 12 Nov 2025 17:59:04 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <llong@redhat.com>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	"John B . Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v14 7/7] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aRS82LMOQZ-u92NZ@localhost.localdomain>
References: <20251104104740.70512-1-gmonaco@redhat.com>
 <20251104104740.70512-8-gmonaco@redhat.com>
 <aRSv-kcSj5kc6CJ9@localhost.localdomain>
 <446f97f9663c1bda011d4171d17f1470d21fb7df.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <446f97f9663c1bda011d4171d17f1470d21fb7df.camel@redhat.com>

Le Wed, Nov 12, 2025 at 05:18:26PM +0100, Gabriele Monaco a écrit :
> 
> 
> On Wed, 2025-11-12 at 17:04 +0100, Frederic Weisbecker wrote:
> > Le Tue, Nov 04, 2025 at 11:47:39AM +0100, Gabriele Monaco a écrit :
> > 
> > 
> > This duplicates a lot tmigr_isolated_exclude_cpumask().
> > Would this work?
> > 
> > static int __init tmigr_init_isolation(void)
> > {
> > 	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
> > 
> > 	static_branch_enable(&tmigr_exclude_isolated);
> > 
> > 	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
> > 		return 0;
> > 	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> > 		return -ENOMEM;
> > 
> > 	cpumask_andnot(cpumask, cpu_possible_mask,
> > housekeeping_cpumask(HK_TYPE_DOMAIN));
> > 
> > 	return tmigr_isolated_exclude_cpumask(cpumask);
> > }
> > 
> > If so please add my Reviewed-by to the next version.
> 
> Good point, it should work, I'm going to test it tomorrow.
> 
> What comes to my mind is that tmigr_isolated_exclude_cpumask expects the hotplug
> lock to be held, so I should probably just hold it before calling it:
> 
> static int __init tmigr_init_isolation(void)
> {
> 	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
> 
> 	static_branch_enable(&tmigr_exclude_isolated);
> 
> 	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
> 		return 0;
> 	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> 		return -ENOMEM;
> 
> 	cpumask_andnot(cpumask, cpu_possible_mask,
> housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	guard(cpus_read_lock)();
> 	return tmigr_isolated_exclude_cpumask(cpumask);
> }

Well it doesn't make much sense to lock hotplug at this stage.

How about:

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index e2f9a4637d7b..6ca870f1b951 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1539,17 +1539,7 @@ static void tmigr_cpu_unisolate(struct work_struct *ignored)
 	tmigr_set_cpu_available(smp_processor_id());
 }
 
-/**
- * tmigr_isolated_exclude_cpumask - Exclude given CPUs from hierarchy
- * @exclude_cpumask: the cpumask to be excluded from timer migration hierarchy
- *
- * This function can be called from cpuset code to provide the new set of
- * isolated CPUs that should be excluded from the hierarchy.
- * Online CPUs not present in exclude_cpumask but already excluded are brought
- * back to the hierarchy.
- * Functions to isolate/unisolate need to be called locally and can sleep.
- */
-int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
+static int __tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
 {
 	struct work_struct __percpu *works __free(free_percpu) =
 		alloc_percpu(struct work_struct);
@@ -1557,8 +1547,6 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
 	cpumask_var_t cpumask_isol __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	int cpu;
 
-	lockdep_assert_cpus_held();
-
 	if (!alloc_cpumask_var(&cpumask_isol, GFP_KERNEL))
 		return -ENOMEM;
 	if (!alloc_cpumask_var(&cpumask_unisol, GFP_KERNEL))
@@ -1604,40 +1592,36 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
 	return 0;
 }
 
+/**
+ * tmigr_isolated_exclude_cpumask - Exclude given CPUs from hierarchy
+ * @exclude_cpumask: the cpumask to be excluded from timer migration hierarchy
+ *
+ * This function can be called from cpuset code to provide the new set of
+ * isolated CPUs that should be excluded from the hierarchy.
+ * Online CPUs not present in exclude_cpumask but already excluded are brought
+ * back to the hierarchy.
+ * Functions to isolate/unisolate need to be called locally and can sleep.
+ */
+int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
+{
+	lockdep_assert_cpus_held();
+	return __tmigr_isolated_exclude_cpumask(exclude_cpumask);
+}
+
 static int __init tmigr_init_isolation(void)
 {
-	struct work_struct __percpu *works __free(free_percpu) =
-		alloc_percpu(struct work_struct);
 	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
-	int cpu;
 
 	static_branch_enable(&tmigr_exclude_isolated);
+
 	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
 		return 0;
 	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
 		return -ENOMEM;
-	if (!works)
-		return -ENOMEM;
-	cpumask_andnot(cpumask, tmigr_available_cpumask,
-		       housekeeping_cpumask(HK_TYPE_DOMAIN));
-	cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
-	/* Never disable the tick CPU, see tmigr_is_isolated for details */
-	for_each_cpu(cpu, cpumask) {
-		if (!tick_nohz_cpu_hotpluggable(cpu)) {
-			cpumask_clear_cpu(cpu, cpumask);
-			break;
-		}
-	}
-	for_each_cpu(cpu, cpumask) {
-		struct work_struct *work = per_cpu_ptr(works, cpu);
 
-		INIT_WORK(work, tmigr_cpu_isolate);
-		schedule_work_on(cpu, work);
-	}
-	for_each_cpu(cpu, cpumask)
-		flush_work(per_cpu_ptr(works, cpu));
+	cpumask_andnot(cpumask, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
-	return 0;
+	return __tmigr_isolated_exclude_cpumask(cpumask);
 }
 
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,

