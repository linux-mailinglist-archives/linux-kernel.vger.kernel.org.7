Return-Path: <linux-kernel+bounces-871571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 137FFC0DAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF9514FCBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B371310640;
	Mon, 27 Oct 2025 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N6vRJVha"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC9231076A;
	Mon, 27 Oct 2025 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568747; cv=none; b=ZqCAyKm+/sIwDHMZj0arAo394fOCv0yElsiHX4pGXFDpi6/Xfr0TOxOAwAMwKhxIdLuLsEV88ZN+osQS2SSsoDDLF5ocL649Mv06D7M7ZOYzXvM6T/VGbzOdg8fOj5AlToyqXlmLlFqrb0OyMkqO5ASKH9OXwUugCg7vT/72xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568747; c=relaxed/simple;
	bh=ic23nmo9lgfOG3Z3HGilbKWoY/RcEgbzf3VPutvzob4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWg/hdN/zgodKcwqrtZohpXzD9bZGxoS4DYpMGYlqC04W4pDimyhaZC/g0ovBvlF6OdnFDOsQAc0Mr5gUIgb+0yqQTRFL2p8f61yvXllx4NgMlkUQj33xW81nZMkZ3T7JeKPmySCMbo67cwrlmHfKI/Ooh3qlb6e6QZOuv0PV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N6vRJVha; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761568743;
	bh=ic23nmo9lgfOG3Z3HGilbKWoY/RcEgbzf3VPutvzob4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N6vRJVhaiEkHsez1pDm7qCVveefUoUXgEwiGf0Hxl/Jf0HRoQKn9Iz+MbCPsaNHi+
	 T5w/5RNIA0FQL4WRZ+dafcRIwodzJtXuHu1V1EWkoea7alkWmyfDnPF/00R6D4AuFo
	 qkZlGaWVPQOQVfrq85FPJtr4ARCt5g7hMvVo8vJ5aG+vokYy47F4V+SVwWQiwGBQOX
	 8LyTUKxSk9RxiOXVfCjlJaHDVz8cU/2Yx5PO0dQmI0xcKalAaieCzpcfdSWJcKIOgo
	 2l8VGGa6BttkTBLzoa4bOgekD2KXUpRrSikDo5xQrJ6MEDinPsIgiVu5DJ0KNlrP8v
	 ggOd7pxr9D1hg==
Received: from [10.40.0.100] (185-67-175-126.lampert.tv [185.67.175.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6B23017E0927;
	Mon, 27 Oct 2025 13:39:03 +0100 (CET)
Message-ID: <1499f50e-aa4f-454a-b8b5-c9a21bef7f72@collabora.com>
Date: Mon, 27 Oct 2025 13:39:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V regulator
 voltage
To: Mykola Kvach <xakep.amatop@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Cenk Uluisik <cenk.uluisik@googlemail.com>, Johan Jonker <jbx6244@gmail.com>
Cc: Jimmy Hon <honyuenkwun@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Muhammed Efe Cetin <efectn@6tel.net>
References: <20251024173830.49211-1-xakep.amatop@gmail.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20251024173830.49211-1-xakep.amatop@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mykola,

Thanks for your patch.

Cc: Muhammed who is the author of commit b6bc755d806e

On 10/24/25 19:38, Mykola Kvach wrote:
> The vcc3v3_pcie20 fixed regulator powers the PCIe device-side 3.3V
> rail for pcie2x1l2 via vpcie3v3-supply. The DTS mistakenly set its
> regulator-min/max-microvolt to 1800000. Correct both to 3300000
> to match the rail name, the PCIe/M.2 power requirement, and the
> actual hardware wiring on Orange Pi 5.
> 

I guess a "Fixes" tag is in order here:

Fixes: b6bc755d806e ("arm64: dts: rockchip: Add Orange Pi 5")

And make sure to Cc: <stable@vger.kernel.org>

> Signed-off-by: Mykola Kvach <xakep.amatop@gmail.com>

The change itself makes sense to me.

Reviewed-by: Michael Riesch <michael.riesch@collabora.com>

Best regards,
Michael

> ---
>  arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> index ad6d04793b0a..83b9b6645a1e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
> @@ -14,8 +14,8 @@ vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
>  		gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
>  		regulator-name = "vcc3v3_pcie20";
>  		regulator-boot-on;
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
>  		startup-delay-us = <50000>;
>  		vin-supply = <&vcc5v0_sys>;
>  	};


