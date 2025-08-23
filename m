Return-Path: <linux-kernel+bounces-782906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932B9B326AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AD21B65852
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9181EA7E4;
	Sat, 23 Aug 2025 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X67+4EU8"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F0A2AD22;
	Sat, 23 Aug 2025 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755920021; cv=none; b=diZANRJyW0XuYMPdb07UR9u/1pek4pixvmqCrLG1xefcNUVjE2BMMDpYZZ0padSW8A7CHSIQEnzQmBQLQ3Kiw4/r9yw9ijnXrwgSY4K1nwlVc/zniFecX5lbz2NvdWrZiu0zMfWIG5gyVAPl0i98lytJP7ThPM3cdhteXs2P5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755920021; c=relaxed/simple;
	bh=dBPGReUVf9VonxjZhenmepSNsjfZcEAnm/Doa/3qaCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dndGE3CjQ7kAfUFwi7gWAWxNLDt3BKEf1HOVI8ExRGn8Ja13RhY4Sa/gDMFA9D7ROVs+J9pBmucRj1H+nXFVBmcpz7o5/yun3stnVl4htB/GMJqjMkUkfISF2bXzzdA9FuaAj10bhkbTfigj3NmTppHlTbO+OxQ10HcfU3NzK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X67+4EU8; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57N3XXWM382086;
	Fri, 22 Aug 2025 22:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755920013;
	bh=MAbR85jPoEBfcAfwGqydIjXGtEuyd1IOgfjERJQho/A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=X67+4EU8QEZkCmTkJ6gzhO55lKFoacGOf14V5Up/bLnhIp3Fp70p28DuR2WXaPLhP
	 v8yEaxYFD84pxlwuLoTsA7fRqX92Xvu6ZmKGqIlERQwZGBQ4FbifFjzBPYb8PX/O+V
	 5Y/ZXN1TBwXrCkZXMefsFzPOlns4dB2nMr/U2qvI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57N3XXLM4072191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 22:33:33 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 22:33:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 22:33:33 -0500
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57N3XSQ5585095;
	Fri, 22 Aug 2025 22:33:29 -0500
Message-ID: <f207b2e9-a910-40f3-a01e-1af33c7f4e6f@ti.com>
Date: Sat, 23 Aug 2025 09:03:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62d2-evm: Add support for OSPI flash
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <s-k6@ti.com>
References: <20250813090300.733295-1-p-bhagat@ti.com>
 <20250822183014.apyvqws4afiqiymb@specks>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <20250822183014.apyvqws4afiqiymb@specks>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Nishanth,


