Return-Path: <linux-kernel+bounces-841316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE24FBB7042
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFDA19E0F22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A762F0C51;
	Fri,  3 Oct 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AwT+QEwc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792A13C3F2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498169; cv=none; b=EWn+Vt9tQYhs6EZjLFh+SOnneWCSTzxp2f5VyxqA7e8fXFgbfBYv8Rk+K+bstKEhK+wqrc9Kl4GT22BUTAUHzWx5PCsTVjVn0PWnSOsx/L1yVABTPWeX3j8HpwvLQ9muIh8noPVPNV6b0qqx+jOsRdVbMXvv8WvMu3P5Rx9Mhf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498169; c=relaxed/simple;
	bh=hO+lF+z0wCAdW8DIfWkXfHTpkaC4gKcnrjNiOXqtJEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pehPMX9X7u2pyDnybh8fbu7pbrtZiKiMJKKCho1fEihqPCWlnY31GoCFEBspxppbFDt5vAl+UW8LVdf7oddr9MFA4jcP4l3otiaoRJkN/x/clhXf16YmIjqFIC4JH3k1EPYQ42w1t/OIisBqtQYZC+wrmuBsCtHJz/A8gzck5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AwT+QEwc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e542196c7so19364195e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759498165; x=1760102965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUOsU7riD2UPyFDZRuUQGcd9dAxze5Lk41FAacCHgs8=;
        b=AwT+QEwcbyWyre/5JCZxqiqE/9WwXF8HbwLu4IKnXy7yo3dM7GQImYobTsdNWJ2hFj
         EuMDHwhef+LYevyNQwvuCKpdDe6iWysyVfFfWWH7PTStNJNygtA2ei+btOHZML8o8hz5
         nd9Mx0hESb13x7aS8LQKMjQ0wkztZ7+FmJmN279QCq48918kCogD1cUMmqsuv4REkKJJ
         YHTWyymHLMzfELNqrr1+ePmcRBCbIvu7ZKy/7I8lMEbBzRC+VXY6YbQFv7eUc9zt4fMI
         w/DDyvTlPhZZIalx6eSK+qld6zVYuEtwAiHevHT5w7wbg5w8KX1U4RTj6b/PLztk4BSo
         M8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498165; x=1760102965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUOsU7riD2UPyFDZRuUQGcd9dAxze5Lk41FAacCHgs8=;
        b=gLIOZ84G7ZXLsr7lxppmHy+fpfxVKRF2ycSI1weLovsVneebpCNPUHXSF2j/o6Tad3
         4DQvBVDElHN/SMY6MIIK5ioMwJU7D1ZxWdtItHa0oDBsRAi/V2iuv4zTkBcMqM7PXLOV
         n8ilkga5JWqY5xy+4a0WUqwaiTTMhQPkgc/dL1JUCUAGSIefl7LjeuV1CO5v8toDeM9t
         2VgLNb1pLtaWTENP4J28wC8dKZ8lXZbMY73Lf/bglZTmPoXbZLQAzJ1e29XikYFvO0XO
         +fHb0dBzaBlZj+7jkz+5sVPvgcHDasL5P1PrMNHetQGqEcfUS0X1Zdl/wACwzraX9i79
         VLAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvrqKTNxhYcOCduiHsyu/e9yIHGPpQIsDXiHnHNdaomAMfzQwDRSsWhnXUH1IlARBT4pob5M+ewUHJ7vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgu+JrIgTcShj/waJgyDZDa25rZCkxmKP8ZeZIV+41sDdKg02
	OsHtA5f/LdmPhZBrdamU0MxRJH/B+LmBOJM4GCfUjJyJgYP7hgGHjRzNxDvUKQ2chIw=
