Return-Path: <linux-kernel+bounces-790279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F9B3A432
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF161B273D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235FC223DDF;
	Thu, 28 Aug 2025 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VaMJPmC7"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D671C860E;
	Thu, 28 Aug 2025 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394508; cv=none; b=BCzXFni1lzCRTFrOWP/i63TUxndzoii/Qivf+EblJ65qnmY+LXWDxeuMFID2M+X4pEk3I6aBalzSAUbSyIYWTye2VE1CWBlS8OSlmGne8jal5s/MNJzwNSXP1kD4W3ZWb2xMkKyLR08EmY1Sjkc6mwFmAc6MUxRAA4QOneBJgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394508; c=relaxed/simple;
	bh=pz0sfFrLSj6bE5giO1t3dzsHqtz5FLAdKPYDMO6H2Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rgltUyTvtrad5AEq3sLs4kv3QGz/IIk8fUS6grShoD1yRERRPTrZYxat0D9Kxh6peFJjLZRN+xG9NbR9KvCA6phtq0wuWRSDwioSR012ljY5LqPlSSpSykPDoqoQL3xGBOS+CEgpa+5S5cvAI8WmsX4nOoDr/kEcKy5/fbEFHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VaMJPmC7; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SE2qYI012823;
	Thu, 28 Aug 2025 17:21:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	O9VFjkNVUuhl3uZqNyXhvf2bzDlbI1XIfUBemNWH/g4=; b=VaMJPmC7U0stvzBm
	IOztLMUvfd4K7y+/Jj2RGMVYGkNuHccu/R3szcysAJRTQMtIs3buKuQHj8DG6Il3
	1YL8UCsi1kddmcJHs3q2BfJo4Jh6wTd7gfDno636J57195tzmU8sXPz54+DxHEB3
	VB7IjO+09HX1yuVFer/DCkEp3sR7I11do4Q7t5OZpxeVF5DP7TmNpXT0wrQOcIYC
	nQZcJ0rxhqEGxaU8Uk5SANiJ/+OGYK+cJQrTjkvxR0NkJMfR97WR7Fq+FVlBaBGp
	XS1MqrgFujJQwsvwoaCmGNDJfJDIAOcAnCoNOBpryPUlC7GrUeIqt9Z1xQR/HxNI
	0ZcOTw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qrkmtxh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:21:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2161540055;
	Thu, 28 Aug 2025 17:20:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 29254768F38;
	Thu, 28 Aug 2025 17:19:14 +0200 (CEST)
Received: from [10.48.86.164] (10.48.86.164) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 17:19:13 +0200
Message-ID: <4201bb6b-3ad8-4b35-b152-0d725310245b@foss.st.com>
Date: Thu, 28 Aug 2025 17:18:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/13] dt-bindings: arm: stm32: add required
 #clock-cells property
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
 <20250822-drm-misc-next-v5-6-9c825e28f733@foss.st.com>
Content-Language: en-US
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <20250822-drm-misc-next-v5-6-9c825e28f733@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01

On 8/22/25 16:34, Raphael Gallais-Pou wrote:
> On STM32MP25 SoC, the syscfg peripheral provides a clock to the display
> subsystem through a multiplexer.  Since it only provides a single clock,
> the cell value is 0.
>
> Doing so allows the clock consumers to reach the peripheral and gate the
> clock accordingly.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   .../bindings/arm/stm32/st,stm32-syscon.yaml        | 31 +++++++++++++++-------
>   1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
> index ed97652c84922813e94b1818c07fe8714891c089..95d2319afe235fa86974d80f89c9deeae2275232 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
> @@ -36,20 +36,31 @@ properties:
>     clocks:
>       maxItems: 1
>   
> +  "#clock-cells":
> +    const: 0
> +
>   required:
>     - compatible
>     - reg
>   
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - st,stm32mp157-syscfg
> -          - st,stm32f4-gcan
> -then:
> -  required:
> -    - clocks
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp157-syscfg
> +              - st,stm32f4-gcan
> +    then:
> +      required:
> +        - clocks
> +  - if:
> +      properties:
> +        compatible:
> +          const: st,stm32mp25-syscfg
> +    then:
> +      required:
> +        - "#clock-cells"
>   
>   additionalProperties: false
>   
>
Acked-by: Christophe Roullier <christophe.roullier@foss.st.com>

You can merge it on DRM MISC.

Best Regards,
   Christophe


