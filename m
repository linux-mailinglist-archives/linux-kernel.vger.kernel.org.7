Return-Path: <linux-kernel+bounces-887821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA0BC39293
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD71C4E6117
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1430A2D7DEA;
	Thu,  6 Nov 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwEiKKl3"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564777E0E8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762406953; cv=none; b=Qy/DTFWAE6goielIWEpBFVtmfuJkltdMOS3dccfWjKGrMyhJI2DQooHMoO3f/jm5EGdkLnXSSaPIaUwgLVDPGJXFzaM0UReXirtjq9mgM0+0OkPP8FUlSjQVpc1v9SNeBDtI7DrIBGhgSCp/OJudW34mwiOC+2SSEISR1IgFxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762406953; c=relaxed/simple;
	bh=n2loI6PnkdWc/Xcsx1+XnYItNZkmsLD8O+LWC/I7LuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTgFoI+1fwjfRQY3peXsbVxiQ/8ViOe/OM1OyuPqp2oykFnutiunrE9cy7kuW67zPwh+pNpVCTXWTtHo2lH5f5lGI1JfxH3xqXpOAq9IrTZJA8T19btUbSoFNO7iIe0fHKYWZmEppudLoaqIMcXTnLKu8vkn1G2sotRAy+1BbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwEiKKl3; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b9ef786babcso384300a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762406950; x=1763011750; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QZf7nzpvEhPnYK8e5saXeTYFZVlI/+ZhnP5xGtJSFjQ=;
        b=AwEiKKl3Uh6ce1TvXL2K5/nOxtXeCC65A1/CK6q+OfQXN/Gc81rR/FVprSdyyrLWme
         wZmhlX65bcQqvJlLC6679l8HuEZjhkeckj1Uj7ndeqt0Qae/QoIpeY+RifVv1OjRw5pE
         uclIaeJCbsINjfploePwQx9mFaBvSKjf5oyxA+i7vj5ef7IH9dRsj61D6AZi60SVyKwH
         jCWDUY1R+4pOZXllED+UzVJUdI0LXlCKh8jwoyTHE1rwKqcOnDCcD5C8qNsxatLyc5vY
         FAXCuu5kGkUjP17l8M/ypstSSe4DW05n05oMPPbVdxZ5Rn9aK5XdD/aPEY4JXVry3ylk
         130A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762406950; x=1763011750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZf7nzpvEhPnYK8e5saXeTYFZVlI/+ZhnP5xGtJSFjQ=;
        b=mp/Dq/QVOZwiDkQ/hZewH+QhalIiHW1Ru5MC8gJAQbZZ5441WqLiRyC9PO9L/QT0F+
         i9dOMTfxhSSpgsdkHuhSmgx0gKiJFK+xAZFsmRU6vv479lKaOU17kiqW0xj0xU7CWf7K
         DfNZpG+bqLp7Q1lA5K8UFuuoWl7cDj+zXAnOlPSYp4zey0ifU6vAFRbrsBCKoxbDCt85
         y9WlUvlqGqvsmlBY8VUobGJXUWRCyfphXi1SGLi4x+XzKZViCua87LemOZPhj+KFf+oM
         nTH2MY2iisIFBj6vHrZm4RYYCGoSmW06X1YLHQTsVeFTnBLk+QCLN/9kb39QNU08EzAb
         swXg==
X-Forwarded-Encrypted: i=1; AJvYcCW2VhGx7oeuYvMf/x0cuT2jrQ/gQpgMq7EkC1AZlxB8c6bC94pr/wPlJTobloD0t+bK5dMuVo4g2BX2wJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruxHwzQ1oyJXWuIp84h5xh3AaTNAKibrzM52vfW5ENc7Pt3yO
	z7hxGQ9D/6w37gU+hntT9WRQemkuJcgLmVS9M4P2SlXYjW/ur/gXwN21
X-Gm-Gg: ASbGncsiFYX0MrpmR3OH0EKMuXwkvU8uAL9oxgmPj78CBNlh1sJdQfX9ELM+gF8gry+
	QZ4PKVjmNtjBLw1T1z0nFkGdFrX76QZc3yH/fdREzuTnJZkqfz5OPG+OawzsOH/a6OVaK5fmpR8
	Od1ODK2TDbI+7ax6vXHWtbVGlOCDUQHSG5Yt2OQbp+FVtwE2kPAJP52ZbmaAon3M7C+h+FttPo+
	GidlrAOxA4bkVJmDQ8o6VI379MmDDlOa9cZgNieRnC6yZySVQMaSudNBJIFchru0dFVRafQsSQm
	gBKFqMyqupazcnlYuo17fkgpq8U8YNEyfS8oOXsT5TCTJ+XbkMiWwJsrQtugHUN8F1CfWOZd52G
	tS0N3uhuqW9I9FksDVl6Q3tNgiKIsiyH/ETfCc6izq8EOkQLZM17HwPRE3wA9aqnr1CH+Ir4wgw
	rMFlK9PRrYg87w1X9bn7wrsKC9NVVWgWDeRx0n9qk=
