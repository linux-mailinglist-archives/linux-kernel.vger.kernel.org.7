Return-Path: <linux-kernel+bounces-873130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB4C132F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FB943535C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA27B2BE021;
	Tue, 28 Oct 2025 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hjZmtt9M"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC66FBF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633433; cv=none; b=MkIby3C+BZS0Yil0VaURXcB2amKLFQrmoStGGAFuR1ivI5ogVhOTCHowLeWFcm9HsDXEAJMb+REXLLaFAJzYz1qwN6wudPPDiMi8X2vu8F9vw93xHobRnZQVVVzv6nOxklgqUBsrRw3kRASRu9J2jH/qrZ/Es9Y8XaW6A0OR/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633433; c=relaxed/simple;
	bh=2xdlk8QbJMFgELl1jrgPAi/0XEkw06bDmDNszfhE3sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9JUdjl828LkNoF2nKots//+RsEaKQa7J/y3TaFfNtjFTgouVWfZWcDCHWlh9GMRc9OqJu8FuJmMm4BlAHJl9MHzhUWMjP7NMQgihGNglCnUCVYSBtgcck2XbvHJZBkiN4lTx+OCkmSf9RMdqsLHrSEGzLdoZHEFVOZSzR70Fxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hjZmtt9M; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so2996737b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761633431; x=1762238231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIzZNDz25ybVRv1hneZHBtih6yTo8yaqCj2ncuoWQYE=;
        b=hjZmtt9Mx4YmuHnoOzYmeiRgkrTLmMAaQuOmiaZZHEnaCQFnnyWwv2QG6Vrh9wuI2w
         68+5ysUZeIK9QiW5i6t+6tuUnNmoO2CwGGMWwRLuP/NqzouyXCZtJueqPE39z5NHOSpw
         mZPxqGDGw048QZThX84Tg/f/N5OvURYQKeKQ4gWYZUJi8LczbOdSlQOgqWK3FgrnNNDu
         6hAE7tfblbJmJBwtlcm4P1WWJ/5WJFWxwCoioTz6KjVvBo9pBHgQoJuHnGRfMuEkzKED
         ND7fECI9oN9Mfgl9jlzrvP8eYPqRCvxAZ16Tz0CradC03ZmdhfxjpkhoIoZpHotSSqEh
         yk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761633431; x=1762238231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIzZNDz25ybVRv1hneZHBtih6yTo8yaqCj2ncuoWQYE=;
        b=k7xpTB9f5CozFyj++qfWb1rk1UrimMwwkzHVNX9xfZHkbaXZ0RA1zsb44PERNLr6m9
         mcqhnA5q3cNwrcAgQkX4Sq4zzySYHLeQNjYJvrwECj0qpXWySqTrfcHaRIfTcJ7AYGXv
         ejdgpjeC3dSvRAEz2hdaM7+LhrnXD53J0Ptg+lrGoArbYVcejkcaftnxwS/P7fP46RVw
         +lz5yztTHLsEDZ3FVpLbX8+uNQydQlvF5hwwEVbuDxqd67XbZLvyoY4+eLo/W0or+mIS
         0qTeiLZlFArCtClxqtyTywgV5EWTZwwQYtv5UEOv4olS0rwZTNkxh9TgSYRaAi5n3N/1
         t7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWSo3iMfD/PSsB2iwDfNCLgQtvTWfCGVMwSQjsCaHaRfuBnV30CeSa2Kmm3jB5XtwX6VRzGQcq+5SNscq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYE7cbBFw/4pgK8y+VysEtYN5iDXpf6l20e6VnUmfe+k1XnS/+
	Gfa8NzZIWsStdRdCrOqk3EmJquHwpqjx2iR2U8GM/RuFrZJdVY/N3oDOTdJmm3V5Gg==
