Return-Path: <linux-kernel+bounces-853007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173DBDA767
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01E86507D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E301128D8DB;
	Tue, 14 Oct 2025 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFgPZ+MS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F32FFFA0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456211; cv=none; b=eYxRAcnzz/X32NZkQT4OeiqjbBkcmN4vq5l+OraP55wFYw31BqFoNt6+iFUMav2d3lpH2KojEB90uC/cVzDMR/UScQEDEjri6AZQm+iMcmUTpFkZB40mcKh2dfoAALPfdfxH6982lAmEkMUqVML6ugcqfMh3JUtfj1Ndc1jQrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456211; c=relaxed/simple;
	bh=/YUfdjKdfeGtY1dZaR19OtPFxA8hHN01woXntI4SbQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSW+B4zHWn8Cp1e1m4WRVvTgLzJHZrwT+axYzgcl11xxW3OLZU1q/di132MxTmlvw1qwFsrxBdroFesDOykFtmR7Dw10XU0/pA5LInqlCOm2WsMIK3zHyQVAItY0l7q88CIL4rZ72hdMx0IIOedsIdHASwTmRPyt74uYj8HVr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFgPZ+MS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B3FC4CEE7;
	Tue, 14 Oct 2025 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760456210;
	bh=/YUfdjKdfeGtY1dZaR19OtPFxA8hHN01woXntI4SbQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFgPZ+MSp9EfV49h7v9dUh3B4dbfJLm5MnG5joDRmsP6pDZ5uBh3I1ZdLizN+CZ3q
	 m1cxb6a3Qyddv+sTPqRAJTPq0cPmKbdoygtpT28ovBv14fKS/SRsRVrF4vNPVfJXoF
	 5gmoEwcTxNU34P2IhcW8qlg/SnWBlTBeiAV0mLYHQqE385qmTzTQPEdWWtpnKaHUQN
	 872Qg9omEw1frzwiHv7v/AHwgVORsViBV+e19uSGRaQVTc4zS1mzWYq6VG5hD0pyOK
	 tA+8pw06CzsT3B4YjCHmn8wxq1isynN02Z/G97cruOhKEghlPWTCRsunDhQ3pODG31
	 wqNiJW119uQvQ==
Date: Tue, 14 Oct 2025 17:36:47 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Bajjuri Praneeth <praneeth@ti.com>, Louis Chauvet <louis.chauvet@bootlin.com>, 
	thomas.petazzoni@bootlin.com, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/tilcdc: Fix removal actions in case of failed probe
Message-ID: <p4u2goyadub3dfuz4empf3g7a44b2ausy4hjjkcwj7nzgeochx@xztpij2i2lao>
References: <20251014143229.559564-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="4iewvzq6u4fbr2dv"
Content-Disposition: inline
In-Reply-To: <20251014143229.559564-1-kory.maincent@bootlin.com>


--4iewvzq6u4fbr2dv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tilcdc: Fix removal actions in case of failed probe
MIME-Version: 1.0

On Tue, Oct 14, 2025 at 04:32:28PM +0200, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
>=20
> The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpers
> should only be called when the device has been successfully registered.
> Currently, these functions are called unconditionally in tilcdc_fini(),
> which causes warnings during probe deferral scenarios.
>=20
> [    7.972317] WARNING: CPU: 0 PID: 23 at drivers/gpu/drm/drm_atomic_stat=
e_helper.c:175 drm_atomic_helper_crtc_duplicate_state+0x60/0x68
> ...
> [    8.005820]  drm_atomic_helper_crtc_duplicate_state from drm_atomic_ge=
t_crtc_state+0x68/0x108
> [    8.005858]  drm_atomic_get_crtc_state from drm_atomic_helper_disable_=
all+0x90/0x1c8
> [    8.005885]  drm_atomic_helper_disable_all from drm_atomic_helper_shut=
down+0x90/0x144
> [    8.005911]  drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [ti=
lcdc]
> [    8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [t=
ilcdc]
>=20
> Fix this by moving both drm_kms_helper_poll_fini() and
> drm_atomic_helper_shutdown() inside the priv->is_registered conditional
> block, ensuring they only execute after successful device registration.
>=20
> Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at shutdown/=
remove time for misc drivers")
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc=
/tilcdc_drv.c
> index 7caec4d38ddf..2031267a3490 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -172,11 +172,11 @@ static void tilcdc_fini(struct drm_device *dev)
>  	if (priv->crtc)
>  		tilcdc_crtc_shutdown(priv->crtc);
> =20
> -	if (priv->is_registered)
> +	if (priv->is_registered) {
>  		drm_dev_unregister(dev);
> -
> -	drm_kms_helper_poll_fini(dev);
> -	drm_atomic_helper_shutdown(dev);
> +		drm_kms_helper_poll_fini(dev);
> +		drm_atomic_helper_shutdown(dev);
> +	}
>  	tilcdc_irq_uninstall(dev);
>  	drm_mode_config_cleanup(dev);

I don't think that's the right fix. tilcdc_fini is pretty complex
because it gets called from multiple locations with various level of
initialisation.

This is done because tilcdc_init is using a bunch of deprecated
functions with better alternatives now, and those would make the job of
tilcdc_fini much easier.

That's what we should be focusing on.

Maxime

--4iewvzq6u4fbr2dv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaO5uCwAKCRAnX84Zoj2+
dr+eAX42SDkP/0toMISYSvfTyiOHtxzqHbO1OxqawFccTWPPAa41BPko8DDctGGp
70sAZ7kBgKUUeVJsaKqB2Kz6eCBBvqBNFu2wItXPGUN9HecAePzPPjHm1sXdLJSP
RsAMCvDnWA==
=mxvO
-----END PGP SIGNATURE-----

--4iewvzq6u4fbr2dv--

