Return-Path: <linux-kernel+bounces-807280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820F0B4A27A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C78B4E29F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CC7303A3F;
	Tue,  9 Sep 2025 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAZ8R0j3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7C3019CE;
	Tue,  9 Sep 2025 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399986; cv=none; b=gUFP10/z/LYdnMOpnnsDbUBg78lKQGb4VjbgAmOxeimiGbmGd2r1d16VhmnZWVdoHJVBHTGhInuOaU38M9LdRh6O+zIagIEvtnzCSj+Cfj81ZhnJC9aeLD/JhKiQCV22fbV8km83H7rMyYEzqycoslM29gQyMrtHiajRShugw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399986; c=relaxed/simple;
	bh=CDGgDx4Nki73aVoqrw4ePQX/fS/RDBiwv6Ilq8gxKAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOYMCc7ZM5MKsVyJnU2jQkMrzayshDJ4savKva9bme018doGI59wWbVnl2xlRAwwavzgEezl009KAA+QoXPCgq+dIipd/IJYvgXMKpfcj/gjtk9cqrNlaa4eBHg6p6aqeEjV3KJsu4Ju7ZhLckmEdsnxC5R7h4o0qonJ+AKoK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAZ8R0j3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099AEC4CEF4;
	Tue,  9 Sep 2025 06:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757399985;
	bh=CDGgDx4Nki73aVoqrw4ePQX/fS/RDBiwv6Ilq8gxKAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAZ8R0j3Vu3SejTmZVGa209vyubij2W5+HI0vyLeeCExpyUOTPOl1orGi3DuJl03G
	 JAvPioYpOy2LYqXPwMAv21aqWKEC6Nh1XA+scKx9nNMrjtXDGOOvBohtpxj23ksiTv
	 uewdU44EmAEnqX3/GVfoIfjkLtJMwC0LcrsqZz+k5HjxiW28LUvBtBTNMZKnX+9AkE
	 A6v4lVb/3qw90yJ1dksSZzRr/Emj2pDp5uR8p5MVjCuNu1WMytesAFi1OQxUDUW806
	 ilf+MMcau1yjUaaA/+uuG1sh/DhOVBLZwblzGYU/mSy32BJGo7Mp9Grb9LDluyAIKU
	 UEVEH6bbGcPAw==
Date: Tue, 9 Sep 2025 08:39:42 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH v5 4/7] drm/bridge: dw-hdmi: Add API
 dw_hdmi_set_sample_iec958() for iec958 format
Message-ID: <20250909-omniscient-honeybee-of-development-adca8a@houat>
References: <20250821073131.2550798-1-shengjiu.wang@nxp.com>
 <20250821073131.2550798-5-shengjiu.wang@nxp.com>
 <20250901185208.394cd162@booty>
 <CAA+D8AOCTqb5jLeRapYk4wRGZrsrPiuAR=ow3OA1B0+M9X4k7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="xbvuwjwmyrruqbpw"
Content-Disposition: inline
In-Reply-To: <CAA+D8AOCTqb5jLeRapYk4wRGZrsrPiuAR=ow3OA1B0+M9X4k7w@mail.gmail.com>


--xbvuwjwmyrruqbpw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/7] drm/bridge: dw-hdmi: Add API
 dw_hdmi_set_sample_iec958() for iec958 format
MIME-Version: 1.0

Hi,

On Wed, Sep 03, 2025 at 06:41:05PM +0800, Shengjiu Wang wrote:
> On Tue, Sep 2, 2025 at 12:52=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
> >
> > Hello Shengjiu,
> >
> > On Thu, 21 Aug 2025 15:31:28 +0800
> > Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> >
> > > Add API dw_hdmi_set_sample_iec958() for IEC958 format because audio d=
evice
> > > driver needs IEC958 information to configure this specific setting.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > Acked-by: Liu Ying <victor.liu@nxp.com>
> >
> > [...]
> >
> > > +void dw_hdmi_set_sample_iec958(struct dw_hdmi *hdmi, unsigned int ie=
c958)
> > > +{
> > > +     mutex_lock(&hdmi->audio_mutex);
> > > +     hdmi->sample_iec958 =3D iec958;
> > > +     mutex_unlock(&hdmi->audio_mutex);
> > > +}
> >
> > Apologies for jumping in the discussion as late as in v5, but I noticed
> > this patch and I was wondering whether this mutex_lock/unlock() is
> > really needed, as you're copying an int.
>=20
> Thanks for your comments.
>=20
> Seems it is not necessary to add mutex here. I just follow the code as
> other similar functions.  I will send a new version to update it.

Let's not be smart about it. Next thing you know, someone will add
another field in there that would absolutely require a mutex and now
you're not race free anymore.

Unless there's a real concern, the mutex must stay.

Maxime

--xbvuwjwmyrruqbpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaL/LpQAKCRAnX84Zoj2+
dor3AYCHio4X2egliC/DxGhE69IFjoCB2kz5rTVR9L9w9lm/BGcwlE52ivJCxATo
hyl0oZ4BgJ1LN6fhReyRbAA8/h8WtarRKmetqF8Cuizv58UMifibdOHkCJ59vF5M
4NuXwPWs5A==
=Ylzo
-----END PGP SIGNATURE-----

--xbvuwjwmyrruqbpw--

