Return-Path: <linux-kernel+bounces-800576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58243B4397E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135013BA465
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2C2FC002;
	Thu,  4 Sep 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OENaUDcb"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186372D060C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983919; cv=none; b=Gfff72EUSgOvC19cigb8dF/kVhH4F1vCFbq/U/O4b7NIQLtoK6WVo7mA5w/HMtqFMvzBmZ/Kau64pGQcenUUsuBMJwkdmbvnQTXP0lhcytbDwVEBL2Y3f41Fli+vvOjc9G6FD2teVeiVDBbwiJ28e6EeZ4frPyizSgRFl2OL7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983919; c=relaxed/simple;
	bh=HthRouz1wbkfvlCxNwQc5tooP60v7rJjd3WRFFx5608=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVm1tlS7GR/9srlMODL5fBreRclmtt3OVda1v/w9Kax7Hhu5beRZ6e3cmYldlMMDNdM01TjkmEOJfVBZL5iPwR1QlkIsUc23n1ohGDB8F1oRYe0qIFK3x96Hf/M5DhQI2SQ1w5wobc/weFBYTvNO2N9mONgcgb0xRRNJMHMnu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OENaUDcb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266cdf64so646820a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756983916; x=1757588716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FR29r6kQ/obU+hIfpjuirh4UjOrHiOEU4iCiBT1+uKg=;
        b=OENaUDcbrjsninSiazzldkecLRuCi2/ecC7w/gWwj6JMAm9WZ2NGSCgp9yxs0wVzuJ
         ObVfxf6NsQak+u8qxs5PIiCT7CBm6kSaqnY94aZFaMK4cWo9FwEWmk3lTgWdaJBodxml
         Fys2HlmlwbsLo2mHiYdjxw9dYmZnFbrDJ9XGDMQher/ZHhygAs1F5N1Z38N1dEOZ6NtL
         3GU4D4/CyyTw/Pk1Oc0BsIavtAkmAyDzA76KQl/Mk8WLRzRK/IZiwLG5/xnH17uC+eN+
         KwOX/4CuPaKnXB9PlJdYUsu+//BZoPVMNwiz7advaNJLyE8Mh+PxC81ElN8T7FhxYkus
         uVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756983916; x=1757588716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR29r6kQ/obU+hIfpjuirh4UjOrHiOEU4iCiBT1+uKg=;
        b=AkLZc+qQFg1DVk/cdMqAChyOUDr2Z0dPMTh4WB7J8g/e1XSz5kowNi4YTw9xN0woUI
         zQnPV0ajvK7qh/jFRrwE0MBvLldQjb8aQ1jabWlp8E7lvCCquvav9knyaoP9rNQ+/XjQ
         jlM/bJp6YAgEom+hb2xUQ09Y5LOh3QQrstiW0ebWNt94WgXKgJR/RcHtzsM5J6zWJygx
         hx3udOB0pKLV88Tj+nEeHFP7kb8n//gvfQE0dhuL8Ij6WWfQidqrfdYNINe+i+YIUZuO
         fmavyx0PN8P43o6PRGWHVoXPXa8GSJ7wSaAcJWyvuSvgoV8mkVrwgTfdQVCOoy4S8fJd
         VyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxqEWt6azY249p5v2lgVeSLRBht9hXVyQ01g/tJJC+pi/v6ye4sRX9FDGZHiejXxbUg2yVkc+3Cl/prHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUqQaeX6xAV58TSlsunjUh8t5sGsqzr6Sp0SFBXgy3n9kGTPw
	Ld4xN+DqQXPPKno8aevwQVAjpdBf7/V17tPO9v8+29vR2JwyLck1jlQu+QTiCoo1KA==
X-Gm-Gg: ASbGnctUDu24syG3c1hrnb6TpaDr7ejAnI3VwItkYiY9q1PLmWSpAFoH8yKsvJwl3Z9
	KJ79m4ioIFnG/2IML0s0iJtChuOQR6hWy7tXNvgqqgvSBLAAaYhUA+l9k2WMxPRZKe+snSxHjzW
	9WLuUZjvSxxIxc6xF2zuJkcY1AdDqz+SC8WRXBmmNtlugwTA/5aYXxIpY+2ckB30mNZHjCn85eb
	784k6UIwMNL6HMMVvUoeFO796wbOw2IS/VVJtYZK9ldC8whisjgBWKx174OXccQcdHzSCP5ydU7
	r5pCLVzDBHa3di1GZlU+mn3QBkwZD3haEclzqR4HIu4b4U2WtsmXXlKo13ZCZk814tJq4vQNWpW
	o2R9Izk4UmOSD7zTj0/qNr4jLEb6rrP2bP5JxJ2u1Q27g/YNT2/EIYIaBpjRb
X-Google-Smtp-Source: AGHT+IE2ApTZe3W9ZtEMaeLcjfMIPxN576p003nkbzr8TTxjYyb3mCysAKEPDoPaEWk5DNHt14E7ig==
X-Received: by 2002:a17:90b:55c7:b0:327:ba77:a47 with SMTP id 98e67ed59e1d1-3281543610dmr28899974a91.15.1756983916112;
        Thu, 04 Sep 2025 04:05:16 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a090c77sm18907239b3a.0.2025.09.04.04.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 04:05:15 -0700 (PDT)
Date: Thu, 4 Sep 2025 19:05:04 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Benjamin Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
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
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250904110504.GG42@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <xm26o6rrtgav.fsf@google.com>
 <20250904081611.GE42@bytedance>
 <da9141b1-d717-493f-939f-85e23d46e7ba@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9141b1-d717-493f-939f-85e23d46e7ba@amd.com>

On Thu, Sep 04, 2025 at 03:21:06PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 9/4/2025 1:46 PM, Aaron Lu wrote:
> > @@ -8722,15 +8730,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  	if (unlikely(se == pse))
> >  		return;
> >  
> > -	/*
> > -	 * This is possible from callers such as attach_tasks(), in which we
> > -	 * unconditionally wakeup_preempt() after an enqueue (which may have
> > -	 * lead to a throttle).  This both saves work and prevents false
> > -	 * next-buddy nomination below.
> > -	 */
> > -	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
> > -		return;
> 
> I think we should have a:
> 
> 	if (task_is_throttled(p))
> 		return;
> 
> here. I can see at least one possibility via prio_changed_fair()

Ah right. I didn't realize wakeup_preempt() can be called for a throttled
task, I think it is not expected. What about forbid that :)
(not tested in anyway, just to show the idea and get feedback)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb93e74a850e8..f1383aede764f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13135,7 +13135,11 @@ static void task_fork_fair(struct task_struct *p)
 static void
 prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 {
-	if (!task_on_rq_queued(p))
+	/*
+	 * p->on_rq can be set for throttled task but there is no need to
+	 * check wakeup preempt for throttled task, so use p->se.on_rq instead.
+	 */
+	if (!p->se.on_rq)
 		return;
 
 	if (rq->cfs.nr_queued == 1)

> where a throttled task might reach here. Rest looks good. I'll
> still wait on Ben for the update_cfs_group() bits :)
> 
> > -
> >  	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
> >  		set_next_buddy(pse);
> >  	}

Best regards,
Aaron

