Return-Path: <linux-kernel+bounces-854372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158FCBDE386
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3AC3C1372
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0418F18F2FC;
	Wed, 15 Oct 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ImMDiNF4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0212E6112
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526528; cv=none; b=Q0gT0XHMKwsv+KhNENG2O4OqCJhAF6jlmhGC/vshnHvOBxbpE/aDT0o7owqqGR4bwngxUspB3V07cdnGMJVxSpZbUw8aIVgjNnYZTicrrBAHYHOe/9oj+KH7nifAUMt79gdqBnMvJs2UuhcGaVyG3NSsTGYTcPswaFh8cfYbR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526528; c=relaxed/simple;
	bh=mw1W+V03YvDNt80JlYjLTxmwOhUqhJrn0U1mV1pfbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGwVs2G8D+vso9djFIIqIIcA/+wLA5ZAnsDgIlcboki93LGy8moTaZSgzQJam5mkm/Prx5r2aV+KFa5r01Aesg6R6Tz/XyD/zDfS9HRSl0EUwWZVNvTrebaETwiX5m7ugbahOu+pULCMmDn+ToW9aPMd9HG5prT9aEOSlk5Zsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ImMDiNF4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gj4wxh40vzoJaoWMETKEwy3Y3zcyLK+RBJP4MsT/Du0=; b=ImMDiNF4NjJkVEsTljKZ76ZfCf
	53sHPEMEO+dihgmcdFfwMeIplwsYexKp8pYIqdRqN1l3VYY9hg8oVg2ZJDUMtaurMaAU+bNgb7m+0
	9pzygP5lMgaYXOqft0AqKvUUS94ABH1ylTqhvm9fA91p7wRY3iZ9y5pz3T12rK+ppGipVin1gNHll
	S4+w7IYG+DSNE027A/7XJOwlSpQ98DYhiPhParssq1bC60ZCF+3nvq2AMvX7rOMk8pbawoYcfvAvB
	ju+5PO3h9731uWQAWNCLNrVBCObXM4cz05G6ySWmqe8+1Hx9k339kyJb0SVev9SKJdung8wbKkyc5
	nB4O1A2A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8zMi-0000000Dll4-3vXX;
	Wed, 15 Oct 2025 11:08:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B165230023C; Wed, 15 Oct 2025 13:08:21 +0200 (CEST)
Date: Wed, 15 Oct 2025 13:08:21 +0200
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
Subject: Re: [PATCH 05/19] sched/fair: Add LLC index mapping for CPUs
Message-ID: <20251015110821.GP3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <7d75af576986cf447a171ce11f5e8a15a692e780.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d75af576986cf447a171ce11f5e8a15a692e780.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:42AM -0700, Tim Chen wrote:
> Introduce an index mapping between CPUs and their LLCs. This provides

"Introduce a *dense* mapping ...", since we already have a mapping, but
as you explain below, that is sparse and not well suited for indexing.

> a continuous per LLC index needed for cache-aware load balancing in
> later patches.

> The maximum number of LLCs is limited by CONFIG_NR_LLCS. If the number
> of LLCs available exceeds CONFIG_NR_LLCS, the cache aware load balance
> is disabled. To further save memory, this array could be converted to
> dynamic allocation in the future, or the LLC index could be made NUMA
> node-wide.


> +config NR_LLCS
> +	int "Maximum number of Last Level Caches"
> +	range 2 1024
> +	depends on SMP && SCHED_CACHE
> +	default 64
> +	help
> +	  This allows you to specify the maximum number of last level caches
> +	  this kernel will support for cache aware scheduling.

Not really a fan of this max thing. I suppose I'll see the use in the
next few patches, but ideally we'd start with the dynamic solution.

