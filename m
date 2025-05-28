Return-Path: <linux-kernel+bounces-664753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B914AC601B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 05:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C033B0763
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 03:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A341E8323;
	Wed, 28 May 2025 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IneiC2An"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5B19DF7A
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748403011; cv=none; b=g+zLR/eFVqUiZZZUJIJnorQaWND9w7yKbEF4ke/GZsMjjQIbB1f7JyLDO/JyA9n8ezV/AUhUhnnZ+ew/GtDk/3urlISvxSZADCx2XjcjosU7o2dNZpNFvyzJqOC8+AyB9iwqsad0m4/mpkE4Ol738iGekiXsELFFm8feUxIe/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748403011; c=relaxed/simple;
	bh=lp59MG/v0MEjnyPw9NAqaEU+qnQ/CI3UyhnltWOSdD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNCIh1wRecMev4AJcE4OLkPPxFhqpw5U6s3LGx9aPsrFzyiIXgVLEkSSKaPUcsHCxSiPn7+K58h5Z+qVwv/yvMNWwRcrNRAh1DezX+TJH+Jg9Oty1gB8pdPisxe2erjPN59cyfsVTIig9rZVKa9aGDOiBOSyN/rySxsbZETwqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IneiC2An; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-601ad30bc0cso300209eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 20:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748403008; x=1749007808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrpEuuXYvnSuwWGsniVnX2YpkMWl6dVwsPZNUsHfWF0=;
        b=IneiC2AnaH9l+bH9QnSyFBFORZxwRCR34xeHjAKi77lDEuL1t78exhV737N5mOZTNS
         f3DfCXpQYy+EVTvie0m2KMKX+8irttOXGAyKt/WQ/f5cbJN6Kx2j7a6zkrGvfqZH7zu/
         qMk/zP3+cOsxjPs2SU5jjIn3XqP5s0M1PGSafo4r7ZE6qTo+kR2bGIAQLMFY6vZc5Lqo
         U07qsCtsixz+okq5uJoeCqb85FV/uXOxyj4nOKRWN1qje3HxxyVyKZfhSLVwP9KCU1U0
         S+B0UhVdDwpmFVTT+53b5CrskZBR4ATuzDyMHUqyg+SHtcf53TCFfNK5+qSo9ATyg+yd
         tnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748403008; x=1749007808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrpEuuXYvnSuwWGsniVnX2YpkMWl6dVwsPZNUsHfWF0=;
        b=bwCq8gSYR4kx91zc5tFJnvhE1TxBji2erzbwitJf9nnwFHnNPJGkrRor8l2wWp86VD
         cMSvbjKnny+DIL8xveOqYx2vXoNZY2rfM0z28xxhl65iJtKiZfTY2MPENZQQwp3RAi0A
         XokRu5yVUUf0nTwbXD/3I3B3dI5akftiSpYwgDpmlftnRDfiuPIXb37VCrB7LOQqj8R1
         ZYHRGBDwyY1Ahqs8NjCbD2Z1nAR5uDo0y5DW9vmqx2h3/4dhva6kmO3GnEunrMieOIhU
         EsiHC3+4V828yMkndJTIXvIZNSiMTzjDfc4HWlN3um59Bg00fexXQkZS7l0vT1YI1lye
         VrOw==
X-Forwarded-Encrypted: i=1; AJvYcCUmjmrg47+F5Z/GqwhBZlsw4LhNukSJibAoDYeobiJSUvp3eA/SSqgWoJPWnPYR/kSNE795fWhYLuIz2co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi5wkibygbE9AxQgP+ZIXG1Yc9MxLBz4pqr29Znh8eE2ML72pZ
	WqNT75TPM3KynXlpCF8o0w1P2xCqfh1tzKE99T4zT/RaroTkbX0MjnYQH88mQTyj8GU/4I9+Xhf
	YlIAbgkWdm2Zvhl2GUiEcexrm/MUuv1O0s66w5f/MaQ==
X-Gm-Gg: ASbGncv75wLXQ4zeXaQO9+NIQGPnlJSMV8eRgfPmsQ6ocldXrQUuuUwuV6CZXGYfTr+
	FflELba582fhxTtnk9GcOq/4weEh4sNHWHzttSux0d7C5eKi2+JEXgVxCnpBEJkTERbMsS7mAOJ
	TDl3kFGnE4MZRySO6PFuie2rBXQq3y5k4UQ+c=
X-Google-Smtp-Source: AGHT+IHM257O3Htv6+WIrvCz49XVMrZHrN3aXMi+LHiIEKQzjeEjAt/Co+wbNNhuDh0ENQfvDtdU1wumurlo0vJP6vw=
X-Received: by 2002:a05:6808:1b87:b0:406:4e0c:9aab with SMTP id
 5614622812f47-406603dcfb4mr1959266b6e.11.1748403007652; Tue, 27 May 2025
 20:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513024212.74658-1-cuiyunhui@bytedance.com>
 <20250513024212.74658-2-cuiyunhui@bytedance.com> <84y0uq9z0o.fsf@jogness.linutronix.de>
