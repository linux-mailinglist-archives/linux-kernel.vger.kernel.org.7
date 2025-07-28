Return-Path: <linux-kernel+bounces-747920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CFB13A42
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED033BD03A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F3263892;
	Mon, 28 Jul 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7Dxswoe"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86839111A8;
	Mon, 28 Jul 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753704791; cv=none; b=sRp95fo4MIs3BhAj/14H4BWCNRgvjIwHVBT+alGfAoyXi/5FKvpAyHZ1p97yhJzqBf8P1NJw2y0Yzncmyar2T4K2ne5cUWLprKL9M2YjEvrqKRQyNZnQFeh8GjANCSVSBQEV9zV/k9Tdr6XVCFhUiY3CCGcH8e2L38MmLZ9l0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753704791; c=relaxed/simple;
	bh=HYUWhbWOKlbw8muyuXJSNrhK49HJSYsKQccZBl/mdO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRM4dgRVud1n7xve7yoG4DO0bDSaENlTH1kLJLkYXf/iWblnFvG6FoxrFolyN8RVVknCpLqksbjppvVLiBpEGMPQmtWDyeGeJrgnxSG7J8AAt7SKI/Ww4Ms1ArS7pl8ewp5b9gfMVcTF9phK+BMXsJBx8XcziMxsGCK10upQ/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7Dxswoe; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8e21180c55so217592276.3;
        Mon, 28 Jul 2025 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753704788; x=1754309588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsezd7035FWrqFWuFHCh68rbnE7LES6kmMFx8Udf+XY=;
        b=J7Dxswoe0RJqGJjjtJSEdjYbGHYStA+r5NMz1SePJxowfgbIGR2JQLUSTAVZLroZo8
         l5GF1M2CXytKb6Qn864fur8oVEeelNqttKWhRUHhzyg8SaXKj7hutfHBb+sHKlV+azQE
         oC2cmglOkycrfvn0U25InpJ+jtWB1KF9lCVAID1KlPNKeaFYNtqaiDt31tySaxBk/D2g
         FDjBcO/pz4uHtWrwGuWs7Hm2y691uTDfTT4CpWRjcRKYwbqZJ+86VtINxkPKZf8bbjoZ
         y6W0Sw4G4HDRSsxukz/wIyhtI+MejYwaqAwMzV1CrTh+yprI4+1lPjYBstxrrqjXxo6L
         KBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753704788; x=1754309588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zsezd7035FWrqFWuFHCh68rbnE7LES6kmMFx8Udf+XY=;
        b=FAYAU1AWICGgRUMLjtZq+Dk6Gwv/xa38GzLQ9WHHF0FUw6dKzIND8Ya8cAQo/6o9/M
         TUxtOpVQ74Ym2k8NXQr/EFAJaKWYp9JFjxu2usIBcmn2c9aeXIiP5Db41eLQBzQjc3/L
         B4y//GRE+5SL5YGjvVI0imYN27G4dAmrBpDIjBahQzZHK1elNVYkCO/j7agBBHOzt2Ky
         JzzOKfQKBPLbFBZXxxtD5ml1YVfAFWfggWhQeykeMeWuze3PuAdhCqIqShdw1TZhqTvy
         11F9biIys9qx748nIe5bjoUFQS1q+3jNqSxjSpLbq6HSZpmjm/r+4Z3mTJKgdNfFalUd
         UHyA==
X-Forwarded-Encrypted: i=1; AJvYcCUilqV5uPsUnbckqNI+OnSYXHFQlAO00+cWvlGL8YVaZQVDEhV8Kbr4G31EMOnO5/RjosYUTdVAKkAWfQkC@vger.kernel.org, AJvYcCUnLd2hBKQqbnNTjiXt0uNhuRzgEG2tYOGcSmJ4LtaQo7GfpF2yDW+11oQMhISkHcW44y1S63G4d6LA@vger.kernel.org
X-Gm-Message-State: AOJu0YznqbImCygU476Wlk8Hr2s9TVsfP7WLnJo0kDThGiDCOebQhHlU
	b82BHDvSUmQ8C0MtWaMpRIWeaC9DoVjEgBIWCXIaKdkh53u3lXhaaQUM5Vrg3gMBrOzxuTBhAlf
	g+J2IbMM9ejINq8DhBbM8YIgOA93Ngyw=
X-Gm-Gg: ASbGncuIDzmp8p/ofuCIRafydEGs08eX4NNhSDQKuZFOCrFCOevoiY0g+L5qF+A87V2
	g3DDTsaBy27utjV3S0b8usX9RPQUiN9L02fu6GNuosCJPG7bP3OzjpSHsXbPRl3hXknWaB2lBco
	h4uWi7hSkWLPoKiR0wUWObhCtFe9xJiizzVRCZrT6ZrOz4WiVrz4hrSUm9uR6/vesOCQsAbTX04
	AZmZfVRobatNO0qu2A=
X-Google-Smtp-Source: AGHT+IE8FetLs5kAG2M95H1SElMF1ElnmLebXhF8d1vIxkrificfFFIDGgsiSxE7aw3pmWHgxRWdkzdSkbDxAbeKrdU=
X-Received: by 2002:a05:6902:120d:b0:e8d:72e4:d9d4 with SMTP id
 3f1490d57ef6-e8df113b799mr11716674276.16.1753704788230; Mon, 28 Jul 2025
 05:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717135336.3974758-1-tmaimon77@gmail.com> <20250717135336.3974758-3-tmaimon77@gmail.com>
 <91119587-789e-485d-9cf1-da2c500f241c@linaro.org>
