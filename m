Return-Path: <linux-kernel+bounces-766697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F220B24A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654D558846F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8D2E6106;
	Wed, 13 Aug 2025 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cAW4mthz"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED215A87C;
	Wed, 13 Aug 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090334; cv=none; b=UmzJgkDmYaEmmovd9O2UrfRRadbsJdW0kZQVIArHtz/W8SXGWn2ebbxkKPxRTDvrHdYsePOaeScnNiRy0bA+SXI1oDVWKGPSYYCJZu+pBcREaSk30fPHXWoDRQVdYS9XlPIFORyErCZQ4I1qDmFqnSgmRMqaEVsoUonOPT6GbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090334; c=relaxed/simple;
	bh=agF8vQN8DrGjvKoo9wYAr2t7qN0STSPsR7lgfOl2dkY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFlnW2/MOBLfQyM0Z7G/99jc3U2b0SvzRAlygEsm1vG+lmtNmRPCVBHtl0YCVcQmLjtYNmMRTJzXjZ1VRgvIEg6Xzzwzafi3K2I71SFkK7Y9Tl1jQommmTec/7O1zihG1Pgg59CawhUOwsPHJD1SRc3R7cDo+hLpRmSe7nKsaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cAW4mthz; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DD5ODJ2152796;
	Wed, 13 Aug 2025 08:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755090324;
	bh=OyvusIEXjAre/xttjCZZR35LjwYPJuaLUvaZ9xyV3Z8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=cAW4mthz+eHWDjhCFx18wqQmgxjqWJVY/281sbD/5YMHzdqsigvxPfiyRDDHGZxA3
	 OkzoEL4zLGmM3MUB5JoNChRxVAnCCG2QioJhHelWzMAD8EHXE04J6oUtLKWsKhlgQ+
	 LXs9zc2DmDq9V1iizq6CdlIMzj1HVmejfd1S9jjo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DD5OZi1086160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 08:05:24 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 08:05:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 08:05:23 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DD5MkH2333843;
	Wed, 13 Aug 2025 08:05:22 -0500
Date: Wed, 13 Aug 2025 18:35:21 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Akashdeep Kaur <a-kaur@ti.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining macros
Message-ID: <20250813130521.zpe7lguful6gyhjz@lcpd911>
References: <20250731115631.3263798-1-a-kaur@ti.com>
 <20250731115631.3263798-4-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250731115631.3263798-4-a-kaur@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Akashdeep,

On Jul 31, 2025 at 17:26:31 +0530, Akashdeep Kaur wrote:
> Add the drive strength, schmitt trigger enable macros to pinctrl file.
> Add the missing macros for deep sleep configuration control.

Please can you add sources/ links to the TRM/collateral and sections where you get
all this information from?

> Reword the existing deep sleep macros to provide combinations that can
> directly be used in device tree files.

I am not very clear on what this line is trying to say. Can you explain
a bit more with an example of a reword and how it is helping?

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

Seeing it on lore and in my git log -p as well, the alignment looks off.
Please fix it.

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

These too, fix all alignment issues please.

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


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

