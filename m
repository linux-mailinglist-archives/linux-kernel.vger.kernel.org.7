Return-Path: <linux-kernel+bounces-801155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB5B44093
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB7854682A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3523D7C7;
	Thu,  4 Sep 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IHTh20+/"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3023ABAB;
	Thu,  4 Sep 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999634; cv=none; b=qTRrPfb6six4zSp+J8yL6JccymtPMS2pfSSqE4AJ8lpirXbnqsggDeIA5J+K4up1xcnSmLsRk1xUT8ouyDh23lwzWpm5VKK4FOHzlvnboklt8rv5bbuc8mkfVIqcuZDP6gLWaYnfiBKbiO3+IRpRlnT/cMenPjZWxmit+4AHt64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999634; c=relaxed/simple;
	bh=QGT4nMVqsTOjW4heFuCYqs5+xXUX0f70MfCiBGQ+/g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yxyia4mEzzek/+d6wlbWic7vzHmCO3NY1juP5NdMNglNOftIi3slzj/kBlmXG7/akxYr3pdrKmfZRuAFLtvoZmr7tYXRgiX7ztqgp8PJwUWiD2/INK1EdfexldvIoHJAllqrGpIiIHmv2w+C6sfNn43GXKLhjm7WhxWV4KVg6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IHTh20+/; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584FR39u3106568;
	Thu, 4 Sep 2025 10:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756999623;
	bh=pnelLJyS9J55hcHKl4p6uGqOHl1Ys0oXzYQLKPfkrEQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IHTh20+/gih3yKu3QsCiGw7GD9puu2EmeSCpat9wR2nCNB4G0+2bYY4GCmLs8rVpz
	 c1TSCdcirLvNUtEWbP4Uf7fJrUBkw5Y/JMEyWukDWZ2mHYJx7tKN26bNdGD5Bpd5rY
	 VVfm89P7Rh90fTBjy4WyjQYpqxFKs5oNw+/6/bOI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584FR3Kj215045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 10:27:03 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 10:27:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 10:27:02 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584FR3Lq3471897;
	Thu, 4 Sep 2025 10:27:03 -0500
Message-ID: <44a55012-32e9-4ecd-8643-d9c0008bc5d2@ti.com>
Date: Thu, 4 Sep 2025 10:27:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62p/j722s: Move sdhci0 from
 common
To: Nishanth Menon <nm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250904004723.2856005-1-jm@ti.com>
 <20250904004723.2856005-2-jm@ti.com>
 <20250904033834.cmn5i7satksnpr6o@revolver>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250904033834.cmn5i7satksnpr6o@revolver>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Nishanth,

