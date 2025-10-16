Return-Path: <linux-kernel+bounces-855686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C0EBE1F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97034F649C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868D2FDC42;
	Thu, 16 Oct 2025 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JkIKXaiC"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AD5288514
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600715; cv=none; b=ISOarBILjuuITcRy/sRyTAJXsBSxVdpdUlwbHDzpr/PvwlPDF/16KtwakN+H0Z1pNxN+xDSz5OmyKDkz6XPWCZHfsheurdbC80DZwFhJ7RCfAgU5FWqNpEzF9tlktv7aRSj95QiRZZyTiOjJBATtEfoYmhRz2fIA+YmE44c8p4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600715; c=relaxed/simple;
	bh=4HJEor79t2Zd/Gv55aXcaHEtS2bT2DVKSqD35v32X28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDihxmOX+3CNLy/wDlPUAWwv+5tPLy7lIQuWwo8tl35UNG2EIqqy5w47geCJyRJQhTMMgqglppQNuvgKl/WeTKQ+dDb7uAUaKI/EU4w0HBFULSuiD/jRqXTk43GjnR0nSWqWydGDJC8OBG3yMHFr/JxWVRLMsxolQbzdBA/WWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JkIKXaiC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dWFuZOwCnHREvFTOOI4lYoSZLWg8HjO7PYath0nHoYc=; b=JkIKXaiCYltNrKznpE5Qv6mRP4
	GR5UN2IKlBI4hP8OTlQOBhOjy4mTDcYzhC1s6hkUYNSr7VGuWYVHGTDpKSQHwQ4ndevDW7UPd6Yld
	9vz3ru2ZuNebxPaRMEfaYWwRD4gtNTho0UCue6DWqs/HxQMEmxA33YhdJUfEcHPZCLtKonmiACT9Y
	m6QN7K+b5vg9Np2cWJvEcAFwuLIthbMF/EzeEps10UlG//UfpE7XrVr1+K6LNM8fT/1VCYOpOr+tG
	O3XwhsWC2g/UN7ZafGutdrzJG3Eag5NE124ra1smOS31MbrqFbdUFZQeLFmpiSxnvFp5OoWgIqoej
	EP0FZQdw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9If5-00000006Zfc-0szB;
	Thu, 16 Oct 2025 07:44:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 45C47300325; Thu, 16 Oct 2025 09:44:34 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:44:34 +0200
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
Message-ID: <20251016074434.GZ3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015120523.GT3289052@noisy.programming.kicks-ass.net>
 <60fb91a69466e84d2367c11a4f0dd38511788bcb.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60fb91a69466e84d2367c11a4f0dd38511788bcb.camel@linux.intel.com>

On Wed, Oct 15, 2025 at 01:03:37PM -0700, Tim Chen wrote:
> On Wed, 2025-10-15 at 14:05 +0200, Peter Zijlstra wrote:
> > On Sat, Oct 11, 2025 at 11:24:44AM -0700, Tim Chen wrote:
> > > @@ -3999,6 +4038,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >  		struct rq *rq = rq_of(cfs_rq);
> > >  
> > >  		account_numa_enqueue(rq, task_of(se));
> > > +		account_llc_enqueue(rq, task_of(se));
> > >  		list_add(&se->group_node, &rq->cfs_tasks);
> > 
> > Here and...
> > 
> > >  	}
> > >  	cfs_rq->nr_queued++;
> > > @@ -4010,9 +4050,14 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >  	update_load_sub(&cfs_rq->load, se->load.weight);
> > >  	if (entity_is_task(se)) {
> > >  		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
> > > +		account_llc_dequeue(rq_of(cfs_rq), task_of(se));
> > 
> > ... here, could you please check the compiler is doing CSE of task_of()?
> 
> Will consolidate those task_of(se). 

And rq_of(). But really, check code-gen, it *should* DTRT and CSE the
lot. If it doesn't, then do it manually.

