Return-Path: <linux-kernel+bounces-868199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A70C04A08
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55F02348A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74329C326;
	Fri, 24 Oct 2025 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHfXOOx2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97651D798E;
	Fri, 24 Oct 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289787; cv=none; b=fIQRSW1uYrdJXD4HQ0fOGkNvU7BZujaLh9EYOUfpY/R/VuDnNvE0PBtPGXa46cpTlC+4oRalBC07Dog9WRD+KsnqvSOaWI2cHQYd5oq6SSEUKLa39He5S5ashDuM9sMXUjVkIvHtM1rBXW0f/90b27ESff7OJbXqFEIS1Ps8Xss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289787; c=relaxed/simple;
	bh=u2i64HNWby+kbJKc8IS7LcAn4TsNBo4u7dXtmgqT8zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3WTfSC9Fudio21Bs/cLk6OeTMERqze75VbR9WfZQdUmInRYXke9RpKE16SUmKzmgf6jwyJ21CWtLm9YWOa/0nOJUc9JWIKXpqCxmOFj+hO77f3a6L1qALjMmRcUGJ04iTE55zX3O1C/qft4UEfHOIthuTDU8O06M2HzrF/A/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHfXOOx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0547FC4CEFB;
	Fri, 24 Oct 2025 07:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761289787;
	bh=u2i64HNWby+kbJKc8IS7LcAn4TsNBo4u7dXtmgqT8zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHfXOOx2kPsIUv8gMyE/MeVmrbuyW7GorGbZuX2+yqCK8d/GRlqaha2fzI9hJOMjc
	 WJM5k5JWT7R/iy+kIqSMxvJ9Kgc7vDqVt0NNn+ItNUGH93ZTeyzMFCxZ2OhMPeVnbf
	 v1UrtfSyJDr8biSBqNfzmwZN3I62gGIKtTULjIt1bF1zuYIlUo3MUd5jDVTkFVvFbI
	 z2WzjexZe2srNwECG4ywMm28sYhFwliwp+mDSfGqyuzI9LfShAgp1xFD4HukfAv58i
	 +2H98rzDsXpeu6PRE+7mpOTQMh/AiiqUvTXMdBExhEMrqEnfviOt1COnddBP0cpYaj
	 XZ/96uARtCLuA==
Date: Fri, 24 Oct 2025 09:09:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joan-Na-adi <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: regulator: Add MAX77675 regulator
 binding
Message-ID: <20251024-judicious-raven-of-economy-e8857b@kuoka>
References: <20251021050830.185626-1-joan.na@analog.com>
 <20251021050830.185626-2-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251021050830.185626-2-joan.na@analog.com>

On Tue, Oct 21, 2025 at 02:08:29PM +0900, Joan-Na-adi wrote:
> From: Joan Na <joan.na@analog.com>
>=20
> Add device tree binding YAML schema for the Maxim MAX77675 PMIC regulator.
> This defines the node properties and supported regulator names for use
> in device tree sources.

Subject: no improvements.

I also missed last time reversed prefixes:
Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patch=
es.html#i-for-patch-submitters

>=20
> Signed-off-by: Joan Na <joan.na@analog.com>
> ---
>  .../bindings/regulator/maxim,max77675.yaml    | 195 ++++++++++++++++++
>  1 file changed, 195 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max=
77675.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77675.y=
aml b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> new file mode 100644
> index 000000000000..0ec0844b6d64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> @@ -0,0 +1,195 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/maxim,max77675.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77675 PMIC Regulator
> +
> +maintainers:
> +  - Joan Na <joan.na@analog.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The MAX77675 is a PMIC providing multiple switching buck regulators
> +  (SBB0=E2=80=93SBB3), accessible via I2C. Each SBB can be configured in=
dividually
> +  in the Device Tree. Additional PMIC settings can be configured through

Drop the second sentence. You do not have to describe how DT works in
DT. We all know it.

> +  device-specific properties.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77675
> +
> +  reg:
> +    maxItems: 1
> +
> +  maxim,en-mode:
> +    description: |
> +      Enable mode configuration.
> +      The debounce time set by 'maxim,en-debounce-time-us' applies to
> +      both push-button and slide-switch modes.
> +      "push-button"  - A long press triggers power-on or power-down
> +      "slide-switch" - Low level powers on, high level powers down
> +      "logic"        - Low level powers on, high level powers down (no d=
ebounce time)
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [push-button, slide-switch, logic]
> +    default: slide-switch
> +
> +  maxim,voltage-change-latency-us:
> +    description: |
> +      Specifies the delay (in microseconds) between an output voltage ch=
ange request
> +      and the start of the SBB voltage ramp.
> +      Use 10us for low-latency or 100us for high-latency (default).

