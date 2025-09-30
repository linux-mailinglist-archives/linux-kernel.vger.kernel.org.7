Return-Path: <linux-kernel+bounces-837674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEECBACE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD131927C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2FE2FC031;
	Tue, 30 Sep 2025 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fRBgayiV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719C2561AA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236003; cv=none; b=sl4hHXM2HnamNqwbITb9X59X5IqfHX1ReYfAGT/wvcLVlQuxaxUI1rI09IRrafF+ggWxzmXN14i036Sfv5mKfxdZc6wbVlzwb7GDKTEOfBmc1MOvwSstND/MxwErlfnSrqJH1VYpL07qdS4vQHHB+HztpfH2tqKEgYSlYtqnQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236003; c=relaxed/simple;
	bh=dXFSz/UuZUi1tUxTs53GZEoKre3etPI/2hl1x+d8Khs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGQFrcitMD54PI/knIBDA/grYxJQt9MDf3xl698gD/B4QPW7hcZjjURi8gWbxCowa+wZoXMVm9wmcGbj+11I7Ja4iKqBgsH0l8BeWy4vqKGjwAikEjiX2KzXnbEEQkWSWXm2A/sY6UDRCu9GHWAKmoybg98JsWoFcf7B4qmSV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fRBgayiV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so6050789b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759236000; x=1759840800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxSIddntQKKjE1uvSWpYdDxCgzOCGY5rs3wwI2uOwwQ=;
        b=fRBgayiVV4+lmyhs/RsiuManCPgW9yNzzvy9YHGUAuxChCW4S3mT7rRidj2zGuGI8X
         zY1uEAdtEVsim0AlbjOlbmO8VmWnO26+UTU7/TOJ4WvLHEl4SscgiI6IH5+/tq86qymS
         xzJ7cN2FxuKCUAzIBejsNDQvc1504uK90qFsxBltTADqwOGbhBhXhskBWXFF8y4wut6z
         NI4IXnpjSzC5JtW4f4JJ2rBiL0NWK8XejmnbVW9VKNcer1+0lufCptMZXZaaPdLxPUpm
         67AEUpgrqxdOLIGxGDIF3XoC5T0Ik4qcTl4k6f/CoR4yXlV28mu/7HGh+no+oA94h1kP
         iP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236000; x=1759840800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxSIddntQKKjE1uvSWpYdDxCgzOCGY5rs3wwI2uOwwQ=;
        b=V3MhVCZvjz9j72zCA3LqATL1u/EtudpF0RM0lr7FeVB+q+2vVtVrL+z6XVukoS1Hxm
         EGldcuq998Hf2vnd3O95iXouA05pKrBQO03XtjZQw+dHBGeInpzYmDfDZEJlm90fixld
         df1Gh4R64g/d5vEwu/CdYueOACCflDjWLL99bV2OdXnPMBqlgv99siQdpEzVrT6kAnJ7
         OjA4umPP4nbqT8f8caElNGPSytNxqoF3/yyfZOUX/xohJEWnEsHCIUwzYnem3ata0kIi
         dm/T60zSaVsWvloO+ExK7ppvvwn9BDWmussE4b5iLJFiqQEZWORMJdgdhtkkxHi65v4o
         9TjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyQMCotHZVdx9ygyhsxGcyt/X6//rLl0TvOVCItV1DUY766JqlcGCxLtIvp8/sD4cuZWbDv8WG/Egvxtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqbdCD1r7EvNqjCzslzZpHRvmqw6Tpc0QEe63BwWSLxQ3k/H1
	ksr7/trvAxrlWSv4ZbLlwc0XUnK9vFRsxI90mE0lD70vIfigjjd9XOJI4k00qH8EVg==
X-Gm-Gg: ASbGncuJJKx/uX4RCInVE7xe48/YJ70qJPeJbqMIV5USsPuIKCajWAXMDoiTXyachSb
	FVwgNjEQiA679aGaEXI6RbkVIbRdk2B0AwOSYnZKzFiGiQlVQpCn9OLdLezSw0QXayxgiWLMGE4
	kOIo5v6EcllnIbAtWZO/9+a2ETlUFV3UcehThuOb+rEoMrzgw0i90Oe1ESVuzXF2a9+02+nE5cQ
	0gJKVsNGhJYvx/7RF40sT4fpMZ0nQBWyPpdXNJ8uQ37DUfedXZJsQuoJNRDMTpDQ42vBRth1a33
	mGDxCiRj1KgLtSAbuARJdbMIy2vrJjLpCz39ZsjBCgVgGvljXQa1jZumKFh8z+onsBUWO8cZ8rr
	lWIbEiZ3Yivxabm0sfqHQDA2+iwEK7WPagsxlFIN56ErkNh+dBt7ZWjZF3bb43g==