X-Gm-Gg: ASbGncse3Ir7Ab4zMPNv/B5QpvkRRHHZA/EiMKS7Qw/p0O2M8Hh2Kc2iCRtAoNV10Gl
	vUOaNrBtGgEIatQntv1RephR91hs8zON1pSTI3eg+q40WDeU0b47MyrgQqrUHHInrt/ISjY40oS
	N3FYOC4Io0q6eGY6mO2PN78zJXp2EFZmIs/eL/gDu7YxpvKYGNtUY/gh0DYecJEtg/ALD9ioP3y
	w9jW5NOfnsQ8n3fJP9/X+ozJH5GhO1ATLTg5Lrf7+xP5W72luDKoTP+IFHH782TVoXdBv+ZCs7l
	nPrVftqrT3qvVtHvaVgMtvQvlLrflLLFLEs+Yc9ltudWDoiKhXyPVXbajtjOIXftauc4Bd/03ny
	MHomlTXYNuLuGKlEzwRq7gjvFz73BYSOQyjEsdqjn6sn7Btwoiw==
X-Google-Smtp-Source: AGHT+IECOBikHXlXR8XG9U9c/DHlFBNlbBE0/Z//Bld/sE6zozDPhWyzN6Hz+1ZhHqcIvnwW1yBEcA==
X-Received: by 2002:a05:600c:254:b0:45d:d86b:b386 with SMTP id 5b1f17b1804b1-46e68c006c2mr44158975e9.14.1759498165157;
        Fri, 03 Oct 2025 06:29:25 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723624b3sm30932895e9.17.2025.10.03.06.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:29:24 -0700 (PDT)
Date: Fri, 3 Oct 2025 15:29:22 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] printk: Introduce console_flush_one_record
Message-ID: <aN_PsplsDMpiSHTQ@pathway.suse.cz>
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-1-cff9f063071a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927-printk_legacy_thread_console_lock-v2-1-cff9f063071a@thegoodpenguin.co.uk>

