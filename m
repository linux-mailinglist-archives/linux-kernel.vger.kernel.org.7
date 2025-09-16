Return-Path: <linux-kernel+bounces-819111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50640B59BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F28F1BC8161
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B0434A32A;
	Tue, 16 Sep 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N4A1/ucP"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDE316905
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035147; cv=none; b=sgrILn8tnTwT1VR0Y0arb1Qgs9GRweQqkbCsdWElcQtQpHyJHRgKbWsFfOZndZJ3RLoz88VnlWK9ycI8waPCmXX0YC3Idzaey7FdRdiPVb4w5SaaH0aUa3H3k1ZhGPXcU9t9YO52NY6XBvfhbT+Mp4r8ECZFayk+fhaL+Is5kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035147; c=relaxed/simple;
	bh=F7TH0mHOufsrdPht32H+JQ8FUdtP859/VvL+8zQrqm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+AsJZEXdiybRyeHJW1sAYXgspivLHs3eIcevXDZIiMeSp9j20BXwHVOTUXj7LOOCwnVPDFB2c4+Mg3sUx/+VgISvz0coIx5l39ElNL/Ipr+ZBkyUliZ7L02drzoMNx2Ze2160zxQHX++9YSkHlTbGnTtLo/IAQtrn5oTrWIVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N4A1/ucP; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso7560716a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758035143; x=1758639943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiyKSJrj1ScNh8hb9va1qCJpWH8585vbS7xritzSO9k=;
        b=N4A1/ucP9IF+q8kU4TEwbvhifovKrkYg7aLY9hMIckaOggRWL30qJPFS1RYkuwhLOh
         dFnYmr60Jnq9h1fi5h4vLLX+DTZN2xS8Pcpkhjj1la4nLpOSR73FIkXpdV+GJY7abr1W
         864xvDCCNl2qp7HYzx8rUJEck82wtJGGrMvqCAdrAB/D3l+FiqayoyorPlq9EdbfP1+y
         pePt+CilYkNnEPuiH54b3njvN4NgtIcSk8PANuwTpiBehkkAO02vV8aRQG1WXLuCWhqZ
         5GPSMhgA5MaJ2E41iwJV9RcT4yThWRU2d+axXSefm9s3o20/eo7EWO6HVgLg2wJEjCCZ
         I/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035143; x=1758639943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiyKSJrj1ScNh8hb9va1qCJpWH8585vbS7xritzSO9k=;
        b=gFiDGcz9lXUdPyJhOSArSQowccfWm8lTmnG6elYKjlztg9R/mG7YO8rckhXiCzVe4x
         ul1/QOBSHLNF7SjlLAqanu2lgeC61WMuWGWRXtirdjDvkUG2AC/4m88tjt60LhYPemq6
         HeUtSNkoAR0qpXWYEvziFdheMmgqo056M/fAd4qCBnf3XylZ8NPDQKa1uNil7ZDg+SaQ
         5b9swjZSrCv0Dq4qMBGtbUTuNuLb/OatAepSGUIZknARim4c1MTJaV6btWeVOGgYLj29
         JAg4OEzfY4/eWDIGBBHnsXVpMClZ70jwDpxwrvrBY+e0wT9+LYxwFl8cNjpOP6hew1d8
         tGng==
X-Forwarded-Encrypted: i=1; AJvYcCUb02P/yyZnr4grn43yD90vSfvZpeTMg7DPsdn+U7Z31D3q3ihandcECBS811qsf1FhVRaMVCtx6O6kQtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRRNIDM+f7NWsd0Flgk6Zd39GKEk7ed9BH+wxgErjqHqjIoTNl
	u7C4nZ/BQZTFfAvUkXdA21hNhiwgFNkUrdLZLPD5ggdePeOpkoYR/ZvH86mlRL8h74I=
