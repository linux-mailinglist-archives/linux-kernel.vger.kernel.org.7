Return-Path: <linux-kernel+bounces-747731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8583DB13767
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F377A4062
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01A23536A;
	Mon, 28 Jul 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ra9i7CST"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F822F74B;
	Mon, 28 Jul 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694384; cv=none; b=OhEQG9iizEXPbUfe8M2YDcNPUPvV3NKvff/ckrAneCTALtsDJZ2JJkoOJfvzML70enQo3FdZ5cG7JGD1X+kSsxvz1ZvAKbMFZ09ReLR/jZxBIi8vDVHoCTq25bpc3ujrnQhKiFyow+6MT4MKVnZgZzCoqx0qJdgUb3jfkmb0Xa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694384; c=relaxed/simple;
	bh=JBe/6VnvMXghy7hG0OQTodzfDN84dQ4C8ehh/E1Ui6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Pfy84LAuB/dM3w7GHsM0sjQ2l7xoThVJc19p5XPY2Kb88v242x8w1SPdU/Gu5Djwlr1z4z0RuxwutuhfljIuoDpG/ZPwpD/HTi7E7MNLEXwUdj0bFiJz46CViwqfBkEarWnmRpXObMpEmyyIchUS1z1vjNpI4x6MAuM3x+uRioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ra9i7CST; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S8jfbS023646;
	Mon, 28 Jul 2025 11:19:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/n2Y6jUtj/p2PorjZw4FleFZNqzHtoA8QQQ55mAjzHM=; b=ra9i7CSTewtW3PGz
	EVHG77biSbn99acmZdPMO6Luyd2LqgWttWTP6203xfySIexq4wRZRqdPoI87a5XP
	l18sBvBmcntaMlsA8dE/2HrpQ1nTISVpKkTKWYZfIL4H2zSuvXOp0GkF1G+S06UX
	sV8tScxIdCquuTwVi6DwcHNZ1pqxReJleky1vbh5ojubX5Ml4WV0p9hNMl9xEpIy
	72lUATwhtKv6JnGDWiwwL6IeUN7JLurheXysmn3A8AF0FQq4voIsR7FCuvqgvjT/
	5H9FFDF8kop6+gwnpHvnhmx/Djv++vi7dKBcLEADglFIsvFluV/i9LP0TZ5zB/o3
	8+KdhQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484m58y7xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 11:19:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 27ECF4002D;
	Mon, 28 Jul 2025 11:18:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1520700A0D;
	Mon, 28 Jul 2025 11:18:08 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 11:18:08 +0200
Message-ID: <09384c23-cffe-471c-95b4-82b3d34de4e7@foss.st.com>
Date: Mon, 28 Jul 2025 11:18:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: sti: rename SATA phy-names
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250713142424.41236-1-rgallaispou@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250713142424.41236-1-rgallaispou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01



On 7/13/25 16:24, Raphael Gallais-Pou wrote:
> Stick to the documentation and rename both SATA phy-names properties to
> what is expected.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  arch/arm/boot/dts/st/stih407-family.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
> index 35a55aef7f4b..3e6a0542e3ae 100644
> --- a/arch/arm/boot/dts/st/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/st/stih407-family.dtsi
> @@ -669,7 +669,7 @@ sata0: sata@9b20000 {
>  			interrupt-names = "hostc";
>  
>  			phys = <&phy_port0 PHY_TYPE_SATA>;
> -			phy-names = "ahci_phy";
> +			phy-names = "sata-phy";
>  
>  			resets = <&powerdown STIH407_SATA0_POWERDOWN>,
>  				 <&softreset STIH407_SATA0_SOFTRESET>,
> @@ -692,7 +692,7 @@ sata1: sata@9b28000 {
>  			interrupt-names = "hostc";
>  
>  			phys = <&phy_port1 PHY_TYPE_SATA>;
> -			phy-names = "ahci_phy";
> +			phy-names = "sata-phy";
>  
>  			resets = <&powerdown STIH407_SATA1_POWERDOWN>,
>  				 <&softreset STIH407_SATA1_SOFTRESET>,


Hi Raphael

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks

