Return-Path: <linux-kernel+bounces-781860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E4FB317E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780473AC6CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1832FB621;
	Fri, 22 Aug 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Zahfk0R3"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2378F58;
	Fri, 22 Aug 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865931; cv=none; b=mb2mSolBDaIWldKTvCMWJXpv6x8yQkbIBbJIF0ZCNeaKXpbZxpe51OJa3z/6MqnLy69GH+8wJrD0ZwwUp5ZpfxHzE3sKaFEuKcyy39mGfcR3Xa8r/YYcbx6xaHs1T/kijFkrIxuai/kx3Bb78bi5tdS48libqyxAUau5558b1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865931; c=relaxed/simple;
	bh=1vOkihTL/FW3jv5lIyr5b0s5TaRbEjA9TqMW25XJvZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ORLUrHG62p+lNidBnlNonKhYb707tg/txYvLOB4mxXDdL/cLwSr29L4W388HcpJjGi6T98Sz+NsfjsAxOIA06krDBYgTbGzIKu0cx/3+vM2VF+L9lHyDJkk7ZgBtwgWB/OadKvQN22Sqr4R0raz2ZplmGNLizWaMcT7nfUOWv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Zahfk0R3; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCHGJl009682;
	Fri, 22 Aug 2025 14:31:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	JBT1UDpbACmKUTz7QVz33kNvVsoysRpJ/dCT2cDLpW4=; b=Zahfk0R3fVBUSlts
	KqSACcCnut8KaGkwtIZecPsqlTIN+SuQG3TxqHT8iCCddekygt83cXwczb6jvr8l
	VA5fiAaU2B9eDZFRDludMIopoz/7pBF3ktLeHYyH/cMsPjipz1O0bMlQJpx4wQfS
	R/Z3uz3liKRAL6xgoz7HxXQeBAnVxPFRkQlz9/kEK8Drl08bmPIB4x2w7LuNiFd7
	tFg1Rqwtz1vEr1JgQ6B4pyq+Yd6e9hfmFKl5XtKOSJ5bNofx1m2eWSIvSe4ggcJj
	ckmbEczqw+Lql/Way9StH+kZfUmq3PrmX24dfd2vKR6z6qZLobT/H9ddXOm+zsss
	BcUoMw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48np7n752x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:31:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1470240046;
	Fri, 22 Aug 2025 14:30:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F9F26C2A88;
	Fri, 22 Aug 2025 14:29:43 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:29:42 +0200
Message-ID: <512c5e41-276d-4c2c-936c-718347df3711@foss.st.com>
Date: Fri, 22 Aug 2025 14:29:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] dt-bindings: display: st: add two new
 compatibles to LTDC device
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250821-drm-misc-next-v4-0-7060500f8fd3@foss.st.com>
 <20250821-drm-misc-next-v4-1-7060500f8fd3@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-1-7060500f8fd3@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

Hi Raphael,

Thanks for the patch.

Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>

Le 21/08/2025 à 13:08, Raphael Gallais-Pou a écrit :
> The new STMicroelectronics SoC features a display controller similar to
> the one used in previous SoCs.  Because there is additional registers,
> and different mandatory clocks it is incompatible with existing IPs.  On
> STM32MP251, the device only needs two clocks while on STM32MP255 it
> needs four.
>
> Add the new names to the list of compatible string and handle each
> quirks accordingly.
>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   .../devicetree/bindings/display/st,stm32-ltdc.yaml | 50 +++++++++++++++++++++-
>   1 file changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> index d6ea4d62a2cfae26353c9f20a326a4329fed3a2f..bcedcfef5427f5725a0473c09628e70d172c8f58 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> @@ -12,7 +12,10 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: st,stm32-ltdc
> +    enum:
> +      - st,stm32-ltdc
> +      - st,stm32mp251-ltdc
> +      - st,stm32mp255-ltdc
>   
>     reg:
>       maxItems: 1
> @@ -24,11 +27,16 @@ properties:
>       minItems: 1
>   
>     clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
>   
>     clock-names:
>       items:
>         - const: lcd
> +      - const: bus
> +      - const: ref
> +      - const: lvds
> +    minItems: 1
>   
>     resets:
>       maxItems: 1
> @@ -51,6 +59,44 @@ required:
>     - resets
>     - port
>   
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32-ltdc
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp251-ltdc
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +        clock-names:
> +          maxItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp255-ltdc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +        clock-names:
> +          minItems: 4
> +
>   additionalProperties: false
>   
>   examples:
>

