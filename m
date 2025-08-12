Return-Path: <linux-kernel+bounces-765106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36974B22B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7555E7AD340
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507452F531D;
	Tue, 12 Aug 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDxGvJS/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAB2F5316
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011670; cv=none; b=e5TYpRU4Xw59a4VChi/23U14IkZk4xq45Z50NWkC58wvdPkI6z8AuJ7yE+qz+fmyMjo/KJJvM5mbeR5eTKc3Hekq7iR8MKSSk2iBVSkwFIdhxYJ2pTMwk2/blaIWq8fAB544/0zBzxuJBjawz8mCzv8x4GUaaT99hHirodhTh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011670; c=relaxed/simple;
	bh=Zg4SrXm4ry1lj/M3UBxygWjyZxW7u0rFSpksOI4xbIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQG1ebj/MwABzdgpWlHBs65YJQc5pjF8DVEsrgnUgjmeiiNRiyT+7GEkYEnGVeUhQswBym54bgGh6a2cribjuOrB8+MQSPWFlYGVjGFtwyMSy8+IXcGByZoHbdnPNmvSmS/1HqSCysMN0khVGWPmI0di3m8pOZMJNEsvsJCl8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDxGvJS/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755011667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9DT/aEiW1dfKdJvUX+iX78XWtyz9361P+/Dh2IUi4Jk=;
	b=KDxGvJS/StM39wSxin24jNreTAPtZL5PuFLQVT8YS+wVzcqe7uuzR+Mb/pLhgX9XuBPgW/
	wcRS5dmcj1bNCSxLyhoUmjFqhyNboid0qC9RCzOY18F/mGwxChfCrDysyoCypZTWKma4Lv
	25nHRxPL4XyULa5JcxLP6K1njqARPPM=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-xQYZOLThNFq5Ds0-EA7u6g-1; Tue, 12 Aug 2025 11:14:26 -0400
X-MC-Unique: xQYZOLThNFq5Ds0-EA7u6g-1
X-Mimecast-MFC-AGG-ID: xQYZOLThNFq5Ds0-EA7u6g_1755011666
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4fc0a601ec1so2423809137.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755011666; x=1755616466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DT/aEiW1dfKdJvUX+iX78XWtyz9361P+/Dh2IUi4Jk=;
        b=iUYwEXV06l/GPtR7inkTDq0Oszvq7odMqCjABRxmX5rhO6I6mdEkXr2qMxecCw7lsZ
         8kgnr/pQr+JDpFQPOyWw08HAiYf/ODPujIu6QGi/VIo3mTqju23P42StoNUUbzscRmkj
         UIf9E5dbNP/Zyby6q1Thil+kF11kl9YZJYr9JhCXpyyJRtkGMWTjXlhpwI9YGqt1wvyA
         BKU19V0zQH1S9/jLjgfEqdDmto8rn87JS8tDxMfDesbqXOfW9QDfBLtGoMslO26m4Jnp
         b7+Azobm2+2jwPtMyXUr2SDABQ/7NY5b6xeVJtO/1g5CZ1geohhcdUbibcstry/GrNtj
         8lUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKgpKUQDJ215zh1hP80yNS61K8vxsou0Z2qNS8N8sl4US9/dAJAoxR/HHq9FlxrkBWPKUS7zwSh8yKl3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0DoakttBmgVDsNSkwcIp+F3Ol6OrfFlIXZXpM212SeMci7tL
	3xPpbfqnZiehSkb7Ois+wt5WcaBwOQPu17VZlTqeOWdy7A2T3wyWVTeWJbNKvnVze6jWthZ5ZFm
	vEGFu9uH8xfPu0fvyRGxhIBNqOXrdR0rS8Z8BsPTMF4iZobjE9cgUrCMOQxadoc0Rdg==
X-Gm-Gg: ASbGnctFArkQ/CnC/MktBpUhaiNTqcUvCADhwXoDgrnJKeIlhy1TQTdCQwzbJFTQ8tt
	8ErWJZwtZSzU4H7rQSmXD+GbyZoOIJmsFBN2KwdmaF+qON8SqydpnW4WAWTnS3/9pobGYf7Ns/I
	pjfFPdf9ZmJn1Q2kLgZST7k0C/7mBxGsA7C2lvXjtZtLUPfwmutS2SH/Yjg7t2/3eiBHMoyAz1E
	fhR5NeWaM1K2Ni8J2PCMPMoNwR6YxgagyxtOniRJA5dlZtr47b7kUDckqtKA8O/91WRVDqEfVaN
	No4+PEcAMc7GBGe3ae+HY+pR1NtWy8Kk9o7dWhrVaLTFgog3LHNwTq5z3K9WPyz9q0ALig==
