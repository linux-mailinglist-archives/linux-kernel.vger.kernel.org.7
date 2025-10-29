Return-Path: <linux-kernel+bounces-876994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04853C1CF54
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4442D4E4214
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0A350A2E;
	Wed, 29 Oct 2025 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSnWR7VI"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0829E0F8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765080; cv=none; b=LWIUAUIezzHQbKnXZYT5ZGnNemhQxX5JSOiR1ujXdMytEMnKJJtjdSZ84aCZLs3QxM3yqtpua27bb+9H9VkDb48MMsoBAjtjifRBxR3jzbYZYRXskdT0MiNLsS/JbTPSK8whEXm32v38z9qtEBA2oUHZeQeG4xp5e8bgRCHq/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765080; c=relaxed/simple;
	bh=6Hv1Rw2fRVXVKpfw0sUm6XZSjCynsbeH3OKFN6Cv98c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Teu6/w/1aSIEjaV3BfVo/mJPG0Ue1Rd4pfZdOS9+PZjHg3VoG8W5xn4R9hds1ya5pl0S3XhBFsJitTk7ylt+0EH2KQ9GfyUVdiayN+N6OtwQj4OOLAfgnb41QBPmUzZblSBwsET+y3R0cuupIHJepyz5vjw5w+fg0Yt71j81E28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSnWR7VI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so1155905e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761765077; x=1762369877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zLgblDIy8bcKRfG2LuAVMDQcQzPf8VrxYqngcQhuaTk=;
        b=mSnWR7VIwc6qWxt/RX7CvSARgryWUowwffDalHzxk9IUy0UVDb95kLLlP7BeieD2+8
         7bz+6ZZ0onTDd4cnNck7n0VNtHPao47nFTdOSuAronZdCpjPqT+cbLyck+F1fe3V8l9Q
         z9z+oTWOeEgFF4PR3ry8gEnF4lHJjf90aupL4boBoRPDuPTn4qZB/BKCtUFN+yswBOr2
         FkpJgAOZyn3umNG4IYawI49kxEV2QWGwbpd+ikTV6m77oYvJkhi4YzYcA/iU/4zsOzG7
         6KikWC5L9Vli5WYnK1ntypSmpSk8BMI6HRJZcQpjuRI8BY6VfCMRYzqoiVW8QnAlkoDp
         YhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761765077; x=1762369877;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLgblDIy8bcKRfG2LuAVMDQcQzPf8VrxYqngcQhuaTk=;
        b=Jr0THalw+eULjNGAFMtL10z3oGI79VvQ6FcCynZ6qJEv+GPOY0LJvlwt513Xm7ZS0D
         Bzg6el/4HDlA8JAFXrJm1zaIDAocdD378kmi9cySKJIFmjkuz0m4KhMrR0g/ReoRL5NY
         LF+0f3xYYI9JpLkHtply/ECznXHxcIQlrmZkAtCDk/t+XbYhrxNdoVII6xIMjZbMzZ/o
         HO/hiZJEv+pFI9dYDZLt5SdRxGfsEvELVnIVpRiqm4Lz/qIt+duwPJN3elaHQAoMQ5gV
         4vVHRqD6PPiO62CE5yibYPwfFYW+fok4D545jVwc3M0Ip7F+E0hZwhKxi9tZ3AKOzxPE
         Bh3w==
X-Forwarded-Encrypted: i=1; AJvYcCWslDkIiXl3fCgvzhAC9h96C4/uV7SQ99JFBc2HYRx3KHtLgcPRx6PhlIX8IvOl7RCJ/l9C4EoEqN3kO6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXGImSlBwPRYmB111nl+U8IelAJ/XbFO8oz3GYzIQzXWlEuxh
	PNvEwFhEiVDRHh9/nZ6sFV7HJHvFpd6A+CBAQoQd69/atSw4eAeclMoS
