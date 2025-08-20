Return-Path: <linux-kernel+bounces-776901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9660B2D2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49203B216D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB61FF7BC;
	Wed, 20 Aug 2025 03:49:19 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1935336A;
	Wed, 20 Aug 2025 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755661759; cv=none; b=nN9AjXysq5c65xmw6x/82SbNoIgh+ArcFek2EaJvndLpAWoV/MSec/uTBN2UH9tr/OuExlcSw/DcEUtlaY7FlDLeD9/d4pJzHxW+Sf6zldt2gU3/IhS4UH+tAMXmKd1+GGT9w+wNwdOAsPAcVp+rT5IC/gvN5E8bIQaMUDRIUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755661759; c=relaxed/simple;
	bh=+eKUrudFVkf/oZRz1/hMMJRiLT/RFDdwQFZeLZaOkfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQFiw4oQHmBblegJpfDj0MwTtGAl2YSPttnZLk6enL6CG7bx4y9lqlDD0HjXwvVNB7foUOhtrF1PyfGAOYhB7+C4FJ0pV6cfLtiMlx3BIKXcHJBc2Nqezte9Ma7uO5FsEef1Amal8mepHRPiuHHBAOg/BJ2i2Lxn56tPOXIS+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.63.12])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id C3467B4E0015;
	Wed, 20 Aug 2025 05:49:05 +0200 (CEST)
Message-ID: <4b516172-bd75-432a-9c96-f02fbfb68c16@freeshell.de>
Date: Tue, 19 Aug 2025 20:49:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: jh7110: bootph-pre-ram
 hinting needed by boot loader
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20250815073739.79241-1-e@freeshell.de>
 <20250815073739.79241-4-e@freeshell.de>
 <ZQ2PR01MB1307CE398A5993B9E5B93357E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB1307CE398A5993B9E5B93357E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/17/25 23:05, Hal Feng wrote:
>> On 15.08.25 15:37, E Shattow wrote:
>> Add bootph-pre-ram hinting to jh7110.dtsi:
>>   - CPU interrupt controller(s)
>>   - core local interrupt timer
>>   - DDR memory controller
>>   - oscillator
>>   - syscrg clock-controller
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index 14df3d062a45..884a3526cb0f 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -35,6 +35,7 @@ S7_0: cpu@0 {
>>
>>  			cpu0_intc: interrupt-controller {
>>  				compatible = "riscv,cpu-intc";
>> +				bootph-pre-ram;
>>  				interrupt-controller;
>>  				#interrupt-cells = <1>;
>>  			};
>> @@ -68,6 +69,7 @@ U74_1: cpu@1 {
>>
>>  			cpu1_intc: interrupt-controller {
>>  				compatible = "riscv,cpu-intc";
>> +				bootph-pre-ram;
>>  				interrupt-controller;
>>  				#interrupt-cells = <1>;
>>  			};
>> @@ -101,6 +103,7 @@ U74_2: cpu@2 {
>>
>>  			cpu2_intc: interrupt-controller {
>>  				compatible = "riscv,cpu-intc";
>> +				bootph-pre-ram;
>>  				interrupt-controller;
>>  				#interrupt-cells = <1>;
>>  			};
>> @@ -134,6 +137,7 @@ U74_3: cpu@3 {
>>
>>  			cpu3_intc: interrupt-controller {
>>  				compatible = "riscv,cpu-intc";
>> +				bootph-pre-ram;
>>  				interrupt-controller;
>>  				#interrupt-cells = <1>;
>>  			};
>> @@ -167,6 +171,7 @@ U74_4: cpu@4 {
>>
>>  			cpu4_intc: interrupt-controller {
>>  				compatible = "riscv,cpu-intc";
>> +				bootph-pre-ram;
>>  				interrupt-controller;
>>  				#interrupt-cells = <1>;
>>  			};
>> @@ -321,6 +326,7 @@ mclk_ext: mclk-ext-clock {
>>
>>  	osc: oscillator {
>>  		compatible = "fixed-clock";
>> +		bootph-pre-ram;
>>  		clock-output-names = "osc";
>>  		#clock-cells = <0>;
>>  	};
>> @@ -354,6 +360,7 @@ soc {
>>  		clint: timer@2000000 {
>>  			compatible = "starfive,jh7110-clint", "sifive,clint0";
>>  			reg = <0x0 0x2000000 0x0 0x10000>;
>> +			bootph-pre-ram;
>>  			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc
>> 7>,
>>  					      <&cpu1_intc 3>, <&cpu1_intc 7>,
>>  					      <&cpu2_intc 3>, <&cpu2_intc 7>,
>> @@ -376,6 +383,7 @@ memory-controller@15700000 {
>>  			compatible = "starfive,jh7110-dmc";
>>  			reg = <0x0 0x15700000 0x0 0x10000>,
>>  			      <0x0 0x13000000 0x0 0x10000>;
>> +			bootph-pre-ram;
>>  			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
>>  			clock-names = "pll1_out";
>>  			resets = <&syscrg JH7110_SYSRST_DDR_AXI>, @@ -
>> 892,6 +900,7 @@ qspi: spi@13010000 {
>>  		syscrg: clock-controller@13020000 {
>>  			compatible = "starfive,jh7110-syscrg";
>>  			reg = <0x0 0x13020000 0x0 0x10000>;
>> +			bootph-pre-ram;
>>  			clocks = <&osc>, <&gmac1_rmii_refin>,
>>  				 <&gmac1_rgmii_rxin>,
>>  				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> 
> pllclk also needs to add bootph-pre-ram. Because it is the dependency of syscrg.
> 
> 		pllclk: clock-controller {
> 			compatible = "starfive,jh7110-pll";
> +			bootph-pre-ram;
> 			clocks = <&osc>;
> 			#clock-cells = <1>;
> 		};
> 
> Best regards,
> Hal

What users are there for 'pllclk' at U-Boot SPL phase? There does not
seem to be any difference in testing U-Boot and Linux with or without
this hint for 'pllclk'.

Thanks,

-E

