Return-Path: <linux-kernel+bounces-818804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6BAB596A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A6A4E436F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58E421B9C9;
	Tue, 16 Sep 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiKA+dKC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4511EDA2C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027173; cv=none; b=A6xArYnTJk4/ZLhm7GB7ZIgKrLle1ZIE0o2zixKyahmowOAD+6a2JXe//NMHy5+SHTcPH3I0jfp2DfQ6s7gmwPap0ZcYBrT2J1CumJo2T9CeoT5ynOrDrQLB2/srCRZ7vQ00u4rhn5OqpcbpuktJ2/7G1an40RtgnOE0SfMIKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027173; c=relaxed/simple;
	bh=sWE9agwvdtyYa2fFs33WTLInZRCW+AgEyfDMY1sOtSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm2EycZu480fIntf4uH/OV9vM8shBsq5SGAV2akfGS2SFA/dxBfZejRc0k3NeiOzhrnOYIS3QKR2HXyyjnHvsoThYaV6SsoH/AbNUc6Kulm0HJ0qD10fxGQdlmVHTScIX0wVRUYZJ++BAzUswDty2ha1TDO6+N3oAYapzTp0RMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiKA+dKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758027170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+He7jqTCyDvR/QF1U7VM/2ghTgyMYAuSu+gKrQ58vUM=;
	b=YiKA+dKCo93deTovN1BhJ9m23nHgI/IUBekczDoGFTStl1auM7PQpHWCnkeQiK1EYJ6QqR
	oMY3ypi6PihUebOp066ule8gimMAg6cO6LvEYABCOFaBq3rtTwTO5rKzlZUBsz6zlXpf1S
	JA8HO4XQ+Adpe77gSTGzvFMSk6LGl1g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-1uRLeZbnNhOBhzBXk55AXg-1; Tue, 16 Sep 2025 08:52:49 -0400
X-MC-Unique: 1uRLeZbnNhOBhzBXk55AXg-1
X-Mimecast-MFC-AGG-ID: 1uRLeZbnNhOBhzBXk55AXg_1758027168
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e997eb7232so1290164f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758027168; x=1758631968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+He7jqTCyDvR/QF1U7VM/2ghTgyMYAuSu+gKrQ58vUM=;
        b=Z0z4zlLc+AmI9i0G5IDfLkjj6rrnzftAeOtAg9jpdDiM7pHUh8FB74qeEXgFl08CLX
         B8w30ZwTDArO8DCBXr+EL9h8WIWH1GKr4gQrE+U5W7NYJaiXhuq+RQbEBhxY2vYK1Lfi
         wW3TsbQ+z4YmehSxiW7PtNUKYTlS3IF6dWzNeOr8QbfJ9Yo4W5NpQFqNhMiyDerGFvTg
         7aZ1du0TdnWzhD/e6YWLV12eF/fNU97Qmmbv+hkA+SDmZZhqM2lTe8CQmfPFLWwKImqE
         bEJF9JTyKiU5tr3PE6Utq+Sygpka4k5dQPhIOl4B3F0T/uCqUw6GpvTzxyC340xfWvs2
         AMeg==
X-Forwarded-Encrypted: i=1; AJvYcCUlPWPB6ud+swRebHKZlf1VaFHIMIxBO35kfpCOiq2/tJKG36XF5B18HFC88Z/vZ1aiuxWvVr+w+OtCohg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQ3appddoUI0gQ8QWo6wOxTi1ebSe6aB/LVZcjMAwJDACP6aK
	BHAlPk52grXhdsL0aJwlKPJ+gGQB4eTuh7PPCuKAvkAd83KFTsQZjZQv+gbxPznzxzzn23AIXBa
	G+D8LJfPerYK9lfzDjI9xZJdWo1E1vYsuwSF6/env8X8xhucO02jPzT+er5Us8tqTUWnGpQIzlw
	==
