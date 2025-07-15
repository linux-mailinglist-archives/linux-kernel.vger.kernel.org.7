Return-Path: <linux-kernel+bounces-731666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED39B057F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6753BDE68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FE42D8378;
	Tue, 15 Jul 2025 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="14TGwTJ8"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D426FA5C;
	Tue, 15 Jul 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575763; cv=none; b=WH2bdz74hk2kxY/igSrrByslM4YBHgcAQWzQ7Fr8ULiVSR+xyxOKJaWt4WmHpHjsfRvl/T46AtVs7zjXuqHvgAMyd3Nt1MFUL2hgfdd9VloOIqYUBepsws1B/L3pVIttQKd04Hf40ytZhmrthBit4bRd7GGUdm+PuaHvSyUYcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575763; c=relaxed/simple;
	bh=PVrN5t+Rswmtwu3Tlf0t04P30Tg+MUZhyGKgeXphSTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEofZ2l8lxcUEbSq0IVLa+VpW69koh3FUMKh8FaNA7WEFoaQaj3AvbERN9E/XjPjJTjS8VP6901+acMt+j+huH+VcCh/yg77o4Tz1FCrk2n0LXk4E2GptUT5i9KX+jOT2skh39HvzOpvkkDJ0KUeMOfV8QgZQZdA6yi5YIA7uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=14TGwTJ8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=cIPn1JdmQUBAudYGWKwQBBR2ZjhtmhuYOGeF5hB/XP8=; b=14TGwTJ8i2Mh5u5WG7VtC3VE23
	YFqP6TUaqtH3GFuLFFL7UrSspk3fVBByN4gsW70nMbjqCUovWeMbDyltzB83dS1IFVG0m5945ngjZ
	BuVB1Rp76b99J3JpEGR0olUIaAY5UQ30wjwa/ZzUKuYS1mVSnc+Iq3NRN8l5YhXceZxAC8UjvwM0v
	TTy+p+lGttVM88UHbqHNGYjTSjirYsOWteKkcFBBVVMcy3Vq1hqz8zd+5bwb87Dw8Id9bHxyOwHkI
	7xdQg6RmqEDmq93oMFMXrbUZBMUNl1n/Iv9Dcpbc9o39WGUCsEXeE12Tw588LxpqE5vN0oqN7tQLs
	2L81kG0A==;
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ubd0o-00009u-Be; Tue, 15 Jul 2025 12:35:50 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
 John Keeping <jkeeping@inmusicbrands.com>
Cc: John Keeping <jkeeping@inmusicbrands.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] phy: rockchip: usbdp: implement .set_mode
Date: Tue, 15 Jul 2025 12:35:47 +0200
Message-ID: <3981131.iZASKD2KPV@phil>
In-Reply-To: <20250710152252.2532020-3-jkeeping@inmusicbrands.com>
References:
 <20250710152252.2532020-1-jkeeping@inmusicbrands.com>
 <20250710152252.2532020-3-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi John,

Am Donnerstag, 10. Juli 2025, 17:22:50 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb John Keeping:
> When the orientation of a type C cable changes, usbdp set the new
> configuration in its internal state but does not write this to the
> hardware.
>=20
> Make use of phy_ops::set_mode to write this new state.  This should be
> called by the USB controller when it is notified of a role change
> (assuming it is acting as the role switch) and will be called at a point
> when the controller does not expect the phy to be operating normally.
>=20
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>

with the comments from Ondrej in [0] the whole thing seems to be
slightly more complex


[0] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250225184=
519.3586926-3-heiko@sntech.de/

> ---
>  drivers/phy/rockchip/phy-rockchip-usbdp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rock=
chip/phy-rockchip-usbdp.c
> index c066cc0a7b4f1..00368fb09307a 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -1335,9 +1335,23 @@ static int rk_udphy_usb3_phy_exit(struct phy *phy)
>  	return 0;
>  }
> =20
> +static int rk_udphy_usb3_phy_set_mode(struct phy *phy, enum phy_mode mod=
e, int submode)
> +{
> +	struct rk_udphy *udphy =3D phy_get_drvdata(phy);
> +	int ret =3D 0;
> +
> +	mutex_lock(&udphy->mutex);
> +	if (udphy->mode !=3D UDPHY_MODE_NONE)
> +		ret =3D rk_udphy_init(udphy);
> +	mutex_unlock(&udphy->mutex);
> +
> +	return ret;
> +}
> +
>  static const struct phy_ops rk_udphy_usb3_phy_ops =3D {
>  	.init		=3D rk_udphy_usb3_phy_init,
>  	.exit		=3D rk_udphy_usb3_phy_exit,
> +	.set_mode	=3D rk_udphy_usb3_phy_set_mode,
>  	.owner		=3D THIS_MODULE,
>  };
> =20
>=20





