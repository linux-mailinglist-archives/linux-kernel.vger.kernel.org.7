Return-Path: <linux-kernel+bounces-851656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D411BD6FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F2C18A785A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2D26E718;
	Tue, 14 Oct 2025 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgUc0p+h"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33A15B0EC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406049; cv=none; b=PfSuuv9xhBe+6MGVW4dYSzeJP9DcIFJnaZkQfGz/Dg0xqT/qmdkoLUmmiYMR5IUtP29IblojStpoaWfEp1rw3rkD0Ue00LkB9g/9lWln6jgW8DMBhEDgDyhk3YWCMtvzOmaEBh6Tfcomo84ED6EfsKluYB04iksUdISBpZV6Rcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406049; c=relaxed/simple;
	bh=SvUOg+GhCiLgOKSplnIErGjUnl2M+DDGuRcUuzNrrSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy+nn+xJnpt/7eGrJUX7zlrM5Y12/goxaSGAwz8cokkM1Xb4fjyioH2HQzr30A/fBJJHOOxrdGBfSRfHP+Wfs9XA2Z5fyYRVrERSI+HmuFVDk0GtWzN/S8Kv5P1jbd9UMP38lFxY0vLZQ0+1Ya2YsOo5WFBs8KZSVh3wm+VEhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgUc0p+h; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so4267268b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760406045; x=1761010845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0HrrIP4IFVgvTei6bJGzfuFKTrJwkNbVYBJNZOs3MY=;
        b=wgUc0p+hwwd1D0aTTBPxPMJllxgGhuBtnQDHVXcBypuMeyptP9JJQRupKvw/Qxu4nM
         6JozLu7q+eFMKFm9ifD9Fwx9WNsqR/bonN6BA2EvXxCTxwwufzkuTu+Vkv8e1UY6Hu9+
         SZpRiUUpcVKDCMi8HRkn3AE9Wo/ykM+/12AO/1v3rxf3AS34kAxFhjnhW0LfyFYmVDTz
         BS1cSC6gDUNEr+cqml4hpndYc/vqil1Gds0soQpTv7yenNjI3l0RGmrS/7iSSfU6Ja6n
         gaihr7TLLzo66MI+3rUt+HKjptAJcr3mdOkIhNivPufamL/5Ybr+YpCG1o3paIkk76BC
         HSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760406045; x=1761010845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0HrrIP4IFVgvTei6bJGzfuFKTrJwkNbVYBJNZOs3MY=;
        b=qOnClNWQZ+IiRNQgFfQpsCiyPhp9HW4sWTc8ueSd+aJv+DP9kVtHlLxpoPGplnEsN8
         sD06AC5fQ9qDWLX6bA08LP8m2AYF1DXa9FNRPYSaan3peQixGA5k5xfBqTes2W46jsab
         VMd3XYYEukkepATawXEyBrqG/9jYxbUGSh5DHEmXDwwwqaaIwlDBz6iyRS59jupabtIB
         Drmj5P57ZTNFHK3cv0HtVP2quwfI0nif1aa4x1stHUtBrVmzXz4dQ+QUlnWkX3M9sKCn
         +vEMbb0Z5wTIzkoUGTZvQoP3y7v6lNBmcWaQq3c9wAfmoSA5r4O8lAQeRx0AjWPdovEm
         da3A==
X-Forwarded-Encrypted: i=1; AJvYcCWO34xWCgPfO0dTVAvBuXp5lH21X5beCV+uV6L2dxaKI9yc3XCBXL+2ocDLY2Xq2kldkBQzxl4dUgut/xY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nEtjOwPpyj/u0H4da245NJR2H0WjVCiyKvv3ucpNiVnv2+ic
	H9Ab0jrKt5+SFT/tq1fVw+dtI1qG1XytotEV19k9gYJ5S4gjGmDPMDQFqFHFCw4H07mExjVyJkX
	//LeBZrIcQzMxnFOwWtb7tlYVtuwa2tAzby49vlAT
X-Gm-Gg: ASbGnctnxlDA/RBZmUW5TFzPAVuCCTfJ3UhDUTRzsmXniRyQjqZp05YF59ORjZOeXMx
	yVyUoE/RtgyLZMcMKC33VwMYrgMkBTMYqn/xxNHOGIo7rt8D2CNxiip6j/iOx0zcRQNPn2PL9du
	0ulGzq2oj0SsDxuekZ0eB3t5AyW7cL2lxIG2IGTWFiHZoRKjCTq2qGt6CCN8ADUwMwpHJqTuGFH
	zC2Ib/nW4CyGmFg3NH7L+DMhovIzxJ6zKV+T9/1pR+Sdywv2kIlK348wRAYaDyedwtdjFzrMzGq
X-Google-Smtp-Source: AGHT+IH/gaVhehz3sRp9VrrzaU79D/o/NZJP8CN7/dl/fC68uxDpeqnl6j3qA8EnLxqoVUctH31vKw6FBzQox/YYs6w=
X-Received: by 2002:a17:903:2408:b0:28e:7fce:667e with SMTP id
 d9443c01a7336-2902723f51emr324260245ad.17.1760406045183; Mon, 13 Oct 2025
 18:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010201607.1190967-1-royluo@google.com> <20251010201607.1190967-2-royluo@google.com>
 <066a9598-ad30-4327-be68-87299bba6fda@kernel.org>
