Return-Path: <linux-kernel+bounces-745758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA4B11E05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B180584B61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1C413C816;
	Fri, 25 Jul 2025 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JN9J7vQm"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2224338F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444811; cv=none; b=RG71DciD8Wijh5tQp91LMEZ4grgoUNXpOuX0gg6m3Yn/+NefPI2E9lP1VrDp9YHZvREVxVbiuRLDx21/af0V8DFadnlAoh1P+lnE3Qj+lYXWWPi03SA+Dkt1gtQett6DqDCmOgofGntZz0XxnVApqeBO3s+lFG9WxUjnqWAYezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444811; c=relaxed/simple;
	bh=/FWxLS8hqus1+HRqR+NgfMdxvAEHUA0sDpoYtqNCdMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaZtn+ajXkbTdKVCFItyWrIvqh4o6C5gWcyQtn32iC0rRHipGfF4WyXwghr6OReP/0KJ70NKUryahyThvP7POrWctDAJeT/9czpPouO1qoaXoMnB5zF5MC58AX5VwenPNEiQqS/8vgeG+1t45SRyRmgPl7T7C1sS5wq5naaZ7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JN9J7vQm; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2ffb85aed35so1582936fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753444809; x=1754049609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mqK1RSBPE9C31GyE2vJbWJ8NDfAV+1bNXjXR8+rtBo=;
        b=JN9J7vQmV7AW0hSHYlYQYu0MAWpJuQuP9cwD8lO68AvFbRgMTQS1FmfupYLeIewcB8
         A1Rh9RmbDOWq+F9c+96bg6aapwYHFi8qG9L2e0n7TmOtoNhV6qCMYPaDORBFg6x6Xugy
         lryrgFvjREPWUW3XIF7oqtrlm8SvECvUANREg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444809; x=1754049609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mqK1RSBPE9C31GyE2vJbWJ8NDfAV+1bNXjXR8+rtBo=;
        b=r2y5PbjjmOVLeSS2y69N2y7tEGuaRHNyI8+qXmRFsY1xovYcTqVKOQYAARMJIX9uSy
         RsGQ6SroXARscjCfLfhIz8nUX1AX8mMH2smeWUj6OxbWSJp3d2ybcgID0qKt3uOwTRVH
         rPLKGQMz0l40S1fooOePGn6M72YDVUOWErjJTXMy5eWq8F8bizbGfWIBg9futc+i90X5
         s2Y6Vsbv7I6MgxH/VAXU+8sx/QfXOnqr4xBs9miGAhGM5x5tCiZMocEDCvUm55g0tj3M
         LhGtnv6ljscVdNJEkwrZ5NXF8AQLkc5qjhNS0rRNyerVSK7e+MEzqu6XnyM/6wvTvRtf
         oaGg==
X-Forwarded-Encrypted: i=1; AJvYcCUWE7sEoiIUmFxVJFd7PZh1o0SQ3pReGtkPPdSGQfA4ggr5YX2H9dcLE+Tkg/V5/N0Q4x6IjjfPAxJ42ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzICZC3s9xbK1tf8/v6MWUF1kUAKzdY16puWyO47OtPpW1Mgf/2
	2cDDnWHI3BDaQYtIxr1jnFTkzk07ceMTn7+cRExJwEqQIXo3RwqxVnguNy2AVYYaz7L0Yrhy7Ac
	Ch/E=
X-Gm-Gg: ASbGnctC2604f4VBND+RwJY7SNZtREsps5Y2MCNDCAB5Mn23QlAC/Il4ZQFZ/r1/E6H
	frxf8QnO0/MecBV5wio7G53QLZTkA4qUk7QYybGGjOrJeX+d3NgThi+haIKIbAcCUhh/qRBUOOj
	YAnlaG/yB0eW2jsfDcHAARS+9iA0SOLi4IR5dMyA5mUzrzxwhrlRwW5CqOzjaFCuMD6RLx1Synn
	uy02q8R/fSbXVTgftplG0rf6dkAcRP9lIpQXFke/9B3wwlGIBKUYCn610VgVjM7J4Z/J5uAmxJw
	r0hXwiivOa6NaIQZJmu0a7hAVax2pBs2dFZgQvTNpS1vf6WD01DHwwN4Ek1h5r7QU4ul3tT1xpP
	fRRhSTjYUqR7voEkBvA6cQNKVq04m5boo+2VcCbS5q3XJdojVp9I09syv1Q==
X-Google-Smtp-Source: AGHT+IEK5p7bN/0laUUMhOCjvTUBsf6w/HlxJWGy8aHVNFGvHl/FAnjOQ/nm2fTMHD53PkbfTsMQFw==
X-Received: by 2002:a05:6871:cc89:b0:2b3:55b3:e38 with SMTP id 586e51a60fabf-30701ef8406mr838006fac.21.1753444808512;
        Fri, 25 Jul 2025 05:00:08 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-306e1c06c44sm1035482fac.5.2025.07.25.05.00.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:00:08 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73e62d692fbso1244977a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:00:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVN95zcNTFIaincEaoj5iIZ0cR3Y3w3DwIb3vZLdyfBTuhqHhf2vuC6Vf2spzbSmMVK89f4DkdlAJLzCEA=@vger.kernel.org
X-Received: by 2002:a05:6102:5a92:b0:4eb:502c:569a with SMTP id
 ada2fe7eead31-4fa3fb3f3f9mr285813137.9.1753440864290; Fri, 25 Jul 2025
 03:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-19-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-19-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:53:47 +0800
