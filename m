Return-Path: <linux-kernel+bounces-853544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE77BBDBEED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7859F3B6E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA7C1E98E6;
	Wed, 15 Oct 2025 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5d6xfOO"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BB1D5160
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760489456; cv=none; b=P3JBR19HF7wYIlHRr5LfEQWxhvks12zmtmcSKu8OeTZp/dhpP985NCwfOXR0ZL5c7bVN7FRPXyy1gjvFXfKthm0Jqx0Yi6sklY614/K6AoKjXP+6Hbc7QWwags2uW472Ip59O6DTOEwK03cOCD7w/cco7Gu4kBbBKcorb6WDL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760489456; c=relaxed/simple;
	bh=5ZAjmvTCmUGu2cPsYFNCyYtrlj73B/OPcDOxY270y68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O476k/+Uvn5WadIA7B8dTlfooN3wXL08NFmUOSb2xQ6OqeB7yiJXOpd84yeX6NivphXA1wJnH/lXuJeNBy98cnExhIBnO2O5hMvFhdSenWUmskchWmEJayccP2603OfC2AGpfyKcpcMdf/4YV70lIDOR+rVFOyMCX81vozsmD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5d6xfOO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-330a4d4359bso4890489a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760489454; x=1761094254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pys06/P8lbZQqKUpds+GbSIWbUdLNbX77jOCPrn7W20=;
        b=b5d6xfOOoerxJnoF3/GkETc4CgtQQcaOi+1WLGKuwFUTY1CbRjRh3jSGR37z9U65/0
         bJL1+apVqOM/2HpaeXA2XxRsDtmKgkwESvXBRPl5lLJFFcvodsmbEJ6xIW+0VuciZygi
         uChvOdlfE78WZeuCe2fLiASdUsyIn0E/lX/LmbN7wx4jNbmxe297qQH9sl1577y0RDYA
         L9xEHnLn1K9vEUQDYWtbOyZfeGul7Wp+MfZR0Ca7/gtyWAj6Lgxdqd6HS48u8dAAEtOP
         HAHimEy65lhp1ci9IX1pIafIf+YTm9NRK7i8D2y+fBbxoF6r+gga8bd2+WjroREahm5h
         6V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760489454; x=1761094254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pys06/P8lbZQqKUpds+GbSIWbUdLNbX77jOCPrn7W20=;
        b=hvdRcP2jU31hn7T9bVTETofM8kc+bN0zOOjWPfKA5CXBQoA9RZ+1NYZqbbmDcbCDsS
         3t2K6uUdFPup1sW+HVsWTkuS4JM2QY4cbs41klFheC3gS5crSAwF1tKdJOgdPAZuf1Kb
         sBqBQyaQfYS6VTiiCAbWyAAAvgD5l6ACmDGyk177UwCCGTlC/2hsEQDVJOsoZPb2ToK5
         yZrw0VDCBqXvBdL22z3dUda5Si45Z7O5LZNGUW+eGCuegOpa14jo/HpvfOzaenE/pEKz
         rqQ9DP22ikUaXtuuRo7TUH1o9+3zkM5bCz+Oo0+aH7L49BwS+T8uJWXct2xlnXcUHPaR
         hAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9hFxLtZd7OkO8Yhr2Xl3wLbAL+Fgq1HmuYQgH7MpBjiNDCW2hD0ZdERQtUZwAArS2czHwwfngIbaCg6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YznlPp40yu/QFgas5YAZrL4DKOqyBywy4jz0PGRcqYqJmpXE3w2
	4uF4u9ar7St41bsRSPmD5V2fL3Vcpq/Q8jU+PcIoVtUYW6THoYxcEuZiC8yU+ratCTAkNjAek+O
	26w1WsTz9Q7aBVbcv3VV1UKTh2pE0NDp3PZnvX2Ck
X-Gm-Gg: ASbGnct8808bAGP1h9U0UegMc23vt9I/20revn8OzcJPoieIIy22aIOSXZShMNr3DSe
	TA6ELk+tp/idrqr4GS3q6uvWXAuVYyfkE+l/4u4ygG5izUe8qtyIt3iqEeu5BoBfJIZEx8IGuBM
	ltZYhilWQmxLRVXx744/l0XLbqP0HJLKHYcKEqmsroBqs9yGhf3A4r2yHZefawx6Awdv4g1qdjP
	mp5WF9OVNUBlEvi46arfZl1CH1ZgnlmlMAARqJmr8tO4A==
X-Google-Smtp-Source: AGHT+IEdFC1oV2FCOk9D1OoKHtXpkscHEpfnoY4gL665jCzwvs2Cq1As6WI2zTWR3UXhYVWN4AQjO/wbTMtNWWION3M=
X-Received: by 2002:a17:90b:3804:b0:336:bfce:3b48 with SMTP id
 98e67ed59e1d1-33b51169060mr35644309a91.9.1760489453987; Tue, 14 Oct 2025
 17:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010201607.1190967-1-royluo@google.com> <20251010201607.1190967-2-royluo@google.com>
 <066a9598-ad30-4327-be68-87299bba6fda@kernel.org> <CA+zupgwc7b51pNRLWRy2CX=n4=FTm=AP7J0dRP2RLjyK5LxGtw@mail.gmail.com>
 <b7b3de64-c656-4a84-8ba4-2d5c7eda9783@kernel.org>
