Return-Path: <linux-kernel+bounces-808110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8211B4B0D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFFE1C2548B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AD732C30D;
	Tue,  9 Sep 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JDhUUnvh"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E92C1780
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419577; cv=none; b=k4oNyMcQpm5mO/xpPG2au59E2p/LGgsmYqqoFZsGNYECyFX5kq4IW2s2diSXOPyCHRt/NkGUkQjGzcl/HcAryESfk/re/ufcLEUL4AFBjZC60pYnJGcLU4EKaH35GKwsPljXqaijRH+UcO7Cf+ujpILu/TSyq4NhNX7I+BmCOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419577; c=relaxed/simple;
	bh=dTUUOGVXzgaBRgrWf4dD8/aZJutd88vOU+FwxGlU5QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyjFG0OH2DJx8y4juzicwjz/EERVMwTSsyU06t3p03igFJMRcFjGde9d1Ha+Lj6z4mYCX1BWKN6YG57rCK9GNcczXytDKjGCqvkv7HrJL6SiieOvf8jNxRE/0abRa4gFydZWnHvF4Yn64fQB/OUJ/shRfLr1YOvCXQv3aFnKbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JDhUUnvh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso4960088b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757419574; x=1758024374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6C8y1JVKk97i0jtD9cReVmUMzN4ri5HibTv4NinnwsU=;
        b=JDhUUnvh1+9zmzmxrlMNbGCnDyybSwt0pxx4kjr7ctATJRmcCFyr+niM8n7jhn9am7
         nleExd97JyUgUdxvTyZ5FX92lg//knXiYQUQbaunKVs6rTDQbrPjkREDzbGt9Qiz2g5S
         2xt317AXxZpowh2y2uPqTMABI+1WPKd3W0gqOjX6mytzr8LQnYYVdwkn3YY8XJbMIEKd
         yoqzEUZDYCZ3fg0sB5mU8WhA/pb7feqE4OAhsb4GR+H3SehOnbr/3CwaAYRfzKX+3hBB
         qSedOgQPrN9uuD0IBdKuAdDposQ+ECke6BCgqyEmtqM2CBYlOln5UBG6sPT88IXTgjWB
         7Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757419574; x=1758024374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C8y1JVKk97i0jtD9cReVmUMzN4ri5HibTv4NinnwsU=;
        b=Wu2+Z0J4YJskwFiSAhUUYvJ91BwMY3I8y6QLzxnIWFmycK7KgLe7m/pWOqxTtZEHKx
         VHYtO5wRUq5X+A6Ht0/IW8W5ieNNDBP5V5mXiBy7WY4RtsNMugB4SFtSASoifl904kLw
         P4iKX7y9qBkdt1xu39W+FaZ+0CZhcS+4n/CQNzsNbDf7D9sVqWj+2uH10Bho5FrB3QFl
         D91muvQ06gjtwRYnStXOk0BNgjP4Bh59Harzx5CGYTZCI8EOlpLCMjKQggni//bgo+co
         87Ud9FhuJ+yVEmm2bVAIfqeS50NkdNXmVTtBaIRVSJP1eR3cGinFPb3hjFQtmCHdKa2V
         E5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYTbgICRylXrM835xZFf9BfX/inUgyE11t9WgYt0L4/xVV+1r0dyKCPdZXgfaG63sA+8OmZmzFK7dircc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLWrxdN8wJ+kJTXLqiRCTX6yZxp+3VJX/kI3HOygUmHXP2a+f
	HRtKlpVkWjf85WvRX8upd2giCHbcFOMxPdIUL4KKJCKQFbko9GVhUpWiZeo4qjOkHg==
