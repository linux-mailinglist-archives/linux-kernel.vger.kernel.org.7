Return-Path: <linux-kernel+bounces-760192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4CB1E79C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1F67A61B2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5422750E5;
	Fri,  8 Aug 2025 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StestG5H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC02749F1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653520; cv=none; b=RlKEZFAyVODnl0MJ0UjDfIbKFhVEi8Nb8D5tbWhbt9BNQymQMg1o41rTqVMvhgQSIJmOdR0vmjkYTM6iHH1jAa44koVK6DRjGLzFV0zqwdnihsojt27VXraEmFzcS0ilZbnL65pEBaiPQIaXCU2wqfFMm0WosdwaQtHJQbIeEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653520; c=relaxed/simple;
	bh=7M0JrCgx5eU5w98j2LZMhjmsn+OCjUdu/yqPopMhdQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/DuHs+54c3bv2/gKXtNP4UV+S3jl1YW+5o1onLO1qN1B7cIYPXxrIGPp7hvHzCnEL0a4rmlOmVuwYzPNmPOR9AhBCBiz/m/LtNzEH90AEVLrvcmtU2sdgQdIiZxlCDa6QxJHvgfzJEcFN82zJb72dZo7HZHWaICSOlFFn8sFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StestG5H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754653517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YkZCdLb6WZU2/frpn0NwOv9SmThv3TPw8wVjf2uMHJ0=;
	b=StestG5HL7SmvCiUiEGbi/ZXIzV4leABU0yXd9wqnxFYdMwxXUUDYv2cAYk9zvQXPXaoa5
	VzZcmRU+rPMwvufqvcS3XGcSyxY59exrFxtb9XF7/oaAtIbwe8ztJ7yvY0VCrpg1zf1k1w
	9KtMOw0yoluZY/wTML7PZ1/O8z79Cjk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-Ce9EjMqfOJ6i4PRJOTiQog-1; Fri, 08 Aug 2025 07:45:16 -0400
X-MC-Unique: Ce9EjMqfOJ6i4PRJOTiQog-1
X-Mimecast-MFC-AGG-ID: Ce9EjMqfOJ6i4PRJOTiQog_1754653515
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b8d8935418so1305845f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653515; x=1755258315;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkZCdLb6WZU2/frpn0NwOv9SmThv3TPw8wVjf2uMHJ0=;
        b=BJ0oYOgyXudrWaiSfjFLXHM7UDK47EJd1mY+TsXkznM5VJnaKG+jkibysaPgg9LuSN
         rh69jEq8v/+3foC7mTWhDbL6B123un6BynwXVGGk1vNIPTH+Ox1Fj8kzNgiBvx9Zv87i
         teKyG+PvCUSD4AUveY4zn41XFgPhacGsdHfOemeisd/1jlRXt8tmYgd8maL++Fmf+XlT
         gnZkQOcnzbj/OeyYjzCoNYW/amfHDD4jDJEdXtNTrTsdmff/NhnKGeCEJ2ofIeP+jvvm
         tE7Zjj7/SYQlKwciIwyOolGpwo53GQBRJARdIIuOw4o4ujXuwmaVdlwlfDQVB6F/R+op
         rFvg==
X-Forwarded-Encrypted: i=1; AJvYcCVEW6vAlgmJ8jk13w7Jugy67dF73ukffKdyVT8d7PrJH7FxkKsY9cjbdu4tAs2ortL7Sl6VeUCs0jJSAvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38swqm9vwduDP+EN59R8G3BNNNh7wX8a0L0dQlF+s2vInDeY3
	mgRkm1oTA8xrvzE2wkMOkvHYvtsMa87WrguVdjfaBhEuYshQFvZhCsFO4gBjS8cqFEQwwzWJi28
	hIiydNtMQFE4XemEHh+oPmzvc2HVCR4blNGO2Wa5UQL0yaTX+S4pFKmU+TH0irzh4ig==
X-Gm-Gg: ASbGncuOZDIgEnZD14Ndr8lQqQHB5wPNbhGfvVURox+aayixhdrpdgphNP8JIZFRi4M
	o3H98Y/HhBrnxmUT9zUg2U3oPLu1BNPwfYge506KMLIeFZpg8lkdU9qOnxSHUVnTBF8jmxpsH8V
	xOKdblaS/7iad6TKmwg9cHewKBLRM2nUsAINpkFDwG2mGd+ibyomWARGj57zpKYVY/jo0gHza/C
	TCuyIXAHyeLUJtyb0gbVJn9wbZfLQOKE7U7vPU1N47pVD1quHX1teEill7h816lkkCAbBbC90ew
	1KeLY/IDhxf6h+ugkXqdNHdDPfX16yF5J9Xc2hdleh90EzBS6+C9YcnKlZWlvYhIlTlq5HI7tNb
	HDQ==
X-Received: by 2002:a05:6000:250a:b0:3a5:243c:6042 with SMTP id ffacd0b85a97d-3b900b4bca8mr2407523f8f.2.1754653515457;
        Fri, 08 Aug 2025 04:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZZTsr8LljTVMXUVmF2Zx0tLBx9Kd0/V8sNlHZ2iorN2eL2lkbGw2YXs0akABivYUbZzhBFw==
X-Received: by 2002:a05:6000:250a:b0:3a5:243c:6042 with SMTP id ffacd0b85a97d-3b900b4bca8mr2407483f8f.2.1754653514913;
        Fri, 08 Aug 2025 04:45:14 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2a04:cec0:107e:d29c:76ef:3842:1ccc:76b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459eec47306sm71622085e9.28.2025.08.08.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:45:13 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Ben Segall <bsegall@google.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, Chengming
 Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org, Juri Lelli
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi
 Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
 <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
In-Reply-To: <20250808101330.GA75@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
Date: Fri, 08 Aug 2025 13:45:11 +0200
Message-ID: <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 08/08/25 18:13, Aaron Lu wrote:
> On Fri, Aug 08, 2025 at 11:12:48AM +0200, Valentin Schneider wrote:
>> On 15/07/25 15:16, Aaron Lu wrote:
>> > From: Valentin Schneider <vschneid@redhat.com>
>> >
>> > In current throttle model, when a cfs_rq is throttled, its entity will
>> > be dequeued from cpu's rq, making tasks attached to it not able to run,
>> > thus achiveing the throttle target.
>> >
>> > This has a drawback though: assume a task is a reader of percpu_rwsem
>> > and is waiting. When it gets woken, it can not run till its task group's
>> > next period comes, which can be a relatively long time. Waiting writer
>> > will have to wait longer due to this and it also makes further reader
>> > build up and eventually trigger task hung.
>> >
>> > To improve this situation, change the throttle model to task based, i.e.
>> > when a cfs_rq is throttled, record its throttled status but do not remove
>> > it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
>> > they get picked, add a task work to them so that when they return
>> > to user, they can be dequeued there. In this way, tasks throttled will
>> > not hold any kernel resources. And on unthrottle, enqueue back those
>> > tasks so they can continue to run.
>> >
>> 
>> Moving the actual throttle work to pick time is clever. In my previous
>> versions I tried really hard to stay out of the enqueue/dequeue/pick paths,
>> but this makes the code a lot more palatable. I'd like to see how this
>> impacts performance though.
>> 
>
> Let me run some scheduler benchmark to see how it impacts performance.
>
> I'm thinking maybe running something like hackbench on server platforms,
> first with quota not set and see if performance changes; then also test
> with quota set and see how performance changes.
>
> Does this sound good to you? Or do you have any specific benchmark and
> test methodology in mind?
>

Yeah hackbench is pretty good for stressing the EQ/DQ paths.

>> > +	if (throttled_hierarchy(cfs_rq) &&
>> > +	    !task_current_donor(rq_of(cfs_rq), p)) {
>> > +		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>> > +		return true;
>> > +	}
>> > +
>> > +	/* we can't take the fast path, do an actual enqueue*/
>> > +	p->throttled = false;
>> 
>> So we clear p->throttled but not p->throttle_node? Won't that cause issues
>> when @p's previous cfs_rq gets unthrottled?
>> 
>
> p->throttle_node is already removed from its previous cfs_rq at dequeue
> time in dequeue_throttled_task().
>
> This is done so because in enqueue time, we may not hold its previous
> rq's lock so can't touch its previous cfs_rq's limbo list, like when
> dealing with affinity changes.
>

Ah right, the DQ/EQ_throttled_task() functions are when DQ/EQ is applied to an
already-throttled task and it does the right thing.

Does this mean we want this as enqueue_throttled_task()'s prologue?

  /* @p should have gone through dequeue_throttled_task() first */
  WARN_ON_ONCE(!list_empty(&p->throttle_node));

>> > @@ -7145,6 +7142,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>> >   */
>> >  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>> >  {
>> > +	if (unlikely(task_is_throttled(p))) {
>> > +		dequeue_throttled_task(p, flags);
>> > +		return true;
>> > +	}
>> > +
>> 
>> Handling a throttled task's move pattern at dequeue does simplify things,
>> however that's quite a hot path. I think this wants at the very least a
>> 
>>   if (cfs_bandwidth_used())
>> 
>> since that has a static key underneath. Some heavy EQ/DQ benchmark wouldn't
>> hurt, but we can probably find some people who really care about that to
>> run it for us ;)
>> 
>
> No problem.
>
> I'm thinking maybe I can add this cfs_bandwidth_used() in
> task_is_throttled()? So that other callsites of task_is_throttled() can
> also get the benefit of paying less cost when cfs bandwidth is not
> enabled.
>

Sounds good to me; just drop the unlikely and let the static key do its
thing :)


