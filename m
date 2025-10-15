Return-Path: <linux-kernel+bounces-854466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67134BDE746
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC12419C41DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5440326D45;
	Wed, 15 Oct 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TWY/yKc4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E13319875
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530997; cv=none; b=uY3cQtpvfdagT+XVcpWKGpDg5UGU9RKaeEwxzDWZsD70b1RgdJCxZWZYPJcVXls8ekN5otwkUFHOgvXCnU2d4eVeP/dsV2Jef4pfZj0/yoUB7gTFyBPWTJoSuD0wmn2lXqVD2IFV0qtx8ysBYuf3ALW/Z2p3mvNoeBhfHwG1reU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530997; c=relaxed/simple;
	bh=yEmXDQ+75BHbSSHmEfOLO+OcyN1K0huQIW3DkWlAKH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nplyih3Dm6M8WZkjuJ72VLWmfMin/W3sM+jzpJK69fZZkfMDVGWi5SaqfHTP/ALg/IXmAsytWrovzl4Zm27T2msyZRG/5ChMeI2O7O5DyFaRJgMf9dFUDa+x5ik+Smg+W9k+Xf09pHM5vGftyWHLPFZVNo4XZU0h1wv4HN3Gf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TWY/yKc4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uNnFg6eheNxTE//U1kIuIsW10sP0wWUAIllUbta/2EM=; b=TWY/yKc4eW9ux6A4jmCCNg9Pln
	9fM4F17JFosZLLN3YfqXKAXI2oUZe0DVxpvnI1nnxnz0slQvpyfdv0dS+cYcBXakozfPgeRnCwFlh
	/ZJCYQ2MRwFg36CIFhTOHfnIVNq5ueVhKHofkzZ736b7KL9ysM8o1ZQ+qqsZX0tjYG5GGQ01RUBTo
	jy+RqcUon2NYEfNTLGFHFGrAmWhl2MqdaFjcY0/UGzr7eEanpxCvsf8Q4svcTNj3zBR4RFoQmdosu
	NdRbikXnbw0EEt8OVy7T2psLITZ2bU2WyNiYHw4M08rCFaydM+DRW8W4JUSCpri6bRSEPrh/Fl33e
	tq8nam9A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v90Wh-0000000F2cG-0ggq;
	Wed, 15 Oct 2025 12:22:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EFB18300325; Wed, 15 Oct 2025 14:22:43 +0200 (CEST)
Date: Wed, 15 Oct 2025 14:22:43 +0200
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
Subject: Re: [PATCH 09/19] sched/fair: Count tasks prefering each LLC in a
 sched group
Message-ID: <20251015122243.GV3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <00e5f2cb6eadc3738e33858d3c4563a0775ee1c0.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e5f2cb6eadc3738e33858d3c4563a0775ee1c0.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:46AM -0700, Tim Chen wrote:
> During LLC load balancing, tabulate the number of tasks on each runqueue
> that prefer a given destination LLC in a sched group.
> 
> For example, consider a system with 4 LLC sched groups (LLC0 to LLC3)
> balancing towards LLC3. LLC0 has 3 tasks preferring LLC3, LLC1 has
> 2, and LLC2 has 1. LLC0, having the most tasks preferring LLC3, is
> selected as the busiest source to pick tasks from.
> 
> Within a source LLC, the total number of tasks preferring a destination
> LLC is computed by summing counts across all CPUs in that runqueue. For
> instance, if LLC0 has CPU0 with 2 tasks and CPU1 with 1 task preferring
> LLC3, the total for LLC0 is 3.
> 
> These statistics allow the load balancer to choose tasks from source
> sched groups that best match their preferred LLCs.
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b7a68fe7601b..cbd1e97bca4b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10399,6 +10399,9 @@ struct sg_lb_stats {
>  	unsigned int nr_numa_running;
>  	unsigned int nr_preferred_running;
>  #endif
> +#ifdef CONFIG_SCHED_CACHE
> +	unsigned int nr_pref_llc[NR_LLCS];
> +#endif
>  };

Hahahaha, no! We have this on-stack, this cannot be.

