Return-Path: <linux-kernel+bounces-774875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CCB2B8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB005248CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BD930FF1E;
	Tue, 19 Aug 2025 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QCNFgav8"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628430F54D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581399; cv=none; b=N7p5cMzcbhJPsZJk1KwWr3OuET5z6Wqnb0YRCW6HK40BnETRSWELLp9VrkCw1JBxgxNhG6581yON3/XHAbG0ZTDrE20iyJlLoULC2u7PEVP0embCdyO9F65fmF2ktiZo+/w/K/by+tuxus6tYPCm8D9abhdqwQpRiHsR1soQ5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581399; c=relaxed/simple;
	bh=Hiaw+1vru5Gp5FXyAQ8mi6lZwyqhH7knrQYR8u+n6YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2fiZekCWNvqj1neHmJFPBLpyaWimj8lJKw+DbvX7fODdKRooDjTWNaoaNrpKBlPDETC3e5QbIMqsOu8LCho/PODwQ5D2Z8G2V5kDV4GIPDdASQmnyscvra0sd9wAhePCjA3PLS8HtFp4XRT4DrrtvthVN90SaEaJ0T7kDQZRfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QCNFgav8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55ce5243f6dso5302006e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755581395; x=1756186195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY416xR1xycZgMaHjJKQxeOxL60iUIwXBSq8Px9VqF4=;
        b=QCNFgav8kfxSctfpXma/aYgM0IhSUJKWUSJwEbya9vLyXC183syObGesgfv/JxAjH/
         /rhSTHh8E3nsBWeitN1hDAOLSW7POKYGwmalJNrBk9w+ddCUUHFbuABTcDAkGxLjHbYL
         UQjxjvTNaohIoY7C6QTvSnXRHXEi2BXTPg0sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581395; x=1756186195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY416xR1xycZgMaHjJKQxeOxL60iUIwXBSq8Px9VqF4=;
        b=Z8MvuY+mAcufckjWMm4rT+C8wJ8riv/d+01ya2aK/uRmxw/lSo7WCz2GsWaQf5g/m/
         5TFs+v4l6gPH0AB9bnnN4Al+2uZYORziUKxJqvKPxGFgDUVzFQcZ7+cVCvKZbQ7/mhw8
         aKoG2C6o2QXryu8dVEfPnFoppSbagUf+8NlQrTUqeQM3BwIZkelBsWeleRHiyq/P9BiE
         AI+nz0u3slHfA0z6tF4DxYlmhNsObEnd0MK8xqesakmToUeSUBr3K/5sbavWBN+hXyjW
         G1w3KxaDo7+qc9O1hXHG4S+nPw8dz6F75cldRNfrJOhYFzGt2UdwBGtrx8hDPIS4suvz
         C6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWxt4nEeWRfEyeB34Y0YEy8+44QInpjKsoZzLrt3qhXgDI1LShgnzSJJDZz4aLxgow1/DLiucw9A5Nd230=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/K8iKhix6JRwHc5y75HEWeLCld4NI53VDdw0wUiIyR85z7KB
	kuL9cyqPhrxyRYi6S+y+gviMInbuqnYim6SAkpUxr/sDuo6cqIma7OPiuemt7uQ0ZjsuzW6UKHH
	w+2pBUHitrvONdPZs6+Tswfsq1KXOUHOsd7bB+0m3
X-Gm-Gg: ASbGncuAgEGuKAZIDbGxNcKzoFaKMkPY9TAbbYQxq73moOxuhn93ph4JbLrv8wnt6jD
	if9IXnuDrYayM/MdvcorIAW+599Cz+AW9DnPyH1qoYpnMAKUqHUvjXCQKwTQpbnZQKjQnfENj7h
	/nwk4vc+cd5IzJWgp6t6MpxwDrOe4WEcRl9mx3je9P9qkHsVREmlQ4U1NzqvnFQml75U5EtAyCc
	D+9zVAbAGe0efhQW0sJQiszbdU+Pp5nbU0=