X-Google-Smtp-Source: AGHT+IGBZ2H3rMDutYX3/Nkf80PrWhkw/pjtjAjzIp4LFJRf9NqsCv0cVzCBVmL+FgEK8xu86UgdTA==
X-Received: by 2002:a05:6a20:4315:b0:2e2:3e68:6e36 with SMTP id adf61e73a8af0-2e7d2e45e6dmr24504857637.49.1759236000081;
        Tue, 30 Sep 2025 05:40:00 -0700 (PDT)
Received: from bytedance ([38.181.81.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c52eee5fsm13952898a12.0.2025.09.30.05.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:39:59 -0700 (PDT)
Date: Tue, 30 Sep 2025 20:39:40 +0800
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
Message-ID: <20250930123940.GA643@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>
 <20250930075602.GA510@bytedance>
 <658734b1-b02b-4e04-8479-ed17eb42c1f2@amd.com>
 <20250930110717.GC510@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930110717.GC510@bytedance>

On Tue, Sep 30, 2025 at 07:07:17PM +0800, Aaron Lu wrote:
> On Tue, Sep 30, 2025 at 02:28:16PM +0530, K Prateek Nayak wrote:
> > Hello Aaron,
> > 
> > On 9/30/2025 1:26 PM, Aaron Lu wrote:
> > > On Mon, Sep 29, 2025 at 03:04:03PM +0530, K Prateek Nayak wrote:
> > > ... ...
> > >> Can we instead do a check_enqueue_throttle() in enqueue_throttled_task()
> > >> if we find cfs_rq->throttled_limbo_list to be empty?
> > >>
> > >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >> index 18a30ae35441..fd2d4dad9c27 100644
> > >> --- a/kernel/sched/fair.c
> > >> +++ b/kernel/sched/fair.c
> > >> @@ -5872,6 +5872,8 @@ static bool enqueue_throttled_task(struct task_struct *p)
> > >>  	 */
> > >>  	if (throttled_hierarchy(cfs_rq) &&
> > >>  	    !task_current_donor(rq_of(cfs_rq), p)) {
> > >                 /*
> > >                  * Make sure to throttle this cfs_rq or it can be unthrottled
> > >                  * with no runtime_remaining and gets throttled again on its
> > >                  * unthrottle path.
> > >                  */
> > >> +		if (list_empty(&cfs_rq->throttled_limbo_list))
> > >> +			check_enqueue_throttle(cfs_rq);
> > > 
> > > BTW, do you think a comment is needed? Something like the above, not
> > > sure if it's too redundant though, feel free to let me know your
> > > thoughts, thanks.
> > 
> > Now that I'm looking at it again, I think we should actually do a:
> > 
> >     for_each_entity(se)
> >         check_enqueue_throttle(cfs_rq_of(se));
> > 
> > The reason being, we can have:
> > 
> >     root -> A (throttled) -> B -> C
> > 
> > Consider B has runtime_remaining = 0, and subsequently a throttled task
> > is queued onto C. Ideally, we should start the B/W timer for B at that
> > point but we bail out after queuing it on C. Thoughts?
> 
> Yes agree the B/W timer should also be considered.

On another thought, do we really need care about B/W timer for B?

I mean, when C is unthrottled and gets enqueued on B,
check_enqueue_throttle() will do the right thing for B so I don't
think we need to do this hierarchy check_enqueue_throttle() here.

I think the only difference with your suggestion and my patch is, with
your suggestion, it's possible for a runtime_enabled cfs_rq to reach
tg_unthrottle_up() with runtime_remaining equals to 0 but since it
doesn't have any tasks in its limbo list, it will not do any enqueue so
won't possibly trigger throttle there, so it's still fine. i.e. I think
your original suggestion works.