X-Gm-Gg: ASbGncuM26//9fnWI+eHrNbCKiK08Pvm1IIyXeELH2dNQBVgA3azRXbIsVOHKywtk7J
	wiVv++sooCp90fd/DJjV9EkbzJ/B4s2pmTqS4wmtvjN6RCeBjVU28MjqHAIoh0j2wFiB68GOMgK
	kabgyopi4AzdPMA2CMyYo1vuWDuYZPBomCRBghQz2yLTiN5xaZRPA2I6KH20CzmNEjIjRseLYhi
	1NXvv9S29jrg+jcSqkLRVU/Y5iFqRrzrAuUNSrdLAZSR3NcRGc6O1lITNAnGpZmV+ftuymrnGhE
	Lu2VvgkuNpt2SaIcBVl6tvOeO3qCu1v/tne2n/CoffbwqBwNABdUA+W5VJDBF6PNoSvYAF2zTth
	IBmQIIxHwbNhpcqnbYIu/OHdSruie4hdDVODwJVVEqhzlifnsdCUog04Hbu64YmsV6JggSJd7oj
	QBJNI2QW55fRPLGVB1ZQlYuhKZQY7r
X-Google-Smtp-Source: AGHT+IHHJ0QFj6Gb9jCEPnxHuuKJVnaNcrJYknPm6OXlzII4o39jZjUz3lv37Wl4zGDlA2OEKu9Xhg==
X-Received: by 2002:a05:600c:34c4:b0:471:145b:dd0d with SMTP id 5b1f17b1804b1-4771e1ca0b2mr36156105e9.24.1761765076611;
        Wed, 29 Oct 2025 12:11:16 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771832e857sm53183195e9.0.2025.10.29.12.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:11:16 -0700 (PDT)
Message-ID: <690266d4.050a0220.3a144c.eef7@mx.google.com>
X-Google-Original-Message-ID: <aQJmzmMMxJfaZA4h@Ansuel-XPS.>
Date: Wed, 29 Oct 2025 20:11:10 +0100
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
 <69025bc9.5d0a0220.1f0440.deb9@mx.google.com>
 <20251029-henna-easily-227513366e90@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-henna-easily-227513366e90@spud>

On Wed, Oct 29, 2025 at 06:35:51PM +0000, Conor Dooley wrote:
> On Wed, Oct 29, 2025 at 07:24:04PM +0100, Christian Marangi wrote:
> > On Wed, Oct 29, 2025 at 06:07:22PM +0000, Conor Dooley wrote:
> > > On Wed, Oct 29, 2025 at 06:37:10PM +0100, Christian Marangi wrote:
> > > > Add documentation for Airoha AN7581 USB PHY that describe the USB PHY
> > > > for the USB controller.
> > > > 
> > > > Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> > > > always supported. The USB 3.0 mode is optional and depends on the Serdes
> > > > mode currently configured on the system for the relevant USB port.
> > > > 
> > > > The first USB port on the SoC can be both used for USB 3.0 operation or
> > > > Ethernet (HSGMII).
> > > > The second USB port on the SoC can be both used for USB 3.0 operation or
> > > > for an additional PCIe line.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > > 
> > > > For DT maintainers, in v2 there were some comments, hope the new
> > > > description and names of the property better clarify the usage and
> > > > why they are needed.
> > > > 
> > > >  .../bindings/phy/airoha,an7581-usb-phy.yaml   | 76 +++++++++++++++++++
> > > >  MAINTAINERS                                   |  7 ++
> > > >  .../dt-bindings/phy/airoha,an7581-usb-phy.h   | 11 +++
> > > >  3 files changed, 94 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > > >  create mode 100644 include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > > > new file mode 100644
> > > > index 000000000000..5106685c124d
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > > > @@ -0,0 +1,76 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/phy/airoha,an7581-usb-phy.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Airoha AN7581 SoC USB PHY
> > > > +
> > > > +maintainers:
> > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > +
> > > > +description: >
> > > > +  The Airoha AN7581 SoC USB PHY describes the USB PHY for the USB controller.
> > > > +
> > > > +  Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> > > > +  always supported. The USB 3.0 mode is optional and depends on the Serdes
> > > > +  mode currently configured on the system for the relevant USB port.
> > > > +
> > > > +  The first USB port on the SoC can be both used for USB 3.0 operation or
> > > > +  Ethernet (HSGMII).
> > > > +  The second USB port on the SoC can be both used for USB 3.0 operation or
> > > > +  for an additional PCIe line.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: airoha,an7581-usb-phy
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  airoha,usb2-monitor-clk-sel:
> > > > +    description: Describe what oscillator across the available 4
> > > > +      should be selected for USB 2.0 Slew Rate calibration.
> > > 
> > > Why's this being set in dt? What actually determines what oscillator
> > > should be used? Do they have different performance characteristics?
> > > How is someone meant to know which one to use?
> > >
> > 
> > Hi Conor,
> > 
> > thanks a lot for the review.
> > 
> > The airoha,usb2-monitor-clk-sel is set in DT because it describe the HW
> > and to what oscillator the PHY should be connected to.
> > 
> > There are 2 PHY at different register space. One PHY needs to calibrate
> > for oscillator 1 and the other PHY for oscillator 2 or the PHY doesn't
> > work for USB 2.0 (the calibration fails)
> 
> This implies that the oscillator is not part of the phy block, if
> there's multiple competing for the same one. Why are these oscillators
> not represented as clocks?
>

