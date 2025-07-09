Return-Path: <linux-kernel+bounces-724180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA3AFEFA9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361F67B3FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F53922425E;
	Wed,  9 Jul 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alRnUFng"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBC156F4A;
	Wed,  9 Jul 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081399; cv=none; b=mfZY/DHRuPIq9JoC4TZDO7VYQIx1NptxBtmxhQvf9yq+CJu774Yg/h0WMwg9bRxQOzWl39rpGhbdFw/AXT2CzmxImh4wCeEY7dgDG5h1rdJjxCTsmtHKCcv0RTqIktEpfsXa3ZaA8Y2ituk+TtUWhD/pfdUdtD8MIbxNiwQULdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081399; c=relaxed/simple;
	bh=RNmpvjGUOHESBcqLpGY3qlY2fG9Y//yaVdSvoRsaCFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lec5PoHN1QPDHi+HWBoZfI4LIg3cMhn2e1JGU9KJfDlXB4Q87j6cTH1GdvhtAVayI5pFu0iTMX5exk7qcQr4eX4SDspjyAFRBDayYmOVcjNPlCrp4O7kYKKH0NOTti/0HrqvdpxNgER/KipTAgRwriEScTEDi8r1rvyAu+IXS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alRnUFng; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-711a3dda147so1877697b3.2;
        Wed, 09 Jul 2025 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752081396; x=1752686196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jOEjp0rI68+oAu3N7tGiFdzG9GzJlC8rN3jpoD8NMRI=;
        b=alRnUFngAaBsggY2ypWqcd4UKimnGJzIZx2ONgqEUymLrkzV7yFAgFMYsvOCw072hJ
         CVDdcB/ZmL3M6bZ5Q7y69j/kq0EbTcLZbkPLbEDV2TkJlt3IovPEdlbUxUt6fx6/pcOs
         jCDp/bBd9RQQiI7tVLSSBMLZ6weNBjEQg12B6IRUDIFKVmgFp1c0ESsu0Yhxg8uVxAd2
         y8XpoYsTq+V78lGVKteckITvU2M1zSIw70kMAWeuKhVWfSu5Y3shywvkCbELql3PMhWc
         IsipBCIIcLNcAtVnItuJGnWrYqysMTjgvE2llKDcsbU9rnmTWn8ZBVLOVMh/HGvs+JPQ
         7vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752081396; x=1752686196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOEjp0rI68+oAu3N7tGiFdzG9GzJlC8rN3jpoD8NMRI=;
        b=MkITA7Lm0Bg4JhEwGV4yVhLKD03oaBaCUVqrcJvFJB7aOZ1UkUato7A8QTRSP3+Fho
         h/G6R8nt7G2rbamLcyo4N3xB+sTdWtpEUqOqmAASwqiq5vx9kRijv7Vm9FekSKXX0hUi
         QouyyK+NYFO7Hk2DafmdujylNgJdq6UHLYt9Aw0JWqwqExx/XkCVvrtkK1ljUdkfYtte
         YKwXpvev1x1+y3V7aZGEy/HBVRVj/2SUrJUjwHICgMQpiW83JFk3DCeXeKX3vqyjZMQb
         pLYap09GjAr7HFFAMwZyFwmEAnsFKMG44VYsiUuaGl5S7HQp1AtOANQWABR39OTNqyQt
         Jwvg==
X-Forwarded-Encrypted: i=1; AJvYcCW2DS/V6chDT1aCxoWthjCIH7GXEed/mv7NVwQDTR4WUPSNKG+9qePxq/aI5+QZ2Oe6aPH/UuouLNBmbHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZoUgHr6HMZtDrddPPc6ESyLmjWWDqYwktpKV1mUUUQONNLIrZ
	x0lWez55ENd4iaVokZ8g3HFUvKTkyEJ/xgySkaMgm0cWdtH1CZdxptWJ/KRiRTKpwvRXFMkUwyK
	jOunTGIn5Mkpq1qrSJEeZsXHRCPo96Ac=
X-Gm-Gg: ASbGncvnwVe19QqzE1YRq6Z07vtwVEtgKbp25M6N8K9eni62INjxqxolReLmoU0KJC/
	ekWKZklaA4RF1OIDz+nqpkN/Gf+tuIKXAu4ePgmGQYjCeqO2YgdNlvXcvbr+DfEvQe9cPk05d8l
	mV7L41VbXbSLN7aRl39xcGWndH6tHDnx9Of10x0OuM1dS0iftnqC+S
X-Google-Smtp-Source: AGHT+IG+AR194uVOXn9cJKdMqorA7Nt38ozun9vVht7g1aQ/Y5/WltzQmb4TmFCfzfv+s2fG57LMCLN/GK/DBbGpONQ=
X-Received: by 2002:a05:690c:d0d:b0:712:d70b:45eb with SMTP id
 00721157ae682-717b19cb385mr50098157b3.31.1752081396367; Wed, 09 Jul 2025
 10:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
 <20250708184841.72933-3-stefano.radaelli21@gmail.com> <0454b830-b9bf-4d04-8e91-d5c514ac4aae@kernel.org>
