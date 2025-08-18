Return-Path: <linux-kernel+bounces-772764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6C2B2973C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9401D7A6436
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4956025D53B;
	Mon, 18 Aug 2025 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k1I+1mbu"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5825CC74
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755486749; cv=none; b=MMDQeExQ6vdC0ZYYyHQVGmMBStUcOH1Nv0CAAOOdjoFFBQGhM9CFzNPZcT0KNd3ZSvDKy71znzRM72LxtKnl+tTBWF1c3oIuoccdYhA1MxgP/nRD8HBjfRVtalN3z6uAmtTVpXCX5KWvd0F7YuwOjpx0HGYV3m+srt6A+LpfF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755486749; c=relaxed/simple;
	bh=HVV+itzUIWf6CugHY40rZQP46SSO/jBl8q44fbS/NfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbfJBwkOUlFyAIgpGORWsq/kj8YbyCJiAilKE62uKULqlqUcjojCa+nNJ8fEGJi0QA1+bQSZ+idYgasOzB74QLaG6hRDNIeEGjsp84BgZxADqlyR8C5jK6gAxyX2ZwDPX0zy8LMBYt3c+JBf9zHm6hlqMRdZfQpNss2vzPrhR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k1I+1mbu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47156b3b79so2730206a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 20:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755486746; x=1756091546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYMYI1FZD4t3cGUk1rpHMrjRrzO7a6K5gMlONlyOvP0=;
        b=k1I+1mbupYCKFr9wILj/Zrnd03DDvOh4zFOsjesFvVHjRj6IZ2/MVOsUe4N5spTAY+
         x4t/W8l7E3WUEEH34L2hu02lKBx7dV/mCPnWeGetR91z/AuNC2Sq2q3/zoKj5LZpF2Gu
         KHBw5Sr1jMQCiT91yiqF3CeKOBfV6Jkf2ug05U7efHLeNMlLvoM9b0VRd7u/fpytlc+G
         byRZ5pEaxJQx/B2JjAage+w1voWvF9wAc0eq/TMLC4E211sVFFI3BKMaSNBjVr0ij+MF
         DvOvL5XbmYV6AcYsQhKs8NfFVsiwWihrvO0jqZSnphWBf9nUZXTtW4gKjFjCcaBpf4dF
         oyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755486746; x=1756091546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYMYI1FZD4t3cGUk1rpHMrjRrzO7a6K5gMlONlyOvP0=;
        b=ZQQHZDqzF58b3uxb/Gueg8DEsLxFhAemiUIpEDGjBmBzQ777inTSb/siPXEj4pnaWN
         NhtIZPvMkIdYz8Q4RrufnNhZHrzXoT/pumOYWFgw16L7GS+MQSQxB2r3vY44dp67fxn0
         X4Krl7rgGyu1HGeZz2Xyx1vZc2UsaipLwOHHuav8n7PA3/8GBAQSJSFPozdewYNQQTdj
         HQYxQJwEwXH1riRDjj4+MByPp13VFTK2eARSXcoSibRuQ9EEr37P4ZtXrAVbBCYH7HMq
         zFRp6Cy2YBdK0QUpKHZAgHCePH++G3CxFHnsTuYk08huMXnGadafzvw/18n9eHcvFa5H
         rWGg==
X-Gm-Message-State: AOJu0YyxmON5bWkdAFNztJJiKfXgyxFFDM0qjaF9k1Wx42wL/zmv65Tv
	yiCA5Omkw2zJtd+H0ExcM70OHLHQxiIChe+ESPg0NuWpw1LJKLd6xsaPUp7dhBmA0g==
X-Gm-Gg: ASbGnctmOGOEdaORWKSrChZL1rfb6qajLBbVBTQyJVHSKS+oDDxnRDwew+3cSVU5HH1
	muWv8IvtnW1AS1sqNnHdmHf84BAy9OCUx3p8gzzt2PO8mrswFZMfBcEUTTw7Tpjm9TZd3+5lnuY
	tT/qVXqPelyBocRqQnh1IZmD787nC+/Tq63VvVU0i9qK0O1rl+Rr7/t66TN8X1/52PnJ853hE0G
	gOzCpeYda+CdjxGRhHw4qs/khKH/N5CkpfaQuwH+HbGOvSwscFvqhgkxxec7bzgv4sphEVMkAHv
	hjST019m0emS70R9LWobPqfoi7QLs/VBmL4BMvFzsD9VqWBHvTdXdkFixDW299OQcIaVDX6u+cx
	PG9Vh+9hPGg4y/HFEgsW8O0xR0obw9rVKFkD54EaYqm2bTxY=
