Return-Path: <linux-kernel+bounces-781945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5108B318FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA71CC431E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817FA2FDC35;
	Fri, 22 Aug 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0Eedm75k"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CAC33DF;
	Fri, 22 Aug 2025 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868370; cv=none; b=qDlzby9XfaPa3RgA6Eu+h5gsIEajgimqKYe8DcRZSAQzC4kSG1hMIqugzTPy8ySyCt/OHXIhWS7sWkkedrtdiMWsTxogmzd3r/vZ3hRWvtGJFVZeX8dDOxO5MBAop+d04A8mopjkG3QtJtwLDIhL1Dq7JhqGzYzdLUM8WQ44osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868370; c=relaxed/simple;
	bh=q4JqQt2fVhFDOCL8SkHpfrtTrPWIgWAQ2A8aiau95Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hy7mtSJZ8IDVfb7cS+/ylJsSlTCHpo36Ab4/0bBjutfmSKtDx19V3bssVA5HJ3JPXVS9ntSzIZpuoyBCkiCkofl/Xy5bzKQf6ughARV/0eltYBrRh8WlNJmHc35EUkp3OgQj5D6BX4J7kFKCF+L3zTCOPyIICjdG6FUttA6gBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0Eedm75k; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCcqnv031363;
	Fri, 22 Aug 2025 15:12:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	GokK0EwgMtfsSNnIpttne/zzS1Pm4lLm8u+xuFpTDOc=; b=0Eedm75kc0PDSdky
	/8jqHNndow2ZEb5RGHoy9LDDl00fo7DN6SI+sP01h0hN4/eGmIohw8BY+4hnQ7TK
	QJIMF7f/QQPTc1auYlfMmDjrNgw7pa4havE+xo6jvNi3jwYsG0ssCAr+A0clIdb2
	ih4l/a8IJcuw8mIqnVosxq2OSXKWOrRHTJE5qqMyYKzZ8LsqE+K5jWHpOxP5ePeF
	FWVyfur2bVOnOYGxfybcYo7SsAj0BCWT17YbvQdJsYhdOhEmYIM1kpi9+og2Q64M
	9Rh7ilp4ZnMMZRQMnkuDw9cTbbYvHqOBde8ooYnKiZXZDD9RBwshHnxecYV+c8V2
	9ZmL8Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48nd5xs993-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 15:12:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id F380D4002D;
	Fri, 22 Aug 2025 15:11:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 415ED7206CF;
	Fri, 22 Aug 2025 15:10:19 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 15:10:18 +0200
Message-ID: <d193523c-5508-4bba-971b-8c0a8b7b44de@foss.st.com>
Date: Fri, 22 Aug 2025 15:10:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] arm64: dts: st: enable display support on
 stm32mp257f-ev1 board
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
 <20250821-drm-misc-next-v4-13-7060500f8fd3@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821-drm-misc-next-v4-13-7060500f8fd3@foss.st.com>
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
> Enable the following IPs on stm32mp257f-ev1 in order to get display:
>     * LTDC
>     * LVDS
>     * WSVGA LVDS panel (1024x600)
>     * Panel LVDS backlight as GPIO backlight
>     * ILI2511 i2c touchscreen
>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 79 ++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> index 836b1958ce65fb72c99d634a92af3efaf9844d76..2958ad413b0675575d84942e193a16f80197b88e 100644
> --- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> +++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> @@ -86,6 +86,43 @@ mm_ospi1: mm-ospi@60000000 {
>   			no-map;
>   		};
>   	};
> +
> +	panel_lvds: display {
> +		compatible = "edt,etml0700z9ndha", "panel-lvds";
> +		enable-gpios = <&gpiog 15 GPIO_ACTIVE_HIGH>;
> +		backlight = <&panel_lvds_backlight>;
> +		power-supply = <&scmi_v3v3>;
> +		status = "okay";
> +
> +		width-mm = <156>;
> +		height-mm = <92>;
> +		data-mapping = "vesa-24";
> +
> +		panel-timing {
> +			clock-frequency = <54000000>;
> +			hactive = <1024>;
> +			vactive = <600>;
> +			hfront-porch = <150>;
> +			hback-porch = <150>;
> +			hsync-len = <21>;
> +			vfront-porch = <24>;
> +			vback-porch = <24>;
> +			vsync-len = <21>;
> +		};
> +
> +		port {
> +			lvds_panel_in: endpoint {
> +				remote-endpoint = <&lvds_out0>;
> +			};
> +		};
> +	};
> +
> +	panel_lvds_backlight: backlight {
> +		compatible = "gpio-backlight";
> +		gpios = <&gpioi 5 GPIO_ACTIVE_HIGH>;
> +		default-on;
> +		status = "okay";
> +	};
>   };
>   
>   &arm_wdt {
> @@ -183,6 +220,15 @@ imx335_ep: endpoint {
>   			};
>   		};
>   	};
> +
> +	ili2511: ili2511@41 {
> +		compatible = "ilitek,ili251x";
> +		reg = <0x41>;
> +		interrupt-parent = <&gpioi>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpiog 14 GPIO_ACTIVE_LOW>;
> +		status = "okay";
> +	};
>   };
>   
>   &i2c8 {
> @@ -230,6 +276,39 @@ timer {
>   	};
>   };
>   
> +&ltdc {
> +	status = "okay";
> +
> +	port {
> +		ltdc_ep0_out: endpoint {
> +			remote-endpoint = <&lvds_in>;
> +		};
> +	};
> +};
> +
> +&lvds {
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			lvds_in: endpoint {
> +				remote-endpoint = <&ltdc_ep0_out>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			lvds_out0: endpoint {
> +				remote-endpoint = <&lvds_panel_in>;
> +			};
> +		};
> +	};
> +};
> +
>   &rtc {
>   	status = "okay";
>   };
>

