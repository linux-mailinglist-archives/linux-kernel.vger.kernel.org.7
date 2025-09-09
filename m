Return-Path: <linux-kernel+bounces-807129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 127B7B4A072
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF16D4E1F6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E22BE7DB;
	Tue,  9 Sep 2025 03:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjD6QwI5"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C11A9F83
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390294; cv=none; b=LftqmfDA8qKXRER8jrs7egO9ew4sJSxRCMoWDctYMbLgHnlxutstRCoRR64O38zyXFYHMhXJOTGCqWUNFiL7IG7hiso4CfZinVuZy3BM5o2yldZETmedZsYH3OuWbcOEa/ntRBj5XEPK1C7WIBwWmFsxFE/ToS9JROYtr1dHMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390294; c=relaxed/simple;
	bh=3W04uNffKxHWTFWhi8r7WWFHCsqpZkkDP8v1I5cMI3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K8+nXdTam1fkh9oC2Qz+o5IbS5MCvcTbGq93hDaaTzIjxbXBUUbpHOt4ON0+UfX6KtNk/KEwwn84uMOfS6aYKswqCg0kRNeZ7eAifvDftT3TkPVhDU0ffChlg23cUrQISsaApqZTTvVgEuJPkEk0mVJRgCe3UCL8RkuEZm+9wHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjD6QwI5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso4689716a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757390292; x=1757995092; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUnrLWRutqzOL+PCyKRj9Q46Et1xm9b1y7m2qf+g92Q=;
        b=SjD6QwI5ifxP0rjRroMM8xVq2KFow3u/zZaSI2Gsav2zMtP9m4MquozRrFBNKntk7P
         2N3hUYutMBizx8p44RhDz4jQlSnCzJOl7upW0d6IvasFGrA1G/g176DUsnA0HbRLSbuo
         o6qRFxSPBJzTChQ3a6c8loBpTmtqUSH+yfeinIHuUbqZVViEQNLN57PJ7iWgI5ugVxNg
         oNe5m++lcBHSMSLLB/uhjBHkDY8kA3UyjsabKSzE2t/RNkrQSs700ZigXDJeL021RZCL
         VNu1186/sfrRMlEZTlINw1d6GzAAg0gEdPr2dpnjuj/YU75f9Xn549qz8CSeJCvMo8AH
         3bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757390292; x=1757995092;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUnrLWRutqzOL+PCyKRj9Q46Et1xm9b1y7m2qf+g92Q=;
        b=q+udbQqxNFhCPFpMTTfAoShqIr3cmZdUkf83nU4a2mkI58+0OFHQq/5QBtzhb2b1uY
         yb8+KHdGkaXnnOkUiDj76uByL2ljScUvR6hSyNFYmQsKEv/kOZVCU26LBRvwT7QjM594
         QzU6UZp58SamZ+gtR7JEJZ6ugqPiK6jaBKsZgCIQ0cZg5u+dhTP/iWOVA12QQW2zDJOZ
         2I6IEShge+Cc1qIZvuckBoNuKdcII4nWOtf2hVTX2sjv84MF8AowkcjNR8mH2iw01K5s
         JMF0VF58A4+sHyUABh0dWmRLRggyfwZDHIMhhhIYGHRZsUSAqktHRr29HuTgtvVRdV3v
         Me0A==
X-Forwarded-Encrypted: i=1; AJvYcCVPuQ3pGqbM3vuVVoTCpimNF2EnI7mLpbv5i4aPPMUnuDluuQHPtoKIjr3/wN9ibpUaohLpIoFOZpEGW60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPIHFnVq7UF+6WSQ6zvOn9Eme6iKCRgAqJKU2zZyqQzzUoo9Y
	tMsYHzt1U7kMV8BUnSL6DDSmVGYmLVHCJkxrUmo0kht+T+mLq6bX54aPPY2S3kBuyw==
X-Gm-Gg: ASbGncv98TJZxhLp7+HyBWMvwT4AUZzV0WZOz3G4SDgbbNyokoIywXnvtfDBqvr5f/+
	Ty0fzYthvFuHAGrQXScWr17YSZvnlu/RPQIodf0HGjYvo64jlXWQnjnnVmOf32/08p95S2ReVCw
	gPZ3DowMydVczZm2aDlQuG+MwZDggmqGl8EV3GvptKwYxiXGeA845GgWtiQUqIQHjGqxhyKKZLm
	u8PTqjR/C7yPbX+05LQhxRf5PguaXV+bFhujnQLgrtLmiZcoeG83qtrstK9D/bmMI+KmNPThyM1
	FwPs7oMqqaGX0BOQcXpzwpA+FnmY3awKLVMKTPQtRu6ZKfG6l7RoZJafBGFVMl+jXvOMkF6KtRR
	3wN1MDZOZ6t9NA9bIJjiMsc7qdfi0eGI06QMQuu1GBNkHbBHVwwvNtTer1/AqhcwJwvTmdK6/jE
	PvL0Eews7UK4VU1Y0=
