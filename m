Return-Path: <linux-kernel+bounces-806741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B45B49B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1DB4E3D65
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED5C2DAFB4;
	Mon,  8 Sep 2025 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pGvmfmPI"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9E22A4EA;
	Mon,  8 Sep 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364309; cv=none; b=tc1wExLEJBwRYelbNmgHYkiLCTFNAcp6ni70MZjZjeNQK1tkKP6eT/3T9UYT73ao3eIS1+cFTRC7Nwe6XznvvH9jHWW0M0g2ZMCEmAJFjUzwGZVFs9pzRay30zkVZ+t8fDpOlDMParX8M2NISwS/UcWoM6+jHS//ys6tx9D+oT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364309; c=relaxed/simple;
	bh=CM+2NiNhrj9cQIvYlB28zmILhm1Icycdkb2nt8kQ+Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gjmls43m68yoLlMKhoMwBZ/awnLOLACrPyycHfL7dBm1PALZYR1BmTKyurEb84XgeKMot4tyDFXsg3MWU8k9nKZlavSva4YnSrjBTUp8U7/7exQHU200vdjAcFtR/C2GTgMnjzrQ2n3AOA4QZXs/Uw9l212QGMRyADb7+5p5Gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pGvmfmPI; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588Kis44131929;
	Mon, 8 Sep 2025 15:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757364294;
	bh=75t8gUXqDkMVSTXxQWJbT39KD1G/2RxpZCQY37fgf94=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pGvmfmPIExQEr+k8ySt//Eut7ANLX5mntUXxQiVgtWdWcYahiiB7r4MtnJ32ElbWl
	 xr6CZMbMxQi+k60/Oiue3wr8MWLAZ78DhLSOFGa5hMjEZZgPfWC+3XNeHzPJdKfzRe
	 v4ETJ55gON2vVAVre06KaHBRrQekJlrI+cPIeUxA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588KisMi3260231
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 15:44:54 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 15:44:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 15:44:53 -0500
Received: from [10.247.30.162] (ula0226330.dhcp.ti.com [10.247.30.162])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588Kirlu1191331;
	Mon, 8 Sep 2025 15:44:53 -0500
Message-ID: <363878df-528b-4959-945f-3b531f156679@ti.com>
Date: Mon, 8 Sep 2025 15:44:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am62p/j722s: Remove HS400
 support from common
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250908173831.269039-1-jm@ti.com>
 <20250908173831.269039-2-jm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250908173831.269039-2-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/8/25 12:38 PM, Judith Mendez wrote:
> Since eMMC HS400 has been descoped for J722s due to errata i2478 [0]
> and is supported for AM62Px device, remove eMMC HS400 support from
> common-main.dtsi and include only in am62p-main.dtsi.
> 
> [0] https://www.ti.com/lit/pdf/sprz575
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ---
>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi              | 6 ++++++
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> index 4427b12058a6..0c05bcf1d776 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> @@ -576,15 +576,12 @@ sdhci0: mmc@fa10000 {
>   		bus-width = <8>;
>   		mmc-ddr-1_8v;
>   		mmc-hs200-1_8v;
> -		mmc-hs400-1_8v;
>   		ti,clkbuf-sel = <0x7>;
> -		ti,strobe-sel = <0x77>;
>   		ti,trm-icp = <0x8>;
>   		ti,otap-del-sel-legacy = <0x1>;
>   		ti,otap-del-sel-mmc-hs = <0x1>;
>   		ti,otap-del-sel-ddr52 = <0x6>;
>   		ti,otap-del-sel-hs200 = <0x8>;
> -		ti,otap-del-sel-hs400 = <0x5>;
>   		ti,itap-del-sel-legacy = <0x10>;
>   		ti,itap-del-sel-mmc-hs = <0xa>;
>   		ti,itap-del-sel-ddr52 = <0x3>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 6aea9d3f134e..90afe21e972b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -31,6 +31,12 @@ usb1: usb@31100000 {
>   			snps,usb2-lpm-disable;
>   		};
>   	};
> +
> +	sdhci0: mmc@fa10000 {

The node already has a label where it is defined, so you could just use:

&sdhci0 {
    ...

here at the base level, and not have it inside cbass_main.

Andrew

> +		mmc-hs400-1_8v;
> +		ti,strobe-sel = <0x77>;
> +		ti,otap-del-sel-hs400 = <0x5>;
> +	};
>   };
>   
>   &oc_sram {


