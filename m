Return-Path: <linux-kernel+bounces-772753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74720B29723
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68FF1961C35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90880244686;
	Mon, 18 Aug 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dEJIRUQ9"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DB111A8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755485438; cv=none; b=VDoyXJjQKIoEYq1H/2pWLYv+L5m/KFM+lpW6CuSFXVJMnvfC9nUaCX229Kp7uDuO4bCPIiqEqSwOYj+yBe5Fz+PNXO0HYrEH8cOhvOsqiLQq1i/cPrmzHfmljWVFBXRa8g6iKIb01UUwKkOc///hjERoePDKy0o/AVu5kVN5ECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755485438; c=relaxed/simple;
	bh=PViqDczLcKA7G2xUvtvKSPWvoetbWNeLL/xKTcYaiXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDnoRj2Lygr43EHmUt0sftcMPLZtQ9/KZIyJpVY4q6xFPMUeJy8ySzzYJZq1qiv3vLphkRXbYyVpjEdPLyxI61byK3WemcdnT6ClcdEwJgIt1LEUOLqX6dhTfIIct6khXKtjTDiv8qjrkCJ/8R6ETALhkBnYW4IvxuaXA6ihni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dEJIRUQ9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e44537dccso1406099b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 19:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755485436; x=1756090236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VhIyc8lbfDWyD877vXvrvggoqpEeK0c8nmG+yxGdWw=;
        b=dEJIRUQ9YmQYPiTIMs0rhHVkh073GvAgvpCFL+ls5a91leB5uOhKJc8Z2x0smWpxMj
         j4gNKDxLflGjl2rvyVZ6gtYzBUNipnmxDNFw/FF+meNrmNCt+kDJiWRSgMMWu20ipEc9
         q8fUFv4VTKbe7Tht0Rh1cUWwSlt1CqjFEfV3N251jp1Qc0MUTQ5LV7V6NPWHa0sn+cf5
         O1gEJMhEeOc8Z8eYYFziY+Rg1BF2r6nbq9x/EJln9swiXf5fo3fXPcXa+GZBQxt5ShRA
         Pghy52bH2PJtB+qU8a1bcSMuEckI3XN6m0D3+5AUoeg+mwu02VkVuJdmG1GU1fpTXurR
         xFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755485436; x=1756090236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VhIyc8lbfDWyD877vXvrvggoqpEeK0c8nmG+yxGdWw=;
        b=JgfLgHXKlV2IwYn2oUGp4rD4m/+6H7Xb2cnq98lMyIV3SNxYhvswXctFs1Xi8GtRrZ
         925p3KwycWyJIZ8SB+UAHcOEEMpeG9nvqgYS8am2p/I5DWkQQAIlZ2DSKv97D6moyYc4
         95/y6uPY84V70b67FjTtNFr5pWfn46gLPTa6jC/kgIUuSRIAAFUJW8DzNIbAVr3L4zjG
         g4sgujaVSs+MQeZED0l7y5CfMprxK2RhMHtil6AP4Dui9YMJOd5L56+/gwDI7TagxOL+
         3gTlnhhrLccMkv//C5YSudB7EgSmgGYSGQ4OxerBeYdPtt8hfLgQNEY5u7tUY4MkuOM5
         vaBw==
X-Gm-Message-State: AOJu0YwkILge4Jl6L35Of59ytORJkVFBC+4cYW9GJGoHGqdUCYGKiISk
	jy0T2CTfFaM8sgaz1g5JCF8JqWzYmZwqVpPP6hQ0IfjfdJYPjhM1bPo0BwCNrOJrbA==
X-Gm-Gg: ASbGncuOqJvzAkyPcdiFN7Y0/IeHGC6Bp3LvhRaNi8PGNZ7x7lguxLCtLsJWe1+HrX3
	mujvYXUPgbWjyOnfdUDvA7qsjZYJhJ0bTF/WuZPD9vmFdUUiyHoClKV0riOVdXYYzvh9eKd0s/0
	P/aj3yJWr+9TYwdKANmSc+Zbfn+icOCYMiYdn5UbefSn/24Kh4FvY10vpzT9RPFNXM8yw+HTbSO
	+MKuLqxf60N8Q5+1gBaS/bk+9evTnZlIGCawHpVBi+iIqvC735i9c+MD95eiS+8IiSKPEysN1wS
	jNEH32KevourbP75uOUQNfH/NJUOUIFRhu/z8rS+7fDJQ1td4hK8+SJw8zIIJeo4ZL1prpGpUF+
	EHk0Fq3ZpyJIQeD1wbpdMw3k6xUY=
X-Google-Smtp-Source: AGHT+IEQe01kbbXSTNLoPxtH6KW3enwJneJDatvTrHCbl0isPhSo7JzYq3iJfhP3PzcTRovZjsLGkw==
X-Received: by 2002:a05:6a00:238c:b0:73d:fa54:afb9 with SMTP id d2e1a72fcca58-76e446fcdcbmr15841357b3a.7.1755485435557;
        Sun, 17 Aug 2025 19:50:35 -0700 (PDT)
Received: from bytedance ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45566fafsm5966960b3a.73.2025.08.17.19.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 19:50:35 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:50:14 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250818025014.GA38@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <4efdc1a8-b624-4857-93cb-c40da6252983@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4efdc1a8-b624-4857-93cb-c40da6252983@intel.com>

On Sun, Aug 17, 2025 at 04:50:50PM +0800, Chen, Yu C wrote:
> On 7/15/2025 3:16 PM, Aaron Lu wrote:
> > From: Valentin Schneider <vschneid@redhat.com>
> > 
> > In current throttle model, when a cfs_rq is throttled, its entity will
> > be dequeued from cpu's rq, making tasks attached to it not able to run,
> > thus achiveing the throttle target.
> > 
> > This has a drawback though: assume a task is a reader of percpu_rwsem
> > and is waiting. When it gets woken, it can not run till its task group's
> > next period comes, which can be a relatively long time. Waiting writer
> > will have to wait longer due to this and it also makes further reader
> > build up and eventually trigger task hung.
> > 
> > To improve this situation, change the throttle model to task based, i.e.
> > when a cfs_rq is throttled, record its throttled status but do not remove
> > it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
> > they get picked, add a task work to them so that when they return
> > to user, they can be dequeued there. In this way, tasks throttled will
> > not hold any kernel resources. And on unthrottle, enqueue back those
> > tasks so they can continue to run.
> > 
> > Throttled cfs_rq's PELT clock is handled differently now: previously the
> > cfs_rq's PELT clock is stopped once it entered throttled state but since
> > now tasks(in kernel mode) can continue to run, change the behaviour to
> > stop PELT clock only when the throttled cfs_rq has no tasks left.
> > 
> > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # tag on pick
> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > ---
> 
> [snip]
> 
> 
> > @@ -8813,19 +8815,22 @@ static struct task_struct *pick_task_fair(struct rq *rq)
> >   {
> >   	struct sched_entity *se;
> >   	struct cfs_rq *cfs_rq;
> > +	struct task_struct *p;
> > +	bool throttled;
> >   again:
> >   	cfs_rq = &rq->cfs;
> >   	if (!cfs_rq->nr_queued)
> >   		return NULL;
> > +	throttled = false;
> > +
> >   	do {
> >   		/* Might not have done put_prev_entity() */
> >   		if (cfs_rq->curr && cfs_rq->curr->on_rq)
> >   			update_curr(cfs_rq);
> > -		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
> > -			goto again;
> > +		throttled |= check_cfs_rq_runtime(cfs_rq);
> >   		se = pick_next_entity(rq, cfs_rq);
> >   		if (!se)
> > @@ -8833,7 +8838,10 @@ static struct task_struct *pick_task_fair(struct rq *rq)
> >   		cfs_rq = group_cfs_rq(se);
> >   	} while (cfs_rq);
> > -	return task_of(se);
> > +	p = task_of(se);
> > +	if (unlikely(throttled))
> > +		task_throttle_setup_work(p);
> > +	return p;
> >   }
> 
> Previously, I was wondering if the above change might impact
> wakeup latency in some corner cases: If there are many tasks
> enqueued on a throttled cfs_rq, the above pick-up mechanism
> might return an invalid p repeatedly (where p is dequeued,

By invalid, do you mean task that is in a throttled hierarchy?

> and a reschedule is triggered in throttle_cfs_rq_work() to
> pick the next p; then the new p is found again on a throttled
> cfs_rq). Before the above change, the entire cfs_rq's corresponding
> sched_entity was dequeued in throttle_cfs_rq(): se = cfs_rq->tg->se(cpu)
> 

Yes this is true and it sounds inefficient, but these newly woken tasks
may hold some kernel resources like a reader lock so we really want them
to finish their kernel jobs and release that resource before being
throttled or it can block/impact other tasks and even cause the whole
system to hung.

> So I did some tests for this scenario on a Xeon with 6 NUMA nodes and
> 384 CPUs. I created 10 levels of cgroups and ran schbench on the leaf
> cgroup. The results show that there is not much impact in terms of
> wakeup latency (considering the standard deviation). Based on the data
> and my understanding, for this series,
> 
> Tested-by: Chen Yu <yu.c.chen@intel.com>

Good to know this and thanks a lot for the test!

