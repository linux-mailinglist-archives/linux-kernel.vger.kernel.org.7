Return-Path: <linux-kernel+bounces-889072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B91B9C3CA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E69E4F60FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49B34A3DB;
	Thu,  6 Nov 2025 16:54:53 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3E346762
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448092; cv=none; b=b6LcwdUk7P7IGNZ4doczITBfGTX4cwMxp0txSH/PsCIYiRRwHZkfS1iOEgPW+0CXzmmqj2iHqf1m7nKoIXT0JcPbZBIPgKG1JKMl7HbMaHa6dQFhTn+45RvA9brb2KuvVGV9OlMvv2YnHPG/qiX1pjkaqyY/1F7W1a4SIuWqCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448092; c=relaxed/simple;
	bh=0f45Jhy3vyneeuTWj7fqcWoBCV5Ykzs4Vow1o8J9vUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkQdWpvB+wkA1ArOIOivUFBPAcloL1q5igXX3zStmO++a4dygxX5z1I67+1daV5BA2yUQ2WGKW1zU4yJNQV7QeCegC+Zrtf7XO6Lfp5yUEFIUTDkrSvSKkrRbf+trpJLzEZJHGRiruoFI/HmIK85VZQnc6PeqLmCn81u5WkRRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso1818624a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448087; x=1763052887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHEPbBF5p6FHfbwI0jMq/NClHsHl36pINBGK1avEHfY=;
        b=Sr4Z9DE10I48k6f67Hyf61kNEV3imrVpAFLhNg5TDE6dozKuSy67EuiT/aXztK84o8
         wgsGRAk+En6Rx/RxxepzZ1eXLmWxvJx0qNh8Ps2200DLT+nslL55jPtoYGkMOHhFjYMk
         z9iQoQsOyXa40NPjXpyKPcu/lYyE17CPudN8ZyrLOQfyi0J7zEEtNrfCwKHCBOoA2BxX
         nKAYqpdy4bMsOrCShWZGHhN7ubXqHi716Q8WDJcoZwNz+BXEGIrTYIH1szrQY5xmagtk
         4ULvda91+GS0Fc33XbQqoOsvq7kgCs0ADh1HWqIAFTr/4nVijfDsSu3/qIQt98fxGVEG
         papg==
X-Forwarded-Encrypted: i=1; AJvYcCVimPgcd/35z28vlCCYJJlWZpDw2PLn3DcVgwEFyh9gCeHcGe46pt4P2VnJw0e63kZhUr8reDoRyxvan2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQ/NltoLJDmRMISMlWAuoce9CdwqkQrRxLvI0B/aq/LeBVAv3
	UpWARdNYgpJTt/DHSiynTdMgF4372iaY5R8VxK8Tg/5GZR9YCxrHPvcowdYm91QVTzQ=
X-Gm-Gg: ASbGncsMk06NYX6SK+9oTFMCoOc184IZJJh6LbqcvEw9k5gr/i8htYk7Ef+69z/Q66V
	Vu9ZGfyPJzxy7J1BUBe8py+ydSuDn94zfc+Pz5yxvcqqiWLmAfmtVKLqAz8t+Z3csUBmzCT8THA
	5LVuqSNl47YwLJi8N57EUlBITGqzmxB7XYglaWPu2dVHu+d1USwMXFwfQAE4Ixk5OQdNhzLfztK
	/bbIwiKORQVK5KEfi+vGxpI4j5Cujrn63ozYJe2rp31/aXKk5tsz5Q/hbdXr+oTFLcyJ7+VzhLj
	J2tkPnU+G+CarQt2mASAtgaGElXnhop5ZDKIyJZJwnTOWnjg//KY7QLWpFi0s8hLdqhx/V9I8IT
	cD/GAV6eI81X2i1UAcq6YJFHL9LeEV79wnKKLeKJc8sT6/c/+c5V+lcSIDFjNgEM4XcVL9zXfrw
	m1qNy0FYzh1qPQcglDlsZmFjAaiHo+bxyb3ZwCVLuMXfkATwfzomCtyz0iq9w=
X-Google-Smtp-Source: AGHT+IHKaDcUK3PRiYiqN9y1Sm2MXXBeBNSxmRtV3jJDqF8zzhGKZnFfIuiDBSc/b1AoSnCn6j+8jg==
X-Received: by 2002:a05:6402:5113:b0:640:ea4b:6a96 with SMTP id 4fb4d7f45d1cf-6413eeafa28mr76687a12.8.1762448086688;
        Thu, 06 Nov 2025 08:54:46 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm2215273a12.2.2025.11.06.08.54.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:54:43 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1929828a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:54:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNzI4sVxqkzu8gQfNwRicFUFDcqoChfB+yv3A6yWayWiSIZSqU5/jpb2C2bG5sLF7fdYjwW2zPANLTdPE=@vger.kernel.org
X-Received: by 2002:a05:6402:460f:20b0:640:a7bc:30c5 with SMTP id
 4fb4d7f45d1cf-6413f070166mr36081a12.28.1762448083616; Thu, 06 Nov 2025
 08:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 17:54:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWRCGYLRK_WBmbB0cRP7PHiGPSi3U1jdWSVKaTSweruUw@mail.gmail.com>
