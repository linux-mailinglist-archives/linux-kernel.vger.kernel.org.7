Return-Path: <linux-kernel+bounces-854443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E39BDE643
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A61714F0A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC229324B22;
	Wed, 15 Oct 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RSmJlZMn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB817A2EA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529957; cv=none; b=PbD7dDyFAyHIjhEMA3orMJ1R6CsFOQyKWHGCO2uIm0k/aY6T8vN/67cw1r5NyPl0J2o9xXxQzIul75De9bgcyXVyNRLJqFjrr6bbGPkZ2yp2Fb4VvX5ZcYiF2d90fmG/Cy4CS/FaJZzl7ksTpz6zG4E21liIVZI/MHnMdntQPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529957; c=relaxed/simple;
	bh=VlNZvdvElUyuOJj3giuTwsNJIbZPaNXgNwUZURsEYuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrbuxB0AmIKK1A02HUrX5XDqvEsRCL5h68WX77kiN+g0d5Y6x0pWBbtkAknqetClwJ6O1HPsjo+IVs8BhUly4Ftt6QOQKPi0MsrDNaZelcBVMZCjV+wrswYJ5kJoWUSs1QoSAxJrN2i+YbCn9OC7bzMUKADiQAgGSH8NgwPBt1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RSmJlZMn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ib4GssBtaoujIpL2c/Zd5XZ8Pl8i/nKMoLHP+jVKo00=; b=RSmJlZMnO2odVBXq6vEMOGkLM9
	tUgKOpi8fLCtWEsE617AUVIKzFJY1Fq/a6U7tSfmT0/NawIt/WcVERfEGu8rU7M+0K47SqRZrN7KB
	3S2Ty/NaYXWi6USyC25aF4hta8GQy4mMGP2lJ3gUkSQ6mPU+H+Xcv1++wzWkegOt5emfCNsituRAT
	sRk4dMYRQ7AcVPEwZyebOtWSrmmILUFK+xGXRfEiR5dag2Z1GAhO0FPctrA2dWtWsmRYG2MYqAtZn
	TBh3h64k1ZQUBtZepx+LNNLr3c4umdAwX8Iag6VYLe6vUPypHYVdsnd7n3KgZvYw/JzJKDLwxbdks
	SvV+w9eg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v90Fv-0000000Eizl-0mpn;
	Wed, 15 Oct 2025 12:05:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE52C30023C; Wed, 15 Oct 2025 14:05:23 +0200 (CEST)
Date: Wed, 15 Oct 2025 14:05:23 +0200
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
Subject: Re: [PATCH 07/19] sched/fair: Track LLC-preferred tasks per runqueue
Message-ID: <20251015120523.GT3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>

On Sat, Oct 11, 2025 at 11:24:44AM -0700, Tim Chen wrote:
> @@ -3999,6 +4038,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  		struct rq *rq = rq_of(cfs_rq);
>  
>  		account_numa_enqueue(rq, task_of(se));
> +		account_llc_enqueue(rq, task_of(se));
>  		list_add(&se->group_node, &rq->cfs_tasks);

Here and...

>  	}
>  	cfs_rq->nr_queued++;
> @@ -4010,9 +4050,14 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	update_load_sub(&cfs_rq->load, se->load.weight);
>  	if (entity_is_task(se)) {
>  		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
> +		account_llc_dequeue(rq_of(cfs_rq), task_of(se));

... here, could you please check the compiler is doing CSE of task_of()?

>  		list_del_init(&se->group_node);
>  	}
>  	cfs_rq->nr_queued--;
> +
> +	/* safeguard to clear the cache aware data */
> +	if (!parent_entity(se) && !cfs_rq->nr_queued)
> +		reset_llc_stats(rq_of(cfs_rq));

I'm confused -- why?

