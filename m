Return-Path: <linux-kernel+bounces-876918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34843C1CC35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6E41896DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9563559EE;
	Wed, 29 Oct 2025 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goL2QN2y"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BC2ECD06
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762254; cv=none; b=WdAuY6RSLnasa8yaF3+jSsUH2BGMLPJn7FxK5P0F1EHw/KP9J0hDxsEq5d08nAp2qOZ5ip6VEJXQEnWjA0TwLkalWEJtTtSDLTufL3OHi+YYYLFXodgSKsNagOYX+9zUoe+VUJReshq+x6N+trK0bayF+ipi4CIP9ZnOJc2+ku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762254; c=relaxed/simple;
	bh=19BiiKEHLAAdUkK3kiHtZ+FIIIcqtIk4Br4GS4kuJIs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl9zPGshoQYOIsVnAUOQp2fl4nwfmgUIUhTeWrr95zu3gmbCzgAM93+KfQFqjyKUk/H6WfgFuHCN/4V/3APSewWoba5IeeybNjegSTE/7ytiNSyhD8EJiUXfb6a8g93LMuqGCTjCIFrnnRMKHqCfdb4QVq0OSFtngUWNAEtkkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goL2QN2y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710665e7deso764975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761762250; x=1762367050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bzK5qNzDD1OL6sh9VhoK7dF0ie9h0/HgqvIRoxOou0g=;
        b=goL2QN2yFMLGLyetAyBqLAvRJkvmg28F5kZwnUkk6Q1zMK/oYWuHZacatToE0gtuNb
         VIJLwKIRIORibslglSTsTNEz+uYqZwo17HznNnrKpCu9X8IA9ukGzg834/IQb/9oGHyc
         ow3VMkI1jwyHdiwi68WndxA/4fzok8KSPPbkX/UzBse9XbzPE6pU0nLezOzRlkDIAE86
         gVcJcKUrxaz5rUIRhHghITcE3Adf11tf0vC/ZP6ypJSNMavNsM4SPJqteF9Cc5ZrVZKu
         uqu/u4S+D5eznmY0J7FyWPKi7X4OiAOfjZA1cYxpNPRHKGGlEaMbwjBR0qWGmN9jdjVf
         h63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761762250; x=1762367050;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzK5qNzDD1OL6sh9VhoK7dF0ie9h0/HgqvIRoxOou0g=;
        b=S3JYXSryx7W/Z6keDnrD0lPl1zW2aVllqBgcvNOJX3ypMZmAUYVBP+7xcKyIgri2C4
         4u4H4B2k3ze9kgTv/HnY95CJ/U9ILr40KfojNi11JMs7xltqXe296y07mZn7BEGTQx4u
         NkauNY/BsNExklv/gf18lGlhqgELuNAfdhx8pZAsDopKKCA1/u8rYPPkyV6Fq/LNPNtS
         xvzzULHT8LncmI8wGvuf54lix0vbrqXDoZSTpiWjdWqcZNKFlnRz0+oD/tZuiHw2rEfc
         wuQL0Y97+16Lb3TD/RwBcVFy0Zl1/Eeh6YKLuJiqVxVep340nYDTjiAEPPVP8GyTPzY0
         d2bA==
X-Forwarded-Encrypted: i=1; AJvYcCXpdXJPU5h6l92Qgq7F5bJkFBU5Z+gmkaTtyrpK7gu64JpKICXhB5YehlKgxRteCjuJLdUEo1oWhSJwheM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMGbsd97cqhJEVkS7Jn9cW1J8ILS+YreiIoF9Po6XQ+nOY499
	qx6HB0BmJwTDqWnwdAODZJJmqe2LGj74amo27Db2ru+m9wIZeb2I6Hd3MkaXTA==
