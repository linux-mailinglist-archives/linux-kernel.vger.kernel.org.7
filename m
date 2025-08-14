Return-Path: <linux-kernel+bounces-768926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0198B26802
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FE61BC1AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE52FE047;
	Thu, 14 Aug 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkUqg0cn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3F126C17
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178947; cv=none; b=EewwOVwQZZS9vZfiuNp6M/Uep1iXH+3kP+CJdQ/Vyd+miJh9SBi0bI7Ze1E1EEPVpsoDxsNSyXFhcETYhoUckL2nyEcT660xmOfHa9kjKO4hSrz9cTjX8K/r863LI2nLGvaDiMy81wSggptGbnUU6VaDUNzKFEqywvAKvVZQXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178947; c=relaxed/simple;
	bh=zjqv7UfkFa8qCDUj1JmeN4FXpiMbciEZNAsjBTbzNbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgjdnYC7zAWzutQVDj98KfBYQNx1HqeLoOYr/33io8xc3XZs5YsVvM53+KPlJierER0n5pKwDqIeABvE1p1xE05kTuyhWRbgGdCdcKYy7Uum63A2w2RS1q4HfyTKgU9XF/YJqmliPLertW3ZisuW1G1//NJC4n+/9hQCgN5HEG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkUqg0cn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755178944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7PBNSto22d4UbHu4vRwWB72/fXAJM6SbOk5sL9uz6g=;
	b=DkUqg0cnDkCWOgnU817nKEIyMgF4giHp54rK1Vsh9MJSsoPeJMOKXIUPUBnKGjMakG3xfu
	xb+rnol3uYqrGN0IDYjqZhDGYWavUHbOTntUNLYEGMx6fi7lTTOAGDxgVg93YotoazQCFb
	wUlw/tqj+W6zPcphvZcVbEUPQxDFXX4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-ABsl0eVCND6jH1gu3EED0w-1; Thu, 14 Aug 2025 09:42:23 -0400
X-MC-Unique: ABsl0eVCND6jH1gu3EED0w-1
X-Mimecast-MFC-AGG-ID: ABsl0eVCND6jH1gu3EED0w_1755178943
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704b4b01so228706285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178943; x=1755783743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7PBNSto22d4UbHu4vRwWB72/fXAJM6SbOk5sL9uz6g=;
        b=mvzsLtEwCfBf1FejlH30grbt9U93S1xJOWOWeL1Wf2N9k/tvh5B3dyH5ooXb3hozOt
         GhQBlMIWvvP6Wy3K9z+/B5NF6SSAln8wTn8fzuNqC2U2YoindIVSGboZ0MicVWh7hXjv
         grYOucZ+44kG9Ka+TB5oU7kIVMmimyB8FKsQC+wroEJ+nvzHO9Kcqcax4xJb5lWqfKk2
         bv0rdjikbKiR02YEtJVJEHSGxO7IUISUAxw/2SNaqVSnDBSX7wNQ0XNTa9Km137k+r6f
         ZyFBt2qptdpmii9Q73Vj4wWAhbecWe0IVCQGli9h6H7bIoHSzf/z+y5Loyy0F+JsHrxR
         tuUg==
X-Forwarded-Encrypted: i=1; AJvYcCVJM6NznmyL7MMKQn/Ob1mrcYt/q7tNxU8XiDOtPkKNjvhIm+OHTMiJe5c0f82l/eMBq73qdIpxDzTBdaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAMG5WTavhEdSNP3QfnvilkiaCNJSOFyqXin3px8Trl7uP3sb
	lDRT0hfZP9FYytu4T8Gyyy/CnMf8YSM7sI0TZdp1CCp6Sfm+f1fNeSkbE4su9YZJghtwkP7LQA4
	PcPdYUvvw+6EQHZqsfozvFD9veNpx6VUkBrH5mssUd/kAF4KHphuXzJlnxN6tQv4ktw==
X-Gm-Gg: ASbGncsuF3z9n88aQ4D1tZ6RIV4GDGWpzgcZ1yTpePgqvwBGjiOz4yNSvC34FtbvZDQ
	QKEahgRN/nmqyVlAM9sSwWVdCqWIqvtmzaqAtoXhSWdtfLwstrCuxAjZvSzyjeJ6WIAUz2BrNIk
	m/Q/6fF8OV7fGlTnLdYRJDx9vf73c3JTH1/Du6A27BDyPxqUmUmLNk8yFUc6resH/5hSm7354wo
	AydCT+joFiqI2Mi5keLfv3rrIGBU49zEu+/Qo7yiKbJjo2ZeopCwxQ8JaidT69JatwD9NHnGhjw
	rQc9+s7tukhpdQ204YLzr5aZn0sZe+4tbdMrfj3L6tEv7+eHO+X5PhH3xNQ98wj9dbyQXQ==
