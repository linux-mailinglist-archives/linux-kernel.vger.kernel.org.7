Return-Path: <linux-kernel+bounces-807653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD82B4A797
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4321893602
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E55287503;
	Tue,  9 Sep 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uhvcxmn6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC528724E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409332; cv=none; b=grcHYQhqDqOQt0d1MPRFcce4rlzc7V2eVVKnTxZEoVJae1IoWkSc+9nrFUAUZSlM4ygWD4JZu/V+12UuyhQOEiYiQadYq/ECdDk3mxen18pouoNZPav2FZbZlYkAPMtJxnhIPtTAojFXEUlUO2kiwuQjiPF5l4mzsb7UpVUqo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409332; c=relaxed/simple;
	bh=4XCHGFp+ERicI+7LiLzM+de5NgDQ3VodGXUFPKTOXa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYzDF1I6DfemI88wtrkA0J9ZSg7lhRJu3o4RCFKtOWKnlBBsHi5gkr7Xw63y8zmV84HUhXATcb+7KdEhJ1yFNSVjdNZ+ToJvTYLO449yZC4PuZzZSAF/5ERwXpT6qkQPpicrGDilhdvoxVmaJWM09cIEFKUgwfHs5FL4WKmlbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uhvcxmn6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7ace3baso927639966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757409328; x=1758014128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mp+RkJYLdE1Crh5KxPBrwpIKJDPei8RPqdYJQLcuk0c=;
        b=Uhvcxmn63mKqWVfAshIl4vtaIYDzsfxHcV3yubXIw9ALR4Qlge5vCmzFjCs2m979Mz
         2h5C+5qdim6qrXBh2pOrfMmQ3pMepEPjEGVxwUEgUakT1msQ8gBjJM4w0M8Mbrm1g1R2
         E50ftXebOnDKyvfNH7gzstyge9l5591jdOG2k9tDgcSi4k3Jorv3cCBnipa3864DSeUm
         VITEuvM6NVUatwOOJUFWTnPBN+yBDhtwqmavakk7yepWRlZi0tEsnuuRC73+ZYSz+vYK
         CvDsHXs3NaNd3gRjFaZidP9XeRngSxA4zPH44gAKOyB4r2FPPm5kCSiF1enwXUZBALZn
         5L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409328; x=1758014128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp+RkJYLdE1Crh5KxPBrwpIKJDPei8RPqdYJQLcuk0c=;
        b=otFnzJUcA+wrcHsoAhb13q3Ep6hYf1axY7ja6WqgApkN01AEZpmhoJKGKwriLVyblm
         t+8F6i4R2OOxJOhcOaUYXrGPGtEgU7BA4HNw5AQzjzelBIEGIlJcYk5RUed7l/en3vBi
         vNGOxC+w1r70H65OfNY2YGK3QCweXPLzbGh6iaZNTTSq7ylewwS73vCAAoBl2IUIuqUu
         AZHNpXPhT8oXAFQohU+2n9FZexqvQzD4V9q8XU+4Dm8KorhD04wUtwhfstNj4R3r22oj
         i8qxWSix4IPCB2jyCE6rnqEeZlUx/Yxja0i8SOqWyWcx/f1+5Zwf8Xd5YgMsFVkla9zF
         Z0/A==
X-Forwarded-Encrypted: i=1; AJvYcCWxoHYHnsI75m2HOWZ3XGk85dVOV+5zverDyYMrCv5F7+PYD/04J9SQqnBGAQObHQOJbKiM2y3fDfCuDvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysHx/23ibsFmXMXeox6d5YbbPv266jabJM7atzm1fVMFxNOvom
	3P+eHbZgnHyXhXK1VjWjne9nvPk/KM7Ourb79vm1ZfvN0K5XlXI3R4HapzOtZ7+Oa+U=