X-Gm-Gg: ASbGnctI21qaGylcHBwk1oO+/n0KlG4p7w7dkRwbyiTHQJooOt7YUgqE50AS0SDrRaf
	BbNisb8XAiR7WVAYjY2GJWq9pAgZnlOkaVMlVEK1WDVWBYuCQz3B66/BEpO+JGpEHv6iXKzUx9r
	gQYWtNaWRXNR17Nl65CuDRMu75V2kzv9SRIjA9/XPfKfdE7TsJn+bdqMhXEuyiXoma98q6SkV0z
	02KLkGSO44JZEskmusgjNlMkCInwtFKzOln9xUiqAcbjl6ENbrwv7fmxJqRa3xoTJ6fS4cl9px1
	ZcRmZxeUKZi+zArwkS5CvETMJTbtaZz7ctdNWqVInayJ/WYrDwoZRfnq528/hi5cpyjq1YEvXp/
	MRoksv5Mm6QOuRTL9TFMdflYOoHvDp0jGmzWwfSM3p+wBpgGRfZxaNyZZHMxVRB0GeXqoDx2KpT
	Tv3OoX57/U0TcMoN26zQl1
X-Google-Smtp-Source: AGHT+IFFWWSGCbGA1NEYNaO+4SJcD3QwII33wF6USaYrUswymuvcFLT2cKeX6QDN/U40Dxh4v0pBUA==
X-Received: by 2002:a17:902:d506:b0:26e:e6ab:66fe with SMTP id d9443c01a7336-294cb37a7c0mr30347445ad.5.1761633430986;
        Mon, 27 Oct 2025 23:37:10 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d42de5sm105586815ad.76.2025.10.27.23.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:37:10 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:36:59 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Benjamin Segall <bsegall@google.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Hao Jia <jiahao.kernel@gmail.com>,
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
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] sched/fair: Prevent cfs_rq from being unthrottled
 with zero runtime_remaining
Message-ID: <20251028063659.GC33@bytedance>
References: <20251023085604.244-1-ziqianlu@bytedance.com>
 <xm26ms5cug9c.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26ms5cug9c.fsf@google.com>

