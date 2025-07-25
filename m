Return-Path: <linux-kernel+bounces-745267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A0B11779
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2B3AC87B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985DD23E320;
	Fri, 25 Jul 2025 04:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWhTHaP/"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E23594E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418108; cv=none; b=SdG+hSRmAVaajVuprUaGpJPLiNDFaGx57wGuRQ4sAbMe+gv2e3zFMuwIFxRxDRgYMcIIs+Jac0I4Tp4KLl9JoirjrBztYB+nZLX0GYhxjDE72LPti3Tr8vuHyKIYOTDnxCw772jBfZGMsLpHfQHC58/ivGUx7WUCpVtuv/AAXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418108; c=relaxed/simple;
	bh=QgL4dd5Vz7uJ6t2HYw0hKjGiE8pdrDFtByWDT0GxhyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLG5jbAzeS3oiOjEw7NKng7JNMiK+pWG/SFRm6l+iSngwi3pVnVTGWaBxhopNEOZf+C38zdicutZXbHjnKyg3Z+jV6SAhgOM0aJNaIrwa9IFisGypDjBN2bv5MyKmv7XvDzlyrEl9OS0oyidbFSSOGDp7051sKHm5cMsEj+yzIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zWhTHaP/; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-718425f1172so18509467b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753418105; x=1754022905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI39K57CdQ86d6d0aFYHUvCEXJfJb9qVK/y2Z3jHq6o=;
        b=zWhTHaP/vn/+CJ9c0IdQsLjQg8gU8fJHCkhSOQeHqpk+LaUcrzWQ/2mzINwEVMD83B
         bGk3jckLpxXotxeGW7D3xF3/w/Sp1UiZRv/DWs/AoHOrrEdd8LjyzLaYuYykC7UuhXBH
         5Gm/+C1Jb9XUsgyP/Lq+aYVY1Z1ciHXKX+CupX/PyJ6Tn28Ehw0AxY0/23bKOaemWiBt
         i5m6OFHXh7GcEPChkDpWExB1jtfbm0/WH3XkhiisEFsjlVeIMJnQSqMjyShF7VV7FDzq
         h+l1XlER+5hTvUW65pQ0KE04YltYA5NqBXLUTKohZB29s4Qyoxa7QFPWRB1zcTSL30t8
         hj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753418105; x=1754022905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VI39K57CdQ86d6d0aFYHUvCEXJfJb9qVK/y2Z3jHq6o=;
        b=IwkxuLg8XU4zcmf7iDIlhGLGkYsJA3iWuR3Z5tgTseFm+Gz8KOQrxp1qpx2ej1WTOn
         QCrWMvWp+plTLdN7ST8hYI/G8vgFhVks3L+8oIyCRSII+kJjTjSfK+ld6G7GRvrkRWXx
         8meawZzkUbL+u8incqoKXUenZtkGgfTe+sgD5I5R56hZQU08yNo+eqFotBboXyf3Zq4t
         F2Sgf1kSJIp7xNbhsF2m0B22FIU8wuGGpT+rdWi5fvdmElJmaH2akEbvAtBuvov12/68
         bm6w7kX5n3FteFZQVzpkq7sm00FgJaar0gtfBbh0XJa21YLTpgcPwEFwD4Pvb8tMFasX
         r2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX2S//2oQQmWD4z9cW5N5ibr1WmGxF4upojjO9r54rr+Qyed7ou2IM0ZxYVWj+SdsyRhzUNuTVI1tNSVMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhvs8jfxQs2WLXgM0paCpCTlHAYkSq/2WC4omob3UADbrWfK29
	WrXDcuQwT2REpcTi6HjW/Eek6+XVNv1wvmlFTLsbCRFgEoCIv9zHgihFd4LLpgDvB7GF627kbMh
	LMXy9SPYdz58PDH2ospn+2qnKj1AEbrR4c7S284+tsg==
X-Gm-Gg: ASbGncs5Fobp0sObzMXJ/PO6RR/s8XL+a2qJ0Ai6DM2Ea/qOpbLGrWUdvQ160IK2HDw
	lYnA+p7zkCFa6B3HezTYlG4wNlif69gTtsM8eSjpTDoEUbOzUKd1B8XRWexRFwucEr62Q2CHthN
	inyAdH5ORB3syaFONL+9JkNYq5dMjxgFtR/JoSOeVVhN2sfiiLjwwHH7w2q5sJeDY/aY3wiGCei
	o5S/fc=
X-Google-Smtp-Source: AGHT+IFJ9XzJp6Xgxj0QLlNaKvOqYQXU71T6tCJTyQCg4SCr1RJUJwWNJFlJ0weWOTfAVwxY6VMJ4E1O+l5CAaib/pU=
X-Received: by 2002:a05:690c:60c5:b0:702:52af:7168 with SMTP id
 00721157ae682-719e37735b4mr7086307b3.2.1753418105293; Thu, 24 Jul 2025
 21:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org> <20250724111345.47889-7-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250724111345.47889-7-krzysztof.kozlowski@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 24 Jul 2025 23:34:54 -0500
X-Gm-Features: Ac12FXznxCvoXznkWVOuS7v8nJpWf44pmIfF2zVk3lxzJ_JMee-Hqsv_4Ncl66s
Message-ID: <CAPLW+4=XmFYvD1tmXXX53ORHp-Ued3_tCZoFCi=ch35aBuYO5Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: iio: adc: samsung,exynos-adc: Use
 correct IRQ level in example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lucas Stankus <lucas.p.stankus@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Dan Robertson <dan@dlrobertson.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Dragos Bogdan <dragos.bogdan@analog.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
	Alexandru Tachici <alexandru.tachici@analog.com>, Stefan Popa <stefan.popa@analog.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Stephan Gerhold <stephan@gerhold.net>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Alexandru Lazar <alazar@startmail.com>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, 
	Angelo Compagnucci <angelo.compagnucci@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>, 
	David Heidelberg <david@ixit.cz>, Manivannan Sadhasivam <mani@kernel.org>, 
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 6:14=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The interrupt line to GIC is IRQ_TYPE_LEVEL_HIGH, so use that instead of
> "none".  Also replace the hard-coded GIC_SPI flag.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml    | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc=
.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> index 4e40f6bed5db..8069e99ddac8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> @@ -128,10 +128,12 @@ allOf:
>
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
>      adc: adc@12d10000 {
>          compatible =3D "samsung,exynos-adc-v1";
>          reg =3D <0x12d10000 0x100>;
> -        interrupts =3D <0 106 0>;
> +        interrupts =3D <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>          #io-channel-cells =3D <1>;
>
>          clocks =3D <&clock 303>;
> @@ -152,11 +154,12 @@ examples:
>
>    - |
>      #include <dt-bindings/clock/exynos3250.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>
>      adc@126c0000 {
>          compatible =3D "samsung,exynos3250-adc";
>          reg =3D <0x126c0000 0x100>;
> -        interrupts =3D <0 137 0>;
> +        interrupts =3D <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
>          #io-channel-cells =3D <1>;
>
>          clocks =3D <&cmu CLK_TSADC>,
> --
> 2.48.1
>
>

