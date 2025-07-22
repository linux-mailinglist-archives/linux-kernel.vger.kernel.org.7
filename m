Return-Path: <linux-kernel+bounces-740214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6316B0D176
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7973B1F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC62B28D845;
	Tue, 22 Jul 2025 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NkULTkd8"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BD28C87F;
	Tue, 22 Jul 2025 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163467; cv=none; b=IhfxaE//JvtsFabV9cvIGtiPUgJ9LbW6eGCSvZAhjti6ybv9oYh3mU5L9NNhI/yUfLOKrDBU7rhJyJUnrfM4LPQojObyTXdNfsmOO5cfM3oXRB5W83j59pfy9UvUyHy7Sfr+g5ydeKtvEzB/LuhWOmO+VOf7FXv32ohqw6q4dpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163467; c=relaxed/simple;
	bh=lLdzGqsqwQjhOsz2WfLsv4rKsYxR9ZpICAIUjq8d/nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UgVtSNVY2EgZmdi4LDO8woduGrsN/FdZA6XOkN1orduh8v0150L87PIL5YV5FE7d4QIU4iK6alGMu1taa5jfukAbYe4sYwz3fy2+fc7AqiRprs0i0qPWTlaZLcsKlnMtU9bw7Q9cX6o+2PFAYv2v/uWvmPuY1IOByevUlREb5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NkULTkd8; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56M5ouYR975209;
	Tue, 22 Jul 2025 00:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753163456;
	bh=/HA54An8RWm8lbhsfU7W1tLrMDcipcyCl86TuK6LUpE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NkULTkd8CLRwZL9F4AcpCREgbRZ0ibeZauJ1ob/YiYnlraZPHpzoJgze025JXhc6w
	 kCi1OsbCQoV3H9LJG83V5k3eXnqkESUqLaKSJOSYr9IqK7k3BXjhIqE5LQkkhQioyR
	 uZonsnsJfF6Tin4Yk4T050tRH8cx5z+7P5jUGmBY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56M5ouKh1882953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 22 Jul 2025 00:50:56 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 00:50:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 00:50:55 -0500
Received: from [172.24.227.115] (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56M5opG6535126;
	Tue, 22 Jul 2025 00:50:52 -0500
Message-ID: <457e2428-f766-4e8d-bfb0-32084de45b5a@ti.com>
Date: Tue, 22 Jul 2025 11:20:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: ti: k3-j721s2-main: Add interrupts
 property
To: "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
 <20250714092708.3944641-2-y-abhilashchandra@ti.com>
 <72545187-4605-40bb-9c68-54670c2e5332@ti.com>
 <05a07a03-3f59-489b-ae55-5f454266bafb@ti.com>
Content-Language: en-US
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
In-Reply-To: <05a07a03-3f59-489b-ae55-5f454266bafb@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Udit,

Thanks for the review.

On 21/07/25 19:40, Kumar, Udit wrote:
> 
> On 7/21/2025 7:37 PM, Kumar, Udit wrote:
>>
>> On 7/14/2025 2:57 PM, Yemike Abhilash Chandra wrote:
>>> Add interrupts property for CDNS CSI2RX. Interrupt IDs are taken from 
>>> the
>>> J721S2 TRM [0].
>>>
>>> Interrupt Line      | Source Interrupt
>>> --------------------|----------------------------
>>> GIC500SS_SPI_IN_153 | CSI_RX_IF1_CSI_ERR_IRQ_0
>>> GIC500SS_SPI_IN_152 | CSI_RX_IF1_CSI_IRQ_0
>>> GIC500SS_SPI_IN_157 | CSI_RX_IF2_CSI_ERR_IRQ_0
>>> GIC500SS_SPI_IN_156 | CSI_RX_IF2_CSI_IRQ_0
>>>
>>> [0]: https://www.ti.com/lit/zip/spruj28
>>>
>>> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi 
>>> b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> index 62f45377a2c9..6f32a2b0c40c 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>>> @@ -1248,6 +1248,9 @@ ti_csi2rx0: ticsi2rx@4500000 {
>>>           cdns_csi2rx0: csi-bridge@4504000 {
>>>               compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>>>               reg = <0x00 0x04504000 0x00 0x1000>;
>>> +            interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
>>
>> Just cosmetic thing, if you are doing v2 then consider 152 first , 
>> followed by 153.
>>
>> Otherwise
>>
>> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> 
> 
> Sorry, sent too fast, offset of 32 missing .
> 

 From what I’ve seen, the SPI interrupt IDs on J721S2 start from 0,
so I don’t think we need to subtract the 32 offset.


Interrupt Input Line   Interrupt ID    Source Interrupt
-------------------------------------------------------------
GIC500SS_SPI_IN_00     0               ESM0_ESM_INT_CFG_LVL_0

To confirm this, I’ve latched onto the correct interrupt line, and
my IRQ handler is getting triggered as expected. I’m also seeing the
desired output [0].

Let me know if I might be missing anything.

[0]: 
https://gist.github.com/Yemike-Abhilash-Chandra/f46587ec1ef72671ee31803dd93434b4

Thanks and Regards
Yemike Abhilash Chandra

> 
>>
>>> +            interrupt-names = "error_irq", "irq";
>>>               clocks = <&k3_clks 38 3>, <&k3_clks 38 1>, <&k3_clks 38 
>>> 3>,
>>>                   <&k3_clks 38 3>, <&k3_clks 38 4>, <&k3_clks 38 4>;
>>>               clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
>>> @@ -1301,6 +1304,9 @@ ti_csi2rx1: ticsi2rx@4510000 {
>>>           cdns_csi2rx1: csi-bridge@4514000 {
>>>               compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>>>               reg = <0x00 0x04514000 0x00 0x1000>;
>>> +            interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
>>> +            interrupt-names = "error_irq", "irq";
>>>               clocks = <&k3_clks 39 3>, <&k3_clks 39 1>, <&k3_clks 39 
>>> 3>,
>>>                   <&k3_clks 39 3>, <&k3_clks 39 4>, <&k3_clks 39 4>;
>>>               clock-names = "sys_clk", "p_clk", "pixel_if0_clk",