On 23/08/25 00:00, Nishanth Menon wrote:
> On 14:33-20250813, Paresh Bhagat wrote:
>> AM62D2 EVM has S28HS512T 64 MiB Octal SPI NOR flash connected to the
>> OSPI interface. Add support for the flash and describe the partition
>> information as per bootloader.
>>
>> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
>> ---
>> Boot logs
>> https://gist.github.com/paresh-bhagat12/262d8c64e692d22c4e48363d246fb083
> We already have issues with am62d that needs fixing:
> cpu cpu0: _of_add_opp_table_v2: no supported OPPs
> cpu cpu0: OPP table can't be empty
>
> and
>
> Please enable defconfig for this device
> arch/arm64/boot/dts/ti/k3-am62d2-evm.dts:       typec_pd0: usb-power-controller@3f {
>
> We can look at adding features for am62d after the above are done.


The above fixes are now posted in upstream.

Thanks
>> Tech Ref Manual-https://www.ti.com/lit/pdf/sprujd4
>> Schematics Link-https://www.ti.com/lit/zip/sprcal5
>>
>>   arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 86 ++++++++++++++++++++++++
>>   1 file changed, 86 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
>> index daea18b0bc61..aa943ef52fb5 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
>> @@ -25,6 +25,7 @@ aliases {
>>   		rtc0 = &wkup_rtc0;
>>   		ethernet0 = &cpsw_port1;
>>   		ethernet1 = &cpsw_port2;
>> +		spi0 = &ospi0;
>>   	};
>>   
>>   	chosen {
>> @@ -367,6 +368,26 @@ usr_led_pins_default: usr-led-default-pins {
>>   			AM62DX_IOPAD(0x0244, PIN_INPUT, 7) /* (D18) MMC1_SDWP.GPIO1_49 */
>>   		>;
>>   	};
>> +
>> +	ospi0_pins_default: ospi0-default-pins {
>> +		pinctrl-single,pins = <
>> +			AM62DX_IOPAD(0x0000, PIN_OUTPUT, 0) /* (L22) OSPI0_CLK */
>> +			AM62DX_IOPAD(0x002c, PIN_OUTPUT, 0) /* (H21) OSPI0_CSn0 */
>> +			AM62DX_IOPAD(0x0030, PIN_OUTPUT, 0) /* (G19) OSPI0_CSn1 */
>> +			AM62DX_IOPAD(0x0034, PIN_OUTPUT, 0) /* (K20) OSPI0_CSn2 */
>> +			AM62DX_IOPAD(0x0038, PIN_OUTPUT, 0) /* (G20) OSPI0_CSn3 */
>> +			AM62DX_IOPAD(0x000c, PIN_INPUT, 0) /* (J21) OSPI0_D0 */
>> +			AM62DX_IOPAD(0x0010, PIN_INPUT, 0) /* (J18) OSPI0_D1 */
>> +			AM62DX_IOPAD(0x0014, PIN_INPUT, 0) /* (J19) OSPI0_D2 */
>> +			AM62DX_IOPAD(0x0018, PIN_INPUT, 0) /* (H18) OSPI0_D3 */
>> +			AM62DX_IOPAD(0x001c, PIN_INPUT, 0) /* (K21) OSPI0_D4 */
>> +			AM62DX_IOPAD(0x0020, PIN_INPUT, 0) /* (H19) OSPI0_D5 */
>> +			AM62DX_IOPAD(0x0024, PIN_INPUT, 0) /* (J20) OSPI0_D6 */
>> +			AM62DX_IOPAD(0x0028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
>> +			AM62DX_IOPAD(0x0008, PIN_INPUT, 0) /* (L21) OSPI0_DQS */
>> +		>;
>> +		bootph-all;
>> +	};
>>   };
>>   
>>   &mcu_gpio0 {
>> @@ -613,3 +634,68 @@ &c7x_0 {
>>   &main_rti4 {
>>   	status = "reserved";
>>   };
>> +
>> +&fss {
>> +	status = "okay";
>> +};
>> +
>> +&ospi0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&ospi0_pins_default>;
>> +	status = "okay";
>> +
>> +	flash@0{
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0x0>;
>> +		spi-tx-bus-width = <8>;
>> +		spi-rx-bus-width = <8>;
>> +		spi-max-frequency = <25000000>;
>> +		cdns,tshsl-ns = <60>;
>> +		cdns,tsd2d-ns = <60>;
>> +		cdns,tchsh-ns = <60>;
>> +		cdns,tslch-ns = <60>;
>> +		cdns,read-delay = <4>;
>> +
>> +		partitions {
>> +			compatible = "fixed-partitions";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			partition@0 {
>> +				label = "ospi.tiboot3";
>> +				reg = <0x0 0x80000>;
>> +			};
>> +
>> +			partition@80000 {
>> +				label = "ospi.tispl";
>> +				reg = <0x80000 0x200000>;
>> +			};
>> +
>> +			partition@280000 {
>> +				label = "ospi.u-boot";
>> +				reg = <0x280000 0x400000>;
>> +			};
>> +
>> +			partition@680000 {
>> +				label = "ospi.env";
>> +				reg = <0x680000 0x40000>;
>> +			};
>> +
>> +			partition@6c0000 {
>> +				label = "ospi.env.backup";
>> +				reg = <0x6c0000 0x40000>;
>> +			};
>> +
>> +			partition@800000 {
>> +				label = "ospi.rootfs";
>> +				reg = <0x800000 0x37c0000>;
>> +			};
>> +
>> +			partition@3fc0000 {
>> +				label = "ospi.phypattern";
>> +				reg = <0x3fc0000 0x40000>;
>> +				bootph-all;
>> +			};
>> +		};
>> +	};
>> +};
>> -- 
>> 2.34.1
>>
>>

