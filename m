Return-Path: <linux-kernel+bounces-837569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC50BACA24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454653C82B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF65221557;
	Tue, 30 Sep 2025 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lDBqNEjJ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EDC2206BB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230452; cv=none; b=J8KMdUZn1tcarurnGVOLIxHcJPig1Ip7gepYGvbl9QkClizWXXk7/CQxblp1dH1pL6gT4ebg2yY7GKarfTCcXZJFX5anyCQ6hvcqMtT6DDnQaq0szXsswDg6pUM1ivIy9Fm6tQLgnlAB3vRV8dJltxUxYKGAj0/1ZCOYi1u6vs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230452; c=relaxed/simple;
	bh=OP1/MRJAfGMICp4RtAI/1z/ZBhQNXHTuF87jjGT2mss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OofnlATFN1tteWElR9AqXgdHpBcIGUVhEEdo4Te5ih0ROatsRT06jiR2kfp3dRtmUbDNmy5JyKHYRF5j00Z2VmU/ReSqLZPrqErJF5YiU8S70/p+sf2l+S8cXTvUm/Wnuiqy7fGW5bBUU+Chqa4c+knKkHQrY5sGx7qQ1QGR6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lDBqNEjJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so2274650b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759230449; x=1759835249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkAq8j18aL2m0KrsrtmHKA5G3346lqjQLn5RjuIphwk=;
        b=lDBqNEjJfI102mHcLzzJLlnMqBOpRRDe7L8uSk1olAbleAV90awXRexuQlmqc4dnSI
         Tmj9+XZGITvivMax+P1/CwcI2MZjyOwVk+l/x5CnaRANUwKKF7/0RC2QY+6g1SHoCIxs
         kaOaQN8f/SjFITaITrPEJISzfOPP/cLVWAaQLjgQiKTn2E6tSA95M/2HZZIzNx7z3dGK
         HoIxt+EmbeG9UWpa/gFhz/hr3SIXVZUBfuALoP7MC97thK/pnKlrvOqUrjXCOKpHhftF
         dS8RSSvXOLtiiTn9zkXFphfEykV3o2QdvnnWNsQBQr2EmzcXG9YeC06PIXLn6wkUrGoD
         fSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230449; x=1759835249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkAq8j18aL2m0KrsrtmHKA5G3346lqjQLn5RjuIphwk=;
        b=fZiT+V/GrII5NgVlcBLKR/8tnv6nt0YOt+K58cFXbOfPSm8rJ045Z08vCEJaamCcD9
         BDKjnb4BO3yHs/xn0mX8ZXew+fkh64XxAdU79Yr8B6y4Blk/E9ogoq8WcIFdTstEh7YK
         +QJCtUrJN/7NNlZb2Osk6dYX/lN+ixLZminLpre8exrD5jCzBDa4tiUvzqsuidlGEE0C
         Xscyxhk5KVsVgkOcqWXGEppT/Pgs2c7UrEpBnNloir21P+VAGRnD3y62XjtoTrtCLWus
         hBmIfVwYeIqOT9UwDBiUFIl/vSWt66eoosLCGWzB7TzTrLDweA9tH/VDVKfge7UsEWZ5
         M25g==
X-Forwarded-Encrypted: i=1; AJvYcCWvTt0QmnU3pXqOdm9ZeoBbQsRraYfOaFo3pqrA4GWfPEcbWQhUwRhfG4osUwj5xv0lDtxbl2qQGh8SxXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8+NdWgJJeD2S6v0hsDsWSOZBkeiNwTjgls2ziiXhAm/rGiA7
	zNCV66q2Q+gC+5S/ROj52HcepgMo9GlfyFUTfPiCO1zWYhXP5hIXpCaOUmZWnz9POw==
