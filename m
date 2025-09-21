Return-Path: <linux-kernel+bounces-826214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD0EB8DDBD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FFD3BC780
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC771D5CD4;
	Sun, 21 Sep 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFgJMfqW"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58E78F59
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758470179; cv=none; b=uKRQkGph2p6diTaRPBQ89MpVbMK6hzeYl/ENJCtdx8MPnV0sh6sfWygljlaAA6Gw7R/Ym4zZaVY+vLZgwUqrfNoGsoIYjAtaE5irsfGifG5PN5jSc3+ZOQ3O9+hCgE3iaRxQnU0JwnX6VYXH+OfynMdFzO9vVWyAFwQiK21DHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758470179; c=relaxed/simple;
	bh=sPbXDhNsIfKYFsysxbc2lokhG+PRuFBiQ2NVbrX+gQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3mIMi68Q4LlvzO3MfHjX1bHOAQ3RtnxvNkF4anuo/t+D/voI6CQSgVMBDtoJzMteUtamYCb6i9L6TSWEb4QuB541MdFLc9LEfnKKFn6tZ9tQd1gQWmarBmRMsNimJZdvqVk4s1bUu0P06NM3FNlmRAwHIwyxbEqTllhGGinxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFgJMfqW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6014810fso27217177b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758470177; x=1759074977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLKMCTLJtHM1Lwpq0qmHNGY4yNV1zxLW/dk1qzk5zZU=;
        b=bFgJMfqWNJY+UhoDhF+1/rTiU4idoRNTuF2oqQkX2lmnSwfwRlpwUDU4JVc7VlQB73
         r4ZPrwwVTi8yS2678bah38jo9JGO6bPv3Ylc3EdBZq9Zl26qawhM+DBAXmLpgQoEhELZ
         9mp8Zj/+c/fetHbf9kIoaF/dHjQSJQAhxA1/DL0vuddDM141XXQUutMst43QfosVBpj8
         XkbpkUbjuSOFTIHv0xl5Fkci5Nil7xmcJgBp3jFyXgSNJRa4+jp0v2zLTQt/2yQmK0hv
         2E55cbiO/2CSAPgpF9Ta52tOdagywCxzPvUNZEXZ6sxXhNU/HoZldtyDLwFDVDzP6iAF
         oU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758470177; x=1759074977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLKMCTLJtHM1Lwpq0qmHNGY4yNV1zxLW/dk1qzk5zZU=;
        b=a8kHYkJnAhz1qqDExFceI3Wb94A2VlmICXPKKVW89WQyvxlF//FFC2FS/VZWXR2IDu
         mRClXNAWK6GR9SNHflYxtxGoNlNii9jVr9/jffc4R4D/hTbBptH7/S4CKRQdtbdfO4Tt
         Ds9IizYHwfGzEC30P/ky9MfKiWgzKHd5mt88Jl0sMHVkmZAphQE8Xx6f34khpDCY5zvd
         MT5LxbBjIGTy22WyPuwxiXetudbnQydLezsWLYRxwHjnlwt4HnLCr5GuK5YbiPeKPh7P
         IyTb5+grQfNEtK/1eIvAkHlW5+dTaRXVZku8lhRaqtm8kCBA5MZ/jzi7thmdDDaS7d6x
         Q0bA==
X-Forwarded-Encrypted: i=1; AJvYcCVnDr3AI1hza/4zUsttck4qlXhuqEAhS9wZGAwCns5EETOBd5nrLKB8BgS1ClaelYmaPS9VzX9vUxH/ks4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqYmVGSxFY+grxNOBX88YL6e98gzowgLROuX8ARVmIO0rEWEN
	6QFyXlzh6nfOz4Dgned3VJwCaf2Tr+KE9gZMWWXsSP/PeKOlsY9wWKmpYWVxBoclzAm4/ylVhXE
	dOZNSFKfUpPmnP2aZD48SWI1yN0cQHZo=
X-Gm-Gg: ASbGncsomxtzb27KDXGLS3hBTiiihKbkjvAlXSguILvtoIG36yBiMlBnYNYveqN3gjY
	OXT9y01CDlP4cisJHJQcaS1AxTCU6dDXC519z6wLLRaWXqWIs9N3tmYA9nE2T+7/6hPOD5yDwwj
	Pxl2MgEcXIky5bI43PBM5l+1YtFA2Hk2S1UKFfHUP63fMf6Q/bVxNWTbJ70ubZtRLkKyKaH4M6x
	qktU2i4
