Return-Path: <linux-kernel+bounces-739404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4881B0C5E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2621790BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260B2DA763;
	Mon, 21 Jul 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FTRU1S7c"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C332D8DCA;
	Mon, 21 Jul 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107052; cv=none; b=hZRZxZGXrd6FNxyzA6XzY8GuQN3F3g7swbb+ZqrfkNU4eUzI7zTzB3D+dqLupgNjug0uMeKBwmZcwv976Nv8+vBwCVRQ5td5Xc664Ons9Wx+dLUgGi1vnKres1HauFleII756NzgX8xQ2kbgngY/nt/Hhqrv7Ve5Ecd/Y2yMMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107052; c=relaxed/simple;
	bh=gfBZrQM1TIPK5QmWH+MeLKo35k/zfTpYv/KPq8pP6XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jTS/gWD2iKiymP8mvqLNdRUESP1h1SKtFRSuHhNEjJTgcgW6d1bPtQ3DD2AvQ3mzXRYTY42COdTlo+RkGMTVUkejYghV6I2l1e4q7suAmPWzJS5t1vw6FAJ/aCcswwgOCbsz5OLSHTv5NqbFaz3jMfGQcfgO1A0Nu4H0yn4lAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FTRU1S7c; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56LEAaWw1287724;
	Mon, 21 Jul 2025 09:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753107036;
	bh=Oywn0X9thZxpwHoq6E9zsRAlXFyL01BrvALB43n7K4o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FTRU1S7cFPcSOmGvp+kwZi/8aKS66qkks2Ksxniim52Ctpderbs5lhk1Ca0ixxBa0
	 1mp962mxEfuENK2G2qCfkvcN+QVIxcCItvMZEPrJKPTioPdGTuXFzuQqUhqWstH6qO
	 E2dKkijr6cdQ2UY5CjwACzT2tGFEgmdCFKT2P71c=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56LEAaWY922931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 21 Jul 2025 09:10:36 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 21
 Jul 2025 09:10:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 21 Jul 2025 09:10:35 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56LEAVjD3952843;
	Mon, 21 Jul 2025 09:10:32 -0500
Message-ID: <05a07a03-3f59-489b-ae55-5f454266bafb@ti.com>
Date: Mon, 21 Jul 2025 19:40:30 +0530
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
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <72545187-4605-40bb-9c68-54670c2e5332@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 7/21/2025 7:37 PM, Kumar, Udit wrote:
>
> On 7/14/2025 2:57 PM, Yemike Abhilash Chandra wrote:
>> Add interrupts property for CDNS CSI2RX. Interrupt IDs are taken from 
>> the
>> J721S2 TRM [0].
>>
>> Interrupt Line      | Source Interrupt
>> --------------------|----------------------------
>> GIC500SS_SPI_IN_153 | CSI_RX_IF1_CSI_ERR_IRQ_0
>> GIC500SS_SPI_IN_152 | CSI_RX_IF1_CSI_IRQ_0
>> GIC500SS_SPI_IN_157 | CSI_RX_IF2_CSI_ERR_IRQ_0
>> GIC500SS_SPI_IN_156 | CSI_RX_IF2_CSI_IRQ_0
>>
>> [0]: https://www.ti.com/lit/zip/spruj28
>>
>> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> index 62f45377a2c9..6f32a2b0c40c 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
>> @@ -1248,6 +1248,9 @@ ti_csi2rx0: ticsi2rx@4500000 {
>>           cdns_csi2rx0: csi-bridge@4504000 {
>>               compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>>               reg = <0x00 0x04504000 0x00 0x1000>;
>> +            interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
>
> Just cosmetic thing, if you are doing v2 then consider 152 first , 
> followed by 153.
>
> Otherwise
>
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>


Sorry, sent too fast, offset of 32 missing .


>
>> +            interrupt-names = "error_irq", "irq";
>>               clocks = <&k3_clks 38 3>, <&k3_clks 38 1>, <&k3_clks 38 
>> 3>,
>>                   <&k3_clks 38 3>, <&k3_clks 38 4>, <&k3_clks 38 4>;
>>               clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
>> @@ -1301,6 +1304,9 @@ ti_csi2rx1: ticsi2rx@4510000 {
>>           cdns_csi2rx1: csi-bridge@4514000 {
>>               compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>>               reg = <0x00 0x04514000 0x00 0x1000>;
>> +            interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "error_irq", "irq";
>>               clocks = <&k3_clks 39 3>, <&k3_clks 39 1>, <&k3_clks 39 
>> 3>,
>>                   <&k3_clks 39 3>, <&k3_clks 39 4>, <&k3_clks 39 4>;
>>               clock-names = "sys_clk", "p_clk", "pixel_if0_clk",

