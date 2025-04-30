Return-Path: <linux-kernel+bounces-626393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BADB1AA429D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 07:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137E04A6F90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 05:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F01E4110;
	Wed, 30 Apr 2025 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R4wB0hke"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124A2F5B;
	Wed, 30 Apr 2025 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992164; cv=none; b=Txh3R0T/H3DJP/TwLF+ZykB95jopPupERXlnp9o7totjCdaDXha/l7ncSAodYbpdL89spTNSSuab35JCljVCcHfCtQORf5ucgnriUOCIfl6H9FQgG8xkqh07Q/If0isr9jEGardyLR8/hrjExChN9m1duqsONQ2vIjo31/vk5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992164; c=relaxed/simple;
	bh=SgKFRrj7vUSXt1gze5yicj4cZw1w2QV5fN92BkKMOdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fWd/igVURoxrjoQO/d241x9V7gOUO9RMQTpXCNbeEFGoW3MRHDymb0LPQUCR9Z8CcnLlLxIaoI5DJzmoWYvrC8j6cmdnI/V/tuwpJRxy72jVCl6JcObHmSA7cHkA8aYiAmJzEp/DeB75zfWLEc3aWpLq6oHSzxtrPVeQIp7/p/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R4wB0hke; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53U5nFpR3282298
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 00:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745992155;
	bh=SVjrJMnJOpuiRTEnMRkig0no+x/TJr9/Pw/Rfkn0XB0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=R4wB0hke52yhPC1TGBVIRgSk8mKtcYCBoIcTfx02J0kQqByFO/6iHOjABczKflkFJ
	 YM+uYtF3ZDLB0Bx7gIgaZvHPGJJSBlcCMcqg1F/uQWq5D4TbGt3qR7KbT53xeZhzzu
	 P3vPOAo7Lj1OsdyYdiVFltirmr8Ndlgl1t0a9QN8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53U5nFHM083316
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Apr 2025 00:49:15 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 00:49:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 00:49:14 -0500
Received: from [10.249.135.124] ([10.249.135.124])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53U5n1e0080805;
	Wed, 30 Apr 2025 00:49:02 -0500
Message-ID: <511ef271-ed0b-40b6-9abc-9fce0081d25b@ti.com>
Date: Wed, 30 Apr 2025 11:18:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: k3-am62p*/k3-j722s: Add bootph-all
 property to enable Ethernet boot
To: Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Roger
 Quadros <rogerq@kernel.org>
References: <20250429072644.2400295-1-c-vankar@ti.com>
 <20250429072644.2400295-3-c-vankar@ti.com>
 <20250429112728.m54x2jwyjykcuus7@unzip>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <20250429112728.m54x2jwyjykcuus7@unzip>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Nishanth,

On 4/29/2025 4:57 PM, Nishanth Menon wrote:
> On 12:56-20250429, Chintan Vankar wrote:
>> Ethernet boot requires CPSW nodes to be present starting from R5 SPL
>> stage. Add bootph-all property to required nodes to enable Ethernet boot
>> for AM62P5-SK and J722S-EVM.
>>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v3:
>> https://lore.kernel.org/r/20250425051055.2393301-3-c-vankar@ti.com/
>>
>> Changes from v3 to v4:
>> - No changes.
>>
>>   arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 +++
> 
> Please notice that we have the same problem[1] here as well.
> 
> [1] https://lore.kernel.org/all/20250425212427.vvyocc4mmne5g3vq@vividly/

I have added "bootph-all" property in the common file of J722S-EVM and 
AM62P5-SK since we are enabling Ethernet boot for both the boards. Are
you referring to move the nodes I have added in
"k3-am62p-j722s-common-main.dtsi" to respective board files,
"k3-am62p5-sk.dts" and "k3-j722s-evm.dts".

Regards,
Chintan.

> 
>>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                | 2 ++
>>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts                | 3 +++
>>   3 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> index 7b65538110e8..11f484f88603 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> @@ -50,6 +50,7 @@ phy_gmii_sel: phy@4044 {
>>   			compatible = "ti,am654-phy-gmii-sel";
>>   			reg = <0x4044 0x8>;
>>   			#phy-cells = <1>;
>> +			bootph-all;
>>   		};
>>   
>>   		epwm_tbclk: clock-controller@4130 {
>> @@ -730,6 +731,7 @@ cpsw_port1: port@1 {
>>   				mac-address = [00 00 00 00 00 00];
>>   				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
>>   				status = "disabled";
>> +				bootph-all;
>>   			};
>>   
>>   			cpsw_port2: port@2 {
>> @@ -751,6 +753,7 @@ cpsw3g_mdio: mdio@f00 {
>>   			clock-names = "fck";
>>   			bus_freq = <1000000>;
>>   			status = "disabled";
>> +			bootph-all;
>>   		};
>>   
>>   		cpts@3d000 {
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> index d29f524600af..5b2f0945a9eb 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
>> @@ -227,6 +227,7 @@ main_mdio1_pins_default: main-mdio1-default-pins {
>>   			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
>>   			AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
>>   		>;
>> +		bootph-all;
>>   	};
>>   
>>   	main_mmc1_pins_default: main-mmc1-default-pins {
>> @@ -496,6 +497,7 @@ &cpsw3g_mdio {
>>   
>>   	cpsw3g_phy0: ethernet-phy@0 {
>>   		reg = <0>;
>> +		bootph-all;
>>   		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>>   		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>>   		ti,min-output-impedance;
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> index 34b9d190800e..93d770c5792e 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> @@ -310,6 +310,7 @@ mdio_pins_default: mdio-default-pins {
>>   			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
>>   			J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
>>   		>;
>> +		bootph-all;
>>   	};
>>   
>>   	ospi0_pins_default: ospi0-default-pins {
>> @@ -344,6 +345,7 @@ J722S_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AF24) RGMII1_TD3 */
>>   			J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
>>   			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
>>   		>;
>> +		bootph-all;
>>   	};
>>   
>>   	main_usb1_pins_default: main-usb1-default-pins {
>> @@ -388,6 +390,7 @@ &cpsw3g_mdio {
>>   
>>   	cpsw3g_phy0: ethernet-phy@0 {
>>   		reg = <0>;
>> +		bootph-all;
>>   		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>>   		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>>   		ti,min-output-impedance;
>> -- 
>> 2.34.1
>>
> 

