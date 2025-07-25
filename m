Return-Path: <linux-kernel+bounces-745607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB411B11C24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21383B81F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D322D9EF8;
	Fri, 25 Jul 2025 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mwVXwIYT"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123432D94AB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438696; cv=none; b=BWQmigWSXlxeSydybPyptTQJPu53r2KWtZEANUflT88aTD0CmcbXledVh/pj+P4hCh+UUFQ0uYHCm6zCbYhAqS7Rc6KxA/Kz1OKkwLbp38bgmPoKB/dyW7Flav5oPMaeYNBuLCEAQVzUjkoV4oPWm4eUsoxxrcL4gg0OD/BE+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438696; c=relaxed/simple;
	bh=2XXVnmKfKOuWrZjQTjDdYxCXEPvU5YjHEeLez+QHVDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wi3ZSgcTQBAEvOXpx+lamfdJtKiLkpadymlZ+WkAjquaACsISqpzxrhiHy/rkJkwvyeOUClOGPYBItKxagdi2Cb89wDLtwAuzOduzxBjFJ+owbudVMdAcTnf1/F86IK8pm8ZUCRs9QhwVNAsRDl22arJJaqlTCEpz9Owqsz0rBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mwVXwIYT; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4f2f2f22c1aso1140255137.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753438694; x=1754043494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9CPe4n6W7cHa+GL0hIjIVMWtvIyx6LwWGjspV/N2Ok=;
        b=mwVXwIYTfSfVo8CJ1H3a68QRzCngDA76zmNtN8/yBQWboq1G84DT+G5sBf9Cbm0/pw
         oVlB4aR9yrEodIPE4z1kVMKuWat2WvdOgJKYypHNb+MrJgiKw6LDp/ZZ0mF6qvlg7i8I
         OYspRLpGiQpbBok2vqwLj4dITzRn4F1R20+Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438694; x=1754043494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9CPe4n6W7cHa+GL0hIjIVMWtvIyx6LwWGjspV/N2Ok=;
        b=kXQ2h6aQlecLq3AmLKpaj9Qx90xbR8W72JLZjUkzswxvk/9/FLbAhE0lJVlOiW2l4j
         cymSiOalvHaqqRbgafyVzwgWqPmvGlevtiDTFG9fU1f9ifEPz60ZYVpOjZr7seXuT3tf
         VAOxtURTYIOxHYY9M2nj/6iU9eDSH3+CesJIym84b47ORr65expyBO7yKpOBYbR4BbMH
         YYgizVq7l3cZMvNXUgY8+Ytd+ayfif4yS138sDuk8aQFu5JJFncmnUdOZpHZFg7Wq/AR
         QI11WSVSfNO+tYScNGbtef9lI116ffz1WJSvniF597Z6jEc80c42d1A0uAJ6JDQOigx5
         H0+g==
X-Forwarded-Encrypted: i=1; AJvYcCU6hHFO2XJYFHQVKtOi0XHHge0v2zBR1jtcKBloAlBxAYRP5EMSMrUSUEyipuYW4CDyF6xF66xdqy5avX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRpMfV+fS3ZTTQ3okEqFLQdu/f3zmdd2hLWiw1EaTfoV6DXlS
	iSQn6l1IVG/Lfe5U3s+Z41vvVwhsSpT1ZPfL9l3w7mStrlvP/Fotz3ELpF8Hm7uV8BSrGWWL9WC
	bbtM=
X-Gm-Gg: ASbGncsNTJzrkUx9FHfG6RMpBvUIwsiGODtb4Bze9R1Gg5FaFV8gXanxKBgT7vbjLVW
	FIhBfAsBF4UprGHJkme1RukaXbWfgIiJFg9P0IYlIIoLsEJyxGObKHkycSGeISVfDxRw9DtEZwN
	C6D8YntQQ61BlXfnlol3l+QaUG5l+/SpAW04tatbAfntqWqvyMNfishtxoCvT+/qdIEZOJX/VUQ
	AGlikUSAS7iAclceuwHgDxq9GZRh3HgZXyPDH9LGrowo+Fk5FToiBJUFdU6trf2ingc7tKBQoTe
	3dDvqqJB7MePVAPEYqbKSS/ULyfoe8BynMyhSeCKONzPwPPry41gi7FoWtcjXWPODlGoutc5r2f
	xufFoetvxABJiy0R+3NSz/YRlcyz/j5+CMauNQ6Wo/Nk/Rv+K/v1SWQmpxg==
