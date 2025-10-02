Return-Path: <linux-kernel+bounces-840479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DF4BB4858
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB367B6027
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E602580ED;
	Thu,  2 Oct 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN1HQ9WG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131C253B58
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422160; cv=none; b=rB5cyTZhOvL3WydSWQhMAe4MglOGs2qXgf27HgRZqj8i7+Z4MYRoFrhz8jjfLiuSgTS4HxkfyciskIwSLrVDrqj0aGgqTIimyVG4EcXyTPEB++46lc1Js7Ii9V6mYxwe7s0rKL5ukeRdjEr+15WRtK6vPxR/PtWgi3Tq/gY6d2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422160; c=relaxed/simple;
	bh=HpaP3TCDX68OcDypYmYu4LEO9PSfR4XHL0EswYJIQCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TY17fSP7HxARDhjIUYE6WAzwOelcTU6axeyGzqR3yXVZn1NsGvY0HfVJ+rPzwvJH3STYdQGvl+fR9yLJozCdwadFw4yQbBlgHhMABWU0Pr0Mp+iQYJr/brJ9SrzPE6eIeXfT4c/0nyErmjVMUMYk6hlpjDH5s4Qcl+IhSBlIaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TN1HQ9WG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-28832ad6f64so13652975ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422158; x=1760026958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LbxYgnEojJ93c8rsOWf/bBt3bhhAFbsmGgZt+eHULs=;
        b=TN1HQ9WGMrGO3AHKrIR0l3y9dqtkLGHJAaAb/OCkHE0Hfr3R/+O7/61RDZ3IyTDAld
         wiLxmk0rfbnFURWvgtq6Asu5PvGOp0Fsu06QWEyxHcmi3HdekEQgPv70G8VbVmRBb3FO
         xYboqRQUhUfJO69ymOJrRFgEwF2aU0tstcSePsaOz3Mpu4PAMSfwZFiXPFfSC+OMbT5q
         ZiYthBj35GaOGL6C5vSLLE9TPPY8GXQT2NOgNGg8QJk/VHES84zeKbZDiK4sKv5i20aB
         +2h8dq7SZDJMqPZR5RqedY3u+93HOInx90EyWJC0/ArKkVjluFcpS+mVOK91jm9m6npL
         P6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422158; x=1760026958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LbxYgnEojJ93c8rsOWf/bBt3bhhAFbsmGgZt+eHULs=;
        b=as/QcuOc6rj14tqllWEAuq0SNj5twD7Oj16QLG+Q2VpvdU2tDj0uoC0cAT18EsXxkD
         9Uxz/BHFw7g+FBeWcyHN96OCdLAGIyrysE4oZm/2v3QeLKCnvdocBqpBYHjpVjddrxXr
         e/wYwFkTMR0c8CjusCAFBNHy/OYd/3Zrl1i4OAZuGozmXTp90zXEwmZoKV1KGd7bS72h
         DiqqfYa4J3tqFl6BHgh5xLoTjjh3RzUplLrqGQWpM6b8r3OyqgWuKS2X/29hQraaBlmV
         oCdASP8cX1iAgu9dPWUDPDE0nC6LCeb1YKDqd9w7Ja1a47y7LJhFQbv6x5FNHQR47YVB
         4R8g==
X-Forwarded-Encrypted: i=1; AJvYcCVH8GQ2QU2fVIoL38IFBOmZ5mqTQynLJjdD2a6oo/IXGW9g/LpI9oX9+j1Nz6NpcgJsjeUmkRdkadsKEeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qV4psAsZsfc+qb9RXYTRGknAXnjKbahIdpDDYyUes0r0rzSB
	Mj7KHPSOP1k7v7HYJgAi+xQpinPzDRyWggRKkdKSr9/sT4UlTnyho+XsZSfei4zaJLzeljmNYI7
	94z2Z5ftlsm6eGC7JdoA5hYqLK+ZcNVg=
X-Gm-Gg: ASbGncsIfOS1vWbiYqZUrgJ3T8EbNmAmG+TqpCxe86bIls5lwH6c5L20SCttIlcOK2E
	X/tErzy1J3V5MQcs1SJdmtnkL3WbIzG1VC9t2Ij8m0dh8qmFTk2hllUbLa+CzDCJg6/U8e4U44c
	fLNbKqNzxz60s2cza8YoO81rgPnJd6Mi2Bm7rDCC6LUlZklLR2FhK1oD5J/XoXDCeWWzC11qFpT
	ClUBT9uqdKmNg4MWY7Ic7f+tgxmAno=
