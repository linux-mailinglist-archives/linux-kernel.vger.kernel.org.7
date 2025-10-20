Return-Path: <linux-kernel+bounces-861494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CECBF2DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E96A426D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30162C21E2;
	Mon, 20 Oct 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cElUcY9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296AF2C0F7F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983773; cv=none; b=RrxC1uy33ccVi5sFTcQ+1eCBXBpv8SPecPznPjxDK8QUMS28dPnL8r4wKgMTW2NpnCePCsiFxEaDPTJMt8dRcKSdBAAAuK1bmEqaYK1mVLJ218cH2ppKTqY4OxisZxXrVFwBMTEnLMs+p2Dh/62NBVs27RHyYxPh0IQDUbqWhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983773; c=relaxed/simple;
	bh=oKPrwAwmPcFNZGmDx1ZWXy1ZmIL+sig1bBBsB/7aJUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ks8zwkZ904kZXSlzdXSbHbp58yWQiBJ913BrsXAvKwnlxzyObPyszObliRate/uX2UlQWZD31JB0U0RdSIC1UfnM+PUyl1JXSPnORcy7D+Y7CRHNsr05dy82EF354AY+x+9xvhxLCclqt092jnY0+iwWAl7KqdgOR1S6RFrnVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cElUcY9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE905C2BC9E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983773;
	bh=oKPrwAwmPcFNZGmDx1ZWXy1ZmIL+sig1bBBsB/7aJUU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=cElUcY9juSeNiBjy+AkG0mXLvgXLuSinG148FBwevxnzyyxzs38DdleUuvtzmuEzB
	 SH8INpi4KUw3KgsjR8GrstW4Y5gnuCHyF9IqUgXy2fy6SNyd/3rSmUFPZIfYZcOfqm
	 9ZtS2daVF952W50BeOX8oG+blrQfeL1PfB90fJJCHhcRX9KGb44VWLjGsQD2t9R1P5
	 cfmM/K5pGmIA8A9ihqTJP9ttrDFbwTSk13gkw49vtm3IBnMEgF2/YnE3tOEOxxxvhg
	 twMzL/eWbUVtqDHnTpBhxpsJnEW5584f2wrnVvVBbhoCuDoDNgIUrHKFVXCI8/52wX
	 TcbjfAXTQzR3Q==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3652d7800a8so35584851fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:09:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7CDqPd3m6D1p8c5piayaHrvrJkOG6rQgKorcghyzVcUH9rk/y9JJuNCOA7mkUlwVsV7FMSja0Y0syE1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTSSVbGgpaCp0TPtDqNi9pIWih6OA5ycIOe/+BVnnAbI6zsle
	huAHoK1jC4ux2Ps9pEgfiBBTlAiTicowmaKDOUl+fVQMBVq5++RZCcuCZ/Z0rxSUZZ82e84l8NI
	3BYg1ir4/wP+1iLb/S4qeF95A0r3wKpc=
X-Google-Smtp-Source: AGHT+IFuWmZV6QNucFFpgj1UEioCDpFc0/s3jbB+5BwfcLRxENd3iLjRFZ6WKCDjV8YIsE8qTPZM2NSG8F6Mb8oD9G4=
X-Received: by 2002:a2e:bcc4:0:b0:36d:6ae3:8158 with SMTP id
 38308e7fff4ca-37797a0daa8mr37580611fa.25.1760983771244; Mon, 20 Oct 2025
 11:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020171059.2786070-1-wens@kernel.org> <20251020171059.2786070-7-wens@kernel.org>
 <8591609.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <8591609.T7Z3S40VBb@jernej-laptop>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 21 Oct 2025 02:09:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v66osdLJa=_nTxz9wppUkxvu2fuS=NgYN8fKOUOLHw6-Ag@mail.gmail.com>
X-Gm-Features: AS18NWCT7E5mgPMwg3ZEBu9fYAxffaDigDTAPFUYOPP5rokDOnq4gkBQ9OJvhcg
Message-ID: <CAGb2v66osdLJa=_nTxz9wppUkxvu2fuS=NgYN8fKOUOLHw6-Ag@mail.gmail.com>
Subject: Re: [PATCH 06/11] clk: sunxi-ng: sun55i-a523-ccu: Lower audio0 pll
 minimum rate
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:52=E2=80=AFAM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne ponedeljek, 20. oktober 2025 ob 19:10:52 Srednjeevropski poletni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> > While the user manual states that the PLL's rate should be between 180
> > MHz and 3 GHz in the register defninition section, it also says the
> > actual operating frequency is 22.5792*4 MHz in the PLL features table.
> >
> > 22.5792*4 MHz is one of the actual clock rates that we want and is
> > is available in the SDM table. Lower the minimum clock rate to 90 MHz
> > so that both rates in the SDM table can be used.
>
> So factor of 2 could be missed somewhere?

Not sure what you mean? This PLL only gives *4 and *1 outputs.

> >
> > Fixes: 7cae1e2b5544 ("clk: sunxi-ng: Add support for the A523/T527 CCU =
PLLs")
> > Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> Best regards,
> Jernej
>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi=
-ng/ccu-sun55i-a523.c
> > index acb532f8361b..20dad06b37ca 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> > @@ -300,7 +300,7 @@ static struct ccu_nm pll_audio0_4x_clk =3D {
> >       .m              =3D _SUNXI_CCU_DIV(16, 6),
> >       .sdm            =3D _SUNXI_CCU_SDM(pll_audio0_sdm_table, BIT(24),
> >                                        0x178, BIT(31)),
> > -     .min_rate       =3D 180000000U,
> > +     .min_rate       =3D 90000000U,
> >       .max_rate       =3D 3000000000U,
> >       .common         =3D {
> >               .reg            =3D 0x078,
> >
>
>
>
>

