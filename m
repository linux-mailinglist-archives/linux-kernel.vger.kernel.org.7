Return-Path: <linux-kernel+bounces-766875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E13EB24C36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB9F5A53E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5FF1D8DE1;
	Wed, 13 Aug 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F2ZfgSqM"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019C45C0B;
	Wed, 13 Aug 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095961; cv=none; b=IanUu/Qeo//UYHR2UO0N/LOVNfgYV3Z0XvdTUL0qitl316tTWXueU4NRaRbpwD8F9sEKmdfnsT/ZTwjZ0AG4L7XGIXgdSMpqWuKBf14Ib4z3USLpV3vCKCEncwUz6ZriHzAKXuNLSa3dHXKGa2KDgPZxO1Bqg0SOuTVp5BqswDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095961; c=relaxed/simple;
	bh=Yt6I40SQqu1RudypHkxSxh3gc469tMH4doopPE6GnOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GrLTnE6x7B+6iCzWRYj+3iGjqpW8mR8d9iL3RXZy7Cztb+tRLLH65urz6iMHekytm/x9tHy9zchGxH6ZMXIumvbQDO8Ph/yKRuuVS9JS45oIMto76Extk6CXvmgZ1sZ4dKY/E0NOsgxshlhRkbazwTHaXkoXvofLV0eK6Fcyhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F2ZfgSqM; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DEdDUY2168109;
	Wed, 13 Aug 2025 09:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755095953;
	bh=du591Tkp6MY1pZEI92hOmTvxfNKepbcwESeiRPgLFUw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=F2ZfgSqMKEk8nBWeqf1VY0CBy52MvnVIHAJTzAn5C6Ranx4qpBbYn0BFanZ7D8srI
	 y4KAQGPyBCwIxtmNKFjt/4lWT+Sz/qQWQofmNfCk2wALiZY9QUMILUk5lXgPJxnCeq
	 HdJrB3oJCXlgAc45X+/IXtrb8ATA/7cE9sJ+QQJQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DEdDp8128062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 09:39:13 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 09:39:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 09:39:13 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DEd9lO2142416;
	Wed, 13 Aug 2025 09:39:10 -0500
Message-ID: <39f2bc33-e35c-4de4-9377-cf41f510ecc2@ti.com>
Date: Wed, 13 Aug 2025 20:08:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining macros
To: Akashdeep Kaur <a-kaur@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
References: <20250731115631.3263798-1-a-kaur@ti.com>
 <20250731115631.3263798-4-a-kaur@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250731115631.3263798-4-a-kaur@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 31/07/25 17:26, Akashdeep Kaur wrote:
> Add the drive strength, schmitt trigger enable macros to pinctrl file.
> Add the missing macros for deep sleep configuration control.
> Reword the existing deep sleep macros to provide combinations that can
> directly be used in device tree files.
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 66 +++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index c0f09be8d3f9..f26f1fcf6f74 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -3,7 +3,7 @@
>   * This header provides constants for pinctrl bindings for TI's K3 SoC
>   * family.
>   *
> - * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
> + * Copyright (C) 2018-2025 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  #ifndef DTS_ARM64_TI_K3_PINCTRL_H
>  #define DTS_ARM64_TI_K3_PINCTRL_H
> @@ -19,6 +19,13 @@
>  #define DS_OUT_VAL_SHIFT	(26)
>  #define DS_PULLUD_EN_SHIFT	(27)
>  #define DS_PULLTYPE_SEL_SHIFT	(28)


> +#define WKUP_EN_SHIFT		    (29)
> +#define WKUP_LVL_EN_SHIFT	    (7)
> +#define WKUP_LVL_POL_SHIFT	    (8)
> +#define ST_EN_SHIFT		        (14)
> +#define DRV_STR_SHIFT		    (19)
> +#define DS_ISO_OVERRIDE_EN_SHIFT (22)
> +#define DS_ISO_BYPASS_EN_SHIFT  (23)

These *_SHIFT macros are mostly arranged in ascending order of bit
position, please follow the same.

Also, ST_EN_SHIFT is already defined ?

