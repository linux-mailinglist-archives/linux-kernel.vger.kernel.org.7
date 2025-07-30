Return-Path: <linux-kernel+bounces-751257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAEB166F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5076F560EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2B207E1D;
	Wed, 30 Jul 2025 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wov6FKbR"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EE202F67;
	Wed, 30 Jul 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904125; cv=none; b=ocFLH4NM8F5iOic1fj51Aq70r+gSGKBhW4RUSo/L+95XFP/to36W2S+d14AbnKKuVunZjEE7k0oEhUsYTwp6WqBUiXVXjN3F2gh2+XED2qC/X7ijHcTe37L2Fj7xkd5eZW/zxE5zFLZ/gPABptC4ARQdxRGoITmp/F+LQeG31Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904125; c=relaxed/simple;
	bh=EatnAFvxUfn9CL+hmmDtELT3YUiiXKFRCHGcG4FczKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q6lE1h2r2lp+0sEsWTXCwNxZN/6ir6oRu0Yx8EgTITZyuiAwJ4k8HnovmpLfy1peu5cMrQqWUZXSWwNOsKtmIY9bJWIpXqB+Xaq7bSDAsx/6xB9mlO6MqkshBck3rYJbSxPLH2s3Ew3XUP1WyDXf4OFVu41MUJS+29wpChG02E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wov6FKbR; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56UJZ7NY3317915;
	Wed, 30 Jul 2025 14:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753904107;
	bh=G4zPmGDVYviav51y4z07PJNmrLYIefFNe+Z0UW0kyWU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wov6FKbRnFzXn0KFhskBVG/N65oXBAzsXXL165S809P9YK9nWpg9b3/Tm6JWG9F/W
	 nRiegl2o7OAO+AcmqvZZXrk6WVgLOHa3lcOwWO1QiCl4F88YiAw4Ebc1RU/B9wrcsD
	 UaMgY6mj7Zau93L2LD05XsCqdwfDwyH9v9mRWn0Y=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56UJZ7c63413840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 30 Jul 2025 14:35:07 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 30
 Jul 2025 14:35:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 30 Jul 2025 14:35:07 -0500
Received: from [128.247.81.81] (uda0499903.dhcp.ti.com [128.247.81.81])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56UJZ7ew1443664;
	Wed, 30 Jul 2025 14:35:07 -0500
Message-ID: <570aa0e3-194e-4f5a-8cfc-a4dc525ae002@ti.com>
Date: Wed, 30 Jul 2025 14:35:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: ti: k3-j721s2-main: Add interrupts
 property
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
        "Kumar, Udit"
	<u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
 <20250714092708.3944641-2-y-abhilashchandra@ti.com>
 <72545187-4605-40bb-9c68-54670c2e5332@ti.com>
 <05a07a03-3f59-489b-ae55-5f454266bafb@ti.com>
 <457e2428-f766-4e8d-bfb0-32084de45b5a@ti.com>
Content-Language: en-US
From: Jared McArthur <j-mcarthur@ti.com>
In-Reply-To: <457e2428-f766-4e8d-bfb0-32084de45b5a@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 7/22/25 00:50, Yemike Abhilash Chandra wrote:
> Hi Udit,
> 
> Thanks for the review.
> 
> On 21/07/25 19:40, Kumar, Udit wrote:
>>
>> On 7/21/2025 7:37 PM, Kumar, Udit wrote:
>>>
>>> On 7/14/2025 2:57 PM, Yemike Abhilash Chandra wrote:
>>>> Add interrupts property for CDNS CSI2RX. Interrupt IDs are taken from the
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
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
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
>>> Just cosmetic thing, if you are doing v2 then consider 152 first , followed by 153.
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

The interrupt lines are correct (153, 152, 157, and 152), but when I
read the TRM (specifically the Appendix xls) [0], the lines'
definitions include the offset. Where are you looking for the line
name?

Interrupt Input Line                       | Source Interrupt
-------------------------------------------|-----------------------------
COMPUTE_CLUSTER0_CLEC_SOC_EVENTS_IN_IN_184 | CSI_RX_IF0_CSI_IRQ_OUT_0
COMPUTE_CLUSTER0_CLEC_SOC_EVENTS_IN_IN_185 | CSI_RX_IF0_CSI_ERR_IRQ_OUT_0
COMPUTE_CLUSTER0_CLEC_SOC_EVENTS_IN_IN_188 | CSI_RX_IF1_CSI_IRQ_OUT_0
COMPUTE_CLUSTER0_CLEC_SOC_EVENTS_IN_IN_189 | CSI_RX_IF1_CSI_ERR_IRQ_OUT_0

You may want to change your comment to reflect the TRM's appendix.

[0]: https://www.ti.com/lit/zip/spruj28

> [0]: https://gist.github.com/Yemike-Abhilash-Chandra/f46587ec1ef72671ee31803dd93434b4
> 
> Thanks and Regards
> Yemike Abhilash Chandra
> 
>>
>>>
>>>> +            interrupt-names = "error_irq", "irq";
>>>>               clocks = <&k3_clks 38 3>, <&k3_clks 38 1>, <&k3_clks 38 3>,
>>>>                   <&k3_clks 38 3>, <&k3_clks 38 4>, <&k3_clks 38 4>;
>>>>               clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
>>>> @@ -1301,6 +1304,9 @@ ti_csi2rx1: ticsi2rx@4510000 {
>>>>           cdns_csi2rx1: csi-bridge@4514000 {
>>>>               compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>>>>               reg = <0x00 0x04514000 0x00 0x1000>;
>>>> +            interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            interrupt-names = "error_irq", "irq";
>>>>               clocks = <&k3_clks 39 3>, <&k3_clks 39 1>, <&k3_clks 39 3>,
>>>>                   <&k3_clks 39 3>, <&k3_clks 39 4>, <&k3_clks 39 4>;
>>>>               clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
> 

-- 
Best,
Jared McArthur

