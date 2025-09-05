Return-Path: <linux-kernel+bounces-802751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0CDB4567D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A362CA41032
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49E1345721;
	Fri,  5 Sep 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O12qZHj8"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D1166F1A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072256; cv=none; b=Rlv7BF95fJXmEVpfsUhbOlj6RAnqFTVurzY4vi4yPdQguObMQdqKRwwiRKvXp03x2Ld8pFEiv1bCtG5PZj++xOFGLTXP8F56p+YjR7E1GbY6dldjLc5+97kY0QVBjD5MkAbCrzlcaUYCQHET0ES0KeEAXjf3Cd/t4GMlH0s1IoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072256; c=relaxed/simple;
	bh=avNbLLm9e9Ta3S76+2w2Fme3j1rZ3Ppkpq5R0RkvrM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkyTEnvXSMJUc2A5/O2qZZFtodF4Dt+PTFfW8EU9NFyVb0lEHYZH8EEtHaCCiLhzy/2tgR0apNLWiItcm1NtmQwmDL3VW3x9AdUjST27skIz8m5J2wu9xlUCsO/i436nHloXvoVOeZUK5pEPBroRdyXvtN4Z8qnwN0UJ5nz0oJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O12qZHj8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so2665147b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757072251; x=1757677051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIlcMsuKf7m9put4yLNSq+qSX+jmGO1EXe5mqywnCSM=;
        b=O12qZHj8GAFDt1D00olm7pB+3edgDF1PZv6ShRGVNpEoBTvcMej0zqxvnwQo2xHsDA
         20As37hlh+yBYeM9/8Oi3lB9YWr9olt7bpaoSn+/8mzbPqlWkc1taFCMo7IsrVwhe7Gl
         L++wVdB5LgFQ7RejOXGMWaDqJ5dZcq9rldK5tQmu50LEc3CzBa7P3/KFADKRYbpUYysw
         ZiFkz4rGhnwQTiUWFCwKyTvunMK76GVe6T3YV4A+cbztwray2ZldmkGNzFOXTCtwJOTp
         l9I7yU2OmtUN7sf2rseXJLvI3L7FEjr5WrZF5MQkZLaN3Vg3TlAIo1OTFTExF17vXrvp
         1olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757072251; x=1757677051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIlcMsuKf7m9put4yLNSq+qSX+jmGO1EXe5mqywnCSM=;
        b=koqDWR+XpoVCb57G6MOPq7DY5l+rhPRMej/D9teyP4ox8klPGvIHllPjeidBdtqkJP
         Mgoybb3a2u4tBnQ8BuecG/nbOxKfBi8gtWO2chBs7KCxx8zr2+KggNHLAMGHcdHP+f8I
         gvwhQGSIo817bwPB99yKrSz9VJlrqkKPfy9re8h1ZIdqLhCBQ/BuIJB0S+ZRt3bZQQMu
         mxyy8+HW60DGSbigq3uzqEEgBVmRvr+tawWBfwxnwWQwkfjDspvyerpp2IJ/Bg9nxJNs
         FHJVff9hih661U2eH47HW+MGIyW6O5T2ZknKfGZkvd/GgQElBP0/hGLfyzLG9gNXxcRs
         y/eg==
X-Forwarded-Encrypted: i=1; AJvYcCXsngti3XzC3O4ONW/BPBtEeGGL2izJnu1s0oUnFqX9UnP41gFNuCI500KJEJWJci+z6KjoFV4BcU1hBQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxyih0RbzXeQBafgF3zpQKiZ+iOfx1HHhzltHl3zFnjpzYyF7I
	wymEBgxB0olKxxbRREolgFx96GUEWre9/YMVdYhAWAtGl/hbYCkQ131qTQ9bwfvEhg==
X-Gm-Gg: ASbGnctQOc/aO0JWpLKfFus0rigGXbxGEi+HbWO7Fhw59VKCTHhAuRWVBiW1UzRxFf5
	cT7/gfXpwx/p3MP4Xu9dq891H7HG2lh21wR5latnUT3TdqTVT68teKzAw0DJm53TnnAIu7pu729
	ik/Qga1jUfQ1hgMw2WBUKmd4aZMeQZjSbnquyEtQsqMIG44hA4qZHYtOatIPevH6bOJY7l2E5r4
	BKhkVCjm8ROgWOWcEzlLIspE9x2drInkTr5+ckaRvF0qTe6jFlLpZNjoi2O71D3s4Q+eH9eW3CN
	JMttCGepS0CGjl6lgMZLPv1T0/gXpBmbfijlxzWEJgoW/eGDPK/CKwqXIJR2r1oDsIdYLKRhtf6
	DslZ2SUPRQXNXlFzRwnkxoQH7/EdCett555eHbaTM3UEHeEf0lWxHfPev4Vgv