On Sat 2025-09-27 23:05:35, Andrew Murray wrote:
> console_flush_all prints all remaining records to all usable consoles
> whilst its caller holds console_lock. This can result in large waiting
> times for those waiting for console_lock especially where there is a
> large volume of records or where the console is slow (e.g. serial).
> 
> Let's extract the parts of this function which print a single record
> into a new function named console_flush_one_record. This can later
> be used for functions that will release and reacquire console_lock
> between records.
> 
> This commit should not change existing functionality.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
> ---
>  kernel/printk/printk.c | 159 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 100 insertions(+), 59 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 0efbcdda9aaba9d8d877df5e4f1db002d3a596bc..060d4919de320fe21fd7aca73ba497e27c4ff334 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3161,6 +3161,100 @@ static inline void printk_kthreads_check_locked(void) { }
>  
>  #endif /* CONFIG_PRINTK */
>  
> +
> +/*
> + * Print out one record for each console.
> + *
> + * @do_cond_resched is set by the caller. It can be true only in schedulable
> + * context.
> + *
> + * @next_seq is set to the sequence number after the last available record.
> + * The value is valid only when this function returns true.

This actually is not true. This function tries to flush one record on all usable
consoles. And @next_seq is set to the highest already emitted sequence
number. But some consoles might be (far) behind.

A more precise description would be something like:

 * @next_seq is set to the sequence number after the last available record.
 * The value is valid only when there is at least one usable console
 * (@any_usable == true) and all usable consoles were flushed
 * (function returns false && @handover == false &&
 * other_cpu_in_panic() == false)

Huh, it is complicated. This is why I suggested to change the semantic
of @any_usable in the 2nd patch. It would be cleared when the emit
was interrupted (handover or other_cpu_in_panic()).

Best Regards,
Petr

> + * @handover will be set to true if a printk waiter has taken over the
> + * console_lock, in which case the caller is no longer holding the
> + * console_lock. Otherwise it is set to false.
> + *
> + * @any_usable will be set to true if there are any usable consoles.
> + *
> + * Returns true when there was at least one usable console and a record was
> + * flushed. A returned false indicates there were no records to flush for any
> + * of the consoles. It may also indicate that there were no usable consoles,
> + * the context has been lost or there is a panic suitation. Regardless the
> + * reason, the caller should assume it is not useful to immediately try again.
> + *
> + * Requires the console_lock.
> + */
> +static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *handover,
> +				     bool *any_usable)
> +{
> +	struct console_flush_type ft;
> +	struct console *con;
> +	bool any_progress;
> +	int cookie;
> +
> +	any_progress = false;
> +
> +	printk_get_console_flush_type(&ft);
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
> +		short flags = console_srcu_read_flags(con);
> +		u64 printk_seq;
> +		bool progress;
> +
> +		/*
> +		 * console_flush_one_record() is only responsible for
> +		 * nbcon consoles when the nbcon consoles cannot print via
> +		 * their atomic or threaded flushing.
> +		 */
> +		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
> +			continue;
> +
> +		if (!console_is_usable(con, flags, !do_cond_resched))
> +			continue;
> +		*any_usable = true;
> +
> +		if (flags & CON_NBCON) {
> +			progress = nbcon_legacy_emit_next_record(con, handover, cookie,
> +								 !do_cond_resched);
> +			printk_seq = nbcon_seq_read(con);
> +		} else {
> +			progress = console_emit_next_record(con, handover, cookie);
> +			printk_seq = con->seq;
> +		}
> +
> +		/*
> +		 * If a handover has occurred, the SRCU read lock
> +		 * is already released.
> +		 */
> +		if (*handover)
> +			return false;
> +
> +		/* Track the next of the highest seq flushed. */
> +		if (printk_seq > *next_seq)
> +			*next_seq = printk_seq;
> +
> +		if (!progress)
> +			continue;
> +		any_progress = true;
> +
> +		/* Allow panic_cpu to take over the consoles safely. */
> +		if (other_cpu_in_panic())
> +			goto abandon;
> +
> +		if (do_cond_resched)
> +			cond_resched();
> +	}
> +	console_srcu_read_unlock(cookie);
> +
> +	return any_progress;
> +
> +abandon:
> +	console_srcu_read_unlock(cookie);
> +	return false;
> +}
> +
>  /*
>   * Print out all remaining records to all consoles.
>   *
> @@ -3186,77 +3280,24 @@ static inline void printk_kthreads_check_locked(void) { }
>   */
>  static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
>  {
> -	struct console_flush_type ft;
>  	bool any_usable = false;
> -	struct console *con;
>  	bool any_progress;
> -	int cookie;
>  
>  	*next_seq = 0;
>  	*handover = false;
>  
>  	do {
> -		any_progress = false;
> -
> -		printk_get_console_flush_type(&ft);
> -
> -		cookie = console_srcu_read_lock();
> -		for_each_console_srcu(con) {
> -			short flags = console_srcu_read_flags(con);
> -			u64 printk_seq;
> -			bool progress;
> +		any_progress = console_flush_one_record(do_cond_resched, next_seq, handover,
> +							&any_usable);
>  
> -			/*
> -			 * console_flush_all() is only responsible for nbcon
> -			 * consoles when the nbcon consoles cannot print via
> -			 * their atomic or threaded flushing.
> -			 */
> -			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
> -				continue;
> -
> -			if (!console_is_usable(con, flags, !do_cond_resched))
> -				continue;
> -			any_usable = true;
> -
> -			if (flags & CON_NBCON) {
> -				progress = nbcon_legacy_emit_next_record(con, handover, cookie,
> -									 !do_cond_resched);
> -				printk_seq = nbcon_seq_read(con);
> -			} else {
> -				progress = console_emit_next_record(con, handover, cookie);
> -				printk_seq = con->seq;
> -			}
> -
> -			/*
> -			 * If a handover has occurred, the SRCU read lock
> -			 * is already released.
> -			 */
> -			if (*handover)
> -				return false;
> -
> -			/* Track the next of the highest seq flushed. */
> -			if (printk_seq > *next_seq)
> -				*next_seq = printk_seq;
> -
> -			if (!progress)
> -				continue;
> -			any_progress = true;
> -
> -			/* Allow panic_cpu to take over the consoles safely. */
> -			if (other_cpu_in_panic())
> -				goto abandon;
> +		if (*handover)
> +			return false;
>  
> -			if (do_cond_resched)
> -				cond_resched();
> -		}
> -		console_srcu_read_unlock(cookie);
> +		if (other_cpu_in_panic())
> +			return false;
>  	} while (any_progress);
>  
>  	return any_usable;
> -
> -abandon:
> -	console_srcu_read_unlock(cookie);
> -	return false;
>  }
>  
>  static void __console_flush_and_unlock(void)
> 
> -- 
> 2.34.1

