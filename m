Return-Path: <linux-kernel+bounces-854259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D018DBDDEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B65E500EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3831A548;
	Wed, 15 Oct 2025 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JMRSHNbC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039B306483
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523357; cv=none; b=dGLhQIqLgqvdBmnnsn3c1ngWh8beLyv/ZYiPB1Wl8BVt1v356caXspleslE+DUCeThPlMoXuouRdxfFHFMr/XzX7+vMqlJ5JzsazONWds961S1KUCyU9uBZmBIikP2SxX8m3uc9YIi/20HBu3vNTn5nsndQRTrDzRnJiQP2LEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523357; c=relaxed/simple;
	bh=jHjvZ85Y6I7dh6mXQbmaVN8rVEZrKxN9kGRCBiQPu40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BinwVONGkrb8Xvj3OTFOzmpaGiQRXwGOmZU1dshfudZFqXgYuXEs7Ksj0cJmv32fvthtTiyfemOEoitG2uXxTojhk8ZTG2GRSvNuEWInFzhh4ZG6dtaKADgoQe70xp0xoc02eoI9nFUm1n8x7WPSi+iLFIV2yiMpBFpPfnxC6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JMRSHNbC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=36Yh1lExm9nIuoX4mzPFfc5jagHwMc2PCMwj74Yi0MM=; b=JMRSHNbCt/K2JsRqB80no5j9Nd
	cnQtrRSWsEWrX6+WqDSuyCulhY34ATI106Qsy/FalrXcUyj46CdXoVOt1iR2koyADyTuy1MdARsKA
	9VsMWLDM1NGe303PVqVqkDqD6p5hWfIxEHBY3zd+bTdEZcwtvjHJIqKF6Kfq+qI75S9xrJuEeYrAg
	6Xv9Tw5OPP5bWtnPNuAAiLB6uhvyJGVvoHRct2TIlV03QQhtqcwgrfdhtSomMJwL/bf6+TnXvWr+M
	DpagwNfNMmkXeTCEQDZIuHgpo6zbluYFY8Obh5c3NUsMfkGyBF2bt8jxIZDwS+u/HgB7UbLt/dSHC
	0akq3c4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8yXP-0000000Cxbt-2mlW;
	Wed, 15 Oct 2025 10:15:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6A76530023C; Wed, 15 Oct 2025 12:15:19 +0200 (CEST)
Date: Wed, 15 Oct 2025 12:15:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>, Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/19] sched/fair: Record per-LLC utilization to guide
 cache-aware scheduling decisions
Message-ID: <20251015101519.GN3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <7684e7381c61a2a0d0580790340d4daa5349e48c.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7684e7381c61a2a0d0580790340d4daa5349e48c.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:39AM -0700, Tim Chen wrote:
> +static void record_sg_llc_stats(struct lb_env *env,
> +				struct sg_lb_stats *sgs,
> +				struct sched_group *group)
> +{
> +	/*
> +	 * Find the child domain on env->dst_cpu. This domain
> +	 * is either the domain that spans this group(if the
> +	 * group is a local group), or the sibling domain of
> +	 * this group.
> +	 */
> +	struct sched_domain *sd = env->sd->child;
> +	struct sched_domain_shared *sd_share;
> +
> +	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE)
> +		return;
> +
> +	/* only care about sched domains spanning a LLC */
> +	if (sd != rcu_dereference(per_cpu(sd_llc, env->dst_cpu)))
> +		return;
> +
> +	/*
> +	 * At this point we know this group spans a LLC domain.
> +	 * Record the statistic of this group in its corresponding
> +	 * shared LLC domain.
> +	 */
> +	sd_share = rcu_dereference(per_cpu(sd_llc_shared,
> +					   cpumask_first(sched_group_span(group))));

Isn't this sd->shared ? Or did I loose the plot somewhere?

> +	if (!sd_share)
> +		return;
> +
> +	if (READ_ONCE(sd_share->util_avg) != sgs->group_util)
> +		WRITE_ONCE(sd_share->util_avg, sgs->group_util);
> +
> +	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
> +		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
> +}