X-Google-Smtp-Source: AGHT+IE2HU3rozS4ETlQvEW7d81Yt0dZ8iVRFlB/nUMKl4iPk9Nx6LlYXBKTNE0JT6pVc/CJRLudrw==
X-Received: by 2002:a17:902:e843:b0:24c:7f2f:d9e6 with SMTP id d9443c01a7336-2516d81a032mr124973235ad.10.1757390291759;
        Mon, 08 Sep 2025 20:58:11 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-76-132-13-32.hsd1.ca.comcast.net. [76.132.13.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b16429692sm187133545ad.122.2025.09.08.20.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:58:11 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Valentin Schneider <vschneid@redhat.com>,
  Chengming Zhou <chengming.zhou@linux.dev>,  Josh Don
 <joshdon@google.com>,  Ingo Molnar <mingo@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  Xi Wang <xii@google.com>,
  linux-kernel@vger.kernel.org,  Juri Lelli <juri.lelli@redhat.com>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Mel Gorman <mgorman@suse.de>,  Chuyi Zhou
 <zhouchuyi@bytedance.com>,  Jan Kiszka <jan.kiszka@siemens.com>,  Florian
 Bezdeka <florian.bezdeka@siemens.com>,  Songtang Liu
 <liusongtang@bytedance.com>,  Chen Yu <yu.c.chen@intel.com>,  Matteo
 Martelli <matteo.martelli@codethink.co.uk>,  Michal Koutn??
 <mkoutny@suse.com>,  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
In-Reply-To: <20250904110504.GG42@bytedance> (Aaron Lu's message of "Thu, 4
	Sep 2025 19:05:04 +0800")
References: <20250829081120.806-1-ziqianlu@bytedance.com>
	<20250829081120.806-4-ziqianlu@bytedance.com>
	<20250903145124.GM4067720@noisy.programming.kicks-ass.net>
	<14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
	<xm26o6rrtgav.fsf@google.com> <20250904081611.GE42@bytedance>
	<da9141b1-d717-493f-939f-85e23d46e7ba@amd.com>
	<20250904110504.GG42@bytedance>
Date: Mon, 08 Sep 2025 20:58:09 -0700
Message-ID: <xm26frcwtgz2.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Lu <ziqianlu@bytedance.com> writes:

> On Thu, Sep 04, 2025 at 03:21:06PM +0530, K Prateek Nayak wrote:
>> Hello Aaron,
>> 
>> On 9/4/2025 1:46 PM, Aaron Lu wrote:
>> > @@ -8722,15 +8730,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>> >  	if (unlikely(se == pse))
>> >  		return;
>> >  
>> > -	/*
>> > -	 * This is possible from callers such as attach_tasks(), in which we
>> > -	 * unconditionally wakeup_preempt() after an enqueue (which may have
>> > -	 * lead to a throttle).  This both saves work and prevents false
>> > -	 * next-buddy nomination below.
>> > -	 */
>> > -	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
>> > -		return;
>> 
>> I think we should have a:
>> 
>> 	if (task_is_throttled(p))
>> 		return;
>> 
>> here. I can see at least one possibility via prio_changed_fair()
>
> Ah right. I didn't realize wakeup_preempt() can be called for a throttled
> task, I think it is not expected. What about forbid that :)
> (not tested in anyway, just to show the idea and get feedback)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cb93e74a850e8..f1383aede764f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13135,7 +13135,11 @@ static void task_fork_fair(struct task_struct *p)
>  static void
>  prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
>  {
> -	if (!task_on_rq_queued(p))
> +	/*
> +	 * p->on_rq can be set for throttled task but there is no need to
> +	 * check wakeup preempt for throttled task, so use p->se.on_rq instead.
> +	 */
> +	if (!p->se.on_rq)
>  		return;
>  
>  	if (rq->cfs.nr_queued == 1)
>
>> where a throttled task might reach here. Rest looks good. I'll
>> still wait on Ben for the update_cfs_group() bits :)


Yeah, I think I agree with all of these (this patch and the previous
patch); the preempt ones are subjective but I'd probably default to "no
special case needed for throttle". Removing the check in
update_cfs_group() I think is correct, unless we want to freeze
everything, yeah. (And that seems dangerous in its own way)

