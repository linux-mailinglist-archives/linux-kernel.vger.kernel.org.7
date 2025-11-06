Return-Path: <linux-kernel+bounces-889061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E3C3C9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 076BB4FE2FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7633557E;
	Thu,  6 Nov 2025 16:51:43 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB263319608
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447902; cv=none; b=DZv6L2uAQejnDPDE9B0ySWjQ71wEjNmZDgSaW7rtO6mOwB1v4sj3zRjL0/Sq2VW7BJ8H1tb9cW9++3csBOIykee76zIHay1RxD/2jckC4MlCIPH9+/y/KWwdBzDaaFKW5bbWV1EITbjl/Bf8RXKOFP4XwL+jpAFU99Z52bs5KF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447902; c=relaxed/simple;
	bh=D2ZR6G6YZxccCdiqKPZyO6q0gMcscv+IoBGces3watg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQyhOP0NLAIzoseb6KkesjmipHcMPxOFNNgz1xE3009UjgnhEgrrPSLfHGvo35/Cnu6Pl4jmAZCFF9xddWJQkS47gqLpB5fv6ju9C59iUjTxpVvzeAl8IcAkuvOmkdVyLnTYh6/QvwOBA76GBfVbBB7hg9fGVxbBUSk+p7wKcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1924680a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447894; x=1763052694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fIROfk4M31jFA5apdExc9xs5jzKKy4c00+TA02caho=;
        b=eN0AG/5F5EsQ4yVP/V9eQtd8dqlfWeIgx4uwzsjxKb8UYJOu8IQrBXUMqUVHU35zbN
         vXAeQBocF2PhqO5+oXmQbjMNmgj/BG/Aq6EpRztmQ1lfKdikeJhU22dDe/6y1m0A0XgL
         Nhwej5K9dlw17JzsybWKGzKr2rtPqc4v7jfbQOxu3eW+hVU4mL5Xin7KBJn8eqUJgCXK
         fT8+BaEBS7qVOuLdJPgyEWAt9JDBwb3RQBkpwDZ7/ZA/4kg3mxe8XTcpXJr88bVLHVLE
         XOjeHt12VmsfiXR2mR8VKpoCjEHFzNzniNMz0lolx9D2gbtSTXL758ELyf22amoAfl/C
         BvlA==
X-Forwarded-Encrypted: i=1; AJvYcCUyOPGjUiCKt9TBfCyCDahtmBa+sqyWeN+NP55nowcGZFlHhA6KW5yKX+Qkc7ckFTFgOUOe6t02mFoaLNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx381WvSblJjpZMdOVbJ8Z+XLC4YaXnTGDiigdzDiEz9hZWmk60
	VEEoHxnZidc0VqEuRQFjYo/S5Zn1udD7on5i+QfQ2f+KEYQA6dvUTKi5xhAF1jBYE8Q=
X-Gm-Gg: ASbGncsRnQPx8i67D/NGzjTx4x3wBUzVbMVyHQMjf2o3Bnk5IbCXNAT66uMJDHiKc7+
	7WFwM9PFEL46q3vQ1H7ebxuIsP4Q3HocNRfdPtd12BpclwK5eSlZvwwXf1H0z3odj9VCqjtH7SU
	oy9fhMR3UqsuVbhVziSXLifcIuqMPU0Du8YixvGJ+5DkASdfX7pK57GmlHNoJwIw7c2mspIl82p
	HlfEIcAlF7okIRadDSq4o3N2cwd3oeRiKCbxJfa6FPGEwZg9VFESybFmQE7h0FarSqay87TrSsE
	wUSM3nNpekdULT49Vg8OEVRQRnFWuTnisi+H5/tbypCPO1YarUf7p6pNvgPG23HRVbn62LqoVzV
	1tR9h7MTFlr2gHAQKlDow5OHadItBIKfcC0HMsUaGqHWRbglNJQJGtmYZZO0wEMxJJEcqWrwTZv
	gwrzD2hIuklZRUCJRTbOucKoeREWr9pd3d4MqeLiBgqjvRpjGx
