Return-Path: <linux-kernel+bounces-788770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BDB38A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965D65E73AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198572DC323;
	Wed, 27 Aug 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ABaJO41g"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099EDF58;
	Wed, 27 Aug 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322099; cv=none; b=IziStnTW5yDhr1EaImWSa/SQZu+f24iBRRlF9LUgsoUpveLo+acMp2nR77SivGFIMa8vvYIwk59Nq2QJCmP3fhwdXxTrGHKekB0hSp25awRzFkzKcDOHwR2/7hve+BfGM1B2V3Hv2VonLVRrT/lyeBL1mb3i10IOcMLU63mB1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322099; c=relaxed/simple;
	bh=2h4vav2QC9xjdDUIwmEajkSGvXHfsNyDqevmRMvPkVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DM7/+HPIEn2U1JybQqB2jI9tmApHdXXV1GLyBUmLnUrCVqE4rvQOwez4z3wzf849lNE7XSWBh1SVpRHRSLqMMxArmWlqsXGRCzKbTBjlaw5EjwU3YvYb9CdfWOceLG+lsSDrmSWKxOQ2N25JXlcuS7iR9P4klGCtwcrUTHjABeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ABaJO41g; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57RJEfbm1837415;
	Wed, 27 Aug 2025 14:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756322082;
	bh=YNq7FAgo4z92pYyBMMzR/Nsu4N6hHZWc/4w7c520tTQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ABaJO41gCUL5gKb7nixcy0Fq5p22ycOIyf0mY6a/RnwOEz+b+Bj6joJZEGJ5akgeS
	 TGe3U2KZJNqjDgb3Bew0xgr4ng1ThDgsZT9yxkp2foKg79RY07lrkl8+B8bldY/e6G
	 WpPmdKHUFtxyIUsfSb7lF3KOps+XLn90ohJAPpqo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57RJEfai3385684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 27 Aug 2025 14:14:41 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 27
 Aug 2025 14:14:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 27 Aug 2025 14:14:41 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57RJEfHf3567231;
	Wed, 27 Aug 2025 14:14:41 -0500
Message-ID: <18fb75ad-aab8-455c-91a7-f8741289191c@ti.com>
Date: Wed, 27 Aug 2025 14:14:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vishal Mahaveer <vishalm@ti.com>,
        Kevin
 Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        Sebin Francis
	<sebin.francis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
 <20250812-topic-am62-dt-partialio-v6-15-v2-1-25352364a0ac@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250812-topic-am62-dt-partialio-v6-15-v2-1-25352364a0ac@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/12/25 04:15, Markus Schneider-Pargmann wrote:
> WKUP_EN is a flag to enable pin wakeup. Any activity will wakeup the SoC
> in that case.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   arch/arm64/boot/dts/ti/k3-pinctrl.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index c0f09be8d3f94a70812b66c3f91626aac35f4026..d3b0ecdf1a4a4de25ee6121ec9e62d1c7df26eb9 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -19,6 +19,7 @@
>   #define DS_OUT_VAL_SHIFT	(26)
>   #define DS_PULLUD_EN_SHIFT	(27)
>   #define DS_PULLTYPE_SEL_SHIFT	(28)
> +#define WKUP_EN_SHIFT		(29)
>   
>   /* Schmitt trigger configuration */
>   #define ST_DISABLE		(0 << ST_EN_SHIFT)
> @@ -65,6 +66,7 @@
>   #define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
>   #define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
>   #define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
> +#define WKUP_EN				(1 << WKUP_EN_SHIFT)
>   
>   /* Default mux configuration for gpio-ranges to use with pinctrl */
>   #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
> 

Reviewed-by: Kendall Willis <k-willis@ti.com>

