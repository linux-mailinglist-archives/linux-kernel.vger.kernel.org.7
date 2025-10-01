Return-Path: <linux-kernel+bounces-839064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC352BB0BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CC5194391D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41AE157A72;
	Wed,  1 Oct 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iHLPnMZO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XPh/1YzU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BF24469B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329406; cv=none; b=l0mJ+BmQ74QQv3cX3gNoA5jhNwBpqUgGIIH8uBClbESw+TgxSyi6WOhS5NmKZ/nnca7fVZZyKmbRHFU1gAzmSgMu8d+CB1vBseu9uuKxggyEgZP0ORoPUZ637BKZ4iP3CvvcsDmripxfYqNSpasDr6iwGB7/WvW2Sn0Xg8i5WT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329406; c=relaxed/simple;
	bh=KA7e5iJl/zXr/zFBuJIM4g+QZjTjY7iSte42ffrVDOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nmS0ApF+3TBtxPscqBNA1tyLGsKQkY36jLay+Vf9VklVI1mC+IJdZB5GH2A8Lbl1xrCu0kU0k7b+9UiZyW+yqIBJijf6BOB2z4pG56iXLM5iUGZVzomt7kE6+SnchQ1Xz9tH63KEFzgd/0OtkmEiVECD8c6PQdiR/rYvSFIxWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iHLPnMZO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XPh/1YzU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759329395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dgg4ivoQfVgSSd7l4LOE439VKXzUXukLN9Ow8Aqpzrk=;
	b=iHLPnMZOR7BZPpag7PgxwljWBHTfZ0Q5cHbm9Vob94avMC7PC0nFM3Ql4by/sfD8oAa9+q
	Tku/vs6OhE6pLd1FDrKg8WKMATThWi86ZbswlDnEeiECHU0ny+04M13atVyLTZlqpO8M6N
	KaUdYqVeMn/0vfjZDNwsgb7jN2K0zsMH2C+7U8wm1GWXPKQzHS0ROnf1CPuRZ0E0L2VEw0
	XC8+w06PCb0pLKK5MfypAUFeo4392d3YvMvGpOBr77fTJawo6ZGAXvxDrRhbp0SWPUlQiP
	gJVgGX1olARThgAWjWHWws4D+jAjPJ4aSFpiIhhlSlwdA5vKhePWaRoUaBTddw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759329395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dgg4ivoQfVgSSd7l4LOE439VKXzUXukLN9Ow8Aqpzrk=;
	b=XPh/1YzUinJ9TwioVgOBBTnpKKTVt/lAl9IyGvo1r0Uer8HUUCRBGdYDU4NNw1OylDcqVn
	t9nWm1SHMoiRn5CA==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v5 1/5] printk: nbcon: Export console_is_usable
In-Reply-To: <20250930-nbcon-kgdboc-v5-1-8125893cfb4f@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
 <20250930-nbcon-kgdboc-v5-1-8125893cfb4f@suse.com>
