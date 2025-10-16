Return-Path: <linux-kernel+bounces-856727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAC6BE4EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F641A64F99
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FAC219319;
	Thu, 16 Oct 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CzDioRcW"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58145334697;
	Thu, 16 Oct 2025 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637233; cv=none; b=X9a5l0ouBLITMt+JV30RJzesQY5qexV4rthleWcTiesAXsuKSkoeYDaqQkxP5RywatiVLDFJIXFRzVDyFzaQb4b+qkHvSKl9BQKurUHBk8DBhFXDaoQgw6RQI283Ssu44TlbFjsGmOtxJviVfvfB8nL3fXJjiu250wrVmfGWq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637233; c=relaxed/simple;
	bh=ldfU5rZuAZcdwlXh2Mdw6hcz2lImjwOUiMhhILNgeNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BPscvq8+WTUHhrYILMXDqoqIfSnoYesU5HO+HsYwwlWg91q01Ham94NAf2UI8biXEZgd4Ye5ej+G7/frQDnoYIcOqIOCrVxMzyHKOpmDpW0VC0BIlZq6Axf+NKrBgLo/HoPTVyySjsZ1gjKY2SSaVOYKt3sIBepjQgl/Yzr04F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CzDioRcW; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59GHraPw071442;
	Thu, 16 Oct 2025 12:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760637216;
	bh=rTUmVCjZwM7PQPWvSKdDMN6x4dpJeSnKTI7jgtFLTK4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CzDioRcWcP0GJuH1NJhcuSw/ZX0N0Sg3REZFvgB5AlpguzXTaL+wgUnRxNB49xgTQ
	 E6+77nybuWBm9PSVeaJdXIh7LgTlJOWVAGDa6nTomEYccJSo/GcEoN3uPVhzwSj1i8
	 ZrZfs7XvTslyYMrAx/vJaT6V4F09942lEy6lFeko=
Received: from DLEE212.ent.ti.com (dlee212.ent.ti.com [157.170.170.114])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59GHraTY1792417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Oct 2025 12:53:36 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 12:53:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 12:53:36 -0500
Received: from [128.247.29.251] (dmz007xyy.dhcp.ti.com [128.247.29.251])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59GHraWQ4129879;
	Thu, 16 Oct 2025 12:53:36 -0500
Message-ID: <19b16368-9ec8-40d8-9389-1dc48f28dd2a@ti.com>
Date: Thu, 16 Oct 2025 12:53:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62d2-evm: Fix regulator properties
To: Paresh Bhagat <p-bhagat@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>
References: <20250916090736.2299127-1-p-bhagat@ti.com>
Content-Language: en-US
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Organization: PMIC
In-Reply-To: <20250916090736.2299127-1-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Paresh,

On 9/16/25 4:07 AM, Paresh Bhagat wrote:
> Fix missing supply for regulators TLV7103318QDSERQ1 and TPS22918DBVR.
> Correct padconfig and gpio for TLV7103318QDSERQ1.
>
> Reference Docs
> Datasheet - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf
> Schematics - https://www.ti.com/lit/zip/sprcal5
>
> Fixes: 1544bca2f188e ("arm64: dts: ti: Add support for AM62D2-EVM")
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>
> Boot logs
> https://gist.github.com/paresh-bhagat12/9a4a1aec5119ceedb386743921432c91

Reviewed-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>

>
> Tag used
> next-20250915
>
>   arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> index 83af889e790a..d202484eec3f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> @@ -146,6 +146,7 @@ vdd_mmc1: regulator-4 {
>   		regulator-name = "vdd_mmc1";
>   		regulator-min-microvolt = <3300000>;
>   		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_3v3_sys>;
>   		regulator-boot-on;
>   		enable-active-high;
>   		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
> @@ -165,14 +166,16 @@ vcc_3v3_sys: regulator-5 {
>   	};
>   
>   	vddshv_sdio: regulator-6 {
> +		/* output of TLV7103318QDSERQ1 */
>   		compatible = "regulator-gpio";
>   		regulator-name = "vddshv_sdio";
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&vddshv_sdio_pins_default>;
>   		regulator-min-microvolt = <1800000>;
>   		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_5v0>;
>   		regulator-boot-on;
> -		gpios = <&main_gpio1 31 GPIO_ACTIVE_HIGH>;
> +		gpios = <&main_gpio0 59 GPIO_ACTIVE_HIGH>;
>   		states = <1800000 0x0>,
>   			 <3300000 0x1>;
>   		bootph-all;
> @@ -334,7 +337,7 @@ AM62DX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
>   
>   	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
>   		pinctrl-single,pins = <
> -			AM62DX_IOPAD(0x1f4, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO1_31 */
> +			AM62DX_IOPAD(0x00f0, PIN_INPUT, 7) /* (Y21) GPIO0_59 */
>   		>;
>   		bootph-all;
>   	};

-- 
Best,
Shree Ramamoorthy
PMIC Software Engineer



