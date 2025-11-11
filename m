Return-Path: <linux-kernel+bounces-895496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB9BC4E1A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56E83ACB93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BEC33AD84;
	Tue, 11 Nov 2025 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="edKIBlf4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BBB331212
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867571; cv=none; b=qRZDwpNvPY3Ceo/zTJVM4iS5GVOSyhn3fVtRgAeRhpu0negrkhdWrMnuC2EaKRRDbzvE652eybG3BC7tgvF8jI1NhToYIQTwPwAIo46wYWak3IDbiZYB8GoW8DNBWMKQ1WM5s/YfHJXIshg2xv0fcasMbmFglGyp35DuhYexzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867571; c=relaxed/simple;
	bh=R+F3wm5JZtyF47y5zSVjOwBuySW8QTK8Fou3F4m2l/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgvAzRkQ+uFBjidOGRHeaDYM7bVKR1Yr+saO63y5Qhft8P4TjrI+PGjURzJSlWq2dIpTZgNyIkvQjGYvJf4gvyvyy3dasc97xJ/o2TmxmXOxZcnYdEy6+/ZXudajFZLnSIqkoHIQf34us7/39ahJRiG78vHIhBA1PNA4W7BeEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=edKIBlf4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477632b0621so28677025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762867567; x=1763472367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=12Z2StwH8KT2vPfAgGG39DszHYOdZn8zdYfVoARngiY=;
        b=edKIBlf43Dc7EzyoxsiqES4vyfev3dukJ5uYMzw9G15zhx0IE8MEl9w5I+uIWc/phv
         9mr55jBL7C6RfBO9co8dMyWvrbQNzrp0+0cJ0XXbgWQmH0IRxk/fSuw0V4znPm1olT0u
         vg8PKmKY28VMEwUxSwHP0Wni3APQoJvbbUHlUMC7wToi6DAAmVFSCeobxInlqGwa6/zR
         wRtpE7l4Eoqa63+McaQufCwBt0x8D6ASfI3RCzyPwjDP9+Ba86rvEGxInYZU5wT06exG
         pi+dS3Sq7MG9ycWC+fVo0dLjMTxMhs7sUiJ06MlTaV5UWjLW7aC73w5Dmue5YHlHxV1M
         LuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867567; x=1763472367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12Z2StwH8KT2vPfAgGG39DszHYOdZn8zdYfVoARngiY=;
        b=m/Ha4RBldpFLVT5Mn+4V1I1LeUxuaRo4/kTypaQmF3hM+qIN3DX8pKjJ+RSSfZYF1d
         L9h3WinGUYhyJCK9Ru4DLhy/GBMXUH54DZpNX3ehPrnqQSjrSTBgDPG/reOlxA2Ss9g4
         qC1khxnHr7U1Fzl7nOt9f3VTJ7xDRE92IU6uENcQbm34Y1I5yLjKshk3gTsELJVmf84C
         gP6I1r2Ypu6zezOoXaWdliC0eusiXidEofvz+NKC2/GWYoMBcA+9rwRivbvSsmQFfYrw
         +fCWyMtMS4joV72HYcARi+RbA4Ce3BENW74aVqofZ2NBWJQ5Hrqb0HElGB/37eo+829/
         YaXw==
X-Forwarded-Encrypted: i=1; AJvYcCXdLC0AoHLLwEEqeNVtiIXD10aMyO/0A7P98U8TaRTf3qJ9UAQRAloF4pi+Hu8OzdzAvIkBAhe5gqigjvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTrgh/FqC2PWtQNDWmAjORSB0KRxOMtFhdwmWDMyQ0weABIiE
	pY6KU5TknbmNzbrh2VqTtj783HC9AvGSQkP6WZuOIwNSSk/RuW0vLCYWOQPFQexHF8M=
X-Gm-Gg: ASbGncueezMdJ3qxHILNOnj5aj8ISiYavxwEx2w7UtLA9Gv+GGu440/zlUMPFfM6gkK
	VcMN10rhYJ23j8RLIfJ9Lhn3Sdr0wlUYSoECzITCqd5RZN285Vri+5AkI8vvcBGSK+ki+zO831x
	di22xiR6WhwGYr0VjIu4dNwSSDS9raTQPDShMPG1PCk9yBkxTsOoZ7IL5HjN9/BwNOzinP0SSZ7
	7wzgBMBvFw/hhNxr34GSzL26SSAbcY/6lLbIuRBO2iEg3pue1pgsiphwsw5Ig1W/Q/JeG1QE5XA
	e3R3W92VMVHEhGD7PhxeWud92O+zBFdqTrYdMWdvuD7QHkC27Rhw2mY+eln1/rrWSE8mYMEVsrN
	lPKspTtV+D+V1WBZ0iIzqHuIgNczqt3PFH/kKzsS9DcKzTORQtffqwNM0yyettJX5Pc0Rg9gc9W
	EwadDM0Ok=
