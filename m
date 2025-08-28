Return-Path: <linux-kernel+bounces-789885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B167FB39C28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADE8189E0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A918730F922;
	Thu, 28 Aug 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dXfse24o"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919F30F54D;
	Thu, 28 Aug 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382700; cv=none; b=GFfwaDO6Z7HAaKXNyocGXcNem48Sn6bwokQjN0SrGP2cYUThXR5Nc1bpDTTm8LYTRWVikhTSgfcoWBCHjsamlfopl8VK/5QmJqw6FNHjsey7WFFtRw4QWdAfc76Wygy2LUFKbkxiTyZHGLNGJc4kootcD0jCRzguODsnEqbGidM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382700; c=relaxed/simple;
	bh=hui+EEJxD/vnvKdapGOPLoICemUL0PTzMfP7GQy58oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dL+2JyGaS/BdnpLZfaaJ4I088fwj1SgJ/SoEMB94Juy3kYFYe391w0bPLJC9IPcksG+hE0W3lFY3y6ZnnTkZKmJw3lF14xtQ1mrRrbW6G+q/qDH05EgmuF4TC8U8O3msdxWGbf89PqigxnP/kiHcazDR7JymzesRgmoBhfy9B1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dXfse24o; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=vPdymbaCqau+yaCWSCW4KLmPAF+HpjkM+g2fCUR5lNY=; b=dXfse24ojcLjDHCLcShxSynjgY
	N3lUpTszTBimpfq/1btLaJ5GmD2APYQLHOXc4DgzbEXb/MrcIWlyZKL4lIS5mG2MbF9glnlRmfRhT
	me0SSegWwB5BxdHbpsmlFCgvJy4VgoZkLTtUjvjksXVm1Y5lpTDUhCqGkrtdFHe3gcKFAoCpOFIJB
	764/UBax1SXtRp8cspT1503G4cSGfPKToIyaS7joNn/ldwsScvHDynbipeCcaulw9057Sxg6kDz1q
	h+pciZ0fW0BLrTeIMjqZoALd147RFdPQjJFZhWNZCYLVAIUIAbdZM+Dcpq+pna1EeX7feXmYmg3ih
	kyFo7bBQ==;
Received: from [185.205.242.134] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urbMy-0005X1-Ex; Thu, 28 Aug 2025 14:04:44 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hide Hako <opi5plus@bcc.bai.ne.jp>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, Hide Hako <opi5plus@bcc.bai.ne.jp>
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Enables sound output from the audio jack
 on OrangePI5 Plus
Date: Thu, 28 Aug 2025 14:04:43 +0200
Message-ID: <9820114.4vTCxPXJkl@phil>
In-Reply-To: <20250826134456.9636-2-opi5plus@bcc.bai.ne.jp>
References: <20250826134456.9636-2-opi5plus@bcc.bai.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Hide Hako,

Am Dienstag, 26. August 2025, 15:44:57 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Hide Hako:
> Currently, analog sound is not output from the audio jack.
> This patch allows you to select analog headphones in alsamixer.
> Works with kernel 6.16.1, but not 6.17-rc1.
>=20
> Points of concern:
> 6.16.1 kernel with ubuntu 25.04 Setting -> Sound -> Output Device
>  I select Speakers Built-in Audio, the sound will be output from the audi=
o jack.
>=20
> Changes since v1:
> - As pointed out by Jimmy, the file to be modified has been changed
>   from rk3588-orangepi-5.dtsi to rk3588-orangepi-5-plus.dts.

All of what Maud said, but also I think this deserves some

=46ixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for rk3=
588-orangepi-5-plus")

tag + could do the subject as=20
  "arm64: dts: rockchip: Fix sound output from the audio jack on OrangePI5 =
Plus"

because this really sounds like it fixes functionality to is supposed
to be working :-)


Thanks a lot
Heiko

> Signed-off-by: Hide Hako <opi5plus@bcc.bai.ne.jp>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/ar=
ch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index 121e4d1c3..44bb15951 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -78,6 +78,7 @@ &analog_sound {
>  	pinctrl-0 =3D <&hp_detect>;
>  	simple-audio-card,aux-devs =3D <&speaker_amp>, <&headphone_amp>;
>  	simple-audio-card,hp-det-gpios =3D <&gpio1 RK_PD3 GPIO_ACTIVE_LOW>;
> +	simple-audio-card,pin-switches =3D "Speaker", "Headphones";
>  	simple-audio-card,widgets =3D
>  		"Microphone", "Onboard Microphone",
>  		"Microphone", "Microphone Jack",
>=20





