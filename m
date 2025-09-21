Return-Path: <linux-kernel+bounces-826142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BAFB8DA23
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D39D17BF3D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD38926B97D;
	Sun, 21 Sep 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="vdj922gU"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607F25D533;
	Sun, 21 Sep 2025 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454039; cv=none; b=eQf30Y4MmIn0ArVYZ4LaWq/zF8z1M33p00KvC0rV1RU4mPn/gBzmF5IupQNfy//Eybq/OEC2mLapavi2ggyse2VSFPWvyiJGyYYpKWClKNzslMDlLRja2EDejNQZGYV21Er0aLvaUDSB6vcz1AbT1mQrYF/nZh+S/JX9mQTVVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454039; c=relaxed/simple;
	bh=uj7IBPcVgr5j3kXfBUzjwNgz92gThuVhXKzbjYk8hmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0GVzF7exwHbNr0aaEZQYOyg+zZfVj6gUm9MGrsULJiejv2saspuyg4cIMAMAvKn4exHcfRk9rh3FyX1f7zgJH2Ics8MegAW/p560S8jfiuZ8iFupHi9cBYvEB2YQmgpFFVAisp4QoBVCCRy9zXnVElrKbbynzk02FbmtBh7IOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=vdj922gU; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1758453604; bh=uj7IBPcVgr5j3kXfBUzjwNgz92gThuVhXKzbjYk8hmA=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=vdj922gU4Bwxp0+IEbQJ62HSf7JICixDFHtqgq7RMoDfAroKG5WAHcjE2dXxGcP6t
	 Vty3YA30lc1iIbjr1Q4qoLbo4uZpc7uyJQQ9RObMoQzpgzkIUl2DztucV0Fi2SjBM6
	 MELH9wXs6Y5GWO7GgJRMfxLpzSJrJiXfynhUf4t8=
Date: Sun, 21 Sep 2025 13:20:03 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: guptarud@gmail.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: rk3399-pinephone-pro: Fix voltage
 threshold for volume down key
Message-ID: <addgrqhxanzrjdhb7y7y2qrqu4odpoclbwlswuua4yqinrzh2l@wcdtuquzuqvr>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	guptarud@gmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
 <20250921-ppp_light_accel_mag_vol-down-v2-5-e6bcc6ca74ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v2-5-e6bcc6ca74ae@gmail.com>

Hi,

On Sun, Sep 21, 2025 at 01:04:23AM -0700, Rudraksha Gupta via B4 Relay wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> U-Boot and Linux use different algorithms for determining voltage ranges
> for comparison. Pick value that will work with both.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 0a4121b05d36c5a7e05eddbd3514a11ae4f7d3eb..4e6df664d780ed4798015db6b2fe79bf7c4e4c00 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -46,7 +46,7 @@ button-up {
>  		button-down {
>  			label = "Volume Down";
>  			linux,code = <KEY_VOLUMEDOWN>;
> -			press-threshold-microvolt = <600000>;
> +			press-threshold-microvolt = <400000>;

This is fixes the issue accidentally...

According to the schematic the actual threshold is 1.8V*(2/12) = 0.3V :)

  https://xff.cz/dl/tmp/f1410ee03fac4c5b.png

Linux adc-keys driver uses the "closest to the threshold voltage key wins"
algorithm.

  https://elixir.bootlin.com/linux/v6.16.8/source/drivers/input/keyboard/adc-keys.c#L32

U-Boot uses the same algorithm implemented differently:

  https://elixir.bootlin.com/u-boot/v2025.10-rc4/source/drivers/button/button-adc.c#L97

So my description in the commit message is wrong.

For the current volume up/down key voltage DT "thresholds" the actual threshold
used by the driver to determine which key will be detected will be:

  (100 + (600 - 100)/2) = 350 mV

So unless you press the key very lightly, a lot of the time adc voltage will be
below 350 mV for the Volume Down key and will be misdetected as Volume Up key
press.

Here a few volume down key presses on my PPP:

[   32.567143] volkey val 1791
[   32.671337] volkey val 1791
[   32.775266] volkey val 1791
[   32.879208] volkey val 1791
[   32.983109] volkey val 1791
[   33.086836] volkey val 1791
[   33.191116] volkey val 300
[   33.295158] volkey val 298 <-----
[   33.399351] volkey val 1791
[   33.503339] volkey val 1792
[   33.607128] volkey val 1792
[   33.711296] volkey val 1791
[   33.815307] volkey val 1791
[   33.919333] volkey val 1791
[   34.023392] volkey val 311
[   34.127329] volkey val 305
[   34.231124] volkey val 1791
[   34.335390] volkey val 1791
[   34.439303] volkey val 1791
[   34.543256] volkey val 1791

On my other Pinephone Pro it goes down even to 293 mV when the button is pressed harder.

It doesn't help that the Volume Up button threshold in DT is set incorrectly, too.
It should be 2mV and not 100mV.

So the correct fix here is to change both button thresholds to:

  Volume Down

    press-threshold-microvolt = <300000>;

  Volume Up

    press-threshold-microvolt = <2000>;

To match the schematic. Then the threshold/decision voltage will become ~150mV,
which works fine according to my tests.

Best regards,
	o.


>  		};
>  	};
>  
> 
> -- 
> 2.51.0
> 
> 

