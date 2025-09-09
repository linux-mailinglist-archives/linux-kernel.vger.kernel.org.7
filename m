Return-Path: <linux-kernel+bounces-807048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07346B49F47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D473A8620
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405D25393B;
	Tue,  9 Sep 2025 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O8POU6SA"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CED24679E;
	Tue,  9 Sep 2025 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757385409; cv=none; b=bEvfJ70KOaBEx9IEv5+L6glTRX4IXTlxOivgqErYlurtDzkVVRGTH4vJYb/p3SKBPz4MTkbRSwnTc0MC203f/huiup/IrOp9LjA+Z2nZbtAv476UmsT9cHhuo0b5s5wHbdB0HEFX6CCQG2KGV9ih6dw1YoWM3IO0oymghf8XmtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757385409; c=relaxed/simple;
	bh=jlE82jQfUqYdwBurnwKA28lMfrCOG1sHMMx/74aI5pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aNiNXBAR4WOGqhnul+yerB6jKTz2d2ei4czVVkHIY1SGBBtTfmPnKoIwXrDmp60ZZnw0KkGkhJIeN/8I9mYj0oufk8MXqT/B4uBPUYkyrBHaKppChNocOvPD3IzTwG+b1P5Rsl914lpY/8ioPyTkh4kboxQFyTDlJ2xCdjxWmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O8POU6SA; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5892afnJ188204;
	Mon, 8 Sep 2025 21:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757385401;
	bh=Mv00JflGDXvXsqskEHJzyoiH4JiTlBhzjI+w8xYgPnU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=O8POU6SAcDOSeuPQRrVuOjhR4rnQGSQNQysEVoRLNTRFhrjI3XlLWdrEq679w2W3w
	 yMkaFIx//PcK2hkwHJG4kVtzAbXRUX+mi3wk/hCNFhtxZnRiwshYRXG9GugsRM8Nyg
	 UEK3EzwgarZnNI1QNPpQrNSNGXSIzDr0uUHVyjFs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5892afRw3448338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 21:36:41 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 21:36:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 21:36:40 -0500
Received: from [10.24.68.177] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5892aaNW1575986;
	Mon, 8 Sep 2025 21:36:36 -0500
Message-ID: <93acbdf4-5de3-47cd-8633-c4ab6aaa1018@ti.com>
Date: Tue, 9 Sep 2025 08:06:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] arm64: dts: ti: k3-pinctrl: Add the remaining
 macros
To: "Willis, Kendall" <k-willis@ti.com>,
        "Bajjuri, Praneeth"
	<praneeth@ti.com>, "Menon, Nishanth" <nm@ti.com>,
        "Davis, Andrew"
	<afd@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        "Gole, Dhruva"
	<d-gole@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>,
        "Francis, Sebin"
	<sebin.francis@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Mahaveer, Vishal" <vishalm@ti.com>
References: <20250905051448.2836237-1-a-kaur@ti.com>
 <20250905051448.2836237-4-a-kaur@ti.com>
 <a89f9e4f-5306-4943-a70f-f6a60a4537d3@ti.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <a89f9e4f-5306-4943-a70f-f6a60a4537d3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Kendall.

On 09/09/25 05:04, Willis, Kendall wrote:
> On 9/5/25 00:14, Akashdeep Kaur wrote:
>> Add the drive strength, schmitt trigger enable macros to pinctrl file.
>> Add the missing macros for DeepSleep configuration control referenced
>> from "Table 14-6172. Description Of The Pad Configuration Register Bits"
> 
> The Table number should be 14-8769 for the AM62P TRM.

Yes, already updating that.
> 
>> in AM625 TRM[0].
> 
> You should reference both the AM62X and AM62P TRMs because in the AM62P
> TRM the ISO_OVERRIDE_EN bit is reserved, whereas in the AM62X TRM it is
> defined.

That is TRM documentation bug. The functionality is same for both the SoCs
> 
>> Add some DeepSleep macros to provide combinations that can be used
>> directly in device tree files example PIN_DS_OUTPUT_LOW that
>> configures pin to be output and also sets its value to 0.
>>
>> [0] https://www.ti.com/lit/pdf/SPRUJ83
>>
>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
>> ---
>>    arch/arm64/boot/dts/ti/k3-pinctrl.h | 47 ++++++++++++++++++++++++++++-
>>    1 file changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> index c0f09be8d3f9..8ce37ace94c9 100644
>> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
>> @@ -3,15 +3,20 @@
>>     * This header provides constants for pinctrl bindings for TI's K3 SoC
>>     * family.
>>     *
>> - * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
>> + * Copyright (C) 2018-2025 Texas Instruments Incorporated - https://www.ti.com/
>>     */
>>    #ifndef DTS_ARM64_TI_K3_PINCTRL_H
>>    #define DTS_ARM64_TI_K3_PINCTRL_H
>>    
>> +#define WKUP_LVL_EN_SHIFT       (7)
>> +#define WKUP_LVL_POL_SHIFT      (8)
>>    #define ST_EN_SHIFT		(14)
>>    #define PULLUDEN_SHIFT		(16)
>>    #define PULLTYPESEL_SHIFT	(17)
>>    #define RXACTIVE_SHIFT		(18)
>> +#define DRV_STR_SHIFT           (19)
>> +#define ISO_OVERRIDE_EN_SHIFT   (22)
>> +#define ISO_BYPASS_EN_SHIFT     (23)
>>    #define DEBOUNCE_SHIFT		(11)
>>    #define FORCE_DS_EN_SHIFT	(15)
>>    #define DS_EN_SHIFT		(24)
>> @@ -19,6 +24,7 @@
>>    #define DS_OUT_VAL_SHIFT	(26)
>>    #define DS_PULLUD_EN_SHIFT	(27)
>>    #define DS_PULLTYPE_SEL_SHIFT	(28)
>> +#define WKUP_EN_SHIFT           (29)
>>    
>>    /* Schmitt trigger configuration */
>>    #define ST_DISABLE		(0 << ST_EN_SHIFT)
>> @@ -33,6 +39,29 @@
>>    #define INPUT_EN		(1 << RXACTIVE_SHIFT)
>>    #define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
>>    
>> +#define DS_PULL_DISABLE         (1 << DS_PULLUD_EN_SHIFT)
>> +#define DS_PULL_ENABLE          (0 << DS_PULLUD_EN_SHIFT)
> 
> nit: IMO either keep the format of these macros to ENABLE or EN unless
> there is a good reason to change the format.

