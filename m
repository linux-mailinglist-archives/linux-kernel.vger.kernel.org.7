Return-Path: <linux-kernel+bounces-836294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA8BA93A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2BD189D434
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFD226F28B;
	Mon, 29 Sep 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK2PpFs1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56734BA40
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149913; cv=none; b=r/ZGQkSBmgw9WhTTV/zrq0Dz2M1kIpU4LE0+nLQOln8Gv1OceMd0xWL3eGKM++gfTF41oJHx2Sw1rqIzFHVmNFgtNSwv5vqqQvwFt/VRVpyAjndWBTyXyRtDbfvkZNWhDlRBtfHz8g0LemgNtPSjSdQthwevC0b4VanKbzVl0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149913; c=relaxed/simple;
	bh=k3QhcLVs/meU1SH3Oti3quubhCNvIZota6kbfHk+xWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3JjaGIdE6r3j3Z0eY9G1+IyYk9nlxOwn+fOSrKwAqfxwtjKTuRolOU9qpouhP7yliSqvFXgEQpesM6n/5+oXSRFsv3n7s0LGKGx3xLOCXc/MzMRXbYTnNTCCbhQMs+r0kzamtIvayMJpHUZnkpxbdNpzUbxMjmLiWKnFsfwlTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK2PpFs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F33AC4CEF4;
	Mon, 29 Sep 2025 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759149912;
	bh=k3QhcLVs/meU1SH3Oti3quubhCNvIZota6kbfHk+xWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YK2PpFs1BhbExmZ9GbO6T7mTKVoKj585xyyeHgnhfe4OeHPjAW0A1878siukIJ18b
	 DR8LmtaLUsWZDdgwgkYqJ77C/hYH/UhuWR8dY+Bt2BFcETpsEBydZ2r9V0cB97Uor9
	 nYuFids9vMqCyJLsLYHqJ3/Kjnwlc3Kw4lsTsnoCFjhRK8C5OvoQeKFMblfvq6RU6N
	 PMNZZYVl8m03kZS/chrXg29a80AKsBFFS+nG7d8F3KtNHlFVsRPG2U0psF/PI5yihE
	 6YGazdpgdf2qhLwKUYgJzAn5uboIeZrUycOsR1paqpIRWyt9vVHpiPkrtDAlTty6yB
	 +ZZY+Gk0PTPZA==
Date: Mon, 29 Sep 2025 14:45:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] drm/encoder: drm_encoder_cleanup: take chain mutex
 while tearing down
Message-ID: <20250929-flat-koel-from-nibiru-665d49@houat>
References: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com>
 <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-2-23b62c47356a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="box6upnjulpje4g5"
Content-Disposition: inline
In-Reply-To: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-2-23b62c47356a@bootlin.com>


--box6upnjulpje4g5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/7] drm/encoder: drm_encoder_cleanup: take chain mutex
 while tearing down
MIME-Version: 1.0

On Fri, Sep 26, 2025 at 05:59:43PM +0200, Luca Ceresoli wrote:
> drm_encoder_cleanup() modifies the encoder chain by removing bridges via
> drm_bridge_detach(). Protect this whole operation by taking the mutex, so
> any users iterating over the chain will not access it during the change.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_encoder.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
> index 3261f142baea30c516499d23dbf8d0acf5952cd6..3a04bedf9b759acd6826864b7=
f2cc9b861a8f170 100644
> --- a/drivers/gpu/drm/drm_encoder.c
> +++ b/drivers/gpu/drm/drm_encoder.c
> @@ -195,9 +195,11 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
>  	 * the indices on the drm_encoder after us in the encoder_list.
>  	 */
> =20
> +	mutex_lock(&encoder->bridge_chain_mutex);
>  	list_for_each_entry_safe(bridge, next, &encoder->bridge_chain,
>  				 chain_node)
>  		drm_bridge_detach(bridge);
> +	mutex_unlock(&encoder->bridge_chain_mutex);

You were claiming that the mutex was to prevent issues with concurrent
iteration and removal of the list members. list_for_each_entry_safe() is
explicitly made to protect against that. Why do we need both?

Maxime

--box6upnjulpje4g5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNp/VQAKCRAnX84Zoj2+
dsSMAX93Bhpb2AuyZzFQQEKJRaSJBKVjFAWIqeHtMlRxy0TJ1j5FlZdjAiS/3A2b
O3y1iSEBf1Fe6M0LaFxakjQ8ekWZB99hcggiZ0i7VTKiVbwRTh0g4ct5T7Ou3jMv
WDvvXFtKBQ==
=vzQl
-----END PGP SIGNATURE-----

--box6upnjulpje4g5--