In-Reply-To: <066a9598-ad30-4327-be68-87299bba6fda@kernel.org>
From: Roy Luo <royluo@google.com>
Date: Mon, 13 Oct 2025 18:40:08 -0700
X-Gm-Features: AS18NWCf063mHzWv1lf5a6FraaWgtqWiANzRpv6KaU2cy8h_cSvnS3pGamEVoLc
Message-ID: <CA+zupgwc7b51pNRLWRy2CX=n4=FTm=AP7J0dRP2RLjyK5LxGtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: dwc3: Add Google Tensor G5 DWC3
To: Krzysztof Kozlowski <krzk@kernel.org>
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

On Fri, Oct 10, 2025 at 5:09=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 10/10/2025 22:16, Roy Luo wrote:
> > Document the device tree bindings for the DWC3 USB controller found in
> > Google Tensor SoCs, starting with the G5 generation.
> >
> > The Tensor G5 silicon represents a complete architectural departure fro=
m
> > previous generations (like gs101), including entirely new clock/reset
> > schemes, top-level wrapper and register interface. Consequently,
> > existing Samsung/Exynos DWC3 USB bindings are incompatible, necessitati=
ng
> > this new device tree binding.
> >
> > The USB controller on Tensor G5 is based on Synopsys DWC3 IP and featur=
es
> > Dual-Role Device single port with hibernation support.
>
> You still mix, completely unnecessarily, subsystems. For Greg this is
> actually even undesired, but regardless don't do this for any cases
> because it just makes everything slower or more difficult to apply.
>
> Really, think how maintainers should deal with your patches.
>

Understood, I will separate the patches into two distinct series: one for
the controller and one for the PHY.
Appreciate the feedback and the explanation.

> >
> > Signed-off-by: Roy Luo <royluo@google.com>
> > ---
> >  .../bindings/usb/google,gs5-dwc3.yaml         | 141 ++++++++++++++++++
> >  1 file changed, 141 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/google,gs5-dw=
c3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml=
 b/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml
> > new file mode 100644
> > index 000000000000..6fadea7f41e8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml
> > @@ -0,0 +1,141 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (c) 2025, Google LLC
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/google,gs5-dwc3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Google Tensor Series (G5+) DWC3 USB SoC Controller
> > +
> > +maintainers:
> > +  - Roy Luo <royluo@google.com>
> > +
> > +description:
> > +  Describes the DWC3 USB controller block implemented on Google Tensor=
 SoCs,
> > +  starting with the G5 generation. Based on Synopsys DWC3 IP, the cont=
roller
> > +  features Dual-Role Device single port with hibernation add-on.
> > +
> > +properties:
> > +  compatible:
> > +    const: google,gs5-dwc3
> > +
> > +  reg:
> > +    items:
> > +      - description: Core DWC3 IP registers.
> > +      - description: USB host controller configuration registers.
> > +      - description: USB custom interrrupts control registers.
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dwc3_core
> > +      - const: host_cfg
> > +      - const: usbint_cfg
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Core DWC3 interrupt.
> > +      - description: High speed power management event for remote wake=
up from hibernation.
> > +      - description: Super speed power management event for remote wak=
eup from hibernation.
>
> Wrap at 80 (see coding style) or just shorten these.

Ack, will fix it in the next patch.

>
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: dwc_usb3
>
> So just "core"?

I'd prefer to stick to "dwc_usb3" as that's
1. more expressive by referring to the underlying IP name,
2. consistent with established dwc3 bindings such as
    Documentation/devicetree/bindings/usb/snps,dwc3.yaml,
    Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml,
unless you have a strong preference for the alternative naming.

>
> > +      - const: hs_pme
> > +      - const: ss_pme
> > +
> > +  clocks:
> > +    items:
> > +      - description: Non-sticky module clock.
> > +      - description: Sticky module clock.
> > +      - description: USB2 PHY APB clock.
>
> This looks wrong. This is not the USB2 phy, so how can it consume APB clo=
ck?

That's a fair point, I'll look into the necessity and placement of this spe=
cific
clk/reset and get back.

Thanks,
Roy Luo

>
> > +
> > +  clock-names:
> > +    items:
> > +      - const: non_sticky
> > +      - const: sticky
> > +      - const: u2phy_apb
> > +
> > +  resets:
> > +    items:
> > +      - description: Non-sticky module reset.
> > +      - description: Sticky module reset.
> > +      - description: USB2 PHY APB reset.
>
> This as well.
>
> > +      - description: DRD bus reset.
> > +      - description: Top-level reset.
> > +
> > +  reset-names:
> > +    items:
> > +      - const: non_sticky
> > +      - const: sticky
> > +      - const: u2phy_apb
> > +      - const: drd_bus
> > +      - const: top
>
>
> Best regards,
> Krzysztof

