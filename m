Return-Path: <linux-kernel+bounces-722437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20001AFDAC6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0621AA5167
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CF259C92;
	Tue,  8 Jul 2025 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="KvvL/TIi"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402321E7C27
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013049; cv=none; b=V9TN0yUNS+T+vRTcPR8QeeDaqa8HZFTCH7hyyGbBwgFKxeQWe2F4KM49Rpvbl15AT9dry6GVCTQ4eeG1dbAB/meKLxLLVL4Wvxf4I6qgKPlv3uLtjjNU49AJmIFfQ30GhJR/VoBGumMjoH6JLYTGRgDON/MxH36ZATdgYPB/UNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013049; c=relaxed/simple;
	bh=FEsHHCXguomOaO5bik3AeXk7CTSFcx8L09BKO1O368Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfGO2k9VLYvNIzTT3UiM7wPWdx0uv+uSI+kN1QYyR/zJPLCUAJNRqQVekZyjuXioakqxolXEndSDP+7Srgti3jZkcKA9FlOyAnjkkZQzD4z3fTCUcvypr/t5f3Imn6f4JYgqANPnBkBPuZsiQyOHNXKjltRQzWs+oV+XThihmbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=KvvL/TIi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748feca4a61so2661185b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1752013047; x=1752617847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKXk1db6biREjlZvqs5QtrQaNwXkFG+6GDi1WibA3ro=;
        b=KvvL/TIioCYVd8ec6u1u7e4VvwMdsL5s4CjMvmrmcnCQwVaVdadUEERmx2LswxOmMz
         L59/rp7g9rA0t34TXCthdNXkzai/LQ3iEiCbq8AgYI5qzRCNvOviuSEVcDZ4m7xyAlOV
         SNB/PMRH0+nJ8ON7Su1q+hApFLyr2mWXeTxht40EZvJPOvDn+SzBIfpt+Ni+HOW7pP9G
         gwTbCQjAYiSuzuNnd3LhsOI6CCgqhkOQQay5jHuGJl339LSy92XenQvGecHTDCWJ322F
         9KbE5KMDqNN+PevXAWgWUJxU7LBaSvNVvphLutBeTVo4eoKXciiE7Bun1r7rCyvquUgm
         D7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752013047; x=1752617847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKXk1db6biREjlZvqs5QtrQaNwXkFG+6GDi1WibA3ro=;
        b=Vyte3eypwyFNi4TOYIVdQAibiaYCbrIinN/p98dC87GgWP2SuqF0ND7kW4uxjXIYfa
         VIDTwZAh4ZD/TCq2XvMC8wUTtpnqM3H8//v0Ilk5T5Zn3xSw+OvIz3Crs2sTCd0rII0M
         W9rP+GUlU9UE8ldSdqNWB+fHVIkbAc+OjgjT8e3fObCVuvwwaB3RyU8ohWXOk33bIoSl
         dQJ1vjn7pmIZ7N4Emo/1KP85pKCRzT4+6Knycmyq/O+GSLV1yCqzOc+hYtBax/T4ARAM
         BAx7jKeu33rttEcQLuuAMtZxQxS3vnLeaJd/R9mGv/yIysSt9BknYmjQWxkMFwXI3vy4
         gd4A==
X-Gm-Message-State: AOJu0YxB/0vDze10CCaCD2nSs7bcjyhGYmOBvcLzgEq/fGku9syLcDUe
	oOJymnZGn3f7pf5bYBJtr+3rGaviEvRD+dSLggNVB65nTfooyGADHHX1MR87T9zg76N+
X-Gm-Gg: ASbGncvhEgmVC6eGMmm1aiqDq+B3OEWuwbn1iTjIeibbCRTRp8pBH+31vrlsHlgCMtH
	Ch5NjpYehwJkmiHIWG6tY3nG1Wf1EcW/gBQ9DKqO1oowrvsr74Eb+63VbdiS6y+Fx6STaKknQSD
	uzWO8O6J293vs36i2YTsMP0D1DQbafnF994HPuzcqQsPOdh94b6EWpqgPLTpXPKdrwpuPPBdSlY
	rtS+3NwsQlNweHV2YmjOflbOf0WQiMjR3kIi/4fpLfiIS5pxCjFffGwp3gB0AlLH8q/5EqqprzS
	I+Ef2+BtXq5AEDk77idCUGBLR+eaFW32UagcPSw739o/PQZOTzoJbHp0P13Xo1b0