X-Google-Smtp-Source: AGHT+IGgO+X7miV6LNYKAksD5CC+FlAiqo7XuJwAT3QL4jWCwKxajPkFDuayvhoiIhJp3qESyCFtQ3Frh8GV2vrPVUY=
X-Received: by 2002:a05:690c:338f:b0:73c:2f51:cac2 with SMTP id
 00721157ae682-73d3d530629mr87539337b3.45.1758470176723; Sun, 21 Sep 2025
 08:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908125938.3584927-1-tmaimon77@gmail.com> <20250908125938.3584927-2-tmaimon77@gmail.com>
 <bee023bb9b2ccb3e2437e466190dff2304268db9.camel@codeconstruct.com.au>
In-Reply-To: <bee023bb9b2ccb3e2437e466190dff2304268db9.camel@codeconstruct.com.au>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Sun, 21 Sep 2025 18:56:05 +0300
X-Gm-Features: AS18NWDKVTz6-nhMqj63jLLM1lEB2xxFv9djsAQVtO6xKVU4pzQViY5NfGj-uLY
Message-ID: <CAP6Zq1j83gOX0vGX3tR09c3S4_DSX4uCcM8TqbFxeP5zXNn2ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: nuvoton: npcm845: Add peripheral nodes
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thanks for your comments.

On Wed, 10 Sept 2025 at 10:52, Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Tomer,
>
> On Mon, 2025-09-08 at 15:59 +0300, Tomer Maimon wrote:
> > Enable peripheral support for the Nuvoton NPCM845 SoC by adding device
> > nodes for Ethernet controllers, MMC controller, SPI controllers, USB
> > device controllers, random number generator, ADC, PWM-FAN controller,
> > and I2C controllers. Include pinmux configurations for relevant
> > peripherals to support hardware operation. Add an OP-TEE firmware node
> > for secure services.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 702 +++++++++++++++++-
> >  .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |   7 +
> >  2 files changed, 708 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > index 24133528b8e9..7f120da3310a 100644
> >
>
> *snip*
>
> > +               fiu1: spi@fb002000 {
> > +                       compatible = "nuvoton,npcm845-fiu";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0x0 0xfb002000 0x0 0x1000>;
> > +                       reg-names = "control";
> > +                       clocks =  <&clk NPCM8XX_CLK_SPI1>;
> > +                       clock-names = "clk_spi1";
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&spi1_pins>;
> > +                       status = "disabled";
> > +               };
> > +
> > +               fiu3: spi@c0000000 {
> > +                       compatible = "nuvoton,npcm845-fiu";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0x0 0xc0000000 0x0 0x1000>;
> > +                       reg-names = "control";
> > +                       clocks =  <&clk NPCM8XX_CLK_SPI3>;
> > +                       clock-names = "clk_spi3";
> > +                       pinctrl-names = "default";
> > +                       pinctrl-0 = <&spi3_pins>;
> > +                       status = "disabled";
> > +               };
I don't need to move the FIU3 node as ordered by ascending unit
address since the FIU3 node is a part of the FIU's group, am I
correct?
> > +
> > +               fiux: spi@fb001000 {
> > +                       compatible = "nuvoton,npcm845-fiu";
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0x0 0xfb001000 0x0 0x1000>,
> > +                       <0x0 0xf8000000 0x0 0x2000000>;
> > +                       reg-names = "control", "memory";
> > +                       clocks =  <&clk NPCM8XX_CLK_SPIX>;
> > +                       clock-names = "clk_ahb";
> > +                       status = "disabled";
> > +               };
>
> Can you please audit the patch (and the rest of the dtsi) to make sure
> all nodes are ordered by ascending unit address, as per the DTS style
> guide?
>
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes
>
> Andrew
>
> > +
> > +               mc: memory-controller@f0824000 {
> > +                       compatible = "nuvoton,npcm845-memory-controller";
> > +                       reg = <0x0 0xf0824000 0x0 0x1000>;
> > +                       interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +               };
> > +
>
> *snip*

I see disorder in the upstream dtsi file, for example, PECI order. Do
you suggest fixing it?

peci: peci-controller@100000 {
compatible = "nuvoton,npcm845-peci";
reg = <0x100000 0x1000>;
interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
clocks = <&clk NPCM8XX_CLK_APB3>;
cmd-timeout-ms = <1000>;
status = "disabled";
};

timer0: timer@8000 {
compatible = "nuvoton,npcm845-timer";
interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
reg = <0x8000 0x1C>;
clocks = <&clk NPCM8XX_CLK_REFCLK>;
clock-names = "refclk";
};

Thanks,

Tomer

