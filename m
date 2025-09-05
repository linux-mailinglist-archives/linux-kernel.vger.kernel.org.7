Return-Path: <linux-kernel+bounces-802905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1E1B4583D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EAEA08379
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F434F486;
	Fri,  5 Sep 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="axheC/XP"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9D350D58
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076837; cv=none; b=EDYUcpWdoGgXxhhKcKez4iCRpQXi3g0PQxQ6VnWwYtfuiJM51O221QA7UAXBgAw400w1M1TemmAUvE04OVNI++p7fUBpbvUKQ/xf47mYwtR75xrJW21GQXZfAw4LxcQ7NOSj5x9EgLDqvBnmTdWb60peWofGwHnrVtAFd7Pp0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076837; c=relaxed/simple;
	bh=WjHICGefntARcstzVO8ZVh680AKPCEjVKvuQmIBP+e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBEDvUTa46vSxHL/LykTqfTjBRWXpfNnxL3tFqpm0XGppeHKuhGDS7/wQ+EeejG17KUQiSLT7yJ64WsIxaEqP1NMu+5jXaVCDSnlt/lDL+Ldy2i8/GnYtfUyAjU/a2ZWYk9I5PZjKv2mPVI4CvVtMAzKzDXmqnHEsIUfVOTSmWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=axheC/XP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Df/CGSjixwi81kzd7JhF2Mhwi2EHsUI8edq8HZo8rqQ=; b=axheC/XPLUUTVpYWHrz8FpUNXW
	mNCPSl9V/kR0YSocybrBzvLvFh5Duuf2g0HO0AhRRT8AEHuY1h3lpA8qjEJbeb+byEdLn9ntgF2zi
	LJBKf17IiEWS4yN3rh3pQBzsSrY/oYX+gozU/AMLFn/5eiAodDM03arrekkzreFNtTIk/+Dv230Ly
	939Uf6eYlXEGFpbMZjP/pgYK8OyQGhmv7I6pt0wEyhzuihKelEuS7F2xiPWFXbvNHvWJO1srQHO5P
	4lW+YOKQ2BHddCVQYSUR+nNhSLAeEiP1MmbsbKym7y9pkJYsBOULaJ7zFg3wlM2xAIxKrCuTQZiuj
	IVJH8i9w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuVwX-00000004W7D-2YXx;
	Fri, 05 Sep 2025 12:53:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8EAB830034B; Fri, 05 Sep 2025 14:53:28 +0200 (CEST)
Date: Fri, 5 Sep 2025 14:53:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250905125328.GU3245006@noisy.programming.kicks-ass.net>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <20250903202703.GP4067720@noisy.programming.kicks-ass.net>
 <ddd2f979-43d5-43e8-a95c-37a1654189e5@amd.com>
 <20250904070407.GD42@bytedance>
 <20250905113719.GL42@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905113719.GL42@bytedance>

On Fri, Sep 05, 2025 at 07:37:19PM +0800, Aaron Lu wrote:
> Hi Peter,
> 
> On Thu, Sep 04, 2025 at 03:04:07PM +0800, Aaron Lu wrote:
> > On Thu, Sep 04, 2025 at 11:14:31AM +0530, K Prateek Nayak wrote:
> > > On 9/4/2025 1:57 AM, Peter Zijlstra wrote:
> > > > So this is mostly tasks leaving/joining the class/cgroup. And its
> > > > purpose seems to be to remove/add the blocked load component.
> > > > 
> > > > Previously throttle/unthrottle would {de,en}queue the whole subtree from
> > > > PELT, see how {en,de}queue would also stop at throttle.
> > > > 
> > > > But now none of that is done; PELT is fully managed by the tasks
> > > > {de,en}queueing.
> > > > 
> > > > So I'm thinking that when a task joins fair (deboost from RT or
> > > > whatever), we add the blocking load and fully propagate it. If the task
> > > > is subject to throttling, that will then happen 'naturally' and it will
> > > > dequeue itself again.
> > > 
> > > That seems like the correct thing to do yes. Those throttled_cfs_rq()
> > > checks in propagate_entity_cfs_rq() can be removed then.
> > >
> > 
> > Not sure if I understand correctly, I've come to the below code
> > according to your discussion:
> >
> 
> Does the below diff look sane to you? If so, shall I send a separate
> patch on top or fold it in patch3 and send an updated patch3?

Yeah, I suppose that works. Please send a follow up patch. It would also
be good to have a comment that explains why we need that list_add_leaf
thing. I think I see, but I'm sure I'll have forgotten all next time I
see this code.