>  
>  /* Schmitt trigger configuration */
>  #define ST_DISABLE		(0 << ST_EN_SHIFT)
> @@ -33,6 +40,26 @@
>  #define INPUT_EN		(1 << RXACTIVE_SHIFT)
>  #define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
>  
> +#define DS_PULL_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
> +#define DS_PULL_ENABLE		(0 << DS_PULLUD_EN_SHIFT)
> +
> +#define DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
> +#define DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
> +
> +#define DS_INPUT_EN		    (1 << DS_OUT_DIS_SHIFT)
> +#define DS_INPUT_DISABLE    (0 << DS_OUT_DIS_SHIFT)
> +
> +#define DS_OUT_VALUE_ZERO   (0 << DS_OUT_VAL_SHIFT)
> +#define DS_OUT_VALUE_ONE    (1 << DS_OUT_VAL_SHIFT)
> +
> +#define WKUP_ENABLE		    (1 << WKUP_EN_SHIFT)
> +#define WKUP_ON_LEVEL		(1 << WKUP_LVL_EN_SHIFT)
> +#define WKUP_ON_EDGE        (0 << WKUP_LVL_EN_SHIFT)
> +#define WKUP_LEVEL_LOW      (0 << WKUP_LVL_POL_SHIFT)
> +#define WKUP_LEVEL_HIGH		(1 << WKUP_LVL_POL_SHIFT)
> +
> +#define WKUP_DISABLE        (0 << WKUP_EN_SHIFT)
> +
>  /* Only these macros are expected be used directly in device tree files */
>  #define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
>  #define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
> @@ -53,18 +80,33 @@
>  #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
>  #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
>  
> +#define PIN_DRIVE_STRENGTH_NOMINAL	(0 << DRV_STR_SHIFT)
> +#define PIN_DRIVE_STRENGTH_SLOW	    (1 << DRV_STR_SHIFT)
> +#define PIN_DRIVE_STRENGTH_FAST	    (2 << DRV_STR_SHIFT)
> +
> +#define PIN_SCHMITT_TRIGGER_DISABLE	(0 << ST_EN_SHIFT)
> +#define PIN_SCHMITT_TRIGGER_ENABLE	(1 << ST_EN_SHIFT)
> +
>  #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
> -#define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
> -#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
> -#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
> -#define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
> -#define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
> -#define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)
> -#define PIN_DS_OUT_VALUE_ONE		(1 << DS_OUT_VAL_SHIFT)
> -#define PIN_DS_PULLUD_ENABLE		(0 << DS_PULLUD_EN_SHIFT)
> -#define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
> -#define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
> -#define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)

No we cannot delete these. There maybe downstream dts files already
using these macros and thus can cause incompatibilities.

> +#define PIN_DS_FORCE_ENABLE		    (1 << FORCE_DS_EN_SHIFT)

> +#define PIN_DS_ISO_OVERRIDE_DISABLE	(0 << DS_ISO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_ISO_OVERRIDE	        (1 << DS_ISO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_ISO_BYPASS           (1 << DS_ISO_BYPASS_EN_SHIFT)
> +#define PIN_DS_ISO_BYPASS_DISABLE   (0 << DS_ISO_BYPASS_EN_SHIFT)
> +
> +#define DS_STATE_VAL        (1 << DS_EN_SHIFT)
> +#define ACTIVE_STATE_VAL    (0 << DS_EN_SHIFT)
> +
> +#define PIN_DS_OUTPUT_LOW       (DS_STATE_VAL | DS_INPUT_DISABLE | DS_OUT_VALUE_ZERO)
> +#define PIN_DS_OUTPUT_HIGH      (DS_STATE_VAL | DS_INPUT_DISABLE | DS_OUT_VALUE_ONE)
> +#define PIN_DS_INPUT            (DS_STATE_VAL | DS_INPUT_EN | DS_PULL_DISABLE)
> +#define PIN_DS_INPUT_PULLUP	    (DS_STATE_VAL | DS_INPUT_EN | DS_PULL_UP)
> +#define PIN_DS_INPUT_PULLDOWN   (DS_STATE_VAL | DS_INPUT_EN | DS_PULL_DOWN)
> +

> +#define WKUP_EN_EDGE		(WKUP_ENABLE | WKUP_ON_EDGE)
> +#define WKUP_EN_LEVEL_LOW	(WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_LOW)
> +#define WKUP_EN_LEVEL_HIGH	(WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_HIGH)
> +#define WKUP_EN		        WKUP_EN_EDGE

All existing macros in this block have PIN_* suffix. Please align with
the same.

>  
>  /* Default mux configuration for gpio-ranges to use with pinctrl */
>  #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)


For future versions, please split the changes to 2 patches: one for
white-space changes only and one for addition of new macros.

-- 
Regards
Vignesh
https://ti.com/opensource


