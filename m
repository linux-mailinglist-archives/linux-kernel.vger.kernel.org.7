Return-Path: <linux-kernel+bounces-846250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CB9BC7627
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48A054EA341
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E40259CAB;
	Thu,  9 Oct 2025 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Kd3yZLW"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC29259CB3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759984897; cv=none; b=NLz5VQYfkoLvCTMIMk6YhpP98Ik6RoSdVtf3O5eFUiPtg1In2695C8EI7/Xp7AEg3k3KTsU90sEnM74QJa//QdvS5RUn3HdY3aDZ/a4Qi4u7beM/ENlEf8BeYrYobqgiatTryC2su7X2dH6uvEN1qr8OtZJfZEPZOkBpCDnGKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759984897; c=relaxed/simple;
	bh=JSx+GA5ZXRbiW2N5KmdbA/YFhbngtu5rtQbXWzmld/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyfitiux3BtodfX4RxC3Dqfx8RESw4Lj7ACm+p/FZJtxrG4W7pKFXForSEkPrnRu7ZGbA/awON2BmhMsr3jYu8Y/DVFZM2Xs7h03bzBMQFLxAsydh/czlTVilYYWPeJpiQIHSMma4NQOf4THtideCwltC23bYbTt4Vx1ql0vjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Kd3yZLW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so331757a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 21:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759984894; x=1760589694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qfg2KUrH0ld2loH5dM6+owKjkO3ztYQAbVtuXjduw8k=;
        b=0Kd3yZLWRkcI6RhWR7P/x98nLJ98OFi8ZKJwjF5yxxCeCglXq1kopgT3Ahm/pMpB/P
         u/x+bDOKBe7sWrXMUa3B3C2Ru2hxMuHTi8JTE2h/KuIBrtezQpYhI1zEz+m/eiP0XIG1
         eqh4ooq/pKTnjDv23i+HDhpszMEPLNPGGt1VCzUBgZI61WREsY2Psqu/1HUOOpLlCmn9
         Me4/7Hp+Heo4e+xJV7lGF+ObvAKFjhfO+4JNN9kJDXLNd5BWDXvJyJOcyE6WgJly7ef+
         koCDlgnGy8sUv1nK9miY/VXX7aR0s7WkU3WBiw4KqT8L/SgvrX06oeuM6+HqCbvt5sJI
         bICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759984894; x=1760589694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qfg2KUrH0ld2loH5dM6+owKjkO3ztYQAbVtuXjduw8k=;
        b=Y+ByNSh6mGxxC83pL8k13j8bxvbSSfbDBti0rQ/193wqo2L6CQw7yVeXu3ZKn2SxpH
         ixqhZomlDputbThnKj7+GRiJa6SA7hh6y9PyeS0ITPILS6oX+sBvnBKS8To5+uzFO3ow
         D5000okF+fSNo4UDf0Ml/ESLzrMEZx3SV3U5hzkeYfPbBfl3hDqs6SredNXb4O38yi9/
         lv+RAW5GuPTCoALGUYOGjSzpRU0lpZDVcr9rbMKlo7w9ESipr8RzcZLDIn5vLZ/zZonP
         H+y4emkYRQIko0V8bjmk4o6WZyKzCrbVsiui9mW7AsbO/Szxwjn5oZT8S5u+tDpvTUC5
         VLtg==
X-Forwarded-Encrypted: i=1; AJvYcCVoVAyPu4HE13ZK979TD+ig7Wr68nNVKgolpWBVspNJCobYimNYU1TRsEkiSE9q5sb0n5Rsuzs/zPrdd0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7zQUXt+EN7pMCP9951KtPkoKQiOSlYqA/2QPEDnnQTaaWd4l
	kdPrxMwXGqAPQcy03Q9FGU8wUdIN1aT7OAdsQEiyrpEEpa5VdJz+jAn+nL1usgE66C/jjHMIxh2
	56p4Jmz3XaKy6Rlat7L+LM94RGF+8AUKay77Xmev2