X-Gm-Gg: ASbGncsTvsqgxfRVa6ff9aN5Ht29E0ogTwhvo7SuWk2g807r4PpmdThP8+IdlVqHbaP
	AoeJ3zqRkbMh/Q9q8yK4CDg6lGDWWq2t77/RFkLUNMvf8mCHoLPZFAk3MrL+TIUXy9UJ9qlIsp1
	+Hg3quDsfgV8y0EE1KvGLHLEz26jVa5VNN0drcD+zMtUD0Tk54cUSLQ6YqfsFDKZ6fUGy3WRDr8
	b6PAMzwPZSpEfW6udrJE8Cv3KH7lA+2p/XpBFkvG/3NLIxG1PkxGAlxw5DDycEKrFVBwwM5g3EX
	O9Ms8AtJ5z307wxlJhJyHgFxjfpMkTePBK29m5W9sMLV+O6/fehUoGXznWAoiUeTJkfAoLU=
X-Received: by 2002:a05:6000:2011:b0:3e8:ee5d:f31e with SMTP id ffacd0b85a97d-3e8ee5df6cemr9547831f8f.25.1758027167683;
        Tue, 16 Sep 2025 05:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZaflQYwsrO0TKK8TAXq7ulKascrUncRVehe9oCnqk4rcmoyO5En1Fb4+28laFZQ4+SlCR9g==
X-Received: by 2002:a05:6000:2011:b0:3e8:ee5d:f31e with SMTP id ffacd0b85a97d-3e8ee5df6cemr9547801f8f.25.1758027167233;
        Tue, 16 Sep 2025 05:52:47 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037186e5sm221337725e9.5.2025.09.16.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:52:46 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:52:44 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
Message-ID: <aMldnFrGfcMECbmK@jlelli-thinkpadt14gen4.remote.csb>
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com>
 <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916110155.GH3245006@noisy.programming.kicks-ass.net>

On 16/09/25 13:01, Peter Zijlstra wrote:
> On Tue, Sep 16, 2025 at 10:51:34AM +0200, Juri Lelli wrote:
> 
> > > @@ -1173,7 +1171,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
> > >  
> > >  		if (!dl_se->server_has_tasks(dl_se)) {
> > >  			replenish_dl_entity(dl_se);
> > > -			dl_server_stopped(dl_se);
> > > +			dl_server_stop(dl_se);
> > >  			return HRTIMER_NORESTART;
> > >  		}
> > 
> > It looks OK for a quick testing I've done. Also, it seems to make sense
> > to me. The defer timer has fired (we are executing the callback). If the
> > server hasn't got tasks to serve we can just stop it (clearing the
> > flags) and wait for the next enqueue of fair to start it again still in
> > defer mode. hrtimer_try_to_cancel() is redundant (but harmless),
> > dequeue_dl_entity() I believe we need to call to deal with
> > task_non_contending().
> > 
> > Peter, what do you think?
> 
> Well, the problem was that we were starting/stopping the thing too
> often, and the general idea of that commit:
> 
>   cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
> 
> was to not stop the server, unless it's not seen fair tasks for a whole
> period.
> 
> Now, the case John trips seems to be that there were tasks, we ran tasks
> until budget exhausted, dequeued the server and did start_dl_timer().
> 
> Then the bandwidth timer fires at a point where there are no more fair
> tasks, replenish_dl_entity() gets called, which *should* set the
> 0-laxity timer, but doesn't -- because !server_has_tasks() -- and then
> nothing.
> 
> So perhaps we should do something like the below. Simply continue
> as normal, until we do a whole cycle without having seen a task.
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5b64bc621993..269ca2eb5ba9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -875,7 +875,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  	 */
>  	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
>  	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
> -		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
> +		if (!is_dl_boosted(dl_se)) {
>  
>  			/*
>  			 * Set dl_se->dl_defer_armed and dl_throttled variables to
> @@ -1171,12 +1171,6 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
>  		if (!dl_se->dl_runtime)
>  			return HRTIMER_NORESTART;
>  
> -		if (!dl_se->server_has_tasks(dl_se)) {
> -			replenish_dl_entity(dl_se);
> -			dl_server_stopped(dl_se);
> -			return HRTIMER_NORESTART;
> -		}
> -
>  		if (dl_se->dl_defer_armed) {
>  			/*
>  			 * First check if the server could consume runtime in background.
> 
> 
> Notably, this removes all ->server_has_tasks() users, so if this works
> and is correct, we can completely remove that callback and simplify
> more.
> 
> Hmm?

But then what stops the server when the 0-laxity (defer) timer fires
again a period down the line?