In-Reply-To: <91119587-789e-485d-9cf1-da2c500f241c@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 28 Jul 2025 15:12:57 +0300
X-Gm-Features: Ac12FXzZw67wcluhlx6LMwL2nF0Ah8oDkSDAC4rYqJ1oF1eanGYALYu78M07rHs
Message-ID: <CAP6Zq1gN28y-6_OwnzMbJ+EiubtABVw+FUqbmAo5bvBW-5tDdw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: nuvoton: npcm845-evb: Add peripheral nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 17 Jul 2025 at 17:25, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/07/2025 15:53, Tomer Maimon wrote:
> > Enable peripheral support for the Nuvoton NPCM845 Evaluation Board by
> > adding device nodes for Ethernet controllers, MMC controller, SPI
> > controllers, USB device controllers, random number generator, ADC,
> > PWM-FAN controller, I2C controllers, and PECI interface.
> > Include MDIO nodes for Ethernet PHYs, reserved memory for TIP, and
> > aliases for device access.
> > This patch enhances functionality for NPCM845-EVB platform.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  | 445 ++++++++++++++++++
> >  1 file changed, 445 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> > index 2638ee1c3846..46d5bd1c2129 100644
> > --- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> > +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
> > @@ -10,6 +10,42 @@ / {
> >
> >       aliases {
> >               serial0 = &serial0;
> > +             ethernet1 = &gmac1;
> > +             ethernet2 = &gmac2;
> > +             ethernet3 = &gmac3;
> > +             mdio-gpio0 = &mdio0;
> > +             mdio-gpio1 = &mdio1;
> > +             fiu0 = &fiu0;
> > +             fiu1 = &fiu3;
> > +             fiu2 = &fiux;
> > +             fiu3 = &fiu1;
> > +             i2c0 = &i2c0;
> > +             i2c1 = &i2c1;
> > +             i2c2 = &i2c2;
> > +             i2c3 = &i2c3;
> > +             i2c4 = &i2c4;
> > +             i2c5 = &i2c5;
> > +             i2c6 = &i2c6;
> > +             i2c7 = &i2c7;
> > +             i2c8 = &i2c8;
> > +             i2c9 = &i2c9;
> > +             i2c10 = &i2c10;
> > +             i2c11 = &i2c11;
> > +             i2c12 = &i2c12;
> > +             i2c13 = &i2c13;
> > +             i2c14 = &i2c14;
> > +             i2c15 = &i2c15;
> > +             i2c16 = &i2c16;
> > +             i2c17 = &i2c17;
> > +             i2c18 = &i2c18;
> > +             i2c19 = &i2c19;
> > +             i2c20 = &i2c20;
> > +             i2c21 = &i2c21;
> > +             i2c22 = &i2c22;
> > +             i2c23 = &i2c23;
> > +             i2c24 = &i2c24;
> > +             i2c25 = &i2c25;
> > +             i2c26 = &i2c26;
> >       };
> >
> >       chosen {
> > @@ -25,12 +61,421 @@ refclk: refclk-25mhz {
> >               clock-frequency = <25000000>;
> >               #clock-cells = <0>;
> >       };
> > +
> > +     reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             tip_reserved: tip@0 {
> > +                     reg = <0x0 0x0 0x0 0x6200000>;
> > +             };
> > +     };
> > +
> > +     mdio0: mdio@0 {
>
> Huh... this should fail checks. It's not MMIO node, is it?
No, it's MDIO node,
https://elixir.bootlin.com/linux/v6.16-rc7/source/Documentation/devicetree/bindings/net/mdio-gpio.yaml#L48
Should I modify the node name? If yes, which node name should I use?
>
>
> > +             compatible = "virtual,mdio-gpio";
>
> where is the reg?
It does not include reg in the mother node, but only in the child.
>
> Please confirm that you introduced no new dtbs_check W=1 warnings.
>
> > +             gpios = <&gpio1 25 GPIO_ACTIVE_HIGH>,
> > +                     <&gpio1 26 GPIO_ACTIVE_HIGH>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             phy0: ethernet-phy@1 {
> > +             };
> > +     };
> > +
>
> ...
>
> > +             reg = <0x05>;
> > +             fan-tach-ch = /bits/ 8 <0x0A 0x0B>;
> > +             cooling-levels = /bits/ 8 <127 255>;
> > +     };
> > +     fan@6 {
> > +             reg = <0x06>;
> > +             fan-tach-ch = /bits/ 8 <0x0C 0x0D>;
> > +             cooling-levels = /bits/ 8 <127 255>;
> > +     };
> > +     fan@7 {
> > +             reg = <0x07>;
> > +             fan-tach-ch = /bits/ 8 <0x0E 0x0F>;
> > +             cooling-levels = /bits/ 8 <127 255>;
> > +     };
> > +};
> > +
> > +&pspi {
> > +     cs-gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
> > +     status = "okay";
> > +     Flash@0 {
>
> DTS coding style, naming...
>
>
>
> Best regards,
> Krzysztof

Thanks,

Tomer

