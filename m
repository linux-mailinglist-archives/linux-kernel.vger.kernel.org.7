Return-Path: <linux-kernel+bounces-823985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12979B87DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C156B5805F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80A26CE06;
	Fri, 19 Sep 2025 04:30:11 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4B2701CB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758256211; cv=none; b=NS+ls14r7VfQTfOlZUQZrsSci/rkcpFHApSBnnp3WIOAGhs09miYuk1bgmBOPvGb2eTYhJ1yu+FmMm+xNKbTcysde+0YyGQSnc4XbYkP+HsLlBO83nOjz5nODx0KivG9jOaaAOTofPdUCam2qWCNArqOqhHVAnhwxZ73euwGjBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758256211; c=relaxed/simple;
	bh=npOTcSqiw+hF0UGUQpx1GK19Rw+VNOfBn6L/aVX0tb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWBhjueQQAbFoLLtj/gupgyw8c47/i4e3vJlMXiBKCWSA2Y3lneVKsrokPtShq34yCeeraFl6qw0R3Ee1gbJJs7w/4nru+BlRLseSaJEYyXe0G4vue9S8s8NHoZg+BEkU97o68QIySyTevLSsG7wfIj4Z9pE32qA9VwcoEw7jwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso316660e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758256206; x=1758861006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73UL61+9pLCpRMWx7q6mvFEg7F186Qu7dLluxWn/Eb0=;
        b=X2+Wk6p6YWNa9DQm16Ior35JDTHrqSy3BHn2ci4SDlVKzaCiiqH8yMpE8c4A7grIxI
         i93ovhieM4WVQ5lJRPUBRVz/ilWYqlwZ/PL357sxIYxhwWi8vq0mQ6RO54vy2tbFsq8u
         dxf3NlaTOF97lqXV8v+QVmInpVLsptrNnh08nTBhBZ3jsZ06cbJLEaWnEngo5JntZlWy
         IjAIdD7m5Iq8O9inf30G0RYnZcO7MYx/kIj14RPV/aP691E0rxYlgeMIyUP5zpJgViUa
         u458idVfZ6DDLKN50sJELGw/oG/5ZZKuoIO3IgfzTiKSUq9vqqj8JFnNy6rzmL2il4GJ
         zu/w==
X-Forwarded-Encrypted: i=1; AJvYcCWYb36m4dbCgb4yGZ5490cacaaAo1+eCmdr85hqWdNvU2zTFMHltfzVZiQNekM7/w3Lk3a3SWur5xCZltg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJlra2xdfLfWpSN8rgt/mQO0p0xph2gk4IBMhTh70wCKs30PF
	NjmTZ44ToQvtmHp1xO9y7SGDBRM+2LEC+cQMfWkAkJS1NTOQZUC6pgHAe015Tzfa
X-Gm-Gg: ASbGncsfBUUnhN386AL3b397S9kGUgQdnDUnccEi/MkStiWaKAtL7T9eAnxtg6gvvwy
	W7jgKAQ7Dgo3M0M8EOFq58vji9V3+1H0LvkQLJ5rPJkfmVa2JZiiiWaN3L27FMB9e2vCZ90Sgd/
	q7LuHn0JtanH47Bim6x/tFk6w8QOZXOrpaC/iBkyRCEudwHMBh+NOgn1fUKJTvrB3km8fTe3lV7
	wj4hfY4Kh6r26nqZUBO+YiZa5Weq6cpz10CLi21GY2zlrBHFiKqqtyJcQAZXbfr83MjnAFfi/FR
	x/sR6Mga5dHukRbNvD8+QiDtF9mjZyDhpU/0DHSXWXybDIyiuG5s1K3oignm78KMkBo3vXAVb25
	hqlGDADZkh0K395Ce05hQnSwKig5PK+Nt0ajpGTt7/qazYt3kDlDCc4M=
X-Google-Smtp-Source: AGHT+IFVnq77SNVnYcVa3eSVWNiPoovUi4bYAQVvAdz/0ESRX8E765kVBZISWz5IwXBwsZ2lWvwwcA==
X-Received: by 2002:a05:6512:2093:b0:55f:503c:d328 with SMTP id 2adb3069b0e04-579e2cc187emr498156e87.36.1758256205431;
        Thu, 18 Sep 2025 21:30:05 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a90a2065sm1137930e87.88.2025.09.18.21.30.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 21:30:04 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336af6356a5so14156601fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:30:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsgZhf4tsQU9wq22+fo559lXs6sTrFNRCVztZOnjRDKUYiFQbPo5rqwaCAARTnloAROzNirtYVXD/m8rg=@vger.kernel.org
X-Received: by 2002:a05:651c:3257:10b0:337:e238:8bd6 with SMTP id
 38308e7fff4ca-3641c633c1dmr4999071fa.40.1758256204053; Thu, 18 Sep 2025
 21:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-x96q-v2-0-51bd39928806@posteo.net> <20250918-x96q-v2-2-51bd39928806@posteo.net>
 <20250918221424.638a5367@minigeek.lan>