This was also pointed out in the old revision. The oscillator is
internal and there isn't a register to read the frequency or to
enable/disable.

The PHY register block have the same exact bits to select from 0 to 3.
The HW internally is then connected to 1 or 2 basted on the physical PHY.

So yes they are part of the PHY block, just the register map is too
""liberal"" on the configuration.

I verified if the same oscillator could be used for both but it does end
up in the port not working as the calibration fails.

> > The previous implementation used an index property but that was rejected
> > as it wasn't descriptive of the HW.
> > 
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [0, 1, 2, 3]
> > > > +
> > > > +  airoha,usb3-serdes:
> > > > +    description: Describe what Serdes line is attached to the USB 3.0 port.
> > > > +      Can be either Serdes USB1 or Serdes USB2.
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    enum: [2, 3]
> > > 
> > > This is confusing. Why 2 and 3 for usb1 and usb2? What even is the
> > > mapping? Is it 2:1/3:2 or 2:2/3:1?
> > > 
> > 
> > AFAIK there isn't a way to directly reference dt-bindings.
> 
> Usually people put the name of the file in.
> 

Yes on this I have seen mixed implementation with only the enum and some
adding the link to it. I will add in the description.

> > 
> > 2 and 3 are from include/dt-bindings/soc/airoha,scu-ssr.h
> > 
> > #define AIROHA_SCU_SERDES_USB1		2
> > #define AIROHA_SCU_SERDES_USB2		3
> 
> Why overcomplicate like this? Just use 1 and 2. If that corresponds to
> register settings of 2 and 3, do that conversion in the driver.
> Properties are not shoving just register settings etc into, what happens,
> for example, when the next soc comes along and these are actually usb1 is
> 3 and usb2 is 4 there? All of a sudden, your property has different
> meanings depending on which device is being used.
> 

This is really just to identify the serdes line that can have multiple
usage, they don't refer to a specific register.

The PCIe one are added as they can also be used for PCIe or Ethernet
usage and in the future this feature will be implemented in the PCIe PHY.

It's ok to change it 1 but then I hope we won't fall in the monclk case
where we end up with

airoha,usb3-serdes = <1>;

as that will be VERY confusing in DT.

(again I'm using dt-bindings here to give clear indication of the
hardware since it's already confusing as is with all the double usage of
the different PHY)

