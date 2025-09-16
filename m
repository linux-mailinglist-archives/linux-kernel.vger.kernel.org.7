Return-Path: <linux-kernel+bounces-818879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2FB5978E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05067AFB34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65123306D4B;
	Tue, 16 Sep 2025 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YmuWfwom"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E728305E3F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029155; cv=none; b=mekFy7dpDxm9iKudsJ8xgtQpSgZPsVjUi28iMmjBkInb7MRW37Pgx8Mw/kmQMZkJqEcAKNO4T30XHSTBaCKh3eR8ofkd8+UXHrr+KFi+6SpycUsOdMytgGvLGg9jF+tZ5MFjG19Wh6U2PWNU269/x6AApjRFpmN+EjBkloQi1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029155; c=relaxed/simple;
	bh=DlDHQFjeEx9+1WP4O9766a/e9ZQfff2tDi57haZVa+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpUhedJqFeCUhHrsjludbNhE6EfSRBDKe5Sz3WAscUSDSRg6fIWNyt7dkuBg6jszAJB7mZ0du0xLJC8SkYoWmGMKwLeqYEHDosAHG+IPiVBNJsmoUxILh83S9yW5PtrO69lN9vmHVhdPGDyNNXzeXIQE77zseh7w8or3/Tx7+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YmuWfwom; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0473327e70so299307466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758029151; x=1758633951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbBi6gPRyLCzTAlQ43yeLikrJZPJlhDq1kpkYEwbecI=;
        b=YmuWfwomkmSbAYgPKKg8BjOX9/CBJ0vzfEEgY2MYSmYx0v4TjzEkaZXtv2tOp96SA0
         3IaQybRW680H8id+ptB0GnO8zGIEc0DWBMKPHztS0O/3oQOxdChY7QEgDQLF9qH5OiLC
         KR57KdMIrV62uzKlPtlcvOQD1F7+PQ1Zrp7RrUo4EEAc3Gy8IsxrXDhGMbVUyIfvHUZE
         be3mmXiv9LwyMGEedtgqV/Whv7ObIPih8lmBb2GwqwWdDQIKhXCa6T47j1Z+WNWqeACe
         NN/3HS5n+GODRw8SwAqPIYENNR0UgqwlVavvSIgE8y0naw33jQUKUNosCxLxt6GQ+/Tc
         cHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029151; x=1758633951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbBi6gPRyLCzTAlQ43yeLikrJZPJlhDq1kpkYEwbecI=;
        b=BqlrIpT2Upt9CRgLLcnJdhW2Y8oWFpo31J+9KDHcgDtSrM2Il4IIVp2tBEr28oyatF
         NP7D0FSHu9TkfR9YEem09TSHmWMCKB/mrIcDL9ODYDkFrG1TlDyZge+zhbVLibXcMu7j
         WVksRjkSlD/EAXwLjAyabmQl5rF1NnlTpD6dc6hJLug+p+yGSf8preFJ5QmSkGXAI7C7
         lzheEyjsn4jLahqOjLgZj9APv/zdol8EeFaEaRVxkR6kyzTohgCiftg7ELuTpQEesaHy
         PpUXze3CJzL59uXaev72ceX0AwHST1VcLAONhw49TZuellArYrDyGj4Hxpdv+rFemj10
         6G6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPikFi5hht9SWiB27rhoe5PksJEXTnJTz1eNBjgQ46OP2opINISbLPkHoccyjny1ey2bSQwDGmTycC4yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy345yN5v/VEaDQOhHtiKvxFHV1aA+NlnGuzej6j5ha7iG6a2Ro
	glEcTcPHUIMbs8u4BOlnWBoTfQrZITh37RH4nTj0XplH60BQRO+D9JQuFTP9oYg+qEDWFwDX267
	n8ICBurE=
X-Gm-Gg: ASbGnctrRhHcgksLDKyDQEyPHmQWaVOAyB0GPgC5hBDo9hI13RGB9x9dxUSnSTwuN9d
	/PF5jDi2zZHXnCRHNWXRqtS/YZy//iFlpNBlYdpUal49dCdT4PkE+7qPLh5DSndcYpdBGV8Z7TA
	4Nanxs2COpfW2UP+XMVehsp2NEVx6KiOITUVKQJ9Tn8SbVJPaueryuv0uGD6xb3TziwvT3lOi1T
	0DVNy5pNT8jTvVop+Gc9MnjW8Bczv8pba7L7ssDmqSmk+m9nnkwa2RB7ycg79DlxL2y0YeSHk5E
	u298Io4CC1M41fY06r5wcDDbU8aosLjMWHEBpoQmjth3mfwA9kS8B3AiMBpHI4NjSflxK8z/Vgs
	B0rboGiXgWMbV9Ug/ehcV0FIAIrmxwZEDBpTP6PtZ
