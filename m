Return-Path: <linux-kernel+bounces-749403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0CB14DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30AA543C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1971758B;
	Tue, 29 Jul 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ampO6lTa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E73208
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793136; cv=none; b=Ws6MsE5MTCmWSbfvA/wZeVlT2sz0EDu8IPhPCUW3jjpCdiN3Y4O0cnK2t+r1ob2k4IyNm9QEKv98WT/C2owz1BIB8Uz6PBWhisJCM0qVJ17Fg/FcfLEl86+rqpxS2EaBG+wVesBqNrZ0lYjU8wE9E4pkFJ9/lIjWpoOxt++yb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793136; c=relaxed/simple;
	bh=NziYxp8UZj0YwVyFDa8KouGzs7K2NLOULSeXFdio+RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzbvqlU/6ZAobFs5Cl7eE284YUTTS5lzM/3erkWZ/U7dgMSHjguivQD86lmsy+vooH9dJnv6cUHhtJvDWdplkUjzMMxHjhf0xlqqDejm0kYmyNZh3ic7w2D0cqakM1TCekiKrrWPLp/nB4M70VFjAhm1JWqPSADkvN4ixtgNo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ampO6lTa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753793134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auUgmZpYgSPBn8OUHhACc16TOd027tjyQY/sDVVda2Y=;
	b=ampO6lTaVI6hJ1TjpcaiJeQH96mR5GfINGIPpUC9riI7MDoA/dW9geCL3754+h0IVbnqwZ
	vPXqNkxrQ6VQ8OGwN3QGvJ4MnOsO+TFHXePJ35ge2RIrbYshJCwlx+4uCySOfprX5JgDJg
	VaTC/P/gVYKUAfM2ko5BUByeOKEjnYw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-d1QdbzoROAOQLWT_FxPThg-1; Tue,
 29 Jul 2025 08:45:28 -0400
X-MC-Unique: d1QdbzoROAOQLWT_FxPThg-1
X-Mimecast-MFC-AGG-ID: d1QdbzoROAOQLWT_FxPThg_1753793124
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A509219560AD;
	Tue, 29 Jul 2025 12:45:23 +0000 (UTC)
Received: from localhost (unknown [10.22.88.125])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0164718001DD;
	Tue, 29 Jul 2025 12:45:21 +0000 (UTC)
Date: Tue, 29 Jul 2025 09:45:20 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <aIjCYEkgNvVpMYCS@uudg.org>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
 <aIh5QajyaVT7MtVp@uudg.org>
 <20250729114702.GA18541@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729114702.GA18541@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jul 29, 2025 at 01:47:03PM +0200, Oleg Nesterov wrote:
> On 07/29, Luis Claudio R. Goncalves wrote:
> >
> > From: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > Subject: sched: restore the behavior of put_task_struct() for non-rt
> >
> > Commit 8671bad873eb ("sched: Do not call __put_task_struct() on rt
> > if pi_blocked_on is set") changed the behavior of put_task_struct()
> > unconditionally, even when PREEMPT_RT was not enabled, in clear mismatch
> > with the commit description.
> >
> > Restore the previous behavior of put_task_struct() for the PREEMPT_RT
> > disabled case.
> >
> > Fixes: 8671bad873eb ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> > Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> > ---
> > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > index ea41795a352b..51678a541477 100644
> > --- a/include/linux/sched/task.h
> > +++ b/include/linux/sched/task.h
> > @@ -130,6 +133,16 @@ static inline void put_task_struct(struct task_struct *t)
> >  	if (!refcount_dec_and_test(&t->usage))
> >  		return;
> >
> > +	/* In !RT, it is always safe to call __put_task_struct(). */
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
> > +
> > +		lock_map_acquire_try(&put_task_map);
> > +		__put_task_struct(t);
> > +		lock_map_release(&put_task_map);
> > +		return;
> > +	}
> 
> FWIW:
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> 
> At the same time... I don't understand this DEFINE_WAIT_OVERRIDE_MAP().
> IIUC, we need to shut up lockdep when put_task_struct() is called under
> raw_spinlock_t and __put_task_struct() paths take spinlock_t, right?
> Perhaps this deserves a comment...

I reverted that code to the previous state, commit 893cdaaa3977 ("sched:
avoid false lockdep splat in put_task_struct()") and simplified the "if"
statement. In the original code, PREEMPT_RT could call __put_task_struct()
if the context was preemptible. But in the proposed code __put_task_struct()
is only called if PREEMPT_RT is disabled. In this case I believe we could
simply do:

+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		__put_task_struct(t);
+		return;
+	}

Does that make sense?

Luis
 
> But if I am right, why LD_WAIT_SLEEP? LD_WAIT_CONFIG should equally work, no?
> 
> LD_WAIT_SLEEP can fool lockdep more than we need, suppose that __put_task_struct()
> does mutex_lock(). Not really a problem, might_sleep/etc will complain in this
> case, but still.
> 
> Or I am totally confused?
> 
> Oleg.
> 
---end quoted text---