X-Gm-Gg: ASbGncukU1gDZ74CGgfMrl0Ia6gX6DmTFFEqsS/Bvx1bOEpD8oG6i33X5ml/aRcKfzX
	eYyoVDEgcvECNp1c7JjTbrcHWdgXuLfMrkyN6Zg3aEHutDKCVEJ8F3YoN0TM/cxnTuLMQPlVJxQ
	VgUMQpKmSPiOtWCCBdLPX/b6CyXD/2nvK0mNtf7rlHvUZpA39JcwsQglnUsPHaYtSgPp/RQesYm
	WSdrS5vVkzaginWJe0EyaQwalG9UYqMsDg90mPNrhv6xz0b9OBtbKNCn+/J8RFPbiuH/UzopeE7
	usTD49+2FXPP464NmR/D1xVZPCQXqK2MZDhkMG+483NUHLZgaYxV+XU9wkd/tXE11zkE/ePBEC8
	PL3R/VWakpkepfxI6MarwGVOd9Wm56PzhK2K41LK3Ah773NhuMarb4qOdzZ59
X-Google-Smtp-Source: AGHT+IFBiGgQVqO+VBzN+gpd9EdxdpfseVBXdsYWl4G2cg34NY1NNSBYoMu4HzcVzmNLifbv4Bl9Qw==
X-Received: by 2002:a05:6a20:1591:b0:245:fb85:ef58 with SMTP id adf61e73a8af0-2534519d16bmr17001811637.40.1757419573665;
        Tue, 09 Sep 2025 05:06:13 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0736ba7sm28235655a12.12.2025.09.09.05.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:06:13 -0700 (PDT)
Date: Tue, 9 Sep 2025 20:03:41 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Benjamin Segall <bsegall@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
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
Message-ID: <20250909120341.GA90@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <xm26o6rrtgav.fsf@google.com>
 <20250904081611.GE42@bytedance>
 <da9141b1-d717-493f-939f-85e23d46e7ba@amd.com>
 <20250904110504.GG42@bytedance>
 <xm26frcwtgz2.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26frcwtgz2.fsf@google.com>

On Mon, Sep 08, 2025 at 08:58:09PM -0700, Benjamin Segall wrote:
> Aaron Lu <ziqianlu@bytedance.com> writes:
> 
> > On Thu, Sep 04, 2025 at 03:21:06PM +0530, K Prateek Nayak wrote:
> >> Hello Aaron,
> >> 
> >> On 9/4/2025 1:46 PM, Aaron Lu wrote:
> >> > @@ -8722,15 +8730,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >> >  	if (unlikely(se == pse))
> >> >  		return;
> >> >  
> >> > -	/*
> >> > -	 * This is possible from callers such as attach_tasks(), in which we
> >> > -	 * unconditionally wakeup_preempt() after an enqueue (which may have
> >> > -	 * lead to a throttle).  This both saves work and prevents false
> >> > -	 * next-buddy nomination below.
> >> > -	 */
> >> > -	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
> >> > -		return;
> >> 
> >> I think we should have a:
> >> 
> >> 	if (task_is_throttled(p))
> >> 		return;
> >> 
> >> here. I can see at least one possibility via prio_changed_fair()
> >
> > Ah right. I didn't realize wakeup_preempt() can be called for a throttled
> > task, I think it is not expected. What about forbid that :)
> > (not tested in anyway, just to show the idea and get feedback)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cb93e74a850e8..f1383aede764f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -13135,7 +13135,11 @@ static void task_fork_fair(struct task_struct *p)
> >  static void
> >  prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
> >  {
> > -	if (!task_on_rq_queued(p))
> > +	/*
> > +	 * p->on_rq can be set for throttled task but there is no need to
> > +	 * check wakeup preempt for throttled task, so use p->se.on_rq instead.
> > +	 */
> > +	if (!p->se.on_rq)
> >  		return;
> >  
> >  	if (rq->cfs.nr_queued == 1)
> >
> >> where a throttled task might reach here. Rest looks good. I'll
> >> still wait on Ben for the update_cfs_group() bits :)
> 
> 
> Yeah, I think I agree with all of these (this patch and the previous
> patch); the preempt ones are subjective but I'd probably default to "no
> special case needed for throttle". Removing the check in
> update_cfs_group() I think is correct, unless we want to freeze
> everything, yeah. (And that seems dangerous in its own way)

Thanks for all these info, let me go ahead and send these changes for
review then :)

