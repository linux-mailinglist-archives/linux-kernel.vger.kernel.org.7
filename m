Return-Path: <linux-kernel+bounces-748013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA20FB13B62
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA813A2DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61D24678A;
	Mon, 28 Jul 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjSpe84k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76676025
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708903; cv=none; b=UUucbQVhz2NYRMpLmOrWHZFi2HU5f3C2Lys31hUTsrIwy7FaEm48INHzJPOpK7Qmdy/M+G3D3AZf8F/5bCWrd7uAEl9GvIxJ7p8ndWwpOalY9DCEwNGA23xmoIe3wAxMza/nV4PtYoccLYLyvAQeIquKfywTPOq5AtgK9c4t0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708903; c=relaxed/simple;
	bh=Z5K7LoM3PLBfN43u3ceVJLJHJwkol93Ka++ZjqIVAlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwEUVjFU9gwQ1ytf/XYrc/EpXvBG+itcH8cefXN3vQT69+esehcukLymyR1GGfe98rFJ1gsvchpwGKWprCmbtWSaqEiJTxiYEpFzcgjyQJbgBLBR3sbftZvh68o6LRktf9055tLy79Np+1dz19HRUzTHE9M1We6ZG9IPP4j6xCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjSpe84k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753708899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37h+OxwY37dFS0xXBKuzWk99em7YV/V2JORPqp4C/mM=;
	b=IjSpe84kPXTkncCvk7z4YaeUtevJQ14BQz+M0yTG5CSmIVia122zV2RT1a5qDi90tNtIbb
	3IZWXmGp8XMK0JuUNoBRanoNKBEt1xvOSyExypyENd8FWJgDU4zwABRFS9XT9ShJ4sly2v
	iAc/WLbeeRAv5YmyDsFlBXs2+7ft754=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-gmqrjnTOMLeTOFo9Av4cxA-1; Mon,
 28 Jul 2025 09:21:36 -0400
X-MC-Unique: gmqrjnTOMLeTOFo9Av4cxA-1
X-Mimecast-MFC-AGG-ID: gmqrjnTOMLeTOFo9Av4cxA_1753708895
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AB7319560B2;
	Mon, 28 Jul 2025 13:21:35 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.177])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57BD61800B6A;
	Mon, 28 Jul 2025 13:21:33 +0000 (UTC)
Date: Mon, 28 Jul 2025 09:21:29 -0400
From: Phil Auld <pauld@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [tip: sched/core] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
Message-ID: <20250728132129.GC11434@pauld.westford.csb>
References: <20250712033407.2383110-2-jstultz@google.com>
 <175266115435.406.15916021190678492115.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175266115435.406.15916021190678492115.tip-bot2@tip-bot2>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jul 16, 2025 at 10:19:14AM -0000 tip-bot2 for John Stultz wrote:
> The following commit has been merged into the sched/core branch of tip:
>

Cool! Good work John.  "That was easy" ;)


Cheers,
Phil

