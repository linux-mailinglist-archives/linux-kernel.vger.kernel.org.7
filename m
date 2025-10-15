Return-Path: <linux-kernel+bounces-854368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F89BDE30C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1391E4FD158
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6B31D732;
	Wed, 15 Oct 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vsgeN1IY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79431CA5D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526326; cv=none; b=C3Grxrwb89wN5KmqsvMpuuusQbtJf1lHAInPkQryLitm1DVqbhrdk9Sf0exEZwUh/yNpulVgeLTHqm25/jP4pM2ZGepexdg2Qt2dkaL71TS3eSYUIlpgtATlHnNHsBLLXPvRHUfVV+Yu/FAum3qZSRU2rBGtE7zFOhrIxv+YA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526326; c=relaxed/simple;
	bh=KzMF7YkciNiC8p7nFrbf2FBOGDw1hL98Ebf6ruBYK/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg+alSjITnYQOkYtqdViW4jubo0X8PJL7P+EbsJ1PJwgik4rATbCLdn7V6eM3WcYzE6boTxBGtT3B+4CQ6/Zy8J6936XBaBUU97weEOTU5sl7JKTZ3nxp4u89dmDpwKZDbc4jXzi+EDiD/by97Y361BrzwC+MtSh0Ii38JQfloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vsgeN1IY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dq5+rfNt/mO5IrcGzsPkO664In3RGor7Ymb6QltUtEw=; b=vsgeN1IY0Dm1se4tbXdd23OJrM
	vPJ120YSa43ahGyAHQ7utJZjxxWWMK71Owg2e+4WVd3zAFK4AlRVMdSIJRM/8JiqdZqFcNBmAsvIL
	BALD1a9WoSVu4ZybxJ6RZLABl152fHqVfp6+fZvj52CR/oOWuoiSmI1fBauVPz4I1k+yDVP8vmhIQ
	BZQvonTi9IujWQMYXEPeU1IsNnNvWhGecInFjK8Ps7f0ITUPpDKceE868vPuuKJgZ04yEOGo4Cqhq
	HAWv8X1s6aLk0FQ2X8VZe+AfWtlH+6q16rUCbQ2TwR0m3uq6MRAbFx+i86cL9A98wROv9gfQECD43
	uxD66LDw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8zJK-0000000DjaM-3LvH;
	Wed, 15 Oct 2025 11:04:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DEA95300220; Wed, 15 Oct 2025 13:04:50 +0200 (CEST)
Date: Wed, 15 Oct 2025 13:04:50 +0200
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
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
Message-ID: <20251015110450.GO3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:41AM -0700, Tim Chen wrote:
> From: Chen Yu <yu.c.chen@intel.com>
> 
> Enable cache-aware load balancing only if at least 1 NUMA node has
> more than one LLC.
> 
> Suggested-by: Libo Chen <libo.chen@oracle.com>
> Suggested-by: Adam Li <adamli@os.amperecomputing.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c     | 15 ++++++++++++---
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c | 14 ++++++++++++--
>  3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cd080468ddc9..3d643449c48c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1208,6 +1208,14 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
>  __read_mostly unsigned int llc_overload_pct       = 50;
>  __read_mostly unsigned int llc_imb_pct            = 20;
>  
> +DEFINE_STATIC_KEY_FALSE(sched_cache_allowed);
> +
> +static inline bool sched_cache_enabled(void)
> +{
> +	return sched_feat(SCHED_CACHE) &&
> +		static_branch_likely(&sched_cache_allowed);
> +}

Urgh; do we really need _2_ static keys stacked for this? I'm thinking
one should be well enough.

