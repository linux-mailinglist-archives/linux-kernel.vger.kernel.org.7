Return-Path: <linux-kernel+bounces-778032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F37B2E06F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA006B63993
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27F7FBAC;
	Wed, 20 Aug 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZJH9/EH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230436997E;
	Wed, 20 Aug 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702015; cv=none; b=bRL8y1eFNBrStwWzt0ixfE3D3LKRK7dXp4jZUNB2IujL79Y5yvgRZC60MQS+gfJRUGLlTk3vh/TAjW0qkPkxiTmEMD01JErp159Yri8S2dsx9y1YIv8W7qns0c95snaN3gJrqnUiPQ4nUV1zG1vzxnXVKmbBbflnggSyA6CApUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702015; c=relaxed/simple;
	bh=HQ5b81Apoab6czGcXH0vKrkZjdSXVB5vGQChQZigfGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIf2ZfJgqmBXGBOT/IizfLiAo0qZTgqE9Gsa6VA62Q96oq2JsJfBG/tj1p3MarZfeJKMtxFXa6c5p8sFgymTLiD3EBcIND8aYlUTHe/RCBmZITTl9DDo0G/Lnnxd6GAWgj7nYcpcu37WEonIwg5uMudycJQ0Orbp4rVviccm6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZJH9/EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27167C116B1;
	Wed, 20 Aug 2025 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755702015;
	bh=HQ5b81Apoab6czGcXH0vKrkZjdSXVB5vGQChQZigfGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZJH9/EH88gSyhql/auK4PWa7AtEO2Igy0GRER4LLH7ThQiHl0XH6BnCy5/NN3PMT
	 RFjDzlxjxBrucO8iCpfXpZD76n+Jm+rOfMI+VGnnDiT6/srjtvkUYGOax/5UWOxpbK
	 64tLdCgCpiXUAhq8NfP1OK6R24kUspG7B7i6j1GQRJ8kZoYvs0yKtNtcAG7pTsJy3Z
	 oXGXc9x484fXChvSvNbcBYhewPk+SLQnaSdOFV1agHVRLoBNL3ao0Wjj/0LmdTQe95
	 pIJiD4uEDJiHNf7o6jJB1oMItVzWHJZkZbFFK+W0g97QucjyTUS+eTaY2fWfejq6Wg
	 MAXxr90IR5uPg==
Date: Wed, 20 Aug 2025 17:00:13 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	"open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: Replace redundant return value judgment with
 PTR_ERR_OR_ZERO()
Message-ID: <20250820-skilled-dragonfly-of-symmetry-b4f4dc@houat>
References: <20250815133727.418204-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="su26l5zhm5tjwxui"
Content-Disposition: inline
In-Reply-To: <20250815133727.418204-1-liaoyuanhong@vivo.com>


--su26l5zhm5tjwxui
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/sun4i: Replace redundant return value judgment with
 PTR_ERR_OR_ZERO()
MIME-Version: 1.0

Hi,

On Fri, Aug 15, 2025 at 09:37:27PM +0800, Liao Yuanhong wrote:
> Replace redundant return value judgment with PTR_ERR_OR_ZERO() to
> enhance code readability.
>=20
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 5 +----
>  drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c     | 5 +----
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c  | 5 +----
>  3 files changed, 3 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/dr=
m/sun4i/sun4i_hdmi_tmds_clk.c
> index fbf7da9d9592..c90dd0ad040f 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> @@ -229,8 +229,5 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
>  	tmds->div_offset =3D hdmi->variant->tmds_clk_div_offset;
> =20
>  	hdmi->tmds_clk =3D devm_clk_register(hdmi->dev, &tmds->hw);
> -	if (IS_ERR(hdmi->tmds_clk))
> -		return PTR_ERR(hdmi->tmds_clk);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(hdmi->tmds_clk);

The readibility improvement is very subjective, and this makes it harder
to extend later on, so I don't think this should be merged.

Maxime

--su26l5zhm5tjwxui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaKXi/AAKCRAnX84Zoj2+
dm+UAX9RCkx9gaut6YQRzmpPslaiJ2m2jmUpynn6QC21/IDDMsYsSM6cisPFTO21
AMJZZp4BgJ+CB1UtTTi+hgvHJSfJvEL0psMKwkK1KB/+wu91d4SMqbEVnzCyIbxY
+wBkUAEZIQ==
=93ng
-----END PGP SIGNATURE-----

--su26l5zhm5tjwxui--

