Return-Path: <linux-kernel+bounces-745756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BDDB11DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D10566D75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1D42E7167;
	Fri, 25 Jul 2025 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jZ/qA0iU"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056972746A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444605; cv=none; b=JXcwDg2wEbDQ5K6O/sZDBXwTi/hq89h+P2j2ZUhqBWXoQl+7FKVtV5iRU+Jd5Z1x7u+qDwiaA5HiKdbNtdtig82QFWEfoExAZBQeI45vBRzr8fhbnQxkz9uFWb3dUmKiVqipFzJ542cE+gMyqa+UHd40T65dvWpvya64QpP+1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444605; c=relaxed/simple;
	bh=70cZJ5+MOSuyvoTc0hRAELy7cfRbFrHaFdQesC+yVH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oI5oAG+6zzHQxCQ0M33+0+3SHXtFJX8an7kDGTdJg3j4gzDFXrV+uzJ9M+ou8ZMWzu5Nicw9YWR0vODLU/O583MmvcGqstfX9CFkLyjJ4moJc8nE/5WmWrCNK1jpFbxjr/m+eKfX9KkboIqjb9ulKMOx2vSUCxSGYYTbZq4Yqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jZ/qA0iU; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e82d2ec9eso1200933a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753444603; x=1754049403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj71s94DBO5ChtWnhYstkEV7QIcBC/2WSymKueRnDS4=;
        b=jZ/qA0iU8M7EvloYgZPZiat9JrlSf6RfzP7s3gRIuNYlHY4wpQPs/+i2/yf72PY6hN
         /QjoYgTFq74e2hNMMmwde3YVyIEUBNLj1WNCoqpTV5ovZkuJUy8uJtSU8tha/StIRtdb
         Bfz0ErvJsoVi1egmQRKXbwIjvhYFjIOtnouHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444603; x=1754049403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj71s94DBO5ChtWnhYstkEV7QIcBC/2WSymKueRnDS4=;
        b=M50ZUYIVTJvX8lIoSX4lLcLfAL9bYIgD6+15PU95sA35Z4wQgiaz7iadBH62t+lKq6
         avMDXN/ZcaNJpAJArgBgtnb69Kpms8Bq2rcNH//H/BVatY1uPikr1h8ojtSxYnD5VP+4
         VOp67WcNA7PVhrpG1kjIJQsiDNfJPWJo9+dXKjMA5zhXDvtqOOfKnRl4NjW6EaQ/eop8
         UIN6nzusndthRZkhlCoWRLXc252xuLnNeh5jttTsWiJSAxLL+v5K1OJcXlScK9UoeXap
         LBmyMn4F8b+zJ7beAB/Gmd6aTyuvDNqKwWXCvyE3vcNycRB7vA63bPbFVSgB5U6NspAc
         41sg==
X-Forwarded-Encrypted: i=1; AJvYcCUpIQmQyP91WFnGQ03M5FUAsYUZ4yEzvbmkMdasQ7RvopyznbsPlR0amABIZasYrHKySDNaAT5LzyR8siM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVinF+3k48diNsTXsc0orQ9cUxDV6Y4jaBfjzsrf+uRIxmoqfI
	xPutVurs2flHqQeIz6Mf7y8OW77iiY2sJjeSx0YW7l7N9lpBPA3TfsjBe0mv2rAOci0qI49qnEJ
	uwkA=
X-Gm-Gg: ASbGnctjKj6BfC1T8i4bF1WYpo3lzSx4BMjEdrKZjZpeUctRm8KVfHaO1fnMh1ufHRq
	z43xBtkAWIVo36VFVnuM/yxDfV51gvzB0nsKaODdEjo9vPax3Ld3w6gM0Px6+ejJVwYCp1VqNCG
	/49eVhU2dOvrIdUaN9W3Hm0u0qDm1VY3L5nYxv/ZJqXGbBY/ky59t3Coqwk5zK2JVvoYXw9v7rZ
	ECTOGB09SDvO63e7HsOMvB/rjoLttNWBPEhtUx24sP4xqywV2Wqe6xgk89X9+RteSvKAoXMhP/S
	lDEdok/pcMNqFbipvLA4ze3tRARNgt+wfBfW5KqMysIiYD0EXr321ZBjPzOYXS8+/b/gVWok2DO
	oBSFFxAz/kuzvbM5Lvvtwg7vtLpr5MxTcFfkxsvSOO08Ngy+lP9s2OEu1H0bCyA==
X-Google-Smtp-Source: AGHT+IHI/eHIBNFLmMMCCbjC++BCXFP70y29Qb3U8P6ujCcqqil9QA3Se7j8aUpEPvjVQc0RGHCWiQ==
X-Received: by 2002:a05:6830:44a4:b0:73a:8a8a:5154 with SMTP id 46e09a7af769-7413dbf65e3mr823067a34.3.1753444602771;
        Fri, 25 Jul 2025 04:56:42 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7412d2ad6e8sm644284a34.32.2025.07.25.04.56.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:56:42 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-41bc2668f85so1269577b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:56:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJtRJJ2VUTt9jEMUlQXB70RRd2ROldpxJszKxVVPpH+D71nm3FherSq0fAfUqPZgJTTuIyJy32fctPLac=@vger.kernel.org
X-Received: by 2002:a05:6102:358d:b0:4eb:f003:a636 with SMTP id
 ada2fe7eead31-4fa3f8f1683mr313640137.0.1753440679035; Fri, 25 Jul 2025
 03:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-25-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-25-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:50:41 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhS8yY6iWNDfv4Lwz8zUJEy0nMxC5MVZGb983hDsg7bhA@mail.gmail.com>
X-Gm-Features: Ac12FXxJVbrVgIPSlm6u4--DKBHxaHRjM_36IT45XEIgpl9bR5PM8dE-s5Wt-28
Message-ID: <CAC=S1nhS8yY6iWNDfv4Lwz8zUJEy0nMxC5MVZGb983hDsg7bhA@mail.gmail.com>
Subject: Re: [PATCH 24/38] arm64: dts: mediatek: mt7986a-bpi-r3: Fix SFP I2C
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

On Thu, Jul 24, 2025 at 5:49=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The binding wants the node to be named "i2c-number", alternatively
> "i2c@address", but those are named "i2c-gpio-number" instead.
>
> Rename those to i2c-0, i2c-1 to adhere to the binding and suppress
> dtbs_check warnings.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

It'd be nice to mention in v2 (if needed) that this patch also drops
redundant #address-cells and #size-cells, but it's minor.

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/a=
rch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> index ed79ad1ae871..6d2762866a1a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> @@ -64,23 +64,19 @@ wps-key {
>         };
>
>         /* i2c of the left SFP cage (wan) */
> -       i2c_sfp1: i2c-gpio-0 {
> +       i2c_sfp1: i2c-0 {
>                 compatible =3D "i2c-gpio";
>                 sda-gpios =3D <&pio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAI=
N)>;
>                 scl-gpios =3D <&pio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAI=
N)>;
>                 i2c-gpio,delay-us =3D <2>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
>         };
>
>         /* i2c of the right SFP cage (lan) */
> -       i2c_sfp2: i2c-gpio-1 {
> +       i2c_sfp2: i2c-1 {
>                 compatible =3D "i2c-gpio";
>                 sda-gpios =3D <&pio 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAI=
N)>;
>                 scl-gpios =3D <&pio 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAI=
N)>;
>                 i2c-gpio,delay-us =3D <2>;
> -               #address-cells =3D <1>;
> -               #size-cells =3D <0>;
>         };
>
>         leds {
> --
> 2.50.1
>
>

