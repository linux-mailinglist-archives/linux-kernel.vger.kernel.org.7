Return-Path: <linux-kernel+bounces-800643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F7CB43A12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A085A4B9D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D12FF659;
	Thu,  4 Sep 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CMYK39XJ"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6B2FF66D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985184; cv=none; b=jYJf+YhK9OOqBSnL4ytqhc2EjtBkESsddoGBbdpuHDJo0s0ASop9zJZNA1BgDMWWmXAVLV/p0IYqdogFq5G/h0YWrVYHEzO3jm8LVxM+l9kjz2NvwOvqtbKVXhH1HC3X96tONtcLtm9op87oGwfYj9Z9ZFiBgeuHZ7esGJk7POk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985184; c=relaxed/simple;
	bh=PwSjGn00ZN7GelJT7ke0FM4OnlhS7AsrYRcZDUAmBn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaqNgA1F0R95QlXFs+JZTF0HIxcrUiV2hEwjGdGFffjIroTr9rtg2SfcMXUFdnd4fComWOxnNZFM/wtCiWae+X8nw8pc72+tBITIU4hyXCW5ulVpWC4iF0CZPKUgykO47oZbDFI9mwAxlOx4gCiMvidtd5OL3MOFZIRszPFZ3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CMYK39XJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so735955a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756985182; x=1757589982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLReCpxjMu/hZ1BQ+dKz4HFiBTfFXSZ0qST+lyVja+c=;
        b=CMYK39XJSanLSS7RKlL5SZ3GGabvaxmpGzFzrKOlH8i0xmw7sRl4nvwTdBZBhxmVz6
         UdDgIyVIypuyhk2ABrI1qAXd0PW5K4FxMqhe9e+E6gm+FWgIzmMQmK7diYae2yPl8LDA
         urBE3d1WRNub9FOed+MFQ+dmIqzMSQmsPZDQxXf5IsH/zdNGWVVWmLYtWiobMm00DXgl
         e/ByCyHi1+xUPnu02xZmQJ0HnjF3GlXB7EiDBrSm/TDhgweVIjRRmsS9rQXvGKBKQbsG
         Y3z5TBakqZl9OELkHLDtfGewf2fVVa/b3uKgHXstasbhNy0A4GKWvzLa/Yygq5cNwq58
         UNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756985182; x=1757589982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLReCpxjMu/hZ1BQ+dKz4HFiBTfFXSZ0qST+lyVja+c=;
        b=RWBL6g/VsbV1NOGRU60HAAMy08aSpjd3BNKajpVeG5lV5xvI+ATW0pxL7slXiPIZpW
         PAMdn+EdM15g5ICkCj6BnGOLiEYCrhOqqglqsWalOEwX5nKoGstvned6VwLwJR00tTUZ
         8+z8jJ1G4h+BKH2EP/O+EhqNSQoH120sdHoOlN/w7R2TaY6LVzmI7gF7zt52+1QLoPGP
         Jc1/8cHiLrGYxiaE0kOOlWQqG3N+MTCBPVCss0OsrplJlVh7m3B0vGUK8Nq6x6ZUJOxi
         /eXJBvAUFNOtCbIT5qWgefaJ9LG2ZNvGTfgGMQiiTJKE6RVI5uRE1BX6HRF15sPBQrRC
         UhTw==
X-Forwarded-Encrypted: i=1; AJvYcCW2r1GT51VW3f+iSDhDdYTfi/dxSikpd8Y5wMUr6ZKFyvZZ7renpHfBkLCSNIg7thsu7Q9tH5kZJNivZPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHtSpNsjA+lp6/vQPunRkjSpnswfpDDE0vqcXnDZyF6PB0X2J
	dq14SH9SZzBk9TpJucLHpW4Sid07jsNHGo0SckLPMHDbACa5K8VarFARPwZ+j7DGCQ==
