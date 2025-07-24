Return-Path: <linux-kernel+bounces-745061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053CBB11453
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93B51C20912
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D3223BCF1;
	Thu, 24 Jul 2025 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbB10xXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCA223336
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753398356; cv=none; b=aSv23W6nzcZQzIfE2mibIX4xHXlyq2jfM0W9jj0N9ulRGAmNWzLs559iGw/8YcIZ+Uy8q2Ibmxs16aUoO4PQ/AhNOZkeCNrcw+jyjfDfkaMHJocQT0al5I5IXY0GjXJY4bS97+ytxfONaJuiUXTAe5tmLpkHn4ns1CkFDE6nKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753398356; c=relaxed/simple;
	bh=bwlCmZDub3rNysUebRkTD9K6cse7Y8U+BJ89vVoxRnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyyRCcdFdR7M1Hz2E+stPmUGsvoh+NXDolihmakiE4sRnlMgcnNTClrDwZmS7sPO8YwS8zz/1akiJwBYtC9USAY3coMOac3Ygnce1btB+xR4DEorih12Tu+RP62jbjnXIDklltMALACTlS/Uljxb5rex53no85+rPS7uS20Qk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbB10xXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5A7C4CEED;
	Thu, 24 Jul 2025 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753398355;
	bh=bwlCmZDub3rNysUebRkTD9K6cse7Y8U+BJ89vVoxRnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KbB10xXIGws9uZ4LK+MQIlacJzjvRTB/j+UXRtb1zRP01IGOCGMePQjmrG4sqpEBO
	 2/fyJE4rQP4gttWpEHXEJ12AZV1dFeK31+WvEm5CZtwSAzQP5WpZSdb9sP9s4qFN0X
	 7/bnpUYapJ+Z/kwXLtRSgbKKZ9xNFBBHSfZn9Z5AU08T/R1v1hLzOe+5gV6R1hkAx+
	 awqGq9jU68+DfTny0MMThB2NJxbiLAA555Dd4FEuVy76g65chNQaEB2GKjB+7SHebV
	 m9E8DmssqRJM7l1Sf0stobnF1xBbNX+L/AJ3v7hxXagD1WHwW2ZjURYduLRGWNNG/i
	 B6gYMWNqSNolg==
Date: Fri, 25 Jul 2025 01:05:52 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 7/7] timers: Exclude isolated cpus from timer migration
Message-ID: <aIK8UFz3A7hNc1sq@pavilion.home>
References: <20250714133050.193108-9-gmonaco@redhat.com>
 <20250714133050.193108-16-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714133050.193108-16-gmonaco@redhat.com>

Le Mon, Jul 14, 2025 at 03:30:58PM +0200, Gabriele Monaco a écrit :
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> index 878fd3af40ecb..c07cc9a2b209d 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -10,6 +10,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/timerqueue.h>
>  #include <trace/events/ipi.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "timer_migration.h"
>  #include "tick-internal.h"
> @@ -428,6 +429,9 @@ static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
>   */
>  static cpumask_var_t tmigr_available_cpumask;
>  
> +/* Enabled during late initcall */
> +static bool tmigr_exclude_isolated __read_mostly;

This variable is still annoying.

> +
>  #define TMIGR_NONE	0xFF
>  #define BIT_CNT		8
[...]  
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
> +static int __init tmigr_init_isolation(void)
> +{
> +	cpumask_var_t cpumask;
> +
> +	tmigr_exclude_isolated = true;
> +	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
> +		return 0;
> +	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> +		return -ENOMEM;
> +	cpumask_andnot(cpumask, tmigr_available_cpumask,
> +		       housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
> +	on_each_cpu_cond_mask(tmigr_should_isolate_cpu, tmigr_cpu_isolate, NULL,
> +			      1, cpumask);

And this is basically repeating the same logic as before but in reverse.

Here is a proposal: register the online/offline callbacks later, on
late_initcall(). This solves two problems:

1) The online/offline callbacks are called for the first time in the right
   place. You don't need that tmigr_exclude_isolated anymore.

2) You don't need to make the on_each_cpu_cond_mask() call anymore in
   tmigr_init_isolation(). In fact you don't need that function. The
   online/offline callbacks already take care of everything.

Here is a patch you can use (only built tested):

commit ad21e35e05865e2d37a60bf5d77b0d6fa22a54ee
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Fri Jul 25 00:06:20 2025 +0200

    timers/migration: Postpone online/offline callbacks registration to late initcall
    
    During the early boot process, the default clocksource used for
    timekeeping is the jiffies. Better clocksources can only be selected
    once clocksource_done_booting() is called as an fs initcall.
    
    NOHZ can only be enabled after that stage, making global timer migration
    irrelevant up to that point.
    
    Therefore, don't bother with trashing the cache within that tree from
    the SMP bootup until NOHZ even matters.
    
    Make the CPUs available to the tree on late initcall, after the right
    clocksource had a chance to be selected. This will also simplify the
    handling of domain isolated CPUs on further patches.
    
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 2f6330831f08..f730107d948d 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1484,6 +1484,17 @@ static int tmigr_cpu_online(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * NOHZ can only be enabled after clocksource_done_booting(). Don't
+ * bother trashing the cache in the tree before.
+ */
+static int __init tmigr_late_init(void)
+{
+	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
+				 tmigr_cpu_online, tmigr_cpu_offline);
+}
+late_initcall(tmigr_late_init);
+
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 			     int node)
 {
@@ -1846,18 +1857,9 @@ static int __init tmigr_init(void)
 
 	ret = cpuhp_setup_state(CPUHP_TMIGR_PREPARE, "tmigr:prepare",
 				tmigr_cpu_prepare, NULL);
-	if (ret)
-		goto err;
-
-	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
-				tmigr_cpu_online, tmigr_cpu_offline);
-	if (ret)
-		goto err;
-
-	return 0;
-
 err:
-	pr_err("Timer migration setup failed\n");
+	if (ret)
+		pr_err("Timer migration setup failed\n");
 	return ret;
 }
 early_initcall(tmigr_init);

