Return-Path: <linux-kernel+bounces-820915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2922B7FA72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C95C7B74F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83330CB39;
	Wed, 17 Sep 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmSkW16H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0DB296BCC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117391; cv=none; b=aEybTKGG43Fe+e+fOJqpoIh9dbe0mqrF016FTPc28B6GBOhfS7CN2xg+sepqgchaZu6m7RniGz4kJ9DUekdSXmL6tGcwL3oXwkWVIqqFNdivt8e4MNNH4EuQeYJIuVXL7knv/aot5IEdt7mY1/QfmlSEg7ftwhOt6JoHGi6jgIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117391; c=relaxed/simple;
	bh=xre9u8lmCSuT+kvU+MQKj8waLG124o91dkUS255/kuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq4trYMA70iCMT2MfARHRGmvPlMhs74m7nTSqJ5EdOP7lHnlkyCVdmnm01WOjmnsYzVrbma+Rx4rAhYN4iByQ/EtC+9rZyTrEUp5J4FAhhejEuZ4I+PKXnCFPjjGlkn+gAj7udB/ZhxqZDknM0FcytbiUPZA/9UKJyiz8YyXIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmSkW16H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758117388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFhgw29TMk4Vl1OzHRLrLrGkSi3PytJA9yR2IiAJEYc=;
	b=SmSkW16HIl4ewUIrdPZWVVUQWJcDeRJ4QVtZS8gbCWdDvjUcjRKktdrOALn8wOhUNVcU74
	lhuyHfTyhUTwAss6MQmU/38HlQll+ezZHsbRxNh18nuvBZatIHXNeGn/Gk1DhnPM4erPmd
	I0fhpZDoYu5alw4o8Y1yltQA69QYpto=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359--RqgpwnbNWax05EE37-S7w-1; Wed, 17 Sep 2025 09:56:26 -0400
X-MC-Unique: -RqgpwnbNWax05EE37-S7w-1
X-Mimecast-MFC-AGG-ID: -RqgpwnbNWax05EE37-S7w_1758117385
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso787642f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117385; x=1758722185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFhgw29TMk4Vl1OzHRLrLrGkSi3PytJA9yR2IiAJEYc=;
        b=h9eOa7Ik6HpSBuRRJacp7Jk1p6K2f6yKaHrWIJBSjV6IsFZuZKO5aC5GwMX26xUPAi
         zOmei1yGt6rqZX5SOatz9RMYCMXabn0OCDmTOnCMkG6xmUBQ3dnX0sqefza3Q6eB6Z3m
         A4jZHII1qtKIYawcepSeD3hKCzhIjymND2v78/2F8l5PPiuXIaWIKNWyJfo8ZHFs9QwR
         ffeQMaJV6f7QlVXxoQXQQ71Q6Om2bEV+6rNcGAKvIMuTvcR5notd9WBZ0pzAgWqb5Edu
         g4L8Wmu1CBOipyQPyU1Aiwk2d9PbVgPPWosgdKugJXm8riG3aNJKvB3mRddyPoaTd35p
         ZZvA==
X-Forwarded-Encrypted: i=1; AJvYcCXl42ockuY/lt1Zurd7NH5pg+WaVPYdCjHsr0wY7VopzpLsT61mjXcY9sMVjPDG96Dy6zHqJI40T2yva4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYT1+91txnLDz1kaApQiQg564K+mEEO8FlnOySkAW1WptDgVH
	UyqAymlFpbG8Z+P7cIB0+WtJ7KQeeM/GWQeF8a5fMjPARMeskUYLGyournGtpsqnVKN3OJ97txW
	4JxMrf7lbJNlgDe/CHHkJtXhfxKI00iru2Luhu8wMGtVDe04eZmkGnKbPfS5s/wgIrg==
X-Gm-Gg: ASbGncsfO3gS8ntjqYr0SQ/7C1GeVW24phFCn7amrIiVd59yQ6vRvqC32PjogBuvVFy
	BrT5aNDSmVPUF9kB7gISSH+k0vV0HPt7YILBHnqImQkOaMILvmKbVxnawcBG1CSIAeJbhNIGxTv
	YrGmLhBCjCS7zDdFcLK29n5CA/klvGqBsQ2lwPYTGfmaS6yXyHQoXohLDSP94K34gNij8KajTM5
	Xo2EXD1r4YIhI4ivrv825ZkbzSd6Pg3qoY3r9ebgn5WYpINxTPVksjrzhN6dmfUbnk/4vItivPp
	mxaHxvm2cjOs8kjVjLZ48hOo0En41k6c8gCq5t8D6l30qaizSRlel+F/mkFNj82My49neLo=
X-Received: by 2002:a05:6000:310f:b0:3d8:e1de:7e4f with SMTP id ffacd0b85a97d-3ecdf9bee22mr2360178f8f.21.1758117384881;
        Wed, 17 Sep 2025 06:56:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuSx3dGA6sbKDkb6PuoU7NWYZUZAbkIawB3s9g/uIGpn/75+4HHB9dD9Nvnb/6SCap1QTr/g==