> Commit-ID:     25c411fce735dda29de26f58d3fce52d4824380c
> Gitweb:        https://git.kernel.org/tip/25c411fce735dda29de26f58d3fce52d4824380c
> Author:        John Stultz <jstultz@google.com>
> AuthorDate:    Sat, 12 Jul 2025 03:33:42 
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Mon, 14 Jul 2025 17:16:31 +02:00
> 
> sched: Add CONFIG_SCHED_PROXY_EXEC & boot argument to enable/disable
> 
> Add a CONFIG_SCHED_PROXY_EXEC option, along with a boot argument
> sched_proxy_exec= that can be used to disable the feature at boot
> time if CONFIG_SCHED_PROXY_EXEC was enabled.
> 
> Also uses this option to allow the rq->donor to be different from
> rq->curr.
> 
> Signed-off-by: John Stultz <jstultz@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Link: https://lkml.kernel.org/r/20250712033407.2383110-2-jstultz@google.com
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++-
>  include/linux/sched.h                           | 13 +++++++-
>  init/Kconfig                                    | 12 +++++++-
>  kernel/sched/core.c                             | 29 ++++++++++++++++-
>  kernel/sched/sched.h                            | 12 +++++++-
>  5 files changed, 71 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 07e22ba..00b8357 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6387,6 +6387,11 @@
>  	sa1100ir	[NET]
>  			See drivers/net/irda/sa1100_ir.c.
>  
> +	sched_proxy_exec= [KNL]
> +			Enables or disables "proxy execution" style
> +			solution to mutex-based priority inversion.
> +			Format: <bool>
> +
>  	sched_verbose	[KNL,EARLY] Enables verbose scheduler debug messages.
>  
>  	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 54a9126..f225b6b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1656,6 +1656,19 @@ struct task_struct {
>  	randomized_struct_fields_end
>  } __attribute__ ((aligned (64)));
>  
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +DECLARE_STATIC_KEY_TRUE(__sched_proxy_exec);
> +static inline bool sched_proxy_exec(void)
> +{
> +	return static_branch_likely(&__sched_proxy_exec);
> +}
> +#else
> +static inline bool sched_proxy_exec(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
>  #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index 965699c..24dd42d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -878,6 +878,18 @@ config UCLAMP_BUCKETS_COUNT
>  
>  	  If in doubt, use the default value.
>  
> +config SCHED_PROXY_EXEC
> +	bool "Proxy Execution"
> +	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
> +	depends on !PREEMPT_RT
> +	# Need to investigate how to inform sched_ext of split contexts
> +	depends on !SCHED_CLASS_EXT
> +	# Not particularly useful until we get to multi-rq proxying
> +	depends on EXPERT
> +	help
> +	  This option enables proxy execution, a mechanism for mutex-owning
> +	  tasks to inherit the scheduling context of higher priority waiters.
> +
>  endmenu
>  
>  #
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e9c8bda..dd9f5c0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -119,6 +119,35 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
> +static int __init setup_proxy_exec(char *str)
> +{
> +	bool proxy_enable = true;
> +
> +	if (*str && kstrtobool(str + 1, &proxy_enable)) {
> +		pr_warn("Unable to parse sched_proxy_exec=\n");
> +		return 0;
> +	}
> +
> +	if (proxy_enable) {
> +		pr_info("sched_proxy_exec enabled via boot arg\n");
> +		static_branch_enable(&__sched_proxy_exec);
> +	} else {
> +		pr_info("sched_proxy_exec disabled via boot arg\n");
> +		static_branch_disable(&__sched_proxy_exec);
> +	}
> +	return 1;
> +}
> +#else
> +static int __init setup_proxy_exec(char *str)
> +{
> +	pr_warn("CONFIG_SCHED_PROXY_EXEC=n, so it cannot be enabled or disabled at boot time\n");
> +	return 0;
> +}
> +#endif
> +__setup("sched_proxy_exec", setup_proxy_exec);
> +
>  /*
>   * Debugging: various feature bits
>   *
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ac953fa..e53d0b8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1142,10 +1142,15 @@ struct rq {
>  	 */
>  	unsigned long 		nr_uninterruptible;
>  
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +	struct task_struct __rcu	*donor;  /* Scheduling context */
> +	struct task_struct __rcu	*curr;   /* Execution context */
> +#else
>  	union {
>  		struct task_struct __rcu *donor; /* Scheduler context */
>  		struct task_struct __rcu *curr;  /* Execution context */
>  	};
> +#endif
>  	struct sched_dl_entity	*dl_server;
>  	struct task_struct	*idle;
>  	struct task_struct	*stop;
> @@ -1326,10 +1331,17 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
>  #define raw_rq()		raw_cpu_ptr(&runqueues)
>  
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
> +{
> +	rcu_assign_pointer(rq->donor, t);
> +}
> +#else
>  static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
>  {
>  	/* Do nothing */
>  }
> +#endif
>  
>  #ifdef CONFIG_SCHED_CORE
>  static inline struct cpumask *sched_group_span(struct sched_group *sg);
> 

-- 


