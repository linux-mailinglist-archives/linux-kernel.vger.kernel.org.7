Return-Path: <linux-kernel+bounces-799421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D0B42B68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3331B20777
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EFA2E173E;
	Wed,  3 Sep 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StkyQaGa"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199FC296BA2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932941; cv=none; b=YxyXfC7gdnFQ4JSkAMtlFvTCt0VkeTlVOTMGt8neh7SqaO2kTycHe/qtfm7laqT5hLhW1WrWhRi8N5lf8LCU35iemr6HbSWhx3gcyy7kWPFER8ITU0fCpCcvJ0NLoEMa/C3vpJJCO/0cMRsr3nnzz1+gVLmxzE6bfTlIM5/JCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932941; c=relaxed/simple;
	bh=HXCKfR62Xx9RdnrZGY+0VqCAH4dVGiyBP+YAU7J3d+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7/38jyKm81wo2gKfgIPdEYK54OH7ifAwmctsQIPUvkLI2WRkKxsesfWTgZIESrCa7LVlw/nWEEOlfdu5EoB4Yz3ar5dU462fVGa4VrXqHoxI5/SqEq2ZD/1maAcCFzGvY2i7uTEgan/LUkBhWXhyAU+YGMPDyTVmd/nxJAWOek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StkyQaGa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7722c8d2694so351648b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756932939; x=1757537739; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLuNhtTsg39/Hr+YCZaZ9hz0VEg/KjFbcAeEONJc7mM=;
        b=StkyQaGaLDthDKpGioGVYAo340ahhKmYi6sn61roPwuV9AtpzyaBWd659NsO++7jgE
         d/RfiETW3vmj4MiFHGLF17Mx6p8VhVgBIfmJsDs0NN95bJJ+vobJvRo75ZRf4KnobkIG
         1fCDj1vW3MZuDecglb/JK7mN9sx+bK8vkaVgX4cRESr+MIxzOslyw26Wudm9l34u6Mup
         Yj6ZHszhvMIs0AC1ddx4VjAzwarRdRucXyHMVohI+2mParLcyNyWmdDClbG4DymKc8iy
         5iKvIP4s9jICdmCBMKWxvHY6Y5ElIN/XRkDr7yPWvmd3Ib+crIqC4GMmARyWH773WFOk
         MYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932939; x=1757537739;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLuNhtTsg39/Hr+YCZaZ9hz0VEg/KjFbcAeEONJc7mM=;
        b=eeGCo1+GcqQ/woQuC5oQ3zlXQqogXdJ+pRwoRWVwmEKBFy2K8B2QAdr5nG6Ul8TO5u
         hu3sf7nZfpR0efNFYaFGSEmbo/cvo66Om4Ycxe6+1LLynBohrsJlTXUQ+Bi3WAuP6sXt
         k1gJFvkH0h02E2s3ozgO3ZsO0kqdVYucrzmZTXa/pJCddF3bt5jyBfuHkvINLP4sDRC3
         SVxcbV+jATcxKtPRMSqEsPyG9z9Ab1oE8EmOpP8esMU+iSGLsKEF474hNl04gZMVnBtM
         tV7ApZIRjEkExcd7DOQhgb8p0qAoNZBGrmauRozDcrgah7hYKZQF6+XgyuY4jjyOA1+M
         ODCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL99Tbo2doN6a+3gKfGAGuceLerwEMgE/CSYUgqxNnTG0ekhHcwvcbnYaCEyHfz655cN0hvKfahf6AQFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySLzGtIQP5nc3Ketloi7GoBoAPujHaMsnGs9/AG38R1q6rrf/A
	6vw8CG2YGLp8/UoOcRSrLee7qX0NG8edOrb3GGCEBkHleibXddxjwC/+lJxOAlyHnA==
X-Gm-Gg: ASbGncvoB5Xtx5euAa+K0Dn7Vocvb9cG2u1GwXmh/uxPWOQXYXS+uxC9TI8PJc0YKcg
	mfmPb3mBgiucbPmERIIXMv5fpqQqGsx0ltYnVEcIw3aNPbz40NLVy79RJzNiDaak4uYJiiNNOdA
	wYDZlGPdbVASliB9Xb9+LcYgWYC0507ZtdlNaA9j0ngTPLRUr9G49MWZ0Neowwql1wJz0qwtBiC
	W4JGl8aDpg+I81H1j2/I1yliLI1w0TOyCI59qBmuS1jBKBB7wEcD7MkmtFubbNognIHA6uz9PdU
	15hOBYFhviWRkSYHKJFgPKkiz107TnEhtoMl7U/FFISWUhyygsE8TU66bXc2MMTma3z7A91VfsX
	MCtk+LHPk9qUJbsMNssg21GVpnMbzKnv6+wOpQFW38O04DiEMzJW083W9ohis+9wcxB+DK2BlcY
	g=
