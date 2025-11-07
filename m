Return-Path: <linux-kernel+bounces-891023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD7C41A26
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D463BBC7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DDD30EF9A;
	Fri,  7 Nov 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PwpJW9oO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613002C3248;
	Fri,  7 Nov 2025 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548703; cv=none; b=CHsSSzdJTqpqh6Za8EkrXaR+fV1mGTVPskNK2scT5QMK/4u3cC54xqQkT1/6y++OLmIeI7iHApJ5YsW7/m6g2fCvS2+hXNlWXGYljVcpGDf91nkxvap5YP/yp7JFlE0DTMUPcxYwuepNDD7kRwP9FQInkgvGItORf0IaNwLDjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548703; c=relaxed/simple;
	bh=8UovAiOWTROIXZYM+ZVGV+MUbMteVqZyd+P1kJY5714=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFwgeszM+XqGp4c5z/ztcW4+fQSSI6unDR4urtDtPplCT49Zz0s+4h6TiuvxsCfaD1GQZ1QZSwEoCJuWTSjQD+1Otowdw6a4Xrrfzaxpg3thxd3lyj9ipFPC2x4+fU7JhQTZOYixVk/AS/meZH5oLCBJVK5zIgCSY7+DJv6m03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PwpJW9oO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762548699;
	bh=8UovAiOWTROIXZYM+ZVGV+MUbMteVqZyd+P1kJY5714=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PwpJW9oOEFMqTwZPZKr4AcwLhrUGSHyEZdZloMFfJkZNeWHxC8gLE8fZCEmqhK62c
	 A2cl0V710LDQdQM54axRs5ZpzuEz1uk0ruczX5ImU0ybiDx9oo5En6YUz+qu0KKO1A
	 6gxkjEiCF0oPIFCMoCNOfTqOTNlfcbQY9kzTPqnS29cuOVJ70XYrDrEFhPbln5A9YU
	 BBjLgTbdxX96s6FDW0aaaxXLjfBIGM+lcoVijXj9E6j/BtdEJP9F3sU0etd/00P7O7
	 efPwYzWpT37DH9qhvqetbqsF5Z9HgOFWshuslCWI8BcD/4ivTKMytg1tFRM64hSWIy
	 AySk/Fmm926Vg==
Received: from [10.40.0.100] (185-67-175-126.lampert.tv [185.67.175.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C3BC17E12D5;
	Fri,  7 Nov 2025 21:51:38 +0100 (CET)
Message-ID: <13c43edb-9592-4779-a39a-7856bb0f964d@collabora.com>
Date: Fri, 7 Nov 2025 21:51:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/18] media: rockchip: add a driver for the rockchip
 camera interface
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
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
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20251107185441.GG5558@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Laurent,

On 11/7/25 19:54, Laurent Pinchart wrote:
> On Fri, Nov 07, 2025 at 07:41:59PM +0100, Michael Riesch wrote:
>> On 11/7/25 18:32, Sakari Ailus wrote:
>>> On Fri, Oct 24, 2025 at 02:51:29PM +0200, Michael Riesch via B4 Relay wrote:
>>>> Habidere,
>>>>
>>>> This series introduces support for the Rockchip Camera Interface (CIF),
>>>> which is featured in many Rockchip SoCs in different variations.
>>>> For example, the PX30 Video Input Processor (VIP) is able to receive
>>>> video data via the Digital Video Port (DVP, a parallel data interface)
>>>> and transfer it into system memory using a double-buffering mechanism
>>>> called ping-pong mode.
>>>> The RK3568 Video Capture (VICAP) unit, on the other hand, features a
>>>> DVP and a MIPI CSI-2 receiver that can receive video data independently
>>>> (both using the ping-pong scheme).
>>>> The different variants may have additional features, such as scaling
>>>> and/or cropping.
>>>> Finally, the RK3588 VICAP unit constitutes an essential piece of the
>>>> camera interface with one DVP, six MIPI CSI-2 receivers, scale/crop
>>>> units, and a data path multiplexer (to scaler units, to ISP, ...).
>>>
>>> I understand both RK3568 and RK3588 include an ISP. Do you have insight on
>>> how would this work, should the support for the ISP be added later on?
>>
>> Short answer: Yes and yes.
>>
>> Long answer:
>>
>> The patch series at hand adds support for the PX30 VIP and the RK3568
>> VICAP. I cannot really say something about the PX30, but on the RK3568
>> VICAP and ISP are orthogonal (the ISP features its own MIPI CSI-2
>> receiver, different from that introduced in this series). Thus, ISP
>> support can be introduced anytime (whenever someone is motivated ;-)).
> 
> Won't they both be connected to the same sensor though, and probably the
> same D-PHY in the SoC ? They don't seem entirely separate to me.

The MIPI CSI-2 DPHY is shared, indeed. Thus, they *maybe technically
could be* connected to the same sensor, but I don't know whether that
works and fail to see why anyone would to such a thing (if it is about
raw capture, the MIPI CSI-2 receiver in the ISP can do that on its own).

The DPHY can be operated in split mode, with two lanes for VICAP and two
lanes for ISP. This is not implemented yet, but can be done at a later
stage on PHY level (not media related). In this case, ISP and VICAP can
receive data from different subdevices via CSI-2.

BTW the ISP is able to process the data captured by VICAP, but
apparently this includes a RAM round trip (VICAP captures to memory, ISP
operates in mem2mem mode).

> A block diagram that shows connections between the CSI-2 pins, D-PHY,
> CSI-2 receivers, VICAP and ISP could help.
> 
>> Once this patch series is merged, I'll push out changes that introduce
>> support for the RK3588 VICAP. We can discuss the integration of any
>> RK3588 ISP in this scope then -- and there may be some things to discuss
>> as there the VICAP and the ISP(s) are directly connected by means of a
>> MUX unit in the VICAP.
>>
>> Alright?
> 

Best regards,
Michael