In-Reply-To: <0454b830-b9bf-4d04-8e91-d5c514ac4aae@kernel.org>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Wed, 9 Jul 2025 19:16:20 +0200
X-Gm-Features: Ac12FXwi3-PTorWyZPZXK4OAkGLyFPpogeHMEzObU5YvDrGXWl8TmNln6b1jYBg
Message-ID: <CAK+owoiL8613hEqDso7cCbqw9vT-TV0eRLvJPq81ZwVDHT7rHA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello Krzysztof,

thank you for your corrections, I completely forgot to compile with
the W=1 flag.

I'll take care of everything,

Best Regards,

Stefano

Il giorno mer 9 lug 2025 alle ore 10:46 Krzysztof Kozlowski
<krzk@kernel.org> ha scritto:
>
> On 08/07/2025 20:48, Stefano Radaelli wrote:
> > Add device tree support for the Variscite VAR-SOM-AM62P system on module.
> > This SOM is designed to be used with various carrier boards.
> >
> > The module includes:
> > - AM62Px Sitara MPU processor
> > - Up to 8GB of DDR4-3733 memory
> > - eMMC storage memory
> > - PS6522430 chip as a Power Management Integrated circuit (PMIC)
> > - Integrated 10/100/1000 Mbps Ethernet Transceiver Analog Devices ADIN1300
> > - Resistive touch panel interface controller TI TSC2046
> > - I2C interfaces
> >
> > Only SOM-specific peripherals are enabled by default. Carrier board
> > specific interfaces are left disabled to be enabled in the respective
> > carrier board device trees.
> >
> > Link: https://www.variscite.it/product/system-on-module-som/cortex-a53-krait/var-som-am62p-ti-sitara-am62px/
> >
> > Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 379 ++++++++++++++++++
> >  1 file changed, 379 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> > new file mode 100644
> > index 000000000000..1d4ebc484d55
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
> > @@ -0,0 +1,379 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Common dtsi for Variscite VAR-SOM-AM62P
> > + *
> > + * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
> > + * Copyright (C) 2025 Variscite Ltd. - https://www.variscite.com/
> > + *
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +#include "k3-am62p5.dtsi"
> > +
> > +/ {
> > +     compatible = "variscite,am62p-var-som", "ti,am62p5";
> > +
> > +     iw612_pwrseq: iw612_pwrseq {
>
> Follow DTS coding style. This applies to multiple places.
>
> Also:
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
>
> > +             compatible = "mmc-pwrseq-simple";
> > +             post-power-on-delay-ms = <100>;
> > +             power-off-delay-us = <10000>;
> > +             reset-gpios = <&main_gpio0 54 GPIO_ACTIVE_LOW>, /* WIFI_PWR_EN */
> > +                           <&main_gpio0 59 GPIO_ACTIVE_LOW>; /* WIFI_EN */
> > +             status = "okay";
>
> Why? Drop.
>
> > +     };
> > +
> > +     emmc_pwrseq: pwrseq@0 {
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.
>
> > +             compatible = "mmc-pwrseq-emmc";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&emmc_pwrseq_pins>;
> > +             reset-gpios = <&main_gpio0 49 GPIO_ACTIVE_LOW>;
> > +     };
> > +
> > +     memory@80000000 {
> > +             /* 8G RAM */
> > +             reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> > +                   <0x00000008 0x80000000 0x00000001 0x80000000>;
> > +             device_type = "memory";
> > +             bootph-pre-ram;
> > +     };
> > +
> > +     opp-table {
> > +             /* Add 1.4GHz OPP for am62p5-sk board. Requires VDD_CORE at 0v85 */
> > +             opp-1400000000 {
> > +                     opp-hz = /bits/ 64 <1400000000>;
> > +                     opp-supported-hw = <0x01 0x0004>;
> > +                     clock-latency-ns = <6000000>;
> > +             };
> > +     };
> > +
> > +     reserved_memory: reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             rtos_ipc_memory_region: rtos-ipc-memory@9b500000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9b500000 0x00 0x00300000>;
> > +                     no-map;
> > +             };
> > +
> > +             mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9b800000 0x00 0x00100000>;
> > +                     no-map;
> > +             };
> > +
> > +             mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9b900000 0x00 0x00f00000>;
> > +                     no-map;
> > +             };
> > +
> > +             wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9c800000 0x00 0x00100000>;
> > +                     no-map;
> > +             };
> > +
> > +             wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x00 0x9c900000 0x00 0x01e00000>;
> > +                     no-map;
> > +             };
> > +
> > +             secure_tfa_ddr: tfa@9e780000 {
> > +                     reg = <0x00 0x9e780000 0x00 0x80000>;
> > +                     no-map;
> > +             };
> > +
> > +             secure_ddr: optee@9e800000 {
> > +                     reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> > +                     no-map;
> > +             };
> > +     };
> > +
> > +     vcc_3v3: vcc-3v3 {
>
> Please use name for all fixed regulators which matches current format
> recommendation: 'regulator-[0-9]v[0-9]'
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml?h=v6.11-rc1#n46
>
>
> Best regards,
> Krzysztof

