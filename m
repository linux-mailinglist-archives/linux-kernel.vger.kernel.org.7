Return-Path: <linux-kernel+bounces-832446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE2B9F56A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38161BC3D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68871DB958;
	Thu, 25 Sep 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCkjCgww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387571A314D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804490; cv=none; b=EpWbbYJIEf4tx4aniL8R8HTn6OKcl69wQyq3A/AytA7rjltiC1k+RxDV0drHKMUYpiGS+Q4so8ILB6vBgP2Y0ek2dM/hE4vCBQ6h3z+OIrsrQ3npvvTweRM4StpuHYV54tc/LBgE5Tvf1PGl4JXz3ITLBvhGFidrAH2Vk1T4HHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804490; c=relaxed/simple;
	bh=1ipVFYFMiuR5F7EukbEmgjPCYH8EmaeiYw+uLkYVTrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJBTYmLEtCmdqYjjyVJ2kjY1Sara4VszfH30JBevcOvR2k/7NJADKdfDJJlOzvUmvNkuS8xQQ1Vf1vuy0E7X8YEyHxvzhcS6QRu7ofX0sTm8RK20bsFWgkHeGB1uEr9EbCHI3TYXT2P++zZJrEiw/kH71bTYnRvWzglwocS5uYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCkjCgww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FCBC4CEF0;
	Thu, 25 Sep 2025 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758804489;
	bh=1ipVFYFMiuR5F7EukbEmgjPCYH8EmaeiYw+uLkYVTrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qCkjCgwwygXnCnJyGWTLqwljG2Tw3EvDltbC2CckpYzg4V93tH3QiwNm+U59O4Zqc
	 fWyKN3frfGYIIr4N2yKjjHdj96z4SieyGAcGTc9CLrtUYQd43i6rPB66tacb10qd+I
	 HQTsy4fGhENe+SogGUfCT78kjDuIs9DUjNJBf5apMFNYukufFI5nJnJy3qlCqJZJ7D
	 DyIGDxFH8f1pzNP0pcx+G/70bCPk4erH8Az7QhxntDX65gJTmyDtcdXIzNm2Nten/f
	 YdFoCGPk/3kXJxYx8IKnUnBgDNBrNITsqKa+9wx8AQEJPAQD73IIgpEpJJzeISEpsg
	 RtjUyFTGYMkVA==
Received: by venus (Postfix, from userid 1000)
	id 7C85A1805A0; Thu, 25 Sep 2025 14:48:07 +0200 (CEST)
Date: Thu, 25 Sep 2025 14:48:07 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michael Riesch <michael.riesch@collabora.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH] drm/panel: sitronix-st7789v: fix sync flags for
 t28cp45tn89
Message-ID: <hktw42pbb4rk3azapasigphhlbndkh5pmcm6fucdvk3ukoiull@dpoh7amjyymh>
References: <20250924-t28cp45tn89-fix-v1-1-8e8f52239c84@collabora.com>
 <6e50e9fb-10f5-48e6-bc04-ec66ca90a626@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w64dwrdjv5cr2ceg"
Content-Disposition: inline
In-Reply-To: <6e50e9fb-10f5-48e6-bc04-ec66ca90a626@mailbox.org>


--w64dwrdjv5cr2ceg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/panel: sitronix-st7789v: fix sync flags for
 t28cp45tn89
MIME-Version: 1.0

Hello Marek,

On Thu, Sep 25, 2025 at 02:15:41AM +0200, Marek Vasut wrote:
> On 9/24/25 11:46 PM, Sebastian Reichel wrote:
> > From: Sebastian Reichel <sebastian.reichel@collabora.com>
> >=20
> > I planned to set the polarity of horizontal and vertical sync, but
> > accidentally described vertical sync twice with different polarity
> > instead.
> >=20
> > Note, that there is no functional change, because the driver only
> > makes use of DRM_MODE_FLAG_P[HV]SYNC to divert from the default
> > active-low polarity.
> >=20
> > Reported-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> > Closes: https://lore.kernel.org/all/20250923132616.GH20765@pendragon.id=
easonboard.com/
> > Fixes: a411558cc143 ("drm/panel: sitronix-st7789v: add Inanbo T28CP45TN=
89 support")
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >   drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/g=
pu/drm/panel/panel-sitronix-st7789v.c
> > index 04d91929eedda092b966b8cffdef5b267748f190..dedf0a390a88dd45a8179e2=
d22e872128c87cfda 100644
> > --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> > +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> > @@ -261,7 +261,7 @@ static const struct drm_display_mode t28cp45tn89_mo=
de =3D {
> >   	.vtotal =3D 320 + 8 + 4 + 4,
> >   	.width_mm =3D 43,
> >   	.height_mm =3D 57,
> > -	.flags =3D DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC,
> > +	.flags =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC,
> Is this panel somehow special with its NHSYNC / PVSYNC , compared to the
> other supported panels, which all use PHSYNC / PVSYNC ? I would expect all
> of these DSI TCON to use the same polarity, how come this one needs NHSYN=
C ?

I wrote this based on reverse engineering incl. quite a bit try-and-error a=
nd
don't have very good data about the panel. Using DRM_MODE_FLAG_PHSYNC like =
all
the other panels results in garbage data on the display.

Greetings,

-- Sebastian

--w64dwrdjv5cr2ceg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjVOgIACgkQ2O7X88g7
+poTjRAAp2ByyBdVykfjLW0AzuSIfUBeMB5GOwwYrD7GLn4AZJB6HeGmVYFCkxXU
OYjLoIVbE6ufUqpPRvPswFioeoU0lkA41I4qZbMzwbid688B56pvxLb+CBy9nC6f
OKCiYEPooFGaZGpd/KyOraEfi5xpxSFPGlSMNxujq8XZ4Crttd7CIZA3CJUZbRTo
qa0MGkYGmg/px5vrcv0G4d9KkbB4S9hUzVvJLQzatrfXtpYko/14QN1BnCtuHyO/
eH1V02P2Q04faSBpkBcehN0GlW8t2sMnW4RVk9ouJG0Ggu0dfgLCk258scB4Hg1m
QGx2u5YvOVvCzz//PVZZ7jYGiFplwh+X4AZLDZLyJnruwEB9fyKWbGTAm0gYlQZ5
AGeeWBE2FyLzCu3Ywhke1PBfOy1AAAUuM9vNrtmOIQoqSIkKVcYwQ1qU6k5yRcjN
fp6QQLzEP9YH15BF6SM6CJ9KHbTVjZMHY9itFt6mb74HVLKV5x0XhPw5L8hOJHNT
mJQDAHdhspg19+lBVGhxHRcfypRIBh9nF2bpm7Vzv5SGLs85mBHHkL2wmkB4n21M
OckYVdXkL5ALGa0K25CN3Dw3w38oLfaEV+BfjlM6+GJi2ZOlniIBtE+deseEp9hE
v3dQXvYk0FNjtJ/Z7nY9P85xkNOeXjO/r2Ysmm0mG9GovZyx7NI=
=sv8+
-----END PGP SIGNATURE-----

--w64dwrdjv5cr2ceg--

