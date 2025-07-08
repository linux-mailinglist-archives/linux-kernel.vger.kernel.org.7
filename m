Return-Path: <linux-kernel+bounces-722017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B7AFD1AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B946584395
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6CF2E5425;
	Tue,  8 Jul 2025 16:36:27 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2022E266B;
	Tue,  8 Jul 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992587; cv=none; b=HaMyYRKoHjcvLkoeTToQHSodtEUOhdIk60yWmLWN1jp7t6nWJYfQ8MpJ37Iwf5QlCRq6WWjLpZrg6aUslEy1Oo6n6Q576kOEB0yiwPaDV/FnPUmKllAvvAiJat1z0yTDUOpfOv1KUmas34R6eOrCNi4j2nDZevKIwRxaSlYK1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992587; c=relaxed/simple;
	bh=I0JRzGqeLnwtKf4kjJYadCFOrmuTnbGxxR/rNzuzW90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0TtU9f8uGaCIB3I3MC0jpnokmWq2M8SAI4Nki49YblcznZS+ghiWQRingetb3tX3H0rYAjiRiZRkrGx6+MWbpNyrr7RHhDiAcv6SUmRTnBMSj8+LykG9GMm0YGutJGOIapAdXORsho8GgDI8xD57QuIh1Llw5xrtQXkGpXncQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32f1df5703aso24981361fa.3;
        Tue, 08 Jul 2025 09:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751992578; x=1752597378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4I7U9ozTZ1bfuxyVJsfZXgas4qwfJlXMhYg9fodydFs=;
        b=esrWdJMGMoo+evwkMKj3bw0RiWo07qmJWQEDKEVkuceg8kLU/OPwXk3ecl1Xx5CyWd
         EmHStFwhyALNMFOZ401Agd6XKGleThwk+pV+E3YL0MoX33pHrmIDuecOODcTjGKf3dSU
         87OEB3QRAeK24Gdy2InQFvJuq8CUWEEY8qmr51U9W3wUVPybJWBxUlcduvQ3zd9mQNWH
         QF9BONDDsjJasSRUKJn4xWnBSw+/xy2i6wJtD2K69zGJxsklou2Sf/2XWxckeTEy3xrK
         jxeV5Kzmi9W1WcjLpjl43qTgszcoIieuKr7v84GtNe4L3FXmeFRlg4s2mVFDPmvi6/L6
         TdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1FX9vpqa9r4Uh55ikbTvcVty/I9gS6FuHBZt6Q5pKjLw9sqq1o/2zgs97jYorHZ59rGBw47GthNlHT61b@vger.kernel.org, AJvYcCXMU5KIRF0qxBwtEy2lsFn0/lbXGoA8Pwh3PzzVFfyvoxby4DnzejFPdbg2jQpUkJWC8kvBWgBxrx90@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+cbFsOcN0U4Z2iMl1pByQEXRK0WjmHMGM3lzn9Uu/os3gvk+
	aM6hJJ8cL5sSAy0yNp7scJdlgFohBGXWxDUs4/9PP2n0BYOy6Snn4UR7kZUWVY/4MgU=
X-Gm-Gg: ASbGncvhNidsltpmdYx6RT+4RETptEPB1bGAtBO5qi0vAhbAtrJUQPI7/rhzIgY41rl
	yQU06An4yDf+471MsCXTd/IKIzMXY/b0+dHwaJriI3qluH188uWPO73Pxcvl/a7g7l7UjKOEdWo
	HaQocV4s9yLUZIzAp49qiVkZZmJf//RlNtDI1O7EurdujMZZn5dl/4CDmcaRgg+7Da2FoZOt2xx
	y0ul+0yvS6uSNLaT2dqXTpfjghYihRAU7NI3sJIsxj24wtN/1z2sLrQmBrHr3qaqPJUwEy2tlKN
	seKQZ8hKEufIlw35a/Ah3s4O7ioaQwIRUenrQ4QbzEnwZChIwbO28tIjA8MU5fZtC8EbmMgfi6E
	zjoCOv4X019IQCj8XIjiWEGZRiA==
X-Google-Smtp-Source: AGHT+IED/HQh+Sg7h5DewySdpWKQM4unAmZDNR/vTxmUbUXhlEWl4JiEp8887eatqGZWL2QafroTYg==
X-Received: by 2002:a05:651c:2105:b0:32b:53b1:c8ab with SMTP id 38308e7fff4ca-32f39b07909mr16203931fa.22.1751992578331;
        Tue, 08 Jul 2025 09:36:18 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32e1afc1b09sm14730801fa.27.2025.07.08.09.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:36:17 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553b5165cf5so5522480e87.0;
        Tue, 08 Jul 2025 09:36:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzzdY9iTOgQRGjVNfcYZRMuJHawISfi0GLcjJ0VF/IhqqKVfkueR9mCTw1v0J9lDCOp8eW1hFD3luh@vger.kernel.org, AJvYcCXuoHqV4ETbU6okFOSVkvc/7I9535RQa8pEABy7Z++SdUsKKn9Q7BfxJlLPpimMFDnTavvYyvnsCGt7GAbS@vger.kernel.org
X-Received: by 2002:a2e:be11:0:b0:329:4bfa:9f5a with SMTP id
 38308e7fff4ca-32f39aa391dmr15595031fa.10.1751992576098; Tue, 08 Jul 2025
 09:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707184420.275991-1-lukas.schmid@netcube.li> <20250707184420.275991-3-lukas.schmid@netcube.li>
In-Reply-To: <20250707184420.275991-3-lukas.schmid@netcube.li>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 9 Jul 2025 00:36:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v663GHk9jWXMBg36T6Qf8mwbnQcQ80=F+-tpbZ0Bau+79Q@mail.gmail.com>
X-Gm-Features: Ac12FXwC7-T3WWNdeROV3cwvshauCK_N_9KnHuUIE5o3NNtisH1pHGwgJnYBNjo
Message-ID: <CAGb2v663GHk9jWXMBg36T6Qf8mwbnQcQ80=F+-tpbZ0Bau+79Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] riscv: dts: allwinner: d1s-t113: Add pinctrl's
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

On Tue, Jul 8, 2025 at 8:35=E2=80=AFAM Lukas Schmid <lukas.schmid@netcube.l=
i> wrote:
>
> Added the following pinctrl's used by the NetCube Systems Nagami SoM
>   * i2c2_pins
>   * i2c3_pins
>   * i2s1_pins, i2s1_din_pins, i2s1_dout_pins
>   * spi1_pins
>
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/ris=
cv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index e4175adb0..8dc3deccb 100644
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
> +
>                         /omit-if-no-ref/
>                         lcd_rgb666_pins: lcd-rgb666-pins {
>                                 pins =3D "PD0", "PD1", "PD2", "PD3", "PD4=
", "PD5",
> @@ -126,6 +156,12 @@ spi0_pins: spi0-pins {
>                                 function =3D "spi0";
>                         };
>
> +                       /omit-if-no-ref/
> +                       spi1_pins: spi1-pins {
> +                               pins =3D "PD10", "PD11", "PD12", "PD13", =
"PD14", "PD15";

Could you split out the WP and HOLD pins as separate nodes. They aren't
strictly needed for SPI, and folks might have designs that use the two
pins for other purposes.


Thanks
ChenYu

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
>

