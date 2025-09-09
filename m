Return-Path: <linux-kernel+bounces-807133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFBDB4A080
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EE44E4A01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271162D838F;
	Tue,  9 Sep 2025 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAQtXYvF"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51254654
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757391058; cv=none; b=roCCk3rAfkweGrF8Xz9LPeIyD+2I4s38h9mpchyL/VEBn31qjWk7rPBJeR0Ev6eBN5FCJN4NtwBDu//l0iYsHa7AEw/HckeKAFzKPHtZnDHJsgSIpijDIFHok2/AInENo9wzeXSQYBTEoCNCO5Mc0Dl+n+EJF1dK3AXRNNYmQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757391058; c=relaxed/simple;
	bh=l7OLerfaZkQQfdQg5SVoQUJYh8Lk1NrIPheczY/nbH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TyY+p7BbBVpv9DYgLG9yP3T1gxVbdH5sOQwXegMdASTvKUHRnFuWy0AuJjAGbKCxOIQcQvGoHTT6qH7HO0oZ+TNOSU6IumiJp7CpSe4Szz4DeljnQyWSPVDC5TJjd4ImTp9C+PK3Ro98yorsfVLqqmlytiES0NR75C8nsr6GQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAQtXYvF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-772481b2329so5333833b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757391056; x=1757995856; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyswnYcg0saFRXMrJ9h8foV6bZoR61ComRxjzP/MVYA=;
        b=hAQtXYvFuGCwodfyjkLLtSyZvVFeMGYnW4oEKRjD8x2tYled1LxZh/eHGqZ5qXKU5K
         boazLstM6yHuJ52UVcjM1pHRpyImitBf3MnAjfCC/ZNlWOyz6U9QtiXIAn415WFCw0cF
         cHjhbLb53IhtU8LvGZdP/Fwg1D+EdyiDDmAqfL6PW74YlWxMgilgQgg0JzibUVZIVuTe
         Oi0DxkI58c/WITsnHAKVdRIzpBiSsv8cxkD/umLyhgO/JHt+U/YpQkoI90bHb/1vLKWc
         GZ3qlIDFSnUYpzKc1kXCmxU6f8+mLFBRx9bxNpbj5ZH+8PxJjI0dQBP57xSzVPJ95Tk8
         qbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757391056; x=1757995856;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyswnYcg0saFRXMrJ9h8foV6bZoR61ComRxjzP/MVYA=;
        b=NMiOfMhpn9RSPGZ2XOExJhkegYVjmJxKV75jloFYjVIYnIzs8PNEvSvIIhA/StVyeJ
         5UAOmBZpKW47JOO65PvATacaY/tIGH7w1cB1AX4pNZO2WMM0kijvf7qsuUZ9bdIgsRIx
         V9aAAE3djmILlMlIVK+xoLi4fgB9vdALAcL+/h7wyqwQZcR36InL0cGQcs8q7HPovCX9
         XMZ0BSVYqKA5edVLWE6Lgoxk4y+fz0DqGnHpSAQu7H2ZcFTZZ6KArA2ri8v/r78rltEk
         EmM448aiblFpStQiw/Mb6A/6NSKWsclJvoG+fJZuZKDMGk0OkawB2xLg4S3NLo3vbK/E
         +QRA==
X-Forwarded-Encrypted: i=1; AJvYcCWaohg8KqtxxMmoA7hvIwW4LhtR56PVjWNglbJc7HvaFexKi/HDWfrpaerj4YgxWWs6o9LZps5LNpMTZ6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtIUjuXbYNlZo4KMvNIr7mCQnS6+QMG735pTElSH7J5DDzmDY
	KyEdQkv0E83Tumxy5aKWWWo8x+U8D1X7fEtD6J0TPZyFeS0d3Bz6aNaLud/1ms5kWw==
X-Gm-Gg: ASbGncvBbZU6tN9bAvyVizxzu47Ke11v2xAJbxgfgjrv+LlLI2a3trZ3IEQCa1YwHka
	+d1Ki/O6Ll1lWrF9rlyEtvdt49aIwjYlu8LjtArBIHKVdrh6JPqbfV8hScKhniVqgqFQJDYOIPs
	+3xeL8viuWF5emuDhgvFAkjWlteDOt/ugkAtyT/HePULjvqqpgj4P4tZE7bk8ScXO1qlmmHNhSM
	uKkmVNdEQe16a36AL5T1D3R/hvYmH+2Kj0XsEwhTJaxkEHeF+Fo30aYzSwdEfRVSrYCYtQTv0pP
	Wrgh6GvYVmo2Cb5kz7mj8U8iPtQdKF/YwA4Yn4rh1HCe5rFIOqjkjj2M807Pk8IajT2qKC2okt9
	kF7LVv35JToIGvxu0SQ1U5KnF4u7RXzJKLZYJh/+c44wYdVMfrTtyJkIUNzwsfLQCk+UdI4yB6M
	MihOYW