In-Reply-To: <84y0uq9z0o.fsf@jogness.linutronix.de>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 28 May 2025 11:29:55 +0800
X-Gm-Features: AX0GCFtY48YUUoKYOkevJvcVSQCY_T7dJuR9Fc4nQmnT8dJb_3-42tZKJL-37Ck
Message-ID: <CAEEQ3wn6tY7QQppTScBMQTeAZDTXdEY1CJYxvGHhE9FNm_4a7g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 2/4] serial: 8250: avoid potential
 PSLVERR issue
To: John Ogness <john.ogness@linutronix.de>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	jirislaby@kernel.org, jkeeping@inmusicbrands.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John Ogness,

On Wed, May 21, 2025 at 3:57=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> On 2025-05-13, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 07fe818dffa34..9a04f24b0c762 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2133,25 +2132,22 @@ static void wait_for_xmitr(struct uart_8250_por=
t *up, int bits)
> >  static int serial8250_get_poll_char(struct uart_port *port)
> >  {
> >       struct uart_8250_port *up =3D up_to_u8250p(port);
> > -     int status;
> > +     int status =3D NO_POLL_CHAR;
> >       u16 lsr;
> > +     unsigned long flags;
> >
> >       serial8250_rpm_get(up);
> >
> > +     uart_port_lock_irqsave(port, &flags);
> >       lsr =3D serial_port_in(port, UART_LSR);
> > +     if (lsr & UART_LSR_DR)
> > +             status =3D serial_port_in(port, UART_RX);
> > +     uart_port_unlock_irqrestore(port, flags);
>
> I realize I previously made a comment saying it was OK to add the spin
> locking here. But I have changed my mind. Please remove this spin
> locking. It is not necessary because with kgdb all the other CPUs are
> quiesced, so there is no need to synchronize with the console. Also, it
> will deadlock if kgdb took over while the port was locked.
>

Okay.


> > @@ -2513,7 +2514,6 @@ void serial8250_do_shutdown(struct uart_port *por=
t)
> >               port->mctrl &=3D ~TIOCM_OUT2;
> >
> >       serial8250_set_mctrl(port, port->mctrl);
> > -     uart_port_unlock_irqrestore(port, flags);
> >
> >       /*
> >        * Disable break condition and FIFOs
> > @@ -2521,6 +2521,14 @@ void serial8250_do_shutdown(struct uart_port *po=
rt)
> >       serial_port_out(port, UART_LCR,
> >                       serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
> >       serial8250_clear_fifos(up);
> > +     /*
> > +      * Read data port to reset things, and then unlink from
> > +      * the IRQ chain.
> > +      * Since reading UART_RX clears interrupts, doing so with
> > +      * FIFO disabled won't trigger PSLVERR.
> > +      */
> > +     serial_port_in(port, UART_RX);
> > +     uart_port_unlock_irqrestore(port, flags);
> >
> >  #ifdef CONFIG_SERIAL_8250_RSA
> >       /*
> > @@ -2529,11 +2537,6 @@ void serial8250_do_shutdown(struct uart_port *po=
rt)
> >       disable_rsa(up);
> >  #endif
> >
> > -     /*
> > -      * Read data port to reset things, and then unlink from
> > -      * the IRQ chain.
> > -      */
> > -     serial_port_in(port, UART_RX);
>
> I am thinking you should keep the read here and instead move the unlock
> below the read. This would mean the lock/unlock in disable_rsa() need to
> be removed. (The function comments for disable_rsa() aready say that the
> caller needs to hold the port lock.)
>
> I am thinking something like the below (untested) diff instead of the
> above 2 hunks.

Reasonable. disable_rsa() has only one caller currently, to be updated
in the next version.

>
> John Ogness
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 22b3f7a193070..51467383aaf5a 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -781,8 +781,6 @@ static void disable_rsa(struct uart_8250_port *up)
>
>         if (up->port.type =3D=3D PORT_RSA &&
>             up->port.uartclk =3D=3D SERIAL_RSA_BAUD_BASE * 16) {
> -               uart_port_lock_irq(&up->port);
> -
>                 mode =3D serial_in(up, UART_RSA_MSR);
>                 result =3D !(mode & UART_RSA_MSR_FIFO);
>
> @@ -794,7 +792,6 @@ static void disable_rsa(struct uart_8250_port *up)
>
>                 if (result)
>                         up->port.uartclk =3D SERIAL_RSA_BAUD_BASE_LO * 16=
;
> -               uart_port_unlock_irq(&up->port);
>         }
>  }
>  #endif /* CONFIG_SERIAL_8250_RSA */
> @@ -2536,7 +2533,6 @@ void serial8250_do_shutdown(struct uart_port *port)
>                 port->mctrl &=3D ~TIOCM_OUT2;
>
>         serial8250_set_mctrl(port, port->mctrl);
> -       uart_port_unlock_irqrestore(port, flags);
>
>         /*
>          * Disable break condition and FIFOs
> @@ -2555,8 +2551,12 @@ void serial8250_do_shutdown(struct uart_port *port=
)
>         /*
>          * Read data port to reset things, and then unlink from
>          * the IRQ chain.
> +        *
> +        * Since reading UART_RX clears interrupts, doing so with
> +        * FIFO disabled won't trigger PSLVERR.
>          */
>         serial_port_in(port, UART_RX);
> +       uart_port_unlock_irqrestore(port, flags);
>         serial8250_rpm_put(up);
>
>         up->ops->release_irq(up);

Thanks,
Yunhui