X-Gm-Gg: ASbGncuicEPsGhacAksIVFXvO27NwCaSeCYIHQP9mBVgIZA7gAmpxmCmdXrgkYZhXl6
	CIZGyP2iVPy+xIZVSwlEYgT/mkLKIAJTus/RdJd6PpCaVjdzVuGIbuEpuyn7e/4H/KmEF74H/Ee
	yYsNPBCOOgt0YlEacY5ZlA6aT0XrmKR/RPYd5996GhjkCQnyCC8qNSRXpreFGgTOp0Pd6soKTO1
	e8zrbrU0pTb1O10buZXHwMkrUvVYEoa4q8pvhE/nx7V9qEVWGE3ecEHiL87Hy85jlNfTtDTn22z
	iNpg7El2vrwNb2zh4DZ6CDjinMtKQ3Vsq0XwqRfZ4t6O1ztdwnbd8TQmyq4SNQ8ap2BvEt968KO
	4huuPwl3MDU7j2RiHpaLZ9rWWeWKaGDIQ+LaF2IPX
X-Google-Smtp-Source: AGHT+IFhbwbNhkYg+ETnqXroHcXGUstXVVDk1CbBu9aIob1lDSG5kSskDYRdTkKvfdLeY1okFNAfmQ==
X-Received: by 2002:a05:6402:26d6:b0:62e:dfaa:a921 with SMTP id 4fb4d7f45d1cf-62edfaaaca7mr14991589a12.32.1758035143014;
        Tue, 16 Sep 2025 08:05:43 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f365573e7sm4626518a12.27.2025.09.16.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:05:42 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:05:41 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <aMl8xX9QCM9jslLH@pathway.suse.cz>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912121852.2666874-2-john.ogness@linutronix.de>