X-Received: by 2002:a05:622a:5e0b:b0:4af:1535:6b53 with SMTP id d75a77b69052e-4b11575fc31mr7844771cf.54.1755178942762;
        Thu, 14 Aug 2025 06:42:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHUUko9D9muIZooHvwqxneJzEmbMuKpU9esY9TSRzoqLmOYgEw5i+o/jT3lTpx4LQ/xxEEnA==
X-Received: by 2002:a05:622a:5e0b:b0:4af:1535:6b53 with SMTP id d75a77b69052e-4b11575fc31mr7844451cf.54.1755178942267;
        Thu, 14 Aug 2025 06:42:22 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.62.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06741bf77sm152084081cf.34.2025.08.14.06.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:42:21 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:42:15 +0200
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
Subject: Re: [RFC PATCH v2 12/25] sched/rt: Add {alloc/free}_rt_sched_group
 and dl_server specific functions
Message-ID: <aJ3nt5KKZmTX8Mt_@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-13-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-13-yurand2000@gmail.com>

Hi!

On 31/07/25 12:55, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Add allocation and deallocation code for rt-cgroups. Add rt dl_server's specific
> functions that pick the next eligible task to run.
> 
> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---
>  kernel/sched/rt.c | 107 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 104 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 38178003184..9c4ac6875a2 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -93,8 +93,39 @@ void unregister_rt_sched_group(struct task_group *tg)
>  
>  void free_rt_sched_group(struct task_group *tg)
>  {
> +	int i;
> +
>  	if (!rt_group_sched_enabled())
>  		return;
> +
> +	for_each_possible_cpu(i) {
> +		if (tg->dl_se) {
> +			unsigned long flags;
> +
> +			/*
> +			 * Since the dl timer is going to be cancelled,
> +			 * we risk to never decrease the running bw...
> +			 * Fix this issue by changing the group runtime
> +			 * to 0 immediately before freeing it.
> +			 */
> +			dl_init_tg(tg->dl_se[i], 0, tg->dl_se[i]->dl_period);
> +			raw_spin_rq_lock_irqsave(cpu_rq(i), flags);
> +			BUG_ON(tg->rt_rq[i]->rt_nr_running);
> +			raw_spin_rq_unlock_irqrestore(cpu_rq(i), flags);

So here we always call dl_init_tg for cpu 0, is it correct?

Also I wonder if the lock shouldn't cover both init and subsequent
check.

> +
> +			hrtimer_cancel(&tg->dl_se[i]->dl_timer);
> +			kfree(tg->dl_se[i]);
> +		}
> +		if (tg->rt_rq) {
> +			struct rq *served_rq;
> +
> +			served_rq = container_of(tg->rt_rq[i], struct rq, rt);
> +			kfree(served_rq);
> +		}
> +	}
> +
> +	kfree(tg->rt_rq);
> +	kfree(tg->dl_se);
>  }
>  
>  void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
> @@ -109,12 +140,77 @@ void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
>  	tg->dl_se[cpu] = dl_se;
>  }
>  
> +static bool rt_server_has_tasks(struct sched_dl_entity *dl_se)
> +{
> +	return !!dl_se->my_q->rt.rt_nr_running;
> +}
> +
> +static struct task_struct *_pick_next_task_rt(struct rt_rq *rt_rq);
> +static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first);
> +static struct task_struct *rt_server_pick(struct sched_dl_entity *dl_se)
> +{
> +	struct rt_rq *rt_rq = &dl_se->my_q->rt;
> +	struct rq *rq = rq_of_rt_rq(rt_rq);
> +	struct task_struct *p;
> +
> +	if (dl_se->my_q->rt.rt_nr_running == 0)
> +		return NULL;
> +
> +	p = _pick_next_task_rt(rt_rq);
> +	set_next_task_rt(rq, p, true);
> +
> +	return p;
> +}
> +
>  int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
>  {
> +	struct rq *s_rq;
> +	struct sched_dl_entity *dl_se;
> +	int i;
> +
>  	if (!rt_group_sched_enabled())
>  		return 1;
>  
> +	tg->rt_rq = kcalloc(nr_cpu_ids, sizeof(struct rt_rq *), GFP_KERNEL);
> +	if (!tg->rt_rq)
> +		goto err;
> +	tg->dl_se = kcalloc(nr_cpu_ids, sizeof(dl_se), GFP_KERNEL);
> +	if (!tg->dl_se)
> +		goto err;

Don't we need to free the array allocated above if we fail here?

Thanks,
Juri


