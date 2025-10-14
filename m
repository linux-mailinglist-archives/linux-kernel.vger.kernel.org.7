Return-Path: <linux-kernel+bounces-852712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD12BD9B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593F9188E78D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D93161A4;
	Tue, 14 Oct 2025 13:20:04 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821DA316193
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448004; cv=none; b=UUHyiecSRgr+Uruul4JwF2/GMcjNnYefa/Ol/rEbyWHlyfAAjL+oaNqn+GY5eXOVvm+6jQjw4d/4M9QRAnXR3ijOi6lGL9Ykg6MvP4Px0sraZS8iF+nq3so0BMBdVh4LcVsfA1DobFldR/N0s140KvtlCPE7duA3XnAiu60JArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448004; c=relaxed/simple;
	bh=aSDd+KL4NOTNpSwWZ1vV1gh67WYD6fXPWRozSjlK8ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaJHfai/YwJ3o+BGxB0XyWJUd76BmhEfk38oeYWNtyZe8ZtaG0V8T5h9l44mJl8wRDVho1nyQA8GRxLUqzHXQ2FrjZsbOu4yBgxxbE86MR4V889ZqsSmu2lY7mkDCY3UqDLdikNJRBheX0hsfs8gP4P4l8hRjZolvJXTlq7VzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54bbe260539so2064866e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448000; x=1761052800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Njz6v4Ye7icNa6eer5LCY0z/OUSx/xsBh5FobUmXyGU=;
        b=COHiUfEToyqN9lZ8p2xDGgVka91QlqhBVybRPymBowgGGEXsi7xzpNodhkRjsi1xFl
         xAOaCpogXIZ7QD0y5TGyB0eU8UsfCiuRLudM8CkwAcAoA1IF+FSr9aAmxxQSGLJYs3W9
         xssfgxnRBxDuFXYyVCTnWdg7TGUlgfxQUddNQWpoC0J7PElAFvXaGzFmOKo1nVpa3ztJ
         uY94krxk5mu6mYgORT3+iQEFJXuc1mW/13ntGcabuvhqR8egY58siw8grI/jq5Wr09QO
         NhfiQIzDcucaRA9ZcmDWACkiLmforO2lv4PQWoWR43xR3WlVaXIg1THs4B8fnLJDRSZe
         nK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTvhV6XOzFlPkXgMgpMB3o7FJJwqpuoipgp5tZx2VhvEaZenjggLIBc20rcroEXX2kxHLNDLOYq1TyyjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3P6C3lE2arat8uMToBdLucUPI5PdHqZiLFgiPOJv96zXi5rZ5
	eIU3ie0Tkyq1AJzrGXFX28DqnysvzpMPmSK9yrawlLoHQ+WbBYjU8vGsy9x/a9bt
X-Gm-Gg: ASbGncvEZi+Mq5Y4LakAkv/I+pnhnr0Af8XOUKLS/QO7DufX0U9OysccCySlATXh4Ea
	qEiXf8gjuDfvvU00X5X8/y517jjQA8jBjmIOQ3zgi875m9VJHvsXr/vIo+aZzONLKXjjWK0J3pn
	3s7WGxfajy6YitPQqa258hqA1NM4lcOWeILIO3IK+mvIDxBD6uivJFQoCOn0wujCbaovNvGaKL+
	a0uAjrg3ROLdgcy3K3AHD3zX42LBR7L/SAipTWnz4htWUREUb11fTKYj2HFV9/mRrq4PkKgqCIH
	iaELUWqp2vk4+Xl6UvBnFGiTITit8goUh1SANKCVmRy5+b5s7qMvMzDB9FbrXfCl8O8HL0rAKuU
	XTgyBwd74UVumc0CUd8U+oZi3PpC6Axb/+FuWiTFPBntsMicAMq4LXU/j1xhUcOK8yUF5JFFMXs
	3SnPAuXHx6yynSnxTpnw==
X-Google-Smtp-Source: AGHT+IEthVm+a9dXY4McwtNSEQvJGNpykwWRpLbdUi33E9WdW/ZWAC4WY2fCHHDn+68vTx5ng3sj6A==
X-Received: by 2002:a05:6122:3193:b0:54a:dcde:fa5b with SMTP id 71dfb90a1353d-554b8bfee83mr7578573e0c.12.1760448000169;
        Tue, 14 Oct 2025 06:20:00 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7ec9d70sm3962328e0c.1.2025.10.14.06.19.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 06:19:59 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5d6266f1a33so672753137.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:19:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZFhzuxLMsYq7fzSHuxFSHaTASe3mOyOnffQNlT1PWedYghlng5XZeCubIlSChLPCqmWsXy8L7vXosdjM=@vger.kernel.org
X-Received: by 2002:a05:6102:6ca:b0:5d5:f6ae:38de with SMTP id
 ada2fe7eead31-5d5f6ae3c7cmr5745861137.41.1760447998299; Tue, 14 Oct 2025
 06:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918104009.94754-1-herve.codina@bootlin.com> <20250918104009.94754-8-herve.codina@bootlin.com>
In-Reply-To: <20250918104009.94754-8-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 15:19:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNErzjfqXXgJZOn2viPYmGeuJekY_WLDeK6vzYZzdJmA@mail.gmail.com>
X-Gm-Features: AS18NWCbANtqchYIwTz4iekVik6u-ZIED4wJm4rfdVFvh3ZW_Tu4x1cmyNlu-78
Message-ID: <CAMuHMdWNErzjfqXXgJZOn2viPYmGeuJekY_WLDeK6vzYZzdJmA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] soc: renesas: Add support for Renesas RZ/N1 GPIO
 Interrupt Multiplexer
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Phil Edworthy <phil.edworthy@renesas.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Thu, 18 Sept 2025 at 12:40, Herve Codina (Schneider Electric)
<herve.codina@bootlin.com> wrote:
> On the Renesas RZ/N1 SoC, GPIOs can generate interruptions. Those
> interruption lines are multiplexed by the GPIO Interrupt Multiplexer in
> order to map 32 * 3 GPIO interrupt lines to 8 GIC interrupt lines.
>
> The GPIO interrupt multiplexer IP does nothing but select 8 GPIO
> IRQ lines out of the 96 available to wire them to the GIC input lines.
>
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/soc/renesas/rzn1_irqmux.c

> +static const struct of_device_id irqmux_of_match[] =3D {
> +       { .compatible =3D "renesas,rzn1-gpioirqmux", },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, irq_mux_of_match);
                           ^^^^^^^^^^^^^^^^
                           irqmux_of_match

Interestingly, this built fine for me before, presumably until commit
5ab23c7923a1d2ae ("modpost: Create modalias for builtin modules")
in v6.18-rc1.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

