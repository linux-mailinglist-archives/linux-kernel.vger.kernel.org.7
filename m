Return-Path: <linux-kernel+bounces-823986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD13B87DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751EB1C8422B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30066269CE1;
	Fri, 19 Sep 2025 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNNsp212"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7C1FDA;
	Fri, 19 Sep 2025 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758256291; cv=none; b=hlPKns/S9AShHDseIDsgaFUbfOnGZxXRm2Fm+EoLCaUJf6YRJXV2QmyMcOOYB9wVkuc5+C8UQ3g70FyXJmDLA888W+DAykevtYw+2osSUlzHO12NX//toWU9GObopJIERYu0puTMHw3StvHE1Wz5v98b8giXzy24VV39LDOF8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758256291; c=relaxed/simple;
	bh=VG9MVCQIKXsITh66ngwjGOPP+zCczKvbptt+ZuWZkks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWXEYTPt1IRdvjP5VKbHL3fLCi9dvbwXvxugLGjxnKQYPc675kZUD1OKQHc3MAchGLaemokWsP6OlGu/iEz7QDYjmT/CRY2JZeLKGR6CZtgw9jXID/aTtQe0byR5Y2LnK30E2O39f4R2Va+aji80lZsLFrqHjJn1dLXT/g9Ox5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNNsp212; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B39AC4CEF0;
	Fri, 19 Sep 2025 04:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758256291;
	bh=VG9MVCQIKXsITh66ngwjGOPP+zCczKvbptt+ZuWZkks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oNNsp212ABX1KF147KWIySTGFE2HnZMsm/pYcGxSCwdIC2ucOoDAWqH6CCx4hZgoD
	 7uOk5EjWXAWU3ZC3jfWBxYiOMgdGEjVJHaP1OF3NkDEfji4ICQ4hLKIfRa7VFw0EGV
	 MZbbcT2cE0zq2kiw2inoZZZ9UCNShOInY/1+tBmnDuWt11Sbc5i+E00ShlBwlrtk0p
	 MLvFWKyPIcVPkn49N9Aihn3LaKar7TCPcW9Pc3h8Z/EyEwJ/BdJ3IMztyfJrlvK/2H
	 IDIutXlF0OZI8JMOJYC5wsiTo8tWrVb2rTWLcu/xP8vAOpyko/+r+kgS6MaOwHUMaI
	 7uYrkSQGpr7Rg==
Message-ID: <2767fb1e-1369-4dff-9b5f-bfa24b72258e@kernel.org>
Date: Fri, 19 Sep 2025 13:31:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb/ti,am62-usb.yaml: Add
 ti,lane-reverse property
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Aswath Govindraju <a-govindraju@ti.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250908162052.355341-1-richard.genoud@bootlin.com>
 <20250908162052.355341-2-richard.genoud@bootlin.com>
 <20250909-curvy-happy-pug-eeffda@kuoka>
 <464f5995-be7d-41f6-8e95-7d724e2b5308@bootlin.com>
 <674b78ca-e4eb-4921-9564-a4490e7ddbca@kernel.org>
 <a4ec438d-b563-4d5d-ade6-92d216bee9f5@bootlin.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <a4ec438d-b563-4d5d-ade6-92d216bee9f5@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/09/2025 00:41, Richard GENOUD wrote:
> Hi Krzysztof,
> Le 14/09/2025 à 16:55, Krzysztof Kozlowski a écrit :
>> On 09/09/2025 11:11, Richard GENOUD wrote:
>>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>>> index f6e6d084d1c5..ba894d610af0 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>>> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>>> @@ -36,6 +36,11 @@ properties:
>>>>>        items:
>>>>>          - const: ref
>>>>>    
>>>>> +  ti,lane-reverse:
>>>>> +    description:
>>>>> +      Should be present if D+ and D- lanes have to be swapped.
>>>>> +    type: boolean
>>>>
>>>> What is not working with existing data-lanes property?
>>> Hum, indeed. data-lanes could definitely be used here.
>>>
>>>>
>>>> Plus, lanes are swapped per port, not for entire device, no?
>>> I'm not sure to get what you mean here.
>>> The use case I'm trying to address is:
>>> pin AD10(USB1_DM) of the AM625 is routed to USB_DP pin of an USB connector.
>>> And pin AE9(USB1_DP) of the AM625 is routed to USB_DM pin of an USB
>>
>> I understand what you are trying to achieve and my comment was exactly
>> about it. You want to change properties of specific connection, high
>> speed in that case, right? So this belongs to specific port. Just do the
>> homework and run `git grep data-lanes`.
> I'm ok with data-lanes, I'm not arguing on that part.
> 
> I'm being confused by using it on the port, it doesn't seem to fit the 
> hardware.

Why? You do have ports in your hardware, right? Physical connections/wires?

> Let me show the example with the dts k3-am62-main.dtsi:

That's DTS, not exactly hardware.

> 	usbss0: dwc3-usb@f900000 {
> 		compatible = "ti,am62-usb";
> 		reg = <0x00 0x0f900000 0x00 0x800>,
> 		      <0x00 0x0f908000 0x00 0x400>;
> 		clocks = <&k3_clks 161 3>;
> 		clock-names = "ref";
> 		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
> 		#address-cells = <2>;
> 		#size-cells = <2>;
> 		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
> 		ranges;
> 		status = "disabled";
> 
> 		usb0: usb@31000000 {
> 			compatible = "snps,dwc3";
> 			reg = <0x00 0x31000000 0x00 0x50000>;
> 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> 				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> 			interrupt-names = "host", "peripheral";
> 			maximum-speed = "high-speed";
> 			dr_mode = "otg";
> 			snps,usb2-gadget-lpm-disable;
> 			snps,usb2-lpm-disable;
> 		};
> 	};

And where is your proper OF graph?

> The bit used to swap data lanes is in MMR_USB2SS_CFG_PHY_CONFIG Register 
> at address 0x0F900008, so it should be in usbss0 node to match the 
> hardware right?
> 
> (I've checked on all ti,am62-usb devices, they have only one port)

So I don't get what is not matching hardware...



Best regards,
Krzysztof

