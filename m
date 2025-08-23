Return-Path: <linux-kernel+bounces-783077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73ECB3291D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D609B1699C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C511E0E14;
	Sat, 23 Aug 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="pb4FEzOe"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F221ADC7E;
	Sat, 23 Aug 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959037; cv=none; b=T7LEQ3dfVWu3hJx5ErJDcE6tM57datWqser7toYh4v6WeobDuSVkZrPjCSHaW99Xbcyw2Wun372kThEeXkVzsZXair9tn0V1tIVEhqLT9fQ+7bnk7B+QCY/OOjmEwHeCafIQDUsgJrWzJ8d0p4xAiXZ55KdvNVF4KZ7VHVkxERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959037; c=relaxed/simple;
	bh=R34OGeCiu/IPda8je9GL6U6dsszdH++pAXr6iT4gB6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urJ/RDuQ95G5EeiCInk8ONAi9+25kaiwURvBS6V2MV1fhxGa0nh+N6eHSnuYyNK+hNtUG64BMmxerX+mDbQ2Ka7XLlIm7d2Ef0eeCYQc3ndVGv2tm5AFu5pEthDQ2VY0mfILxX0T/PipwrU8PIt0Uz82YzyIpzk05jPogUOu1Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=pb4FEzOe; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1755959033; bh=R34OGeCiu/IPda8je9GL6U6dsszdH++pAXr6iT4gB6Y=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=pb4FEzOeilNegfspE7/aewKwoiawHbo+Rf4DUXKz6hPTbgJ5iP5IvIsBtQlva0cP4
	 BEklA73ynyazlNcuhkeeoh/HA0zAP+HAOkkqtDHDygeE/68qm/xSQI/4qKXJaM0g97
	 MIjPIl1kOMgfbtfndoKDGtlxVpcHR3FtHBmlN8ro=
Date: Sat, 23 Aug 2025 16:23:52 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: maud_spierings@hotmail.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Enable HDMI receiver on
 orangepi 5 plus
Message-ID: <wc4mcm5nywfrzafexagun4kaw3hzb3avtunh4idg22ctuz6r2h@xjgqo6ihiyey>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	maud_spierings@hotmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
 <20250823-orangepi5-v1-2-ae77dd0e06d7@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250823-orangepi5-v1-2-ae77dd0e06d7@hotmail.com>

On Sat, Aug 23, 2025 at 02:43:51PM +0200, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> Enable support for the HDMI input port found on the orangepi 5 plus.
> 
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>

Reviewed-by: Ondřej Jirman <megi@xff.cz>

Thank you,
	o.

> ---
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index 8222f1fae8fadc5cbb4ef16b3db5ed975ed43915..9950d1147e129dc866cfde62ddd636b082ae1926 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -160,6 +160,17 @@ &hdmi1_sound {
>  	status = "okay";
>  };
>  
> +&hdmi_receiver_cma {
> +	status = "okay";
> +};
> +
> +&hdmi_receiver {
> +	hpd-gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
> +	pinctrl-0 = <&hdmim1_rx_cec &hdmim1_rx_hpdin &hdmim1_rx_scl &hdmim1_rx_sda &hdmirx_hpd>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &hdptxphy0 {
>  	status = "okay";
>  };
> @@ -279,6 +290,12 @@ blue_led_pin: blue-led {
>  		};
>  	};
>  
> +	hdmirx {
> +		hdmirx_hpd: hdmirx-5v-detection {
> +			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>  	ir-receiver {
>  		ir_receiver_pin: ir-receiver-pin {
>  			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> 
> -- 
> 2.50.1
> 
> 

