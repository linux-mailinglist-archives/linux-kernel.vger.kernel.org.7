Return-Path: <linux-kernel+bounces-799980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF9B431F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A161C1BC7DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C4A243969;
	Thu,  4 Sep 2025 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HNqwXsXv"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FBBE5E;
	Thu,  4 Sep 2025 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965932; cv=none; b=VwLzvcHbVbwpttzYapK/T5Ta8AP8lT4LhueXTH3mYU7yY/uSwWSUzkzszYAE+OCiyBIiac87lKaimw6pRm8Y1MySXbC3V3tIOPMsM4IhxdZdgRlgswmkQU/QUR3BM+pIm5XkLVl668CQEruF8/7J0xB30RduXAU9x/MC77+eYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965932; c=relaxed/simple;
	bh=A8DyXpmSf0YJ9pU5HQsyBKJGG/i0naCN+latWCdwnUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jBVjBr8pjq+wQ/RKh436I2kpq2FLYAR4npXxsxmQx58POuK26iKTZCkc8lDlf9czWVnEX6jWGqiSVZ8Jyk+BHIK5frYo8u5xeK5ui4+obqxLU8/2drWQ93JWz49PtZSmoaat7zHExZOcrGYmJUBe6TmeIVMsdp9H7YF2rxwd6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HNqwXsXv; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58465Ogf2945232;
	Thu, 4 Sep 2025 01:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756965924;
	bh=xJWd2GdqmONSMgXynZQD3tF9E/uol/2oNFgNcJ3L0Ns=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HNqwXsXvhP/lbCutPmWGIszOidN6sA/xFgKFBvfkMUwgJLisT3JW/3M8neprSeUW0
	 pNmnfhNaEA5BFT3y6gA4zVmPHqPw8+nbQizHLc5DhxS+zAM17KF9RF3xepzza1yRN2
	 6+2/KJU1hzM8e4uyjj8gxf0/8Qy0za5x2J9oByJs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58465OTp3599531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 01:05:24 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 01:05:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 01:05:23 -0500
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58465IMH2500914;
	Thu, 4 Sep 2025 01:05:19 -0500
Message-ID: <c5dd1c02-8538-4b9f-a453-d18e7a30ae30@ti.com>
Date: Thu, 4 Sep 2025 11:32:40 +0530
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
CC: <vishalm@ti.com>
References: <20250902071917.1616729-1-a-kaur@ti.com>
 <20250902071917.1616729-4-a-kaur@ti.com>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20250902071917.1616729-4-a-kaur@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Akash,

On 02/09/25 12:49, Akashdeep Kaur wrote:
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
...
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

This can be moved below WKUP_ENABLE macro to be consistent

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
...
> +#define DS_STATE_VAL                    (1 << DS_EN_SHIFT)
> +#define ACTIVE_STATE_VAL                (0 << DS_EN_SHIFT)

These can be moved to the top before PIN_* and can be renamed to 
DS_STATE_EN and DS_STATE_DIS

> +
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

As EDGE wake is used commonly we can use the PIN_WKUP_EN_EDGE in this case

>   
>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>   #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)

Thanks
Sebin