X-Google-Smtp-Source: AGHT+IGMEqbvyWeaAZazbuPkBjZhYoslaRRz8x/ppuRU3wF1T4fX6Nf/ny83RDvXF5HlF/EfyB84Ig==
X-Received: by 2002:a05:6102:3051:b0:4df:e510:242e with SMTP id ada2fe7eead31-4fa2eb0c863mr2335908137.5.1753438693978;
        Fri, 25 Jul 2025 03:18:13 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b6fb64b61sm612567241.17.2025.07.25.03.18.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 03:18:13 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4f2f2f22c1aso1140234137.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:18:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhh0+V883cmVgYpPO6aczDR7nYL7PsxoaNrs76Ckjggr9k5SRnInH5d0Q53pLtFIa7P55Ce8G55uaoI0w=@vger.kernel.org
X-Received: by 2002:a05:6102:1623:b0:4fa:dd4:6877 with SMTP id
 ada2fe7eead31-4fa2eb0ce5dmr2502816137.4.1753438693359; Fri, 25 Jul 2025
 03:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-31-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-31-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:17:35 +0800
X-Gmail-Original-Message-ID: <CAC=S1niM4ddPSaOM9uMRQuUS8HwPw+gtxe9kGUggWQx6uio5eA@mail.gmail.com>
X-Gm-Features: Ac12FXzF0-E5XCOaIf5MFeMvqjYMvWSzSdwqzh1uEwhsUpfXPcd-rqBecXNopmU
Message-ID: <CAC=S1niM4ddPSaOM9uMRQuUS8HwPw+gtxe9kGUggWQx6uio5eA@mail.gmail.com>
Subject: Re: [PATCH 30/38] arm64: dts: mediatek: pumpkin-common: Fix pinctrl
 node names
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

On Thu, Jul 24, 2025 at 5:50=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Fix the pinctrl node names to adhere to the bindings, as the main
> pin node is supposed to be named like "uart0-pins" and the pinmux
> node named like "pins-bus".
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  .../boot/dts/mediatek/pumpkin-common.dtsi      | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm6=
4/boot/dts/mediatek/pumpkin-common.dtsi
> index a356db5fcc5f..805fb82138a8 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -198,8 +198,8 @@ &usb_phy {
>  };
>
>  &pio {
> -       gpio_keys_default: gpiodefault {
> -               pins_cmd_dat {
> +       gpio_keys_default: gpio-keys-pins {
> +               pins-cmd-dat {
>                         pinmux =3D <MT8516_PIN_42_KPCOL0__FUNC_GPIO42>,
>                                  <MT8516_PIN_43_KPCOL1__FUNC_GPIO43>;
>                         bias-pull-up;
> @@ -207,7 +207,7 @@ pins_cmd_dat {
>                 };
>         };
>
> -       i2c0_pins_a: i2c0 {
> +       i2c0_pins_a: i2c0-pins {
>                 pins1 {
>                         pinmux =3D <MT8516_PIN_58_SDA0__FUNC_SDA0_0>,
>                                  <MT8516_PIN_59_SCL0__FUNC_SCL0_0>;
> @@ -215,7 +215,7 @@ pins1 {
>                 };
>         };
>
> -       i2c2_pins_a: i2c2 {
> +       i2c2_pins_a: i2c2-pins {
>                 pins1 {
>                         pinmux =3D <MT8516_PIN_60_SDA2__FUNC_SDA2_0>,
>                                  <MT8516_PIN_61_SCL2__FUNC_SCL2_0>;
> @@ -223,21 +223,21 @@ pins1 {
>                 };
>         };
>
> -       tca6416_pins: pinmux_tca6416_pins {
> -               gpio_mux_rst_n_pin {
> +       tca6416_pins: tca6416-pins {
> +               pins-mux-rstn {
>                         pinmux =3D <MT8516_PIN_65_UTXD1__FUNC_GPIO65>;
>                         output-high;
>                 };
>
> -               gpio_mux_int_n_pin {
> +               pins-mux-intn {
>                         pinmux =3D <MT8516_PIN_64_URXD1__FUNC_GPIO64>;
>                         input-enable;
>                         bias-pull-up;
>                 };
>         };
>
> -       ethernet_pins_default: ethernet {
> -               pins_ethernet {
> +       ethernet_pins_default: ethernet-pins {
> +               pins-eth {
>                         pinmux =3D <MT8516_PIN_0_EINT0__FUNC_EXT_TXD0>,
>                                  <MT8516_PIN_1_EINT1__FUNC_EXT_TXD1>,
>                                  <MT8516_PIN_5_EINT5__FUNC_EXT_RXER>,
> --
> 2.50.1
>
>