X-Google-Smtp-Source: AGHT+IGSmkPtGBQ6ifSAn9vtISg9TfIDdYXXP9toM7YZSXENQHfcPZNWcjyx+Uh+CgNEvqayaxJHuQ==
X-Received: by 2002:a17:907:1c9b:b0:b04:9acf:46cd with SMTP id a640c23a62f3a-b07c382925cmr1697197866b.42.1758029151363;
        Tue, 16 Sep 2025 06:25:51 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334ed29sm1140236866b.107.2025.09.16.06.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:25:51 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:25:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <aMllXWKbn_5INlEt@pathway.suse.cz>
References: <20250912121852.2666874-1-john.ogness@linutronix.de>
 <20250912121852.2666874-2-john.ogness@linutronix.de>
 <74htjoj66srvussqvivbhlkdkj6lkm6ox4jdv2sedb4yzccdmr@sgzbd44mivfs>
 <84348n9510.fsf@jogness.linutronix.de>
 <i6qgd5wcdl5gkwfc6cru2hnokcsawdd4yzez2i6klu54uxwx23@jl44kdpph3t3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i6qgd5wcdl5gkwfc6cru2hnokcsawdd4yzez2i6klu54uxwx23@jl44kdpph3t3>

On Mon 2025-09-15 08:46:13, Breno Leitao wrote:
> On Mon, Sep 15, 2025 at 04:20:35PM +0206, John Ogness wrote:
> > On 2025-09-15, Breno Leitao <leitao@debian.org> wrote:
> > > On Fri, Sep 12, 2025 at 02:24:52PM +0206, John Ogness wrote:
> > >> @@ -1606,6 +1610,13 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
> > >>  		if (!console_is_usable(con, flags, true))
> > >>  			continue;
> > >>  
> > >> +		/*
> > >> +		 * It is only allowed to use unsafe ->write_atomic() from
> > >> +		 * nbcon_atomic_flush_unsafe().
> > >> +		 */
> > >> +		if ((flags & CON_NBCON_ATOMIC_UNSAFE) && !allow_unsafe_takeover)
> > >> +			continue;
> > >
> > > What will happen with the "message" in this case? is it lost?
> > >
> > > Let me clarify I understand the patch. The .write_atomic callback are
> > > called in two cases:
> > >
> > > 	1) Inside IRQ/NMI and scheduling context
> > > 	2) During panics.
> > >
> > > In both cases, they go throught __nbcon_atomic_flush_pending_con(),
> > > right?
> > 
> > @allow_unsafe_takeover is only true at the very end of panic. In all
> > other cases, the ->write_atomic() callback is ignored as if it wasn't
> > implemented. That means it will rely on the deferred printing kthread to
> > handle it.
> > 
> > > Let's say that netconsole implements CON_NBCON_ATOMIC_UNSAFE. What will
> > > happen with printks() inside IRQs (when the system is NOT panicking).
> > > Are they coming through __nbcon_atomic_flush_pending() and will be
> > > skipped?
> > >
> > > Also, are these messages even deferred for later flush?
> > 
> > When the system is not panicing, CON_NBCON_ATOMIC_UNSAFE has the effect
> > of acting as if you never implemented ->write_atomic(). So yes, only
> > ->write_thread() will handle everything in a deferred context. If the
> > system never panics, your ->write_atomic() will never be called.
> 
> If there is a printk() inside an IRQ and the host is not panicking, then
> the message will be deferred to the kthread, which will print through
> ->write_thread.

Just to be sure that we are all on the same page.

Note that the above statement is true for all NBCON consoles,
including serial consoles, even with the _safe_ .write_atomic().

In fact, printk() does not distinguish IRQ or task context. The
primary distinction are the following three priorities:

  + NBCON_PRIO_NORMAL is used when the system is working properly.

    In this case, all messages are deferred to the kthread when
    the kthread is available.


  + NBCON_PRIO_EMERGENCY is currently used in some situations,
    e.g. WARN(), RCU stall, or lockdep report.

    In this case, printk() tries to emit the messages directly using
    _safe_ .write_atomic(). It must be deferred to the kthread when
    the callback is not implemented or is not safe.


  + NBCON_PRIO_PANIC is used in panic() by the panic CPU.

    Note that only panic CPU is allowed to flush messages to be on the safe
    side when other CPUs are stopped. In fact, non-panic() CPUs are
    not even allowed to add new messages by default.

    Anyway, in panic(), printk() tries to flush the messages directly
    using _safe_ .write_atomic(). They are ignored when the callback
    is not implemented.

    This patch will allow to use the _unsafe_ . write_atomic() by
    the final "can't loose anything" nbcon_atomic_flush_unsafe()
    call before the CPU enters the final infinite loop (blinking LEDs).


Note that we use the term "priority" because the context with
the higher (more critical) priority is allowed to take over
the ownership of the console even in the middle of emitting
a message.

> So, from a user/netconsole perspective, assuming the no panic
> (allow_unsafe_takeover=false) all the messages will be transmitted
> (always from a thread context), even if the printk() happens on an IRQ.
> So, no message will be lost.

True.

Best Regards,
Petr

