Return-Path: <linux-kernel+bounces-762919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4820AB20C27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D4E7A4B61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92627602D;
	Mon, 11 Aug 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZFskvmVt"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CA253B64
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923110; cv=none; b=ZEPZ9auxQKmDgCiRoCE06E12Rak82IqsH+r+U18jXW69xgW0mSScOQ/oHk7g0wsjoo66TO2YzhXahCsmlPW5AjcMU5SyJ55gT2TfBecuMt8MP/CB8U0Mb+8xOO3wIKC8IUnVHO/mGXr/CZCl4f4VAlxODQZTkevbPtwWmen8aG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923110; c=relaxed/simple;
	bh=Cce+LPGmDUuM8rZQ9XRU03fgLgtnSDwzOLS9njFMY3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbQKwO5fd9XwjtUOMNeMdSygB9PWiPWmwJhcJmo28QYZAtpIpY7FLKa9gYka8guK0QlzjkoGKQsVIi1rsQspZPZULGlC4UM8x1lGPiWs+WKgO0Ss/ssK/tOZNFlQeOmP8bbSCHBcejVeShSA6u3wx0mCg7g5KCK+Y3viJ3g+icI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZFskvmVt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459fdc391c6so17603745e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1754923107; x=1755527907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDnLj3nHfiTbzAkj8zN3PNTrMnWkU/ikvokuB96PBrc=;
        b=ZFskvmVt49cCUmJhVzVG+61QFgQircus8JynCID65uk5BUSpTJmBushQ0nXAMTVOuK
         E2lmpe5ftgVtynOvJluShh+NIezv+d+LsbT90KwDp12AXIsQ6j2+uwfxwiZogOp+IMF+
         WvWgJdn8qroT0037ADNShCTW2hY4BPTdx3HjR9KLjTyT4JctwEIIbVtocLSbrvwqW+36
         1ePMVXad1PKU7X0GjL5lshJhGjF2hu9OFyrSvkpn9Da/sKXeOioRP3TtzUngdIrEh26s
         fr5TzVd0O2jWpNXMc4ZEAm2R5u66DQjtKO0yMItH0mOFwGHVJyY4wDcbnjawuO/FW1I0
         nrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923107; x=1755527907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDnLj3nHfiTbzAkj8zN3PNTrMnWkU/ikvokuB96PBrc=;
        b=qYhMRhZ0ZAZTGeAQg393Y+nG4RLp1CIiyJkkKhuMXpNh7V/4ZKwe3cuZrwpjGXAmEv
         M/NenoLEqyufl8uRNX0GMgTmF4gDhZKquqGksPVo9e+5OxeqnAXmj6P0k83mkrDJEAT4
         OtrEuBNFJZ7xa/PKo7qvmKM1SrY5QXYn1FgAiBgFKgs9eEGGOhtTXsEfg2hGuOta74Cp
         loQZLBSTOCqVOLk8JBHglR+T14DGnyJQedVhf6k9WICVO6EXsuIHWXZOsbu5h4RU0I8y
         M3yLkpDO129zM+jcNGuCKNt3Vh9T7ZAKD3Mt+hUz8+najOeSDd696AFh40P2ouyVfn2j
         BjbA==
X-Forwarded-Encrypted: i=1; AJvYcCU8t6jatvceWAkeYOm9FXyspBDV39kbndeWy4mpfifk55q7Rq95SYJkR29CmtVh6uxb2pJvU1iNoWvsE7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDV1ivvHdCnGqnhIrovEzChLiTHh8twQrQjPb7IKcPccyCwJt5
	Ln3LhLCrdhVYrJ+muCPLf2nffktd+kB47YpN6z3xHqrdVUVWIk9Eut830RsyPP7VyiI=
X-Gm-Gg: ASbGncs3mOhE4zz9e4ww3J16Cn7yhsJDflp2Z2gtw7m5zelRLX7A+EgaSUVKzSjVqkR
	IsmQCxzAEFght79xlRyqDlIVbfkgahdRQ1VQQJpiiEgGIochFh8ET4+iqeWaiLRQmGoryLzPZl2
	KqGbbzgUmBZevvGYVg1Z3SHu3twHqdE6Rm/u5ZaDKeHrNDyqe4wejo0+XJOJHctjgbbcmbZluCA
	aT4BoaamxHjpfwvwEVPBaJZ93K+ljo8ezVcVaYNb6cip6MdrOzmw35SA5eHe5Csthy0OzYzkzBc
	brgb0gpvnmIhFasIF4KWwY0M+t/0xKfxGYlkXtm7jGFppCbDD7PU64DAvWFlypXJrKPAXF0NvgB
	dl0YrLZmodV6USBvK5m+oxhock0kzt/l9GVKFekF4j2wSczgmHfTSPP0LEJUSqC7gvm/Zk0AP15
	pQqWY46Q==
X-Google-Smtp-Source: AGHT+IF+la5If0EY7C3TMLMaGLfDZEbIEhN9YbuU+kkFHErmZMrL09SGPul00CwuSlbJhKlCeTJtNQ==
X-Received: by 2002:a05:600c:3baa:b0:459:e200:67e0 with SMTP id 5b1f17b1804b1-459f4f523e5mr131894845e9.10.1754923106707;
        Mon, 11 Aug 2025 07:38:26 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b8aab8c0sm392263435e9.19.2025.08.11.07.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:38:26 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:38:24 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v2 3/3] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
Message-ID: <aJoAYD_r7ygH9AdS@aspen.lan>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
 <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>

Hi Marcos

No objections, but a couple of questions if I may...


On Mon, Aug 11, 2025 at 10:32:47AM -0300, Marcos Paulo de Souza wrote:
> Function kdb_msg_write was calling con->write for any found console,
> but it won't work on NBCON ones. In this case we should acquire the
> ownership of the console using NBCON_PRIO_EMERGENCY, since printing
> kdb messages should only be interrupted by a panic. This is done by the
> nbcon_kdb_{acquire,release} functions.

Just wanted to check what it means to be "interrupted by a panic"?

kdb is called from the panic handler but, assuming the serial port is run
syncrhonously when "bad things are happening", the serial port should be
quiet when we enter kdb meaning we can still acquire ownership of the
console?
>
> At this point, the console is required to use the atomic callback. The
> console is skipped if the write_atomic callback is not set or if the
> context could not be acquired. The validation of NBCON is done by the
> console_is_usable helper. The context is released right after
> write_atomic finishes.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  kernel/debug/kdb/kdb_io.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..74f6d4316bdc9d3c4f6d4252bf425e33cce65a87 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -589,12 +589,23 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	 */
>  	cookie = console_srcu_read_lock();
>  	for_each_console_srcu(c) {
> -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> +		struct nbcon_write_context wctxt = { };
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
> +			if (!nbcon_kdb_try_acquire(c, &wctxt))
> +				continue;
> +		}
> +
>  		/*
>  		 * Set oops_in_progress to encourage the console drivers to
>  		 * disregard their internal spin locks: in the current calling
> @@ -605,7 +616,14 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  		 * for this calling context.
>  		 */
>  		++oops_in_progress;

Dumb question, but is the oops_in_progress bump still useful with atomic
consoles? Will the console have any spinlocks to disregard or will the
console ownership code already handled any mutual exclusion issues meaning
there should be no spinlocks taking by the atomic write handler?


Thanks

Daniel.

