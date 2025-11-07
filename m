Return-Path: <linux-kernel+bounces-890892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877EC414E9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B63AFC70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F433B6E8;
	Fri,  7 Nov 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eJxS1HR/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A11336ECC;
	Fri,  7 Nov 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540931; cv=none; b=bRyJzNFDt1lGhPamxGQa/VMAhTda64BW3gjoB7ruuAUKSWW/TDpFJru3rps3JGSXl3WnL73DT1+TYVp70sVYXzRofloqC5dseKvHikxcDmmy7VN53V7hMmTkTsX3rJbP/pehoXWZrwewU0ZpA0ov3IU/9yKEUZyDUqRSUiMj/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540931; c=relaxed/simple;
	bh=QurK2/aeYYaTshySUtEliqovujqE6ttMkDCo9FMWluk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSTQ8zoGXed8LIoepM6hW+nZWJo2p8fUrUh6NLi5jLjd9Hqjayo3zJ3dgXLBhzPgS8T30xBM9iMyon6IoPrfUMPYDsy5pnAS68mSYjaCETKqqPOkZkpIPmz31msxpp84i96+3Q40kz2y0Yb4AfrA3Y7o9lIIW6DDrPmfYHGhA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eJxS1HR/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762540921;
	bh=QurK2/aeYYaTshySUtEliqovujqE6ttMkDCo9FMWluk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eJxS1HR/gSikwNVeEpl1avVNjIn7ZGA5CTTYUp2tru/xqQnyTn0H3l11WaYOyugVm
	 +RbdSUs6PSlOPKSYLA0/iLT+ftjhNzx0D4/qIkVqCykXfPtjI7NdPlL0ekn1tF4Rhw
	 OMp49kkjL8hTafEWwJnuSBP+fWL2jyYRY6HnXojFl466kwGFzqmeWCGK8Ado7+SMss
	 642WgG6YFCbEEZDrMOHAIFkMQSBTqkV3dmpEwXCG1RQOGhlcUTVksZiyU4iGqQWD3c
	 tcZ5lzNIroWcWn84WINhOEpiSRiSISmIZ8Jhs0wd3iv9v1LTZdtLVMSZwAWEmOO9pb
	 bDpj0p60CljWw==
Received: from [10.40.0.100] (185-67-175-126.lampert.tv [185.67.175.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4814D17E108B;
	Fri,  7 Nov 2025 19:42:00 +0100 (CET)
Message-ID: <074cd08e-0412-49f9-8dd9-b1f96eb11717@collabora.com>
Date: Fri, 7 Nov 2025 19:41:59 +0100
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
Cc: Mehdi Djait <mehdi.djait@linux.intel.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Markus Elfring <Markus.Elfring@web.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <aQ4tJg8r_j4NyKhv@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 11/7/25 18:32, Sakari Ailus wrote:
> Hi Michael,
> 
> On Fri, Oct 24, 2025 at 02:51:29PM +0200, Michael Riesch via B4 Relay wrote:
>> Habidere,
>>
>> This series introduces support for the Rockchip Camera Interface (CIF),
>> which is featured in many Rockchip SoCs in different variations.
>> For example, the PX30 Video Input Processor (VIP) is able to receive
>> video data via the Digital Video Port (DVP, a parallel data interface)
>> and transfer it into system memory using a double-buffering mechanism
>> called ping-pong mode.
>> The RK3568 Video Capture (VICAP) unit, on the other hand, features a
>> DVP and a MIPI CSI-2 receiver that can receive video data independently
>> (both using the ping-pong scheme).
>> The different variants may have additional features, such as scaling
>> and/or cropping.
>> Finally, the RK3588 VICAP unit constitutes an essential piece of the
>> camera interface with one DVP, six MIPI CSI-2 receivers, scale/crop
>> units, and a data path multiplexer (to scaler units, to ISP, ...).
> 
> I understand both RK3568 and RK3588 include an ISP. Do you have insight on
> how would this work, should the support for the ISP be added later on?
> 

Short answer: Yes and yes.

Long answer:

The patch series at hand adds support for the PX30 VIP and the RK3568
VICAP. I cannot really say something about the PX30, but on the RK3568
VICAP and ISP are orthogonal (the ISP features its own MIPI CSI-2
receiver, different from that introduced in this series). Thus, ISP
support can be introduced anytime (whenever someone is motivated ;-)).

Once this patch series is merged, I'll push out changes that introduce
support for the RK3588 VICAP. We can discuss the integration of any
RK3588 ISP in this scope then -- and there may be some things to discuss
as there the VICAP and the ISP(s) are directly connected by means of a
MUX unit in the VICAP.

Alright?

Best regards,
Michael