X-Gm-Gg: ASbGnctOoMXeCagPvInvByph/LqNuGff+OZj1sx8TL0ljy2I+BtTI/s7jPpnDxLomZ+
	Db2mqLPOAZZQa5TrHE/QUqikyM3i0qmIbtfF8x7yJJnMjWL8D43sh7dg2A1cSPsc5MdL+vwUZd4
	PbBwkCtOQZxhdpZ84j6CLmc2PsXPgSGusO5e2ZsHduKOeAVOaUE8Xis5RgA0QgNDhBU/yblhZOE
	vQBA1BdEVf17Hi2DJxeQ4bYvMqoGp+z62/ZtgoP5E170dweR3UCNmKjuaPgLarAC9JNptjK8XKx
	+id2m8cY4uucYiOrFXYuylfY992yqWm6zuHmEDJJiClFk4jK4MkD+ObZnmq7HuXbYEY/3eYfKMS
	2B8yhXCsDsJ8hF1DVbwjKGIcjH1UMvOT/M2htNgjqzs0/13amMxaxhwOK7l9znqfL4zcR9ya9CG
	l4Qt7kYr2iap5vxPOXT7AVwLbWem7N
X-Google-Smtp-Source: AGHT+IHiqbGMQAd5HKcmjlS9yIwTWKcuIT+kbHRohu/cwGjeIbdOsMSRiO92YQLIPJlRr2d/zjLp/w==
X-Received: by 2002:a05:600c:468f:b0:46e:1cc6:25f7 with SMTP id 5b1f17b1804b1-4771e177ca5mr33863075e9.9.1761762250323;
        Wed, 29 Oct 2025 11:24:10 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca979sm28796326f8f.14.2025.10.29.11.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 11:24:09 -0700 (PDT)
Message-ID: <69025bc9.5d0a0220.1f0440.deb9@mx.google.com>
X-Google-Original-Message-ID: <aQJbxPm8SFN8WR7f@Ansuel-XPS.>
Date: Wed, 29 Oct 2025 19:24:04 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: phy: Add documentation for Airoha
 AN7581 USB PHY
References: <20251029173713.7670-1-ansuelsmth@gmail.com>
 <20251029173713.7670-3-ansuelsmth@gmail.com>
 <20251029-mutual-scotch-7ca52e17da69@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-mutual-scotch-7ca52e17da69@spud>

On Wed, Oct 29, 2025 at 06:07:22PM +0000, Conor Dooley wrote:
> On Wed, Oct 29, 2025 at 06:37:10PM +0100, Christian Marangi wrote:
> > Add documentation for Airoha AN7581 USB PHY that describe the USB PHY
> > for the USB controller.
> > 
> > Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> > always supported. The USB 3.0 mode is optional and depends on the Serdes
> > mode currently configured on the system for the relevant USB port.
> > 
> > The first USB port on the SoC can be both used for USB 3.0 operation or
> > Ethernet (HSGMII).
> > The second USB port on the SoC can be both used for USB 3.0 operation or
> > for an additional PCIe line.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > 
> > For DT maintainers, in v2 there were some comments, hope the new
> > description and names of the property better clarify the usage and
> > why they are needed.
> > 
> >  .../bindings/phy/airoha,an7581-usb-phy.yaml   | 76 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 ++
> >  .../dt-bindings/phy/airoha,an7581-usb-phy.h   | 11 +++
> >  3 files changed, 94 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> >  create mode 100644 include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > new file mode 100644
> > index 000000000000..5106685c124d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/airoha,an7581-usb-phy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha AN7581 SoC USB PHY
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description: >
> > +  The Airoha AN7581 SoC USB PHY describes the USB PHY for the USB controller.
> > +
> > +  Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> > +  always supported. The USB 3.0 mode is optional and depends on the Serdes
> > +  mode currently configured on the system for the relevant USB port.
> > +
> > +  The first USB port on the SoC can be both used for USB 3.0 operation or
> > +  Ethernet (HSGMII).
> > +  The second USB port on the SoC can be both used for USB 3.0 operation or
> > +  for an additional PCIe line.
> > +
> > +properties:
> > +  compatible:
> > +    const: airoha,an7581-usb-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  airoha,usb2-monitor-clk-sel:
> > +    description: Describe what oscillator across the available 4
> > +      should be selected for USB 2.0 Slew Rate calibration.
> 
> Why's this being set in dt? What actually determines what oscillator
> should be used? Do they have different performance characteristics?
> How is someone meant to know which one to use?
>

Hi Conor,

