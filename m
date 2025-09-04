Return-Path: <linux-kernel+bounces-800328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93050B43658
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457867B6293
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6C42D1916;
	Thu,  4 Sep 2025 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JZxGE2UB"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630D24167F;
	Thu,  4 Sep 2025 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976259; cv=none; b=hB0ry7I2zscdWWmEM8vixLlEHDicB+tYxm05eCDcu2f2Mz/RRGR4PuMktgS7sqjt+sqHgp5mCvtKj3+gOVVMU7t7J2VP5PfzrtFFTnuzjKS0R1KCLXgQ6kNUnzk+QyGuH+KYW/ByHuazjUjcbxNT408yLHqI9DhMF+QdqLu6xCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976259; c=relaxed/simple;
	bh=ef0an2s0RMq35BHmE3vLeCCXeXHzfb8w06p6vIy8qfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CGAoP9PAjvzsdbrf9x/z9iroN9NL9iGO6Ehk46E+bBTf3rkyn5dWxIM46IhdLkzMAijYyUAWiI0TnMCTParsM6JSNlsJyU67b2kepnhTgGCHQ1ZYJ96k/kE1rRiJMuQ6zObrwmCn+TSmtEfOj8amAN1Bz/x/frqisVUjDqN0/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JZxGE2UB; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5848vKau3472912;
	Thu, 4 Sep 2025 03:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756976240;
	bh=uF4m/pRRU4rgRt7tXnCtpn8VYgPl9axTqJo4BB655os=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JZxGE2UBN40dWWYuDmfX2FMeRszsL4a7bvGt7TEhMXmCCHwYjN8WkLUZC0Nl8do7C
	 vkSvHNg5bkVnCHd/DMKtwrMrLFq3xXWEnWD+Emu44QX7Cro4DUhm7eNrSVVNFg8K3m
	 GOzORqTCUFmXIrpiXg1HAODHPx4WgDrzpblcQdt0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5848vKSn749886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 03:57:20 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 03:57:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 03:57:20 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5848vFWj3006227;
	Thu, 4 Sep 2025 03:57:15 -0500
Message-ID: <b946af38-abf9-4b34-bf44-3ba9bc64bff7@ti.com>
Date: Thu, 4 Sep 2025 14:27:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining
 macros
To: Akashdeep Kaur <a-kaur@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <vigneshr@ti.com>, <d-gole@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>
References: <20250902071917.1616729-1-a-kaur@ti.com>
 <20250902071917.1616729-4-a-kaur@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250902071917.1616729-4-a-kaur@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Akashdeep,

On 9/2/2025 12:49 PM, Akashdeep Kaur wrote:
> Add the drive stregth, schmitt trigger enable macros to pinctrl file.
> Add the missing macros for DeepSleep configuration control referenced
> from "Table 14-6172. Description Of The Pad Configuration Register Bits"
> in AM625 TRM[0].
> Add some DeepSleep macros to provide combinations that can be used
> directly in device tree files example PIN_DS_OUTPUT_LOW that
> configures pin to be output and also sets its value to 0.
>
> [0] https://www.ti.com/lit/ug/spruiv7b/spruiv7b.pdf
>
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-pinctrl.h | 55 +++++++++++++++++++++++++++--
>   1 file changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index c0f09be8d3f9..39aad59075d1 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -3,15 +3,20 @@
>    * This header provides constants for pinctrl bindings for TI's K3 SoC
>    * family.
>    *
> - * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2018-2025 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   #ifndef DTS_ARM64_TI_K3_PINCTRL_H
>   #define DTS_ARM64_TI_K3_PINCTRL_H
>   
> +#define WKUP_LVL_EN_SHIFT       (7)
> +#define WKUP_LVL_POL_SHIFT      (8)
>   #define ST_EN_SHIFT		(14)
>   #define PULLUDEN_SHIFT		(16)
>   #define PULLTYPESEL_SHIFT	(17)
>   #define RXACTIVE_SHIFT		(18)
> +#define DRV_STR_SHIFT           (19)

referring to above TRM mentioned in commit message

Bit 20-19 are for DRV_STR, and description says

0 - Default
1 - Reserved
2 - Reserved
3 - Reserved

Not sure, is there some additional document to be referred for 
PIN_DRIVE_STRENGTH


> +#define DS_ISO_OVERRIDE_SHIFT   (22)
> +#define DS_ISO_BYPASS_EN_SHIFT  (23)

Please follow same convention as for rest of bit fields

DS_ISO_OVERRIDE_SHIFT  to ISO_OVR_SHIFT and
DS_ISO_BYPASS_EN_SHIFT to ISO_BYP_SHIFT



