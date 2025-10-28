Return-Path: <linux-kernel+bounces-874148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D11C159E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFB31C22F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53609346E67;
	Tue, 28 Oct 2025 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qwy0cYPA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDC34679E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666464; cv=none; b=ZXCzUGBOSj9WNjYFhcPYFUKmk/5xbDYRzY8JYNwBq9fzwDqS8Ds1yMgKLTzVXSbmq9HQUj+18JfNN23hsrLO98zJkGZNPk5Jp0xuCyIms6391gyPUkdgk59j+muilXcPCpeYSXFrHWSPnMyjt2N3oqujTrRyEKJqYksikd7+6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666464; c=relaxed/simple;
	bh=JynqXbEi3gP/sDwues6MRdpK7ZQvZmr3JT8HZqkx4ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIQD6hUhXz0vWZZZNOmn7Zo4zgEKw0qSAceqpm/dbkHhCtc26fu4DBoYl6udgGBOvWD1FNhYOb6cEM+2wJzvkcxK5Q9kAQWIQs859plJ/5qfqTMTKKuXGQCSzUdt4B2CLMQ43rGJ5ZU4b5FZMKLsS/CR/TKT6bPFgyyr72HIWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qwy0cYPA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/5o81syi6bur6/v8zmFIQojrtJ+ndujIUMrkjP72Md0=; b=Qwy0cYPAYNP32E+ko6fPeXuo9e
	gpYA/uKo3q+IqPjqg8PBnz/SJP7oxaXAylRQ9qAhxMENql4ccsliSKxeZn+yUbyIzvvoebtGuWUNm
	OyOL11jzrGLl/lrwbIbqUZ+BNFejYSCyROqYIvCocjB8/EyOAzq+M0rbgH7T/1CAaTHioILaHcmHy
	eeyAGCR+bIx4KAA+qrbJ/G9bMvleqaBoH25bmk1QWmXSGaIrLkTY3UzvwJrjHTzUcvLynWwKOmC44
	/dKYzDi5NFjf8j2e+AS0HPJIDOU8sbCKN/VMuXuHFgtST/gQD/MquZoY3MxkJ7437fsa0eBYm8c0w
	BMGL9LYQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlv4-000000010Nl-0z6K;
	Tue, 28 Oct 2025 15:47:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0241300289; Tue, 28 Oct 2025 16:47:34 +0100 (CET)
Date: Tue, 28 Oct 2025 16:47:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <20251028154734.GS4068168@noisy.programming.kicks-ass.net>
References: <20251027133915.4103633-1-mgorman@techsingularity.net>
 <20251027133915.4103633-3-mgorman@techsingularity.net>
 <20251028153351.GN3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028153351.GN3245006@noisy.programming.kicks-ass.net>

On Tue, Oct 28, 2025 at 04:33:51PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 01:39:15PM +0000, Mel Gorman wrote:
> > @@ -8783,7 +8862,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  		 * When non-idle entity preempt an idle entity,
> >  		 * don't give idle entity slice protection.
> >  		 */
> > -		do_preempt_short = true;
> > +		do_preempt_short = PREEMPT_WAKEUP_NEXT;
> >  		goto preempt;
> >  	}
> 
> I'm confused, should this not be WAKEUP_RESCHED?

It doesn't matter, you cannot end up with !do_preempt_short at preempt:,
so that condition is always true and can thus be deleted, at which point
the value of do_preempt_short is irrelevant and doesn't need to be set.

A little something like so perhaps...

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8727,7 +8727,7 @@ static void set_next_buddy(struct sched_
 }
 
 enum preempt_wakeup_action {
-	PREEMPT_WAKEUP_NONE,		/* No action on the buddy */
+	PREEMPT_WAKEUP_NONE = 0,	/* No action on the buddy */
 	PREEMPT_WAKEUP_NEXT,		/* Check next is most eligible
 					 * before rescheduling.
 					 */
@@ -8814,7 +8814,7 @@ __do_preempt_buddy(struct rq *rq, struct
  */
 static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	enum preempt_wakeup_action do_preempt_short = PREEMPT_WAKEUP_NONE;
+	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_NONE;
 	struct task_struct *donor = rq->donor;
 	struct sched_entity *se = &donor->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
@@ -8863,7 +8863,6 @@ static void check_preempt_wakeup_fair(st
 		 * When non-idle entity preempt an idle entity,
 		 * don't give idle entity slice protection.
 		 */
-		do_preempt_short = PREEMPT_WAKEUP_NEXT;
 		goto preempt;
 	}
 
@@ -8883,17 +8882,17 @@ static void check_preempt_wakeup_fair(st
 	 * current's slice protection in order to allow preemption.
 	 */
 	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
-		do_preempt_short = PREEMPT_WAKEUP_NEXT;
+		preempt_action = PREEMPT_WAKEUP_NEXT;
 	} else {
 		/*
 		 * If @p potentially is completing work required by current then
 		 * consider preemption.
 		 */
-		do_preempt_short = __do_preempt_buddy(rq, cfs_rq, wake_flags,
+		preempt_action = __do_preempt_buddy(rq, cfs_rq, wake_flags,
 						      pse, se);
 	}
 
-	switch (do_preempt_short) {
+	switch (preempt_action) {
 	case PREEMPT_WAKEUP_NONE:
 		return;
 	case PREEMPT_WAKEUP_RESCHED:
@@ -8905,18 +8904,16 @@ static void check_preempt_wakeup_fair(st
 	/*
 	 * If @p has become the most eligible task, force preemption.
 	 */
-	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
+	if (__pick_eevdf(cfs_rq, false) == pse)
 		goto preempt;
 
-	if (sched_feat(RUN_TO_PARITY) && do_preempt_short != PREEMPT_WAKEUP_NONE)
+	if (sched_feat(RUN_TO_PARITY))
 		update_protect_slice(cfs_rq, se);
 
 	return;
 
 preempt:
-	if (do_preempt_short)
-		cancel_protect_slice(se);
-
+	cancel_protect_slice(se);
 	resched_curr_lazy(rq);
 }
 

