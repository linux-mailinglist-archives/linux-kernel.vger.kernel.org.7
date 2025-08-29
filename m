Return-Path: <linux-kernel+bounces-792559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F24BB3C58B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863951C80405
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2971A2FF650;
	Fri, 29 Aug 2025 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NAa8XrSu"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA2256C88
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756509641; cv=none; b=njx/myluzjEwFPvZo8cTTzKmMeFFHEUoIPQz2nYs1mu0npi1ZPu3mJdgVUv8mPUl7qC2eAe2aL3MFqYLK4hA7wuGyHmBPJXdJszTogG7TMvVTMY/r/hbxaytTtRRSPHFL+3aTdNmihBZtFGHfFQ6qcQ84Ue5CIjJshmyQQrerfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756509641; c=relaxed/simple;
	bh=sVHh0fDJEEcbI6I0CB6sLa1P9jRyNfdXhp8W0dVa1+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=licjzP61DoyKRYqEowFth0uzNlIftXNSfBfZ2qgLqxchxAByJlKTEXHDAJZgSV4YK5B57+rOL/XDjKgHYnRs/TZpBpP1K3EsTJtZxlsEIA61AnUBI0TALEszRYvq11nNpYLQN72u/h73l9PL23vfIDJB12N/L43d5pK7OEDXsu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NAa8XrSu; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 29 Aug 2025 16:20:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756509635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kh81RZzZpiPIXslFRnG6rVGhlxEMq1kmBomjyvChOoo=;
	b=NAa8XrSuTmfZlqPQgBBj09AOVxU4pwSzGo4oJBiUrceLy/eecA5iyB/uL5oOGh5Mi0bu9o
	l1Q6G36QIR7zYO1/yS3pnuoJzUYypvb1V++f1KGRD1N6UxquIiIZg+zyobwqxX+U43MApM
	kfGzGtcp47eueHFXJZd+M2oCJyEpaSI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: zhongjinji <zhongjinji@honor.com>
Cc: mhocko@suse.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, surenb@google.com, 
	liulu.liu@honor.com, feng.han@honor.com, tianxiaobin@honor.com, fengbaopeng@honor.com
Subject: Re: [PATCH v6 1/2] mm/oom_kill: Do not delay oom reaper when the
 victim is frozen
Message-ID: <krmliemwgxygxkc3rkix5ah6ubzzulpktejdbu5uhpldwtjts2@3sqqkl5i36tv>
References: <20250829065550.29571-1-zhongjinji@honor.com>
 <20250829065550.29571-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829065550.29571-2-zhongjinji@honor.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 29, 2025 at 02:55:49PM +0800, zhongjinji wrote:
> The oom reaper is a mechanism to guarantee a forward process during OOM
> situation when the oom victim cannot terminate on its own (e.g. being
> blocked in uninterruptible state or frozen by cgroup freezer). In order
> to give the victim some time to terminate properly the oom reaper is
> delayed in its invocation. This is particularly beneficial when the oom
> victim is holding robust futex resources as the anonymous memory tear
> down can break those. [1]
> 
> On the other hand deliberately frozen tasks by the freezer cgroup will
> not wake up until they are thawed in the userspace and delay is
> effectively pointless. Therefore opt out from the delay for cgroup
> frozen oom victims.
> 
> Reference:
> [1] https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> ---
>  mm/oom_kill.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..a5e9074896a1 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -700,7 +700,14 @@ static void queue_oom_reaper(struct task_struct *tsk)
>  
>  	get_task_struct(tsk);
>  	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
> -	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
> +	tsk->oom_reaper_timer.expires = jiffies;
> +
> +	/*
> +	 * If the task is frozen by the cgroup freezer, the delay is unnecessary
> +	 * because it cannot exit until thawed. Skip the delay for frozen victims.
> +	 */
> +	if (!frozen(tsk))

Can you please change the above condition with the following to handle
v2 as well?

	if (!frozen(tsk) && !(READ_ONCE(tsk->frozen)))

> +		tsk->oom_reaper_timer.expires += OOM_REAPER_DELAY;
>  	add_timer(&tsk->oom_reaper_timer);
>  }
>  
> -- 
> 2.17.1
> 

