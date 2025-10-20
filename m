Return-Path: <linux-kernel+bounces-860903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E9BF1413
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A41EE4F14F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ECA3112BD;
	Mon, 20 Oct 2025 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNI+mQLL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D232FDC20
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963832; cv=none; b=BFO2yUhvme5qeNr56o6K5d3oJ0occiYrUkI0AvpTGalbwG8mLM7SKQHq/PMwTHpkEYVUbRqj1VivWbjncfaDR9MuqMSQTGVrLYi3uT3kAqO0bpOZ8tKY9krAtM6XJvXPGheamPAz/7e+KJ9B9A/g6F3TSq4yGLYxvHZcZo78l4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963832; c=relaxed/simple;
	bh=Hb8vMFnJWtt9JWRdtQrx1uzFcIosNZOkgn5jFWSP2JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NloLiKbfFVHoOYKfZ5C6maMnPkTp50faaT4c9GF8aRw+BqBdnc0T+JDrcMwTJiqGvt4La67BEZSIkvHlVjpPMTG4F8ph8EpZBj0x4dPU1KzMeioatWFV6y8Ibk37HSgKXUAltHGpdmqQm1d8mHVSOeQ9i2JmmVCOiQVIGv8g3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNI+mQLL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760963829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7/5n7Nz7/R8H3NytbcahCz3tfCjEdVoB19BXcmANLI=;
	b=cNI+mQLLrt0Xthoq3KL6EDMIAmdTqm9qPpJNtI1eQid6HyxqU5IbqiWCZX/Vx2t+toBhPD
	In6FZ3Ec3DAbRM5G77YJE608tdTrXnqk6s7KLEJ8O4RqKvcxIKP5w+G8nSo+O8QFAGtinW
	FkmctPrDYfOVL5dwVA2GVlSrFzmRbjs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-rwlaeTjlOhqDi7IpR_i6cA-1; Mon,
 20 Oct 2025 08:37:05 -0400
X-MC-Unique: rwlaeTjlOhqDi7IpR_i6cA-1
X-Mimecast-MFC-AGG-ID: rwlaeTjlOhqDi7IpR_i6cA_1760963824
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB56819560B0;
	Mon, 20 Oct 2025 12:37:02 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.45.224.217])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53BAF1800451;
	Mon, 20 Oct 2025 12:36:53 +0000 (UTC)
Date: Mon, 20 Oct 2025 08:36:48 -0400
From: Phil Auld <pauld@redhat.com>
To: shubhang@os.amperecomputing.com
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shubhang Kaushik <sh@gentwo.org>,
	Shijie Huang <Shijie.Huang@amperecomputing.com>,
	Frank Wang <zwang@amperecomputing.com>,
	Christopher Lameter <cl@gentwo.org>,
	Adam Li <adam.li@amperecomputing.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
Message-ID: <20251020123648.GA851830@pauld.westford.csb>
References: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi,

On Fri, Oct 17, 2025 at 04:00:44PM -0700 Shubhang Kaushik via B4 Relay wrote:
> From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> 
> Modify the wakeup path in `select_task_rq_fair()` to prioritize cache
> locality for waking tasks. The previous fast path always attempted to
> find an idle sibling, even if the task's prev CPU was not truly busy.
> 
> The original problem was that under some circumstances, this could lead
> to unnecessary task migrations away from a cache-hot core, even when
> the task's prev CPU was a suitable candidate. The scheduler's internal
> mechanism `cpu_overutilized()` provide an evaluation of CPU load.
> 
> To address this, the wakeup heuristic is updated to check the status of
> the task's `prev_cpu` first:
> - If the `prev_cpu` is  not overutilized (as determined by
>   `cpu_overutilized()`, via PELT), the task is woken up on
>   its previous CPU. This leverages cache locality and avoids
>   a potentially unnecessary migration.
> - If the `prev_cpu` is considered busy or overutilized, the scheduler
>   falls back to the existing behavior of searching for an idle sibling.
> 
> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> ---
> This patch optimizes the scheduler's wakeup path to prioritize cache 
> locality by keeping a task on its previous CPU if it is not overutilized,
> falling back to a sibling search only when necessary.
> ---
>  kernel/sched/fair.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc0b7ce8a65d6bbe616953f530f7a02bb619537c..bb0d28d7d9872642cb5a4076caeb3ac9d8fe7bcd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8618,7 +8618,16 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  		new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
>  	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
>  		/* Fast path */
> -		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +
> +		/*
> +		 * Avoid wakeup on an overutilized CPU.
> +		 * If the previous CPU is not overloaded, retain the same for cache locality.
> +		 * Otherwise, search for an idle sibling.
> +		 */
> +		if (!cpu_overutilized(prev_cpu))
> +			new_cpu = prev_cpu;
> +		else
> +			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);

Won't this be checking if the cpu is overusitilzed without the wakee. It
might well be overutilized once the wakee is placed there.

I suspect this will hurt some workloads. Do you have numbers to share?


Cheers,
Phil


>  	}
>  	rcu_read_unlock();
>  
> 
> ---
> base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
> change-id: 20251017-b4-sched-cfs-refactor-propagate-2c4a820998a4
> 
> Best regards,
> -- 
> Shubhang Kaushik <shubhang@os.amperecomputing.com>
> 
> 
> 

-- 