On 9/3/25 10:38 PM, Nishanth Menon wrote:
> On 19:47-20250903, Judith Mendez wrote:
>> Since eMMC HS400 has been descoped for j722s due to errata i2478 [0]
>> and is supported for am62p SR1.2 device, remove sdhci0 node from
>> common-main.dtsi and include instead in each device's main.dtsi
>> appropriately.
>>
>> [0] https://www.ti.com/lit/pdf/sprz575
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 25 -------------------
>>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 25 +++++++++++++++++++
>>   arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 22 ++++++++++++++++
>>   3 files changed, 47 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> index 4427b12058a6..84083f5125df 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> @@ -566,31 +566,6 @@ main_gpio1: gpio@601000 {
>>   		clock-names = "gpio";
>>   	};
>>   
>> -	sdhci0: mmc@fa10000 {
>> -		compatible = "ti,am64-sdhci-8bit";
>> -		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
>> -		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> -		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>> -		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
>> -		clock-names = "clk_ahb", "clk_xin";
>> -		bus-width = <8>;
>> -		mmc-ddr-1_8v;
>> -		mmc-hs200-1_8v;
>> -		mmc-hs400-1_8v;
>> -		ti,clkbuf-sel = <0x7>;
>> -		ti,strobe-sel = <0x77>;
>> -		ti,trm-icp = <0x8>;
>> -		ti,otap-del-sel-legacy = <0x1>;
>> -		ti,otap-del-sel-mmc-hs = <0x1>;
>> -		ti,otap-del-sel-ddr52 = <0x6>;
>> -		ti,otap-del-sel-hs200 = <0x8>;
>> -		ti,otap-del-sel-hs400 = <0x5>;
> 
> would'nt it be sufficient to provide this in am62p and keep the common
> stuff here?

Either way works, I can keep a common no problem.

> 
> Additionally handling of SR1.2 should be documented in am62p

WYM? Why document anything on  SR1.2? For am62p, we support HS400 mode
which is the default, all other silicon revision will automatically
be reduced to HS200, that logic is abstracted away in the driver.

There is nothing to document here IMO.

~ Judith



> 
>> -		ti,itap-del-sel-legacy = <0x10>;
>> -		ti,itap-del-sel-mmc-hs = <0xa>;
>> -		ti,itap-del-sel-ddr52 = <0x3>;
>> -		status = "disabled";
>> -	};
>> -
>>   	sdhci1: mmc@fa00000 {
>>   		compatible = "ti,am62-sdhci";
>>   		reg = <0x00 0x0fa00000 0x00 0x1000>, <0x00 0x0fa08000 0x00 0x400>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> index 6aea9d3f134e..fb8473ce403a 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>> @@ -31,6 +31,31 @@ usb1: usb@31100000 {
>>   			snps,usb2-lpm-disable;
>>   		};
>>   	};
>> +
>> +	sdhci0: mmc@fa10000 {
>> +		compatible = "ti,am64-sdhci-8bit";
>> +		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
>> +		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
>> +		clock-names = "clk_ahb", "clk_xin";
>> +		bus-width = <8>;
>> +		mmc-ddr-1_8v;
>> +		mmc-hs200-1_8v;
>> +		mmc-hs400-1_8v;
>> +		ti,clkbuf-sel = <0x7>;
>> +		ti,strobe-sel = <0x77>;
>> +		ti,trm-icp = <0x8>;
>> +		ti,otap-del-sel-legacy = <0x1>;
>> +		ti,otap-del-sel-mmc-hs = <0x1>;
>> +		ti,otap-del-sel-ddr52 = <0x6>;
>> +		ti,otap-del-sel-hs200 = <0x8>;
>> +		ti,otap-del-sel-hs400 = <0x5>;
>> +		ti,itap-del-sel-legacy = <0x10>;
>> +		ti,itap-del-sel-mmc-hs = <0xa>;
>> +		ti,itap-del-sel-ddr52 = <0x3>;
>> +		status = "disabled";
>> +	};
>>   };
>>   
>>   &oc_sram {
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
>> index 993828872dfb..2978fe1a151e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
>> @@ -404,6 +404,28 @@ e5010: jpeg-encoder@fd20000 {
>>   		power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
>>   		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>>   	};
>> +
>> +	sdhci0: mmc@fa10000 {
>> +		compatible = "ti,am64-sdhci-8bit";
>> +		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
>> +		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>> +		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
>> +		clock-names = "clk_ahb", "clk_xin";
>> +		bus-width = <8>;
>> +		mmc-ddr-1_8v;
>> +		mmc-hs200-1_8v;
>> +		ti,clkbuf-sel = <0x7>;
>> +		ti,trm-icp = <0x8>;
>> +		ti,otap-del-sel-legacy = <0x1>;
>> +		ti,otap-del-sel-mmc-hs = <0x1>;
>> +		ti,otap-del-sel-ddr52 = <0x6>;
>> +		ti,otap-del-sel-hs200 = <0x8>;
>> +		ti,itap-del-sel-legacy = <0x10>;
>> +		ti,itap-del-sel-mmc-hs = <0xa>;
>> +		ti,itap-del-sel-ddr52 = <0x3>;
>> +		status = "disabled";
>> +	};
>>   };
>>   
>>   &main_bcdma_csi {
>> -- 
>> 2.51.0
>>
> 