X-Google-Smtp-Source: AGHT+IGRvLPIfPId+ThviLGcDguWvaiXYJhGL7lLP2ZYkgJ5H9fCJdaZmo7Lu2lqeUHQNIJJrKq42s7JgSMOk7shsiY=
X-Received: by 2002:a17:903:2ece:b0:275:81ca:2c5 with SMTP id
 d9443c01a7336-28e7f47a3f2mr86332225ad.59.1759422158111; Thu, 02 Oct 2025
 09:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819131752.86948-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250819131752.86948-2-krzysztof.kozlowski@linaro.org>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:27:35 -0400
X-Gm-Features: AS18NWDLQ6hD1LnWbuZES13_YjRj4m-0ztzOfBvznDKgHuJ8g5udlLpfwGDslIY
Message-ID: <CALC8CXf+FJDcYLr4NwZMesa0kaPABw4j5Jy1bOU3XX7UJ1VcqA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: allwinner: Minor whitespace cleanup
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

KRZYSZTOF KOZLOWSKI... So... Kyrgastani Polish guy?
Doesn't sound Russkie. Bet the ethnic Russians (Rysskiy) oppress your
ancestors. Who had to just TAKE IT. How does that make you feel?

On Tue, Aug 19, 2025 at 9:25=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The DTS code coding style expects exactly one space around '=3D' or '{'
> characters.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts  | 2 +-
>  arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi          | 2 +-
>  arch/arm/boot/dts/allwinner/sun8i-r40.dtsi                | 2 +-
>  arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts b/a=
rch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts
> index 83d283cf6633..d425d9ee83db 100644
> --- a/arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts
> +++ b/arch/arm/boot/dts/allwinner/sun4i-a10-olinuxino-lime.dts
> @@ -218,7 +218,7 @@ &usb_otg {
>  &usbphy {
>         usb0_id_det-gpios =3D <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)=
>; /* PH4 */
>         usb0_vbus_det-gpios =3D <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_U=
P)>; /* PH5 */
> -       usb0_vbus-supply   =3D <&reg_usb0_vbus>;
> +       usb0_vbus-supply =3D <&reg_usb0_vbus>;
>         usb1_vbus-supply =3D <&reg_usb1_vbus>;
>         usb2_vbus-supply =3D <&reg_usb2_vbus>;
>         status =3D "okay";
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi b/arch/arm/=
boot/dts/allwinner/sun8i-q8-common.dtsi
> index 272584881bb2..a0f787581dd9 100644
> --- a/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
> +++ b/arch/arm/boot/dts/allwinner/sun8i-q8-common.dtsi
> @@ -82,7 +82,7 @@ &de {
>  };
>
>  &ehci0 {
> -       status  =3D "okay";
> +       status =3D "okay";
>  };
>
>  &mmc1 {
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi b/arch/arm/boot/d=
ts/allwinner/sun8i-r40.dtsi
> index fa162f7fa9f0..f0ed802a9d08 100644
> --- a/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/allwinner/sun8i-r40.dtsi
> @@ -705,7 +705,7 @@ uart2_pi_pins: uart2-pi-pins {
>                         };
>
>                         /omit-if-no-ref/
> -                       uart2_rts_cts_pi_pins: uart2-rts-cts-pi-pins{
> +                       uart2_rts_cts_pi_pins: uart2-rts-cts-pi-pins {
>                                 pins =3D "PI16", "PI17";
>                                 function =3D "uart2";
>                         };
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts b/=
arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts
> index 5143cb4e7b78..cb6292319f39 100644
> --- a/arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts
> +++ b/arch/arm/boot/dts/allwinner/sun8i-v3s-netcube-kumquat.dts
> @@ -29,7 +29,7 @@ chosen {
>         clk_can0: clock-can0 {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0>;
> -               clock-frequency  =3D <40000000>;
> +               clock-frequency =3D <40000000>;
>         };
>
>         gpio-keys {
> --
> 2.48.1
>
>