X-Google-Smtp-Source: AGHT+IFWHnAb9j6vZshzDqvVii3Uf/KBB33Bnto3sYiPYiFnR7Gp0lU90AzE3X1ABlczyhY58iWXOw==
X-Received: by 2002:a05:6a00:21cd:b0:772:4b05:78c1 with SMTP id d2e1a72fcca58-7724b057c56mr20792278b3a.3.1757072251283;
        Fri, 05 Sep 2025 04:37:31 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4c2c86sm22187610b3a.52.2025.09.05.04.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:37:30 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:37:19 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
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
Message-ID: <20250905113719.GL42@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <20250903202703.GP4067720@noisy.programming.kicks-ass.net>
 <ddd2f979-43d5-43e8-a95c-37a1654189e5@amd.com>
 <20250904070407.GD42@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904070407.GD42@bytedance>

Hi Peter,

On Thu, Sep 04, 2025 at 03:04:07PM +0800, Aaron Lu wrote:
> On Thu, Sep 04, 2025 at 11:14:31AM +0530, K Prateek Nayak wrote:
> > On 9/4/2025 1:57 AM, Peter Zijlstra wrote:
> > > So this is mostly tasks leaving/joining the class/cgroup. And its
> > > purpose seems to be to remove/add the blocked load component.
> > > 
> > > Previously throttle/unthrottle would {de,en}queue the whole subtree from
> > > PELT, see how {en,de}queue would also stop at throttle.
> > > 
> > > But now none of that is done; PELT is fully managed by the tasks
> > > {de,en}queueing.
> > > 
> > > So I'm thinking that when a task joins fair (deboost from RT or
> > > whatever), we add the blocking load and fully propagate it. If the task
> > > is subject to throttling, that will then happen 'naturally' and it will
> > > dequeue itself again.
> > 
> > That seems like the correct thing to do yes. Those throttled_cfs_rq()
> > checks in propagate_entity_cfs_rq() can be removed then.
> >
> 
> Not sure if I understand correctly, I've come to the below code
> according to your discussion:
>

Does the below diff look sane to you? If so, shall I send a separate
patch on top or fold it in patch3 and send an updated patch3?

Thanks.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3e927b9b7eeb6..97ae561c60f5b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5234,6 +5234,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  
>  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
>  static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
> +static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq);
>  
>  static void
>  requeue_delayed_entity(struct sched_entity *se);
> @@ -5729,6 +5730,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
>  	return cfs_bandwidth_used() && cfs_rq->throttled;
>  }
>  
> +static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
> +{
> +	return cfs_bandwidth_used() && cfs_rq->pelt_clock_throttled;
> +}
> +
>  /* check whether cfs_rq, or any parent, is throttled */
>  static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
>  {
> @@ -6721,6 +6727,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
>  	return 0;
>  }
>  
> +static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
> +{
> +	return 0;
> +}
> +
>  static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
>  {
>  	return 0;
> @@ -13154,10 +13165,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  {
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
> -	if (cfs_rq_throttled(cfs_rq))
> -		return;
> -
> -	if (!throttled_hierarchy(cfs_rq))
> +	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
>  		list_add_leaf_cfs_rq(cfs_rq);
>  
>  	/* Start to propagate at parent */
> @@ -13168,10 +13176,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
>  
> -		if (cfs_rq_throttled(cfs_rq))
> -			break;
> -
> -		if (!throttled_hierarchy(cfs_rq))
> +		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
>  			list_add_leaf_cfs_rq(cfs_rq);
>  	}
>  }
> 
> So this means when a task left/joined a cfs_rq, we will do propagate
> immediately, no matter if the cfs_rq is throttled or has its pelt clock
> stopped or not; if cfs_rq still has pelt clock running, it will be added
> to leaf cfs_rq list to make sure its load can be decayed. If cfs_rq's
> pelt clock is stopped, it will be added to leaf cfs_rq list if necessary
> by enqueue_task_fair() or when it's unthrottled.