X-Gmail-Original-Message-ID: <CAC=S1njpbfARTSBwddCeeO+c0vvf=GVaD6+QhauJOki0NS9dTQ@mail.gmail.com>
X-Gm-Features: Ac12FXy3jzZS4uZ6X5J7uIwzpvgV1oXiUrEGuonvNPTbsP1Oacxt9m6NF-3FvZA
Message-ID: <CAC=S1njpbfARTSBwddCeeO+c0vvf=GVaD6+QhauJOki0NS9dTQ@mail.gmail.com>
Subject: Re: [PATCH 18/38] arm64: dts: mediatek: mt6797: Remove bogus id
 property in i2c nodes
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, 
	daniel.lezcano@linaro.org, mwalle@kernel.org, devicetree@vger.kernel.org, 
	linus.walleij@linaro.org, linux-remoteproc@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	olivia.wen@mediatek.com, shane.chien@mediatek.com, linux-gpio@vger.kernel.org, 
	linux-phy@lists.infradead.org, airlied@gmail.com, simona@ffwll.ch, 
	herbert@gondor.apana.org.au, jassisinghbrar@gmail.com, jiaxin.yu@mediatek.com, 
	andy.teng@mediatek.com, chunfeng.yun@mediatek.com, jieyy.yang@mediatek.com, 
	chunkuang.hu@kernel.org, conor+dt@kernel.org, jitao.shi@mediatek.com, 
	p.zabel@pengutronix.de, arnd@arndb.de, kishon@kernel.org, 
	kyrie.wu@mediatek.corp-partner.google.com, maarten.lankhorst@linux.intel.com, 
	tinghan.shen@mediatek.com, mripard@kernel.org, ck.hu@mediatek.com, 
	broonie@kernel.org, eugen.hristev@linaro.org, houlong.wei@mediatek.com, 
	matthias.bgg@gmail.com, tglx@linutronix.de, mchehab@kernel.org, 
	linux-arm-kernel@lists.infradead.org, granquet@baylibre.com, 
	sam.shih@mediatek.com, mathieu.poirier@linaro.org, fparent@baylibre.com, 
	andersson@kernel.org, sean.wang@kernel.org, linux-sound@vger.kernel.org, 
	lgirdwood@gmail.com, vkoul@kernel.org, linux-crypto@vger.kernel.org, 
	tzimmermann@suse.de, atenart@kernel.org, krzk+dt@kernel.org, 
	linux-media@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 5:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> All of the I2C nodes in this devicetree has a bogus "id" property,
> which was probably specifying the I2C bus number.
>
> This property was never parsed and never used - and besides, it
> also gives dtbs_check warnings: remove it from all i2c nodes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt6797.dtsi | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6797.dtsi
> index be401617dfd8..f2d93bf6a055 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> @@ -285,7 +285,6 @@ uart3: serial@11005000 {
>         i2c0: i2c@11007000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <0>;
>                 reg =3D <0 0x11007000 0 0x1000>,
>                       <0 0x11000100 0 0x80>;
>                 interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
> @@ -301,7 +300,6 @@ i2c0: i2c@11007000 {
>         i2c1: i2c@11008000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <1>;
>                 reg =3D <0 0x11008000 0 0x1000>,
>                       <0 0x11000180 0 0x80>;
>                 interrupts =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
> @@ -317,7 +315,6 @@ i2c1: i2c@11008000 {
>         i2c8: i2c@11009000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <8>;
>                 reg =3D <0 0x11009000 0 0x1000>,
>                       <0 0x11000200 0 0x80>;
>                 interrupts =3D <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
> @@ -334,7 +331,6 @@ i2c8: i2c@11009000 {
>         i2c9: i2c@1100d000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <9>;
>                 reg =3D <0 0x1100d000 0 0x1000>,
>                       <0 0x11000280 0 0x80>;
>                 interrupts =3D <GIC_SPI 87 IRQ_TYPE_LEVEL_LOW>;
> @@ -351,7 +347,6 @@ i2c9: i2c@1100d000 {
>         i2c6: i2c@1100e000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <6>;
>                 reg =3D <0 0x1100e000 0 0x1000>,
>                       <0 0x11000500 0 0x80>;
>                 interrupts =3D <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> @@ -367,7 +362,6 @@ i2c6: i2c@1100e000 {
>         i2c7: i2c@11010000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <7>;
>                 reg =3D <0 0x11010000 0 0x1000>,
>                       <0 0x11000580 0 0x80>;
>                 interrupts =3D <GIC_SPI 89 IRQ_TYPE_LEVEL_LOW>;
> @@ -383,7 +377,6 @@ i2c7: i2c@11010000 {
>         i2c4: i2c@11011000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <4>;
>                 reg =3D <0 0x11011000 0 0x1000>,
>                       <0 0x11000300 0 0x80>;
>                 interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
> @@ -399,7 +392,6 @@ i2c4: i2c@11011000 {
>         i2c2: i2c@11013000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <2>;
>                 reg =3D <0 0x11013000 0 0x1000>,
>                       <0 0x11000400 0 0x80>;
>                 interrupts =3D <GIC_SPI 95 IRQ_TYPE_LEVEL_LOW>;
> @@ -416,7 +408,6 @@ i2c2: i2c@11013000 {
>         i2c3: i2c@11014000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <3>;
>                 reg =3D <0 0x11014000 0 0x1000>,
>                       <0 0x11000480 0 0x80>;
>                 interrupts =3D <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
> @@ -433,7 +424,6 @@ i2c3: i2c@11014000 {
>         i2c5: i2c@1101c000 {
>                 compatible =3D "mediatek,mt6797-i2c",
>                              "mediatek,mt6577-i2c";
> -               id =3D <5>;
>                 reg =3D <0 0x1101c000 0 0x1000>,
>                       <0 0x11000380 0 0x80>;
>                 interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
> --
> 2.50.1
>
>