>   #define DEBOUNCE_SHIFT		(11)
>   #define FORCE_DS_EN_SHIFT	(15)
>   #define DS_EN_SHIFT		(24)
> @@ -19,6 +24,7 @@
>   #define DS_OUT_VAL_SHIFT	(26)
>   #define DS_PULLUD_EN_SHIFT	(27)
>   #define DS_PULLTYPE_SEL_SHIFT	(28)
> +#define WKUP_EN_SHIFT           (29)
>   
>   /* Schmitt trigger configuration */
>   #define ST_DISABLE		(0 << ST_EN_SHIFT)
> @@ -33,6 +39,26 @@
>   #define INPUT_EN		(1 << RXACTIVE_SHIFT)
>   #define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
>   
> +#define DS_PULL_DISABLE         (1 << DS_PULLUD_EN_SHIFT)
> +#define DS_PULL_ENABLE          (0 << DS_PULLUD_EN_SHIFT)

what is purpose of shifting zero,


> +
> +#define DS_PULL_UP              (1 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
> +#define DS_PULL_DOWN            (0 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
> +
> +#define DS_INPUT_EN             (1 << DS_OUT_DIS_SHIFT)
> +#define DS_INPUT_DISABLE        (0 << DS_OUT_DIS_SHIFT)
> +
> +#define DS_OUT_VALUE_ZERO       (0 << DS_OUT_VAL_SHIFT)
> +#define DS_OUT_VALUE_ONE        (1 << DS_OUT_VAL_SHIFT)
> +
> +#define WKUP_ENABLE             (1 << WKUP_EN_SHIFT)
> +#define WKUP_ON_LEVEL           (1 << WKUP_LVL_EN_SHIFT)
> +#define WKUP_ON_EDGE            (0 << WKUP_LVL_EN_SHIFT)
> +#define WKUP_LEVEL_LOW          (0 << WKUP_LVL_POL_SHIFT)
> +#define WKUP_LEVEL_HIGH         (1 << WKUP_LVL_POL_SHIFT)
> +
> +#define WKUP_DISABLE            (0 << WKUP_EN_SHIFT)
> +
>   /* Only these macros are expected be used directly in device tree files */
>   #define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
>   #define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
> @@ -53,18 +79,41 @@
>   #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
>   #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
>   
> +#define PIN_DRIVE_STRENGTH_NOMINAL      (0 << DRV_STR_SHIFT)
> +#define PIN_DRIVE_STRENGTH_SLOW         (1 << DRV_STR_SHIFT)
> +#define PIN_DRIVE_STRENGTH_FAST         (2 << DRV_STR_SHIFT)
> +
> +#define PIN_SCHMITT_TRIGGER_DISABLE	(0 << ST_EN_SHIFT)
> +#define PIN_SCHMITT_TRIGGER_ENABLE	(1 << ST_EN_SHIFT)
> +
>   #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
>   #define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
>   #define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
>   #define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
> -#define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
> -#define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
> +#define PIN_DS_OUT_ENABLE		DS_INPUT_DISABLE
> +#define PIN_DS_OUT_DISABLE		DS_INPUT_EN
>   #define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)
>   #define PIN_DS_OUT_VALUE_ONE		(1 << DS_OUT_VAL_SHIFT)
>   #define PIN_DS_PULLUD_ENABLE		(0 << DS_PULLUD_EN_SHIFT)
>   #define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
>   #define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
>   #define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
> +#define PIN_DS_ISO_BYPASS               (1 << DS_ISO_BYPASS_EN_SHIFT)
> +#define PIN_DS_ISO_BYPASS_DISABLE       (0 << DS_ISO_BYPASS_EN_SHIFT)
> +
> +#define DS_STATE_VAL                    (1 << DS_EN_SHIFT)
> +#define ACTIVE_STATE_VAL                (0 << DS_EN_SHIFT)
> +

Please do not mix PIN_x #define with other internal defines


> +#define PIN_DS_OUTPUT_LOW               (DS_STATE_VAL | DS_INPUT_DISABLE | DS_OUT_VALUE_ZERO)
> +#define PIN_DS_OUTPUT_HIGH              (DS_STATE_VAL | DS_INPUT_DISABLE | DS_OUT_VALUE_ONE)
> +#define PIN_DS_INPUT                    (DS_STATE_VAL | DS_INPUT_EN | DS_PULL_DISABLE)
> +#define PIN_DS_INPUT_PULLUP             (DS_STATE_VAL | DS_INPUT_EN | DS_PULL_UP)
> +#define PIN_DS_INPUT_PULLDOWN           (DS_STATE_VAL | DS_INPUT_EN | DS_PULL_DOWN)
> +
> +#define PIN_WKUP_EN_EDGE                (WKUP_ENABLE | WKUP_ON_EDGE)
> +#define PIN_WKUP_EN_LEVEL_LOW           (WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_LOW)
> +#define PIN_WKUP_EN_LEVEL_HIGH          (WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_HIGH)
> +#define PIN_WKUP_EN                     WKUP_EN_EDGE

what is difference between PIN_WKUP_EN_EDGE and PIN_WKUP_EN


>   
>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>   #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)