X-Google-Smtp-Source: AGHT+IEuqAIvwPL13BUxyY2lZ1Qa4zyra1O2FCT3sFXJiXBD2gUqTmeoVTWwFxJmprTyh6zeUPF9Lg==
X-Received: by 2002:a05:6a20:6a06:b0:24a:94db:bcfa with SMTP id adf61e73a8af0-25344415d85mr14676262637.31.1757391055853;
        Mon, 08 Sep 2025 21:10:55 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-76-132-13-32.hsd1.ca.comcast.net. [76.132.13.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4dad911628sm25661893a12.11.2025.09.08.21.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:10:55 -0700 (PDT)
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
In-Reply-To: <a5dd474c-5436-413c-a72a-38dfae9121cb@amd.com> (K. Prateek
	Nayak's message of "Thu, 4 Sep 2025 11:33:55 +0530")
References: <20250829081120.806-1-ziqianlu@bytedance.com>
	<20250829081120.806-4-ziqianlu@bytedance.com>
	<20250903145124.GM4067720@noisy.programming.kicks-ass.net>
	<14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
	<xm26o6rrtgav.fsf@google.com>
	<a5dd474c-5436-413c-a72a-38dfae9121cb@amd.com>
Date: Mon, 08 Sep 2025 21:10:53 -0700
Message-ID: <xm26bjnktgdu.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Prateek Nayak <kprateek.nayak@amd.com> writes:

> Hello Ben,
>
> On 9/4/2025 2:16 AM, Benjamin Segall wrote:
>> K Prateek Nayak <kprateek.nayak@amd.com> writes:
>> 
>>> Hello Peter,
>>>
>>> On 9/3/2025 8:21 PM, Peter Zijlstra wrote:
>>>>>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>>>  {
>>>>> +	if (task_is_throttled(p)) {
>>>>> +		dequeue_throttled_task(p, flags);
>>>>> +		return true;
>>>>> +	}
>>>>> +
>>>>>  	if (!p->se.sched_delayed)
>>>>>  		util_est_dequeue(&rq->cfs, p);
>>>>>  
>>>>
>>>> OK, so this makes it so that either a task is fully enqueued (all
>>>> cfs_rq's) or full not. A group cfs_rq is only marked throttled when all
>>>> its tasks are gone, and unthrottled when a task gets added. Right?
>>>
>>> cfs_rq (and the hierarchy below) is marked throttled when the quota
>>> has elapsed. Tasks on the throttled hierarchies will dequeue
>>> themselves completely via task work added during pick. When the last
>>> task leaves on a cfs_rq of throttled hierarchy, PELT is frozen for
>>> that cfs_rq.
>>>
>>> When a new task is added on the hierarchy, the PELT is unfrozen and
>>> the task becomes runnable. The cfs_rq and the hierarchy is still
>>> marked throttled.
>>>
>>> Unthrottling of hierarchy is only done at distribution.
>>>
>>>>
>>>> But propagate_entity_cfs_rq() is still doing the old thing, and has a
>>>> if (cfs_rq_throttled(cfs_rq)) break; inside the for_each_sched_entity()
>>>> iteration.
>>>>
>>>> This seems somewhat inconsistent; or am I missing something ? 
>>>
>>> Probably an oversight. But before that, what was the reason to have
>>> stopped this propagation at throttled_cfs_rq() before the changes?
>>>
>> 
>> Yeah, this was one of the things I was (slowly) looking at - with this
>> series we currently still abort in:
>> 
>> 1) update_cfs_group
>> 2) dequeue_entities's set_next_buddy
>> 3) check_preempt_fair
>> 4) yield_to
>> 5) propagate_entity_cfs_rq
>> 
>> In the old design on throttle immediately remove the entire cfs_rq,
>> freeze time for it, and stop adjusting load. In the new design we still
>> pick from it, so we definitely don't want to stop time (and don't). I'm
>> guessing we probably also want to now adjust load for it, but it is
>> arguable - since all the cfs_rqs for the tg are likely to throttle at the
>> same time, so we might not want to mess with the shares distribution,
>> since when unthrottle comes around the most likely correct distribution
>> is the distribution we had at the time of throttle.
>
> So we were having a discussion in the parallel thread here
> https://lore.kernel.org/lkml/20250903101102.GB42@bytedance/ on whether
> we should allow tasks on throttled hierarchies to be load balanced or
> not.
>
> If we do want them to be migrated, I think we need update_cfs_group()
> cause otherwise we might pick off most task from the hierarchy but
> the sched entity of the cfs_rq will still be contributing the same
> amount of weight to the root making the CPU look busier than it
> actually is.
>
> The alternate is to ensure we don't migrate the tasks on throttled
> hierarchies and let them exit to userspace in-place on the same CPU
> but that too is less than ideal.
>

Yeah - if we don't update group se load then we shouldn't load balance
throttled-hierarchy because the amount of root load migrated in the
moment is always 0. Once we do all of that properly we should be fine to
migrate in/out of a throttled hierarchy.

Much like wakeup there's an argument for not migrating into a throttled
hierarchy, at least from an unthrottled one, where there's presumably a
high likelyhood of the thread just being preempted in userspace. (And my
gut feeling is that this case is probably even more common than wakeup,
that need_rescheds land in (return to) userspace more often than wakeups
go straight to userspace with no significant kernel work)

