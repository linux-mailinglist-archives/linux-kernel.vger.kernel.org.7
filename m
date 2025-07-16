Return-Path: <linux-kernel+bounces-734003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C12B07BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32CD1690D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FD82F5499;
	Wed, 16 Jul 2025 17:14:24 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E91991BF;
	Wed, 16 Jul 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686064; cv=none; b=D1GwvZ6hiqjKRfZ9pZsTayrfOZ35AWUyUWufda8HxxtqqLgboZ0Lte8feAdzIMv/DfBfuFHc7MlYDwu7zyMQzdXvjf2qk4iQbB07S15rxxSBTHyj13CMUJPuNPsR/8ASQWId4tXqsv5Ywyw6I1171z1cbK+gwbjUG/kgWB5qbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686064; c=relaxed/simple;
	bh=/VcBE64VXzyxiWWxl+j7H8EM2iLninanhQq03YO6Erk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofx3pLuutmL6AVD7ztSqvSy1kBzcmJ89Rbk2sT6Wh2d4wL/DlRXk4XMQrd1ejjqbzc+95L8De8bf4Yl6P89Vv/cyaMI8kIwvgpExoTa9Dkj+/RwIUVqtMKy3KLM4YKP8pW368HTUDR6XoM5UD8cPNMkC9kfoDgeuClS1w76Oh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [143.105.119.108])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 11B43B4D0D04;
	Wed, 16 Jul 2025 19:14:14 +0200 (CEST)
Message-ID: <ff4021dd-69bc-45ae-a3d0-7f15be194717@freeshell.de>
Date: Wed, 16 Jul 2025 10:14:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: add status power led
 node
To: Conor Dooley <conor@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716040500.178287-1-e@freeshell.de>
 <20250716-wind-slum-99dd6ea87f63@spud>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250716-wind-slum-99dd6ea87f63@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 08:28, Conor Dooley wrote:
> On Tue, Jul 15, 2025 at 09:04:54PM -0700, E Shattow wrote:
>> Add status power led node for StarFive VisionFive2 and variant boards.
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
> 
> Again, I'll grab this too but it may be too late for 6.17.
> 
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> index 4baeb981d4df..2eaf01775ef5 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> @@ -8,6 +8,7 @@
>>  #include "jh7110.dtsi"
>>  #include "jh7110-pinfunc.h"
>>  #include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/leds/common.h>
>>  #include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
>>  
>>  / {
>> @@ -38,6 +39,14 @@ gpio-restart {
>>  		priority = <224>;
>>  	};
>>  
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		led_status_power: led-0 {
>> +			gpios = <&aongpio 3 GPIO_ACTIVE_HIGH>;
>> +		};
>> +	};
>> +
>>  	pwmdac_codec: audio-codec {
>>  		compatible = "linux,spdif-dit";
>>  		#sound-dai-cells = <0>;
>>
>> base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
>> -- 
>> 2.50.0
>>

Ok sounds good to me. This is common on all JH7110 boards, but am not
sure if it is connected to anything on DeepComputing Framework 13 V01.

LED color varies yet there is an LED connected this way on variants I
could find a published schematic for:
- Milk-V Mars
- Pine64 Star64
- StarFive VisionFive2 1.2a
- StarFive VisionFive2 1.3b

Discussion about the OrangePi RV dts shows this to have the same
connection to an LED. I am putting together patches for adding Milk-V
Mars CM and Milk-V Mars CM Lite, tested successfully and listed on
schematics as well. Some early revision developer sample board
schematics for some of the above do not list RGPIO3 so assumed n/c and
no problem there.

If anyone out there can link to the FML13V01 schematic or confirm this
change does not break for users I'd appreciate that, for any follow-up
that might be needed per-board.

-E

