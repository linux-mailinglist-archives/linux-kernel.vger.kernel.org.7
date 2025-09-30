Return-Path: <linux-kernel+bounces-837655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30701BACD78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6841896410
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F9326A1BE;
	Tue, 30 Sep 2025 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezFwC0AL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15E2FB616
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235413; cv=none; b=c0aO/9MBgH935si1533v0XiR4S8X4vmUjBKGUeBoCiijjnjWG0Df3HTSgGVw7zAI6V/8fM7u15wa2ShOyiEjIcJcXrcguK9DhO8u7YCG1UjXJP0hH7nITffYMFu63ejLerhkKJgbb1nzAEv5Sy6bfmgzQ897Yl4RMfjJoz17qW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235413; c=relaxed/simple;
	bh=/zL0EFk+v/5fhzJnTW5AH5NtDIodVA5pLQDzXOr2AqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huAUy1z262kecLrE/23OeD+kRaoUQl0kRB9c+bXr3HBgCFjFgUuprt6K7iOLwOjUp+N5LdXB5GtwCoSfhzPvyxUq9ZmD4xSLPSHVxANVhBatf7nPXtIKzt+gyt+9h93cGv6qQvewTVug7lj1fG9qYpG4iI4s8WDdcaO81aBTuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezFwC0AL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759235410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6xcN7C4Fb9O/Gi5nkV9luP1iu5hB9NCLHHJ7lVM2PQ=;
	b=ezFwC0ALv3TvxdtxEVvnjuMMA0+mT/hGB5QIB55tdMDICZUQmlVsz5OHDbhwUbLS45/flg
	KoLU0EEfiqQi40NTvky5EpRgg22fJSypq2dQCsBPMy5G3nwbSdde/GvvHhIofutC70OzFz
	qmyghJ6bdxTD0ZBidTLa3ZpxansNu7M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-lUx6fI6cMJ-K3x16lkjNDg-1; Tue,
 30 Sep 2025 08:30:07 -0400
X-MC-Unique: lUx6fI6cMJ-K3x16lkjNDg-1
X-Mimecast-MFC-AGG-ID: lUx6fI6cMJ-K3x16lkjNDg_1759235405
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68AA61800366;
	Tue, 30 Sep 2025 12:30:05 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.241])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4942530003BA;
	Tue, 30 Sep 2025 12:30:01 +0000 (UTC)
Date: Tue, 30 Sep 2025 08:29:59 -0400
From: Phil Auld <pauld@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Jianyun Gao <jianyungao89@gmail.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] sched: Fix some spelling mistakes in the scheduler
 module
Message-ID: <20250930122959.GA87275@pauld.westford.csb>
References: <20250929061213.1659258-1-jianyungao89@gmail.com>
 <ff4099fa-a6e4-4478-af81-a4c1baaf483b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff4099fa-a6e4-4478-af81-a4c1baaf483b@arm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 30, 2025 at 09:26:59AM +0100 Christian Loehle wrote:
> On 9/29/25 07:12, Jianyun Gao wrote:
> > From: "jianyun.gao" <jianyungao89@gmail.com>
> > 
> > The following are some spelling mistakes existing in the scheduler
> > module. Just fix it!
> > 
> >   slection -> selection
> >   achitectures -> architectures
> >   excempt -> except
> >   incorectly -> incorrectly
> >   litle -> little
> >   faireness -> fairness
> >   condtion -> condition
> > 
> > Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> > ---
> > V2:
> > Delete the incorrect modifications for "borken" in V1.
> > The previous version is here:
> > 
> > https://lore.kernel.org/lkml/20250926092832.1457477-1-jianyungao89@gmail.com/
> > 
> >  kernel/sched/core.c     | 2 +-
> >  kernel/sched/cputime.c  | 2 +-
> >  kernel/sched/fair.c     | 8 ++++----
> >  kernel/sched/wait_bit.c | 2 +-
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7f1e5cb94c53..af5076e40567 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6858,7 +6858,7 @@ static void __sched notrace __schedule(int sched_mode)
> >  		/*
> >  		 * We pass task_is_blocked() as the should_block arg
> >  		 * in order to keep mutex-blocked tasks on the runqueue
> > -		 * for slection with proxy-exec (without proxy-exec
> > +		 * for selection with proxy-exec (without proxy-exec
> >  		 * task_is_blocked() will always be false).
> >  		 */
> >  		try_to_block_task(rq, prev, &prev_state,
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index 7097de2c8cda..2429be5a5e40 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -585,7 +585,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
> >  	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
> >  	/*
> >  	 * Because mul_u64_u64_div_u64() can approximate on some
> > -	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
> > +	 * architectures; enforce the constraint that: a*b/(b+c) <= a.
> >  	 */
> >  	if (unlikely(stime > rtime))
> >  		stime = rtime;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 18a30ae35441..20fe5899b247 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5381,7 +5381,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  		bool delay = sleep;
> >  		/*
> >  		 * DELAY_DEQUEUE relies on spurious wakeups, special task
> > -		 * states must not suffer spurious wakeups, excempt them.
> > +		 * states must not suffer spurious wakeups, except them.
> 
> This should be exempt, no?
> 

I had the same thought then decded that "except" as a verb worked too.
We are making an exception for the special states, right? I think either
works, but not both at once :) 

But that said, I'm not sure we should bother as these don't seem to
effect the meaning (at least to me as a native 'merican speaker). 

Cheers,
Phil



-- 


