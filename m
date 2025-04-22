Return-Path: <linux-kernel+bounces-613463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07BA95CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 06:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270EE3A4187
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 04:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2142E19FA93;
	Tue, 22 Apr 2025 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="Gic08PWZ"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E8A196;
	Tue, 22 Apr 2025 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745295553; cv=pass; b=owkjZPPjzFPOm8uvTqjmC2lkMff/vD8tEanChUQFl4lza0wo4oqtgrBMM60IBMqiYNUtAh7RVJe9/PmOWuqd2rnEbAvaf7tImPrwRfEHjwVZKFlS3Q5dF4DSaaMRsCtOF7jiWAaKSex27F2/3gsqU1STdnTyqMCXh3Pm/6JF9MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745295553; c=relaxed/simple;
	bh=iNsKMm84GHQhbUytpMjyMh6LwwOS6U2zFWLDvpU9Cmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=me/x8lyUbAqbbOH8rnHS/qvibmjVgeJp81AGOlfEA2WZm1wDYG9m7eUCm6+h62NXiPAwZoQ9BjRcwZox++MUoJhFcsDIO9+EyMtxrAOVOBQp1P+nr5nOro2oUFpVAqY+Rrgq8GSwZ/zyIJ8ZZPDL1y27PlNmp/vPKqIvFPcoGSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=Gic08PWZ; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1745295527; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bYShoK2I5627kuvCMBr7ice5zoZvmVLXZxqiboxIqDwF0rBOTWN+rIFKUegsdEjNoYjjC32ZOZzzzkUFjOdCeD3NIYMJHOMkOs4tcfcxVdpHJV5mv0y9taQ7g9d344fb3U/yCegeLMCrThiBuqFu7VuZKk6nUHnMjxb8Lyv62Ms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745295527; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iNsKMm84GHQhbUytpMjyMh6LwwOS6U2zFWLDvpU9Cmg=; 
	b=hSzjbzbDUhiVei7Eec+5YrhPzASfsG8bj5oGQVlO4MqcG7oUuY1P5VWV90eKWHFvt88ZH9uH8WcjHS6IaYXB3v4O80I46oA1r7lyE05VipcpGi+t4owgoraKk5zSDlhjsBd0GwC/MuwRDmfjqvR8OoCsD1ON4eCDAl6s2bYcG2U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745295527;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=iNsKMm84GHQhbUytpMjyMh6LwwOS6U2zFWLDvpU9Cmg=;
	b=Gic08PWZfyL08Tbqw5qQYDmVI4RM1Os2KsH5V5FLKN8HENRrA+tv8edW7Ws+DGuH
	Mf6xpKRORMb1usri4f3BOofaekUuQVqU2hb+y3MZzykrLgAf73LsW0m7Xt4/pwfV5Nm
	RswSu3lHtv3YSZcNxq4OUzFxAwO1RWuFjGH6PsSQ=
Received: by mx.zohomail.com with SMTPS id 17452955185091.4976603090620983;
	Mon, 21 Apr 2025 21:18:38 -0700 (PDT)
Message-ID: <b858e1a3-7bad-4e23-bd95-d409a29195ad@zohomail.com>
Date: Tue, 22 Apr 2025 12:18:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dt-bindings: clock: Add bindings for Canaan K230
 clock controller
To: Chen Wang <unicorn_wang@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250415-b4-k230-clk-v6-0-7fd89f427250@zohomail.com>
 <20250415-b4-k230-clk-v6-1-7fd89f427250@zohomail.com>
 <MA0P287MB22621E1EC7F030E093C05084FEB82@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <MA0P287MB22621E1EC7F030E093C05084FEB82@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112272a13f94d3fc8e81c0fa6ae23000020fdad24f314990c2fb2150b564169e8b45e6e758e036a8a80:zu080112278c70b1c3fda24dcf3c14c9b50000bc403e68ad6228418b8c8f41b6e9f42e34dd877b267001d8fc:rf0801122ccc9d7616e07c63669e52d081000092f1083db6b64a211b5e15228f345040d987203771a4404cca7708396413:ZohoMail
X-ZohoMailClient: External