X-Gm-Gg: ASbGncsQtg0xqmHjlJoKmPbm2hTxIBfR9fTJvJFpINoupIIM9rm0Bbp/er9YIBp0nkM
	TAXK5W9BgY4qF5mQO2eqyYyGLakYW8m9yLIZDgzsiJoQawMBGLkffbQ0VWj7oOGOxKojjRY6NgD
	zvUAfbsPc9S+JBjldEt6yNkkKIomogO4fRtVy8C0BTP8JkZ87J9Uzmp+fQEnJZOOQHMAcg9bt4v
	fR1CdWBNK8aA8ISumnbqYJhTuD7SoBZr/CIFwP7CBSunR459jg8h/65yG5uQ1nuvc6CUDN/LhGH
	lTO/a33A4ZbhQLPknR665zuekVkcOxN77wu/HwZiLLvowV63IllopPbmzygj57FLoYtLsfbCXrk
	bU6aAyMxR+JhcKoyIKUvtGXwKcLodgxVwZN+vD7V1kSO8HInl0Q==
X-Google-Smtp-Source: AGHT+IH1PMnmT5pVJYcu0xdoSUPQxLXGgkkp2rhHMqt7Ev/gC6zb+uiME++pWPM1n4ZWqRV/BdQUcw==
X-Received: by 2002:a17:90a:e708:b0:32b:7082:b2 with SMTP id 98e67ed59e1d1-32b70820373mr5724489a91.23.1756985181804;
        Thu, 04 Sep 2025 04:26:21 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e5ad5sm20045907a91.18.2025.09.04.04.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 04:26:21 -0700 (PDT)
Date: Thu, 4 Sep 2025 19:26:10 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Benjamin Segall <bsegall@google.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250904112610.GH42@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <xm26jz2ftfw7.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26jz2ftfw7.fsf@google.com>

On Wed, Sep 03, 2025 at 01:55:36PM -0700, Benjamin Segall wrote:
> Aaron Lu <ziqianlu@bytedance.com> writes:
> 
> > +static bool enqueue_throttled_task(struct task_struct *p)
> > +{
> > +	struct cfs_rq *cfs_rq = cfs_rq_of(&p->se);
> > +
> > +	/* @p should have gone through dequeue_throttled_task() first */
> > +	WARN_ON_ONCE(!list_empty(&p->throttle_node));
> > +
> > +	/*
> > +	 * If the throttled task @p is enqueued to a throttled cfs_rq,
> > +	 * take the fast path by directly putting the task on the
> > +	 * target cfs_rq's limbo list.
> > +	 *
> > +	 * Do not do that when @p is current because the following race can
> > +	 * cause @p's group_node to be incorectly re-insterted in its rq's
> > +	 * cfs_tasks list, despite being throttled:
> > +	 *
> > +	 *     cpuX                       cpuY
> > +	 *   p ret2user
> > +	 *  throttle_cfs_rq_work()  sched_move_task(p)
> > +	 *  LOCK task_rq_lock
> > +	 *  dequeue_task_fair(p)
> > +	 *  UNLOCK task_rq_lock
> > +	 *                          LOCK task_rq_lock
> > +	 *                          task_current_donor(p) == true
> > +	 *                          task_on_rq_queued(p) == true
> > +	 *                          dequeue_task(p)
> > +	 *                          put_prev_task(p)
> > +	 *                          sched_change_group()
> > +	 *                          enqueue_task(p) -> p's new cfs_rq
> > +	 *                                             is throttled, go
> > +	 *                                             fast path and skip
> > +	 *                                             actual enqueue
> > +	 *                          set_next_task(p)
> > +	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
> > +	 *  schedule()
> > +	 *
> > +	 * In the above race case, @p current cfs_rq is in the same rq as
> > +	 * its previous cfs_rq because sched_move_task() only moves a task
> > +	 * to a different group from the same rq, so we can use its current
> > +	 * cfs_rq to derive rq and test if the task is current.
> > +	 */
> > +	if (throttled_hierarchy(cfs_rq) &&
> > +	    !task_current_donor(rq_of(cfs_rq), p)) {
> > +		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> > +		return true;
> > +	}
> > +
> > +	/* we can't take the fast path, do an actual enqueue*/
> > +	p->throttled = false;
> > +	return false;
> > +}
> > +
> 
> Is there a reason that __set_next_task_fair cannot check p->se.on_rq as
> well as (or instead of) task_on_rq_queued()? All of the _entity parts of
> set_next/put_prev check se.on_rq for this sort of thing, so that seems
> fairly standard. And se.on_rq should exactly match if the task is on
> cfs_tasks since that add/remove is done in account_entity_{en,de}queue.

Makes sense to me.

Only thing that feels a little strange is, a throttled/dequeued task is
set as next now. Maybe not a big deal. I booted a VM and run some tests,
didn't notice anything wrong but I could very well miss some cases.

