Return-Path: <linux-kernel+bounces-815101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E7B55FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA30E174A63
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A342EA473;
	Sat, 13 Sep 2025 09:09:25 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89A1B5EB5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754565; cv=none; b=rdSzjKgX0wAr1b/TWg39EbS4BfHLnwaX9ZddfoBVHXAh7S/KzAWs/l+6RQPI1XUzotFCEu3YXr7be4iE7Ypbjm9Oqj6QaclRlhI2H8UcaKlaQrg9zgfS9w3ZwWiO8afpPzbvR/BTVthu0In7WNfnVPaSpJ3P1F5Jjcds1AGPIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754565; c=relaxed/simple;
	bh=3axRdzUJe+dWuKW8fyKBAG7j/3hD2bAE41+RVxf3jAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcN9dFE8xuP6X03ocmZpxBGXB7ET1NgsrNY+qO05blZz4wcw2PzrAzADZL06Qv4KettNCFH3CdCG0dG9PaPr8DmwBDaGpoIrn5aetgbLuPX9IcMJAVyLQCtOBiZ+aTLQOujYJM/m2oLTsVom08YiqSxlTODqdpY0JB44YcELO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-56d1b40ed70so2077366e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757754559; x=1758359359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4M9q1sBtoJdbch2HX+0f+gEgUbmufQuxtOpAtokmLRw=;
        b=ponTLkn3JTwpKykmNSj/ARHA4F26kDJT63tKpGBFyftCaBX1jb0V2TW/dFo3VGuL6E
         wEtJtIVsPTkPnmtVD/pI5UtnAWB3lgZxfuy77ezxHP8bLgxhS4yuKSEeHoymbCqm/GTu
         cfDvrDyn9J/fSHk47gOAbShLlVqiJkGeFN4l7PHeV4QMh6kfAlildyGXVIx6xeHu4JfU
         6iZBw1a/GsIkHA6xyY6gx5T1Buj0MVcVFu6q0SoLuF5cri7PlbSc9TFgSCs5y4nA285o
         Nn3ao9L5z0m8WF7/wxc6rX/XyWdaZPjB/n2+bnLToKUsSjgZBsbV/JbIxsY7pdJN8iA/
         fFwg==
X-Forwarded-Encrypted: i=1; AJvYcCWzcb2IgRhLOwwI5EU8Ocma3lMs98gfIR7SAfb2F3HSlDCe+wQYQuYp8YTQye81K0XaHK6IaAI04P/7XxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQl31s1tSpT1dI9gCVmAT3B3Mx6AB2PvxGtDDZcxtuH8B4+6uQ
	LcTMlUrazLqCHVvnMI/f0i3k8Lf0aSt3OMgFlLIBIkZU4pvdkcdTGVOYIidcw9Dv
X-Gm-Gg: ASbGncsdXocVvCdX1zlb2NFh2N58teuRNdjr0NBQ4lm8AII9JoqEEdKK/wf5Ss6IZPt
	03xC51przZfKcjggUA1hBOG9ac8zOALYT4SPXKPaP3GFsoui4HhzvlqqDqmBMkaGglt/AktrNw0
	MniadRSbBzgwyaSa9ZOpAhKT+cW0TmZGtYyrLns1FJtzNyvfrBzTziIAEWqXhjjeHDaMye5PFPP
	vg7I+6GhjQMyDmyInx8RgBOZZZb6NJUSoxdb8jIQc4dbWvaXGJwAZMOvDLdYmsNRq97brMkLtEY
	dRvK1f9Hb2xvJ50ps5cKmZ3JaQZdViY5RgxM2BVCnZUQdIG8gjW96b88ZcVf+W3whdVwjwBrOLX
	G2EqcYxsYrlplBz6I6uc7/bTmiHERC8egh98mp9lUu7iT9sf2D56vtC1OVZ6hc0431YWmK/vwxn
	A3
