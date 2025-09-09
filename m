Return-Path: <linux-kernel+bounces-807226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90B6B4A1CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B761B27623
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9E52FE598;
	Tue,  9 Sep 2025 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eul3I6/3"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745A1A262A;
	Tue,  9 Sep 2025 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398041; cv=none; b=DNRfyRBZKyR24RJPM90EQmnG41v7YFldqIBlQ9exTtGjUnSRNuPKUyNR2Ul525EfRUEeTKnOj72pKz/WxgUfvtOqKGxVitv0dMaNDoYHBd3Jq6/p1+CG49UQQNsuQXSWofP4RXUWarb4ePmsmXYFHi5959VeMKGlhcCVu5Bb/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398041; c=relaxed/simple;
	bh=yQYB6tSzoM/2rg3u/ZJ/YWLsBv0NJOUt2NRXgu/Hoo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r7xODkb0FBVnz6FJro2QSCWMvgijYjsi1HUx4HHxZmmH8yU0OJPB9iUItJtwrvJBKnJWkVD+kro9qAG4bBd/ooMxsw1fu407JRzcUSyaMht34lpQ5BYiXK/9AhC1rsPAgmjkL1TE3B6NXx2vJ1aT0mzyZ/1xcKRgZJ2kgAKlWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eul3I6/3; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5896758U3959728;
	Tue, 9 Sep 2025 01:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757398025;
	bh=zuFLBnhVlG9Xe0rzmQ2aQ8puxTjfyso14EEKYx0T/lQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=eul3I6/3uBR2bsColcBThyV824YZxzZhC6yvqUfw6QU6V/swPN1gDl6Xb78ti+UwV
	 rViCSO9WQngKkou0AtcHBLr2dDAieLBiKGmqDZ/W2ypskC1C6oz7X1DZcPyAoqeMrU
	 9vjJX0tnQk6IobTih9eCUt9BJ7laV9ebrudm6Hls=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5896759i3563479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 01:07:05 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 01:07:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 01:07:05 -0500
Received: from [10.24.72.162] (moteen-ubuntu-desk.dhcp.ti.com [10.24.72.162])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589671DH1840294;
	Tue, 9 Sep 2025 01:07:02 -0500
Message-ID: <c4de581a-906c-4f0f-a881-6725f27499e6@ti.com>
Date: Tue, 9 Sep 2025 11:37:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-am62p/j722s: Remove HS400
 support from common
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Andrew Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>
References: <20250908235207.473628-1-jm@ti.com>
 <20250908235207.473628-2-jm@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20250908235207.473628-2-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 09/09/25 05:22, Judith Mendez wrote:
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
> index 6aea9d3f134e..020bd121a6a3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -74,3 +74,9 @@ &main_gpio1 {
>   	gpio-reserved-ranges = <32 10>;
>   	ti,ngpio = <52>;
>   };
> +
> +&sdhci0 {
> +	mmc-hs400-1_8v;
> +	ti,strobe-sel = <0x77>;
> +	ti,otap-del-sel-hs400 = <0x5>;
> +};

Reviewed-by: Moteen Shah <m-shah@ti.com>

Regards,
Moteen