X-Gm-Features: AWmQ_bmQmsHt_92KjlOBxlqZCgcBwWXwdvX6xOc66LuFHB1pYmrIKPozpRSE9Ro
Message-ID: <CAMuHMdWRCGYLRK_WBmbB0cRP7PHiGPSi3U1jdWSVKaTSweruUw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: sh-sci: fix RSCI FIFO overrun handling
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Nam Cao <namcao@linutronix.de>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Tue, 23 Sept 2025 at 17:47, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The receive error handling code is shared between RSCI and all other
> SCIF port types, but the RSCI overrun_reg is specified as a memory
> offset, while for other SCIF types it is an enum value used to index
> into the sci_port_params->regs array, as mentioned above the
> sci_serial_in() function.
>
> For RSCI, the overrun_reg is CSR (0x48), causing the sci_getreg() call
> inside the sci_handle_fifo_overrun() function to index outside the
> bounds of the regs array, which currently has a size of 20, as specified
> by SCI_NR_REGS.
>
> Because of this, we end up accessing memory outside of RSCI's
> rsci_port_params structure, which, when interpreted as a plat_sci_reg,
> happens to have a non-zero size, causing the following WARN when
> sci_serial_in() is called, as the accidental size does not match the
> supported register sizes.
>
> The existence of the overrun_reg needs to be checked because
> SCIx_SH3_SCIF_REGTYPE has overrun_reg set to SCLSR, but SCLSR is not
> present in the regs array.
>
> Avoid calling sci_getreg() for port types which don't use standard
> register handling.
>
> Use the ops->read_reg() and ops->write_reg() functions to properly read
> and write registers for RSCI, and change the type of the status variable
> to accommodate the 32-bit CSR register.
>
> sci_getreg() and sci_serial_in() are also called with overrun_reg in the
> sci_mpxed_interrupt() interrupt handler, but that code path is not used
> for RSCI, as it does not have a muxed interrupt.
>
> ------------[ cut here ]------------
> Invalid register access
> WARNING: CPU: 0 PID: 0 at drivers/tty/serial/sh-sci.c:522 sci_serial_in+0x38/0xac
> Modules linked in: renesas_usbhs at24 rzt2h_adc industrialio_adc sha256 cfg80211 bluetooth ecdh_generic ecc rfkill fuse drm backlight ipv6
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc1+ #30 PREEMPT
> Hardware name: Renesas RZ/T2H EVK Board based on r9a09g077m44 (DT)
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : sci_serial_in+0x38/0xac
> lr : sci_serial_in+0x38/0xac
> sp : ffff800080003e80
> x29: ffff800080003e80 x28: ffff800082195b80 x27: 000000000000000d
> x26: ffff8000821956d0 x25: 0000000000000000 x24: ffff800082195b80
> x23: ffff000180e0d800 x22: 0000000000000010 x21: 0000000000000000
> x20: 0000000000000010 x19: ffff000180e72000 x18: 000000000000000a
> x17: ffff8002bcee7000 x16: ffff800080000000 x15: 0720072007200720
> x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> x11: 0000000000000058 x10: 0000000000000018 x9 : ffff8000821a6a48
> x8 : 0000000000057fa8 x7 : 0000000000000406 x6 : ffff8000821fea48
> x5 : ffff00033ef88408 x4 : ffff8002bcee7000 x3 : ffff800082195b80
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800082195b80
> Call trace:
>  sci_serial_in+0x38/0xac (P)
>  sci_handle_fifo_overrun.isra.0+0x70/0x134
>  sci_er_interrupt+0x50/0x39c
>  __handle_irq_event_percpu+0x48/0x140
>  handle_irq_event+0x44/0xb0
>  handle_fasteoi_irq+0xf4/0x1a0
>  handle_irq_desc+0x34/0x58
>  generic_handle_domain_irq+0x1c/0x28
>  gic_handle_irq+0x4c/0x140
>  call_on_irq_stack+0x30/0x48
>  do_interrupt_handler+0x80/0x84
>  el1_interrupt+0x34/0x68
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x6c/0x70
>  default_idle_call+0x28/0x58 (P)
>  do_idle+0x1f8/0x250
>  cpu_startup_entry+0x34/0x3c
>  rest_init+0xd8/0xe0
>  console_on_rootfs+0x0/0x6c
>  __primary_switched+0x88/0x90
> ---[ end trace 0000000000000000 ]---
>
> Cc: stable@vger.kernel.org
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch, which is now commit ef8fef45c74b5a00 ("tty:
serial: sh-sci: fix RSCI FIFO overrun handling") in v6.18-rc3.

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1014,16 +1014,18 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
>         struct sci_port *s = to_sci_port(port);
>         const struct plat_sci_reg *reg;
>         int copied = 0;
> -       u16 status;
> +       u32 status;
>
> -       reg = sci_getreg(port, s->params->overrun_reg);
> -       if (!reg->size)
> -               return 0;
> +       if (s->type != SCI_PORT_RSCI) {
> +               reg = sci_getreg(port, s->params->overrun_reg);
> +               if (!reg->size)
> +                       return 0;
> +       }
>
> -       status = sci_serial_in(port, s->params->overrun_reg);
> +       status = s->ops->read_reg(port, s->params->overrun_reg);
>         if (status & s->params->overrun_mask) {
>                 status &= ~s->params->overrun_mask;
> -               sci_serial_out(port, s->params->overrun_reg, status);
> +               s->ops->write_reg(port, s->params->overrun_reg, status);
>
>                 port->icount.overrun++;
>

Ouch, this is really becoming fragile, and thus hard to maintain.
See also "[PATCH v2 2/2] serial: sh-sci: Fix deadlock during RSCI FIFO
overrun error".
Are you sure this is the only place where that can happen?
sci_getreg() and sci_serial_{in,out}() are used all over the place.

[1] https://lore.kernel.org/20251029082101.92156-3-biju.das.jz@bp.renesas.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

