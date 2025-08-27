Return-Path: <linux-kernel+bounces-788014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6BBB37ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6F4362217
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9C32142E;
	Wed, 27 Aug 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap3iInRw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435A276028
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286844; cv=none; b=c55+p9l+zJP3pLk18skSiRQ/PuebPPw3uG1OBkclnq3XcIe+hx/ti0o3rhcxTbYVf9R1OgdvQLfnziqkWP3cyvC/Abvb0GzuzpvoE5qTC56qgifomhCoz7/Iibta9dfVL3OMIOAY6msmuAUi+v6k/G8xOHXHigFK14JYG5jT7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286844; c=relaxed/simple;
	bh=Wv36AMBEza3FUF3/2V8wmSPaK8c8A4/g4c5XcF2MTp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGiVDxMhr2M75taaXa3TDMx0IXzQVWhu77T6I5YmIZ9EBOC4v1Q2qqkYMlmiS8x3j/4NclHAMU+av05gs+qGxjSmZShfhBXph/Fc9N2VijX0iROqAAaCJ+YK/TZUGiliSQfA3jnKM7YnIIvggynpx0nhQUSGPDmNV56rEOlPHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap3iInRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8982EC4CEEB;
	Wed, 27 Aug 2025 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756286843;
	bh=Wv36AMBEza3FUF3/2V8wmSPaK8c8A4/g4c5XcF2MTp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ap3iInRwEA21rNPhjtOQcc6nzJrsOESnex35TeWvXMJqA3iSvZCA5J8zFNyYm6hK5
	 tTZn2NzC7kMEkXNMAWHFXj+c+11RHvDwy1+wqs5KO8emE2g9RT+0u19ChnjbXwzuHf
	 BUFQl0060mC5JJXa6Qx6eknPHP+0t26a1GqlgXGaHaM62icxrg5AyWfUv1QZqHJ8bZ
	 GSORvXBAfgJAVHFZnol5ljxC8PBAzvOE7iAdXpfgnACoiAQ9L543Uo3fmyrTUKFnXW
	 Z3pUurcbFULD2v01lMQmqDtLwn8DGb7dSBS9mMQ+m40IpsyA6iPAFp5v5RRad8ZmBm
	 ym5T9I7gOg79g==
Date: Wed, 27 Aug 2025 11:27:21 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Swamil Jain <s-jain1@ti.com>, h-shenoy@ti.com, devarsht@ti.com, 
	vigneshr@ti.com, praneeth@ti.com, u-kumar1@ti.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, jyri.sarha@iki.fi, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	aradhya.bhatia@linux.dev
Subject: Re: [PATCH v5 2/3] drm/tidss: Remove max_pclk_khz from tidss display
 features
Message-ID: <20250827-illegal-splendid-coyote-aff8cc@houat>
References: <20250819192113.2420396-1-s-jain1@ti.com>
 <20250819192113.2420396-3-s-jain1@ti.com>
 <b95b60c3-5988-4238-a8d4-73bd8bbf8779@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="rpq6tiz433pjehda"
Content-Disposition: inline
In-Reply-To: <b95b60c3-5988-4238-a8d4-73bd8bbf8779@ideasonboard.com>


--rpq6tiz433pjehda
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/3] drm/tidss: Remove max_pclk_khz from tidss display
 features
MIME-Version: 1.0