X-Google-Smtp-Source: AGHT+IFT+jrjXMaHwGsQ6O7aIkM6xiLZOEWqOora2R1jFqITYFI+TEHDGkIN0NlaP9WS2/NVUzFxrQ==
X-Received: by 2002:a17:902:ce04:b0:295:54cb:a8df with SMTP id d9443c01a7336-2962ae4cc76mr83028555ad.36.1762406950342;
        Wed, 05 Nov 2025 21:29:10 -0800 (PST)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509683easm13781345ad.15.2025.11.05.21.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 21:29:09 -0800 (PST)
Date: Thu, 6 Nov 2025 14:29:03 +0900
From: Joan Na <joan.na.devcode@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding
Message-ID: <aQwyH4rYlcWNxGxI@HYB-iPCgmhaB8Cy.ad.analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-4-joan.na@analog.com>
 <512ffe3d-5ab3-4e87-afd2-46f0005a8d17@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <512ffe3d-5ab3-4e87-afd2-46f0005a8d17@kernel.org>

On Tue, Oct 14, 2025 at 10:14:15AM +0200, Krzysztof Kozlowski wrote:
> On 14/10/2025 07:31, Joan-Na-adi wrote:
> > From: Joan Na <joan.na@analog.com>
> > 
> > Add device tree binding YAML schema for the Maxim MAX77675 PMIC regulator.
> > This defines the node properties and supported regulator names for use
> > in device tree sources.

Hello Krzysztof,

Thank you again for your helpful feedback.

> 
> A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
> prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 

I plan to update the patch subject to avoid redundancy. The new title is:
dt-bindings: regulator: Add support for MAX77675 PMIC


> > 
> > Fixed:
> > - Missing explanation of `maxim,fps-slot` default value
> > - Updated DT binding enums to use string values (e.g., "low", "high") instead of integers
> > - Converted several binary properties to boolean type
> > - Renamed time-based properties to use standard unit suffixes (e.g., "-sec", "-us")
> > - Added default values for properties
> 
> 
> Probably you wanted a changelog? Changelog goes to --- with details
> against EACH version. Please start using b4 if canonical patch format is
> tricky. b4 would help.
>

I have applied this from PATCH V4.

> > 
> > Signed-off-by: Joan Na <joan.na@analog.com>
> > ---
> >  .../bindings/regulator/maxim,max77675.yaml    | 205 ++++++++++++++++++
> >  1 file changed, 205 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> > new file mode 100644
> > index 000000000000..6be29eced039
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> > @@ -0,0 +1,205 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/maxim,max77675.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX77675 PMIC Regulator
> > +
> > +maintainers:
> > +  - Joan Na <joan.na@analog.com>
> > +
> > +description: |
> > +  The MAX77675 is a PMIC providing multiple switching buck regulators
> > +  (SBB0–SBB3), accessible via I2C. Each SBB can be configured individually
> > +  in the Device Tree. Additional PMIC settings can be configured through
> > +  device-specific properties.
> > +  Users should use the macros from dt-bindings/regulator/maxim,max77675-regulator.h
> > +
> > +allOf:
> > +  - $ref: regulator.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: maxim,max77675
> 
> Please organize the patch documenting compatible (DT bindings) before
> their user.
> See also:
> https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46
> 

I have changed the commit order starting from PATCH V5.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  maxim,en-mode:
> > +    description: |
> > +      Enable mode configuration.
> > +      "push-button"  - Push button
> > +      "slide-switch" - Slide switch
> > +      "logic" - Logic mode
> 
> You just repeat the name in the description. Say something useful.
> 

Updated the DT property description as follows:
description: |
      Enable mode configuration.
      The debounce time set by 'adi,debounce-time-us' applies to
      both push-button and slide-switch modes.
      "push-button"  - A long press triggers power-on or power-down
      "slide-switch" - Low level powers on, high level powers down
      "logic"        - Low level powers on, high level powers down (no debounce time)

> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: ["push-button", "slide-switch", "logic"]
> > +    default: "slide-switch"
> > +
> > +  maxim,latency-mode:
> > +    description: |
> > +      Latency mode for voltage transition:
> > +      "high" - High latency (100μs)
> > +      "low"  - Low latency (10μs)
> 
> So use values 100 or 10, and proper type (-us)
> 
>

I have applied this from PATCH V5.

> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: ["high", "low"]
> > +    default: "high"
> > +
> > +  maxim,drv-sbb-strength:
> > +    description: |
> > +      SIMO Buck-Boost Drive Strength Trim.
> > +      Controls the drive strength of the SIMO regulator's power MOSFETs.
> > +      This setting affects the switching speed, which impacts power efficiency and EMI.
> > +      "max"  – Maximum drive strength (~0.6 ns transition time)
> > +      "high" – High drive strength (~1.2 ns transition time)
> > +      "low"  – Low drive strength (~1.8 ns transition time)
> > +      "min"  – Minimum drive strength (~8 ns transition time)
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: ["max", "high", "low", "min"]
> > +    default: "max"
> > +
> > +  maxim,dvs-slew-rate-mv-per-us:
> 
> ... like here.
> 
> > +    description: |
> > +      Dynamic rising slew rate for output voltage transitions, in mV/μs.
> 
> Except you said mv/us, not us. Confusing.
> 

