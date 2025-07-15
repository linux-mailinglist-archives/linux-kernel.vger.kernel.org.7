Return-Path: <linux-kernel+bounces-731597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7563B056FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48135188BCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54AF272E6D;
	Tue, 15 Jul 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TU+S+Vjx"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A62264D5;
	Tue, 15 Jul 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572834; cv=none; b=Jrt2zYk0h+DbQozAtMbpNUq/+yZtZiqOhiv8FuKUQ2pDo+zJ2nSSIUBKCMzqhJ0WF2ECNzFDf0RUM0n7iqC7b7H89VjoLPIDwibdEVCEP4RGq4yOkT492F4ZEgN72QCdc7NxzyfDPYOeI6XL68eIWwybdkR6LYvUS7B58kEGl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572834; c=relaxed/simple;
	bh=KTw1n1aRAlqNRwWDKpZ3tk0QLNss+mT8kTZgk4V0Nmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kJe98Yj9GHtlhuwv9TSwuWVRF+wl+Rix3ZyhUGBmTWC8WotlObSwOeZsxnvVnb/zVfTv8SG7RmVDDe3dWG8s5XfImP336QMuVuTngnhEV6vNOmbCnVf+jEcho4bXtouAHHaVDh78Y8z3q3tqRUQmGvmrXqvnywZ8ysbGSgEAbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TU+S+Vjx; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56F9ks402235260;
	Tue, 15 Jul 2025 04:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752572814;
	bh=jSjJtqdXOK2619OVhSk/cvk2yD64s3HepL+hT3bVVSo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TU+S+Vjxvo1w/t9UsKNrQ7K9dEjlS8PBqFfDcOZohoVDL/YBUsR2zQLSoonzh2XRQ
	 B66XhiP0jHH3c5+Zy71bpyzUZc0p16vdIUNf9zkTKlKO/tMjfd6WyfcaLJ26kxklsw
	 Y7tqfJ8rHVa4RCgsuR4xGjx3Y0ctRPUnsUdFH01I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56F9kstD1177302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 04:46:54 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 04:46:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 04:46:54 -0500
Received: from [172.24.227.166] (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.166])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56F9kotu2356744;
	Tue, 15 Jul 2025 04:46:51 -0500
Message-ID: <e8400355-d59e-44ad-8f69-af068a6ee85c@ti.com>
Date: Tue, 15 Jul 2025 15:16:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] arm64: dts: ti: k3-j784s4-j742s2-main-common: add
 DSI & DSI PHY
To: Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>, <u-kumar1@ti.com>
References: <20250624082619.324851-1-j-choudhary@ti.com>
 <20250624082619.324851-2-j-choudhary@ti.com>
 <ed2ccf14-b470-4f3e-a793-61866cf7e26c@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <ed2ccf14-b470-4f3e-a793-61866cf7e26c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Vignesh,

On 26/06/25 11:56, Vignesh Raghavendra wrote:
> Hi
> 
> On 24/06/25 13:56, Jayesh Choudhary wrote:
>> Add DT nodes for DPI to DSI Bridge and DSI Phy.
>> The DSI bridge is Cadence DSI and the PHY is a
>> Cadence DPHY with TI wrapper.
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   .../dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> index 363d68fec387..2413c4913a8b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> @@ -2517,6 +2517,43 @@ watchdog18: watchdog@2550000 {
>>   		status = "reserved";
>>   	};
>>   
>> +	dphy_tx0: phy@4480000 {
>> +		compatible = "ti,j721e-dphy";
>> +		reg = <0x0 0x04480000 0x0 0x1000>;
> 
> Follow the convention of the file. Use:
> 
> 		reg = <0x00 0x04480000 0x00 0x1000>;

Okay I will add padding.
Will add it to 4th field as well as I am seeing it in some
nodes:

reg = <0x00 0x04480000 0x00 0x00001000>;

> 
> Please fix throughout the series.


Okay.

> 
>> +		clocks = <&k3_clks 402 20>, <&k3_clks 402 3>;
>> +		clock-names = "psm", "pll_ref";
>> +		#phy-cells = <0>;
>> +		power-domains = <&k3_pds 402 TI_SCI_PD_EXCLUSIVE>;
>> +		assigned-clocks = <&k3_clks 402 3>;
>> +		assigned-clock-parents = <&k3_clks 402 4>;
>> +		assigned-clock-rates = <19200000>;
>> +		status = "disabled";
>> +	};
>> +
>> +	dsi0: dsi@4800000 {
>> +		compatible = "ti,j721e-dsi";
>> +		reg = <0x0 0x04800000 0x0 0x100000>, <0x0 0x04710000 0x0 0x100>;
>> +		clocks = <&k3_clks 215 2>, <&k3_clks 215 5>;
>> +		clock-names = "dsi_p_clk", "dsi_sys_clk";
>> +		power-domains = <&k3_pds 215 TI_SCI_PD_EXCLUSIVE>;
> 
>> +		interrupt-parent = <&gic500>;
> 
> This is implied and can be dropped.

Will drop.

Warm Regards,
Jayesh

> 
>> +		interrupts = <GIC_SPI 600 IRQ_TYPE_LEVEL_HIGH>;
>> +		phys = <&dphy_tx0>;
>> +		phy-names = "dphy";
>> +		status = "disabled";
>> +
>> +		dsi0_ports: ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			port@0 {
>> +				reg = <0>;
>> +			};
>> +			port@1 {
>> +				reg = <1>;
>> +			};
>> +		};
>> +	};
>> +
>>   	mhdp: bridge@a000000 {
>>   		compatible = "ti,j721e-mhdp8546";
>>   		reg = <0x0 0xa000000 0x0 0x30a00>,
> 