thanks a lot for the review.

The airoha,usb2-monitor-clk-sel is set in DT because it describe the HW
and to what oscillator the PHY should be connected to.

There are 2 PHY at different register space. One PHY needs to calibrate
for oscillator 1 and the other PHY for oscillator 2 or the PHY doesn't
work for USB 2.0 (the calibration fails)

The previous implementation used an index property but that was rejected
as it wasn't descriptive of the HW.

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +
> > +  airoha,usb3-serdes:
> > +    description: Describe what Serdes line is attached to the USB 3.0 port.
> > +      Can be either Serdes USB1 or Serdes USB2.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [2, 3]
> 
> This is confusing. Why 2 and 3 for usb1 and usb2? What even is the
> mapping? Is it 2:1/3:2 or 2:2/3:1?
> 

AFAIK there isn't a way to directly reference dt-bindings.

2 and 3 are from include/dt-bindings/soc/airoha,scu-ssr.h

#define AIROHA_SCU_SERDES_USB1		2
#define AIROHA_SCU_SERDES_USB2		3

> > +
> > +  airoha,scu:
> > +    description: Phandle to the SCU syscon to configure the Serdes line.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  '#phy-cells':
> > +    description: Describe if the referred PHY is the USB 2.0 PHY or USB 3.0 PHY.
> > +    const: 1
> 
> Which is which here?
>

Mhh I think I didn't understand here. #phy-cells describe the
parameters to be used for phys property in a different node.

The current usage would be

<&usb0_phy PHY_TYPE_USB2> for USB 2.0
or <&usb0_phy PHY_TYPE_USB3> for USB 3.0

This node expose 2 PHY that can be referenced by the single parameters.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - airoha,usb2-monitor-clk-sel
> > +  - airoha,usb3-serdes
> > +  - airoha,scu
> > +  - '#phy-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/phy/airoha,an7581-usb-phy.h>
> > +    #include <dt-bindings/soc/airoha,scu-ssr.h>
> > +
> > +    phy@1fac0000 {
> > +        compatible = "airoha,an7581-usb-phy";
> > +        reg = <0x1fac0000 0x10000>;
> > +
> > +        airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL1>;
> > +        airoha,usb3-serdes = <AIROHA_SCU_SERDES_USB1>;
> > +        airoha,scu = <&scu>;
> > +
> > +        #phy-cells = <1>;
> > +    };
> > +
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8085fdca7bcd..af23c590bbc6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -763,6 +763,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
> >  F:	drivers/spi/spi-airoha-snfi.c
> >  
> > +AIROHA USB PHY DRIVER
> > +M:	Christian Marangi <ansuelsmth@gmail.com>
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > +F:	include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > +
> >  AIRSPY MEDIA DRIVER
> >  L:	linux-media@vger.kernel.org
> >  S:	Orphan
> > diff --git a/include/dt-bindings/phy/airoha,an7581-usb-phy.h b/include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > new file mode 100644
> > index 000000000000..efbb0ae75e3a
> > --- /dev/null
> > +++ b/include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > +
> > +#ifndef _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
> > +#define _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
> > +
> > +#define AIROHA_USB2_MONCLK_SEL0                 0
> > +#define AIROHA_USB2_MONCLK_SEL1                 1
> > +#define AIROHA_USB2_MONCLK_SEL2                 2
> > +#define AIROHA_USB2_MONCLK_SEL3                 3
> 
> These definitions seem completely pointless. The property is called
> "airoha,usb2-monitor-clk-sel" so any use will look like
> "airoha,usb2-monitor-clk-sel = <3>;"
> That's more informative than the define is, since it doesn't even
> truncate "monitor". I'd just delete this header entirely and use the
> number. If you want the define in the driver to avoid magic numbers,
> just define it in the driver.
> 

Well yes the idea here is to not have to use magic numbers in DT and try
to use the naming in the SoC documentation since they are called
monclk_sel0, monclk_sel1 ...

Will drop.

> pw-bot: changes-requested
> 
> Cheers,
> Conor.
> 
> > +
> > +#endif
> > -- 
> > 2.51.0
> > 



-- 
	Ansuel

