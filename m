Return-Path: <linux-kernel+bounces-799411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13208B42B46
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872401A8389D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16212DBF48;
	Wed,  3 Sep 2025 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llzdWare"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B72E8DF6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932414; cv=none; b=dB/csHFzrBH6mMfnxGpqBIfCLQ0nuFwIGXSZ0RFKfcgfR56g/4Bxgw/zt9ig7DSfeH55xNvO4Lmf3MmY+Wb+N11W4GjPHz1a2qSp0+skFdTIO6GAMySCtdoi90prc1y9sOK7ofpSGrSOyPu90EEahW56tmLny9DTSeBXYfPs34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932414; c=relaxed/simple;
	bh=8Sjpx6LwL8qngcyx8effURsIdeC4kjMw3r2A2PEEfhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rOht2uTNWaQMTe/Lg4GnQ5cszuK4w0LBMMjfXsRmx3qhpN9PuWLwSB5P04ZPruz6HhiZEM0PX/+XpWNL8nlajQ+qEAitIBSUeuVtItana1I62xURpzEPKt+SCeVvn6mQHutt7CwQF5Upxwuww0YifH/6ypNi4DIUVgLmx3Ipf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llzdWare; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47173749dbso168796a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756932412; x=1757537212; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWGn1Qb0KIjnuqOw6TphYaw5j4IfbMgJEHpHGOy8roU=;
        b=llzdWarerkRMJ6XwxrSlqT7J4pj/NNtDYVKJehRSulAYzULSd8cPmlf7YnZp1I1BIa
         SPfibDrAd0AXqFQ/I8PiWwaLrKV9cRtOFzCHFrJoVbnxnZcvyijpsHrk+Lr848ml84ta
         GZhO0XTltUaGQ2akxvtklaBwagx7ox9rujtzv598cFCPS0iJ2fcVpSF9JH2SrD5fNQ7Q
         arW236PKwz5eQcebEeDhbQQrrxyZqIlFWH4mcbmSLT/OdE807fRJSrU5ho0O61uRcaOu
         sPpv+ymLjFyV8uYtoIyH83wR7f8Pf9J32fDPCniKaYrDCP/AyJoZXtCeUADfDmV/Kxws
         Bq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932412; x=1757537212;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWGn1Qb0KIjnuqOw6TphYaw5j4IfbMgJEHpHGOy8roU=;
        b=T2lb/VevNGHYb8qFDjTefnI1S4QmRR4CNJVAzMsm1adEhdiuOK2gjfK2zu5Zl1eoN2
         i80jXzKL9Fxt4AFSP93vak+GjAVkGikwAi295tukLMilcA0SaH3ROqvL2+INPH5LCrrI
         Yp37KTL2KbacVfYuyI0OBCsfL50FnKyPubY6SGw2kOU/2/59qjYAMnIJyA/FMpQzrJDs
         UWjMMsNwHifjU35GyRxgVjfpjIDdY8bqs5zvBlh+0yo5ooe6NsqSPDJcLzNIMqk6Jaou
         7V6xLJyj5/7fqbcxDjD6F5CpSi+DLuAe8eeMwap57rKLZlwPxR+vAc2dRgmZN8nCaOwS
         JL1g==
X-Forwarded-Encrypted: i=1; AJvYcCXhLu0x22CYibs3uApwJdvlt6lRyIwhe99ou0biKLmMsRWcrTTlUhVOj8q43wJm/4EH3owwpVN1UKY0GBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzggWH7lamLFF4IMnJaWpdhAL55fzHVsLFbfGJyXQQiKIt3X6Mt
	3nBoiwI/S15ZnCspZ0Y32pk9K0ONBKmegUUYni9fuBHVlmGz9P4X9sTK9/SXxbhbBA==
X-Gm-Gg: ASbGncvLkjLYgE6togcqzofkIvHOwPndCfbMtZc6y51sWOZ7yttUfZkNZVJgR4IY0Ey
	dRRpo9P9N9zJhXI0T/I2AkPA1/ljkIpWCPlzRv063z2SjfdivQJmFDSuzjVEErMtq0Cnws3y1k/
	hVFD8AApgK/wiswATmWah/YrVokVEnaWDrOmv+bplhmzfCp2bCxByCnxUQswPudV08PTidYFAl6
	0fDqDtvUb5joSA3pljn12CRRwZu1iEl9DVeld1E1arJhXRWDGN0MM5KBqECJU2+3z7u25ZQKdkv
	QX9+vsbqCntR7rfZrhrExK2jXWUH4yZSbBFpxeFnY/j0A5gwsI8p3lQjeAf+/vhwg+zOhwONeIB
	cTu5IDMl9kcCMrei2p9P2+3tBJcNIkv13upI/fENRKrwsLpM3JPZqXcNaFwZdhT7igVMxUijCE9
	ez73ojXkQqUg==
X-Google-Smtp-Source: AGHT+IEDT8HfDdtAel2AQicVpMxeAncF1ME4lzWDyWrqnTfqxyUP0FHouzQS0YPDBmy4427ZPSfVkQ==
X-Received: by 2002:a17:902:f683:b0:24a:aca0:7ce5 with SMTP id d9443c01a7336-24aaca081ddmr181967905ad.44.1756932411666;
        Wed, 03 Sep 2025 13:46:51 -0700 (PDT)
