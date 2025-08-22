Return-Path: <linux-kernel+bounces-781892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C66B3184E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32822AC1DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C22FDC4B;
	Fri, 22 Aug 2025 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dRbXqxYF"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C5E2FAC04;
	Fri, 22 Aug 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866981; cv=none; b=cmmGee30ZZbYZfpH0O3Vq/E0op4fAAjHDM1AvKBOAJ+uC2tmo0ixmlptJEyKXN9+S0bFRcwyY1CnMLx0+44rbgB+4iHRmiNkpz1Nxu4tX/13so9EVhNdXNRTK6buQZFAJazWSvtbuUTCZi4DY+/pFn4wJKUAOCb1kBiPkuD4E44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866981; c=relaxed/simple;
	bh=7CKJ/lmvVicuGbBywEH71nBkN6RuXcD09bl7WbskK8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D9Vp/7rgnMPvgO20y0yQs7B/QDmWSKOyAk37VSc7e7yROXRjJ5krjwDwYNJ4fZKAXfOXT9GExYR4U7b3y3v9UMVqMIr9ppmVzf8Q+5KXRK+7HyhEgV0G1RnYozsLj2cojSEMFK9Jaxvr1P2z+kK9aZWlDHH9kmlxO/3zwcPw24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dRbXqxYF; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCkkEZ009011;
	Fri, 22 Aug 2025 14:49:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	BBUcXlxzscyorCoaJ9iJ2kd5UTgHKRJLd4Iov/cXDBI=; b=dRbXqxYFHYZu0NTY
	BCOn6XSFf1YRiKYIGJnepLQpmrq2iyKf65fxTTXn3aH5Nbqc+k/14vp1sLsJyMwe
	ArTs1NeZShJYPrcuVExX22ntyt7ztOQ+4MhjL0z/Q1/n+l6GRtadpTlUfbKyuTZz
	ptr0qVOL3Z2+WiPS6hKrrCIhJLVzohLYDuc/Dpw2+n6+Fj8V7sKFQmqvsvPwk6nn
	z8IOq6SPx/8GWvdMzq3XNzhEmxVQwNzxwuMRaiDpuNBLMzDevzud4FKnSA5BWjJz
	H2hCyxdQjRisapgF+YuRvw+B72ydhRJ2RBTS+sU1MSb94ewt3U46kIMSKn2gqUJ1
	Ce3V5A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48nj3v87d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:49:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EE9284004B;
	Fri, 22 Aug 2025 14:47:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9057A71CEF9;
	Fri, 22 Aug 2025 14:46:52 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:46:51 +0200
Message-ID: <ee21d95d-31fe-40e8-ab89-06ce3a44b4bb@foss.st.com>
Date: Fri, 22 Aug 2025 14:46:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] dt-bindings: display: st,stm32mp25-lvds: add
 power-domains property
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
 <20250821-drm-misc-next-v4-5-7060500f8fd3@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-5-7060500f8fd3@foss.st.com>
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
> STM32 LVDS peripheral may be in a power domain.  Allow an optional
> single 'power-domains' entry for STM32 LVDS devices.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> index 05a73bbc246a8994b6aabf7c2cd9dca773232be4..14e042156179cb2f2d906422eaff6840da3c91ea 100644
> --- a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
> @@ -62,6 +62,9 @@ properties:
>     access-controllers:
>       maxItems: 1
>   
> +  power-domains:
> +    maxItems: 1
> +
>     ports:
>       $ref: /schemas/graph.yaml#/properties/ports
>   
>

