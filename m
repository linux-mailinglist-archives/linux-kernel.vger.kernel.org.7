Return-Path: <linux-kernel+bounces-837416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C323BAC45A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B349480F44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E802F3621;
	Tue, 30 Sep 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W8o7f6sX"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F61279DCA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224468; cv=none; b=Fqa1VQSRwsaodAGRdDqyu8LmBEa9HGvLW16N5QCbMEh03kQCDoA2NuslCc5CGjx95HEX5MZ4aHrbey61wILojuF/CAMfhWSjidnI+qLXitVd0TbFdLicTAezNmpWOhy7pWOApCZ8Nwg0eG65IqCmyYLXQ89VmqwVjr89PaI+p80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224468; c=relaxed/simple;
	bh=QomGnp/WZaiSlLUxeHbxwNEqFcT66kwVEQVeFwjRZmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqf81Ly4bOXeJtXW0/Td9NaGmTQ6yWDvY9GX/h0UeXqyf7acdp5yJ+S9tdazMiL2oFCEcFmie1ijGR44f9gRzu73SCkCjKd/6ECl0S3eiIQo2r249/MiigtN0HAgwyd9SRA4VnJ0u+o6OhDDLhC7B/PwbzhfGmdsp57SeydmEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W8o7f6sX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27a6c3f482dso44858085ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759224465; x=1759829265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPZ87GrK4sGmTZypYw4angNWxIgNKI/floJfOy9PBvc=;
        b=W8o7f6sX8ffQJcChfLeum/EO9+VFi35/vJprUFn+ExbHWaZT5pMENw7fpG3Hs9JSrG
         BMT48Y1R+HphPi5Oy80z4tUCD1lcu1/v1yklJoLQjSN6dC9FsgrlfdOY5UKYRVtjNeRk
         66ydGpJlRMYjXLdaGNdHKKJaeHScpuXGe/5l6kAqax+nQ+8rQ1BlXVUbghCLpo7pN5tp
         Qvbig97xRIQpCfNdx0W4X0ccf1hZHGEyMpnutUlPEAW+1wksdrW0Zk3XLnYXK3ZBl8wz
         dS5lK86rFBJfYy++kRlimRjFgIbLEhU5Q84MKKeoPJrGa2PNXxdnBhnXf8S/o9gPMHpP
         jPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759224465; x=1759829265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPZ87GrK4sGmTZypYw4angNWxIgNKI/floJfOy9PBvc=;
        b=EVU1SgsuzKTzyxBG03C9oY5USZojGsEX9WD3ZstFuJ4lctgmbZVQLDJq0+LKT0F7iy
         9UlHwI6MkIW+l/8YYY1INiKZd9Bh5iq1/4B4GJLtCzmrDAb2XWl5gGItK4GTJcPSY3eo
         7Ufec/szg1ooItP3Ys2TLv5YGPzPoXMd0KHyBrF1XTHQzzCcl0TtGDYj3UshMDn4HJh+
         7Xzo3tBSL69ci7By4p2eXiewzhIN9IJw96pN068F51YMspjbOsG5B/Gxmg+VXp79oWQg
         jsAtAQWOahGK4wDWuj4Lil0JO0H0+Y2vfph2Porj7uMQYDcBjBDJOZ3chbDAbmG0e/vF
         pRVA==
X-Forwarded-Encrypted: i=1; AJvYcCWvPTS1B6qgt9Qr36GgDE477aPZ/UflNbnBH0lpe9cGlfSvvBJKB0rsdU+MB7Hnnm03bYuxxc3bapxiIRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYK1zvGlgn5eR4kU2mt9/m3frZPZC9AVSaPvMsFzQqmfLVYOH
	2/8I4rybU29SO8Cvi8sS/M7lJwjnWZacgfGf0JmCDL1ZtWi+RBqYOwyqBfLimxVrrg==
X-Gm-Gg: ASbGncv/xxBRE/ujRbrEeg7kpARBnH3HcOjDXwbr5kKHQCUM9s0NDD6XaP3aSUWNIkY
	lPn+y0BONiKhHNPr6MvK980jeYpSDDdZ7NG49ShZSy0MEbu4Q1BM4w6AukT2edOLokT37tanyz0
	aP1t+sNTpLOUBkr5VXmmlwJMtJ1Q+ezC7L2KBHKXQhJ/kN4Xk0fBIQToPIt7aO4UpxioZ3ETBUC
	5mskPkpPBGzR9n6ICqp3WoOl2FZ8nD2eAK6q9Cw3lyCv3YCF/gppELyJYkwnV0+U7YK4ehgSWtB
	a/TY4FxCGzzaStOuzkvzFw59aXXsemc+pVZuBGXxt3J4laJ0/V7FE7a4SGjyAtCDejkxTPwj9tV
	aEkh2tqm9hNeupjX/aYoj0mVIbQHIBGdUfjWo41fENVC9ao4bAOT53sNHnWH8n2Z21NwrGZDjhw
	==
X-Google-Smtp-Source: AGHT+IEC0VyjNusvAJKWZyQAPOThgSIAU1u6hkebU3rsz6hzRJ96HLYqZTSr2SpKNv2O19ZjdtVM0A==
X-Received: by 2002:a17:902:f60f:b0:27d:6f37:7b66 with SMTP id d9443c01a7336-27ed4ac78b0mr218893855ad.47.1759224464994;
        Tue, 30 Sep 2025 02:27:44 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69b0685sm152527565ad.116.2025.09.30.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:27:44 -0700 (PDT)
Date: Tue, 30 Sep 2025 17:27:33 +0800
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
Message-ID: <20250930092733.GB510@bytedance>
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

Hi Prateek,

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

Nice catch and sigh.

> 
> The reason being, we can have:
> 
>     root -> A (throttled) -> B -> C
> 
> Consider B has runtime_remaining = 0, and subsequently a throttled task
> is queued onto C. Ideally, we should start the B/W timer for B at that
> point but we bail out after queuing it on C. Thoughts?
>

If we want to make sure no cfs_rqs with runtime_enabled gets unthrottled
with zero runtime_remaining, agree we will have to do that in a hierarchy
way.

I don't feel good about that for_each_entity(se) check_enqueue_throttle()
though, it made me feel we are duplicating enqueue_task_fair() somehow...

With this said, if we have to do that hierarchical check, I would prefer
to throttle it upfront in tg_set_cfs_bandwidth() :) The useless assign
of runtime is just 1ns, and it should only affect the first period, so
shouldn't matter much?