X-Google-Smtp-Source: AGHT+IEoTsAEECaqidyE5XI6NaD2gsDqElA0aGnLSePD6se0foAGjyrpk6byVcjKreL0AoAYojElvQ==
X-Received: by 2002:a05:600c:1c03:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-477732285e5mr99037825e9.1.1762867567583;
        Tue, 11 Nov 2025 05:26:07 -0800 (PST)
Received: from pathway (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774d3557csm185511615e9.8.2025.11.11.05.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:26:07 -0800 (PST)
Date: Tue, 11 Nov 2025 14:26:05 +0100
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>, paulmck@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] watchdog: add lockup_sys_info sysctl to dump sys
 info on system lockup
Message-ID: <aRM5bXr4erUqpl_e@pathway>
References: <20251106023032.25875-1-feng.tang@linux.alibaba.com>
 <20251106023032.25875-4-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106023032.25875-4-feng.tang@linux.alibaba.com>

On Thu 2025-11-06 10:30:32, Feng Tang wrote:
> When soft/hard lockup happens, developers may need different kinds of
> system information (call-stacks, memory info, locks, etc.) to help debugging.
> 
> Add 'lockup_sys_info' sysctl knob to take human readable string like
> "tasks,mem,timers,locks,ftrace,...", and when system lockup happens, all
> requested information will be dumped. (refer kernel/sys_info.c for more
> details).
> 
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -53,6 +54,13 @@ static int __read_mostly watchdog_hardlockup_available;
>  struct cpumask watchdog_cpumask __read_mostly;
>  unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
>  
> +/*
> + * A bitmask to control what kinds of system info to be printed when
> + * system lockup is detected, it could be task, memory, lock etc. Refer
> + * include/linux/sys_info.h for detailed bit definition.
> + */
> +static unsigned long lockup_si_mask;
> +
>  #ifdef CONFIG_HARDLOCKUP_DETECTOR
>  
>  # ifdef CONFIG_SMP
> @@ -240,6 +248,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
>  				clear_bit_unlock(0, &hard_lockup_nmi_warn);
>  		}

The code right above printed backtaces from all CPUs when
sysctl_hardlockup_all_cpu_backtrace.

> +		sys_info(lockup_si_mask);

And sys_info() could print it again when SYS_INFO_ALL_BT
bit is set. The hard lockup detector should use the same
trick as the softlockup detector in watchdog_timer_fn().

>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");
>  
> @@ -746,9 +755,11 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  	unsigned long touch_ts, period_ts, now;
>  	struct pt_regs *regs = get_irq_regs();
>  	int duration;
> -	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
> +	int softlockup_all_cpu_backtrace;
>  	unsigned long flags;
>  
> +	softlockup_all_cpu_backtrace = (lockup_si_mask & SYS_INFO_ALL_BT) ?
> +					1 : sysctl_softlockup_all_cpu_backtrace;
>  	if (!watchdog_enabled)
>  		return HRTIMER_NORESTART;
>  
> @@ -846,6 +857,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  		}
>  
>  		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
> +		sys_info(lockup_si_mask & ~SYS_INFO_ALL_BT);
>  		if (softlockup_panic)
>  			panic("softlockup: hung tasks");
>  	}
> @@ -1178,6 +1190,13 @@ static const struct ctl_table watchdog_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_watchdog_cpumask,
>  	},
> +	{
> +		.procname	= "lockup_sys_info",
> +		.data		= &lockup_si_mask,
> +		.maxlen         = sizeof(lockup_si_mask),
> +		.mode		= 0644,
> +		.proc_handler	= sysctl_sys_info_handler,
> +	},

There already exists:

	+ hardlockup_all_cpu_backtrace
	+ hardlockup_panic
	+ softlockup_all_cpu_backtrace
	+ softlockup_panic

IMHO, it would make sense to introduce separate:

	+ hardlockup_sys_info
	+ softlockup_sys_info


Best Regards,
Petr

