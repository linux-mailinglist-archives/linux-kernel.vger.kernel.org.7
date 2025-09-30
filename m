Return-Path: <linux-kernel+bounces-838222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACBCBAEB94
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E541C284F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5F62D1931;
	Tue, 30 Sep 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S31i/LCt"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51657264F9F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273216; cv=none; b=hJpHPfnX1UUZUV5vWZyDqvRLPWRGtfNmVLpYQ9ksVcahtQRAf+z58oeWG7Ogu2j5gqrokCnmrsxOWGo3YZQx2eR2FigvpMwyI0qFw/4G9OQuAMvRrZ7WZe0M+vN5qn5eMOEFFpwdfCAumQhGh/sNi2wdUUk1xrR3oYlcolBzYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273216; c=relaxed/simple;
	bh=0JAdTX9kSCI0ZL2lixlSV2aTjK1FwSvpdQJXgYHkgA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp/OTl5WpEf4fYK4zmgUnN91x8f4nTr47fya70F3NqTIUzsXifAqbMWRUU2JBdhX6y+aYWPJCbKWK/7WnHR4qBhBGHb9e4Tc2fzAR8a1aa6R25JfRuu5MXkUuUvQZtQO9noBrQ0MkAYKmjRyCCSU05rhfSssPFz1ekgCmkSVIu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S31i/LCt; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57b35e176dbso8205757e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759273212; x=1759878012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNGpoJ5D1HDARLkPTC0Il8tsGPxqsMJo0AN7zBWkLI0=;
        b=S31i/LCte32fAC5JKpz4CSTkJ7tadDLjIngdsdFR0nKDFcnmWKB2uxbjY+uWyfeuQx
         7vuCrzkydDTd8o6JtxmTiYEQK4Ocmxhl8PcX2HsD3nDPAEw67NV6DF8DplxQnccZabL2
         ioJkc1BiogXLwFDOM0UsQ7otBAaVFIIBI8UlHMtaPoDxyrxJjuKPjyB3uAH+vWW2OTGh
         xCEhlDCX75P/BAP9VhPc6pcs593xJkgpvTJCqWz8FZNEAV9SKFd+wHOJDXKv446mUYi0
         WBSxwY3CWEHUzuluEAlq+ScbPBD5zqEthRCxah5dWLKs4X6H9UO4IgyLn9EBXP6f5xen
         fRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759273212; x=1759878012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNGpoJ5D1HDARLkPTC0Il8tsGPxqsMJo0AN7zBWkLI0=;
        b=uK365atn2IwPMM5g2hMN12sMls1Q7Bb60BvFOxv9llBigBgC38e+sAAe0Vyuu4Qa9D
         7GkzvYl5onyUKzo2opZrZzUTOjWTnqh4uGAd1FGZZovVT4+g+25eUuUhgFNi48/FaKY4
         kuEWHBaWrfCyZNmnw6lq85xYDLQUSmhv+o0nel594kG7Uw6Rm6KGkdVEElzSUuP3sDFE
         opTT1vwnaOapUEwWYZP97op9ROUSGI/GKkzd8q44d0QhrWYjohfTivnywfVHCHz9nQx5
         NT/HayG/zDhMrk1kmXnCwlzCI8TwNCWRWs2Q/E+RDALHclBu0j+FYberxI8uqtnYeuXD
         +iQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYDGsH62fOqyaqJEsZbUacSuNdLuJd+EsmpT7OphV4yBHHJEMPiy6cgRuE/dr/iUkwEykd9vOImvovHuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7F94H8A/aDPYxBXifBeZLvYAhmWx2jthvHox8WIjCN6BW660P
	xqNGW8d3ogy69QdMY4oesi79nFxuO9l4e77Z6acO6NrewJWQ2eOkowybe2A9RvRR2eWV2BsLmy1
	qacKZek5houMpuO4CnL9rz+Kc/TQaAVAntEiwwU7SUQ==
X-Gm-Gg: ASbGnct1mBhISiJM/GktS5eR0TQxmLLKj7VVDprLe2tcCjZ1kEU4foRQATmu6imGbo5
	9rzRrkTehilxQ8KAkXwzptMK48nq+eJbJHNf1+G+Vnzo4iKX74vGhhcAqwt+QonjWmjm6h5/zBr
	oUzgL2FXxrAkuBJpkjApe8YqoLigYOMEAZpIGOYMcXwWSAdYEjJW8isYk+NyRgW6r7JmcA5Lwi3
	28mJjMTbv68Ccp+1Stkpm5JB3sgBu0=
X-Google-Smtp-Source: AGHT+IEVz6f2f6ubGL1NAHbArQuJx21btrHT6IMUIR8tJN8YYNQAnJBbiclaELxhNdFbCs8p1UkBI5RhBN5Vzj3bgbs=
X-Received: by 2002:a05:6512:b05:b0:57d:d62e:b212 with SMTP id
 2adb3069b0e04-58af9f4b755mr335472e87.38.1759273212293; Tue, 30 Sep 2025
 16:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922142427.3310221-1-ioana.ciornei@nxp.com> <20250922142427.3310221-9-ioana.ciornei@nxp.com>
In-Reply-To: <20250922142427.3310221-9-ioana.ciornei@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 01:00:01 +0200
X-Gm-Features: AS18NWDno9w3YJfSDGfd27SZbITIyFHNn9tKwshGM3VINLqos-LcWggqf3IrU68
Message-ID: <CACRpkdYBz2Ly20N92w1FCZFOs6GONzEHi8ZsVg_HAUNExh071A@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] gpio: add QIXIS FPGA GPIO controller
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ioana,

thanks for your patch!

On Mon, Sep 22, 2025 at 4:24=E2=80=AFPM Ioana Ciornei <ioana.ciornei@nxp.co=
m> wrote:

> Add support for the GPIO controller found on some QIXIS FPGAs in
> Layerscape boards such as LX2160ARDB and LS1046AQDS. This driver is
> using gpio-regmap.
>
> A GPIO controller has a maximum of 8 lines (all found in the same
> register). Even within the same controller, the GPIO lines' direction is
> fixed, which mean that both input and output lines are found in the same
> register. This is why the driver also passed to gpio-regmap the newly
> added .fixed_direction_output bitmap to represent the true direction of
> the lines.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
(...)
> +++ b/drivers/gpio/Kconfig
> @@ -1986,6 +1986,15 @@ config GPIO_LATCH
>           Say yes here to enable a driver for GPIO multiplexers based on =
latches
>           connected to other GPIOs.
>
> +config GPIO_QIXIS_FPGA
> +       tristate "NXP QIXIS FPGA GPIO support"
> +       depends on MFD_SIMPLE_MFD_I2C || COMPILE_TEST
> +       select GPIO_REGMAP
> +       help
> +         This enables support for the GPIOs found in the QIXIS FPGA whic=
h is
> +         integrated on some NXP Layerscape boards such as LX2160ARDB and
> +         LS1046AQDS.
> +
>  config GPIO_MOCKUP
>         tristate "GPIO Testing Driver (DEPRECATED)"
>         select IRQ_SIM

Why is this menu entry among the virtual GPIO drivers?
Move it under the MFD menu where it should be, please.

With this fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

