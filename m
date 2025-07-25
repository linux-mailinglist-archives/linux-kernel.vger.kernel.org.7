Return-Path: <linux-kernel+bounces-745753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7EAB11DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA56188AC95
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702422E6103;
	Fri, 25 Jul 2025 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uej2vVwu"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2C242922
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444312; cv=none; b=Vj/mAaIvsp1AQg2C9FzOzXp2buTUGnWF1DxKUPZAjUKzA6SGJPDF9500d32uldrMCDbUTX6Jo39uVVvxXdB0cJn4MqW0L0oapPn/Hryv5geQpgOmYItPoT3FAmjn7ELx4XdXqa4VOFZztlrM5OMzaE0yk7vCJfhX8389GPn7uhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444312; c=relaxed/simple;
	bh=V8hirrUVOWBBWHrhJ7nvVXSHaacevucbhSLPMWQvrV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqsS+jolzzP1U0TbnDqyv2BLfuECzTd/F89lW5Fjbv9hCFw5gceXMtqpOt3UdDxx15H+U4HVlS9uGw5q6X7z0D0xv23YxQ+r7F42kChN2ymEzRFw5fRcbKuLYDRQ/IndyE+vcp3quc1/Qp61W17zjYQIzpzZyUu/HV6ttVgP9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uej2vVwu; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-52b2290e290so569694e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753444310; x=1754049110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOvBSwwtmNG8Z+SjWPY5aek+Y4mrxHqGqroX/bR/8SM=;
        b=Uej2vVwuEsYdEDDUeQcSmcaUsvpzQKKSdKsFRRXibTmowt5RSY2ZeJA0aJL/vNCsIS
         VfukywVN4YHD+D6clbITlI/3iYd4qh3BJuyFCuTBwTvPs9BautfuasL1ffot5oforUUM
         ESRHFIftbsyYqypOc2LrFMhuZEIXEfAFhsYuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444310; x=1754049110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOvBSwwtmNG8Z+SjWPY5aek+Y4mrxHqGqroX/bR/8SM=;
        b=hbkni0wMpgZw+dIY6qTNN+gtnCXLq+pAKIj8hsYgQFA+GBWyLtBvymuS3/LVYg+S+M
         a2m59jsgP+1kH9KpGSniLuSRt/zjagHaFeM9zvB05C8HXPk6hpjL6g6zz6uF4kT7G6Ez
         L8XIjS2Gbx+epFZWtnQLJ6XgV4JWjmWVrF/CJeDEg0hQTW3ZyK+cFdihlzztB9NXq3NS
         3FxAf4sYhVehQMCxZFPf9kksmWcSDQsS+RjCZRl7CinkVbotGp7IhMvyb2fqHYanaz+Q
         lSyfUlu92+OWTk2x80B//Ax3/fhzZh8zD4dkEM9DRbYP9pjHPCgpZPSlWNQ/zgv89M1Q
         OerA==
X-Forwarded-Encrypted: i=1; AJvYcCVw2mjwtdMJHvmlWk4VjEc0jLdsd5qz4OxjNGgEGEdlrpjMVNGrBUpVvpUunUMR2MhskhSkdWmgwD1hSgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyieVUrdc9jV8/nA4zIQWU++RRKMXcaEPCsXLAUXz5nePo7bQIk
	XIPpW9wWp+NhRlITp9+WJTRQL3wD0Gz7AQwNMhIkSr8w0U6ns6yVjgwxJATk+proPryauIRcAkb
	0DbI=
X-Gm-Gg: ASbGnctDl6yp+V4FHPeZO8VtcIDjkTKzytVIPDuMJELU2WLPNH2ScUtfxcRDOgXaVwm
	+x+VodV3omoNB05ANzwmkTkFbM3Hh0rPWhYJ+k6CjDyaVQBeEjpr+1JmbJkRbyjaaJO/Lv9kHRI
	OEjjQ1zUfVaJN6u5i7aVQuMPm1e+0vzQYmdgm2+p2OPa1q4c8d6PWMub7+O+K74qli91iudsvc2
	xYYk+hBfyAmiwDzp0N81olpUrf2g3eFQMVMkBQ1XYCIvmW15S0n0LOLsiPiX91APULrsDZ8IpcK
	ZYTgzKQVBWeDCfYCXSKMRCCmZoPs9pgfmGE/Y/GCTqPoe9K/9asJbGa1C1mfMilnxCMNTpOau/f
	OoQLqTD77oM2xDHyLuh8DanbR+f1tbXEl7VJ+x0en+wS8GmIY/uF9vKVj8suBfg==