> > > > +
> > > > +  airoha,scu:
> > > > +    description: Phandle to the SCU syscon to configure the Serdes line.
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +
> > > > +  '#phy-cells':
> > > > +    description: Describe if the referred PHY is the USB 2.0 PHY or USB 3.0 PHY.
> > > > +    const: 1
> > > 
> > > Which is which here?
> > >
> > 
> > Mhh I think I didn't understand here. #phy-cells describe the
> > parameters to be used for phys property in a different node.
> > 
> > The current usage would be
> > 
> > <&usb0_phy PHY_TYPE_USB2> for USB 2.0
> > or <&usb0_phy PHY_TYPE_USB3> for USB 3.0
> > 
> > This node expose 2 PHY that can be referenced by the single parameters.
> 
> Ah, I didn't know that the 1 cell variant here was type not index.
> 

Yes in the driver I'm maching for type not index as it's very confusing.
Any hint on better describe it on the schema? Maybe I can reword with

"Describe if the referred PHY is PHY_TYPE_USB2 or PHY_TYPE_USB3"

Should be more direct. I understand now the confusion.

> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - airoha,usb2-monitor-clk-sel
> > > > +  - airoha,usb3-serdes
> > > > +  - airoha,scu
> > > > +  - '#phy-cells'
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/phy/airoha,an7581-usb-phy.h>
> > > > +    #include <dt-bindings/soc/airoha,scu-ssr.h>
> > > > +
> > > > +    phy@1fac0000 {
> > > > +        compatible = "airoha,an7581-usb-phy";
> > > > +        reg = <0x1fac0000 0x10000>;
> > > > +
> > > > +        airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL1>;
> > > > +        airoha,usb3-serdes = <AIROHA_SCU_SERDES_USB1>;
> > > > +        airoha,scu = <&scu>;
> > > > +
> > > > +        #phy-cells = <1>;
> > > > +    };
> > > > +
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 8085fdca7bcd..af23c590bbc6 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -763,6 +763,13 @@ S:	Maintained
> > > >  F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
> > > >  F:	drivers/spi/spi-airoha-snfi.c
> > > >  
> > > > +AIROHA USB PHY DRIVER
> > > > +M:	Christian Marangi <ansuelsmth@gmail.com>
> > > > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > > +S:	Maintained
> > > > +F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > > > +F:	include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > > > +
> > > >  AIRSPY MEDIA DRIVER
> > > >  L:	linux-media@vger.kernel.org
> > > >  S:	Orphan
> > > > diff --git a/include/dt-bindings/phy/airoha,an7581-usb-phy.h b/include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > > > new file mode 100644
> > > > index 000000000000..efbb0ae75e3a
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > > > @@ -0,0 +1,11 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > > > +
> > > > +#ifndef _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
> > > > +#define _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
> > > > +
> > > > +#define AIROHA_USB2_MONCLK_SEL0                 0
> > > > +#define AIROHA_USB2_MONCLK_SEL1                 1
> > > > +#define AIROHA_USB2_MONCLK_SEL2                 2
> > > > +#define AIROHA_USB2_MONCLK_SEL3                 3
> > > 
> > > These definitions seem completely pointless. The property is called
> > > "airoha,usb2-monitor-clk-sel" so any use will look like
> > > "airoha,usb2-monitor-clk-sel = <3>;"
> > > That's more informative than the define is, since it doesn't even
> > > truncate "monitor". I'd just delete this header entirely and use the
> > > number. If you want the define in the driver to avoid magic numbers,
> > > just define it in the driver.
> > > 
> > 
> > Well yes the idea here is to not have to use magic numbers in DT and try
> > to use the naming in the SoC documentation since they are called
> > monclk_sel0, monclk_sel1 ...
> 
> Sometimes the "magic" number just makes sense to use. If something is
> completely arbitrary, then sure use one to make it readable. If
> literally the number itself, as it is here, don't bother.

Ok no problem, thanks for hint. More than happy to make this easier and
have less redundant headers.

-- 
	Ansuel