In-Reply-To: <b7b3de64-c656-4a84-8ba4-2d5c7eda9783@kernel.org>
From: Roy Luo <royluo@google.com>
Date: Tue, 14 Oct 2025 17:50:17 -0700
X-Gm-Features: AS18NWACCqT3kxFlbATNFzqFu_XOiDjmmd9pdcyMxo1Erfx1Ha14-MwEazkZAV4
Message-ID: <CA+zupgzo9zRO2GHR2Np0Tm4M5_h8y0GF2JGGqE_S0BxSR_ZbqQ@mail.gmail.com>
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

On Tue, Oct 14, 2025 at 1:22=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 14/10/2025 03:40, Roy Luo wrote:
> > On Fri, Oct 10, 2025 at 5:09=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 10/10/2025 22:16, Roy Luo wrote:
> >>> Document the device tree bindings for the DWC3 USB controller found i=
n
> >>> Google Tensor SoCs, starting with the G5 generation.
> >>>
> >>> The Tensor G5 silicon represents a complete architectural departure f=
rom
> >>> previous generations (like gs101), including entirely new clock/reset
> >>> schemes, top-level wrapper and register interface. Consequently,
> >>> existing Samsung/Exynos DWC3 USB bindings are incompatible, necessita=
ting
> >>> this new device tree binding.
> >>>
> >>> The USB controller on Tensor G5 is based on Synopsys DWC3 IP and feat=
ures
> >>> Dual-Role Device single port with hibernation support.
> >>
> >> You still mix, completely unnecessarily, subsystems. For Greg this is
> >> actually even undesired, but regardless don't do this for any cases
> >> because it just makes everything slower or more difficult to apply.
> >>
> >> Really, think how maintainers should deal with your patches.
> >>
> >
> > Understood, I will separate the patches into two distinct series: one f=
or
> > the controller and one for the PHY.
> > Appreciate the feedback and the explanation.
> >
> >>>
> >>> Signed-off-by: Roy Luo <royluo@google.com>
> >>> ---
> >>>  .../bindings/usb/google,gs5-dwc3.yaml         | 141 ++++++++++++++++=
++
> >>>  1 file changed, 141 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/usb/google,gs5-=
dwc3.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/google,gs5-dwc3.ya=
ml b/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml
> >>> new file mode 100644
> >>> index 000000000000..6fadea7f41e8
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/usb/google,gs5-dwc3.yaml
> >>> @@ -0,0 +1,141 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +# Copyright (c) 2025, Google LLC
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/usb/google,gs5-dwc3.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Google Tensor Series (G5+) DWC3 USB SoC Controller
> >>> +
> >>> +maintainers:
> >>> +  - Roy Luo <royluo@google.com>
> >>> +
> >>> +description:
> >>> +  Describes the DWC3 USB controller block implemented on Google Tens=
or SoCs,
> >>> +  starting with the G5 generation. Based on Synopsys DWC3 IP, the co=
ntroller
> >>> +  features Dual-Role Device single port with hibernation add-on.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: google,gs5-dwc3
> >>> +
> >>> +  reg:
> >>> +    items:
> >>> +      - description: Core DWC3 IP registers.
> >>> +      - description: USB host controller configuration registers.
> >>> +      - description: USB custom interrrupts control registers.
> >>> +
> >>> +  reg-names:
> >>> +    items:
> >>> +      - const: dwc3_core
> >>> +      - const: host_cfg
> >>> +      - const: usbint_cfg
> >>> +
> >>> +  interrupts:
> >>> +    items:
> >>> +      - description: Core DWC3 interrupt.
> >>> +      - description: High speed power management event for remote wa=
keup from hibernation.
> >>> +      - description: Super speed power management event for remote w=
akeup from hibernation.
> >>
> >> Wrap at 80 (see coding style) or just shorten these.
> >
> > Ack, will fix it in the next patch.
> >
> >>
> >>> +
> >>> +  interrupt-names:
> >>> +    items:
> >>> +      - const: dwc_usb3
> >>
> >> So just "core"?
> >
> > I'd prefer to stick to "dwc_usb3" as that's
> > 1. more expressive by referring to the underlying IP name,
>
>
> But that's completely redundant name.
>
> > 2. consistent with established dwc3 bindings such as
> >     Documentation/devicetree/bindings/usb/snps,dwc3.yaml,
>
> If you use only one interrupt. You don't use one interrupt here.

After looking into it further, I found that the interrupt name "dwc_usb3"
must be used here to adhere to the interrupt naming defined in
"snps,dwc3.yaml".

This requirement stems from the device's corresponding glue driver
utilizing a so-called "flattened" model (see [1] for context). This model
causes the glue driver to probe an underlying "snps,dwc3" device.
Consequently, the core DWC3 interrupt defined here is consumed by
the driver handling the "snps,dwc3" device, making it mandatory to
follow the interrupt naming established in "snps,dwc3.yaml".
Essentially, the interrupts defined here are a mix of vendor specific
implementation (like "hs_pme", "ss_pme") and the DWC3 core in
"snps,dwc3.yaml" ("dwc_usb3").

I don't know if there's a better way to express this implicit dependency
of the core DWC3 interrupt except for documenting it in the binding
description. Any advice would be welcome.

[1] https://lore.kernel.org/all/20250414-dwc3-refactor-v7-0-f015b358722d@os=
s.qualcomm.com/

Thanks,
Roy Luo

>
> >     Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml,
> > unless you have a strong preference for the alternative naming.
>
> Such namings are discouraged, because they tell absolutely nothing.
> Also, schematics or datasheets usually do not use them, either.
>
>
> Best regards,
> Krzysztof