X-Google-Smtp-Source: AGHT+IH2xPU11ZST8X1fAWIz8YRu6tO6IqSsnjvisdau2WpIkvGgcr7Z2Tco6sHga90yooPUxn9n4g==
X-Received: by 2002:a17:903:2ac4:b0:234:986c:66cf with SMTP id d9443c01a7336-2446bdad7e4mr155969985ad.16.1755486746372;
        Sun, 17 Aug 2025 20:12:26 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446c2f441asm66167505ad.0.2025.08.17.20.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 20:12:25 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:12:15 +0800
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
Message-ID: <20250818031215.GB38@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <4efdc1a8-b624-4857-93cb-c40da6252983@intel.com>
 <20250818025014.GA38@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818025014.GA38@bytedance>

On Mon, Aug 18, 2025 at 10:50:14AM +0800, Aaron Lu wrote:
> On Sun, Aug 17, 2025 at 04:50:50PM +0800, Chen, Yu C wrote:
> > On 7/15/2025 3:16 PM, Aaron Lu wrote:
> > > From: Valentin Schneider <vschneid@redhat.com>
> > > 
> > > In current throttle model, when a cfs_rq is throttled, its entity will
> > > be dequeued from cpu's rq, making tasks attached to it not able to run,
> > > thus achiveing the throttle target.
> > > 
> > > This has a drawback though: assume a task is a reader of percpu_rwsem
> > > and is waiting. When it gets woken, it can not run till its task group's
> > > next period comes, which can be a relatively long time. Waiting writer
> > > will have to wait longer due to this and it also makes further reader
> > > build up and eventually trigger task hung.
> > > 
> > > To improve this situation, change the throttle model to task based, i.e.
> > > when a cfs_rq is throttled, record its throttled status but do not remove
> > > it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
> > > they get picked, add a task work to them so that when they return
> > > to user, they can be dequeued there. In this way, tasks throttled will
> > > not hold any kernel resources. And on unthrottle, enqueue back those
> > > tasks so they can continue to run.
> > > 
> > > Throttled cfs_rq's PELT clock is handled differently now: previously the
> > > cfs_rq's PELT clock is stopped once it entered throttled state but since
> > > now tasks(in kernel mode) can continue to run, change the behaviour to
> > > stop PELT clock only when the throttled cfs_rq has no tasks left.
> > > 
> > > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > > Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # tag on pick
> > > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > > ---
> > 
> > [snip]
> > 
> > 
> > > @@ -8813,19 +8815,22 @@ static struct task_struct *pick_task_fair(struct rq *rq)
> > >   {
> > >   	struct sched_entity *se;
> > >   	struct cfs_rq *cfs_rq;
> > > +	struct task_struct *p;
> > > +	bool throttled;
> > >   again:
> > >   	cfs_rq = &rq->cfs;
> > >   	if (!cfs_rq->nr_queued)
> > >   		return NULL;
> > > +	throttled = false;
> > > +
> > >   	do {
> > >   		/* Might not have done put_prev_entity() */
> > >   		if (cfs_rq->curr && cfs_rq->curr->on_rq)
> > >   			update_curr(cfs_rq);
> > > -		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
> > > -			goto again;
> > > +		throttled |= check_cfs_rq_runtime(cfs_rq);
> > >   		se = pick_next_entity(rq, cfs_rq);
> > >   		if (!se)
> > > @@ -8833,7 +8838,10 @@ static struct task_struct *pick_task_fair(struct rq *rq)
> > >   		cfs_rq = group_cfs_rq(se);
> > >   	} while (cfs_rq);
> > > -	return task_of(se);
> > > +	p = task_of(se);
> > > +	if (unlikely(throttled))
> > > +		task_throttle_setup_work(p);
> > > +	return p;
> > >   }
> > 
> > Previously, I was wondering if the above change might impact
> > wakeup latency in some corner cases: If there are many tasks
> > enqueued on a throttled cfs_rq, the above pick-up mechanism
> > might return an invalid p repeatedly (where p is dequeued,
> 
> By invalid, do you mean task that is in a throttled hierarchy?
> 
> > and a reschedule is triggered in throttle_cfs_rq_work() to
> > pick the next p; then the new p is found again on a throttled
> > cfs_rq). Before the above change, the entire cfs_rq's corresponding
> > sched_entity was dequeued in throttle_cfs_rq(): se = cfs_rq->tg->se(cpu)
> > 
> 
> Yes this is true and it sounds inefficient, but these newly woken tasks
> may hold some kernel resources like a reader lock so we really want them
                                               ~~~~

Sorry, I meant reader semaphore.

> to finish their kernel jobs and release that resource before being
> throttled or it can block/impact other tasks and even cause the whole
> system to hung.
> 
> > So I did some tests for this scenario on a Xeon with 6 NUMA nodes and
> > 384 CPUs. I created 10 levels of cgroups and ran schbench on the leaf
> > cgroup. The results show that there is not much impact in terms of
> > wakeup latency (considering the standard deviation). Based on the data
> > and my understanding, for this series,
> > 
> > Tested-by: Chen Yu <yu.c.chen@intel.com>
> 
> Good to know this and thanks a lot for the test!

