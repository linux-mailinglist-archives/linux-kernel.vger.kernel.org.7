Return-Path: <linux-kernel+bounces-656869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323ADABEBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 08:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12254A640D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 06:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04427231842;
	Wed, 21 May 2025 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JkGzmFXF"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC322D788
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747808480; cv=none; b=ZvRjeHq6z0w3nanbNYgtdt1qRXWc3c1hIjeoCuEmfkI6rSjNo9hXREnGUzikB4hgBrk7GFV2LEpn+mkvkW/9a9+WdbxfrRO/0V8SwPH1+4mD3LS0L//8bCaLq5tkd1BIzG93e2v8JxL9qjRXn/DNUR/rCqpy9RiVWO/tgnH17uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747808480; c=relaxed/simple;
	bh=6fd7IHRGu83NxTfyT0SalOcLlzPOsDoCo5ZLaUQUYko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OdRq0BCy1jOjLa8IZ3cNVXHWD3vPvQwvThS2v8/P/D5jwZc9Np7ykVnPGvRlT+SZMJEfwTJVTFFEhO5dnSHZ31iGjkSYd1siiCmpP21+bMoBOWGHnfHB5eKvB4wnOpjm4NJ2hTrDRXxfW4R3rGzZeDaNDjN6jmd5PAdvZsCN7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JkGzmFXF; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2d0920ce388so2364806fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 23:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747808477; x=1748413277; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOkB60AMJtxVpaqykf8gS9NGTSk7YEzw+V5v/2zgCaA=;
        b=JkGzmFXF6d5ZfzW+RD3kz4XEKJf3HPXc0wUlj/dz0pA4pPXYZ3NlBO1zepgoxaVfGH
         v2pAXaXwuYbyTfLiQSc684fd+sPAXjn4HOpQUIdzdHqw4rHKb7Br0/V0YSFVBPProPqn
         X+QK0V4rz2ZTUlXyrMtxFhvdhdbR7ac8HexEktBoCTZIWn+E2/LkGmHuf0soRjFEud9i
         LHduU2lI5roVW1bW2+504SAavLs/pjhsR62xdKeb85NLzaOC2kC+FC5l7W2Hn70A24Oo
         6rxwhRAzLgj1aJQSj15iXFKOfV7thLdMNA0sZm5k/yYc807vGulx6q3qc5REH3WIYuCB
         UffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747808477; x=1748413277;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOkB60AMJtxVpaqykf8gS9NGTSk7YEzw+V5v/2zgCaA=;
        b=hINAzFCeZcY2zINsN1ESPnqFew/w91umw5gmm+nbKYB7X7+pMVC+p9ALYGHPVQFoOf
         SZsjvf/ZKszvNEbCYn02/9puoPJWvQP6rHPg7xMVkdNSEql5+M4eoPh0MC/X33DeqQPc
         NLgJzzSAg5RhgWcJN39YxEEhw+As9ng84Y0t8a/ymVcxUrXxJ89WHWOsxLQBSFiLRxnU
         VZI2ZP+oYEHXSn8hTz6GoRDiLjqpqUZXILJyno/ejqqCxRrVrONI3rVJGSLErnLQl+rQ
         Pm3ZEsYiPvriHx5Frz2N9Neh4/m/oAhc15oFTr+m4KijI8wRcpn8DErdhvNYyJJmCsCG
         HUig==
X-Forwarded-Encrypted: i=1; AJvYcCVWne/VH2MtLjPtNK74zV/5jr7pR/RmxhN8Vg/gSNzYS2RU206ORiVEyFfFHOJ0dY9pClA0x32WQN8HDDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cHChlUKdYcx8Z1FyRgmxYglb5b8X8rNYvoHweA/62eOie7GC
	ZoFsIQhPu6DhNvuF+se30Vl9nQ4vOJtBajVj+OXEpU4kW28hznx/UxjIC3XdpPzDr0+qj6wmMeE
	qP/P4umj4ZhpIILF6FJxc8yhaznSq65Rq+T5oD9nuEw==
X-Gm-Gg: ASbGncv5zzDv71iFN3leOyGpZk1z/v+0sE1CgFPG0ucfFfKizFli+6c1MEmnM5pz4/E
	x8hCODJAGjj5jbhs5GcKUhJj0te6/9rIEaXv0MeGHJmQdhZMRSCOkH3GOcpGdv30tIWRPaaIJyb
	YwMyCb0xOPLvbDEbsih3McSv9ZSwQVTVWdyHR1mMbW7pcgKA==
X-Google-Smtp-Source: AGHT+IFdeoiENF5NssGj08RW6C8y/2V+vUCBOiJ7eOfqfvG4ZPU6n8gvvJkZVmrcaOvrNSI0kRH1Lpo+qxGQ/w67DaQ=
X-Received: by 2002:a05:6871:33a0:b0:2da:8a0e:6563 with SMTP id
 586e51a60fabf-2e3c1ed0fa7mr12098896fac.30.1747808477225; Tue, 20 May 2025
 23:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513024212.74658-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250513024212.74658-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 21 May 2025 14:21:06 +0800
X-Gm-Features: AX0GCFvdsHvdDnWwbBaqd6fO_vbeMJzi4JgqkAgCH7b1GhfiOeTj9TnK_lkVy3Q
Message-ID: <CAEEQ3wmNGNuG3v7RgowMrcHX9D7uRz3Y2q0eoORAN4i1Ep_HiQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] serial: 8250: fix panic due to PSLVERR
To: arnd@arndb.de, andriy.shevchenko@linux.intel.com, 
	benjamin.larsson@genexis.eu, cuiyunhui@bytedance.com, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, 
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org, 
	jkeeping@inmusicbrands.com, john.ogness@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	markus.mayer@linaro.org, matt.porter@linaro.org, namcao@linutronix.de, 
	paulmck@kernel.org, pmladek@suse.com, schnelle@linux.ibm.com, 
	sunilvl@ventanamicro.com, tim.kryger@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Gentle ping. Any comments on this patchset?

On Tue, May 13, 2025 at 10:42=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.co=
m> wrote:
>
> When the PSLVERR_RESP_EN parameter is set to 1, the device generates
> an error response if an attempt is made to read an empty RBR (Receive
> Buffer Register) while the FIFO is enabled.
>
> In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
> UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
> dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
> function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
> Execution proceeds to the serial_port_in(port, UART_RX).
> This satisfies the PSLVERR trigger condition.
>
> When another CPU (e.g., using printk()) is accessing the UART (UART
> is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) =3D=3D
> (lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
> dw8250_force_idle().
>
> Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
> to fix this issue.
>
> Panic backtrace:
> [    0.442336] Oops - unknown exception [#1]
> [    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
> [    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
> ...
> [    0.442416] console_on_rootfs+0x26/0x70
>
> Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround"=
)
> Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 6d7b8c4667c9c..07fe818dffa34 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2376,9 +2376,10 @@ int serial8250_do_startup(struct uart_port *port)
>         /*
>          * Now, initialize the UART
>          */
> -       serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
>
>         uart_port_lock_irqsave(port, &flags);
> +       serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> +
>         if (up->port.flags & UPF_FOURPORT) {
>                 if (!up->port.irq)
>                         up->port.mctrl |=3D TIOCM_OUT1;
> --
> 2.39.2
>

Thanks,
Yunhui