On Fri 2025-09-12 14:24:52, John Ogness wrote:
> There may be console drivers that have not yet figured out a way
> to implement safe atomic printing (->write_atomic() callback).
> These drivers could choose to only implement threaded printing
> (->write_thread() callback), but then it is guaranteed that _no_
> output will be printed during panic. Not even attempted.
> 
> As a result, developers may be tempted to implement unsafe
> ->write_atomic() callbacks and/or implement some sort of custom
> deferred printing trickery to try to make it work. This goes
> against the principle intention of the nbcon API as well as
> endangers other nbcon drivers that are doing things correctly
> (safely).
> 
> As a compromise, allow nbcon drivers to implement unsafe
> ->write_atomic() callbacks by providing a new console flag
> CON_NBCON_ATOMIC_UNSAFE. When specified, the ->write_atomic()
> callback for that console will *only* be called during the
> final "hope and pray" flush attempt at the end of a panic:
> nbcon_atomic_flush_unsafe().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Link: https://lore.kernel.org/lkml/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt
> ---
>  include/linux/console.h |  3 +++
>  kernel/printk/nbcon.c   | 17 ++++++++++++++---
>  kernel/printk/printk.c  | 23 ++++++++++++++++-------
>  3 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 8f10d0a85bb4..ec68ecd13f85 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -185,6 +185,8 @@ static inline void con_debug_leave(void) { }
>   *			printing callbacks must not be called.
>   * @CON_NBCON:		Console can operate outside of the legacy style console_lock
>   *			constraints.
> + * @CON_NBCON_ATOMIC_UNSAFE: The write_atomic() callback is not safe and is
> + *			therefore only used by nbcon_atomic_flush_unsafe().
>   */
>  enum cons_flags {
>  	CON_PRINTBUFFER		= BIT(0),
> @@ -196,6 +198,7 @@ enum cons_flags {
>  	CON_EXTENDED		= BIT(6),
>  	CON_SUSPENDED		= BIT(7),
>  	CON_NBCON		= BIT(8),
> +	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
>  };
>  
>  /**
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 646801813415..8c2966b85ac3 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -972,14 +972,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
>  	/*
>  	 * This function should never be called for consoles that have not
>  	 * implemented the necessary callback for writing: i.e. legacy
> -	 * consoles and, when atomic, nbcon consoles with no write_atomic().
> +	 * consoles and, when atomic, nbcon consoles with no write_atomic()
> +	 * or an unsafe write_atomic() without allowing unsafe takeovers.
>  	 * Handle it as if ownership was lost and try to continue.
>  	 *
>  	 * Note that for nbcon consoles the write_thread() callback is
>  	 * mandatory and was already checked in nbcon_alloc().
>  	 */
> -	if (WARN_ON_ONCE((use_atomic && !con->write_atomic) ||
> -			 !(console_srcu_read_flags(con) & CON_NBCON))) {
> +	if (WARN_ON_ONCE(!(console_srcu_read_flags(con) & CON_NBCON) ||
> +			 (use_atomic &&
> +			  (!con->write_atomic ||
> +			   (!ctxt->allow_unsafe_takeover &&
> +			    (console_srcu_read_flags(con) & CON_NBCON_ATOMIC_UNSAFE)))))) {

The condition seems to be correct. But it is evil. I wonder whether
it would make sense to replace this with:

	flags = console_srcu_read_flags(con);

	if (WARN_ON_ONCE(!(flags & CON_NBCON) ||
			 !console_is_usable(con, flags, use_atomic, ctxt->allow_unsafe_takeover))) {


Note that I have added the 4th parameter intentionally, see below.

>  		nbcon_context_release(ctxt);
>  		return false;
>  	}
> @@ -1606,6 +1610,13 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
>  		if (!console_is_usable(con, flags, true))
>  			continue;
>  
> +		/*
> +		 * It is only allowed to use unsafe ->write_atomic() from
> +		 * nbcon_atomic_flush_unsafe().
> +		 */
> +		if ((flags & CON_NBCON_ATOMIC_UNSAFE) && !allow_unsafe_takeover)
> +			continue;
> +
>  		if (nbcon_seq_read(con) >= stop_seq)
>  			continue;
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 0efbcdda9aab..1cfc6801eed0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3206,13 +3206,22 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  			u64 printk_seq;
>  			bool progress;
>  
> -			/*
> -			 * console_flush_all() is only responsible for nbcon
> -			 * consoles when the nbcon consoles cannot print via
> -			 * their atomic or threaded flushing.
> -			 */
> -			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
> -				continue;
> +			if (flags & CON_NBCON) {
> +				/*
> +				 * console_flush_all() is only responsible for nbcon
> +				 * consoles when the nbcon consoles cannot print via
> +				 * their atomic or threaded flushing.
> +				 */
> +				if (ft.nbcon_atomic || ft.nbcon_offload)
> +					continue;
> +
> +				/*
> +				 * It is only allowed to use unsafe ->write_atomic() from
> +				 * nbcon_atomic_flush_unsafe().
> +				 */
> +				if ((flags & CON_NBCON_ATOMIC_UNSAFE) && !do_cond_resched)
> +					continue;
> +			}
>  
>  			if (!console_is_usable(con, flags, !do_cond_resched))
>  				continue;

Adding extra check looks error prone. I think that also
__nbcon_atomic_flush_pending_con() has to be patched.
Otherwise, it might end up in an infinite loop.
It is called directly from nbcon_device_release().

Note that this patch added the check only to the other caller
__nbcon_atomic_flush_pending().

It would be more reliable when the check was integrated into
console_is_usable(). I guess that you did not do it because
it added another parameter...

I would personally prefer to add the 4th parameter.

Or maybe, we could define @allow_unsafe_takeover via a global variable,
e.g. panic_nbcon_allow_unsafe_takeover. And it might be valid
only on the panic CPU, e.g.

static inline
bool nbcon_allow_unsafe_takeover(void)
{
	return panic_on_this_cpu() && panic_nbcon_allow_unsafe_takeover;
}

It is a kind of hack. But it might be better than the 4th parameter.
And it would simplify few other APIs.

Best Regards,
Petr