In-Reply-To: <20250918221424.638a5367@minigeek.lan>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 19 Sep 2025 12:29:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v67qa6YoZQMoGHhawKHZxsBOiS6ThQrsaCwaGS+oRn58xQ@mail.gmail.com>
X-Gm-Features: AS18NWBfBPM-6yBxX4UPX9zTJX4DDBDlwTc17hVW51BvbFP6qSbAx0_vOFVNPZI
Message-ID: <CAGb2v67qa6YoZQMoGHhawKHZxsBOiS6ThQrsaCwaGS+oRn58xQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: allwinner: h313: Add Amediatech X96Q
To: Andre Przywara <andre.przywara@arm.com>
Cc: =?UTF-8?Q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>, 
	j.ne@posteo.net, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 5:15=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Thu, 18 Sep 2025 12:58:44 +0200
> J. Neusch=C3=A4fer via B4 Relay <devnull+j.ne.posteo.net@kernel.org> wrot=
e:
>
> Hi,
>
> > From: "J. Neusch=C3=A4fer" <j.ne@posteo.net>
> >
> > The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM=
,
> > 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> > output, and infrared input.
> >
> >   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> >
> > Tested, works:
> > - debug UART
> > - status LED
> > - USB ports in host mode
> > - MicroSD
> > - eMMC
> > - recovery button hidden behind audio/video port
> > - analog audio (line out)
> >
> > Does not work:
> > - Ethernet (requires AC200 MFD/EPHY driver)
> > - WLAN (requires out-of-tree XRadio driver)
> > - analog video output (requires AC200 driver)
> > - HDMI audio/video output
> >
> > Untested:
> > - "OTG" USB port in device mode
> > - built-in IR receiver
> > - external IR receiver
> >
> > Table of regulators on the downstream kernel, for reference:
> >
> >  vcc-5v      1   15      0 unknown  5000mV     0mA  5000mV  5000mV
> >     dcdca    0    0      0 unknown   900mV     0mA     0mV     0mV
> >     dcdcb    0    0      0 unknown  1350mV     0mA     0mV     0mV
> >     dcdcc    0    0      0 unknown   900mV     0mA     0mV     0mV
> >     dcdcd    0    0      0 unknown  1500mV     0mA     0mV     0mV
> >     dcdce    0    0      0 unknown  3300mV     0mA     0mV     0mV
> >     aldo1    0    0      0 unknown  3300mV     0mA     0mV     0mV
> >     aldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     aldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     bldo1    0    0      0 unknown  1800mV     0mA     0mV     0mV
> >     bldo2    0    0      0 unknown  1800mV     0mA     0mV     0mV
> >     bldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     bldo4    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     cldo1    0    0      0 unknown  2500mV     0mA     0mV     0mV
> >     cldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
> >     cldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
> >
> > Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
>
> Looks good now, thanks for the changes!
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>
> Chen-Yu: any chance you can still push that, if you agree? U-Boot
> depends on DTs in tagged releases to get this imported.

I can try, but it's also up to Arnd and whether he wants to take a
really late PR or not.

ChenYu