In the entire file, both _EN and _ENABLE are used. It should be okay. 
Thanks!
> 
>> +
>> +#define DS_PULL_UP              (1 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
>> +#define DS_PULL_DOWN            (0 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
>> +
>> +#define DS_STATE_EN             (1 << DS_EN_SHIFT)
>> +#define DS_STATE_DISABLE        (0 << DS_EN_SHIFT)
> 
> nit: Is there anyway this could be more descriptive? Like
> DS_IO_OVERRIDE_EN or DS_OVERRIDE_CTRL. It is hard to tell what these
> bits do unless you look at the TRM, whereas the other macros are easier
> to deduce their function.
> 
>> +
>> +#define DS_INPUT_EN             (1 << DS_OUT_DIS_SHIFT | DS_STATE_EN)
>> +#define DS_INPUT_DISABLE        (0 << DS_OUT_DIS_SHIFT | DS_STATE_EN)
> 
> By looking at the TRM it looks like this disables or enables output, not
> input. Shifting a 1 to DS_OUT_DIS_SHIFT should disable output.

Yes, shifting to one should disable the output, hence enable the input. 
(A pin can only act as output or input and this bit is used to control that)
> 
>> +
>> +#define DS_OUT_VALUE_ZERO       (0 << DS_OUT_VAL_SHIFT)
>> +#define DS_OUT_VALUE_ONE        (1 << DS_OUT_VAL_SHIFT)
>> +
>> +/* Configuration to enable wake-up on pin activity */
>> +#define WKUP_ENABLE             (1 << WKUP_EN_SHIFT)
>> +#define WKUP_DISABLE            (0 << WKUP_EN_SHIFT)
>> +#define WKUP_ON_LEVEL           (1 << WKUP_LVL_EN_SHIFT)
>> +#define WKUP_ON_EDGE            (0 << WKUP_LVL_EN_SHIFT)
>> +#define WKUP_LEVEL_LOW          (0 << WKUP_LVL_POL_SHIFT)
>> +#define WKUP_LEVEL_HIGH         (1 << WKUP_LVL_POL_SHIFT)
>> +
>>    /* Only these macros are expected be used directly in device tree files */
>>    #define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
>>    #define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
>> @@ -53,6 +82,10 @@
>>    #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
>>    #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
>>    
>> +#define PIN_DRIVE_STRENGTH_NOMINAL      (0 << DRV_STR_SHIFT)
>> +#define PIN_DRIVE_STRENGTH_SLOW         (1 << DRV_STR_SHIFT)
> 
> DRV_STR value of 1 is reserved in both AM62X and AM62P TRMs

This is a common file. We need to define macros that can be used by all 
SoCs.
> 
>> +#define PIN_DRIVE_STRENGTH_FAST         (2 << DRV_STR_SHIFT)
>> +
>>    #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
>>    #define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
>>    #define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
>> @@ -65,6 +98,18 @@
>>    #define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
>>    #define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
>>    #define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
>> +#define PIN_DS_ISO_BYPASS               (1 << ISO_BYPASS_EN_SHIFT)
>> +#define PIN_DS_ISO_BYPASS_DISABLE       (0 << ISO_BYPASS_EN_SHIFT)
>> +
>> +#define PIN_DS_OUTPUT_LOW               (DS_INPUT_DISABLE | DS_OUT_VALUE_ZERO)
>> +#define PIN_DS_OUTPUT_HIGH              (DS_INPUT_DISABLE | DS_OUT_VALUE_ONE)
>> +#define PIN_DS_INPUT                    (DS_INPUT_EN | DS_PULL_DISABLE)
>> +#define PIN_DS_INPUT_PULLUP             (DS_INPUT_EN | DS_PULL_UP)
>> +#define PIN_DS_INPUT_PULLDOWN           (DS_INPUT_EN | DS_PULL_DOWN)
>> +
>> +#define PIN_WKUP_EN_LEVEL_LOW           (WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_LOW)
>> +#define PIN_WKUP_EN_LEVEL_HIGH          (WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_HIGH)
>> +#define PIN_WKUP_EN                     (WKUP_ENABLE | WKUP_ON_EDGE)
>>    
>>    /* Default mux configuration for gpio-ranges to use with pinctrl */
>>    #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
> 
> Best,
> Kendall
> 
Regards,
Akashdeep Kaur


