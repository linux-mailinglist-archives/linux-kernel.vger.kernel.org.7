Return-Path: <linux-kernel+bounces-708266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F35AECE51
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19CD97A9341
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 15:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FFB231830;
	Sun, 29 Jun 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="lwQ6TVbB"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827F22FDE6
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751210525; cv=none; b=addnr8uOsZCHHB2mRmioBWXAshx5cjTj8g0zsBSqBRax3HUUFKBLH5mC8hYGXx4h48etKdmQBYVGBZ3+8ILDLgfjdlRFXTWZLBVI1mzSaoX+94UnIkV89evFI/1LZwv04YYU3RUAcOInI2xRnx+C4z5Fl9ie+oeBj+9DnbGS9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751210525; c=relaxed/simple;
	bh=2oYswlF9AhHrpgfKj4RUAztQaAUMBpUTsfST+k5C06Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:Cc:To:
	 References:In-Reply-To; b=uzU3QfCqi+OjNSl1pjmk+Z8zg/cBEln4xhH1zTkPzfNDoURAZHdzmOyhIhgc37Elg43Cm2YHkc1GaYroTjjhgoMgjDE9dMWlxbbYqIBkn2PnOfv2HVW+l4H+lj+oDz0e4bJN8deMZttHADh4Q13h/AFmOP5wB+q7fMAoCl4O0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=lwQ6TVbB; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1751210519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CQig8DqKUDgYQc5TUxBurAmCLuuco1HaVKaFPcbDts0=;
	b=lwQ6TVbB9kA4v8c+9fEI1MCHKrvlSlCdL2QanaMY1bJs5vKvNM8vHwVXFQJZKZMn+Q7+J+
	VIja3RCvQjYFkgEGgGCVjMM4NNe23F70ba/iR/jZFItleEuPbDcGSGy7G1RiWR4DrLNs7Y
	CXaeF0jiHkvfKHAGfmr3mGD1STZESGdWRQVSl3g++jhZf1ugQQYvlw+Tnqg1WvgBig7ub+
	gqndaa8s/b+xxXCLRyrr80NYCl7ox8/g2Dwf79Rhb4t4UR8WRF8Ik6dQr66l8ogqD9P2Uy
	cJbLEGG/k+VoDqBz0dUaQCfxHAeOhxY60In3k7di9kfQpgLH4JV3n/E9TW9TXA==
Content-Type: multipart/signed;
 boundary=8b0b4523779c4da51aebb377aae00a4fbb05642b98251df13617b5a6d748;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 29 Jun 2025 17:21:42 +0200
Message-Id: <DAZ4BALHEJ9M.10FO1U9IYP4WA@cknow.org>
Subject: Re: [PATCH] rockchip/drm: vop2: make vp registers nonvolatile
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
Cc: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
To: "Piotr Zalewski" <pZ010001011111@proton.me>
References: <20250628180914.1177177-2-pZ010001011111@proton.me>
In-Reply-To: <20250628180914.1177177-2-pZ010001011111@proton.me>
X-Migadu-Flow: FLOW_OUT

--8b0b4523779c4da51aebb377aae00a4fbb05642b98251df13617b5a6d748
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Piotr,

On Sat Jun 28, 2025 at 8:11 PM CEST, Piotr Zalewski wrote:
> Make video port registers nonvolatile. As DSP_CTRL register is written
> to twice due to gamma LUT enable bit which is set outside of the main
> DSP_CTRL initialization within atomic_enable (for rk356x case it is also
> necesarry to always disable gamma LUT before writing a new LUT) there is
> a chance that DSP_CTRL value read-out in gamma LUT init/update code is
> not the one which was written by the preceding DSP_CTRL initialization
> code within atomic_enable. This might result in misconfigured DSP_CTRL
> which leads to no visual output[1]. Since DSP_CTRL write takes effect
> after VSYNC[1] the issue is not always present. When tested on Pinetab2
> with kernel 6.14 it happenes only when DRM is compiled as a module[1].
> In order to confirm that it is because of timing I inserted 18ms udelay
> before vop2_crtc_atomic_try_set_gamma in atomic enable and compiled DRM
> as module - this has also fixed the issue on Pinetab2.
>
> [1] https://lore.kernel.org/linux-rockchip/562b38e5.a496.1975f09f983.Core=
mail.andyshrk@163.com/
>
> Reported-by: Diederik de Haas <didi.debian@cknow.org>
> Closes: https://lore.kernel.org/linux-rockchip/DAEVDSTMWI1E.J454VZN0R9MA@=
cknow.org/
> Suggested-by: Andy Yan <andy.yan@rock-chips.com>
> Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index d0f5fea15e21..241060cc24cb 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -2589,12 +2589,13 @@ static int vop2_win_init(struct vop2 *vop2)
>  }
> =20
>  /*
> - * The window registers are only updated when config done is written.
> - * Until that they read back the old value. As we read-modify-write
> - * these registers mark them as non-volatile. This makes sure we read
> - * the new values from the regmap register cache.
> + * The window and video port registers are only updated when config
> + * done is written. Until that they read back the old value. As we
> + * read-modify-write these registers mark them as non-volatile. This
> + * makes sure we read the new values from the regmap register cache.
>   */
>  static const struct regmap_range vop2_nonvolatile_range[] =3D {
> +	regmap_reg_range(RK3568_VP0_CTRL_BASE, RK3588_VP3_CTRL_BASE+255),
>  	regmap_reg_range(0x1000, 0x23ff),
>  };
> =20

I built a 6.16-rc3 kernel with this patch and booted into it ... and it
fixed the issue I reported \o/ Thus:

Tested-by: Diederik de Haas <didi.debian@cknow.org>

Thanks!

Cheers,
  Diederik

--8b0b4523779c4da51aebb377aae00a4fbb05642b98251df13617b5a6d748
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaGFaCQAKCRDXblvOeH7b
blnvAQDRa0zYQCz0TbHhkzDu2IbxQRVxIb6zmpUFwWz5jPwfLwD/T5yIvj+Cmn20
1n04TWUawcOG/GyocXAfoaWpF07LOA0=
=GYzV
-----END PGP SIGNATURE-----

--8b0b4523779c4da51aebb377aae00a4fbb05642b98251df13617b5a6d748--