> Cheers,
> Andre
>
> > ---
> >
> > v2:
> > - remove mmc aliases, &mmc0/max-frequency property (Andre Przywara)
> > - document reason for &mmc2/max-frequency property
> > - clean up mmc-releated comments (Andre Przywara)
> > - rename dcdcd regulator to vdd-dram, because it's the only source of
> >   1.5V (needed by the Micron MT41J256M4 DDR3 RAM), and the system halts
> >   when it's turned off.
> > ---
> >  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
> >  arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts | 230 +++++++++++++=
++++++++
> >  2 files changed, 231 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/d=
ts/allwinner/Makefile
> > index 780aeba0f3a4e14d69c9602e37b8d299165507b9..2edfa7bf4ab31c4aa934da9=
8e5e042edc9aaf600 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-mode=
l-b.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mini.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h313-tanix-tx1.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h313-x96q.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-cb1-manta.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-h313-x96q.dts
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..b2275eb3d55b9dacbd9006b=
93795a8011e06bf2f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts
> > @@ -0,0 +1,230 @@
> > +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> > +/*
> > + * Copyright (C) 2025 J. Neusch=C3=A4fer <j.ne@posteo.net>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-h616.dtsi"
> > +#include "sun50i-h616-cpu-opp.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/input/linux-event-codes.h>
> > +#include <dt-bindings/leds/common.h>
> > +
> > +/ {
> > +     model =3D "X96Q";
> > +     compatible =3D "amediatech,x96q", "allwinner,sun50i-h616";
> > +
> > +     aliases {
> > +             serial0 =3D &uart0;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path =3D "serial0:115200n8";
> > +     };
> > +
> > +     reg_vcc5v: vcc5v {
> > +             /* board wide 5V supply directly from the DC input */
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vcc-5v";
> > +             regulator-min-microvolt =3D <5000000>;
> > +             regulator-max-microvolt =3D <5000000>;
> > +             regulator-always-on;
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible =3D "gpio-keys";
> > +
> > +             key-recovery {
> > +                     label =3D "Recovery";
> > +                     linux,code =3D <KEY_VENDOR>;
> > +                     gpios =3D <&pio 7 9 GPIO_ACTIVE_LOW>;
> > +             };
> > +     };
> > +
> > +     leds {
> > +             compatible =3D "gpio-leds";
> > +
> > +             led-0 {
> > +                     color =3D <LED_COLOR_ID_BLUE>;
> > +                     gpios =3D <&pio 7 6 GPIO_ACTIVE_LOW>;
> > +                     default-state =3D "on";
> > +             };
> > +     };
> > +};
> > +
> > +&codec {
> > +     allwinner,audio-routing =3D "Line Out", "LINEOUT";
> > +     status =3D "okay";
> > +};
> > +
> > +&cpu0 {
> > +     cpu-supply =3D <&reg_dcdca>;
> > +};
> > +
> > +&ehci0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ehci3 {
> > +     status =3D "okay";
> > +};
> > +
> > +/* TODO: EMAC1 connected to AC200 PHY */
> > +
> > +&gpu {
> > +     mali-supply =3D <&reg_dcdcc>;
> > +     status =3D "okay";
> > +};
> > +
> > +&ir {
> > +     status =3D "okay";
> > +};
> > +
> > +&mmc0 {
> > +     /* microSD */
> > +     vmmc-supply =3D <&reg_aldo1>;
> > +     cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;  /* PF6 */
> > +     disable-wp;
> > +     bus-width =3D <4>;
> > +     status =3D "okay";
> > +};
> > +
> > +/* TODO: XRadio XR819 WLAN @ mmc1 */
> > +
> > +&mmc2 {
> > +     /* eMMC */
> > +     vmmc-supply =3D <&reg_aldo1>;
> > +     vqmmc-supply =3D <&reg_bldo1>;
> > +     non-removable;
> > +     cap-mmc-hw-reset;
> > +     mmc-ddr-1_8v;
> > +     mmc-hs200-1_8v;
> > +     max-frequency =3D <100000000>; /* required for stable operation *=
/
> > +     bus-width =3D <8>;
> > +     status =3D "okay";
> > +};
> > +
> > +&ohci0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&ohci3 {
> > +     status =3D "okay";
> > +};
> > +
> > +&r_i2c {
> > +     status =3D "okay";
> > +
> > +     axp305: pmic@36 {
> > +             compatible =3D "x-powers,axp305", "x-powers,axp805",
> > +                          "x-powers,axp806";
> > +             interrupt-controller;
> > +             #interrupt-cells =3D <1>;
> > +             reg =3D <0x36>;
> > +
> > +             x-powers,self-working-mode;
> > +             vina-supply =3D <&reg_vcc5v>;
> > +             vinb-supply =3D <&reg_vcc5v>;
> > +             vinc-supply =3D <&reg_vcc5v>;
> > +             vind-supply =3D <&reg_vcc5v>;
> > +             vine-supply =3D <&reg_vcc5v>;
> > +             aldoin-supply =3D <&reg_vcc5v>;
> > +             bldoin-supply =3D <&reg_vcc5v>;
> > +             cldoin-supply =3D <&reg_vcc5v>;
> > +
> > +             regulators {
> > +                     reg_dcdca: dcdca {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <810000>;
> > +                             regulator-max-microvolt =3D <1100000>;
> > +                             regulator-name =3D "vdd-cpu";
> > +                     };
> > +
> > +                     dcdcb {
> > +                             /* unused */
> > +                     };
> > +
> > +                     reg_dcdcc: dcdcc {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <810000>;
> > +                             regulator-max-microvolt =3D <990000>;
> > +                             regulator-name =3D "vdd-gpu-sys";
> > +                     };
> > +
> > +                     dcdcd {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <1500000>;
> > +                             regulator-max-microvolt =3D <1500000>;
> > +                             regulator-name =3D "vdd-dram";
> > +                     };
> > +
> > +                     dcdce {
> > +                             /* unused */
> > +                     };
> > +
> > +                     reg_aldo1: aldo1 {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <3300000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-name =3D "vcc3v3";
> > +                     };
> > +
> > +                     aldo2 {
> > +                             /* unused */
> > +                     };
> > +
> > +                     aldo3 {
> > +                             /* unused */
> > +                     };
> > +
> > +                     reg_bldo1: bldo1 {
> > +                             regulator-always-on;
> > +                             regulator-min-microvolt =3D <1800000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-name =3D "vcc1v8";
> > +                     };
> > +
> > +                     bldo2 {
> > +                             /* unused */
> > +                     };
> > +
> > +                     bldo3 {
> > +                             /* unused */
> > +                     };
> > +
> > +                     bldo4 {
> > +                             /* unused */
> > +                     };
> > +
> > +                     cldo1 {
> > +                             /* unused */
> > +                     };
> > +
> > +                     cldo2 {
> > +                             /* unused */
> > +                     };
> > +
> > +                     cldo3 {
> > +                             /* unused */
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&uart0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&uart0_ph_pins>;
> > +     status =3D "okay";
> > +};
> > +
> > +&usbotg {
> > +     dr_mode =3D "host";       /* USB A type receptacle */
> > +     status =3D "okay";
> > +};
> > +
> > +&usbphy {
> > +     status =3D "okay";
> > +};
> >
>
>