On Mon, Oct 27, 2025 at 03:33:19PM -0700, Benjamin Segall wrote:
> Aaron Lu <ziqianlu@bytedance.com> writes:
> 
> > When a cfs_rq is to be throttled, its limbo list should be empty and
> > that's why there is a warn in tg_throttle_down() for non empty
> > cfs_rq->throttled_limbo_list.
> >
> > When running a test with the following hierarchy:
> >
> >           root
> >         /      \
> >         A*     ...
> >      /  |  \   ...
> >         B
> >        /  \
> >       C*
> >
> > where both A and C have quota settings, that warn on non empty limbo list
> > is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
> > part of the cfs_rq for the sake of simpler representation).
> >
> > Debug showed it happened like this:
> > Task group C is created and quota is set, so in tg_set_cfs_bandwidth(),
> > cfs_rq_c is initialized with runtime_enabled set, runtime_remaining
> > equals to 0 and *unthrottled*. Before any tasks are enqueued to cfs_rq_c,
> > *multiple* throttled tasks can migrate to cfs_rq_c (e.g., due to task
> > group changes). When enqueue_task_fair(cfs_rq_c, throttled_task) is
> > called and cfs_rq_c is in a throttled hierarchy (e.g., A is throttled),
> > these throttled tasks are directly placed into cfs_rq_c's limbo list by
> > enqueue_throttled_task().
> >
> > Later, when A is unthrottled, tg_unthrottle_up(cfs_rq_c) enqueues these
> > tasks. The first enqueue triggers check_enqueue_throttle(), and with zero
> > runtime_remaining, cfs_rq_c can be throttled in throttle_cfs_rq() if it
> > can't get more runtime and enters tg_throttle_down(), where the warning
> > is hit due to remaining tasks in the limbo list.
> >
> > I think it's a chaos to trigger throttle on unthrottle path, the status
> > of a being unthrottled cfs_rq can be in a mixed state at the end, so fix
> > this by calling throttle_cfs_rq() in tg_set_cfs_bandwidth() immediately
> > after enabling bandwidth and setting runtime_remaining = 0. This ensures
> > cfs_rq_c is throttled upfront and cannot enter tg_unthrottle_up() with
> > zero runtime_remaining.
> >
> > Also, update outdated comments in tg_throttle_down() since
> > unthrottle_cfs_rq() is no longer called with zero runtime_remaining.
> >
> > While at it, remove a redundant assignment to se in tg_throttle_down().
> >
> > Fixes: e1fad12dcb66("sched/fair: Switch to task based throttle model")
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > ---
> > v2: add update_rq_clock() before throttle_cfs_rq() as reported by Hao
> >     Jia, or a warn on outdated rq clock is trigged in tg_throttle_down().
> >     This can happen when user specified a tiny quota.
> >
> > Note that Hao Jia also proposed another solution by using a special flag
> > when doing enqueue_task_fair() in unthrottle path to avoid doing
> > check_enqueue_throttle() [0]. I think that approach is fine too and it
> > also has the benefit of not needing to worry about any other potential
> > cases where a cfs_rq is unthrottled with <=0 runtime_remaining. Thoughts
> > on which approach to go is welcome, thanks.
> > [0]: https://lore.kernel.org/lkml/c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com/
> >
> >  kernel/sched/core.c  | 11 ++++++++++-
> >  kernel/sched/fair.c  | 16 +++++++---------
> >  kernel/sched/sched.h |  1 +
> >  3 files changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f1ebf67b48e21..58185ec5b8efd 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9608,7 +9608,16 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
> >  		cfs_rq->runtime_enabled = runtime_enabled;
> >  		cfs_rq->runtime_remaining = 0;
> >  
> > -		if (cfs_rq->throttled)
> > +		/*
> > +		 * Throttle cfs_rq now or it can be unthrottled with zero
> > +		 * runtime_remaining and gets throttled on its unthrottle path.
> > +		 */
> > +		if (cfs_rq->runtime_enabled && !cfs_rq->throttled) {
> > +			update_rq_clock(rq);
> > +			throttle_cfs_rq(cfs_rq);
> > +		}
> > +
> > +		if (!cfs_rq->runtime_enabled && cfs_rq->throttled)
> >  			unthrottle_cfs_rq(cfs_rq);
> >  	}
> >
> 
> So if this is the only case it can come up, and it only occurs becasue
> we set runtime_remaining = 0 and check in unthrottle with <= 0, then I
> think we should just set runtime_remaining = 1 here. 
>

Thanks Ben, I like your suggestion and tested that it works for the case
I described here. I think it should also work for the case Hao Jia
described in his patch's changelog. 

> That seems simpler than either throttling immediately (despite likely
> having plenty of cfs_b->runtime) or adding an enqueue flag. Adding NR_CPUs
> nanoseconds worth of quota on configure seems fine.

Agree.

> 
> unthrottle_cfs_rq/tg_unthrottle_up itself doesn't drop rq lock, so we
> shouldn't be able to see cfs_rq->runtime_remaining being consumed during
> it, even if it's running on a remote cpu so that threads in the cfs_rq
> can be running. They should wind up stuck waiting for rq lock in order
> to update runtime_remaining.
> 
> Is there anything you see missing from that approach? I think it doing =

Not any that I'm aware of.

> 0 in particular here is just an artifact, and while the extra check for
> runtime_remaining in unthrottle isn't unreasonable, the conflict with
> tg_set_cfs_bandwidth isn't a fundamental issue.

Got it, thanks for the suggestion, will change the patch accordingly for
v3. I think it will become a simple one line change:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f1e5cb94c536..23f92222aedf3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9606,7 +9606,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
 
 		guard(rq_lock_irq)(rq);
 		cfs_rq->runtime_enabled = runtime_enabled;
-		cfs_rq->runtime_remaining = 0;
+		cfs_rq->runtime_remaining = 1;
 
 		if (cfs_rq->throttled)
 			unthrottle_cfs_rq(cfs_rq);

