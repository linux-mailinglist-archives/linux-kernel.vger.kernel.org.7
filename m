Return-Path: <linux-kernel+bounces-745751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03823B11DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9DFB7B85A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F5F2E6D1C;
	Fri, 25 Jul 2025 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OHTdkFav"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750214E2F2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444203; cv=none; b=Pp5Oaco7g8YQKLKg9pQqFqAzqVH8Q0ec6fVgBqKrOd3ATWyJ6mI/VMNM/G355J/CMtjDN9+u60CLmp/Gjr509chYAtxBcRJGUT/w/f3WqSG/AjgNnUiGb1FuIqyv4BaUoNR1gvyIO1E4gkpcGbk6aUV0x9XxP4xfq8Hmrel3yas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444203; c=relaxed/simple;
	bh=wuFFxAizy2X1aAZ/SF2x06cfnVSKnpsKMko3UN4we2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abast3t4hOydSOezSjXptg7PsJteDQw5Qw+bqy4p6WsWNzDtvX7GXH1ho0LIV/JzE4v7Sg8vQTtQPlrBA0ilxVyr/4WUJfUYu1txsyT5lOA4dXmJe2YDUwPloS1Kc1EKwaePxAvFyKfuFRoLh7Q77z57x+fhOSaDJY0VBQTZjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OHTdkFav; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab5953f5dcso19642351cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753444200; x=1754049000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaRYlYWMnL5FdToAvFBY21N9TEhebXI6JAmJStjizl0=;
        b=OHTdkFavfuX+82S0t0H8m9CHmD/b0R6e66PThq7OrfO54C6KGV1Gf35V+fTzkFqb+u
         grG0vXEJzWbF07pEmobBEF6PuD5oPTXroGRG6pjxmFbhQ3OiSJ9ZrzBpGUjwC+SsEYCi
         5+fyJtid0yuEUo4p8HnLyl+Q5CbOfPcZEXcVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444200; x=1754049000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaRYlYWMnL5FdToAvFBY21N9TEhebXI6JAmJStjizl0=;
        b=BHCkcuzZ2ai0sTewSE44dNSJyFo3bkSgRMgsD9HnU9CGrXLyUo53DQXQNvc77B/9U5
         ZUtc7XS8s1ZHV1DgYS25GVo/cw2q1Z/NWqtU6KxEv8XBhp/dXtFLFbKCobGlO9ukmJBV
         hySjt1Vor0x/LLUrqDkbKfPLxXigY4hiNi5Np5tv5nmw4hfoZsj4NZM1P7PmcuSPG7Oz
         Y22rtIaYfQvSkhr8Q5DYggvbGIADkqIkWi8n9VTAdWEi1/7Fw3O3HETen3J4QDz4P12p
         1SguPDhct1ewco6nh0BCvvL3VAZlcsSE4czXWW3wQPvueBxKJhDo1Vy5Mo37YPlRJMMA
         lOJw==
X-Forwarded-Encrypted: i=1; AJvYcCVFTFi4WF4rVF76grTbNyN1bQIqAhCW9hTF18PLCMaZV8JVUD7NgTUtmBzIQSV+uOCSMXBC0RjUAi7U1eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypfmbZHv+peSXs2qvJr194BnOHq5u91lnnK1G/2Qk0dCJIcWPV
	qQNCF4fRyQq63QxFRSCaeW9tLlKXrOOkrQ49PbVIOPvpeZgDqzmdjKuyO6fmwdNoIhrpwhuouZY
	wdqkHbQ==
X-Gm-Gg: ASbGncudOZDac6uRLqbotLj/q2ztPhUmZrpDQEIiU6Ni9rCGPmAvUs/Y7UmfebtgAdF
	x9MNL1azFFcRi92xXw+ItOBEEaXzIt/0f2kAlG6KppWmP5sMAUThNKjbzW7dN9BdZ4oLeXBCFjY
	Pz/bLSUn/evK8NhaVm9d6Q4o1VtGnAGvOLt0R6Lj58VGlpqSN3uj+sJu5q6rg0KIneZu3RyCdfr
	PrlhbNFdx2Y2o+yv6E3KBVK6CcXsAYCGUdS4U789+wdwhVx+GTL00nhZTVg9FH3cLGdf8C4gR03
	aUhiNiW00VVln1vAR+GTrTiDvpXtZG7mkzJ1lBNvwvzPVV2f9U1dWx4ao77aaNXc3EF7n0jl9Sx
	/hvqqai2bg2yhyaiJ7C4LxUq/BRRqm5ZE3qT2lh3BjIy+znr5CyY77dZU21nDfA==
