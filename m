Return-Path: <linux-kernel+bounces-839146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B9CBB0E98
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FF519C0903
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C5306B1C;
	Wed,  1 Oct 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eg8yIOYW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TzFs0ci"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077926E71F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330606; cv=none; b=RlmXBOO2nVdvicoFMpRZIDSG+F4c5v7KIe1yHmr+XK5R1XVnV+WN9ZFb18q33iEwLCUmpOKc4P3FuJHL/KrCfCCPdvigOTpYs48o21MRNX1HOAxlP8au7tueYHjQH1G3AASyCf/6e9CLUI/TXSD3Kq0Zuc0Swk+/asai6GGy4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330606; c=relaxed/simple;
	bh=DSUc9pfoQ+Y16E5od2msQ42hBfl43pFOqLqPE5guTLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzsDxw16pFMWR8kEJJBxp/+ZRGIDFegLeoKtcuIF2c44VEA4J7DyFyE2EVry9b03GIlv4NQICDrMHQLDTQ4rvhBEtMk08px3Q2VEY9b8fX9+ZoXTFbMS4dUQp+f6F5vEeBqOcvtjc45rMSNrEaiqp+QnG7UgYFQI9jAhv/erpNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eg8yIOYW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TzFs0ci; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759330602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k86pFraRxRk/kzNe91Jwqta9P8GQT0RrkwicCsr3eUY=;
	b=eg8yIOYWKZNzT94N6xkS8Y+Zxo9EZunWrk6gYJO0wlB0n1F1mVO94GwVWbCoOC+tCEg+12
	ODfSLnsh9iLH8EK2Qqe+eACgLtK6HiECzppcIM1nuHw/f/ARCavhA1ZjvjOCEXGZHD2Fo0
	uU0/gjTXe8NGjhhOccQQqFruOHV2KQqGikLUF+vYHp9OmLWCA3rKa3xNOhKwK/yz6p/MHK
	VUMVXEiXF5H+/RaXjozHDSGk5gGNOjYG04rIquVDDZV0GzRKIKHjowFK3f/q4+J+ma0+66
	QwpteoyDwrnNqyWpzhqVUDAyVhgXcfwhL37IuHHESAXD+7Eds8ewSKrcUvtm2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759330602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k86pFraRxRk/kzNe91Jwqta9P8GQT0RrkwicCsr3eUY=;
	b=1TzFs0ci1RxD5UfBHpHSCYCm8oF4zFcHZ2k4Bs/L4C4Z1/wYl9wKgwKnjm0u7phqQMAWiU
	52TXXSlM68WZwrCw==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v5 2/5] printk: nbcon: Introduce KDB helpers
In-Reply-To: <20250930-nbcon-kgdboc-v5-2-8125893cfb4f@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
 <20250930-nbcon-kgdboc-v5-2-8125893cfb4f@suse.com>
Date: Wed, 01 Oct 2025 17:02:41 +0206
Message-ID: <84h5wihdqu.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-30, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 558ef31779760340ce42608294d91d5401239f1d..c23abed5933527cb7c6bcc42057fadbb44a43446 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1855,3 +1855,69 @@ void nbcon_device_release(struct console *con)
>  	console_srcu_read_unlock(cookie);
>  }
>  EXPORT_SYMBOL_GPL(nbcon_device_release);
> +
> +/**
> + * nbcon_kdb_try_acquire - Try to acquire nbcon console, enter unsafe
> + *				section, and initialized nbcon write context

                               initialize ---^^^^^^^^^^^

And technically it is not initializing the write context, just the
console ownership context. I'm not sure it is really necessary to
mention that.

> + * @con:	The nbcon console to acquire
> + * @wctxt:	The nbcon write context to be used on success
> + *
> + * Context:	Under console_srcu_read_lock() for emiting a single kdb message

                                       emitting ---^^^^^^^

"./scripts/checkpatch.pl --codespell" is your friend. ;-)

> + *		using the given con->write_atomic() callback. Can be called
> + *		only when the console is usable at the moment.
> + *
> + * Return:	True if the console was acquired. False otherwise.
> + *
> + * kdb emits messages on consoles registered for printk() without
> + * storing them into the ring buffer. It has to acquire the console
> + * ownerhip so that it could call con->write_atomic() callback a safe way.
> + *
> + * This function acquires the nbcon console using priority NBCON_PRIO_EMERGENCY
> + * and marks it unsafe for handover/takeover.
> + */
> +bool nbcon_kdb_try_acquire(struct console *con,
> +			   struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	memset(ctxt, 0, sizeof(*ctxt));
> +	ctxt->console = con;
> +	ctxt->prio    = NBCON_PRIO_EMERGENCY;
> +
> +	if (!nbcon_context_try_acquire(ctxt, false))
> +		return false;
> +
> +	if (!nbcon_context_enter_unsafe(ctxt))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * nbcon_kdb_release - Exit unsafe section and release the nbcon console
> + *
> + * @wctxt:	The nbcon write context initialized by a successful
> + *		nbcon_kdb_try_acquire()
> + *
> + * Context:	Under console_srcu_read_lock() for emiting a single kdb message

                                       emitting ---^^^^^^^

> + *		using the given con->write_atomic() callback. Can be called
> + *		only when the console is usable at the moment.

I do not think the "Context" is relevant. It must be called if
a previous call to nbcon_kdb_try_acquire() was successful.

> + */
> +void nbcon_kdb_release(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	if (!nbcon_context_exit_unsafe(ctxt))
> +		return;
> +
> +	nbcon_context_release(ctxt);
> +
> +	/*
> +	 * Flush any new printk() messages added when the console was blocked.
> +	 * Only the console used by the given write context was	blocked.
> +	 * The console was locked only when the write_atomic() callback
> +	 * was usable.
> +	 */
> +	__nbcon_atomic_flush_pending_con(ctxt->console,
> +					 prb_next_reserve_seq(prb), false);

This can all be one line. 100 characters is the official limit for code.

> +}

