Return-Path: <linux-kernel+bounces-786810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3EB36B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF339847DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A00E35AAC0;
	Tue, 26 Aug 2025 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="07Ddwaqk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugVsECJR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30732352FD0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218651; cv=none; b=cE6YnphjzTDTshDaDY6wJHFKVvUwQSn2MDe/aVpnZoAUNJRyenvMyz2wl6UbwXvi8SazSI9DZ2z4XL0mCcRtsoeLBNZsUXOPvA1yzEN7RjF9GzqhG8zh6Pmj7141osqarWH7ukHKXwVmPnmOmbpebhEqgaRL23fkPOV8lihG6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218651; c=relaxed/simple;
	bh=9FM7dLd2FcNVgmKKswqQCU9MBMyuSM04FCSXZz8OgC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MlYksuWj3vrxUcZOkd3jiwsbKd0PvPLlovNloH4uyJsJ1f0qHouUrNcPy2x7ycqeIwVrG6tXP3wIp5bhX7D9zVtG85FkhjMDfudL0cccduBDgIRJLjdMMP1d/J6zDvC2709GaVxwJHzzHLfiefTWkJYX0MoqyAxxWMgsbOKMdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=07Ddwaqk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugVsECJR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756218648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4kY00LpSA1e+7KmQQ5LdYtL9aisEt5i8Y//Pi9j1m38=;
	b=07DdwaqkdqIkCv8/fRjdp9cP0XJ2V+HwR8FueWVYW7BnR+a1tTKT8fopw6BWkiyadgMbF0
	7kXaRjaNUBj8BmjkuLVzhOo16LdKJ9ypDUxslANHJpKbS4K/ob/BX90uezuAsWWvUXZkwW
	0TdFxOhE/LE6d0zMq9U0k5p01WhX2GJleZBIFA/InYKM/G8fEgu7fiTi9g5gvS9LcbHZ7V
	8kmrbPkkpAeU1EcUW1Zrxx/oKAsIE1PAXxps9Tnh/Yz9QiTAHg7blZMkJCZo1QUmJTkC8H
	4Er1wd1Lu52nSe/19t3yhvi2RxVo3GcgTYge9jRleZNFgFzfxfLlnj45gaAAmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756218648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4kY00LpSA1e+7KmQQ5LdYtL9aisEt5i8Y//Pi9j1m38=;
	b=ugVsECJRPzPrArp281QkG6OSB0TzUWsGy2y0Hc0UwLy8h+/Po9bJgNTGIY5o7ErW9RR6K5
	IJqYuzjpVnep7TBA==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v2 2/3] printk: nbcon: Introduce KDB helpers
In-Reply-To: <20250811-nbcon-kgdboc-v2-2-c7c72bcdeaf6@suse.com>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
 <20250811-nbcon-kgdboc-v2-2-c7c72bcdeaf6@suse.com>
Date: Tue, 26 Aug 2025 16:36:47 +0206
Message-ID: <84jz2qkve0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-08-11, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> These helpers will be used when calling console->write_atomic on
> KDB code in the next patch. It's basically the same implementaion
> as nbcon_device_try_acquire, but using NBCON_PORIO_EMERGENCY when
> acquiring the context.
>
> For release, differently from nbcon_device_release, we don't need to
> flush the console, since all CPUs are stopped when KDB is active.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  include/linux/console.h |  6 ++++++
>  kernel/printk/nbcon.c   | 26 ++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 67af483574727c00eea1d5a1eacc994755c92607..b34c5a0b86303e2fb4583fa467d8be43761cf756 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -605,6 +605,9 @@ extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
>  extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
>  extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
>  extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
> +extern bool nbcon_kdb_try_acquire(struct console *con,
> +				  struct nbcon_write_context *wctxt);
> +extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
>  
>  /*
>   * Check if the given console is currently capable and allowed to print
> @@ -654,6 +657,9 @@ static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return
>  static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
>  static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
> +static inline bool nbcon_kdb_try_acquire(struct console *con,
> +					 struct nbcon_write_context *wctxt) { return false; }
> +static inline void nbcon_kdb_release(struct console *con) { }
>  static inline bool console_is_usable(struct console *con, short flags,
>  				     bool use_atomic) { return false; }
>  #endif
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 646801813415f0abe40cabf2f28ca9e30664f028..79d8c7437806119ad9787ddc48382dc2c86c23c3 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1855,3 +1855,29 @@ void nbcon_device_release(struct console *con)
>  	console_srcu_read_unlock(cookie);
>  }
>  EXPORT_SYMBOL_GPL(nbcon_device_release);
> +
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
> +void nbcon_kdb_release(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	nbcon_context_exit_unsafe(ctxt);
> +	nbcon_context_release(ctxt);

If nbcon_context_exit_unsafe() fails, the current task is no longer the
owner and thus a release is not needed. I would prefer:

	if (nbcon_context_exit_unsafe(ctxt))
		nbcon_context_release(ctxt);

or

	if (!nbcon_context_exit_unsafe(ctxt))
		return;

	nbcon_context_release(ctxt);

You can find this same pattern in nbcon_device_release().

John