X-Received: by 2002:a05:6000:310f:b0:3d8:e1de:7e4f with SMTP id ffacd0b85a97d-3ecdf9bee22mr2360147f8f.21.1758117384412;
        Wed, 17 Sep 2025 06:56:24 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32114c62sm40736125e9.2.2025.09.17.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:56:23 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:56:20 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
Message-ID: <aMq-BKLSIG9JrRb7@jlelli-thinkpadt14gen4.remote.csb>
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com>
 <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
 <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
 <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>
 <20250917093441.GU3419281@noisy.programming.kicks-ass.net>
 <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917122616.GG1386988@noisy.programming.kicks-ass.net>

On 17/09/25 14:26, Peter Zijlstra wrote:
> On Wed, Sep 17, 2025 at 11:34:42AM +0200, Peter Zijlstra wrote:
> 
> > Yes. This makes sense.
> > 
> > The old code would disable the dl_server when fair tasks drops to 0
> > so even though we had that yield in __pick_task_dl(), we'd never hit it.
> > So the moment another fair task shows up (0->1) we re-enqueue the
> > dl_server (using update_dl_entity() / CBS wakeup rules) and continue
> > consuming bandwidth.
> > 
> > However, since we're now not stopping the thing, we hit that yield,
> > getting this pretty terrible behaviour where we will only run fair tasks
> > until there are none and then yield our entire period, forcing another
> > task to wait until the next cycle.
> > 
> > Let me go have a play, surely we can do better.
> 
> Can you please try:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
> 
> That's yesterdays patch and the below. Its compile tested only, but
> with a bit of luck it'll actually work ;-)
> 
> ---
> Subject: sched/deadline: Fix dl_server behaviour
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Sep 17 12:03:20 CEST 2025
> 
> John reported undesirable behaviour with the dl_server since commit:
> cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling").
> 
> When starving fair tasks on purpose (starting spinning FIFO tasks),
> his fair workload, which often goes (briefly) idle, would delay fair
> invocations for a second, running one invocation per second was both
> unexpected and terribly slow.
> 
> The reason this happens is that when dl_se->server_pick_task() returns
> NULL, indicating no runnable tasks, it would yield, pushing any later
> jobs out a whole period (1 second).
> 
> Instead simply stop the server. This should restore behaviour in that
> a later wakeup (which restarts the server) will be able to continue
> running (subject to the CBS wakeup rules).
> 
> Notably, this does not re-introduce the behaviour cccb45d7c4295 set
> out to solve, any start/stop cycle is naturally throttled by the timer
> period (no active cancel).

Neat!

> Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
> Reported-by: John Stultz <jstultz@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

...

> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -371,10 +371,39 @@ extern s64 dl_scaled_delta_exec(struct r
>   *   dl_server_update() -- called from update_curr_common(), propagates runtime
>   *                         to the server.
>   *
> - *   dl_server_start()
> - *   dl_server_stop()  -- start/stop the server when it has (no) tasks.
> + *   dl_server_start() -- start the server when it has tasks; it will stop
> + *			  automatically when there are no more tasks, per
> + *			  dl_se::server_pick() returning NULL.
> + *
> + *   dl_server_stop() -- (force) stop the server; use when updating
> + *                       parameters.
>   *
>   *   dl_server_init() -- initializes the server.
> + *
> + * When started the dl_server will (per dl_defer) schedule a timer for its
> + * zero-laxity point -- that is, unlike regular EDF tasks which run ASAP, a
> + * server will run at the very end of its period.
> + *
> + * This is done such that any runtime from the target class can be accounted
> + * against the server -- through dl_server_update() above -- such that when it
> + * becomes time to run, it might already be out of runtime and get deferred
> + * until the next period. In this case dl_server_timer() will alternate
> + * between defer and replenish but never actually enqueue the server.
> + *
> + * Only when the target class does not manage to exhaust the server's runtime
> + * (there's actualy starvation in the given period), will the dl_server get on
> + * the runqueue. Once queued it will pick tasks from the target class and run
> + * them until either its runtime is exhaused, at which point its back to
> + * dl_server_timer, or until there are no more tasks to run, at which point
> + * the dl_server stops itself.
> + *
> + * By stopping at this point the dl_server retains bandwidth, which, if a new
> + * task wakes up imminently (starting the server again), can be used --
> + * subject to CBS wakeup rules -- without having to wait for the next period.

In both cases we still defer until either the new period or the current
0-laxity, right?

The stop cleans all the flags, so subsequent start calls
enqueue(ENQUEUE_WAKEUP) -> update_dl_entity() which sets dl_throttled
and dl_defer_armed in both cases and then we start_dl_timer (defer
timer) after it (without enqueueing right away).

Or maybe I am still a bit lost. :)

> + * Additionally, because of the dl_defer behaviour the start/stop behaviour is
> + * naturally thottled to once per period, avoiding high context switch
> + * workloads from spamming the hrtimer program/cancel paths.

Right. Also nice cleanup of a flag and a method.