X-Gm-Gg: ASbGncuMke11jQB1RQ1UoqncfIIvX2sRFNxxGnZdMr1vTQudo0fU/QwFWwuOyxm0tlz
	82aQleGzai3Y0zSoX6pwgYbQiw6Q0a4NuYufBq+lg/CAKzBKh163B8rdXma4SK9wTpzUUGzIZBZ
	VVF8mxK+wc5L2tidSHi+1jrCpowC8kuj8kvkBQvX14VGmUZXI10Yd1XUSP8erd3TPTB26MMS47S
	Bv/2H77XEBknI/uwoMvYBcHfs3+h2sLCNX6Z5qvsEZIqeW1aEOeHOfYXCw/KjfP4ibus2s=
X-Google-Smtp-Source: AGHT+IHq7WMGknZC9D22TiuSJobcSs2r+0inHJ0URZqm945Ibpmj/rMeznufzslM6ZAVx62ePKO1/By8R2qOoulx2p4=
X-Received: by 2002:a17:903:240e:b0:25c:b1d6:c41a with SMTP id
 d9443c01a7336-290273568efmr77605215ad.11.1759984894045; Wed, 08 Oct 2025
 21:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008060000.3136021-1-royluo@google.com> <20251008060000.3136021-2-royluo@google.com>
 <20251008-slider-uncombed-66790ea92ea0@spud>
In-Reply-To: <20251008-slider-uncombed-66790ea92ea0@spud>
From: Roy Luo <royluo@google.com>
Date: Wed, 8 Oct 2025 21:40:57 -0700
X-Gm-Features: AS18NWDwvHFFVwwFF0xyUsh6hOplsl-LTeW3KNkkNIVFS6G7WbYp6KqWo-pnIz8
Message-ID: <CA+zupgxnBK_k2X0_KKX9pUMMTwY4VhsyTEEVz6v+__u=2xR8Ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: dwc3: Add Google Tensor G5 DWC3
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Joy Chakraborty <joychakr@google.com>, 
	Naveen Kumar <mnkumar@google.com>, Badhri Jagan Sridharan <badhri@google.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 1:58=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Wed, Oct 08, 2025 at 05:59:57AM +0000, Roy Luo wrote:
> > Document the device tree bindings for the DWC3 USB controller found in
> > Google Tensor SoCs, starting with the G5 generation.
> >
> > The Tensor G5 silicon represents a complete architectural departure fro=
m
> > previous generations (like gs101), including entirely new clock/reset
> > schemes, top-level wrapper and register interface. Consequently,
> > existing Samsung/Exynos DWC3 USB bindings and drivers are incompatible,
> > necessitating this new device tree binding.
> >
> > The USB controller on Tensor G5 is based on Synopsys DWC3 IP and featur=
es
> > Dual-Role Device single port with hibernation support.
> >
> > Signed-off-by: Roy Luo <royluo@google.com>
> > ---
> >  .../bindings/usb/google,gs-dwc3.yaml          | 145 ++++++++++++++++++
> >  1 file changed, 145 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/google,gs-dwc=
3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/google,gs-dwc3.yaml =
b/Documentation/devicetree/bindings/usb/google,gs-dwc3.yaml
> > new file mode 100644
> > index 000000000000..9eb0bf726e8d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/google,gs-dwc3.yaml
>
> filename matching the compatible please.
>
> > @@ -0,0 +1,145 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (c) 2025, Google LLC
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/google,gs-dwc3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Google Tensor Series (G5+) DWC3 USB SoC Controller
> > +
> > +maintainers:
> > +  - Roy Luo <royluo@google.com>
> > +
> > +description: |
> > +  Describes the DWC3 USB controller block implemented on Google Tensor=
 SoCs,