X-Google-Smtp-Source: AGHT+IEbVLqIJT4748lkyOmpQDJNT/RT3JObSMFw8D5f4RZbFfkZVg82poK6PUoVig85EqyJFtJxCA==
X-Received: by 2002:a05:6a20:4322:b0:243:b576:e1b1 with SMTP id adf61e73a8af0-243d6f09abfmr25373612637.39.1756932939066;
        Wed, 03 Sep 2025 13:55:39 -0700 (PDT)
Received: from bsegall-glaptop.localhost ([2a00:79e0:2efc:9:2cc5:e7bd:145c:10aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f095d3esm14232758b3a.97.2025.09.03.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:55:38 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>,  K Prateek Nayak
 <kprateek.nayak@amd.com>,  Peter Zijlstra <peterz@infradead.org>,
  Chengming Zhou <chengming.zhou@linux.dev>,  Josh Don
 <joshdon@google.com>,  Ingo Molnar <mingo@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  Xi Wang <xii@google.com>,
  linux-kernel@vger.kernel.org,  Juri Lelli <juri.lelli@redhat.com>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Mel Gorman <mgorman@suse.de>,  Chuyi Zhou
 <zhouchuyi@bytedance.com>,  Jan Kiszka <jan.kiszka@siemens.com>,  Florian
 Bezdeka <florian.bezdeka@siemens.com>,  Songtang Liu
 <liusongtang@bytedance.com>,  Chen Yu <yu.c.chen@intel.com>,  Matteo
 Martelli <matteo.martelli@codethink.co.uk>,  Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>,  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
In-Reply-To: <20250829081120.806-4-ziqianlu@bytedance.com> (Aaron Lu's message
	of "Fri, 29 Aug 2025 16:11:18 +0800")
References: <20250829081120.806-1-ziqianlu@bytedance.com>
	<20250829081120.806-4-ziqianlu@bytedance.com>
Date: Wed, 03 Sep 2025 13:55:36 -0700
Message-ID: <xm26jz2ftfw7.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Lu <ziqianlu@bytedance.com> writes:

> +static bool enqueue_throttled_task(struct task_struct *p)
> +{
> +	struct cfs_rq *cfs_rq = cfs_rq_of(&p->se);
> +
> +	/* @p should have gone through dequeue_throttled_task() first */
> +	WARN_ON_ONCE(!list_empty(&p->throttle_node));
> +
> +	/*
> +	 * If the throttled task @p is enqueued to a throttled cfs_rq,
> +	 * take the fast path by directly putting the task on the
> +	 * target cfs_rq's limbo list.
> +	 *
> +	 * Do not do that when @p is current because the following race can
> +	 * cause @p's group_node to be incorectly re-insterted in its rq's
> +	 * cfs_tasks list, despite being throttled:
> +	 *
> +	 *     cpuX                       cpuY
> +	 *   p ret2user
> +	 *  throttle_cfs_rq_work()  sched_move_task(p)
> +	 *  LOCK task_rq_lock
> +	 *  dequeue_task_fair(p)
> +	 *  UNLOCK task_rq_lock
> +	 *                          LOCK task_rq_lock
> +	 *                          task_current_donor(p) == true
> +	 *                          task_on_rq_queued(p) == true
> +	 *                          dequeue_task(p)
> +	 *                          put_prev_task(p)
> +	 *                          sched_change_group()
> +	 *                          enqueue_task(p) -> p's new cfs_rq
> +	 *                                             is throttled, go
> +	 *                                             fast path and skip
> +	 *                                             actual enqueue
> +	 *                          set_next_task(p)
> +	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
> +	 *  schedule()
> +	 *
> +	 * In the above race case, @p current cfs_rq is in the same rq as
> +	 * its previous cfs_rq because sched_move_task() only moves a task
> +	 * to a different group from the same rq, so we can use its current
> +	 * cfs_rq to derive rq and test if the task is current.
> +	 */
> +	if (throttled_hierarchy(cfs_rq) &&
> +	    !task_current_donor(rq_of(cfs_rq), p)) {
> +		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> +		return true;
> +	}
> +
> +	/* we can't take the fast path, do an actual enqueue*/
> +	p->throttled = false;
> +	return false;
> +}
> +

Is there a reason that __set_next_task_fair cannot check p->se.on_rq as
well as (or instead of) task_on_rq_queued()? All of the _entity parts of
set_next/put_prev check se.on_rq for this sort of thing, so that seems
fairly standard. And se.on_rq should exactly match if the task is on
cfs_tasks since that add/remove is done in account_entity_{en,de}queue.

