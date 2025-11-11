Return-Path: <linux-kernel+bounces-895772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7398C4EDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98981891806
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144636A02D;
	Tue, 11 Nov 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+qm8opW"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5E36A026
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876206; cv=none; b=PJBttlepUbISOHm9uSVoSAEcy0jwsbmWWmBnhQMV6laH01icDY/K6TDHJtDBxBXR3fTPlv7PSV03kIaX7PvK51+Atu0W1CQs5GzUUc4RJVzu87ZCqjxOTq30Sojgoeg66ZDggPY2ZEGM/sHCYttSazyRgxpfpBS8MGmOfnxXX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876206; c=relaxed/simple;
	bh=ESyER2JSxYY4NsV34yBghgZ/2Fls0YEErp/SY+YCskE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3M59v2liH2soxvUEQ/RIssq70INBOF+S2K5YIAPAFtfFcqyrao8J4LUwITu2HTQB8hNICDZZjH8BgAzxSlAVoqbGmKo6v2lcJCHGs1yf/X4sxnTisbWLYitZ68Ih1qoFlpePMBh13miDNwDtchEfIoYWa9MG8tLYcepvuYhSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+qm8opW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b26b12be9eso91167885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876203; x=1763481003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BwefmE2IIwpJVnJq6WbbfWH7vOY7bkvNqlJ8WW2tUJ8=;
        b=g+qm8opWkg2yOmOfKjjqwEDy7Iytj6coRI/5TVSEPdkP3k5GetxZHa8xu/nLEfPyL2
         0FnRT57a3QgwVv+Tg1m5IHZmjP6/w/4t2oCNdPcqPPzMMvl63m/NoQTGzSr/yG8Os2hT
         oZVA1FluUEaq8MM8nvFTN5hJ8xJ8xkBdEa+GipsOTJUnxT2nhUEla4vJrxumbSaihzDS
         Z+Fo8m0ebJWX/mUy+Ww4h8h+85hUvRx6hHQJZoCQsYsfg/NI8pgAX11H8UuDLI0jRaun
         zK/bK6Mt7MpMEZ46qDP++kqb/xOfRsZcugQCzc/WJIMwBA14FO16DgJSzy+iEVJKIYpC
         uXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876203; x=1763481003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwefmE2IIwpJVnJq6WbbfWH7vOY7bkvNqlJ8WW2tUJ8=;
        b=T1BVUSCL4OBoLPNW+RL+7b1dGl/QGZMAOPUHv2o+yBACJWTjXM/G2fgtjpcWCcsI82
         7HAiIABp6yrL7Wpsx2x5PW4o+BXsQR2udfSxcIplu8PKFKMLbyJpBAnqGw/T6601HCnr
         1Y9kJo27BnkDvxsDt/VWbTvWcw1oTJj+SB77XezOaKqsytgpz39K6zKFl50kMYX6yUq4
         om/y24gRvbFXHF7V1ryJ0urug9z6ZmfS8RosCeJSy6hLqmnHk0HdY7Emv1W7bdoPv4/d
         7vLXciSCW4hfZhX7SHwPsYP45tF1Lj0XCDCz/luOqgPzN/q0CGd6hXpV2E/2DmM6LaKl
         x7NQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4RCLVqg7XHoP3moIa23bvcA1Oi1DSIxTUDl/l4zWk0qLzP3o4EIv7i38auGZyXKSjVniSH9JcmP3Lw3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWFUnnZK3Ey4wELND278syW7RuBq39tA/u/9Hpcdbht5VWyRl
	4TZ/rg9WRiWPyoKZ5QYFtxeT3ExG7URt9dIJFMrT/HUAXL8/MIEvP0S3
X-Gm-Gg: ASbGncuY4E3+qY3YejKUG4ZgqxU0chIvMN46VibzJdWkwRP3Mcy9GvSPK85VXzwa0yI
	UjM8xt8dZ4BT8RIMifOlXpBb4RZWjmqRMgvQg3n3nb3YAELDUpflrL56571sNwTrDlA85j6ZlfH
	e8YMhTOHHG56HYqMp5bsCzsFcwWpoY6uIVQrOEAEul0TPymTQYYRF40IrNCd3lpnGmLF8K7d9Fa
	mSHVHo3cwdvG/AsMuUbKRGkyBdMF+ZSMjL4UlAb298+evFcsUDdrCY6qqJLO2MVldbLXdezqUko
	QVvW8ARcG5SMw3SPlLZmtMnVxuSXk9eArwek6OnTjS7T7F+Ihr5ZL9IhajaUsyNe8q4opTEfnQl
	Sp6kfkwMVdGJR3U0qjmjVLVmPyKySDwJOdJM4TV1x60hqd3dqo3iCHdptHAcQS2ZcvfucNQmhdC
	xxqXWC8Tu2RQGKBVgt9N0RsvXE
