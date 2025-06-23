Return-Path: <linux-kernel+bounces-698996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A1EAE4C90
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 20:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F84417E44B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8E22D4B7B;
	Mon, 23 Jun 2025 18:11:25 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAC2D3231
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702284; cv=none; b=oe1dCIKqmATIElpgS/yfKSHKWsCucmmOK8IgPBF0LRWxGS/0vvEhprVvXNF7xd1QTR0ipFhObk9hOSgk73ginXihWoFlSbMBI4Ay9GbQPIPsGDBMQiAidmH/paH/Eqm9WyimKUiFtWss1XvIKAcpGwPqsnbCnVggZz1DRCTX/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702284; c=relaxed/simple;
	bh=rlcBDtIMoGT3V5ey9ZFYpWVUAE/L0LnaqLbwIYm3Sys=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqfeCGJrSxcWHoxRtLx6hBsn689bOB7hM7rq5jYOlXJFl3aqq4qTT/CQc2Yt3sVW9xx3H4t3Lx3ySzBQZpgZvjeliouNj12digd3WhlbAwkyv1ftkynpa69x0OjzunzLa/AN+thvy/Vi+MrJd5d+s+D3tr70v7mqKjO9WSUj9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 72cc51cd-505d-11f0-a9aa-005056bdfda7;
	Mon, 23 Jun 2025 21:11:13 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Jun 2025 21:11:13 +0300
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/5] serial: 8250: extract serial8250_init_mctrl()
Message-ID: <aFmYwcO9tJ4byxjz@surfacebook.localdomain>
References: <20250623074606.456532-1-jirislaby@kernel.org>
 <20250623074606.456532-2-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623074606.456532-2-jirislaby@kernel.org>

Mon, Jun 23, 2025 at 09:46:02AM +0200, Jiri Slaby (SUSE) kirjoitti:
> After commit 795158691cc0 ("serial: 8250: extract
> serial8250_initialize()"), split serial8250_initialize() even more --
> the mctrl part of this code can be separated into
> serial8250_init_mctrl() -- done now.

...

> +static void serial8250_init_mctrl(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +
> +	if (up->port.flags & UPF_FOURPORT) {
> +		if (!up->port.irq)
> +			up->port.mctrl |= TIOCM_OUT1;

I am not sure I understand why it was changed from using port directly to
up->port.

> +	} else
> +		/*
> +		 * Most PC uarts need OUT2 raised to enable interrupts.
> +		 */
> +		if (port->irq)
> +			up->port.mctrl |= TIOCM_OUT2;

Having {} in this branch is also better.

> +	serial8250_set_mctrl(port, port->mctrl);
> +}

...

I specifically left below to point out the original code.

> -	if (port->flags & UPF_FOURPORT) {
> -		if (!port->irq)
> -			port->mctrl |= TIOCM_OUT1;
> -	} else {
> -		/* Most PC uarts need OUT2 raised to enable interrupts. */
> -		if (port->irq)
> -			port->mctrl |= TIOCM_OUT2;
> -	}

-- 
With Best Regards,
Andy Shevchenko



