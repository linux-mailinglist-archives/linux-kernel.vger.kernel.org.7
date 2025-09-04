Return-Path: <linux-kernel+bounces-799702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69429B42F56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCA67AE923
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC06C192D97;
	Thu,  4 Sep 2025 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JqRFHCyo"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E92566
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951586; cv=none; b=KGYQQjktn6UeYzH4nd6uzbKDnTn8jgSTuQrDVqPgwWHIFAnFI/a3HsJqlc1PoDCgLneTM43RXiMsVA0cIcGYw30EZohUdToev2302LluI3CsyF/FPbGUunczLi6j9GrOflIdoWddbTmPecA5NUMCd3XYDaDOVuvtjBnNgni/yuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951586; c=relaxed/simple;
	bh=UEDEpNnAqWuPiSi/QeUGlFhW28mRKF7U9+7PoWjKfmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=git4+1lBKs/kRvzMEKlqxRoy57nOjZ34EKMn4fC49DQDn26WTAZIP3U2IIYqeaRRen3MBYLsDDshxlxMt6VuT8Vd2WuCJENvhDA2exGnQnoNlopa+IH+bK88ZZre9KpRYa4/E+ATx0oQmoixXki0bdHpLLBU9V88vsZSAvlS04w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JqRFHCyo; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756951576; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=ugzH9a4DiScFUhtZ1qL5WwXK1FJyXWgMVInMIHFZwXw=;
	b=JqRFHCyo4BO997hMIQxZjvHufgzW7N6A0G7/z979F+1HBnMP0xteihs6eHrj4KjeafNzOtgmOdf9wr8fVwf4wL003vgHz7ymsSjJwIM0GFn8dLWYNwv2HwEm8ETm1TzXnHkFLEoQKVTg+sdRZ0OIWUT4jQM4LhZ2UPPX6MCCQ+E=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WnDeS3C_1756951574 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 10:06:15 +0800
Date: Thu, 4 Sep 2025 10:06:13 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] panic: Remove redundant panic-cpu backtrace
Message-ID: <aLj0FYAAzT6FwEgG@U-2FWC9VHC-2323.local>
References: <20250903100418.410026-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903100418.410026-1-pmladek@suse.com>

On Wed, Sep 03, 2025 at 12:04:18PM +0200, Petr Mladek wrote:
> From: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Backtraces from all CPUs are printed during panic() when
> SYS_INFO_ALL_CPU_BT is set. It shows the backtrace for
> the panic-CPU even when it has already been explicitly
> printed before.
> 
> Do not change the legacy code which prints the backtrace
> in various context, for example, as part of Oops report,
> right after panic message. It will always be visible in
> the crash dump.
> 
> Instead, remember when the backtrace was printed, and skip
> it when dumping the optional backtraces on all CPUs.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Link: https://lore.kernel.org/r/20250731030314.3818040-1-senozhatsky@chromium.org
> [pmladek@suse.com: Handle situations when the backtrace was not printed for the panic CPU.]
> Signed-off-by: Petr Mladek <pmladek@suse.com>

It worked as expected and had the similar effect as Sergey's
original patch, upon my test. Feel free to add:

Tested-by: Feng Tang <feng.tang@linux.alibaba.com>

Thanks,
Feng

> ---
> Hi,
> 
> I resend my proposal [1] as a proper patch.
> 
> Changes against v1:
> 
>   - Handle situations when the backtrace was not printed for
>     the panic CPU.
> 
> [1] https://lore.kernel.org/all/aJs7p_UjPIfb_XYd@pathway/
> 
> kernel/panic.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 72fcbb5a071b..e3cec9bc05ef 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -67,6 +67,7 @@ static unsigned int warn_limit __read_mostly;
>  static bool panic_console_replay;
>  
>  bool panic_triggering_all_cpu_backtrace;
> +bool panic_this_cpu_backtrace_printed;
>  
>  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>  EXPORT_SYMBOL_GPL(panic_timeout);
> @@ -328,6 +329,19 @@ void check_panic_on_warn(const char *origin)
>  		      origin, limit);
>  }
>  
> +static void panic_trigger_all_cpu_backtrace(void)
> +{
> +	/* Temporary allow non-panic CPUs to write their backtraces. */
> +	panic_triggering_all_cpu_backtrace = true;
> +
> +	if (panic_this_cpu_backtrace_printed)
> +		trigger_allbutcpu_cpu_backtrace(raw_smp_processor_id());
> +	else
> +		trigger_all_cpu_backtrace();
> +
> +	panic_triggering_all_cpu_backtrace = false;
> +}
> +
>  /*
>   * Helper that triggers the NMI backtrace (if set in panic_print)
>   * and then performs the secondary CPUs shutdown - we cannot have
> @@ -335,12 +349,8 @@ void check_panic_on_warn(const char *origin)
>   */
>  static void panic_other_cpus_shutdown(bool crash_kexec)
>  {
> -	if (panic_print & SYS_INFO_ALL_CPU_BT) {
> -		/* Temporary allow non-panic CPUs to write their backtraces. */
> -		panic_triggering_all_cpu_backtrace = true;
> -		trigger_all_cpu_backtrace();
> -		panic_triggering_all_cpu_backtrace = false;
> -	}
> +	if (panic_print & SYS_INFO_ALL_CPU_BT)
> +		panic_trigger_all_cpu_backtrace();
>  
>  	/*
>  	 * Note that smp_send_stop() is the usual SMP shutdown function,
> @@ -422,13 +432,15 @@ void vpanic(const char *fmt, va_list args)
>  		buf[len - 1] = '\0';
>  
>  	pr_emerg("Kernel panic - not syncing: %s\n", buf);
> -#ifdef CONFIG_DEBUG_BUGVERBOSE
>  	/*
>  	 * Avoid nested stack-dumping if a panic occurs during oops processing
>  	 */
> -	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
> +	if (test_taint(TAINT_DIE) || oops_in_progress > 1) {
> +		panic_this_cpu_backtrace_printed = true;
> +	} else if (IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE)) {
>  		dump_stack();
> -#endif
> +		panic_this_cpu_backtrace_printed = true;
> +	}
>  
>  	/*
>  	 * If kgdb is enabled, give it a chance to run before we stop all
> -- 
> 2.50.1