Received: from bsegall-glaptop.localhost ([2a00:79e0:2efc:9:2cc5:e7bd:145c:10aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490375a591sm171671485ad.60.2025.09.03.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:46:51 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Aaron Lu
 <ziqianlu@bytedance.com>,  Valentin Schneider <vschneid@redhat.com>,
  Chengming Zhou <chengming.zhou@linux.dev>,  Josh Don
 <joshdon@google.com>,  Ingo Molnar <mingo@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  Xi Wang <xii@google.com>,
  <linux-kernel@vger.kernel.org>,  Juri Lelli <juri.lelli@redhat.com>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Mel Gorman <mgorman@suse.de>,  Chuyi Zhou
 <zhouchuyi@bytedance.com>,  Jan Kiszka <jan.kiszka@siemens.com>,  Florian
 Bezdeka <florian.bezdeka@siemens.com>,  Songtang Liu
 <liusongtang@bytedance.com>,  Chen Yu <yu.c.chen@intel.com>,  Matteo
 Martelli <matteo.martelli@codethink.co.uk>,  Michal Koutn??
 <mkoutny@suse.com>,  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
In-Reply-To: <14be66aa-e088-4267-ac10-d04d600b1294@amd.com> (K. Prateek
	Nayak's message of "Wed, 3 Sep 2025 22:42:01 +0530")
References: <20250829081120.806-1-ziqianlu@bytedance.com>
	<20250829081120.806-4-ziqianlu@bytedance.com>
	<20250903145124.GM4067720@noisy.programming.kicks-ass.net>
	<14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
Date: Wed, 03 Sep 2025 13:46:48 -0700
Message-ID: <xm26o6rrtgav.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Prateek Nayak <kprateek.nayak@amd.com> writes:

> Hello Peter,
>
> On 9/3/2025 8:21 PM, Peter Zijlstra wrote:
>>>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>  {
>>> +	if (task_is_throttled(p)) {
>>> +		dequeue_throttled_task(p, flags);
>>> +		return true;
>>> +	}
>>> +
>>>  	if (!p->se.sched_delayed)
>>>  		util_est_dequeue(&rq->cfs, p);
>>>  
>> 
>> OK, so this makes it so that either a task is fully enqueued (all
>> cfs_rq's) or full not. A group cfs_rq is only marked throttled when all
>> its tasks are gone, and unthrottled when a task gets added. Right?
>
> cfs_rq (and the hierarchy below) is marked throttled when the quota
> has elapsed. Tasks on the throttled hierarchies will dequeue
> themselves completely via task work added during pick. When the last
> task leaves on a cfs_rq of throttled hierarchy, PELT is frozen for
> that cfs_rq.
>
> When a new task is added on the hierarchy, the PELT is unfrozen and
> the task becomes runnable. The cfs_rq and the hierarchy is still
> marked throttled.
>
> Unthrottling of hierarchy is only done at distribution.
>
>> 
>> But propagate_entity_cfs_rq() is still doing the old thing, and has a
>> if (cfs_rq_throttled(cfs_rq)) break; inside the for_each_sched_entity()
>> iteration.
>> 
>> This seems somewhat inconsistent; or am I missing something ? 
>
> Probably an oversight. But before that, what was the reason to have
> stopped this propagation at throttled_cfs_rq() before the changes?
>

Yeah, this was one of the things I was (slowly) looking at - with this
series we currently still abort in:

1) update_cfs_group
2) dequeue_entities's set_next_buddy
3) check_preempt_fair
4) yield_to
5) propagate_entity_cfs_rq

In the old design on throttle immediately remove the entire cfs_rq,
freeze time for it, and stop adjusting load. In the new design we still
pick from it, so we definitely don't want to stop time (and don't). I'm
guessing we probably also want to now adjust load for it, but it is
arguable - since all the cfs_rqs for the tg are likely to throttle at the
same time, so we might not want to mess with the shares distribution,
since when unthrottle comes around the most likely correct distribution
is the distribution we had at the time of throttle.

Assuming we do want to adjust load for a throttle then we probably want
to remove the aborts from update_cfs_group and propagate_entity_cfs_rq.
I'm guessing that we need the list_add_leaf_cfs_rq from propagate, but
I'm not 100% sure when they are actually doing something in propagate as
opposed to enqueue.

The other 3 are the same sort of thing - scheduling pick heuristics
which imo are pretty arbitrary to keep. We can reasonably say that "the
most likely thing a task in a throttled hierarchy will do is just go
throttle itself, so we shouldn't buddy it or let it preempt", but it
would also be reasonable to let them preempt/buddy normally, in case
they hold locks or such.

yield_to is used by kvm and st-dma-fence-chain.c. Yielding to a
throttle-on-exit kvm cpu thread isn't useful (so no need to remove the
abort there). The dma code is just yielding to a just-spawned kthread,
so it should be fine either way.