> > +  starting with the G5 generation. Based on Synopsys DWC3 IP, the cont=
roller
> > +  features Dual-Role Device single port with hibernation add-on.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - google,gs5-dwc3
>
> items is redundant here.
>
> > +
> > +  reg:
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +  reg-names:
> > +    description: |
> > +      The following memory regions must present:
> > +        - dwc3_core: Core DWC3 IP registers.
> > +        - host_cfg_csr: Hibernation control registers.
> > +        - usbint_csr: Hibernation interrupt registers.
>
> Put this into reg as an items list, and you can drop the min/max items
> from there.
> Same applies to interrupts and power-domains.
>
> > +    items:
> > +      - const: dwc3_core
> > +      - const: host_cfg_csr
> > +      - const: usbint_csr
> > +
> > +  interrupts:
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    description: |
> > +      The following interrupts must present:
> > +        - dwc_usb3: Core DWC3 interrupt.
> > +        - hs_pme_irq: High speed remote wakeup interrupt for hibernati=
on.
> > +        - ss_pme_irq: Super speed remote wakeup interrupt for hibernat=
ion.
> > +    items:
> > +      - const: dwc_usb3
> > +      - const: hs_pme_irq
> > +      - const: ss_pme_irq
>
> s/_irq//
>
> > +
> > +  clocks:
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +  resets:
> > +    minItems: 5
> > +    maxItems: 5
>
> For clocks and resets, please provide descriptions. For clock-names, you
> provided no names and therefore cannot use the property since anything
> is valid!
>
> > +
> > +  reset-names:
> > +    items:
> > +      - const: usbc_non_sticky
> > +      - const: usbc_sticky
> > +      - const: usb_drd_bus
> > +      - const: u2phy_apb
> > +      - const: usb_top_csr
>
> "csr" is an odd thing to have in a reset name, since it usually means
> "control and status register". Why is it here.
>
> > +
> > +  power-domains:
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  power-domain-names:
> > +    description: |
> > +      The following power domain must present:
> > +          - usb_psw_pd: The child power domain of usb_top_pd. Turning =
it on puts the controller
> > +                         into full power state, turning it off puts th=
e controller into power
> > +                         gated state.
> > +          - usb_top_pd: The parent power domain of usb_psw_pd. Turning=
 it on puts the controller
> > +                         into power gated state, turning it off comple=
tely shuts off the
> > +                         controller.
> > +    items:
> > +      - const: usb_psw_pd
> > +      - const: usb_top_pd
>
> s/_pd// at the very least, but I would question the need to put "usb" in
> any of the names given that this is a usb device.
>
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - resets
> > +  - reset-names
> > +  - power-domains
> > +  - power-domain-names
> > +
> > +allOf:
> > +  - $ref: snps,dwc3-common.yaml#
> > +
> > +unevaluatedProperties: false
>
> So every property from snps,dwc3-common.yaml is valid here, with any of
> the permitted values?

Conor,

Appreciate the review.
Ack to all the comments, will fix them in the next patch.
And yes, every property from snps,dwc3-common.yaml is valid here.
You can find more context here [1], essentially the dwc3 glue would be
operating on the same platform device as the dwc3 core, hence all
properties are allowed.

[1] https://lore.kernel.org/all/20250414-dwc3-refactor-v7-0-f015b358722d@os=
s.qualcomm.com/

Thanks,
Roy Luo

> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        usb@c400000 {
> > +            compatible =3D "google,gs5-dwc3";
> > +            reg =3D <0 0x0c400000  0 0xd060>, <0 0x0c450000 0 0x14>, <=
0 0x0c450020 0 0x8>;
> > +            reg-names =3D "dwc3_core", "host_cfg_csr", "usbint_csr";
> > +            interrupts =3D <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH 0>,
> > +                         <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH 0>,
> > +                         <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH 0>;
> > +            interrupt-names =3D "dwc_usb3", "hs_pme_irq", "ss_pme_irq"=
;
> > +            clocks =3D <&hsion_usbc_non_sticky_clk>,  <&hsion_usbc_sti=
cky_clk>,
> > +                     <&hsion_u2phy_apb_clk>;
> > +            clock-names =3D "usbc_non_sticky", "usbc_sticky", "u2phy_a=
pb";
> > +            resets =3D <&hsion_resets_usbc_non_sticky>, <&hsion_resets=
_usbc_sticky>,
> > +                     <&hsion_resets_usb_drd_bus>, <&hsion_resets_u2phy=
_apb>,
> > +                     <&hsion_resets_usb_top_csr>;
> > +            reset-names =3D "usbc_non_sticky", "usbc_sticky",
> > +                     "usb_drd_bus", "u2phy_apb",
> > +                     "usb_top_csr";
> > +            power-domains =3D <&hsio_n_usb_psw_pd>, <&hsio_n_usb_pd>;
> > +            power-domain-names =3D "usb_psw_pd", "usb_top_pd";
> > +            phys =3D <&usb_phy 0>;
> > +            phy-names =3D "usb2-phy";
> > +            snps,quirk-frame-length-adjustment =3D <0x20>;
> > +            snps,gfladj-refclk-lpm-sel-quirk;
> > +            snps,incr-burst-type-adjustment =3D <4>;
> > +        };
> > +    };
> > +...
>
> pw-bot: cr