X-Google-Smtp-Source: AGHT+IFrdLI7zE62JzRTcm8R+nfJf9KUyF1VAbRhM4J+cUdpeivJAHC78io6XrTAM4cJnrpP4SgnAg==
X-Received: by 2002:a05:6a00:2d0c:b0:74c:efae:ffae with SMTP id d2e1a72fcca58-74ea63e3dbfmr342284b3a.5.1752013047402;
        Tue, 08 Jul 2025 15:17:27 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc13csm11567452b3a.47.2025.07.08.15.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 15:17:26 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:17:23 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 1/5] kernel/async: streamline cookie synchronization
Message-ID: <aG2Y8795VSeT75hH@sultan-box>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250625201853.84062-2-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625201853.84062-2-stuart.w.hayes@gmail.com>

On Wed, Jun 25, 2025 at 03:18:49PM -0500, Stuart Hayes wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> To prevent a thundering herd effect, implement a custom wake function for
> the async shubsystem which will only wake waiters which have all their
> dependencies completed.
> 
> The async subsystem currently wakes all waiters on async_done when an async
> task completes. When there are many tasks trying to synchronize on differnt
> async values, this can create a thundering herd problem when an async task
> wakes up all waiters, most of whom go back to waiting after causing
> lock contention and wasting CPU.
> 
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
>  kernel/async.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/async.c b/kernel/async.c
> index 4c3e6a44595f..ae327f29bac9 100644
> --- a/kernel/async.c
> +++ b/kernel/async.c
> @@ -76,6 +76,12 @@ struct async_entry {
>  	struct async_domain	*domain;
>  };
>  
> +struct async_wait_entry {
> +	wait_queue_entry_t wait;
> +	async_cookie_t cookie;
> +	struct async_domain *domain;
> +};
> +
>  static DECLARE_WAIT_QUEUE_HEAD(async_done);
>  
>  static atomic_t entry_count;
> @@ -298,6 +304,24 @@ void async_synchronize_full_domain(struct async_domain *domain)
>  }
>  EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
>  
> +/**
> + * async_domain_wake_function - wait function for cooking synchronization
> + *
> + * Custom wait function for async_synchronize_cookie_domain to check cookie
> + * value.  This prevents waking up waiting threads unnecessarily.
> + */
> +static int async_domain_wake_function(struct wait_queue_entry *wait,
> +				      unsigned int mode, int sync, void *key)
> +{
> +	struct async_wait_entry *await =
> +		container_of(wait, struct async_wait_entry, wait);
> +
> +	if (lowest_in_progress(await->domain) < await->cookie)
> +		return 0;
> +
> +	return autoremove_wake_function(wait, mode, sync, key);
> +}
> +
>  /**
>   * async_synchronize_cookie_domain - synchronize asynchronous function calls within a certain domain with cookie checkpointing
>   * @cookie: async_cookie_t to use as checkpoint
> @@ -310,11 +334,27 @@ EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
>  void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain *domain)
>  {
>  	ktime_t starttime;
> +	struct async_wait_entry await = {
> +		.cookie = cookie,
> +		.domain = domain,
> +		.wait = {
> +			.func = async_domain_wake_function,
> +			.private = current,
> +			.flags = 0,
> +			.entry = LIST_HEAD_INIT(await.wait.entry),
> +		}};
>  
>  	pr_debug("async_waiting @ %i\n", task_pid_nr(current));
>  	starttime = ktime_get();
>  
> -	wait_event(async_done, lowest_in_progress(domain) >= cookie);
> +	for (;;) {
> +		prepare_to_wait(&async_done, &await.wait, TASK_UNINTERRUPTIBLE);
> +
> +		if (lowest_in_progress(domain) >= cookie)

This line introduces a bug on PREEMPT_RT because lowest_in_progress() may sleep
on PREEMPT_RT. If it does sleep, it'll corrupt the current task's state by
setting it to TASK_RUNNING after the sleep is over. IOW, the current task's
state might be TASK_RUNNING after lowest_in_progress() returns.

lowest_in_progress() may sleep on PREEMPT_RT because it locks a non-raw spin
lock (async_lock).

> +			break;
> +		schedule();
> +	}
> +	finish_wait(&async_done, &await.wait);
>  
>  	pr_debug("async_continuing @ %i after %lli usec\n", task_pid_nr(current),
>  		 microseconds_since(starttime));
> -- 
> 2.39.3
> 

Sultan

