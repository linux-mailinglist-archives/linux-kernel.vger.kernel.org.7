Return-Path: <linux-kernel+bounces-793590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62EB3D5A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD003BBBC2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5924290D;
	Sun, 31 Aug 2025 22:46:37 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37879CD;
	Sun, 31 Aug 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756680396; cv=none; b=MzH13M8lyVgp0q40BLudsIOCFGE3bErxiI0cte+nROCFlUrl5Clk1AOHYmcoCAifWnc9HEGIGqBd+6PEU6/qaExPIB0yzjIDbbiuZ5eIVyBMi9CCwaX7cBo9LUDx3YYfn4oGjibhRdgea7b3qISqJFOrtYl7tY9jq8KHARYsmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756680396; c=relaxed/simple;
	bh=B+QONtLKbWoUSZnzuXBxJPZMyjhwY9s6vLIk+omz+1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWooymzpgaJQ06Jk5ImxxrTXoWqQWKNYwXCK69+svSLAn3g1aaLw8MO3Secl56wQc2b1Dy5/G0yyjTmU/4Z4bw6WbFet2jB9qa5uBqBPfN7gw+V6fs75enZmLHaJW7xUiMBOMVgGDntC9ib/8nG11oP5JGEMh0SssupfgX/vs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 6F16FB2200E7;
	Mon,  1 Sep 2025 00:46:28 +0200 (CEST)
Message-ID: <036589cf-3e78-42ea-9876-2a01acdbb598@freeshell.de>
Date: Sun, 31 Aug 2025 15:46:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] riscv: dts: starfive: add Milk-V Mars CM Lite
 system-on-module
To: Hal Feng <hal.feng@linux.starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250724094912.253723-1-e@freeshell.de>
 <20250724094912.253723-5-e@freeshell.de>
 <257702B5AE6EE65A+20bf1aab-7fa4-45ba-a8ae-d3aeb5f6e9d9@linux.starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <257702B5AE6EE65A+20bf1aab-7fa4-45ba-a8ae-d3aeb5f6e9d9@linux.starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 19:40, Hal Feng wrote:
> On 7/24/2025 5:48 PM, E Shattow wrote:
>> Milk-V Mars CM Lite is a System-on-Module based on the Milk-V Mars CM
>> without the onboard eMMC storage component populated and configured
>> instead for SD3.0 Card Slot on that interface via 100-pin connector.
>>
>> Link to Milk-V Mars CM Lite schematics: https://github.com/milkv-mars/mars-files/tree/main/Mars-CM_Hardware_Schematices
>> Link to StarFive JH7110 Technical Reference Manual: https://doc-en.rvspace.org/JH7110/TRM/index.html
>> Link to Raspberry Pi CM4IO datasheet: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf
>>
>> Add the devicetree file to make use of StarFive JH7110 common supported
>> features PMIC, EEPROM, UART, I2C, GPIO, PCIe, QSPI Flash, PWM, and
>> Ethernet. Also configure the eMMC interface mmc0 for SD Card use and
>> configure the common SD Card interface mmc1 for onboard SDIO BT+WiFi.
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
>>  .../dts/starfive/jh7110-milkv-marscm-lite.dts | 176 ++++++++++++++++++
>>  2 files changed, 177 insertions(+)
>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
>>
>> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
>> index 79742617ddab..62b659f89ba7 100644
>> --- a/arch/riscv/boot/dts/starfive/Makefile
>> +++ b/arch/riscv/boot/dts/starfive/Makefile
>> @@ -11,6 +11,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
>> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-lite.dtb
>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
>>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
>> new file mode 100644
>> index 000000000000..e110146f0b76
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
>> @@ -0,0 +1,176 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2025 E Shattow <e@freeshell.de>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include "jh7110-common.dtsi"
> 
> You can just include "jh7110-milkv-marscm-emmc.dts" instead of "jh7110-common.dtsi".
> And then adding mmc0 changes will be enough.
> 
> Best regards,
> Hal
> 
> ...
> 
>> +&mmc0 {
>> +	bus-width = <4>;
>> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
>> +};
>> +
>> +&mmc0_pins {
>> +	pwren-pins {
>> +		pinmux = <GPIOMUX(22, GPOUT_HIGH,
>> +				      GPOEN_ENABLE,
>> +				      GPI_NONE)>;
>> +	};
>> +};
>> +
> ...
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Okay. I will refactor the series to create and use
"jh7110-milkv-marscm.dtsi" common board include.

-E

