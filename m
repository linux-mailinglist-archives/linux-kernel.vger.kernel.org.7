Return-Path: <linux-kernel+bounces-892576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B731C45613
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBEF3B39F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B62FC01B;
	Mon, 10 Nov 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X32hUG8Z"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB02FBE01
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763404; cv=none; b=OuHNhVkjInlZ3jRRT3m3CsXpYXT3OU9jIvTNIU741zlktbqunDKLGA0yrbKbXCgGk8LpbGCRbH8Z8qE38CF93wfU4oOKadQfaGgXMalAdgE8hJ2RhLvSK+izBEsXOYYHkCK076ygs/byzvkR9/L5lrxBrzNR4FLXFV+R/EfuikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763404; c=relaxed/simple;
	bh=ND28dtJOsES5XuobflpYBzeBDfecK0Z6MQsRDFRzIV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+iaKvS8J7yX5cOlWilxFToDApIHOZ6BSjYpzkKQ6s3XDgFsGSjxEBzhwIYHTtWwQzz0nrWDsO3hbK0T7apkbH8Xx5v45MjultNWx5AjI50vNcoVV2ZhK8DT/r4WZcd4Z+iMCV/uYzKcx5PDPEOMZMSo4qJeMBUfzQNE93ohpNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X32hUG8Z; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 09:29:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762763400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zq54ZpUTeLpQv2UpzCWGpEFEV7z02gjTzdSmIMnN5F0=;
	b=X32hUG8ZsZyZIdEaNoSRpSGj6dj/h2BCDs8OheHaMTjGEmjyNLEU49XXzwTDn95uA/P5FO
	6Z1fPRP8lpIqMqOyJ95Q0Ys6plQ9dPtDII0LX/8uRFJs9BUJ9cz8TXlMYaMUfYWiU+kVJ8
	mEOESdTlyJ/2XV5Aco4thu1LXtVa2Wg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] sched_ext: Make handle_lockup() propagate
 scx_verror() result
Message-ID: <aRGigc4YQFsyK7Hd@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-10-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-10-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 09, 2025 at 08:31:08AM -1000, Tejun Heo wrote:
> handle_lockup() currently calls scx_verror() but ignores its return value,
> always returning true when the scheduler is enabled. Make it capture and return
> the result from scx_verror(). This prepares for hardlockup handling.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5c75b0125dfe..4507bc4f0b5c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3658,6 +3658,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  {
>  	struct scx_sched *sch;
>  	va_list args;
> +	bool ret;
>  
>  	guard(rcu)();
>  
> @@ -3669,9 +3670,9 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  	case SCX_ENABLING:
>  	case SCX_ENABLED:
>  		va_start(args, fmt);
> -		scx_verror(sch, fmt, args);
> +		ret = scx_verror(sch, fmt, args);
>  		va_end(args);
> -		return true;
> +		return ret;
>  	default:
>  		return false;
>  	}
> -- 
> 2.51.1
> 

