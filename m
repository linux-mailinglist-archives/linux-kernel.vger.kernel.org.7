Return-Path: <linux-kernel+bounces-812852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B1EB53DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DB73A1C74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1BF229B18;
	Thu, 11 Sep 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+fNm4/I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F722DC762
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757625670; cv=none; b=CBy7BYLLQuSXSEbIxIVPYYuCrSDPkbw5rW1v05+4ZWCuUb6sShSeKdvJ2CuvRGk0zlpYZm9Ph91mzghvNRJlhIW8eD5SKm3VQvlZ1aRt+2/FNb8eDrU/WPYs0Tz4OOxLwf0+J/Kug0FIsryzX0kJBOx6hTNa0lDS9gacsuD5m1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757625670; c=relaxed/simple;
	bh=QyJtcQPcEZ8nVwrzFwz0lmfAF0Jafs45nc9NO4VMVgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzo+WgtecsjurQGybcwmp5YD621uo91vCikbkPkCGxZmDdspjT+sj2BF1JtxhkEnAyas6lLYx0PmMkQ3S5UFq1Z7soV9EDzZPxUF4ZqqMC+zTbkbO7/RRy1GIkVzuvfyGqJiKHtvTIYNE4gCvYgzc/ywMqjzjaNJWHkzKk2Yng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+fNm4/I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757625664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPivr8Py3B0NFnkMK/EAFf26R7QjGJ5nyyS4H+kZWOI=;
	b=D+fNm4/IHZLnhovA9pOg+KEttvFQV6CxJN3casz3kzgxMhWTJDi3MjM3zgvsfnPunmwGch
	r1ggQQkNk4M8yPG1AI8/xfgkx41nBxlUWT2ZH4GvjtMfAkV8YemVPT5rZP9myO2Mze5QAO
	txHBcZ23RTpFW2SUi1XKuYipImY6C68=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-cxm8U4-5OE623rJNTXZ19w-1; Thu,
 11 Sep 2025 17:21:02 -0400
X-MC-Unique: cxm8U4-5OE623rJNTXZ19w-1
X-Mimecast-MFC-AGG-ID: cxm8U4-5OE623rJNTXZ19w_1757625660
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AB631800452;
	Thu, 11 Sep 2025 21:21:00 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BDF430002C6;
	Thu, 11 Sep 2025 21:20:57 +0000 (UTC)
Date: Thu, 11 Sep 2025 17:20:54 -0400
From: Phil Auld <pauld@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: simplify task_numa_find_cpu()
Message-ID: <20250911212054.GD7235@pauld.westford.csb>
References: <20250911203136.548844-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911203136.548844-1-yury.norov@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Sep 11, 2025 at 04:31:35PM -0400 Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> Use for_each_cpu_and() and drop some housekeeping code.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

The "housekeeping" part threw me off for a second. I was looking for
isolation related code being dropped :)


Reviewed-by: Phil Auld <pauld@redhat.com>


> ---
>  kernel/sched/fair.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0990ed90c14e..c48c0975fe7a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2474,11 +2474,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>  		maymove = !load_too_imbalanced(src_load, dst_load, env);
>  	}
>  
> -	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
> -		/* Skip this CPU if the source task cannot migrate */
> -		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
> -			continue;
> -
> +	/* Skip CPUs if the source task cannot migrate */
> +	for_each_cpu_and(cpu, cpumask_of_node(env->dst_nid), env->p->cpus_ptr) {
>  		env->dst_cpu = cpu;
>  		if (task_numa_compare(env, taskimp, groupimp, maymove))
>  			break;
> -- 
> 2.43.0
> 
> 

-- 


