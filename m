Return-Path: <linux-kernel+bounces-887905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32431C39570
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 08:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73623B4043
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B132D9EEC;
	Thu,  6 Nov 2025 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuKpiCF6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9B2D7395;
	Thu,  6 Nov 2025 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412921; cv=none; b=A2mRTjq/grFt1xu5XGqfnnwHzgQuxkVUfHPz93a6Js7tlecB3BLzotrIkWZSTWPskdnNz3XOw7vPQDbH4JXaG/qFW6qF6CujoLU0N2Pk0HyJ9Ug+bJXTbItbUlw/HEZEleVMySNWfO9ez9LH2Rc4Tjq34UN4RdVRkMt3HtqbZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412921; c=relaxed/simple;
	bh=ujlzb1GhCpEwgMoCOyyboe177j2wIGRIzVDf5shszs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTPeVWQPn2Mfh3wQB4MDQy6bZBnQ10V2ksajA6BPxrsf81+rO6i7zB7nF+WgxRUjsWyLxpl1mhxEijZWSpMwprRcUYNpo7/0HW1vhPdMC0Br32u9sZwSjgSWLjIMY9DKYCe1gnLspmyMewX2qjhnIpM5PWvsjLozKujhihiN+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuKpiCF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9873BC4CEF7;
	Thu,  6 Nov 2025 07:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762412920;
	bh=ujlzb1GhCpEwgMoCOyyboe177j2wIGRIzVDf5shszs8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nuKpiCF6ORoPYXCgrfpmM/WmahBdskMFxUb8Wfgy3FshuIlh5MotlaFmfjhmiABMy
	 SNVhBdyEa33dHqtNJAJwxHSRErqIgG9ddrpIoH4THCrMaJPSVMOwziSLWY81H+GhAK
	 U+5YUPt+IDwTX3TTxQZ9kDsj6nr7+96FS9MK0MJeY4+NH7pwvk+TNWcjdGywgJzAai
	 lkX4c4lsgra35SflxleGESex7SH6Rp/3Uko9pUllRk5GubZ4E/mvBubyJH5vYccSnS
	 H6ZPIWRVjZvCxcYzolnIVAeFSIG6bCbz3Zcyj5/4r2SMMy+8Vyb88h9lRaUzJWF0fm
	 fpnlAp2CedJZg==
Message-ID: <d700c50a-272d-4b6b-8c39-615d096ffed4@kernel.org>
Date: Thu, 6 Nov 2025 08:08:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding
To: Joan Na <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-4-joan.na@analog.com>
 <512ffe3d-5ab3-4e87-afd2-46f0005a8d17@kernel.org>
 <aQwyH4rYlcWNxGxI@HYB-iPCgmhaB8Cy.ad.analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aQwyH4rYlcWNxGxI@HYB-iPCgmhaB8Cy.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/11/2025 06:29, Joan Na wrote:
>>> +  maxim,bias-low-power-request:
>>> +    type: boolean
>>> +    description: |
>>> +      Request low-power bias mode.
>>> +      When set, the device enters low-power bias mode.
>>> +      Defaults to normal bias mode if this property is not specified.
>>> +    default: false
>>> +
>>> +  maxim,simo-int-ldo-always-on:
>>> +    type: boolean
>>> +    description: |
>>> +      Set internal LDO to always supply 1.8V
>>> +      When set, the internal LDO always supplies 1.8V.
>>> +      By default, the SIMO internal channel supplies 1.8V during low-power mode
>>> +    default: false
>>> +
>>> +  regulators:
>>> +    type: object
>>> +    description: Regulator child nodes
>>> +    patternProperties:
>>> +      "^sbb[0-3]$":
>>> +        type: object
>>> +        $ref: regulator.yaml#
>>> +    properties:
>>> +      maxim,fps-slot:
>>
>> That's not property of regulators. Totally messed indentation.
>>
>>
> 
> The maxim,fps-slot property is specific to the MAX77675 regulators 
> and is used to configure FPS slots individually for each regulator (e.g., sbb0–sbb3). 
> As this represents a device-specific extension rather than a generic regulator property, 
> it is defined under each regulator node.

But you did not define it under each regulator node. That would be fine.
You defined it under regulators. So again that is not a property of
regulators. That's a property of each regulator.

If you bothered to test it, you would see warnings.

> 
>>> +        description: |
>>> +          FPS (Flexible Power Sequencer) slot selection.
>>> +          The Flexible Power Sequencer allows resources to power up under hardware or software control.
>>> +          Additionally, each resource can power up independently or among a group of other regulators
>>> +          with adjustable power-up and power-down slots.
>>> +          This device's regulators provide an additional property to configure the FPS parameters,
>>> +          allowing each regulator to be assigned to an FPS slot for proper power management control.
>>> +          "slot0"   - Assign to FPS Slot 0
>>> +          "slot1"   - Assign to FPS Slot 1
>>> +          "slot2"   - Assign to FPS Slot 2
>>> +          "slot3"   - Assign to FPS Slot 3
>>> +          "default" - Use the default FPS slot value stored in OTP and read from the register
>>> +        $ref: /schemas/types.yaml#/definitions/string
>>> +        enum: ["slot0", "slot1", "slot2", "slot3", "default"]
>>> +        default: default
>>> +
>>> +      maxim,fixed-slew-rate:
>>> +        type: boolean
>>> +        description: |
>>> +          Use fixed slew rate of 2 mV/μs for output voltage transitions.
>>> +          When this property is present, the device uses a constant 2 mV/μs slew rate
>>> +          and ignores any dynamic slew rate configuration.
>>> +          When absent, the device uses the dynamic slew rate specified
>>> +          by 'maxim,dvs-slew-rate-mv-per-us'
>>> +        default: true
>>> +
>>> +    additionalProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - regulators
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/regulator/maxim,max77675-regulator.h>
>>> +
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      max77675: pmic@44 {
>>> +        compatible = "maxim,max77675";
>>> +        reg = <0x44>;
>>> +
>>> +        maxim,en-mode = "slide-switch";
>>> +        maxim,latency-mode = "high";
>>> +        maxim,drv-sbb-strength = "max";
>>> +        maxim,dvs-slew-rate-mv-per-us = <5>;
>>> +        maxim,manual-reset-time-sec = <4>;
>>> +        maxim,en-debounce-time-us = <100>;
>>> +
>>> +        regulators {
>>> +          sbb0: sbb0 {
>>> +            regulator-name = "sbb0";
>>> +            regulator-min-microvolt = <500000>;
>>> +            regulator-max-microvolt = <5500000>;
>>> +            maxim,fps-slot = "default";
>>
>> I don't think this was tested.
>>
>>
>> Best regards,
>> Krzysztof
> 
> Testing on the actual EVKit has been conducted since PATCH V4

I have proofs this was not tested - see email from Rob.

But if you claim it was tested, then please explain me how can you
possible test a binding on EVKit (it is impossible) and how could your
testing miss such obvious errors?


> 


Best regards,
Krzysztof