X-Google-Smtp-Source: AGHT+IFnmV8lPL1dW/yU8ITQV7AloEf8BmjuVevMFk5DefG59wbb05ZS/fCDtWKx5yGSJc4kEu1xQg==
X-Received: by 2002:a05:6122:46a8:b0:531:236f:1283 with SMTP id 71dfb90a1353d-538db602ff1mr378821e0c.10.1753444309711;
        Fri, 25 Jul 2025 04:51:49 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537bf89d6f0sm917494e0c.31.2025.07.25.04.51.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:51:49 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5346b405d1aso1228754e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:51:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzoWf2Lw8R5A+ELrqNbMH1diGxTKxIioX/lGn6yr3j/oZd/CEZmoMBsbUC88ahrtTFEZQn6+S40VNlc0U=@vger.kernel.org
X-Received: by 2002:a05:6102:358c:b0:4e4:5df7:a10a with SMTP id
 ada2fe7eead31-4fa3fc6be93mr374132137.16.1753440996607; Fri, 25 Jul 2025
 03:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-17-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-17-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:55:59 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhwrq60q-=jMZQ2u8TwwG9HHnQFWrFRx58VF2K6Xi16XA@mail.gmail.com>
X-Gm-Features: Ac12FXy6b-EYxcfTGxWYM-OfSnpWrsOFjS6YFWPk3kTV_ZIdvcSVvNebJ1JSwHk
Message-ID: <CAC=S1nhwrq60q-=jMZQ2u8TwwG9HHnQFWrFRx58VF2K6Xi16XA@mail.gmail.com>
Subject: Re: [PATCH 16/38] arm64: dts: mediatek: mt6331: Fix pmic, regulators,
 rtc, keys node names
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
> The node names for "pmic", "regulators", "rtc", and "keys" are
> dictated by the PMIC MFD binding: change those to adhere to it.
>
> Fixes: aef783f3e0ca ("arm64: dts: mediatek: Add MT6331 PMIC devicetree")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt6331.dtsi | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6331.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6331.dtsi
> index d89858c73ab1..243afbffa21f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6331.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6331.dtsi
> @@ -6,12 +6,12 @@
>  #include <dt-bindings/input/input.h>
>
>  &pwrap {
> -       pmic: mt6331 {
> +       pmic: pmic {
>                 compatible =3D "mediatek,mt6331";
>                 interrupt-controller;
>                 #interrupt-cells =3D <2>;
>
> -               mt6331regulator: mt6331regulator {
> +               mt6331regulator: regulators {
>                         compatible =3D "mediatek,mt6331-regulator";
>
>                         mt6331_vdvfs11_reg: buck-vdvfs11 {
> @@ -258,7 +258,7 @@ mt6331_vrtc_reg: ldo-vrtc {
>                         };
>
>                         mt6331_vdig18_reg: ldo-vdig18 {
> -                               regulator-name =3D "dvdd18_dig";
> +                               regulator-name =3D "vdig18";
>                                 regulator-min-microvolt =3D <1800000>;
>                                 regulator-max-microvolt =3D <1800000>;
>                                 regulator-ramp-delay =3D <0>;
> @@ -266,11 +266,11 @@ mt6331_vdig18_reg: ldo-vdig18 {
>                         };
>                 };
>
> -               mt6331rtc: mt6331rtc {
> +               mt6331rtc: rtc {
>                         compatible =3D "mediatek,mt6331-rtc";
>                 };
>
> -               mt6331keys: mt6331keys {
> +               mt6331keys: keys {
>                         compatible =3D "mediatek,mt6331-keys";
>                         power {
>                                 linux,keycodes =3D <KEY_POWER>;
> --
> 2.50.1
>
>