Drop sentence. Don't repeat constraints in free form text.

> +    enum: [10, 100]
> +    default: 100
> +
> +  maxim,drv-sbb-strength:
> +    description: |
> +      SIMO Buck-Boost Drive Strength Trim.
> +      Controls the drive strength of the SIMO regulator's power MOSFETs.
> +      This setting affects the switching speed, which impacts power effi=
ciency and EMI.
> +      "max"  =E2=80=93 Maximum drive strength (~0.6 ns transition time)
> +      "high" =E2=80=93 High drive strength (~1.2 ns transition time)
> +      "low"  =E2=80=93 Low drive strength (~1.8 ns transition time)
> +      "min"  =E2=80=93 Minimum drive strength (~8 ns transition time)
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [max, high, low, min]
> +    default: max
> +
> +  maxim,dvs-slew-rate-mv-per-us:
> +    description: |

Drop |

> +      Dynamic rising slew rate for output voltage transitions, in mV/=CE=
=BCs.
> +      This setting is only used when 'maxim,fixed-slew-rate' is not pres=
ent.
> +    enum: [5, 10]
> +    default: 5
> +
> +  maxim,en-debounce-time-us:

debounce-delay-us

> +    description: Debounce time for the enable pin, in microseconds
> +    enum: [100, 30000]
> +    default: 100
> +
> +  maxim,manual-reset-time-sec:
> +    description: Manual reset time in seconds

That's for the power button? If so, you have here few input properties -
that's reset-time-sec from input.yaml, right? Reference that schema and
provide here constraints.

> +    enum: [4, 8, 12, 16]
> +    default: 4
> +
> +  maxim,en-pullup-disable:
> +    type: boolean
> +    description: |

Drop |

> +      Disable internal pull-up for EN pin.
> +      When set, the internal pull-up is disabled.

These two repeat itself.

> +      Defaults to enabled if this property is not specified.

Don't repeat constraints in free form text.

> +    default: false
> +
> +  maxim,bias-low-power-request:
> +    type: boolean
> +    description: |
> +      Request low-power bias mode.
> +      When set, the device enters low-power bias mode.

These two repeat itself.

> +      Defaults to normal bias mode if this property is not specified.

Don't repeat constraints in free form text.

> +    default: false
> +
> +  maxim,simo-int-ldo-always-on:
> +    type: boolean
> +    description: |
> +      Set internal LDO to always supply 1.8V
> +      When set, the internal LDO always supplies 1.8V.

These two repeat itself.

> +      By default, the SIMO internal channel supplies 1.8V during low-pow=
er mode
> +    default: false
> +
> +  regulators:
> +    type: object
> +    description: Regulator child nodes
> +    patternProperties:
> +      "^sbb[0-3]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        properties:
> +          maxim,fps-slot:
> +            description: |
> +              FPS (Flexible Power Sequencer) slot selection.
> +              The Flexible Power Sequencer allows resources to power up =
under hardware or software control
> +              Additionally, each resource can power up independently or =
among a group of other regulators

Please wrap according to coding style (see coding style document, so at
80).

> +              with adjustable power-up and power-down slots.
> +              This device's regulators provide an additional property to=
 configure the FPS parameters,
> +              allowing each regulator to be assigned to an FPS slot for =
proper power management control.

Redundant statement. Please do not describe how to use Devicetree.
Explain the hardware.

> +              "slot0"   - Assign to FPS Slot 0
> +              "slot1"   - Assign to FPS Slot 1
> +              "slot2"   - Assign to FPS Slot 2
> +              "slot3"   - Assign to FPS Slot 3
> +              "default" - Use the default FPS slot value stored in OTP a=
nd read from the register
> +            $ref: /schemas/types.yaml#/definitions/string
> +            enum: [slot0, slot1, slot2, slot3, default]
> +            default: default
> +
> +          maxim,fixed-slew-rate:
> +            type: boolean
> +            description: |
> +              Use fixed slew rate of 2 mV/=CE=BCs for output voltage tra=
nsitions.

Drop. Please don't write two sentences which are repeating the same.
Write concise yet informative descriptions.

> +              When this property is present, the device uses a constant =
2 mV/=CE=BCs slew rate
> +              and ignores any dynamic slew rate configuration.
> +              When absent, the device uses the dynamic slew rate specifi=
ed
> +              by 'maxim,dvs-slew-rate-mv-per-us'
> +            default: true
> +
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators

Best regards,
Krzysztof


