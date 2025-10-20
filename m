Return-Path: <linux-kernel+bounces-860797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A334EBF0F89
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD094070FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60843043D1;
	Mon, 20 Oct 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmkU7qmw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEEC229B36
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961538; cv=none; b=r2RQTWUKNl2TwnW7mFnj52PA4Q7OyqbQ4OWmosRRINtN4XrboiB/4UDHbq7AL4N8fmWGzL3CwuqjoFKbqFyGOLnXuqECN+EUR1ix36ig/urNCAMWZKUpsrstfetu9+zbiaXFbLwlXlEFuP3Yga8moViH7HTD1A8UOWb+jARBY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961538; c=relaxed/simple;
	bh=prBsS/3TdnqRdZW7jgJaElFuOWg9kNn6hLTHuRKrO4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA9Xwfoh3410U5S1rDFEMvLs42kY6LNtSshckqLVFmrW1JzKJE3wfRGSAjTT3n82ROZ4eAU2j8gg087XXOGFAi0g4a1kbdnXpTi38cnJ/PT3K7jIh9Gq6dm5sXoWgpKkf7h0td4kg0VMJQPK7jCcdc2BcAsD6VjBYkzPGOCJVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmkU7qmw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760961536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3DGWABDIIB0dwmhK6Y7TeY6zhcql3nAwcUWHRom4zEg=;
	b=MmkU7qmwmztaS+EXaTxdSUt4G+mHq/mXvspn6c4EM1XpvyKqtJqiIbKPcfTMiuc4f2LFA2
	7uL7HK/17p394llxTba0UOAzrUZ/CeRjqbtE2+BqSyWPnLpY+NtPlrScn7o7zttbIhdy1E
	22ZnwW3gw54M9+3WnizVhzVlcEUxwHI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-p_KbAeS7MVSZBJY6JiOS9Q-1; Mon, 20 Oct 2025 07:58:54 -0400
X-MC-Unique: p_KbAeS7MVSZBJY6JiOS9Q-1
X-Mimecast-MFC-AGG-ID: p_KbAeS7MVSZBJY6JiOS9Q_1760961534
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-471005f28d2so16412085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961533; x=1761566333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DGWABDIIB0dwmhK6Y7TeY6zhcql3nAwcUWHRom4zEg=;
        b=ZHtXcDAtyaYJ5BLnGqk1h8+q+eep7eoo0COw64GTFZeivuq7zNLmUth62AuypOUR7e
         xeE7T4KL4PYO8Loto/ruZt5GiO5mZWRk72+05AYl1nrmpHJ+Umsae8CKmBqb5t2bv1ZJ
         pWXgW0Z8K4JjRWJlVhlc/6SbY1vKxXW0gabT4AiK76A+lJJZkABUrsXbarqnjUvnhcaV
         LKl3mPZZrAr9Iq5ss9nStV64L2xUBg0vC4RNeuLAXzwgonDRrNPOxcaGtBsxiwp+vEfp
         Dtl+y9M6CeSObFE5LeDoB2o4EZS7KiG9g9ll1SECWJrZoc1I+IDdvCgg6sHgSLFyNrOm
         v8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4/mPdL0lW3O8bjFrZR99JG3VwcOHfBCOSgGagL+PSVZFX4Ua3gTdNj4xKUrtV2rb6mSKKfiktNlVB8nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9XezVY4IDZ5JOeKFuFDiSwhvgKps9RV8X4VdjXZwb2YCOq7v
	Hjtp27kgbrYyu/kwlSmlx4EW5lqr5SJnDC8cwfZlb1mUjMbPJMjd9ViY520F2dlsjQB6LjLiCSE
	lgbfkeFAoBXh6agY3+2XQgLgRsQKS0empufJE2Cr6/L88tN5yQB+fs+doKfz1hcl9tQ==
X-Gm-Gg: ASbGncscSePMz/w8UxNC/z9TVwt/P1Y2yDMzvU6gIv1+g73GfwWidEq3ZMhTPHy+Nez
	uyMJvMrzEwiQ3oMMZkE2ySJFi6ZAe2nqllr0v9oxTcpV+oFG/tM4qT5FvCiEbQtx7aITZ05loSn
	BsIrH6x0XXmWsRZ19/yBph7cVKEprf6EjWKk+SAlsNe7zlVdB+kNGsCvB/u0H7Ad/39DHPgSzSg
	yZlCGk1cDPww+VIkopvixXmpo17AvREXI8gQxa/8PPS//IBiTceilcKYITtiwJxYKDRRBLCfQLe
	YMZ99E48CjkJB2hFaE66P2OR2ZnmdJYvZbdsfFeXMxpDeNT1dnEZegParAMq0tIS+0fs6PB6cGP
	pTnWtAeIHyX+gvTdHXDBHeFu/OQUHFpI=
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr91944585e9.5.1760961533608;
        Mon, 20 Oct 2025 04:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3bJRkDnTNsDoLX27C6wNA7H7qPmCVso88dp9ehs0+zp2XESQa1XmzDa+Csu2dj2eVZorh8A==
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr91944415e9.5.1760961533236;
        Mon, 20 Oct 2025 04:58:53 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c900asm229469775e9.16.2025.10.20.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:58:52 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:58:50 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPYj-iOdvgUYQFpn@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-7-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also provided later to verify:
> 
> ./runner -t rt_stall
> ===== START =====
> TEST: rt_stall
> DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
> OUTPUT:
> TAP version 13
> 1..1
> ok 1 PASS: CFS task got more than 4.00% of runtime
> 
> [ arighi: drop ->balance() now that pick_task() has an rf argument ]
> 
> Cc: Luigi De Matteis <ldematteis123@gmail.com>
> Co-developed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/core.c     |  3 +++
>  kernel/sched/deadline.c |  2 +-
>  kernel/sched/ext.c      | 51 +++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h    |  2 ++
>  4 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 096e8d03d85e7..31a9c9381c63f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8679,6 +8679,9 @@ void __init sched_init(void)
>  		hrtick_rq_init(rq);
>  		atomic_set(&rq->nr_iowait, 0);
>  		fair_server_init(rq);
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +		ext_server_init(rq);
> +#endif
>  
>  #ifdef CONFIG_SCHED_CORE
>  		rq->core = rq;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0680e0186577a..3c1fd2190949e 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1504,7 +1504,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  	 * The fair server (sole dl_server) does not account for real-time

Fair server is not alone anymore. :))

Please update the comment as well.

>  	 * workload because it is running fair work.
>  	 */
> -	if (dl_se == &rq->fair_server)
> +	if (dl_se->dl_server)
>  		return;
>  
>  #ifdef CONFIG_RT_GROUP_SCHED

...

> @@ -1487,6 +1499,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  	sub_nr_running(rq, 1);
>  
>  	dispatch_dequeue(rq, p);
> +
> +	/* Stop the server if this was the last task */
> +	if (rq->scx.nr_running == 0)
> +		dl_server_stop(&rq->ext_server);
> +

Do we want to use the delayed stop behavior for scx-server as we have
for fair-server? Wonder if it's a matter of removing this explicit stop
and wait for a full period to elapse as we do for fair. It should reduce
timer reprogramming overhead for scx as well.

Thanks,
Juri


