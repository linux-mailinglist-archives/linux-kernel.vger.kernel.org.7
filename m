Return-Path: <linux-kernel+bounces-781931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9213B318CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2D31C21752
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9523043CF;
	Fri, 22 Aug 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KI/XT+6M"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F512FC03E;
	Fri, 22 Aug 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867614; cv=none; b=aqKWb5gy/ZOfiygQkyruNnqaUB2ieRq6Ml/tJx6I0GQE9Swa6q6SuLzazK4TY982YxR7FfHJxx6Nl7NbfSoNInP3/fstRDAJruTj1pIFnOjzbe0zz1LIpwwNw7+gnzLpQOo70gseHAyNV48TPAXzSKq0XgpEX3xJNYELOL3aKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867614; c=relaxed/simple;
	bh=hRTwqACIQ8hZJjA3GSkgqt13hL1cRiFuW3CfMttMcKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qgfmhasRfMgxi56h75duq7E+U+583IvrqxsGQyyOvazaWE0vr7gmufmJi1IS65Q0P8iSWC3evEhO0LRA1F3MeHwW8DaIoNh0wFmDw8AaYKAZKRKqfw/sWTvKuHg1/UK2A4WY+AxL6wGlwl2DJvl3MI86O/yXWpJsJWtJ5CFC/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KI/XT+6M; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCoe7v030096;
	Fri, 22 Aug 2025 14:59:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	fdRuwvgpdfkzMUyKr6tHlpFHvNuuCdXxV4D+HC6QaMA=; b=KI/XT+6MJhFi2WeZ
	w5MTkk1UGOx796nFOR/zy+WvJGJudHm7jyOVRGMaXPZ8w3xyHBktOam8O+P/3qVX
	VHDVymxUsP8rpSaly0cSlknRRPL6vW9aO4zwzjIUFMukfMXWBkOUO/R1oZ8meTeE
	+3JvIr4Rbjysy0r1W0Q/J9U7xURtq1A05uWJ4tvY912gefWrZ6GZBa/HvUhyXXpX
	HxiAMdLAgdqNKPU1FHAuEoJ9zVdZywDzhv7Qk6PQCRxrdKDMtOL2kaUPbwAAgvuw
	htF5OKdOLwYHZctSLYtibJWJz5iaAjqC+/wUYlz1RUa9qnLm8+DKybMjl1Az8Lhr
	hFtBYg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48np7n77uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:59:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 23DE04004B;
	Fri, 22 Aug 2025 14:58:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4281871EE31;
	Fri, 22 Aug 2025 14:57:40 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:57:39 +0200
Message-ID: <7278430c-0b01-4a35-b1c0-b906e6cf464a@foss.st.com>
Date: Fri, 22 Aug 2025 14:57:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/13] arm64: dts: st: add ltdc support on stm32mp251
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
 <20250821-drm-misc-next-v4-9-7060500f8fd3@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-9-7060500f8fd3@foss.st.com>
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
> The LCD-TFT Display Controller (LTDC) handles display composition,
> scaling and rotation.  It provides a parallel digital RGB flow to be
> used by display interfaces.
>
> Add the LTDC node.
>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index 303abf915b8e489671b51a8c832041c14a42ecb8..372a99d9cc5c3730e8fbeddeb6134a3b18d938b6 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -1576,6 +1576,18 @@ dcmipp: dcmipp@48030000 {
>   				status = "disabled";
>   			};
>   
> +			ltdc: display-controller@48010000 {
> +				compatible = "st,stm32mp251-ltdc";
> +				reg = <0x48010000 0x400>;
> +				interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&rcc CK_KER_LTDC>, <&rcc CK_BUS_LTDC>;
> +				clock-names = "lcd", "bus";
> +				resets = <&rcc LTDC_R>;
> +				access-controllers = <&rifsc 80>;
> +				status = "disabled";
> +			};
> +
>   			combophy: phy@480c0000 {
>   				compatible = "st,stm32mp25-combophy";
>   				reg = <0x480c0000 0x1000>;
>