X-Google-Smtp-Source: AGHT+IFjOeRSX8cBt3MnVqgIgSn8wyVXvfl2lnetKem39Eu0Qy1lwKy0g/m9anu7eUdF2JDXS/7dpA==
X-Received: by 2002:a17:906:3c4a:b0:b72:67c2:6eb0 with SMTP id a640c23a62f3a-b7267c28fc0mr589410166b.62.1762447893971;
        Thu, 06 Nov 2025 08:51:33 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a17sm3772766b.27.2025.11.06.08.51.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:51:32 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1924451a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:51:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxgkJekZ7/hb9tglERqomAKMj4Y4TJ37zWz9fMaNhXtRVSiO2ZiSogPjsIEC9AG/914aFShRshj+X/+K8=@vger.kernel.org
X-Received: by 2002:a05:6402:35c9:b0:640:fb1f:e934 with SMTP id
 4fb4d7f45d1cf-6413f0834a2mr20615a12.32.1762447891499; Thu, 06 Nov 2025
 08:51:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029082101.92156-1-biju.das.jz@bp.renesas.com> <20251029082101.92156-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251029082101.92156-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 17:51:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUXimjkB_Cz=ac43RhOGF2Lf1ypLK1sLwk=ONXf7kdhQQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk5DY6m4c8xO-kYacWAOBZuK7yTJexfPP1B_4jehepe727_WwaTWXgMpQg
Message-ID: <CAMuHMdUXimjkB_Cz=ac43RhOGF2Lf1ypLK1sLwk=ONXf7kdhQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: sh-sci: Fix deadlock during RSCI FIFO
 overrun error
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Nam Cao <namcao@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 29 Oct 2025 at 09:21, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> On RSCI IP, a deadlock occurs during a FIFO overrun error, as it uses a
> different register to clear the FIFO overrun error status.
>
> Cc: stable@kernel.org
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/rsci.c
> +++ b/drivers/tty/serial/rsci.c
> @@ -414,6 +414,7 @@ static const struct sci_port_params_bits rsci_port_param_bits = {
>         .rxtx_enable = CCR0_RE | CCR0_TE,
>         .te_clear = CCR0_TE | CCR0_TEIE,
>         .poll_sent_bits = CSR_TDRE | CSR_TEND,
> +       .overrun_clr = CFCLR_ORERC,
>  };
>
>  static const struct sci_port_params rsci_port_params = {
> diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
> index e3c028df14f1..bcdb41ddc15d 100644
> --- a/drivers/tty/serial/sh-sci-common.h
> +++ b/drivers/tty/serial/sh-sci-common.h
> @@ -51,6 +51,7 @@ struct sci_port_params_bits {
>         unsigned int rxtx_enable;
>         unsigned int te_clear;
>         unsigned int poll_sent_bits;
> +       unsigned int overrun_clr;

I don't really see a need to add this field, as there are two alternatives...

>  };
>
>  struct sci_common_regs {
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 62bb62b82cbe..b33894d0273b 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1024,8 +1024,12 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
>
>         status = s->ops->read_reg(port, s->params->overrun_reg);
>         if (status & s->params->overrun_mask) {
> -               status &= ~s->params->overrun_mask;
> -               s->ops->write_reg(port, s->params->overrun_reg, status);
> +               if (s->type == SCI_PORT_RSCI) {
> +                       s->ops->clear_SCxSR(port, s->params->param_bits->overrun_clr);

1. You can just use CFCLR_ORERC directly here,
2. All of the CFCLR_*C clearing bits match the corresponding CSR_*
   status bits, so you could do without the former, and thus use
   params->overrun_mask here, too.

> +               } else {
> +                       status &= ~s->params->overrun_mask;
> +                       s->ops->write_reg(port, s->params->overrun_reg, status);
> +               }
>
>                 port->icount.overrun++;
>

BTW, how is this related to "[PATCH] tty: serial: sh-sci: fix RSCI
FIFO overrun handling" [1], which is already applied (and which I
still don't fully understand the big picture behind. I'll reply there)?

[1] https://lore.kernel.org/20250923154707.1089900-1-cosmin-gabriel.tanislav.xa@renesas.com
    commit ef8fef45c74b5a00 ("tty: serial: sh-sci: fix RSCI FIFO
    overrun handling") in v6.18-rc3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