X-Gm-Gg: ASbGncvody2pQ+WT8EIznNzMhzfTcRZbOai3zFIq0JPttnTaI9qj14SfJmC+9IdIGqs
	XiValaSvUIgOy9D7nkTNYi8wpb7rqN7Sy+5q2Bbvu3oFH/T0al2qemTgdMOVjOJiz/sYtWSIHIi
	eXeEkBhVl2//RtUPZ5IlMm7zQYlJ9o9B0xjtrSzp0hEBxDb6Cg6MJONDVLCjU10cJkfZYqU9ulC
	fT7InoDiMUNBX9L/ZKK3S+LJkfKkZLewCrVOTS4YRviHBWY5gWGGililzCu5/qLlghftoglrq+o
	dEDgbQvRXNOjvjgT6xQ+uygN5G1ZsobmhfQbJCFVLUENvDn2QbE1oZ3KEEM1naA0uN6siaULop+
	qyw3O1YHpgrtxaB+j2fhMBrHmMUKHEUerXuprfCq371nEWmbBnL0VGYl2jZAuOsxNj11iuIQr9w
	==
X-Google-Smtp-Source: AGHT+IG/oWvaKnxK1G0O/CtaYSug/EbLg/EXO9xECxsCPDSMqEMhqxOZVMDYHKWEEpNz0y3HKLECnA==
X-Received: by 2002:a17:902:dace:b0:24a:fab6:d15a with SMTP id d9443c01a7336-27ed49ff533mr227833795ad.20.1759230449010;
        Tue, 30 Sep 2025 04:07:29 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699cbfesm156568865ad.108.2025.09.30.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 04:07:28 -0700 (PDT)
Date: Tue, 30 Sep 2025 19:07:17 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
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
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20250930110717.GC510@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>
 <20250930075602.GA510@bytedance>
 <658734b1-b02b-4e04-8479-ed17eb42c1f2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658734b1-b02b-4e04-8479-ed17eb42c1f2@amd.com>

On Tue, Sep 30, 2025 at 02:28:16PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 9/30/2025 1:26 PM, Aaron Lu wrote:
> > On Mon, Sep 29, 2025 at 03:04:03PM +0530, K Prateek Nayak wrote:
> > ... ...
> >> Can we instead do a check_enqueue_throttle() in enqueue_throttled_task()
> >> if we find cfs_rq->throttled_limbo_list to be empty?
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 18a30ae35441..fd2d4dad9c27 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -5872,6 +5872,8 @@ static bool enqueue_throttled_task(struct task_struct *p)
> >>  	 */
> >>  	if (throttled_hierarchy(cfs_rq) &&
> >>  	    !task_current_donor(rq_of(cfs_rq), p)) {
> >                 /*
> >                  * Make sure to throttle this cfs_rq or it can be unthrottled
> >                  * with no runtime_remaining and gets throttled again on its
> >                  * unthrottle path.
> >                  */
> >> +		if (list_empty(&cfs_rq->throttled_limbo_list))
> >> +			check_enqueue_throttle(cfs_rq);
> > 
> > BTW, do you think a comment is needed? Something like the above, not
> > sure if it's too redundant though, feel free to let me know your
> > thoughts, thanks.
> 
> Now that I'm looking at it again, I think we should actually do a:
> 
>     for_each_entity(se)
>         check_enqueue_throttle(cfs_rq_of(se));
> 
> The reason being, we can have:
> 
>     root -> A (throttled) -> B -> C
> 
> Consider B has runtime_remaining = 0, and subsequently a throttled task
> is queued onto C. Ideally, we should start the B/W timer for B at that
> point but we bail out after queuing it on C. Thoughts?

Yes agree the B/W timer should also be considered.

So in my original patch, cfs_rqs will (most likely) start with
runtime_remaining == 1 and unthrottled after calling throttle_cfs_rq(),
which will also start the B/W timer. The timer is not needed in this
case when no cfs_rqs are actually throttled but it doesn't hurt. Looks
like everything is OK, we do not need to do any special handling in
enqueue_throttled_task(). Thoughts?

