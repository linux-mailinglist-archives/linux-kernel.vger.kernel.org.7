Return-Path: <linux-kernel+bounces-836368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D63BA9805
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87610192186C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0F305E19;
	Mon, 29 Sep 2025 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hU1tJsoQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B013064AA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154994; cv=none; b=nR7bYjkgGsHQ4nkjGaQsYvIQd38OkBJqh1K6ykLRToFdQ/jfk1Mh3c15CKaCQAHm+AmS+cbYGAefWVj5VpTHEgaFjscehcS7lcWT1mjU4NOHV0eP5Qosv5gNQYwIl8j3HNK0D7nqoEp5A0oWstQvwR/gRG7v5Ha4NwUn9Ocx7PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154994; c=relaxed/simple;
	bh=LOlZZge0meAaNA7/sV76IApYacLdhdMN0LsoJkQo3xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr6Y5MCEWERA+5ZUoEAxNZjezStxcGtn/lMHUr0qS4N4W0dpu7s3JQxqRZHgn9KV+QQWQ+1KOrVpVUoBp9WNLmmgqZeHPPX8S0zxX88y92IeDsM6ZojZzY/8YN5CPuh9iRrIApkvbTfMcrCoVupjEPcvn3VgIZoTo0/G+27ZVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hU1tJsoQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=euPO9jWmT5Hq8XFMM6BdYYsoQVvkSkQm2Hgnlq9vzKk=; b=hU1tJsoQpzMIbKpAAV4K+WCM8w
	ZAPyaSKVS9tsK2xLYHqctXI5G08bJ8WDDCC+Y2p727AmwhchPUPSuMb03GMoadAuLWrYWDXrO3Tt1
	c434nOO6SRJvbFsZpX2VQuK+MeyEEx9APaJDrwI7YkCWBjzWnWR37zud66J471zZ+Aq8tcD9zWmJJ
	Nwh83PRk7iybR1WuiJsESCPOvE956vfGDwGuI7gA86/wNCzTpLSJdm4iRoAYtIjq46FtzjjgZE8as
	+g37T2qNcc+Dik5X/Vul8ak2Agnmzv71eafOAUsVDp93iKNcIREGxeP5ntdH8ZzJdvASdxTqrkAiU
	Xf9MPPGw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3EZ6-000000041Hv-1Ylv;
	Mon, 29 Sep 2025 14:09:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 800CF300359; Mon, 29 Sep 2025 16:09:20 +0200 (CEST)
Date: Mon, 29 Sep 2025 16:09:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Libo Chen <libo.chen@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 06/28] sched: Save the per LLC utilization for
 better cache aware scheduling
Message-ID: <20250929140920.GN3419281@noisy.programming.kicks-ass.net>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <d77d4db175adc09cd01fdee097c16bc3e52c8be2.1754712565.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77d4db175adc09cd01fdee097c16bc3e52c8be2.1754712565.git.tim.c.chen@linux.intel.com>

On Sat, Aug 09, 2025 at 01:02:54PM +0800, Chen Yu wrote:

> +#ifdef CONFIG_SCHED_CACHE
> +/*
> + * Save this sched group's statistic for later use:
> + * The task wakeup and load balance can make better
> + * decision based on these statistics.
> + */
> +static void update_sg_if_llc(struct lb_env *env, struct sg_lb_stats *sgs,
> +			     struct sched_group *group)
> +{
> +	/* Find the sched domain that spans this group. */
> +	struct sched_domain *sd = env->sd->child;
> +	struct sched_domain_shared *sd_share;
> +
> +	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE)
> +		return;
> +
> +	/* only care the sched domain that spans 1 LLC */
> +	if (!sd || !(sd->flags & SD_SHARE_LLC) ||
> +	    !sd->parent || (sd->parent->flags & SD_SHARE_LLC))
> +		return;

Did you want to write:

	if (sd != per_cpu(sd_llc))
		return;

Or something?

> +	sd_share = rcu_dereference(per_cpu(sd_llc_shared,
> +				  cpumask_first(sched_group_span(group))));
> +	if (!sd_share)
> +		return;
> +
> +	if (likely(READ_ONCE(sd_share->util_avg) != sgs->group_util))
> +		WRITE_ONCE(sd_share->util_avg, sgs->group_util);

If you expect it to be different, does that whole load and compare still
matter?

> +}