X-Google-Smtp-Source: AGHT+IFc+cNqQJD94yOsJXvxKRjOpffc7Ia22z42Fq9ZyFSlD4taXbrHvujNSr7HuBf9iSSI7SrVxD3w4KS0qImpweY=
X-Received: by 2002:a05:6512:3f14:b0:55c:cc6a:a212 with SMTP id
 2adb3069b0e04-55e008451ebmr402983e87.39.1755581395466; Mon, 18 Aug 2025
 22:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-mtk-dtb-warnings-v1-0-6ba4e432427b@collabora.com>
 <20250801-mtk-dtb-warnings-v1-8-6ba4e432427b@collabora.com>
 <CAGXv+5EHk=f62+KiLo-aWMcd0-q+_59kno+uOW5rdYaq5q+5tQ@mail.gmail.com>
 <CACRpkdbWctNH0XJfcHfVJM9Etp0WCXpdyhhyaQemH-Xc0LDr0A@mail.gmail.com> <CAGXv+5ECsP7_wbdcaAkWuD=RyJiJpPe4r60bhD5U8xUvEBzmXw@mail.gmail.com>
In-Reply-To: <CAGXv+5ECsP7_wbdcaAkWuD=RyJiJpPe4r60bhD5U8xUvEBzmXw@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 19 Aug 2025 13:29:44 +0800
X-Gm-Features: Ac12FXx-vk1JhaQ3rCWpmDReEnhaHNW7M5aboaWtjp9aXHyjGH_2VPoF2xHclbY
Message-ID: <CAGXv+5FXZ_byK8Ftb9LjfQMkgtLd7mTmWgz_Nsvcv8=jy53T=g@mail.gmail.com>
Subject: Re: [PATCH 8/9] arm64: dts: mediatek: mt8183-kukui: Fix
 pull-down/up-adv values
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ikjoon Jang <ikjn@chromium.org>, 
	Enric Balletbo i Serra <eballetbo@kernel.org>, Weiyi Lu <weiyi.lu@mediatek.com>, 
	Eugen Hristev <eugen.hristev@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Julien Massot <jmassot@collabora.com>, 
	Sean Wang <sean.wang@kernel.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:27=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Mon, Aug 18, 2025 at 11:22=E2=80=AFPM Linus Walleij <linus.walleij@lin=
aro.org> wrote:
> >
> > On Wed, Aug 6, 2025 at 8:38=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org=
> wrote:
> > > On Fri, Aug 1, 2025 at 7:18=E2=80=AFPM Julien Massot wrote
> >
> > > >                 pins-clk {
> > > >                         pinmux =3D <PINMUX_GPIO124__FUNC_MSDC0_CLK>=
;
> > > >                         drive-strength =3D <MTK_DRIVE_14mA>;
> > > > -                       mediatek,pull-down-adv =3D <10>;
> > > > +                       mediatek,pull-down-adv =3D <2>;
> > >
> > >         bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> > >
> > > and so on.
> > >
> > > ChenYu
> >
> > I agree with ChenYu, the more standardized properties are the better it=
 is.
> >
> > All the custom properties makes sense for an engineer working with just
> > that one SoC (like the SoC vendor...) but for field engineers who have
> > to use different SoCs every day this is just a big mess for the mind.
> >
> > The standard properties are clear, concise and tell you exactly what
> > they are about.
> >
> > The argument should be in Ohms though, according to the standard
> > bindings, but maybe the value of MTK_PUPD_SET_R1R0_10 is
> > something like that?
>
> For reasons I can't recall clearly these are just placeholder values
> that the driver then maps to the R1 and R0 settings. But at least they
> use the standard properties.
>
> The reason was either one of the following or both:
>
>   a. not every group of pins had the same resistance values for R1 & R0
>   b. there are no known precise values; the values depend on the process
>      and batch

Also, their customers seemed more accustomed to dealing with toggling
R1 & R0 vs setting some actual value. I presume that comes with the
uncertainty of the actual hardware value, and they just try which
combination works better.

ChenYu

