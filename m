Return-Path: <linux-kernel+bounces-844104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B17BC1024
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C73188F068
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55682D8DA4;
	Tue,  7 Oct 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWscjQ7K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CC2D7DCF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832801; cv=none; b=ql7klTQRQTPdJ3Bi4esmOw4Wt62hdpj3ysP3ucANbVy0jCQmtjbj5Bg5YBkAKv5WzUdmN3MJpzqZdIU5I50c8aIshTAKxWl0SPLRfaofYNDBc1+hJqVu2t03KxJWk3GkMj5cyeYAK4OS3bxOPOiPi87eTyblMRR6ErHXe9M74r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832801; c=relaxed/simple;
	bh=gbzDoxYv0MvSzWpS8VUWjtEE8E1Rv9qpr+KsA+B9NqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjysoNmChsfpq83nv/xiRw2lEob2D/aMLgH684pQqoblHmEOPfjr9KZPh0cqyxh2FoU4nGGq4hNwjIW4woFj0g1PzfudZqMubZWmydjir1y2vsKlO79mvzU+WMeHyfsXDq1H8/m6h1QmMIFhmEHUfbmTI5TbUBru3VPjxFUNNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWscjQ7K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759832797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1oRiQ21RD56WeY2QvGAYtt4aZJ/FMR4+RaPEw0tI+EE=;
	b=SWscjQ7KQArvpzNf2mIfR+EQdUp5VHjsD7hk7x4nZ8XE4kLof/ppUNT5qMiMP+uC+JZ8mO
	XYP7823IJj7BMsXq0YhuKaJgnUQ+Kv5uEHJ0jTo/22rsaGOIDVEKL8uU0jiSpWWDN0uwjp
	UjwrM0y8pcGylDFvn86gPHizXASZljA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-nr09Nf5JOGmvidK3BZ8zAw-1; Tue, 07 Oct 2025 06:26:36 -0400
X-MC-Unique: nr09Nf5JOGmvidK3BZ8zAw-1
X-Mimecast-MFC-AGG-ID: nr09Nf5JOGmvidK3BZ8zAw_1759832795
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e3e177893so32922995e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832795; x=1760437595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oRiQ21RD56WeY2QvGAYtt4aZJ/FMR4+RaPEw0tI+EE=;
        b=TQ1rLriezqy/6x/BuTgG5WzgtbVP5pR1KDcVBNRWlZ8kIfTr9+lAYlT2c8NpCpf94G
         41CAhUzmFLGgLFT3JdwieQNEuU2Keu5uJyWCv5DVSercYbgAFWcy1kttBbBBQ/DaJYVi
         u48rEjQIpUGM8GsPSVT9c8sDgnFx0BObT6lK6pyP3869mClZSpM2+LFFPCvDBiGWE7Om
         uvpl1fIuE0YLmpNZaDcKsKG3s/JNr6SV5692hoyfsBiEdsjO/ECW8BkJ9oFW6Xcnhw+H
         QnBpVM3lado1A/EVVv1FsTzWvvvAyVYxgrDcH0vur7OqqPzspi1g4KaR8hpyiqpsnn7C
         aMog==
X-Forwarded-Encrypted: i=1; AJvYcCWgcrOzEKmI99ztv7FZkRSKM4n/f4uHNGbpiNP+frG1X7x0NuNmA7UZkc+f3QCz4yOamaWUvfTdOJUmZwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0HAx4aBQw02lUPm9HH8zwTwNkpeGrQiX9+asH+DWBlCTQhRQ
	+aVe0GJHPbwU9d9vFha1kd1fi3czwFWXFyRAdDQUewaxqK4vEpWreSerRWxcV9v1rxKenBZACBW
	WSOKxD1gmbaZ/9RaW1JQTIYUL0mWqJnHwoVm20SAtSe2tEJPSWD9ODVOM6MjVl6iLBA==
X-Gm-Gg: ASbGncu+J4ua52BZDHTKA7XAXs4QHuUrjY1r5GmyrSePoE+kbIcLcJYPQt+ahad+bU6
	PPhOUaQ6FZOxFu+DygemYejMbyPOlP8sOI1dWwWZXSGoJWRyfjYBo689gqClvXIhvgUtUTrOt5k
	MhkXw8r5gHGBj+GRNf6kvetHmCg3UL451x01vJCdcWLJjhAAtRNZFDbdMz2c/6AUfThAaoIx+LM
	QhrjN55rb4HXWAgZpNsH46ayMhwZs31Z/UL7xyoCgfw4WLHLhGtmRyvU7jQwn4Ycln5Pw6d6YL/
	3FxEgYb7pKWmQlw5hYVQbnDNjugU+MVfLISe3lIMjdkBMzqlW0rRmAxz2etFU+WWS+07KYpr/zS
	vGQ==
X-Received: by 2002:a05:600c:548a:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-46e710b6231mr113836295e9.0.1759832794920;
        Tue, 07 Oct 2025 03:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpzj+r3TPYmWvbkiCjUYFasMEAw744DuMCfiYyedpCn/rb6hxGdhvFcG2MoVK74jPTRfi2Bg==
X-Received: by 2002:a05:600c:548a:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-46e710b6231mr113836035e9.0.1759832794472;
        Tue, 07 Oct 2025 03:26:34 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm265625615e9.4.2025.10.07.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 03:26:34 -0700 (PDT)
Date: Tue, 7 Oct 2025 12:26:31 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 1/3] sched: Detect per-class runqueue changes
Message-ID: <aOTq19a_OIONFmTs@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.522934521@infradead.org>
 <aOTmg90J1Tdggm5z@jlelli-thinkpadt14gen4.remote.csb>
 <20251007101610.GD3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007101610.GD3245006@noisy.programming.kicks-ass.net>

On 07/10/25 12:16, Peter Zijlstra wrote:
> On Tue, Oct 07, 2025 at 12:08:03PM +0200, Juri Lelli wrote:
> > Hi Peter,
> > 
> > On 06/10/25 12:46, Peter Zijlstra wrote:
> > > Have enqueue/dequeue set a per-class bit in rq->queue_mask. This then
> > > enables easy tracking of which runqueues are modified over a
> > > lock-break.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > 
> > Nice.
> > 
> > > @@ -12887,8 +12888,8 @@ static int sched_balance_newidle(struct
> > >  	if (this_rq->cfs.h_nr_queued && !pulled_task)
> > >  		pulled_task = 1;
> > >  
> > > -	/* Is there a task of a high priority class? */
> > > -	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
> > > +	/* If a higher prio class was modified, restart the pick */
> > > +	if (this_rq->queue_mask & ~((fair_sched_class.queue_mask << 1)-1))
> > >  		pulled_task = -1;
> > 
> > Does this however want a self-documenting inline helper or macro to make
> > it even more clear? If this is always going to be the only caller maybe
> > not so much.
> 
> There's another one in patch 3. I suppose we can do that. Maybe
> something like:
> 
> static inline bool rq_modified_above(struct rq *rq, struct sched_class *class)
> {
> 	unsigned int mask = class->queue_mask;
> 	return rq->queue_mask & ~((mask << 1) - 1);
> }
> 
> This then writes the above like:
> 
> 	if (rq_modified_above(this_rq, &fair_sched_class))
> 

Yeah. Maybe also add a "check rq::queue_mask comment for additional
details" or something like this.

Thanks!
Juri