X-Google-Smtp-Source: AGHT+IFnIaKJtXJg3iN6DQv793NW1mJ+KYYlHxpHzfiGkXZSLhLAjRcTOovWMKYKj2Vb9KxLsNOGiQ==
X-Received: by 2002:a05:6512:a83:b0:55f:4746:61ed with SMTP id 2adb3069b0e04-5704a8b5f14mr1845243e87.22.1757754558669;
        Sat, 13 Sep 2025 02:09:18 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571c6347384sm520216e87.37.2025.09.13.02.09.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 02:09:18 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-33c9efd65eeso25796711fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:09:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeN5tejFB7rWht5zZzz08RAwtmmToNbl++1gxKSrLfhI7yxTGuD4+ZTnUzoxVXF5dvN5qqO5biOc3oMIM=@vger.kernel.org
X-Received: by 2002:a2e:bc13:0:b0:336:ed88:f3b1 with SMTP id
 38308e7fff4ca-3513a042fe1mr16058841fa.7.1757754557881; Sat, 13 Sep 2025
 02:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831162536.2380589-1-lukas.schmid@netcube.li> <20250831162536.2380589-3-lukas.schmid@netcube.li>
In-Reply-To: <20250831162536.2380589-3-lukas.schmid@netcube.li>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 13 Sep 2025 17:09:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v67fwg0x8HNE6Dp-M-LDyon1YipeonqvSvSY-BFH+f4E9w@mail.gmail.com>
X-Gm-Features: Ac12FXypVtt3w9R-5_aPJlDVL7mEoeRUisSDiiTl2jorYCCDiG8XoTwLb6M_2sQ
Message-ID: <CAGb2v67fwg0x8HNE6Dp-M-LDyon1YipeonqvSvSY-BFH+f4E9w@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] riscv: dts: allwinner: d1s-t113: Add pinctrl's
 required by NetCube Systems Nagami SoM
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:26=E2=80=AFAM Lukas Schmid <lukas.schmid@netcube.=
li> wrote:
>
> Added the following pinctrl's used by the NetCube Systems Nagami SoM
>   * i2c2_pins
>   * i2c3_pins
>   * i2s1_pins, i2s1_din_pins, i2s1_dout_pins
>   * spi1_pins, spi1_hold_pin, spi1_wp_pin
>
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/ris=
cv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index e4175adb028da..c00996d6275c5 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -78,6 +78,36 @@ dsi_4lane_pins: dsi-4lane-pins {
>                                 function =3D "dsi";
>                         };
>
> +                       /omit-if-no-ref/
> +                       i2c2_pins: i2c2-pins {
> +                               pins =3D "PD20", "PD21";
> +                               function =3D "i2c2";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       i2c3_pins: i2c3-pins {
> +                               pins =3D "PG10", "PG11";
> +                               function =3D "i2c3";
> +                       };

Because i2c2 and i2c3 have multiple options, they should be named
appropriately, like i2c2-pd-pins and i2c3-pg-pins

> +
> +                       /omit-if-no-ref/
> +                       i2s1_pins: i2s1-pins {
> +                               pins =3D "PG12", "PG13";
> +                               function =3D "i2s1";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       i2s1_din_pins: i2s1-din-pins {
> +                               pins =3D "PG14";
> +                               function =3D "i2s1_din";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       i2s1_dout_pins: i2s1-dout-pins {
> +                               pins =3D "PG15";
> +                               function =3D "i2s1_dout";
> +                       };

Should be *din0* and *dout0*, since you have din1 and dout1 on the same pin=
s
but swapped around.


ChenYu

> +
>                         /omit-if-no-ref/
>                         lcd_rgb666_pins: lcd-rgb666-pins {
>                                 pins =3D "PD0", "PD1", "PD2", "PD3", "PD4=
", "PD5",
> @@ -126,6 +156,24 @@ spi0_pins: spi0-pins {
>                                 function =3D "spi0";
>                         };
>
> +                       /omit-if-no-ref/
> +                       spi1_pins: spi1-pins {
> +                               pins =3D "PD10", "PD11", "PD12", "PD13";
> +                               function =3D "spi1";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       spi1_hold_pin: spi1-hold-pin {
> +                               pins =3D "PD14";
> +                               function =3D "spi1";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       spi1_wp_pin: spi1-wp-pin {
> +                               pins =3D "PD15";
> +                               function =3D "spi1";
> +                       };
> +
>                         /omit-if-no-ref/
>                         uart1_pg6_pins: uart1-pg6-pins {
>                                 pins =3D "PG6", "PG7";
> --
> 2.39.5
>
>

