Return-Path: <linux-kernel+bounces-781943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F936B318F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2603F1D22EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB30139E;
	Fri, 22 Aug 2025 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sm++KblT"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A042FD1BE;
	Fri, 22 Aug 2025 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868287; cv=none; b=O1MrsLx6R0G0waJGWNzGIJ/zbRvt4RVwOXu4vikWVuqsP3ZyjUfW/Vt03bRlHGxMl0WWCXiCeBZ0ZiuzdvvKX1yoVuhf7f7s3cjwhWzuRFrfXPipBeN3c4+kk6rsqu6M0gILKJxqfJ53tVE6XC3eRbvBUIGiaKlH6GCkRSysF6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868287; c=relaxed/simple;
	bh=6zRVdF0GRGrlhVEsPy08ofm/C5L5xuR1ZqGaSeUPfFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BYgW2ADupr2zyPGqnKIVOlNktFIUSmmOcHt6ARxZtzxF8u1UsegWfS+Glzoh/sCHoMTaGMqQK0iwni7PiKwvH48O2TAm8K7Qs5lpsLleNg6J6lhIENQPfso13145M4FeYQd98PDSaIIjUyxbmSRtdyxir0r6TAjAChEMtUGAlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sm++KblT; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCCaeX015941;
	Fri, 22 Aug 2025 15:11:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	B4pYdqJuAzYUBYGLZvAHsnWM97Hp3xHmy6gGSOZhTl0=; b=sm++KblT0vJdhu/X
	xpsgsy8lD9wXrhreSVLSBAtXvdBHIfmWKkBS1wuwTe/6PWel5AzEmcLpZMJOAqIP
	lkY1KdnfrzieOgZ09ggEIaWPSdc+TyLimjZjQOq51CN0mfaRzSVtCo+0mE0jB2Xs
	F1bAPglIEIb8MCDtEsyc0DhTZpbtvPvRhb8f+D7jOUS7uF4FwBnaTbXfF8GVt624
	EMgwNxTea9UynQvLx1X+5dfZJmfOfAaahFe3JHRvnAv1mU5Es9shzQdG9LEXMDLh
	Rd789ZhVXr9hQFyCZLJfnHZvj1gmlEH/8blMCP4z+P8JF2lnGlS2RG3jTUT+qBDZ
	uX+evw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n70dk7g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 15:11:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5460840050;
	Fri, 22 Aug 2025 15:09:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 975616CA48F;
	Fri, 22 Aug 2025 15:08:58 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 15:08:57 +0200
Message-ID: <44b7b47d-a42c-499d-a760-f34d2740ff8c@foss.st.com>
Date: Fri, 22 Aug 2025 15:08:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] arm64: dts: st: add lvds support on stm32mp255
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
 <20250821-drm-misc-next-v4-11-7060500f8fd3@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-11-7060500f8fd3@foss.st.com>
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
> The LVDS is used on STM32MP2 as a display interface.
>
> Add the LVDS node.
>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp255.dtsi | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/st/stm32mp255.dtsi b/arch/arm64/boot/dts/st/stm32mp255.dtsi
> index 48a95af1741c42300195b753b710e714abc60d96..433a0aabe72e5a449ec03fb984a8684c5d5d75a2 100644
> --- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
> @@ -12,6 +12,18 @@ &ltdc {
>   };
>   
>   &rifsc {
> +	lvds: lvds@48060000 {
> +		compatible = "st,stm32mp255-lvds", "st,stm32mp25-lvds";
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
> @@ -28,4 +40,4 @@ venc: venc@480e0000 {
>   		clocks = <&rcc CK_BUS_VENC>;
>   		access-controllers = <&rifsc 90>;
>   	};
> -};
> \ No newline at end of file
> +};
>