X-Google-Smtp-Source: AGHT+IEqK4mmcwj1No+DeMHAuBPHf2gYyU/MGOLcd6RyV4lLyqhIbyC1o/hm9IO4zzs/5TliDWk8XA==
X-Received: by 2002:a05:620a:4722:b0:8a3:fa43:321b with SMTP id af79cd13be357-8b257f038cbmr1699387385a.27.1762876202543;
        Tue, 11 Nov 2025 07:50:02 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:708f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa27882sm5521185a.55.2025.11.11.07.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:50:01 -0800 (PST)
Date: Tue, 11 Nov 2025 10:49:59 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] sched_ext: Refactor lockup handlers into
 handle_lockup()
Message-ID: <aRNbJ2zzq814zPsG@dschatzberg-fedora-PF3DHTBV>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-9-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-9-tj@kernel.org>

On Sun, Nov 09, 2025 at 08:31:07AM -1000, Tejun Heo wrote:
> scx_rcu_cpu_stall() and scx_softlockup() share the same pattern: check if the
> scheduler is enabled under RCU read lock and trigger an error if so. Extract
> the common pattern into handle_lockup() helper. Add scx_verror() macro and use
> guard(rcu)().
> 
> This simplifies both handlers, reduces code duplication, and prepares for
> hardlockup handling.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 65 ++++++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 033c8b8e88e8..5c75b0125dfe 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -195,6 +195,7 @@ static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
>  }
>  
>  #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
> +#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
>  
>  #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
>  
> @@ -3653,39 +3654,40 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
>  	return false;
>  }
>  
> -/**
> - * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
> - *
> - * While there are various reasons why RCU CPU stalls can occur on a system
> - * that may not be caused by the current BPF scheduler, try kicking out the
> - * current scheduler in an attempt to recover the system to a good state before
> - * issuing panics.
> - */
> -bool scx_rcu_cpu_stall(void)
> +static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  {
>  	struct scx_sched *sch;
> +	va_list args;
>  
> -	rcu_read_lock();
> +	guard(rcu)();
>  
>  	sch = rcu_dereference(scx_root);
> -	if (unlikely(!sch)) {
> -		rcu_read_unlock();
> +	if (unlikely(!sch))
>  		return false;
> -	}
>  
>  	switch (scx_enable_state()) {
>  	case SCX_ENABLING:
>  	case SCX_ENABLED:
> -		break;
> +		va_start(args, fmt);
> +		scx_verror(sch, fmt, args);
> +		va_end(args);
> +		return true;
>  	default:
> -		rcu_read_unlock();
>  		return false;
>  	}
> +}
>  
> -	scx_error(sch, "RCU CPU stall detected!");
> -	rcu_read_unlock();
> -
> -	return true;
> +/**
> + * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
> + *
> + * While there are various reasons why RCU CPU stalls can occur on a system
> + * that may not be caused by the current BPF scheduler, try kicking out the
> + * current scheduler in an attempt to recover the system to a good state before
> + * issuing panics.
> + */
> +bool scx_rcu_cpu_stall(void)
> +{
> +	return handle_lockup("RCU CPU stall detected!");
>  }
>  
>  /**
> @@ -3700,28 +3702,11 @@ bool scx_rcu_cpu_stall(void)
>   */
>  void scx_softlockup(u32 dur_s)
>  {
> -	struct scx_sched *sch;
> -
> -	rcu_read_lock();
> -
> -	sch = rcu_dereference(scx_root);
> -	if (unlikely(!sch))
> -		goto out_unlock;
> -
> -	switch (scx_enable_state()) {
> -	case SCX_ENABLING:
> -	case SCX_ENABLED:
> -		break;
> -	default:
> -		goto out_unlock;
> -	}
> -
> -	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU%d stuck for %us, disabling \"%s\"\n",
> -			smp_processor_id(), dur_s, scx_root->ops.name);
> +	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
> +		return;
>  
> -	scx_error(sch, "soft lockup - CPU#%d stuck for %us", smp_processor_id(), dur_s);
> -out_unlock:
> -	rcu_read_unlock();
> +	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
> +			smp_processor_id(), dur_s);
>  }
>  
>  /**
> -- 
> 2.51.1
> 

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>