On Wed, Aug 27, 2025 at 11:49:22AM +0300, Tomi Valkeinen wrote:
> On 19/08/2025 22:21, Swamil Jain wrote:
> > From: Jayesh Choudhary <j-choudhary@ti.com>
> >=20
> > TIDSS hardware by itself does not have variable max_pclk for each VP.
> > The maximum pixel clock is determined by the limiting factor between
> > the functional clock and the PLL (parent to the VP/pixel clock).
>=20
> Hmm, this is actually not in the driver, is it? We're not limiting the
> pclk based on the fclk.
>=20
> > The limitation that has been modeled till now comes from the clock
> > (PLL can only be programmed to a particular max value). Instead of
> > putting it as a constant field in dispc_features, we can query the
> > DM to see if requested clock can be set or not and use it in
> > mode_valid().
> >
> > Replace constant "max_pclk_khz" in dispc_features with
> > max_successful_rate and max_attempted_rate, both of these in
> > tidss_device structure would be modified in runtime. In mode_valid()
> > call, check if a best frequency match for mode clock can be found or
> > not using "clk_round_rate()". Based on that, propagate
> > max_successful_rate and max_attempted_rate and query DM again only if
> > the requested mode clock is greater than max_attempted_rate. (As the
> > preferred display mode is usually the max resolution, driver ends up
> > checking the highest clock the first time itself which is used in
> > subsequent checks).
> >=20
> > Since TIDSS display controller provides clock tolerance of 5%, we use
> > this while checking the max_successful_rate. Also, move up
> > "dispc_pclk_diff()" before it is called.
> >=20
> > This will make the existing compatibles reusable if DSS features are
> > same across two SoCs with the only difference being the pixel clock.
> >=20
> > Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
> > Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > Signed-off-by: Swamil Jain <s-jain1@ti.com>
> > ---
> >  drivers/gpu/drm/tidss/tidss_dispc.c | 85 +++++++++++++----------------
> >  drivers/gpu/drm/tidss/tidss_dispc.h |  1 -
> >  drivers/gpu/drm/tidss/tidss_drv.h   | 11 +++-
> >  3 files changed, 47 insertions(+), 50 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tids=
s/tidss_dispc.c
> > index c0277fa36425..c2c0fe0d4a0f 100644
> > --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> > +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> > @@ -58,10 +58,6 @@ static const u16 tidss_k2g_common_regs[DISPC_COMMON_=
REG_TABLE_LEN] =3D {
> >  const struct dispc_features dispc_k2g_feats =3D {
> >  	.min_pclk_khz =3D 4375,
> > =20
> > -	.max_pclk_khz =3D {
> > -		[DISPC_VP_DPI] =3D 150000,
> > -	},
> > -
> >  	/*
> >  	 * XXX According TRM the RGB input buffer width up to 2560 should
> >  	 *     work on 3 taps, but in practice it only works up to 1280.
> > @@ -144,11 +140,6 @@ static const u16 tidss_am65x_common_regs[DISPC_COM=
MON_REG_TABLE_LEN] =3D {
> >  };
> > =20
> >  const struct dispc_features dispc_am65x_feats =3D {
> > -	.max_pclk_khz =3D {
> > -		[DISPC_VP_DPI] =3D 165000,
> > -		[DISPC_VP_OLDI_AM65X] =3D 165000,
> > -	},
> > -
> >  	.scaling =3D {
> >  		.in_width_max_5tap_rgb =3D 1280,
> >  		.in_width_max_3tap_rgb =3D 2560,
> > @@ -244,11 +235,6 @@ static const u16 tidss_j721e_common_regs[DISPC_COM=
MON_REG_TABLE_LEN] =3D {
> >  };
> > =20
> >  const struct dispc_features dispc_j721e_feats =3D {
> > -	.max_pclk_khz =3D {
> > -		[DISPC_VP_DPI] =3D 170000,
> > -		[DISPC_VP_INTERNAL] =3D 600000,
> > -	},
> > -
> >  	.scaling =3D {
> >  		.in_width_max_5tap_rgb =3D 2048,
> >  		.in_width_max_3tap_rgb =3D 4096,
> > @@ -315,11 +301,6 @@ const struct dispc_features dispc_j721e_feats =3D {
> >  };
> > =20
> >  const struct dispc_features dispc_am625_feats =3D {
> > -	.max_pclk_khz =3D {
> > -		[DISPC_VP_DPI] =3D 165000,
> > -		[DISPC_VP_INTERNAL] =3D 170000,
> > -	},
> > -
> >  	.scaling =3D {
> >  		.in_width_max_5tap_rgb =3D 1280,
> >  		.in_width_max_3tap_rgb =3D 2560,
> > @@ -376,15 +357,6 @@ const struct dispc_features dispc_am625_feats =3D {
> >  };
> > =20
> >  const struct dispc_features dispc_am62a7_feats =3D {
> > -	/*
> > -	 * if the code reaches dispc_mode_valid with VP1,
> > -	 * it should return MODE_BAD.
> > -	 */
> > -	.max_pclk_khz =3D {
> > -		[DISPC_VP_TIED_OFF] =3D 0,
> > -		[DISPC_VP_DPI] =3D 165000,
> > -	},
> > -
> >  	.scaling =3D {
> >  		.in_width_max_5tap_rgb =3D 1280,
> >  		.in_width_max_3tap_rgb =3D 2560,
> > @@ -441,10 +413,6 @@ const struct dispc_features dispc_am62a7_feats =3D=
 {
> >  };
> > =20
> >  const struct dispc_features dispc_am62l_feats =3D {
> > -	.max_pclk_khz =3D {
> > -		[DISPC_VP_DPI] =3D 165000,
> > -	},
> > -
> >  	.subrev =3D DISPC_AM62L,
> > =20
> >  	.common =3D "common",
> > @@ -1347,25 +1315,57 @@ static void dispc_vp_set_default_color(struct d=
ispc_device *dispc,
> >  			DISPC_OVR_DEFAULT_COLOR2, (v >> 32) & 0xffff);
> >  }
> > =20
> > +/*
> > + * Calculate the percentage difference between the requested pixel clo=
ck rate
> > + * and the effective rate resulting from calculating the clock divider=
 value.
> > + */
> > +unsigned int dispc_pclk_diff(unsigned long rate, unsigned long real_ra=
te)
> > +{
> > +	int r =3D rate / 100, rr =3D real_rate / 100;
> > +
> > +	return (unsigned int)(abs(((rr - r) * 100) / r));
> > +}
> > +
> > +static int check_pixel_clock(struct dispc_device *dispc,
> > +			     u32 hw_videoport, unsigned long clock)
> > +{
> > +	unsigned long round_clock;
> > +
> > +	if (dispc->tidss->is_ext_vp_clk[hw_videoport])
> > +		return 0;
> > +
> > +	if (clock <=3D dispc->tidss->max_successful_rate[hw_videoport])
> > +		return 0;
> > +
> > +	if (clock < dispc->tidss->max_attempted_rate[hw_videoport])
> > +		return -EINVAL;
> > +
> > +	round_clock =3D clk_round_rate(dispc->vp_clk[hw_videoport], clock);
> > +
> > +	if (dispc_pclk_diff(clock, round_clock) > 5)
> > +		return -EINVAL;
> > +
> > +	dispc->tidss->max_successful_rate[hw_videoport] =3D round_clock;
> > +	dispc->tidss->max_attempted_rate[hw_videoport] =3D clock;
>=20
> I still don't think this logic is sound. This is trying to find the
> maximum clock rate, and optimize by avoiding the calls to
> clk_round_rate() if possible. That makes sense.
>=20
> But checking for the 5% tolerance breaks it, in my opinion. If we find
> out that the PLL can do, say, 100M, but we need pclk of 90M, the current
> maximum is still the 100M, isn't it?

5% is pretty large indeed. We've been using .5% in multiple drivers and
it proved to be pretty ok. I would advise you tu use it too.

It's not clear to me why avoiding a clk_round_rate() call is something
worth doing though?

Even caching the maximum rate you have been able to reach before is
pretty fragile: if the PLL changes its rate, or if a sibling clock has
set some limits on what the PLL can do, your maximum isn't relevant
anymore.

in other words, what's wrong with simply calling clk_round_rate() and
checking if it's within a .5% deviation?

At the very least, this should be explained in comments or the commit
message.

Maxime

--rpq6tiz433pjehda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaK7PcQAKCRAnX84Zoj2+
dvY/AYC68Q6d4wqvpMlEECwf3C4mEVdQ9NQxDMI73v63CUc+UuQwKZX0bhxW8ZZq
S0obvAwBfjsiSD4jX44fQeOf0Vu4DiHmsljRlVmicjF7Jc3dSk9wNAhE60eKyp6v
rIUQVO5fHA==
=xvuZ
-----END PGP SIGNATURE-----

--rpq6tiz433pjehda--

