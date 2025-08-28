Return-Path: <linux-kernel+bounces-790285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD847B3A465
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4421B56162E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4369221FC4;
	Thu, 28 Aug 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tf9VEDcJ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4F224B12
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394780; cv=none; b=PML0IxJzXsNt21irmHxKqChO00lwB88jRqpyhsQ1V7g+Ve3hpM4WdjgoGcvfquU/I32X5NTjWDhz09K2Pb4kkATJ6JEjj2pfgEudZWcgjwVy6w8zchTEc7thBFn3O6sD+o4BZ95pI2DTOzBb6/Ey1aNkgG1zTGK4FfHkB1L6nFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394780; c=relaxed/simple;
	bh=1pb+w2mc6JXmXH8WnFsHZXVWTj2ucyhIzqU0igk5i3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HouTbX2RGM/81B8QoNmSGE1uNkwqRwHqXaggYgfirGkv7W5favLbliifNnrP4vkuEcpHyFG6C3lclXv3rAjY7dZsLUsdTTO8bHYH4SpwMS9sH/e50tQm9dH/QOdoSmUPO6QQWHJ/AslksLxidQAyVehMgkGAecrkwiSCez4urs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tf9VEDcJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afedbb49c26so170132066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756394775; x=1756999575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5c+soFxj1JAcKaj+Wa0WnFtoE0EOupVzeg9P7UdtkM=;
        b=Tf9VEDcJl073W3pVyFtoAMtATXMcOtsL4AMOvkofI36Mz4yzcrVl2nJEHUQ0iXRt27
         nfvqto2OAf+8nKjwYraKaaYEThHOdy07a2caI/TzWfVReMDi29oUjS2KGN39in+ZnWlf
         irFgUb5iJ008EkdRlDZpmIC+KlCa8fN26ATeYODkCUo9QaJsM/8Fe0MeUCyXznIh4D/T
         ziyU1HkEY5chEfqlYfQQzwHhzbIT49xZlHlFNS/mJmARvmrmU4xs5NQKa2kYoDGxNe6E
         jjs9KVXtB2GX/w5Xr7O0nlMLtVQAdYLyJEXt/zuPtNPLKPepcppXKYRCkQRnGuBDWDpZ
         GwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756394775; x=1756999575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5c+soFxj1JAcKaj+Wa0WnFtoE0EOupVzeg9P7UdtkM=;
        b=HyFzECLNS+WH3WMb+CHalG7raTKh3cAf4P+cbvLRun3oV+lCa6NpSXF/9Z0Pa3EWBw
         OPCLn6YCJXxFvF5F8N8yYLtF+qoBj/9WhApo/YaVYXgnkgqRUP3QADaTSQDxNSas7kQo
         TzwaIPcK5T27AkghqdN+8Th8o/GDUCzwnQ6IjHXCvyg4dJDJ7Bj4idSGFV+X/G6GuvCh
         MYbxdynMsZ/NGoL1BX7+f3WSih4R2WHkW2+PtK1srKZ5SMhat02lgq6eAkQdUeK5bzyr
         nWVVKh6CgkLvY52KTWqEO3b1gQ6gaCE/R2Yl8jFIYA9llyR9ucX6qsIcxP4AmIZKgbpr
         XnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhXIiWIfYuG5iPqbosMB88lXdsRCAQhTf0JwQM4wP+qwQfLwXElJnRaP2tTQ0iqSGJlJUBk+ijt6ZLZEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytauttDn87oB4ZTcwboHZse/kE+cO0eEJaavkrkkHFrydwTqOz
	N9k3ugKy6/Sskqtrn+g5KIkxRIzbwXE61BklWOecgP4sur8ph2fTGo506cTBwHyx1QXF4+53aGD
	Tdjf/
X-Gm-Gg: ASbGncuiVOKEOZSzhl9YjJCFxxFeRhY8RT4t8I4enRgUEV2PaGXX1NNzHi+OnIqUsdr
	gE7ortpmsaxAB47DMRV5v9DvvGAD9Gh9mtPRLb3AsokFzTa76s4sSnxJw66CEnhIGJ2FpuuJp1j
	4ibF/5m+4roDg0nlhbQMn4DxTOLvKODgw1Xs9CiW8hOHh5o2BJridYtsFGimOkBRpJh9KeYzDGy
	dGyE/5EqnYMLLS1zzUO/93CGjjahQroHgBefsWv0tWHoYJM53cfsbjLuS+DzlIdZ/CUr2+IVVkp
	iXrWiKZV9USXU3GC5TEVkfwK+RgZG5wKHDuzSF+WAyhNXA7oYUbHOidgvqhRghL11AeHRoS5wLx
	Pa+5+O7npTVHrkD+dl2eo2bXsYA==