X-Received: by 2002:a05:6102:304d:b0:4ec:c548:f953 with SMTP id ada2fe7eead31-50e237d40afmr62883137.17.1755011664645;
        Tue, 12 Aug 2025 08:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk0ki9+KpViufxZlkdc8OxioFisnGWrRW97lhM0J5vBwf5K7mjT5NnW4vpbG6iPRCvd6QZCA==
X-Received: by 2002:a05:6102:304d:b0:4ec:c548:f953 with SMTP id ada2fe7eead31-50e237d40afmr62823137.17.1755011663973;
        Tue, 12 Aug 2025 08:14:23 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.46.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e85d4f5ff4sm128259085a.3.2025.08.12.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 08:14:23 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:14:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Doug Berger <opendmb@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] sched/deadline: only set free_cpus for online runqueues
Message-ID: <aJtaSgXf9fkRo-Rp@jlelli-thinkpadt14gen4.remote.csb>
References: <20250811190536.661884-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811190536.661884-1-opendmb@gmail.com>

Hi!

On 11/08/25 12:05, Doug Berger wrote:
> Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
> to reflect rd->online") introduced the cpudl_set/clear_freecpu
> functions to allow the cpu_dl::free_cpus mask to be manipulated
> by the deadline scheduler class rq_on/offline callbacks so the
> mask would also reflect this state.
> 
> Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
> from cpudl_find()") removed the check of the cpu_active_mask to
> save some processing on the premise that the cpudl::free_cpus
> mask already reflected the runqueue online state.
> 
> Unfortunately, there are cases where it is possible for the
> cpudl_clear function to set the free_cpus bit for a CPU when the
> deadline runqueue is offline. When this occurs while a CPU is
> connected to the default root domain the flag may retain the bad
> state after the CPU has been unplugged. Later, a different CPU
> that is transitioning through the default root domain may push a
> deadline task to the powered down CPU when cpudl_find sees its
> free_cpus bit is set. If this happens the task will not have the
> opportunity to run.
> 
> One example is outlined here:
> https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com
> 
> Another occurs when the last deadline task is migrated from a
> CPU that has an offlined runqueue. The dequeue_task member of
> the deadline scheduler class will eventually call cpudl_clear
> and set the free_cpus bit for the CPU.
> 
> This commit modifies the cpudl_clear function to be aware of the
> online state of the deadline runqueue so that the free_cpus mask
> can be updated appropriately.
> 
> It is no longer necessary to manage the mask outside of the
> cpudl_set/clear functions so the cpudl_set/clear_freecpu
> functions are removed. In addition, since the free_cpus mask is
> now only updated under the cpudl lock the code was changed to
> use the non-atomic __cpumask functions.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---

Thanks for this new approach, it looks good to me.

I would like to stress test it a little more, and have a comment below.

>  kernel/sched/cpudeadline.c | 34 +++++++++-------------------------
>  kernel/sched/cpudeadline.h |  4 +---
>  kernel/sched/deadline.c    |  8 ++++----
>  3 files changed, 14 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index cdd740b3f774..d612d5c6c61a 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -166,12 +166,13 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>   * cpudl_clear - remove a CPU from the cpudl max-heap
>   * @cp: the cpudl max-heap context
>   * @cpu: the target CPU
> + * @online: the online state of the deadline runqueue
>   *
>   * Notes: assumes cpu_rq(cpu)->lock is locked
>   *
>   * Returns: (void)
>   */
> -void cpudl_clear(struct cpudl *cp, int cpu)
> +void cpudl_clear(struct cpudl *cp, int cpu, bool online)
>  {
>  	int old_idx, new_cpu;
>  	unsigned long flags;
> @@ -184,7 +185,7 @@ void cpudl_clear(struct cpudl *cp, int cpu)
>  	if (old_idx == IDX_INVALID) {
>  		/*
>  		 * Nothing to remove if old_idx was invalid.
> -		 * This could happen if a rq_offline_dl is
> +		 * This could happen if rq_online_dl or rq_offline_dl is
>  		 * called for a CPU without -dl tasks running.
>  		 */
>  	} else {
> @@ -195,9 +196,12 @@ void cpudl_clear(struct cpudl *cp, int cpu)
>  		cp->elements[new_cpu].idx = old_idx;
>  		cp->elements[cpu].idx = IDX_INVALID;
>  		cpudl_heapify(cp, old_idx);
> -
> -		cpumask_set_cpu(cpu, cp->free_cpus);
>  	}
> +	if (unlikely(!online))

Isn't using likely(online) more direct and cleaner? :)

> +		__cpumask_clear_cpu(cpu, cp->free_cpus);
> +	else
> +		__cpumask_set_cpu(cpu, cp->free_cpus);
> +
>  	raw_spin_unlock_irqrestore(&cp->lock, flags);
>  }

Best,
Juri


