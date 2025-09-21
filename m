Return-Path: <linux-kernel+bounces-826165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A04B8DB97
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028F21899941
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9382D5416;
	Sun, 21 Sep 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="ixZor4Fh"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05386342;
	Sun, 21 Sep 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758460256; cv=none; b=cftTgWf7KcbCgNmHi7Hzubcc5qOl47OYNIDD6qEi+4byxYPQZ/TjmXB1Bb/gfrvf8foG4I/TXBnt7LbyXC+KTQgVGWkxMlrez24ut6y2AaJ+/9A/JBIQWQMUd+wIA/EixCqvWNDg8Zh5vlQGU1Q5aK23W2ZHdDtUlSk6cASPfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758460256; c=relaxed/simple;
	bh=DYZxgRurBduAgF9lRk9kGZIRbd3bIwXZL3ok4oNlfF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctqb4IGEOus/WmxlczJ1YRtzuqJ32/rCAdDPYPqfxROOkMgkdp6P8hlCQjF0mn+HGiQx+rxXGxYZEHcj8IOYKhJd4KIuCp9w6UtWciijHcAzaKcCim6T5bPvCLFESVD2V1w7OSDzONk8lCW3J+JtoED5P37wAsvSVCwajE4vmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=ixZor4Fh; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1758460250; bh=DYZxgRurBduAgF9lRk9kGZIRbd3bIwXZL3ok4oNlfF4=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=ixZor4FhlbeesOOfPKrhXATito9HFzwpNtFWiEgo1XUfaBVokaylzJe5YPMb4uhXH
	 HONi/KiM4yrlFjhr0mjt51RQevFLRE0GxuSEWTrTJxEbWcJbu0TJ6+sefRsGJwwHr9
	 o55PbPJJPaIeD2ytgAibzOcv95SFR0qfYl6AIl2w=
Date: Sun, 21 Sep 2025 15:10:49 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: guptarud@gmail.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] arm64: dts: rk3399-pinephone-pro: Add
 accelerometer sensor support
Message-ID: <5b6ijumsm6bgqymsfc25frqzjlpiryq7iupuk2pokcb6d4bz56@yqrz6j3oj5ga>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	guptarud@gmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com>
 <20250921-ppp_light_accel_mag_vol-down-v2-2-e6bcc6ca74ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v2-2-e6bcc6ca74ae@gmail.com>

Hi,

On Sun, Sep 21, 2025 at 01:04:20AM -0700, Rudraksha Gupta via B4 Relay wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> Pinephone Pro uses mpu6500.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 65ee0b805034a4357a766d4f1f9efa2d4a843d77..21ff12ac5f6e52041f485c9f2702f5a15ee831f9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -544,7 +544,13 @@ mpu6500@68 {
>  		reg = <0x68>;
>  		interrupt-parent = <&gpio1>;
>  		interrupts = <RK_PC6 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vcc_1v8>;
>  		vddio-supply = <&vcc_1v8>;
> +
> +		mount-matrix =
> +			"1", "0", "0",
> +			"0", "-1", "0",
> +			"0", "0", "1";

I'm not sure where you got this patch, but it's not from me (I know for sure
I never did any mount-matrix testing/DT patches) and should not have my
Signed-of-by.

I have this in my tree https://codeberg.org/megi/linux/commit/d7cd2eab931e32fa94408a96d73b4e6c0616107a

Which is:

  Signed-of-by: Leonardo G. Trombetta <lgtrombetta@gmx.com>

And has different values on top of that and much more explanation. :)

		mount-matrix =
			"0", "1", "0",
			"-1", "0", "0",
			"0", "0", "1";

So I guess you'd need to provide a bit more information about how you
tested/verified these values, or where you've got them from.

See: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/iio/mount-matrix.txt#L93

Looking at where the magnetometer is mounted, it's mounted on the bottom side of
the PCB (U29 chip):

  https://xff.cz/dl/tmp/a0a36024d1ce9b15.png
  https://xff.cz/dl/tmp/8f9dce63f3a7f3f4.png

Which means it would face from the PCB in the direction of the display and up
towards the user who is looking at the display, due to the way PCB is mounted.

From the datasheet: https://xff.cz/dl/tmp/6b163fbe4335e58e.png the relationship
of the chip orientation to measured XYZ values.

Putting it together https://xff.cz/dl/tmp/a17eec1488ea7705.png


- Z increases downwards away from user looking at the phone display
- Y increases to the left
- X increases to the bottom of the display (towards USB-C connector)


DT bindings state:

- Magnetometers (compasses) have their world frame of reference relative to the
  geomagnetic field. The system orientation vis-a-vis the world is defined with
  respect to the local earth geomagnetic reference frame where (y) is in the
  ground plane and positive towards magnetic North, (x) is in the ground plane,
  perpendicular to the North axis and positive towards the East and (z) is
  perpendicular to the ground plane and positive upwards.

     ^^^ North: y > 0

     (---------)
     !         !
     !         !
     !         !
     !         !  >
     !         !  > North: x > 0
     ! 1  2  3 !  >
     ! 4  5  6 !
     ! 7  8  9 !
     ! *  0  # !
     (---------)

Mount matrix in your patch just flips Y axis and leaves the rest as is, so that
doesn't seem to match what bindings ask for at all.

Just based on the PCB component placement and datasheets we should have:
(small letters = DT bindings, big letters output from magnetometer)

  x = -Y
  y = -X
  z = -Z

So that gives:

		mount-matrix =
			"0", "-1", "0",
			"-1", "0", "0",
			"0", "0", "-1";

I did a quick test (rotating the phone on the table with display
facing up):

- Y is highest when right edge of the phone faces north:

  in_magn_x_raw: -3074
  in_magn_y_raw: -690
  in_magn_z_raw: -1622

  and lowest when pointing south

  in_magn_x_raw: -3569
  in_magn_y_raw: -2052
  in_magn_z_raw: -1824
 
  (X is roughly the same)

  so that matches x = Y


- X is highest when top edge of the phone faces north:

  in_magn_x_raw: -3990
  in_magn_y_raw: -1287
  in_magn_z_raw: -1677

  and lowest when facing south

  in_magn_x_raw: -2553
  in_magn_y_raw: -1314
  in_magn_z_raw: -1624

  (Y is roughly the same)

  y = X

- Z is lower when display faces up

  in_magn_x_raw: -4083
  in_magn_y_raw: -1179
  in_magn_z_raw: -2436

  and higher with display facing down

  in_magn_x_raw: -3999
  in_magn_y_raw: -1584
  in_magn_z_raw: 393

  z = -Z

So based on that mount-matrix should be:

		mount-matrix =
			"0", "1", "0",
			"1", "0", "0",
			"0", "0", "-1";

Go figure. :-D

Best regards,
	o.


>  	};
>  };
>  
> 
> -- 
> 2.51.0
> 
> 

