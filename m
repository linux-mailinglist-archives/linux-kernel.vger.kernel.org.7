Return-Path: <linux-kernel+bounces-745752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575EDB11DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463F17B89EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530DD2E5B20;
	Fri, 25 Jul 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fgdM9e67"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A847242922
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444300; cv=none; b=s0h/PfIeDFl8jprjSY8MLiNBhP4JPi9A6OuX6UeWcSPCUX0z4O2K0NACWl4FVXCqL21wyRYidR9r665IvQyt7gr9DIiqyd5hFpozAkenoGsOdtsa5ePLW3dgsic8mKVpdS6T7IBVthnYDMDXnJ3cV5w6MpLpY0+HWM+t1khtXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444300; c=relaxed/simple;
	bh=7Lq+L8ybIKzJFE7aCP8K4OUgb0w5TEGi1D/8HV86VOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzi3/5C+m6xWLmFBJIhpniPiDaj/WBkRMDz9WU1GCmexACReQ9emUR/7dOrW7mwYh+868XvTl3d4vK+dN41tEZbUSFj0Tjmi1+sFDxaKAJNOVNZuYR5gn7X5jiXKJEHEjk9COT+cB2kWEcyirrgzA9XlWk+aD6sN+p1CZVWZXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fgdM9e67; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7df981428abso308071385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753444298; x=1754049098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hJBa13s79OQWhYLxMwSe1UwJVG9FUdchi7fOARwLxY=;
        b=fgdM9e67/suj8hgpbK6oserOOFE4r+XjXW51jUtGx1Yx92ki/tLFoLL/yg5TrTzA4j
         rImWOU/ebixcmaUnQcJtIViFDZka7V7azek+gW3azkf7B19uH8P1P/2h9PYeDYCbCtK3
         t1MPWIZ++q6SXoGL9lEcu1eLraakcs+5UO0Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444298; x=1754049098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hJBa13s79OQWhYLxMwSe1UwJVG9FUdchi7fOARwLxY=;
        b=bcboxcCeNqRbq7I4VbG4jWl8TcYRyYj0FDIa5vrG+jmw73cnjW2telgPBdoPW9etbH
         nIxGdwzekncxzTIF30reg23zXJCTbWJ3AImALDefJI2DH4jlwH1X8imek5//KHAfcKbv
         NiPHmm/WqbMhqOGxwFYBDy33KPLywb7cTc11utJMXWpXWFOnqIdXHieZLoEYL0/oAbNC
         6RJcj99kPvmjk77/+6cYGjAXWlyHhFvowRa89s8E9n2hBbap3vqV/NouXwSHeyFvDa+9
         Xi7t8UN6Acrl3tCroFo5rZ28UULqRYxYSoBVdF/Uim0aw+eBYYVOBKozOSp/7sIjSp3N
         f8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU0itcn3isHkTcQL++RxT3Q/trAWr27K7SvxCaBirZW6MEUUYpVYI/RNsoruvgH3N4GjajLZyAXKvQ8yKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxaPCqgVC1wWUf9+92h+4YcHRpx9Qw/jVdPzjcZyG933vvW3tW
	oVzam5hk1kLLJDy4SDm0YDJGXg7uk8YQnJOEbu7hzVmd6nHNY5ylDyZcE5ruifRinkRKTisQC5l
	j6nw=
X-Gm-Gg: ASbGncsoHT9uvuto+FvaahZulI57eijdC/tmC7ei+jYeSDjMDpLvfWjjSW5WpLoDe33
	KrXCBQQ2RYaqAcmBsy3pLdk2GoQPJqiqUp/lp66QwJDtntbuxrCFph9b+LDguUUSXgaMUsTA8vP
	r86Jswr48r+Byc4zUQHLXiqXoEsT4FkPC7nldCxT2S+9krKQJk6r4ecIYO6E/v9Qam8boFJ61k3
	pL/DFQQ1mvt+Q+XRkG3sqpYKYj1I9cwiBnazFWa3Ly98/kYPgbgBbFTM/W0HfIgO26iDHr4omVI
	4g+pg8XtXSu3Fvp56kp+h+m/cIGcknKfWB041cEaw18357QZ1LrwVhrWhQG0GXB1+RMEVVTw202
	OUukVvXze6+Na4+3TKgk3sDufxsEDd2ODbc+fkPnYUmidvYW8IAAej2mZvzCt53KRiUgv
X-Google-Smtp-Source: AGHT+IEjdKehsiPu+IpzTd0HhPFfjDS4Fn5ux6CQ8gLazXb9HmbQD+j9CblLJbAMWeIboyVkQRQY3w==
X-Received: by 2002:a05:620a:4ac8:b0:7e3:3a5f:8dac with SMTP id af79cd13be357-7e63c1b7577mr130743385a.49.1753444297790;
        Fri, 25 Jul 2025 04:51:37 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632d50374sm238473885a.3.2025.07.25.04.51.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:51:37 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7072628404dso2030826d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:51:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJFCdI0qd5+iJCzNlMtpyMcTpsS3qbu+Z+j55F9Beyv6l6zD9VEUl1N9zgsA6JHm4JSfxMeaEEqDlwZtM=@vger.kernel.org
X-Received: by 2002:a05:6102:6891:b0:4dd:b82d:e0de with SMTP id
 ada2fe7eead31-4fa3ff44195mr316348137.17.1753440787376; Fri, 25 Jul 2025
 03:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-20-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-20-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:52:31 +0800
X-Gmail-Original-Message-ID: <CAC=S1nguRWyG3ubmSFE95_zgsCjjq4dxGWr5ErV9-Yu2+mTmpw@mail.gmail.com>
X-Gm-Features: Ac12FXzhNEGCOc6TL2wVpoG5kEXhC599YdNWu941VvXlO0dL7_W9Jc4if8EyMHA
Message-ID: <CAC=S1nguRWyG3ubmSFE95_zgsCjjq4dxGWr5ErV9-Yu2+mTmpw@mail.gmail.com>
Subject: Re: [PATCH 19/38] arm64: dts: mediatek: mt6795: Add mediatek,infracfg
 to iommu node
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

On Thu, Jul 24, 2025 at 5:49=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The "M4U" IOMMU requires a handle to the infracfg to switch to
> the 4gb/pae addressing mode: add it.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt6795.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6795.dtsi
> index e5e269a660b1..38f65aad2802 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> @@ -427,6 +427,7 @@ iommu: iommu@10205000 {
>                         clocks =3D <&infracfg CLK_INFRA_M4U>;
>                         clock-names =3D "bclk";
>                         interrupts =3D <GIC_SPI 146 IRQ_TYPE_LEVEL_LOW>;
> +                       mediatek,infracfg =3D <&infracfg>;
>                         mediatek,larbs =3D <&larb0 &larb1 &larb2 &larb3>;
>                         power-domains =3D <&spm MT6795_POWER_DOMAIN_MM>;
>                         #iommu-cells =3D <1>;
> --
> 2.50.1
>
>

