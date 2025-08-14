Return-Path: <linux-kernel+bounces-769062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEC1B2699A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3939268614C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A921C5486;
	Thu, 14 Aug 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3gMih6V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A561C6FE9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181805; cv=none; b=IoNsPIz9cP9ogk6v+HOU38Zm4xEXtlr32gsWXhtKyJUvmsCN9ehAI49K2IN737NQ9ZHh9GflPQF5+YJeKpZWop7GAOyfubn/RAgbydvaWbARA2v+OCfvjRAPHUWBr+R5mysYkAYxZli1DC3u7a5sYHv8Kdb7+kK6yRtxnhp2xJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181805; c=relaxed/simple;
	bh=63Cw0XLiiKlCxqoz5QK1YjZONnB4ZwnZ/XbMj5jYIu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6l9Umk0D8S5vw+TJee0BYfVZMI3zZBIpoHi7VikNJTVMjr/yDP/k0dJ4wy8rC+NLruUZSk0mhm66gf0mBWzsempfNPzoFolmdC9EtlBPeuG9AwaRAZQ37FTWY+Fg9SlaUCoLCoLSQLXBfSomvKRQWC+uq5okmAO7rYpbmrw5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3gMih6V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755181802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jS1cBufXR7O+XIh1qhOs8Yxdm44aMSMGnsrOgstYpyk=;
	b=Y3gMih6VZ8oCKsme1pUrDh7Md2ZDjKWwkrLyp9FvwHGHFmdprZD1Mmo9H86/9s7XbRcWD8
	sKCQvIQYSE+UK7rY/Wsaa8us2FmZxUdKLpugZStt0kNs1qHnhA1QnCpD9/nKBEZRTE+eFl
	uVFDis7iSQ+dkitQXiEQGnf+wyPHXkQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-buVocEYeOFSOYuXCuFKh_w-1; Thu, 14 Aug 2025 10:30:01 -0400
X-MC-Unique: buVocEYeOFSOYuXCuFKh_w-1
X-Mimecast-MFC-AGG-ID: buVocEYeOFSOYuXCuFKh_w_1755181801
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a927f570eso21764066d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181801; x=1755786601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS1cBufXR7O+XIh1qhOs8Yxdm44aMSMGnsrOgstYpyk=;
        b=PXaYTUtAt/ng2yq/6ETOShNtLTfK4PaZgWRhIID0jqPpN+RyEPIN/AZpyID6Bd9vWB
         Hf9WfS/N+dUprd70Kv/Jr6EgH/azM+/DjHGR2hKcRcGy/mQXlr/0BYQ5UphTjYh7cZCE
         +OqB/XI01PhLqDfWukPMksaZC5XsSXQkXGqJAB77MaMXnG9cK2+pvGRGmCC11FWh55pZ
         VJOhvTV6EMe80Jt3Uvy67Y02RgYcc1eD9LC2y5MRM7kKStJnN5TPOmxkoU83CjfPYo+u
         0K4TJhkjAsGg8y9LpowHxAcmxCE5Ag+sf0uytQYsx8ZTWwBJcG6AXrK2Au2LI3URpMrX
         Mwpw==
X-Forwarded-Encrypted: i=1; AJvYcCU0qpPRIiHaMHdGEC+Rga5P1qrFTnSsBO2oTN7+HFOGs3mGPBag0gHcnkh9W4ye/koViEiI9IrISpeV38Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEqmOJ6En63HyNb625EuZBbrEx64E39oKo0fNs2jLToCjs6W67
	HXeQ+/pWH3U2w+VBv1S05tgEirDiDOCHhM3Cc3BJlqQGW3azJKrTiGY1Xpa4EAB3dssYYaeqCni
	+jlnc8JPQLKfzArQ+7uyg3wEaRGHzQExawdU4RIjity2a00YbLkqLfLVbObl+CQaukw==
X-Gm-Gg: ASbGncuhQ2etl5daHgM3qkSmwQX/MQOHNC5RneaJyMDh/awkkb2w0eNY3Dyqe7UzflT
	mmg3rePxFfTUGG274nropkyBJ7BEW7HZPjnn1z3ZrJIs3/83GsV68z5VjmpagWbjc8lpm6PmJJI
	SfFUuoCnPb8iQlcjV/UbX8//PGRGkqqMZP5pIf2usIqzblRkmf2y6tG5l7EaBijzHOUGbz2cNT7
	wt4TBzkqitUYV85mqzn/PUKTrXDQJyh0VHn1va4ci0ye/uENVCOkzG9I+SVSCkrCzftuMeW/9wQ
	aubyvvzEyIOFogZ0dxWyCQirv7bbp1HDRwB0qRtbMY+nMebJUd1edhz8Z17hDJAgwPhGkQ==
X-Received: by 2002:a05:6214:240a:b0:709:22f1:d657 with SMTP id 6a1803df08f44-70af5e70e4bmr43264256d6.40.1755181800731;
        Thu, 14 Aug 2025 07:30:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZW3Ke1rLyQz83YmDEoCCHcdXsqwaWLf8ag8VvALc+zUyyJP1FIUDJhqqCdZw8pCnAcv2uqg==
X-Received: by 2002:a05:6214:240a:b0:709:22f1:d657 with SMTP id 6a1803df08f44-70af5e70e4bmr43263556d6.40.1755181800013;
        Thu, 14 Aug 2025 07:30:00 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.62.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b10152sm13597696d6.41.2025.08.14.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:29:59 -0700 (PDT)
Date: Thu, 14 Aug 2025 16:29:53 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v2 19/25] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <aJ3y4YfcVQ-qVrxF@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-20-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-20-yurand2000@gmail.com>

Hi!

On 31/07/25 12:55, Yuri Andriaccio wrote:

...

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 7b131630743..e263abcdc04 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -406,11 +406,42 @@ int dl_check_tg(unsigned long total)
>  	return 1;
>  }
>  
> -void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
> +static inline bool is_active_sched_group(struct task_group *tg)
>  {
> +	struct task_group *child;
> +	bool is_active = 1;
> +
> +	// if there are no children, this is a leaf group, thus it is active
> +	list_for_each_entry_rcu(child, &tg->children, siblings) {
> +		if (child->dl_bandwidth.dl_runtime > 0) {
> +			is_active = 0;
> +		}
> +	}
> +	return is_active;
> +}
> +
> +static inline bool sched_group_has_active_siblings(struct task_group *tg)
> +{
> +	struct task_group *child;
> +	bool has_active_siblings = 0;
> +
> +	// if there are no children, this is a leaf group, thus it is active
> +	list_for_each_entry_rcu(child, &tg->parent->children, siblings) {
> +		if (child != tg && child->dl_bandwidth.dl_runtime > 0) {
> +			has_active_siblings = 1;
> +		}
> +	}
> +	return has_active_siblings;
> +}

...

> @@ -2216,7 +2228,14 @@ int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
>  	if (rt_group_sched_enabled() && tg->dl_bandwidth.dl_runtime == 0)
>  		return 0;
>  
> -	return 1;
> +	/* If one of the children has runtime > 0, cannot attach RT tasks! */
> +	list_for_each_entry_rcu(child, &tg->children, siblings) {
> +		if (child->dl_bandwidth.dl_runtime) {
> +			can_attach = 0;
> +		}
> +	}

Can we maybe reuse some of the methods above?

Thanks,
Juri