On 2025/4/21 18:47, Chen Wang wrote:
>
> On 2025/4/15 22:25, Xukai Wang wrote:
>> This patch adds the Device Tree binding for the clock controller
>> on Canaan k230. The binding defines the new clocks available and
>> the required properties to configure them correctly.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
>> ---
>>   .../devicetree/bindings/clock/canaan,k230-clk.yaml | 43 ++++++++++++++
>>   include/dt-bindings/clock/canaan,k230-clk.h        | 69
>> ++++++++++++++++++++++
>>   2 files changed, 112 insertions(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
>> b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
>> new file mode 100644
>> index
>> 0000000000000000000000000000000000000000..d7220fa30e4699a68fa5279c04abc63c1905fa4a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/canaan,k230-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Canaan Kendryte K230 Clock
>> +
>> +maintainers:
>> +  - Xukai Wang <kingxukai@zohomail.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: canaan,k230-clk
>> +
>> +  reg:
>> +    items:
>> +      - description: PLL control registers.
>> +      - description: Sysclk control registers.
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clock-controller@91102000 {
>> +        compatible = "canaan,k230-clk";
>> +        reg = <0x91102000 0x1000>,
>
> Note that when actually writing DTS, the PLL-related register range is
> not so large (0x1000). Otherwise, the BOOT-related registers may be
> overwritten.
>
I get the point. Although I won't modify other registers unrelated to
PLL, I will still refine the mapped areas(0x40 size).
>
>> +              <0x91100000 0x1000>;
>> +        clocks = <&osc24m>;
>> +        #clock-cells = <1>;
>> +    };
>> diff --git a/include/dt-bindings/clock/canaan,k230-clk.h
>> b/include/dt-bindings/clock/canaan,k230-clk.h
>> new file mode 100644
>> index
>> 0000000000000000000000000000000000000000..41edb13ea04bffaa1ddd1d1af87ae3406b688332
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/canaan,k230-clk.h
>> @@ -0,0 +1,69 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Kendryte Canaan K230 Clock Drivers
>> + *
>> + * Author: Xukai Wang <kingxukai@zohomail.com>
>> + */
>> +
>> +#ifndef CLOCK_K230_CLK_H
>> +#define CLOCK_K230_CLK_H
>> +
>> +/* Kendryte K230 SoC clock identifiers (arbitrary values). */
>> +#define K230_CPU0_SRC            0
>> +#define K230_CPU0_ACLK            1
>> +#define K230_CPU0_PLIC            2
>> +#define K230_CPU0_NOC_DDRCP4        3
>> +#define K230_CPU0_PCLK            4
>> +#define K230_PMU_PCLK            5
>> +#define K230_HS_HCLK_HIGH_SRC        6
>> +#define K230_HS_HCLK_HIGH_GATE        7
>> +#define K230_HS_HCLK_SRC        8
>> +#define K230_HS_SD0_HS_AHB_GAT        9
>> +#define K230_HS_SD1_HS_AHB_GAT        10
>> +#define K230_HS_SSI1_HS_AHB_GA        11
>> +#define K230_HS_SSI2_HS_AHB_GA        12
>> +#define K230_HS_USB0_HS_AHB_GA        13
>> +#define K230_HS_USB1_HS_AHB_GA        14
>> +#define K230_HS_SSI0_AXI15        15
>> +#define K230_HS_SSI1            16
>> +#define K230_HS_SSI2            17
>> +#define K230_HS_QSPI_AXI_SRC        18
>> +#define K230_HS_SSI1_ACLK_GATE        19
>> +#define K230_HS_SSI2_ACLK_GATE        20
>> +#define K230_HS_SD_CARD_SRC        21
>> +#define K230_HS_SD0_CARD_TX        22
>> +#define K230_HS_SD1_CARD_TX        23
>> +#define K230_HS_SD_AXI_SRC        24
>> +#define K230_HS_SD0_AXI_GATE        25
>> +#define K230_HS_SD1_AXI_GATE        26
>> +#define K230_HS_SD0_BASE_GATE        27
>> +#define K230_HS_SD1_BASE_GATE        28
>> +#define K230_HS_OSPI_SRC        29
>> +#define K230_HS_USB_REF_50M        30
>> +#define K230_HS_SD_TIMER_SRC        31
>> +#define K230_HS_SD0_TIMER_GATE        32
>> +#define K230_HS_SD1_TIMER_GATE        33
>> +#define K230_HS_USB0_REFERENCE        34
>> +#define K230_HS_USB1_REFERENCE        35
>> +#define K230_LS_APB_SRC            36
>> +#define K230_LS_UART0_APB        37
>> +#define K230_LS_UART1_APB        38
>> +#define K230_LS_UART2_APB        39
>> +#define K230_LS_UART3_APB        40
>> +#define K230_LS_UART4_APB        41
>> +#define K230_LS_I2C0_APB        42
>> +#define K230_LS_I2C1_APB        43
>> +#define K230_LS_I2C2_APB        44
>> +#define K230_LS_I2C3_APB        45
>> +#define K230_LS_GPIO_APB        46
>> +#define K230_LS_PWM_APB            47
>> +#define K230_LS_UART0            48
>> +#define K230_LS_UART1            49
>> +#define K230_LS_UART2            50
>> +#define K230_LS_UART3            51
>> +#define K230_LS_UART4            52
>> +#define K230_SHRM_AXI_SRC        53
>> +#define K230_SHRM_SDMA_AXI_GATE        54
>> +#define K230_SHRM_PDMA_AXI_GATE        55
>> +
>
> It seems that some clks are missing, such as the timer-related clocks.
> Please try to fill them in. There is no need to submit another patch
> for this.
OK, I'll complete the rest clock next version.
>
> Thanks,
>
> Chen
>
>> +#endif /* CLOCK_K230_CLK_H */
>>

