Return-Path: <linux-kernel+bounces-781940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AE9B318F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57298685B96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3901C2FC02B;
	Fri, 22 Aug 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fyuJccF/"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DC033DF;
	Fri, 22 Aug 2025 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868076; cv=none; b=FuYnF4Bwezl3k6RpXHJccbFx+4a8aqTFh8+9+elV56M+TO9gINWcQQO3r5NXi1Huaep6/wWUSwqsMT4InKOPNf1GBMtoNILH2D2q34Ru9yBjaWDCigkKgrk6re5+WFRELUOU7bKxsXD0NPvD+J6Z/97ojDPVvHyIG9JxVUQDlUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868076; c=relaxed/simple;
	bh=iNPmt14UjjhirH26YNKhHvPAEP6Rp/w9ujFmpRLTsNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UtKM/9cyIi0tJxlTlqHbV+wizeur27ua2TfhqYQww/xkjH39aNm107U0ncyXrscAlEziPU7/XgCReiscdFpqYlbCyiRSuEYFGEC/iPZIxpoQOoGqntKeU/Uh8tHLBI3J479Ok5/j9bOHLpszXaWFTLlIMCSipQY+6Mb4GucnqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fyuJccF/; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MBCtNP004015;
	Fri, 22 Aug 2025 15:07:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	y4dfZmBKti9e9DTCpNwBo1wF53VJMOGIMax06H7HFHE=; b=fyuJccF/s7ggC7Ys
	XJTR9QPRN0IY/FWb5RFoJbpn7uySk9I5631NtBvMrBOFbAEhXLjcjg7+OjAN/jhz
	gg5kdf51Xz1wSV1t+152tqzPW5lie+cUeyz3auDWM1RdGUJU5wqRgrm9kqJl2WQO
	eCNHizL9rENpsgDW4UtPzjCgSnLzfPnJp7tK8oVihy7JAf7jtg5T82N9qUKlnVuG
	FPFcpjnb5OlxYF3+mtVSkFhBVnSGBpmmqI/GsAn967R8wjjXtK9FQOQUnut76wFn
	PW0KlPDut6fXdxXt/8BDVpeOMDq1llQoBBaFDwel/WfDeQBbHruoy8hsWkqPCs8s
	+4KGyg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48np7n78s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 15:07:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9DEB840050;
	Fri, 22 Aug 2025 15:06:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6BEFB71CE44;
	Fri, 22 Aug 2025 15:05:26 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 15:05:25 +0200
Message-ID: <6dc308d7-9b31-4b6d-ba68-69a91c8fcd32@foss.st.com>
Date: Fri, 22 Aug 2025 15:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] arm64: dts: st: add ltdc support on stm32mp255
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
 <20250821-drm-misc-next-v4-10-7060500f8fd3@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-10-7060500f8fd3@foss.st.com>
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

Le 21/08/2025 à 13:09, Raphael Gallais-Pou a écrit :
> Add the LTDC node for stm32mp255 SoC and handle its loopback clocks.
>
> ck_ker_ltdc has the CLK_SET_RATE_PARENT flag.  While having this flag is
> semantically correct, it for now leads to an improper setting of the
> clock rate.  The ck_ker_ltdc parent clock is the flexgen 27, which does
> not support changing rates yet.  To overcome this issue, a fixed clock
> can be used for the kernel clock.
>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 6 ++++++
>   arch/arm64/boot/dts/st/stm32mp255.dtsi | 6 ++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index 372a99d9cc5c3730e8fbeddeb6134a3b18d938b6..b44ff221e0da968be104ff8195f9bef79c90c57a 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -52,6 +52,12 @@ clk_rcbsec: clk-rcbsec {
>   			compatible = "fixed-clock";
>   			clock-frequency = <64000000>;
>   		};
> +
> +		clk_flexgen_27_fixed: clk-54000000 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <54000000>;
> +		};
>   	};
>   
>   	firmware {
> diff --git a/arch/arm64/boot/dts/st/stm32mp255.dtsi b/arch/arm64/boot/dts/st/stm32mp255.dtsi
> index f689b47c5010033120146cf1954d6624c0270045..48a95af1741c42300195b753b710e714abc60d96 100644
> --- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
> @@ -5,6 +5,12 @@
>    */
>   #include "stm32mp253.dtsi"
>   
> +&ltdc {
> +	compatible = "st,stm32mp255-ltdc";
> +	clocks = <&clk_flexgen_27_fixed>, <&rcc CK_BUS_LTDC>, <&syscfg>, <&lvds>;
> +	clock-names = "lcd", "bus", "ref", "lvds";
> +};
> +
>   &rifsc {
>   	vdec: vdec@480d0000 {
>   		compatible = "st,stm32mp25-vdec";
>

