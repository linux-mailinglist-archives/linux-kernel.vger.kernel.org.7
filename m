Return-Path: <linux-kernel+bounces-729188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990D3B032EB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 22:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004571686FD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F50230BE3;
	Sun, 13 Jul 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cydsYNcj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3rhC55JJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508B7D3F4
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752438981; cv=none; b=AtmUe13RxxQ0g1B+nB/IMvx5MdVsIIqYKvKJmKD1omVZZMiLJRNXnXdYO74QtL2nznt/XyA7Xc9kNP8UdEvF0s8WjtB8Rt+KwATbAFryHrXJ6tKtbn7jjiFaLYJXTw/XqyRWhUEQl4epjEJh57Hdr6zhqqt40MYAwv7wbrmkNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752438981; c=relaxed/simple;
	bh=mj7ZxhKN5VCDPgmr7vu3VV6iEMAcdv718V80l6iVPLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uRNcxDj1oTe2/6ZR/E58T4JnGn6KfyX/1G/Nrf9ZE0P5M7cWcEY+UbRujPb9efSjisjnoFKbeDSXFqBa/4rtxXgJIQdJ7LB1EOisKnytlTUjte61itg5P1f8jUeYZE6mq/6L4tHWJIBIt4DfQ9xOS18+NkJIbtSlj/dDve+ZkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cydsYNcj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3rhC55JJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752438978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UJ5zhQJGb7kOJ6QCoOgQhr3q1mLVIu5/uEbNE7bwy98=;
	b=cydsYNcjtaf4IhedRED+BXjoK/j006BHzhW6EiEYNV6BVWEikEcF6C+hykZqEXn7hZSXkP
	WB1GtU2TebQ4qZ+7Fj1YcOvVWoUxj6SZJzxjCa4IFXR+USpf6yQwXTPY3y2+QTYvX38nA4
	uH3QfY6e9s1I88BKvl5FDpRDr83Clw8sKWMebF46r5p5p1kwMez7SkJhtAMDaD92vzj1bK
	mk4OWy/TdgPrz5xtxVC+TcLZVjEuXo1u09+aOHoVv6UwTBFsO0Pv5xSvymvsm8d5UdbSmK
	P/SEceqxklIbstdAp8o6PRMGZbtlT3pr7zoHvNptswLHvfWzQNW6tuB/7SmOhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752438978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UJ5zhQJGb7kOJ6QCoOgQhr3q1mLVIu5/uEbNE7bwy98=;
	b=3rhC55JJ1QdMczS65PGWJCqo94ktb0DXxK70kliM9GPi6sKoMmv3aw3F+ZTE2zKRlVRskX
	Jx50btrlTMXTmgAg==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 2/2] kdb: Adapt kdb_msg_write to work with NBCON consoles
In-Reply-To: <20250713-nbcon-kgdboc-v1-2-51eccd9247a8@suse.com>
References: <20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com>
 <20250713-nbcon-kgdboc-v1-2-51eccd9247a8@suse.com>
Date: Sun, 13 Jul 2025 22:42:17 +0206
Message-ID: <84ldorx1z2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-07-13, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..3b7365c11d06b01d487767fd89f1081da10dd2ed 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -558,6 +558,25 @@ static int kdb_search_string(char *searched, char *searchfor)
>  	return 0;
>  }
>  
> +static struct nbcon_context *nbcon_acquire_ctxt(struct console *con,
> +					struct nbcon_write_context *wctxt,
> +					char *msg, int msg_len)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	ctxt->console		    = con;
> +	ctxt->spinwait_max_us	    = 0;
> +	ctxt->prio		    = NBCON_PRIO_EMERGENCY;
> +	ctxt->allow_unsafe_takeover = false;
> +	wctxt->outbuf		    = msg;
> +	wctxt->len		    = msg_len;
> +
> +	if (!nbcon_context_try_acquire(ctxt))
> +		return NULL;
> +
> +	return ctxt;

This function is grabbing a reference to a private member and returning
it, thus exposing internals. Can we instead create a proper API in
kernel/printk/nbcon.c for kdb?

For example, take a look at:

nbcon_device_try_acquire() and nbcon_device_release()

We could have something similar for kdb, such as:

bool *nbcon_kdb_try_acquire(struct nbcon_write_context *wctxt,
			    struct console *con, char *msg, int msg_len);

void nbcon_kdb_release(struct nbcon_write_context *wctxt);

> +}
> +
>  static void kdb_msg_write(const char *msg, int msg_len)
>  {
>  	struct console *c;
> @@ -589,12 +608,26 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	 */
>  	cookie = console_srcu_read_lock();
>  	for_each_console_srcu(c) {
> -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> +		struct nbcon_write_context wctxt = { };
> +		struct nbcon_context *ctxt;

With the above suggestion we do not need @ctxt.

> +		short flags = console_srcu_read_flags(c);
> +
> +		if (!console_is_usable(c, flags, true))
>  			continue;
>  		if (c == dbg_io_ops->cons)
>  			continue;
> -		if (!c->write)
> -			continue;
> +
> +		/*
> +		 * Do not continue if the console is NBCON and the context
> +		 * can't be acquired.
> +		 */
> +		if (flags & CON_NBCON) {
> +			ctxt = nbcon_acquire_ctxt(c, &wctxt, (char *)msg,
> +						  msg_len);
> +			if (!ctxt)
> +				continue;

And this becomes:

			if (!nbcon_kdb_try_acquire(&wctxt, c, (char *)msg, msg_len))
				continue;
> +		}
> +
>  		/*
>  		 * Set oops_in_progress to encourage the console drivers to
>  		 * disregard their internal spin locks: in the current calling
> @@ -605,7 +638,12 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  		 * for this calling context.
>  		 */
>  		++oops_in_progress;
> -		c->write(c, msg, msg_len);
> +		if (flags & CON_NBCON) {
> +			c->write_atomic(c, &wctxt);
> +			nbcon_context_release(ctxt);

And this becomes:

			nbcon_kdb_release(&wctxt);

> +		} else {
> +			c->write(c, msg, msg_len);
> +		}
>  		--oops_in_progress;
>  		touch_nmi_watchdog();
>  	}

John Ogness