X-Google-Smtp-Source: AGHT+IHrJdfc/hnzkWws47dv4FvLrZ7eywma5iHdwN+sbK/iexQLUf7HcDQJGJ4d3y0a7koYmFPZPA==
X-Received: by 2002:a17:906:c10d:b0:afe:c2e7:36f1 with SMTP id a640c23a62f3a-afec2e7424emr550890266b.0.1756394774829;
        Thu, 28 Aug 2025 08:26:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afeae4ca4bdsm601522666b.5.2025.08.28.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 08:26:14 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:26:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2 2/3] printk: nbcon: Introduce KDB helpers
Message-ID: <aLB1FCc-IJNxjgIy@pathway.suse.cz>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
 <20250811-nbcon-kgdboc-v2-2-c7c72bcdeaf6@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-nbcon-kgdboc-v2-2-c7c72bcdeaf6@suse.com>

On Mon 2025-08-11 10:32:46, Marcos Paulo de Souza wrote:
> These helpers will be used when calling console->write_atomic on
> KDB code in the next patch. It's basically the same implementaion
> as nbcon_device_try_acquire, but using NBCON_PORIO_EMERGENCY when
> acquiring the context.
> 
> For release, differently from nbcon_device_release, we don't need to
> flush the console, since all CPUs are stopped when KDB is active.

I thought this when we were discussion the code, especially the
comment in

static void kdb_msg_write(const char *msg, int msg_len)
{
[...]

	/*
	 * The console_srcu_read_lock() only provides safe console list
	 * traversal. The use of the ->write() callback relies on all other
	 * CPUs being stopped at the moment and console drivers being able to
	 * handle reentrance when @oops_in_progress is set.


But I see that kdb_msg_write() is called from vkdb_printf() and
there is the following synchronization:

int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
{
[...]

	/* Serialize kdb_printf if multiple cpus try to write at once.
	 * But if any cpu goes recursive in kdb, just print the output,
	 * even if it is interleaved with any other text.
	 */
	local_irq_save(flags);
	this_cpu = smp_processor_id();
	for (;;) {
		old_cpu = cmpxchg(&kdb_printf_cpu, -1, this_cpu);
		if (old_cpu == -1 || old_cpu == this_cpu)
			break;

		cpu_relax();
	}

It suggests that the code might be used when other CPUs are still
running.

And for example, kgdb_panic(buf) is called in vpanic() before
the other CPUs are stopped.


My opinion:

It might make sense to flush the console after all. But probably
only the particular console, see below.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1855,3 +1855,29 @@ void nbcon_device_release(struct console *con)
>  	console_srcu_read_unlock(cookie);
>  }
>  EXPORT_SYMBOL_GPL(nbcon_device_release);
> +

The function must be called only in the very specific kdb
context, so it would deserve a comment. Inspired by
nbcon_device_try_acquire():

/**
 * nbcon_kdb_try_acquire - Try to acquire nbcon console, enter unsafe
 *				section, and initialized nbcon write context
 * @con:	The nbcon console to acquire
 * @wctxt:	The nbcon write context to be used on success
 *
 * Context:	Under console_srcu_read_lock() for emiting a single kdb message
 *		using the given con->write_atomic() callback. Can be called
 *		only when the console is usable at the moment.
 *
 * Return:	True if the console was acquired. False otherwise.
 *
 * kdb emits messages on consoles registered for printk() without
 * storing them into the ring buffer. It has to acquire the console
 * ownerhip so that is could call con->write_atomic() callback a safe way.
 *
 * This function acquires the nbcon console using priority NBCON_PRIO_EMERGENCY
 * and marks it unsafe for handover/takeover.
 */

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

It deserves a comment as well, see below:

> +void nbcon_kdb_release(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	nbcon_context_exit_unsafe(ctxt);
> +	nbcon_context_release(ctxt);

I agree with John that the _release() should be called only when
exit_unsafe() succeeded.

Also it might make sense to flush the console. I would do something
like:


/**
 * nbcon_kdb_release - Exit unsafe section and release the nbcon console
 *
 * @wctxt:	The nbcon write context intialized by a succesful
 *	nbcon_kdb_try_acquire()
 *
 * Context:	Under console_srcu_read_lock() for emiting a single kdb message
 *		using the given con->write_atomic() callback. Can be called
 *		only when the console is usable at the moment.
 */
void nbcon_kdb_release(struct nbcon_write_context *wctxt)
{
	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);

	nbcon_context_exit_unsafe(ctxt);
	nbcon_context_release(ctxt);

	if (!nbcon_context_exit_unsafe(ctxt))
		return;

	nbcon_context_release(ctxt);

	/*
	 * Flush any new printk() messages added when the console was blocked.
	 * Only the console used by the given write context was	blocked.
	 * The console was locked only when the write_atomic() callback
	 * was usable.
	 */
	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb), false);


Best Regards,
Petr