Date: Wed, 01 Oct 2025 16:42:34 +0206
Message-ID: <84jz1eheod.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-30, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> The helper will be used on KDB code in the next commits.
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  include/linux/console.h  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/printk/internal.h | 44 --------------------------------------------
>  2 files changed, 44 insertions(+), 44 deletions(-)
>
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 8f10d0a85bb4536e4b0dda4e8ccbdf87978bbb4a..67af483574727c00eea1d5a1eacc994755c92607 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -605,6 +605,48 @@ extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
>  extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
>  extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
>  extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
> +
> +/*
> + * Check if the given console is currently capable and allowed to print
> + * records. Note that this function does not consider the current context,
> + * which can also play a role in deciding if @con can be used to print
> + * records.
> + */
> +static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
> +{
> +	if (!(flags & CON_ENABLED))
> +		return false;
> +
> +	if ((flags & CON_SUSPENDED))
> +		return false;
> +
> +	if (flags & CON_NBCON) {
> +		/* The write_atomic() callback is optional. */
> +		if (use_atomic && !con->write_atomic)
> +			return false;
> +
> +		/*
> +		 * For the !use_atomic case, @printk_kthreads_running is not
> +		 * checked because the write_thread() callback is also used
> +		 * via the legacy loop when the printer threads are not
> +		 * available.
> +		 */
> +	} else {
> +		if (!con->write)
> +			return false;
> +	}
> +
> +	/*
> +	 * Console drivers may assume that per-cpu resources have been
> +	 * allocated. So unless they're explicitly marked as being able to
> +	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
> +	 */
> +	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
> +		return false;
> +
> +	return true;
> +}
> +
>  #else
>  static inline void nbcon_cpu_emergency_enter(void) { }
>  static inline void nbcon_cpu_emergency_exit(void) { }
> @@ -612,6 +654,8 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
>  static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
> +static inline bool console_is_usable(struct console *con, short flags,
> +				     bool use_atomic) { return false; }
>  #endif
>  
>  extern int console_set_on_cmdline;
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index f72bbfa266d6c9bbc533661c40386aa5f0df6c8f..7238da161ff9814fe8a22e4836624e50ee5b71d3 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -112,47 +112,6 @@ bool nbcon_kthread_create(struct console *con);
>  void nbcon_kthread_stop(struct console *con);
>  void nbcon_kthreads_wake(void);
>  
> -/*
> - * Check if the given console is currently capable and allowed to print
> - * records. Note that this function does not consider the current context,
> - * which can also play a role in deciding if @con can be used to print
> - * records.
> - */
> -static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
> -{
> -	if (!(flags & CON_ENABLED))
> -		return false;
> -
> -	if ((flags & CON_SUSPENDED))
> -		return false;
> -
> -	if (flags & CON_NBCON) {
> -		/* The write_atomic() callback is optional. */
> -		if (use_atomic && !con->write_atomic)
> -			return false;
> -
> -		/*
> -		 * For the !use_atomic case, @printk_kthreads_running is not
> -		 * checked because the write_thread() callback is also used
> -		 * via the legacy loop when the printer threads are not
> -		 * available.
> -		 */
> -	} else {
> -		if (!con->write)
> -			return false;
> -	}
> -
> -	/*
> -	 * Console drivers may assume that per-cpu resources have been
> -	 * allocated. So unless they're explicitly marked as being able to
> -	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
> -	 */
> -	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
> -		return false;
> -
> -	return true;
> -}
> -
>  /**
>   * nbcon_kthread_wake - Wake up a console printing thread
>   * @con:	Console to operate on
> @@ -204,9 +163,6 @@ static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *hand
>  static inline void nbcon_kthread_wake(struct console *con) { }
>  static inline void nbcon_kthreads_wake(void) { }
>  
> -static inline bool console_is_usable(struct console *con, short flags,
> -				     bool use_atomic) { return false; }
> -
>  #endif /* CONFIG_PRINTK */
>  
>  extern bool have_boot_console;

This also needs the required includes moved over as well. smp.h is
probably more appropriate than the higher level percpu.h:

diff --git a/include/linux/console.h b/include/linux/console.h
index b34c5a0b86303..9406342b27db4 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -19,6 +19,7 @@
 #include <linux/irq_work.h>
 #include <linux/rculist.h>
 #include <linux/rcuwait.h>
+#include <linux/smp.h>
 #include <linux/types.h>
 #include <linux/vesa.h>
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 077927ed56c5f..7203b7b969c06 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -3,7 +3,6 @@
  * internal.h - printk internal definitions
  */
 #include <linux/console.h>
-#include <linux/percpu.h>
 #include <linux/types.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)

On a side note, we are missing <linux/rcuwait.h> in
kernel/printk/internal.h. It currently relies on console.h as a
proxy. But I guess that is out of scope for this series.

John

