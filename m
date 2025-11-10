Return-Path: <linux-kernel+bounces-892850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF182C45F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7CC3B616A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680430648C;
	Mon, 10 Nov 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PRf6dxUc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C854288C22;
	Mon, 10 Nov 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770605; cv=none; b=Osn9/c1YiDOvnyNK7LqN5DYlH59SoAqV8u67BgIgr5zbWtc25L+j+cJaFgN4N4oxshqOIGAnUqHQNpSFCrE4vB0C+0pc4lIbexZ51XSh0QuDdKTE2vOjv1PKM/vlIpnctaBcMy0T9ereGbjjfTvbHfJQc9s7lQ/zdqtr/idoDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770605; c=relaxed/simple;
	bh=LKcjUvamtaRp5VMo3tOXWpvnOYnMuYx9dZBPJdrUs+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCfZF0TB2fOgdgunntZLfxOiIKhphLV3/PdAVuMml1ozE6i5LLM0/n7TFhSp1L/q2uOyvR4ihJntBgMecXa+AhsJyhdDHUrTbqHGA8OVVgIMYfIMxw4YmJtCAnhQinF2H8CXY7vwWuXgNicxf2qT8DFyLcm4WHBqlycSnvfGNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PRf6dxUc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762770599;
	bh=LKcjUvamtaRp5VMo3tOXWpvnOYnMuYx9dZBPJdrUs+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PRf6dxUcq0UEdSiLe1Onb+Yo+VTS6NVXgiv+vXd5KGFs3q/hoxY2VWb2yKh6CgtYV
	 CDoyGNBBd1VsYgh4H49Vjydts0Ohh73OLYdXRRDcGXrb2Rpm+HGoAIVT5EsVLWsz0L
	 wylVlsZDaV7eC29uWUEj9VRLVKiJsBGshU7PNM5RzX6BlqfkAuUZR2OENrKU6HAgIB
	 c1X2R62jqJQah5MWwxKE3/5mJDYLea91xeuzAAm8fxuNl2DvcDZnS9YhhHRbA0MyMw
	 YLf50y3rEOwrJ7hhFngeOqlToQZYUy8jXhMdDAmM7BSKw+p8boA4VSpFsD5jpb3Cxq
	 7yn8NEXgetc6g==
Received: from [10.40.0.100] (185-67-175-126.lampert.tv [185.67.175.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C2EA917E12E5;
	Mon, 10 Nov 2025 11:29:57 +0100 (CET)
Message-ID: <b89746e1-4574-4b65-af69-c533576ed185@collabora.com>
Date: Mon, 10 Nov 2025 11:29:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/18] media: rockchip: add a driver for the rockchip
 camera interface
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mehdi Djait <mehdi.djait@linux.intel.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Markus Elfring <Markus.Elfring@web.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Collabora Kernel Team <kernel@collabora.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Alexander Shiyan <eagle.alexander923@gmail.com>,
 Val Packett <val@packett.cool>, Rob Herring <robh@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Mehdi Djait <mehdi.djait@bootlin.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bryan O'Donoghue <bod@kernel.org>, Chen-Yu Tsai <wens@csie.org>
References: <20240220-rk3568-vicap-v14-0-b38b6da0fc80@collabora.com>
 <aQ4tJg8r_j4NyKhv@kekkonen.localdomain>
 <074cd08e-0412-49f9-8dd9-b1f96eb11717@collabora.com>
 <20251107185441.GG5558@pendragon.ideasonboard.com>
 <13c43edb-9592-4779-a39a-7856bb0f964d@collabora.com>
 <aRGlvQRVoQs0WjyA@kekkonen.localdomain>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <aRGlvQRVoQs0WjyA@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 11/10/25 09:43, Sakari Ailus wrote:
> Hi Michael, Laurent,
> 
> On Fri, Nov 07, 2025 at 09:51:37PM +0100, Michael Riesch wrote:
>> Hi Laurent,
>>
>> On 11/7/25 19:54, Laurent Pinchart wrote:
>>> On Fri, Nov 07, 2025 at 07:41:59PM +0100, Michael Riesch wrote:
>>>> On 11/7/25 18:32, Sakari Ailus wrote:
>>>>> On Fri, Oct 24, 2025 at 02:51:29PM +0200, Michael Riesch via B4 Relay wrote:
>>>>>> Habidere,
>>>>>>
>>>>>> This series introduces support for the Rockchip Camera Interface (CIF),
>>>>>> which is featured in many Rockchip SoCs in different variations.
>>>>>> For example, the PX30 Video Input Processor (VIP) is able to receive
>>>>>> video data via the Digital Video Port (DVP, a parallel data interface)
>>>>>> and transfer it into system memory using a double-buffering mechanism
>>>>>> called ping-pong mode.
>>>>>> The RK3568 Video Capture (VICAP) unit, on the other hand, features a
>>>>>> DVP and a MIPI CSI-2 receiver that can receive video data independently
>>>>>> (both using the ping-pong scheme).
>>>>>> The different variants may have additional features, such as scaling
>>>>>> and/or cropping.
>>>>>> Finally, the RK3588 VICAP unit constitutes an essential piece of the
>>>>>> camera interface with one DVP, six MIPI CSI-2 receivers, scale/crop
>>>>>> units, and a data path multiplexer (to scaler units, to ISP, ...).
>>>>>
>>>>> I understand both RK3568 and RK3588 include an ISP. Do you have insight on
>>>>> how would this work, should the support for the ISP be added later on?
>>>>
>>>> Short answer: Yes and yes.
>>>>
>>>> Long answer:
>>>>
>>>> The patch series at hand adds support for the PX30 VIP and the RK3568
>>>> VICAP. I cannot really say something about the PX30, but on the RK3568
>>>> VICAP and ISP are orthogonal (the ISP features its own MIPI CSI-2
>>>> receiver, different from that introduced in this series). Thus, ISP
>>>> support can be introduced anytime (whenever someone is motivated ;-)).
>>>
>>> Won't they both be connected to the same sensor though, and probably the
>>> same D-PHY in the SoC ? They don't seem entirely separate to me.
>>
>> The MIPI CSI-2 DPHY is shared, indeed. Thus, they *maybe technically
>> could be* connected to the same sensor, but I don't know whether that
>> works and fail to see why anyone would to such a thing (if it is about
>> raw capture, the MIPI CSI-2 receiver in the ISP can do that on its own).
>>
>> The DPHY can be operated in split mode, with two lanes for VICAP and two
>> lanes for ISP. This is not implemented yet, but can be done at a later
>> stage on PHY level (not media related). In this case, ISP and VICAP can
>> receive data from different subdevices via CSI-2.
> 
> The two would be part of the same media graph in that case and as there are
> two CSI-2 receivers and a single PHY, the PHY would probably need to have a
> sub-device as well, to allow link configuration to be used to select where
> the PHY is connected.
> 
> I don't think we have such a setup elsewhere, and supporting this would
> require changes in the MC framework.

What follows is a response that also addresses issues raised during our
off-list discussion.

First of all, I agree with you that the RK3568 HW is "a bit special" (to
say the least) in that regard. Let's have an outlook to newer SoCs, such
as the RK3588: Here, the MIPI CSI-2 DPHYs (there are two of them) with
their split mode are present as well, but the assignment is fixed. For
example, the RK3588 VICAP has six MIPI CSI-2 receiver units and six MIPI
CSI-2 capture units. Units 1 and 2 handle a different MIPI PHY, units 3
and 5 handle the DPHYs (without split mode), units 4 and/or 6 are active
whenever DPHY 1 and/or 2 is in split mode.

I would model this by adding support for more than one (logical) PHYs
(phy-cells = <1>;) and assigning the logical PHYs to the MIPI CSI-2
receivers. There is not really a possibility to route anything at this
point (routing is done in a MUX unit that takes the different MIPI CSI-2
receivers as inputs).

Now back to the peculiar RK3568 situation: By default the split mode of
the DPHY is off and both VICAP and ISP are able to receive the same data
(from up to four lanes) with their MIPI CSI-2 receivers (not sure
whether both can be active at the same time, though). There are two bits
in the GRF that define the lanes that ISP and VICAP receive in split
mode (lane 0/1 or lane 2/3). Not sure whether these bits are supposed to
be changed during runtime.

I would suggest modelling this on PHY level in DT, e.g., by passing
reasonable properties to the dphy node, such as
    rockchip,dphy-split-mode;
    rockchip,dphy-split-invert;
where the former activates the split mode and assigns lanes 0/1 to the
ISP and lanes 2/3 to the VICAP, and the latter inverts this assignment
(lanes 2/3 to the ISP and lanes 0/1 to the VICAP). This would facilitate
the reasonable use cases with reasonable effort.

Otherwise, to keep it perfectly general and most flexible and
everything, we would have to introduce another subdevice indeed, which
would be active on the RK3568 exclusively. Therefore, I don't see that
the PHY driver introduces this subdevice, but a specialized (syscon?)
MUX driver that deals with the RK3568 GRF bits. Something like this

                           |----------------------|     |-------------|
 Sensor A --- /2 lanes --- | lane 0/1      to ISP | --- | ISP MIPI RX |
                           |                      |     |-------------|
                           |                      |
                           |                      |     |-------------|
 Sensor B --- /2 lanes --- | lane 2/3    to VICAP | --- |VICAP MIPI RX|
                           |----------------------|     |-------------|

But IMHO this will be too much effort for corner use case that I doubt
anyone will actually use.

What do you think:
 - Let's keep the PHYs out of V4L2/MC, ok?
 - Let's model the reasonable use cases with device tree properties in
   the dphy DT node, ok?

> How does the media graph look like for the device at the moment?

Please take a look at the media graph in the documentation patch (PATCH
v14 01/18). This is without the ISP, but gives an overview of what the
RK3568 VICAP is capable of.

Best regards,
Michael

> 
>>
>> BTW the ISP is able to process the data captured by VICAP, but
>> apparently this includes a RAM round trip (VICAP captures to memory, ISP
>> operates in mem2mem mode).
>>
>>> A block diagram that shows connections between the CSI-2 pins, D-PHY,
>>> CSI-2 receivers, VICAP and ISP could help.
>>>
>>>> Once this patch series is merged, I'll push out changes that introduce
>>>> support for the RK3588 VICAP. We can discuss the integration of any
>>>> RK3588 ISP in this scope then -- and there may be some things to discuss
>>>> as there the VICAP and the ISP(s) are directly connected by means of a
>>>> MUX unit in the VICAP.
>>>>
>>>> Alright?
>>>
> 


