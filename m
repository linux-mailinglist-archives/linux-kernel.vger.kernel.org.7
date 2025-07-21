Return-Path: <linux-kernel+bounces-739397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC38FB0C5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102EA189303E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FE62D9ED3;
	Mon, 21 Jul 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="obiR0xeW"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961229CB45;
	Mon, 21 Jul 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106857; cv=none; b=KG5aobEt62Ps4G7o24TtwUeKhKp+B+Ppga+8eSmGvZK6gIK5WV6B/mmS3T/KtlkI+Yrhg0CM3qSFgboV/15n/qZlXfBfb6uVgKoLI8JtRMlVw9CZYFrP/N01dVxRE9mxAvFVD3jY8/Fd/ayB9JyM2K2/F1pNvX6rWK+r+k3aOXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106857; c=relaxed/simple;
	bh=RCoAC62sIF375dvK8CczQIxI3oZZHMnsTp+yqvHmY+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sMj3VC4r7qBAz0fVhYwQ45XG3V+OQKPdw4uuUyGbMJbotDKY8UwGwX9D+7eyQWN59EbiK90kvHi59QY/ml/R+V9qSI6suOVyqkauHaeYTkKqPl3+QLJnYQ+6639Ktvz1CbzHMiZeE60PTrj8zjjXvoXCiAqYykaebP53m9ZA8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=obiR0xeW; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56LE7E4X1272907;
	Mon, 21 Jul 2025 09:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753106834;
	bh=soVyBj6MPIY1VOaKT/v86ILGRdMXLp+19Ble5d58VLs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=obiR0xeWBf2p9hVCANQNLf3a+0T/HXSfHfsXNYzwycV/IKWc4nJhiZ/QmgZSUCLh5
	 qRF4HVPAnb1UKRg8fwWiKPFgYvM830GfBur75wkXBwq+3FgFB1fcYC8JN8dkHCEM+d
	 fx19WT+oMxLKuchJUwLdmJIfU3AMRIG1FKeGJ/dY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56LE7E6w921270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 21 Jul 2025 09:07:14 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 21
 Jul 2025 09:07:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 21 Jul 2025 09:07:14 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56LE7AAR3643505;
	Mon, 21 Jul 2025 09:07:10 -0500
Message-ID: <72545187-4605-40bb-9c68-54670c2e5332@ti.com>
Date: Mon, 21 Jul 2025 19:37:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: ti: k3-j721s2-main: Add interrupts
 property
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
 <20250714092708.3944641-2-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250714092708.3944641-2-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 7/14/2025 2:57 PM, Yemike Abhilash Chandra wrote:
> Add interrupts property for CDNS CSI2RX. Interrupt IDs are taken from the
> J721S2 TRM [0].
>
> Interrupt Line      | Source Interrupt
> --------------------|----------------------------
> GIC500SS_SPI_IN_153 | CSI_RX_IF1_CSI_ERR_IRQ_0
> GIC500SS_SPI_IN_152 | CSI_RX_IF1_CSI_IRQ_0
> GIC500SS_SPI_IN_157 | CSI_RX_IF2_CSI_ERR_IRQ_0
> GIC500SS_SPI_IN_156 | CSI_RX_IF2_CSI_IRQ_0
>
> [0]: https://www.ti.com/lit/zip/spruj28
>
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 62f45377a2c9..6f32a2b0c40c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -1248,6 +1248,9 @@ ti_csi2rx0: ticsi2rx@4500000 {
>   		cdns_csi2rx0: csi-bridge@4504000 {
>   			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>   			reg = <0x00 0x04504000 0x00 0x1000>;
> +			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;

Just cosmetic thing, if you are doing v2 then consider 152 first , 
followed by 153.

Otherwise

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> +			interrupt-names = "error_irq", "irq";
>   			clocks = <&k3_clks 38 3>, <&k3_clks 38 1>, <&k3_clks 38 3>,
>   				<&k3_clks 38 3>, <&k3_clks 38 4>, <&k3_clks 38 4>;
>   			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
> @@ -1301,6 +1304,9 @@ ti_csi2rx1: ticsi2rx@4510000 {
>   		cdns_csi2rx1: csi-bridge@4514000 {
>   			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
>   			reg = <0x00 0x04514000 0x00 0x1000>;
> +			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "error_irq", "irq";
>   			clocks = <&k3_clks 39 3>, <&k3_clks 39 1>, <&k3_clks 39 3>,
>   				<&k3_clks 39 3>, <&k3_clks 39 4>, <&k3_clks 39 4>;
>   			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",

