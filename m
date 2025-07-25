Return-Path: <linux-kernel+bounces-745664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AFCB11CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DAF568560
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625BD2E2EF7;
	Fri, 25 Jul 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X7fKBOwx"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9EB14A4F9;
	Fri, 25 Jul 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440395; cv=none; b=ML5V8peVHNTZCdRPHJQPITtcXjyZtsHLfdNh4ZfeXrUP2QV3sqFrl00jOQUpAs2/944b1Y1YIdc/s8eVZaebX0YzrJSYzrLHxMJ6ol79ooesYxWtmZMid4f7cQsylYUygXpZonRBIna/M3CG7X46Rlc9UDjM/dP1hHZu+VSS0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440395; c=relaxed/simple;
	bh=vY4NI0ylYQoFxth8beeKDC8Pbmq/zB9SSUiYtZNglfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Snj+oo4aWrqEAIvsqQFjskA59wMmOUKCvKGvOuibqyBCWyi7PfZv+1KJEmHeWXbEXAqjtCpY5EcsMyYVPoopcPm38FLiou3Cdj5VPEYbtvRYBkIEYgjou3cy4FuwQi+di9b58vUcuVYhNkXsqmM1l4nEHqn+2yviY+Eq9Sd5ga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X7fKBOwx; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56PAkNbO2163931;
	Fri, 25 Jul 2025 05:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753440383;
	bh=mrRSD3PbZTPAHVSh/yIWQ6kP6ELKmzfyM3fZUnn2niM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=X7fKBOwxApS4IoduzRVtbBYQu/sYtQFJLtz/Lq3y0UbRkIFschtdBwNGgzoztH4tj
	 kGUivju/mcixXVJjJNuUCE4uphyZoX8GD3jNlJiglRVhuv1MqE/M3B9AmPvh7eg9R6
	 OA+8ItOIqJWvFU8+RfY+RFuHrlNOGOJvc+yY7U48=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56PAkNG82237368
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 25 Jul 2025 05:46:23 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 25
 Jul 2025 05:46:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 25 Jul 2025 05:46:23 -0500
Received: from [172.24.18.25] (lt5cd2489kgj.dhcp.ti.com [172.24.18.25])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56PAkJ6l1924763;
	Fri, 25 Jul 2025 05:46:19 -0500
Message-ID: <d15078ef-9a3a-47f6-a1c8-b9eed911e945@ti.com>
Date: Fri, 25 Jul 2025 16:16:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: ti: k3-j721s2-main: Add interrupts
 property
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
 <20250714092708.3944641-2-y-abhilashchandra@ti.com>
 <72545187-4605-40bb-9c68-54670c2e5332@ti.com>
 <05a07a03-3f59-489b-ae55-5f454266bafb@ti.com>
 <457e2428-f766-4e8d-bfb0-32084de45b5a@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <457e2428-f766-4e8d-bfb0-32084de45b5a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 7/22/2025 11:20 AM, Yemike Abhilash Chandra wrote:
> Hi Udit,
>
> Thanks for the review.
>
> On 21/07/25 19:40, Kumar, Udit wrote:
>>
>> On 7/21/2025 7:37 PM, Kumar, Udit wrote:
>>>
>>> On 7/14/2025 2:57 PM, Yemike Abhilash Chandra wrote:
>>>> Add interrupts property for CDNS CSI2RX. Interrupt IDs are taken 
>>>> from the
>>>> J721S2 TRM [0].
>>>>
>>>> Interrupt Line      | Source Interrupt
>>>> --------------------|----------------------------
>>>> GIC500SS_SPI_IN_153 | CSI_RX_IF1_CSI_ERR_IRQ_0
>>>> GIC500SS_SPI_IN_152 | CSI_RX_IF1_CSI_IRQ_0
>>>> GIC500SS_SPI_IN_157 | CSI_RX_IF2_CSI_ERR_IRQ_0
>>>> GIC500SS_SPI_IN_156 | CSI_RX_IF2_CSI_IRQ_0
>>>>
>>>> [0]: https://www.ti.com/lit/zip/spruj28
>>>>
>>>> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
>>>> ---
>>>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi 
>>>> b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>>> index 62f45377a2c9..6f32a2b0c40c 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>>> @@ -1248,6 +1248,9 @@ ti_csi2rx0: ticsi2rx@4500000 {
>>>>           cdns_csi2rx0: csi-bridge@4504000 {
>>>>               compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>>>>               reg = <0x00 0x04504000 0x00 0x1000>;
>>>> +            interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
>>>
>>> Just cosmetic thing, if you are doing v2 then consider 152 first , 
>>> followed by 153.
>>>
>>> Otherwise
>>>
>>> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
>>
>>
>> Sorry, sent too fast, offset of 32 missing .
>>
>
> From what I’ve seen, the SPI interrupt IDs on J721S2 start from 0,
> so I don’t think we need to subtract the 32 offset.
>
>
> Interrupt Input Line   Interrupt ID    Source Interrupt
> -------------------------------------------------------------
> GIC500SS_SPI_IN_00     0               ESM0_ESM_INT_CFG_LVL_0
>
> To confirm this, I’ve latched onto the correct interrupt line, and
> my IRQ handler is getting triggered as expected. I’m also seeing the
> desired output [0].
>
> Let me know if I might be missing anything.
>

Thanks for update and please retain Reviewed-by


> [0]: 
> https://gist.github.com/Yemike-Abhilash-Chandra/f46587ec1ef72671ee31803dd93434b4
>
> Thanks and Regards
> Yemike Abhilash Chandra
>
>>
>>>
>>>> +            interrupt-names = "error_irq", "irq";
>>>>               clocks = <&k3_clks 38 3>, <&k3_clks 38 1>, <&k3_clks 
>>>> 38 3>,
>>>>                   <&k3_clks 38 3>, <&k3_clks 38 4>, <&k3_clks 38 4>;
>>>>               clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
>>>> @@ -1301,6 +1304,9 @@ ti_csi2rx1: ticsi2rx@4510000 {
>>>>           cdns_csi2rx1: csi-bridge@4514000 {
>>>>               compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>>>>               reg = <0x00 0x04514000 0x00 0x1000>;
>>>> +            interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            interrupt-names = "error_irq", "irq";
>>>>               clocks = <&k3_clks 39 3>, <&k3_clks 39 1>, <&k3_clks 
>>>> 39 3>,
>>>>                   <&k3_clks 39 3>, <&k3_clks 39 4>, <&k3_clks 39 4>;
>>>>               clock-names = "sys_clk", "p_clk", "pixel_if0_clk",