Would it be acceptable to keep the current name "mv-per-us"?

> > +      This setting is only used when 'maxim,fixed-slew-rate' is not present.
> > +    enum: [5, 10]
> > +    default: 5
> > +
> > +  maxim,en-debounce-time-us:
> > +    description: |
> > +      Debounce time for the enable pin, in microseconds
> > +    enum: [100, 30000]
> > +    default: 100
> > +
> > +  maxim,manual-reset-time-sec:
> > +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 

I have applied this from PATCH V5.

> > +      Manual reset time in seconds:
> > +    enum: [4, 8, 12, 16]
> > +    default: 4
> > +
> > +  maxim,en-pullup-disable:
> > +    type: boolean
> > +    description: |
> > +      Disable internal pull-up for EN pin.
> > +      When set, the internal pull-up is disabled.
> > +      Defaults to enabled if this property is not specified.
> 
> This and maybe few more properties look like pinctrl bindings. Maybe
> properties from pincfg are applicable?
> 

The maxim,en-pullup-disable property disables the internal pull-up of the EN pin.
While it looks similar to a pinctrl configuration,
it is actually handled by a device-specific control in the max77675 register,
not through the SoC’s pinctrl subsystem.
So, would it be acceptable to keep the current naming and implementation?

> > +    default: false
> > +
> > +  maxim,bias-low-power-request:
> > +    type: boolean
> > +    description: |
> > +      Request low-power bias mode.
> > +      When set, the device enters low-power bias mode.
> > +      Defaults to normal bias mode if this property is not specified.
> > +    default: false
> > +
> > +  maxim,simo-int-ldo-always-on:
> > +    type: boolean
> > +    description: |
> > +      Set internal LDO to always supply 1.8V
> > +      When set, the internal LDO always supplies 1.8V.
> > +      By default, the SIMO internal channel supplies 1.8V during low-power mode
> > +    default: false
> > +
> > +  regulators:
> > +    type: object
> > +    description: Regulator child nodes
> > +    patternProperties:
> > +      "^sbb[0-3]$":
> > +        type: object
> > +        $ref: regulator.yaml#
> > +    properties:
> > +      maxim,fps-slot:
> 
> That's not property of regulators. Totally messed indentation.
> 
>

The maxim,fps-slot property is specific to the MAX77675 regulators 
and is used to configure FPS slots individually for each regulator (e.g., sbb0–sbb3). 
As this represents a device-specific extension rather than a generic regulator property, 
it is defined under each regulator node.

> > +        description: |
> > +          FPS (Flexible Power Sequencer) slot selection.
> > +          The Flexible Power Sequencer allows resources to power up under hardware or software control.
> > +          Additionally, each resource can power up independently or among a group of other regulators
> > +          with adjustable power-up and power-down slots.
> > +          This device's regulators provide an additional property to configure the FPS parameters,
> > +          allowing each regulator to be assigned to an FPS slot for proper power management control.
> > +          "slot0"   - Assign to FPS Slot 0
> > +          "slot1"   - Assign to FPS Slot 1
> > +          "slot2"   - Assign to FPS Slot 2
> > +          "slot3"   - Assign to FPS Slot 3
> > +          "default" - Use the default FPS slot value stored in OTP and read from the register
> > +        $ref: /schemas/types.yaml#/definitions/string
> > +        enum: ["slot0", "slot1", "slot2", "slot3", "default"]
> > +        default: default
> > +
> > +      maxim,fixed-slew-rate:
> > +        type: boolean
> > +        description: |
> > +          Use fixed slew rate of 2 mV/μs for output voltage transitions.
> > +          When this property is present, the device uses a constant 2 mV/μs slew rate
> > +          and ignores any dynamic slew rate configuration.
> > +          When absent, the device uses the dynamic slew rate specified
> > +          by 'maxim,dvs-slew-rate-mv-per-us'
> > +        default: true
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - regulators
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/regulator/maxim,max77675-regulator.h>
> > +
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      max77675: pmic@44 {
> > +        compatible = "maxim,max77675";
> > +        reg = <0x44>;
> > +
> > +        maxim,en-mode = "slide-switch";
> > +        maxim,latency-mode = "high";
> > +        maxim,drv-sbb-strength = "max";
> > +        maxim,dvs-slew-rate-mv-per-us = <5>;
> > +        maxim,manual-reset-time-sec = <4>;
> > +        maxim,en-debounce-time-us = <100>;
> > +
> > +        regulators {
> > +          sbb0: sbb0 {
> > +            regulator-name = "sbb0";
> > +            regulator-min-microvolt = <500000>;
> > +            regulator-max-microvolt = <5500000>;
> > +            maxim,fps-slot = "default";
> 
> I don't think this was tested.
> 
> 
> Best regards,
> Krzysztof

Testing on the actual EVKit has been conducted since PATCH V4

-- 
Best regards,
Joan Na