X-Google-Smtp-Source: AGHT+IEFuS92lxeJqtJpRpWYQ87UDmReGlJnrhrfu59RuCGITnuZfiGVb2FnWCbteV3+7aJuhP3WBA==
X-Received: by 2002:a05:622a:4cc:b0:4ae:6b1d:ee29 with SMTP id d75a77b69052e-4ae8ef9ab9fmr17726731cf.13.1753444200211;
        Fri, 25 Jul 2025 04:50:00 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae7e2c8d74sm22960771cf.2.2025.07.25.04.50.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:50:00 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e62a1cbf83so192698185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4f7VIME1f3xH1dUnfCfKBiFFM2gLRdJvd7VnQtkbM4jEdmJnXzL+5F1oUJeRIhjjYXCdNJ9mfAZe2Xn8=@vger.kernel.org
X-Received: by 2002:a05:6102:cce:b0:4e6:4e64:baeb with SMTP id
 ada2fe7eead31-4fa3ff55fbamr323634137.17.1753441040390; Fri, 25 Jul 2025
 03:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-18-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-18-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:56:44 +0800
X-Gmail-Original-Message-ID: <CAC=S1nh5bF6kZe7TFA_EGPGt8Xp_rfuc-rkeXgjRCU=QEtZQiw@mail.gmail.com>
X-Gm-Features: Ac12FXw-hSTS0fHSbHXeHNK-nhzfyTLOXfpWf3gYQQXz8LA0IhEjugCIp682sPw
Message-ID: <CAC=S1nh5bF6kZe7TFA_EGPGt8Xp_rfuc-rkeXgjRCU=QEtZQiw@mail.gmail.com>
Subject: Re: [PATCH 17/38] arm64: dts: mediatek: mt6797: Fix pinctrl node names
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
> Change the pinctrl node names to adhere to the binding: the main
> nodes are now named like "uart0-pins" and the children "pins-bus".
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt6797.dtsi | 40 ++++++++++++------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6797.dtsi
> index 0e9d11b4585b..be401617dfd8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
> @@ -135,71 +135,71 @@ pio: pinctrl@10005000 {
>                 gpio-controller;
>                 #gpio-cells =3D <2>;
>
> -               uart0_pins_a: uart0 {
> -                       pins0 {
> +               uart0_pins_a: uart0-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO234__FUNC_UTXD0>,
>                                          <MT6797_GPIO235__FUNC_URXD0>;
>                         };
>                 };
>
> -               uart1_pins_a: uart1 {
> -                       pins1 {
> +               uart1_pins_a: uart1-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO232__FUNC_URXD1>,
>                                          <MT6797_GPIO233__FUNC_UTXD1>;
>                         };
>                 };
>
> -               i2c0_pins_a: i2c0 {
> -                       pins0 {
> +               i2c0_pins_a: i2c0-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO37__FUNC_SCL0_0>,
>                                          <MT6797_GPIO38__FUNC_SDA0_0>;
>                         };
>                 };
>
> -               i2c1_pins_a: i2c1 {
> -                       pins1 {
> +               i2c1_pins_a: i2c1-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO55__FUNC_SCL1_0>,
>                                          <MT6797_GPIO56__FUNC_SDA1_0>;
>                         };
>                 };
>
> -               i2c2_pins_a: i2c2 {
> -                       pins2 {
> +               i2c2_pins_a: i2c2-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO96__FUNC_SCL2_0>,
>                                          <MT6797_GPIO95__FUNC_SDA2_0>;
>                         };
>                 };
>
> -               i2c3_pins_a: i2c3 {
> -                       pins3 {
> +               i2c3_pins_a: i2c3-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO75__FUNC_SDA3_0>,
>                                          <MT6797_GPIO74__FUNC_SCL3_0>;
>                         };
>                 };
>
> -               i2c4_pins_a: i2c4 {
> -                       pins4 {
> +               i2c4_pins_a: i2c4-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO238__FUNC_SDA4_0>,
>                                          <MT6797_GPIO239__FUNC_SCL4_0>;
>                         };
>                 };
>
> -               i2c5_pins_a: i2c5 {
> -                       pins5 {
> +               i2c5_pins_a: i2c5-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO240__FUNC_SDA5_0>,
>                                          <MT6797_GPIO241__FUNC_SCL5_0>;
>                         };
>                 };
>
> -               i2c6_pins_a: i2c6 {
> -                       pins6 {
> +               i2c6_pins_a: i2c6-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO152__FUNC_SDA6_0>,
>                                          <MT6797_GPIO151__FUNC_SCL6_0>;
>                         };
>                 };
>
> -               i2c7_pins_a: i2c7 {
> -                       pins7 {
> +               i2c7_pins_a: i2c7-pins {
> +                       pins-bus {
>                                 pinmux =3D <MT6797_GPIO154__FUNC_SDA7_0>,
>                                          <MT6797_GPIO153__FUNC_SCL7_0>;
>                         };
> --
> 2.50.1
>
>

