Return-Path: <linux-kernel+bounces-773015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C286B29A76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AB95E64A1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF6327C162;
	Mon, 18 Aug 2025 06:58:42 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA7278772;
	Mon, 18 Aug 2025 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500322; cv=none; b=W7ZF422jMcC3ht44sKVTXXsRAEEio8zd6LF6fGHPzTNxlktwAi8we4rnXBThz/zk+oEhzy2fsP6/Z4RMF8BQ5q04Enzr12y39V0lGTDzOMMnp1Ek5FZDy+a8hJtMjfpJ/V1rq4+z8f9gcNtbYQ2i/qmMto4knkUHCRaWMLG9WXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500322; c=relaxed/simple;
	bh=ubUFzesfUYXlPF17yj2IvT/HDmVZpKMUPllKQ1ADwfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5DSUwMnRXQWQ1ipJ3fbYE5adnV+pGPUkAbgxCoI3/2rHpSG/yH/3gHvfyWTBpUpyw7Ztji5En8mpH08zcdUKTpaErUsNemP2nqXn/K12mYMPYdjcUUqgTBU6ZhdZ8tMueb1HtdCtRsNANL6KQVe6Tyae55DweQL3dOJUj46t/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1755500244t6fc68c41
X-QQ-Originating-IP: sLmbQl3vBpNZ30bWX5N0sBTYr4LYaC7/m/aS7e2wyqY=
Received: from [IPV6:240f:10b:7440:1:e696:3c18 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 14:57:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1927108559509469176
Message-ID: <BCD8E43E564BC334+1e45d36f-edc7-4c3c-90c9-7b0f2a52360f@radxa.com>
Date: Mon, 18 Aug 2025 15:57:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: rockchip: remove vcc_3v3_pmu regulator
 for Radxa E52C
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250816080030.183931-1-amadeus@jmu.edu.cn>
 <20250816080030.183931-3-amadeus@jmu.edu.cn>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250816080030.183931-3-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OBUGnm9pFasAcNPGHYEMAopgoh5OwK6sDVK9bpqjd4LE8UhdUNPQ9bKd
	Eft9UalMA+yEWVadv5T6zu8vxV885J/dFccTojhVAHOFPp4bMUXBCPSVwxd/LFYHuOK47Dk
	4Pf3qcgL8BXEGSElSYv/4M8iBjpN221bvXwzxf8nlQimUGPyLQFOc72o8jk3WWvQhwvyVJk
	N++pAcPjMhGi6EZwh8mYFVZg8yybg6OL6jAIN7DcfscMlSpCA8Qm9BAnPvA/XkZcLkrF01P
	cU83tt+n0jxG39QLqnam+jEniLdShLddKJpN7FbQ2IQRhhuJ2Ae7yC3JcwKiCT1KRbm4L1o
	55uisvFusSs0snQ/pBidg1zdinBWowBbUbTp7c8FAiQ3SQBuQYY+nIhOCmHoVoOoDd/6qgj
	UodG2CUSlHj/UxAcVPHDdRkZdBlyz6sAK4fqG9pvdQyfmyqzrqx3oUcWNhkOMSa17XUl/Hl
	tw5v+HFbDJHUDLX7y4vkfJ8KD7h3qGV82mlWgSmYDhnD+Bx433C4H/vuMDSSlCygbJcAXYS
	GnUuBjWqcKWV3RO4rzkM7+PZ/y31YoyU4/OE+PQjp36PmdLMnnYOx7ej8A6Rqy4uVBjZVju
	mm1vqI8w1mdjpQ0tpi4GE+V7+7eotK1libg4gEWWS6MPlRetQn+mA3zAeuvXFrUy+u86pYG
	g1Z8L0iK+doHUhhyvrAAPkOpsbObkDjS39ZocN/zY5mCTx9X/ryvHW6198iVAC+/Up8vsy9
	+fVElV2mut9qi7JF001tr4iGW13YAvuTWAYMrXmCX24wgwq7UfcPTNaLwbjtdyveMt+4m1X
	+TNSjx6dHnY53Sl57Uexu6tfzD9aYWezAGfdJukbeaqFefyzxG0b0yJvDyuT6aBdqJ7tFYx
	dA8bU2U7pDMLx3DkNj7CWf2L6B0DHJ3aqhVAhfZeiGRmuJPZ8iLjsey9UFpnQUc42aadKSJ
	H6FS267F7p60Ccr3jSDqVod3S4fvQq+gpNU3Ro0JRGPZmOyoQ/dCAxDiNy1xoW7jBvN4=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Hi Chukun,

On 8/16/25 17:00, Chukun Pan wrote:
> According to Radxa E52C Schematic V1.2 [1] page 5, vcc_3v3_pmu
> is directly connected to vcc_3v3_s3 via a 0 ohm resistor.
> The vcc_3v3_pmu is not a new regulator, so remove it.
> 
> [1] https://dl.radxa.com/e/e52c/hw/radxa_e52c_v1.2_schematic.pdf
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>   arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> index 1883bd183396..4a3ae95f122f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> @@ -98,16 +98,6 @@ vcc_1v1_nldo_s3: regulator-1v1 {
>   		vin-supply = <&vcc_sysin>;
>   	};
>   
> -	vcc_3v3_pmu: regulator-3v3-0 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_3v3_pmu";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc_3v3_s3>;
> -	};
> -
>   	vcc_3v3_s0: regulator-3v3-1 {
>   		compatible = "regulator-fixed";
>   		regulator-name = "vcc_3v3_s0";
> @@ -255,7 +245,7 @@ eeprom@50 {
>   		reg = <0x50>;
>   		pagesize = <16>;
>   		read-only;
> -		vcc-supply = <&vcc_3v3_pmu>;
> +		vcc-supply = <&vcc_3v3_s3>;

How about the following instead?

@@ -538,7 +538,7 @@ regulator-state-mem {
  				};
  			};

-			vcc_3v3_s3: dcdc-reg8 {
+			vcc_3v3_pmu: vcc_3v3_s3: dcdc-reg8 {
  				regulator-name = "vcc_3v3_s3";
  				regulator-always-on;
  				regulator-boot-on;

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

>   	};
>   };
>   


