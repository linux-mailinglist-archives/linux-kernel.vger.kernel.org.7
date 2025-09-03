Return-Path: <linux-kernel+bounces-797915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A793B41725
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEBB17C372
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F72E0927;
	Wed,  3 Sep 2025 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="O3nFrIWC"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA932D8385;
	Wed,  3 Sep 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885709; cv=none; b=SD1t0pvIFbMWdgwDOZ4h7I53VGhC4Kt36EnBvz9oihgWIKdTc9YlcSBYhxFPqICM06K5aNmHtdnuUHLDkSWUP9Xd+1tnxEc6HBv5MDOtYH1enJc5UMQof2Yx/5bR++yC4fW+1MGqFXpkmc8Tp07mhKou0HAba1n4kOX2Fi62peE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885709; c=relaxed/simple;
	bh=UX7ApGSd89PCSc4tk1Vecf+y29U73iL76b7Fzh5k+oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JxeGlQzSdtMWp/auB5AtO+ju22evL3LDaQ/oHfRz59WFSV3I9ZAZ7gPKDwDVttkF1CwzqyNHWf8junjScsIodz7Vc8rGnC0aOqunUR2YYRlRvpEzSepyBua2uiKYFHqUrJLOiiiZ6j87LL1l1IsumJK/8cFuMi40e5JDTCilOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=O3nFrIWC; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58376lcY022966;
	Wed, 3 Sep 2025 09:48:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	JclnwSMvldXNg3mzAIKsE19OGsHun7hVYkpQHQzEaGg=; b=O3nFrIWCMqFeoPD+
	GoHXZrTfbqsYitdNwTPnW4e1DXmCkb6S1MXA/EDCUuRVJVEj+OAaeWDr4xoVAW02
	2xmMfdRgGlHd8M4e6RyeqQi/szE6kEIgNQ2STmdBfKqBmY2PNSIvjm0TQWiaoiKK
	nHEeIrrxPtHB/WOH8MUpFkJ0kLxbmuH19keFnPUYwmIe2pVsAIGGvt/DybJkx+t/
	TvjcsqMlW25zZX35sdFPogsXzYn0YPgWGELkfkBPYJB3hLzDMBLCB1F0y2DBAytI
	B3gN7L+Ey7YWQyOsvKTIE+AiMrmfERn9VLt/mxakGMarya/EtVIlaU5646XHqJYS
	BrXCBQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48urmxfmrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 09:48:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A372840046;
	Wed,  3 Sep 2025 09:47:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4935329039A;
	Wed,  3 Sep 2025 09:46:48 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 09:46:47 +0200
Message-ID: <7cf42f82-5f90-47a7-8308-5f0c34f3fa1d@foss.st.com>
Date: Wed, 3 Sep 2025 09:46:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: stm32: Minor whitespace cleanup
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
        =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250819131707.86657-3-krzysztof.kozlowski@linaro.org>
 <20250819131707.86657-4-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250819131707.86657-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01

Hi

On 8/19/25 15:17, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> index 836b1958ce65..4ff334563599 100644
> --- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> +++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> @@ -100,7 +100,7 @@ &combophy {
>   };
>   
>   &csi {
> -	vdd-supply =  <&scmi_vddcore>;
> +	vdd-supply = <&scmi_vddcore>;
>   	vdda18-supply = <&scmi_v1v8>;
>   	status = "okay";
>   	ports {
> @@ -151,7 +151,7 @@ phy0_eth2: ethernet-phy@1 {
>   			reg = <1>;
>   			reset-assert-us = <10000>;
>   			reset-deassert-us = <300>;
> -			reset-gpios =  <&gpiog 6 GPIO_ACTIVE_LOW>;
> +			reset-gpios = <&gpiog 6 GPIO_ACTIVE_LOW>;
>   		};
>   	};
>   };

ARM & arm64 patches applied on stm32-next.

regards
alex

