Return-Path: <linux-kernel+bounces-854744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D349BBDF49A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8D13A613B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684972D839E;
	Wed, 15 Oct 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DRWvjIFv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2782F23D7FD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541034; cv=none; b=U/bNkwSO7r+wKqy7CDv24qMtmZ9SXdP5NTePez0sAgfznOnthJQRWkzGtt9LqM9OT8GBFXUgHfWwECN386SaDHByEn/ApZM1nTZ0B4hypZfS1Tyt7MltI0kuDUx6mD2RMYcjhCc3Ge4be/eR3U4Sbx048cnPlFtpM8XbPOZelGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541034; c=relaxed/simple;
	bh=f14PWbULMh4v8PUO7qDTRoj0XcDJtts3b8JSLTkxNg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxTw3y6xhYjO8UgmwevJ/tqMeOW+UjZc0tSe30TMDzI8DTk9w2zzaM5E/gRgeCIa2ryNMQw9r5yJsTyCwyrH6WrLTOJjQfeXkUwY94PVNdjAMh2jT76mwoHkPeWd7pLuTfpEbm1bTIXesJA2COzyMYd4QyXaMewEcPg+0wVsdAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DRWvjIFv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4wgEq49IB0uLqTXuKXqfa6en+AWfDLw0/Bbku+CO7No=; b=DRWvjIFvOw33hFMjIZ8ue3UWJB
	y3SMtHZmVBT3TfYfuPh0yAvX5mkvYFkV8w1hpa2d45NXyQJE639C6EBuJBCjJta0ACnLLRSRnQmoR
	4izR3OMsXd5Slr3GXrWjki2yUiw3yq0orD3WXBnGBq11ZFDJNoMNiqwIe1/xQJ3F4xtT7ZBtfSFaS
	M6Mx4ThybAPzmTtonLcirCKQR6cXBSvlCFHqFEcxV3oZUL30TrV6+ifALukRETGSyyUWrx2TzAZ3V
	JrM9UNWw+pj4/R6ijZdttMrjnd0v1esEhE9OgjX3NzSFkBt0bde4Mqv1wJRtqgPZxGwFROg3b/p6v
	TZzpXtKA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v938e-00000000cPL-3SrN;
	Wed, 15 Oct 2025 15:10:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CEE5300325; Wed, 15 Oct 2025 17:10:05 +0200 (CEST)
Date: Wed, 15 Oct 2025 17:10:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
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
	Chen Yu <yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring
 destination LLC during balancing
Message-ID: <20251015151005.GC3168635@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:47AM -0700, Tim Chen wrote:

> +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats *sgs,
> +			       struct sched_group *group)
> +{
> +	struct sched_domain *child = env->sd->child;
> +	int llc;
> +
> +	if (!sched_cache_enabled())
> +		return false;
> +
> +	if (env->sd->flags & SD_SHARE_LLC)
> +		return false;
> +
> +	/* only care about task migration among LLCs */
> +	if (child && !(child->flags & SD_SHARE_LLC))
> +		return false;
> +
> +	llc = llc_idx(env->dst_cpu);
> +	if (sgs->nr_pref_llc[llc] > 0 &&

Robot says llc can be -1 here, and it don't like doing out of bound
array access.

> +	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) == mig_llc)
> +		return true;
> +
> +	return false;
> +}

