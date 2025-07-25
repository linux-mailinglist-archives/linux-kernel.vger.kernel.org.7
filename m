Return-Path: <linux-kernel+bounces-745705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3AB11D50
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F69C3A6E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433192E54DB;
	Fri, 25 Jul 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="N3M2Egl7"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D1239E6B;
	Fri, 25 Jul 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441909; cv=none; b=hDBK4f7aARjLhuuSshrAcln+Ct8vuJA4EYt+foRmx0i1ho6LueSAizYStpcv2AQa53bov0ICqXKMFyquVL7gVe3QobPbIEMhDoqg3Yyb4bSWZvqY3WCoKGHRx+W+THKnJnC+o5ZWqTx7Zfgr7DBXqB+0EgL961s5+xMviLiW11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441909; c=relaxed/simple;
	bh=XAXScqVMUryK7u8cjxp+a04hujddoVAphlMbwqtTPts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CxhrV15jj59u5cm7rejiA2ETWy3R4pyC5MGm7/RsqLTd+M3v0m3S54KNm4IYc8FrUgo6aV/Mo/WnfqLENRPAjtBwgALH9D+jakRF8c1pDw+mJddXF5Cd18C9xWAicGS8tT/jsv8hlCZ8jBNFVtqZjBcwTjexn2YzILQmR/G8Tsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=N3M2Egl7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PA7CB4004324;
	Fri, 25 Jul 2025 13:11:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	7EIFICZ6PcSv8Dm1Wx1IcEsY2QkDaiXmUkaUpQzq2mw=; b=N3M2Egl7vTiFztE5
	eWo2u9sUVXirJiniHCzcbmnm41xHXf33B3ctG5RtYCk9GRh++0Sz5JzTNNeOUard
	sPyHLHT1ipV3o770xZa2wnlHs2zl6ex/6pM3+PIhbuFun/95aqW3xttHRUDWEjQc
	DaXeKT7wLq6SpwVUaIo+qyhjkUj8aPtzFqqW67TZSFfRyJd7MjaOZGgO+r3uBnOd
	hJnDkqU+UvTrpxhWQFe4XxEgHYjeHOTcub0B/q+CpnKVWhc5GBlpBK0cakMJg1iY
	vo427FXrD3VPZtlgCF9U+oQsmx3WXVAC92qSFtQQ11nZn/zqjDW4Lcp7h9saIfPZ
	Lwyx9Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 483w3ett17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 13:11:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 03F9B4004D;
	Fri, 25 Jul 2025 13:10:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AE05C22306A;
	Fri, 25 Jul 2025 13:09:00 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:08:59 +0200
Message-ID: <85673db7-d311-47cc-be52-291d94e136e4@foss.st.com>
Date: Fri, 25 Jul 2025 13:08:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH 09/12] arm64: dts: st: add lvds support on
 stm32mp255
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
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
 <20250725-drm-misc-next-v1-9-a59848e62cf9@foss.st.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20250725-drm-misc-next-v1-9-a59848e62cf9@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01

Hi Raphael,

On 7/25/25 12:04, Raphael Gallais-Pou wrote:
> The LVDS is used on STM32MP2 as a display interface.
> 
> Add the LVDS node.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp255.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp255.dtsi b/arch/arm64/boot/dts/st/stm32mp255.dtsi
> index f689b47c5010033120146cf1954d6624c0270045..a4d965f785fa42c4597494010855aec7e1b9fdd1 100644
> --- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
> @@ -6,6 +6,18 @@
>   #include "stm32mp253.dtsi"
>   
>   &rifsc {
> +	lvds: lvds@48060000 {
> +		compatible = "st,stm32mp25-lvds";

For the compatible you now need one comaptible per SoC.
It means your compatible should look like : "st,stm32mp251-lvds".
This way, if on the 253 or 255 there is an issue you are able to easily 
add match data in the driver with compatible "st,stm32mp253-lvds" or 
"st,stm32mp255-lvds".
A prior discussion on this subject has been raised on my V1 of HDP 
involving Krzysztof and Alexandre :
https://lore.kernel.org/all/418a80a9-8c08-4dd1-bf49-1bd7378321aa@kernel.org/

> +		#clock-cells = <0>;
> +		reg = <0x48060000 0x2000>;
> +		clocks = <&rcc CK_BUS_LVDS>, <&rcc CK_KER_LVDSPHY>;
> +		clock-names = "pclk", "ref";
> +		resets = <&rcc LVDS_R>;
> +		access-controllers = <&rifsc 84>;
> +		power-domains = <&CLUSTER_PD>;
> +		status = "disabled";
> +	};
> +
>   	vdec: vdec@480d0000 {
>   		compatible = "st,stm32mp25-vdec";
>   		reg = <0x480d0000 0x3c8>;
> 

Best regards,
Clément

