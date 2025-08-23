Return-Path: <linux-kernel+bounces-783054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6403B328D2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C2A7B7D66
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8B4239E7D;
	Sat, 23 Aug 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="oj1ZnTEf"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758C111BF;
	Sat, 23 Aug 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956339; cv=none; b=ID4vXfVv+TEonE5yhJmheTcbYdZynp87EaBlgvrvmLsytLzgYSnJJob2kXDHp6jOHPptDNYKzp8N+c+YGcvW98bfmqkybQyJ8AFiC8UMfTugQjl8o5/I3HD0u+K/d2qHQkDZCE4kLUuJB3ksQodmBm1ny3yCgwY0mNUCYBjceDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956339; c=relaxed/simple;
	bh=xD2qXS1OqnfB4ixy8P2YWslAr2PFZXWLVpd7ffyzsoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+KSaSkTwi2yUCvAxctzJ3S3Ofe3c61tQMfnsT0S9rtCSwJZiYF8QB9NqhSwR061r711cC5gz5eo0hbB8SmW6lFvfLgAOKoSAwVo2o0tiCdisMINTSGwYcqYECjio2iqeyCam8ixjSy8yVUDI6lNTjjmy7ibqhxxFwLpPT+xy5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=oj1ZnTEf; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1755955885; bh=xD2qXS1OqnfB4ixy8P2YWslAr2PFZXWLVpd7ffyzsoE=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=oj1ZnTEfJLanuyfTM903xQPlU1Q1ZxAOk61DCfYlJ81rLe+UCgVorD+rNBM0WSbY3
	 iCFG1hYq5ahEN1wheZwwBpTatA1fO5PoMtm6H5MiTM7rYTIZ3hUd2KxN27T02sSdz0
	 4KrouToU9aj5/NKGP7IQl9VzsD7SrnuR08gHdHA8=
Date: Sat, 23 Aug 2025 15:31:24 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: maud_spierings@hotmail.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Fix the headphone detection on
 the orangepi 5 plus
Message-ID: <q47mi7iyx4nu3tkrtsjrghlultm3kj4zz73uekffalm2vwjck7@btiiymy6fohy>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	maud_spierings@hotmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
 <20250823-orangepi5-v1-1-ae77dd0e06d7@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250823-orangepi5-v1-1-ae77dd0e06d7@hotmail.com>

Hello Maud,

On Sat, Aug 23, 2025 at 02:43:50PM +0200, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> The logic of the headphone detect pin seems to be inverted, with this
> change headphones actually output sound when plugged in.
> 
> Verified by checking /sys/kernel/debug/gpio and by listening.

This can also be tested by:

  evtest /dev/input/by-path/platform-sound-event

Which shows inverted output without this patch.

Reviewed-by: Ondřej Jirman <megi@xff.cz>


> Fixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5-plus")
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---
> There was a big change at some point so it will take some effor to port
> it back that far.
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index 121e4d1c3fa5dab0d08edf7cba692a765b48f7b4..8222f1fae8fadc5cbb4ef16b3db5ed975ed43915 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -77,7 +77,7 @@ &analog_sound {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&hp_detect>;
>  	simple-audio-card,aux-devs = <&speaker_amp>, <&headphone_amp>;
> -	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_LOW>;
> +	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_HIGH>;
>  	simple-audio-card,widgets =
>  		"Microphone", "Onboard Microphone",
>  		"Microphone", "Microphone Jack",
> 
> -- 
> 2.50.1
> 
> 