X-Gm-Gg: ASbGncsFzVD4OgjpFCFvWxyd5bI4QI/VAl408PNFKo9qkrqMOPQpUVausRdqfaIeXAn
	Tcc5Gx3nTkl1LNA68m4wopRk3dDsHjBtpu75KVnvCfCSpQ1HT2Ukx/PEF8Glv5Kc47zQxvHSxiC
	UuTmqNBxLrtcuS15z5cG+zvPGVNqCMXrAfNBtlIuouU0kNkXdEtEfuoOUUoOHGp/qN/8WuiDT4U
	NWN471e8ZEebtgRUXxZQ2qoJECzEYLDpRsUvZXIRhl49teAPHNeZHe2APnS2qC87k63WCodHsMf
	lGskwCRm0BI7sZl+0hdjmrI3eKL7W5FGrNAX3wC7/HU7vqbUcYkTFBQUjduD0CgLGasDdqb0kLW
	re+slwovMMdTjIDFwCpCzK8M5Xs6yYzoLAg==
X-Google-Smtp-Source: AGHT+IHUbvikxhHUTGxZjrj/IiuBOao2wd7cJlQ7Lb/Yre+ntGCxGyZdytPfWHiAGIqSj5PfiD+38Q==
X-Received: by 2002:a17:907:a03:b0:afe:be04:5ce2 with SMTP id a640c23a62f3a-b04b17c3124mr1010187766b.64.1757409328276;
        Tue, 09 Sep 2025 02:15:28 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b04190700a4sm2235051066b.63.2025.09.09.02.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:15:27 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:15:26 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, surenb@google.com, lenb@kernel.org,
	rafael@kernel.org, pavel@kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v8 1/3] mm/oom_kill: Introduce thaw_oom_process() for
 thawing OOM victims
Message-ID: <aL_wLqsy7nzP_bRF@tiehlicka>
References: <20250909090659.26400-1-zhongjinji@honor.com>
 <20250909090659.26400-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909090659.26400-2-zhongjinji@honor.com>

On Tue 09-09-25 17:06:57, zhongjinji wrote:
> OOM killer is a mechanism that selects and kills processes when the system
> runs out of memory to reclaim resources and keep the system stable.
> However, the oom victim cannot terminate on its own when it is frozen,
> because __thaw_task() only thaws one thread of the victim, while
> the other threads remain in the frozen state.
> 
> Since __thaw_task did not fully thaw the OOM victim for self-termination,
> introduce thaw_oom_process() to properly thaw OOM victims.

You will need s@thaw_oom_process@thaw_processes@

I would also add the caller in this patch.

> Signed-off-by: zhongjinji <zhongjinji@honor.com>

Other than that looks good to me. With the above fixed feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/freezer.h |  2 ++
>  kernel/freezer.c        | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index b303472255be..19a4b57950cd 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -47,6 +47,7 @@ extern int freeze_processes(void);
>  extern int freeze_kernel_threads(void);
>  extern void thaw_processes(void);
>  extern void thaw_kernel_threads(void);
> +extern void thaw_oom_process(struct task_struct *p);
>  
>  static inline bool try_to_freeze(void)
>  {
> @@ -80,6 +81,7 @@ static inline int freeze_processes(void) { return -ENOSYS; }
>  static inline int freeze_kernel_threads(void) { return -ENOSYS; }
>  static inline void thaw_processes(void) {}
>  static inline void thaw_kernel_threads(void) {}
> +static inline void thaw_oom_process(struct task_struct *p) {}
>  
>  static inline bool try_to_freeze(void) { return false; }
>  
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 6a96149aede9..17970e0be8a7 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -206,6 +206,25 @@ void __thaw_task(struct task_struct *p)
>  		wake_up_state(p, TASK_FROZEN);
>  }
>  
> +/*
> + * thaw_oom_process - thaw the OOM victim process
> + * @p: process to be thawed
> + *
> + * Sets TIF_MEMDIE for all threads in the process group and thaws them.
> + * Threads with TIF_MEMDIE are ignored by the freezer.
> + */
> +void thaw_oom_process(struct task_struct *p)
> +{
> +	struct task_struct *t;
> +
> +	rcu_read_lock();
> +	for_each_thread(p, t) {
> +		set_tsk_thread_flag(t, TIF_MEMDIE);
> +		__thaw_task(t);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * set_freezable - make %current freezable
>   *
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs

