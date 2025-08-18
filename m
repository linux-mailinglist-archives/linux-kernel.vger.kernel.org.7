Return-Path: <linux-kernel+bounces-773045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B942CB29ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA5B3B3DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DFD279DCE;
	Mon, 18 Aug 2025 07:27:45 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC4275B1E;
	Mon, 18 Aug 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502064; cv=none; b=LCoB7tOnWn2etXi4sBs51HPXbbFKymlX7gOU06SXN5jZimie47VDTZsb5+AgOwZWofbRgpmep6GFz8g/H57poih5BdXpFFikEa2WvrpmnUMJ8JryWKfnep/xIzPkyo60uNmqqkzjJDQXBNN1zrIqp7kuvjTjn6mVetecndgXifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502064; c=relaxed/simple;
	bh=NhIq3CKXSSEJm6cafNoGY2GRYvK8gPc1gLScvyg8Rrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXfkCpEVtiXO8NQqZTYxICgjXMRY6AR/At0G2xSzRUuwQ7hOgvLmQcIkq11JuUhjXKKfk+xa/bQs896hFe37v04rNEuWbZF2cmxguCP8WjhRN/Y5HIgb1VYcjVlNwddkdWSIVdB5DBaQuxrTh9xnrZXtpMjdAZECsLOjQpxZySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1755501983te195c171
X-QQ-Originating-IP: Ed+ORawxXpZ6NA7jhmANWyut2oLJqIWX2Q7j4Aj9hhs=
Received: from [IPV6:240f:10b:7440:1:e696:3c18 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 15:26:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17431412545650112022
Message-ID: <ABB74D9D1E3774F3+5a8c0d7d-fb7f-47c0-8308-e2b69f0628c1@radxa.com>
Date: Mon, 18 Aug 2025 16:26:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: update pinctrl names for
 Radxa E52C
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250816080030.183931-1-amadeus@jmu.edu.cn>
 <20250816080030.183931-4-amadeus@jmu.edu.cn>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250816080030.183931-4-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MKbpLBOB35npu3RU/ctuzE+hm7xbZHPJ2wwAbMbVT+X4X0iRIT8KoPyS
	Pvzm5j3MytJCZS7iYJ6WNpiNxTZ45+aMDmsoekRu1lvOeuMnsJfKJt0QhwXSZFfHLJesg6J
	a8wRVrcID52m3wa5jbefVboeaMnx/YN72hTF1Io5C9c9EGpJFTCG9JlUzZJ4lntXdUbXASj
	cqclzqvBA/kaX5PCafgbXtiXboSbrYnk2zxDuAgnQeH6CZO2likKk1zF4udFQTobijzvJiE
	iBCGynEU5t+6pLDTkw+tUKEXTQl32A4MJzZSDeRA8vONKNhYHFkTlIZ/IEzZ5JrSDy13uPV
	yU56/2s/QUwnRKYw4GxUphVkmjy9nDglG8of3DvqUuid51eYpO35sd7+EhHnzmIaO/m0YbJ
	kbQUnqUuQf+0zzGNIR4XEfcmrGSIZmhgA/+XQmoIRFALmgpHxSBso4eatJcXE05E09Bhycl
	zUulg18Qn6j7pBtA9WCijuwVpfUDIDP0RChvNjlu2Hm0Qi/HlVDqaTqimAeYPOpo3XZUHw8
	fa0i9xtXU8xBM6NW9M2GtwFdQsTcxgg48buVJGEpTmD1LLxkeih24YusB7Q7rwjZXra9ROc
	5ZNkzsFzaK4ZZJ7IYMszExdmqbLmR8COnSDEsapzRB0nKv8+ZT8lObLZNSskjcU5DtqxEad
	u+edAGZU6sK61Xnkjxy/WLhJtVhOuLpLbER6vv7eGmdXBsb3IxbcuapqXR2ZpJZouWg+Q6P
	KAam6ZTLzIYB5mvEfbNRyMpUMKD4Aly4Qt15JRl0W6RxN/13buxvM9nA5iz8vLWn8KQuCG2
	hWNYPXUEOtgmILxcady5xcTJKOMOUEGDt/9UbT7BY5A85ebNcV5M//h2KzWcyeNFTeWIRsB
	3NLLCJHGxuBSE3TeEj4voAHA5vddDsTMP4xmcQa/zlO7fPQiNEIVFpnpoWRT0XY+C5n5AIj
	HuZN07ZMMP2505AVLFw5ThiMUolpecARXI/Gt4pnZi1FhKw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi Chukun,

On 8/16/25 17:00, Chukun Pan wrote:
> Updated the pinctrl names of the user key and power LED according
> to the schematic. Also updated the nodenames of other pinctrls.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>   arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> index 4a3ae95f122f..f93b129a0032 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3582-radxa-e52c.dts
> @@ -42,7 +42,7 @@ button-0 {
>   	keys-1 {
>   		compatible = "gpio-keys";
>   		pinctrl-names = "default";
> -		pinctrl-0 = <&btn_0>;
> +		pinctrl-0 = <&pwm15_ir_m1>;
>   
>   		button-1 {
>   			label = "User";
> @@ -55,7 +55,7 @@ button-1 {
>   	leds-0 {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> -		pinctrl-0 = <&led_0>;
> +		pinctrl-0 = <&power_led>;
>   
>   		led-0 {
>   			color = <LED_COLOR_ID_GREEN>;
> @@ -306,13 +306,13 @@ &pcie2x1l2 {
>   
>   &pinctrl {
>   	keys {
> -		btn_0: button-0 {
> +		pwm15_ir_m1: pwm15-ir-m1 {

"The name of a node should be somewhat generic".

  https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst?plain=1#L193
  https://lore.kernel.org/all/20241216113052.15696-1-naoki@radxa.com/T/#u

(I don't understand why this only applies to me...)

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

>   			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};
>   
>   	leds {
> -		led_0: led-0 {
> +		power_led: power-led {
>   			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};
> @@ -328,19 +328,19 @@ pcie20x1_2_perstn_m0: pcie-2 {
>   	};
>   
>   	regulators {
> -		vcc_5v0_pwren_h: regulator-5v0-1 {
> +		vcc_5v0_pwren_h: vcc-5v0-pwren-h {
>   			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};
>   
>   	rtc {
> -		rtc_int_l: rtc-0 {
> +		rtc_int_l: rtc-int-l {
>   			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};
>   
>   	usb {
> -		usb_otg_pwren_h: regulator-5v0-0 {
> +		usb_otg_pwren_h: usb-otg-pwren-h {
>   			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
>   		};
>   	};


