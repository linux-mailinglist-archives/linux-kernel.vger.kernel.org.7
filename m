Return-Path: <linux-kernel+bounces-761799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0426B1FE91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649DF3A5E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C252309BE;
	Mon, 11 Aug 2025 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yFHpeB+u"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275610F2;
	Mon, 11 Aug 2025 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890262; cv=none; b=fyqaxwsqyhSqDV9q0i2lVsLdNMzqGhkGv1/XJ5zbSCCFHB48rj2Me7KtxmWgGmJlu1NXUIfc56TnnK8we+PQD/TcFARjd2NaJGG9jSl612mvC7nHmWkVMgQiOLWIxEJqibcYN0p6FlKO6g+oAYdC5kA6QoMVzSooOhB+ruvw93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890262; c=relaxed/simple;
	bh=P0V2H2NxxF0Ozi8NOvSbx3x81S67gE8h723lHlm1Nws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RKdAy+m8rQ+UZPgfVfaQYKo2w/mp134BNqxXYVL5tonUjZE/0+PPclzQmxKHyssgkxwBKIzICF898YMuN3YmCUb5DphtXTySdqDYX/pJmIYzPJ3zG7LASKDEZ+nH88EjXDSOrEbuIjYwngRjTpmHI9wuQzwgWqx6//2le2d9hak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yFHpeB+u; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57B5UjKe1036119;
	Mon, 11 Aug 2025 00:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754890245;
	bh=qGaUrxnPupGN/G94QupN7sqi/0EBTqM+/xSQq20HIj4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yFHpeB+ucmTh/ltorX1Mz72rh6S2cswshu3GSv3iMBWiypkMidCgpzm+ZToswAwS/
	 N9XM9eELfg7Mku8oh5m+8XokVnqR66d0lDRWZC5ox939jiCBLIxHGHrDd3ajFMGo+y
	 8ehi3gMjla23FWoSfBtHCrkVU9nkjxk/TJMgLHgs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57B5Uj0B2434724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 11 Aug 2025 00:30:45 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 11
 Aug 2025 00:30:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 11 Aug 2025 00:30:45 -0500
Received: from [10.249.145.16] ([10.249.145.16])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57B5Ueij2636883;
	Mon, 11 Aug 2025 00:30:41 -0500
Message-ID: <be073100-31a0-44a9-8837-8c0adaf1c0ff@ti.com>
Date: Mon, 11 Aug 2025 11:00:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder
To: Brandon Brnich <b-brnich@ti.com>, <linux-kernel@vger.kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Udit
 Kumar <u-kumar1@ti.com>, Darren Etheridge <detheridge@ti.com>
References: <20250808155555.2632451-1-b-brnich@ti.com>
Content-Language: en-US
From: devarsh <devarsht@ti.com>
In-Reply-To: <20250808155555.2632451-1-b-brnich@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 08/08/25 21:25, Brandon Brnich wrote:
> This adds node for E5010 JPEG Encoder which is a stateful JPEG Encoder
> present in J722s SoC, supporting baseline encoding of semiplanar based
> YUV420 and YUV422 raw video formats to JPEG encoding, with resolutions
> supported from 64x64 to 8kx8k.
> 
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
> 
> Changes in v3:
>   - Add TI compatible
>   - Make node name more generic
> 
> Changes in v2:
>   - remove invalid clock-names attribute
> 
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 5cfa7bf36641..c0a104bc87ad 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -385,6 +385,16 @@ c7x_1: dsp@7e200000 {
>  		ti,sci-proc-ids = <0x31 0xff>;
>  		status = "disabled";
>  	};
> +
> +	e5010: jpeg-encoder@fd20000 {
> +		compatible = "ti,am62a-jpeg-enc", "img,e5010-jpeg-enc";
> +		reg = <0x00 0xfd20000 0x00 0x100>,
> +		      <0x00 0xfd20200 0x00 0x200>;
> +		reg-names = "core","mmu";
> +		clocks = <&k3_clks 201 0>;
> +		power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
> +		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +	};
>  };
>  
>  &main_bcdma_csi {


