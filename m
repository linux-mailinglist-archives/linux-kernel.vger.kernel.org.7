Return-Path: <linux-kernel+bounces-796412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E571DB4002D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5964618961B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8B2E5B1F;
	Tue,  2 Sep 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjxLry+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782E21FF44;
	Tue,  2 Sep 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815751; cv=none; b=ANfAdlhBbbS2rua2MJfG17dXyQfCtnZmdO572kHNYD+hQQFxwLyYhhgHqQANIqYtzXWspnwMjrtMZzt7K60jCzqNtrp7LFmgUwBq6W3Y5KcS+kXRG88zwfcvf4XC5F7P/bxmZfxa9woezUxld/BcDjdfxKYfqF7P0YyYlVOX3xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815751; c=relaxed/simple;
	bh=WNvwZbGhhRwiEb2NPZN3SCJ15SAxBEIHxjUM1lFStyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uxgiwfy4+CyRUI1SZdcFYfiIPXmanFpk8QcNBH0t4iBEQvy/+xlFIgg6bOIdj2YDs2+vao2Z1gXxmMp6+y8GGYPkT0O8iZgqwnJI6B4kzIjt/92NVTh5o5tWcuRAgO0gzLTHrl3EDudg+JOuCmL6q0k19QGQJ5ZzAm+FWmuOQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjxLry+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3778AC4CEF9;
	Tue,  2 Sep 2025 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756815750;
	bh=WNvwZbGhhRwiEb2NPZN3SCJ15SAxBEIHxjUM1lFStyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjxLry+kEeJUnxV6320vUXHUgAtysOdDe1jnnqQakBn7XHkLy8IoCYiz8XaXyarnp
	 bWqO7UB1DMQbu6g/GNEI/9c683OShl1Tm5ybjq3HTAJ0dXNzeBgLPPvO/SE7jgcA6c
	 on9jzYxcdrpIA8yMU+NHVWtno+Lr2A3a7ziQdUWLsRYUGyi58FjZMBnWq/r9qjRrVt
	 moZAi2g3uJsCbVOi+L0c9EDWk68EAcF57Jl4mdwJ2fRqfB31D0uMEk7wcBGy/tp+kM
	 ZrDCqn2GQow2szfYXf3yfR8Z0EfenYPsDinvAIX+5UA855oKs6nUJqJgTB/whvPG1t
	 ttqlMwa6eVV5A==
Date: Tue, 2 Sep 2025 14:22:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Liu Ying <victor.liu@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Zijun Hu <quic_zijuhu@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/9] list: add list_last_entry_or_null()
Message-ID: <20250902-speedy-friendly-alpaca-f80709@houat>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
 <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-1-888912b0be13@bootlin.com>
 <aJJ9ttmL7wiw41fY@smile.fi.intel.com>
 <20250814183609.3788a6df@booty>
 <aKXRHAyfPHPpZmMs@smile.fi.intel.com>
 <20250902135709.19e1ef54@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ha3ss3lic4lbxxde"
Content-Disposition: inline
In-Reply-To: <20250902135709.19e1ef54@booty>


--ha3ss3lic4lbxxde
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/9] list: add list_last_entry_or_null()
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 01:57:09PM +0200, Luca Ceresoli wrote:
> Hello DRM maintainers,
>=20
> On Wed, 20 Aug 2025 16:43:56 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > On Thu, Aug 14, 2025 at 06:36:09PM +0200, Luca Ceresoli wrote:
> > > On Wed, 6 Aug 2025 00:55:02 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >  =20
> > > > On Fri, Aug 01, 2025 at 07:05:23PM +0200, Luca Ceresoli wrote: =20
> > > > > Add an equivalent of list_first_entry_or_null() to obtain the las=
t element
> > > > > of a list.   =20
> > > >=20
> > > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> =20
> > >=20
> > > Thanks Andy!
> > >=20
> > > However I'm not sure when and where this should be applied.
> > >=20
> > > Except for this one patch, all patches in the series are for
> > > drm-misc-next. Also, patch 1 is currently not needed by any other
> > > series AFAIK.
> > >=20
> > > Based on the above, is it correct to assume that the whole series can
> > > be applied on drm-misc-next? (when other patches will have a
> > > R-by/Ack-by of course)
> > >=20
> > > Also, is Andy's A-by enough to apply this patch? =20
> >=20
> > The list.h is common for many, I think going via DRM with my Ack is eno=
ugh
> > based on the Git history of my changes in this file. But if you want mo=
re
> > reliable source, get an Ack from Andrew Morton.
>=20
> While applying this patch with dim on drm-misc-next, dim push-branch
> failed because:
>=20
>   dim: ERROR: cb86408b1fc2 ("list: add list_last_entry_or_null()"): Manda=
tory Maintainer Acked-by missing., aborting
>=20
> Looking at the dim code, it is looking for a Reviewed- or Acked-by from
> people listed by `scripts/get_maintainer.pl --no-git-fallback -m --nol
> --norolestats`. but that command returns an empty string, so it will
> never allow me to push.
>=20
> How can I get that commit pushed to drm-misc-next?

Adding a MAINTAINERS entry for it would be nice too

Maxime

--ha3ss3lic4lbxxde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLbhewAKCRAnX84Zoj2+
dkQBAYDszpV6SGYWBTBgJCvIUpiseT/exARuDvzdOQmtFKiQnfCnA6jnGgP8dcxi
1t81QSABfjclCtf2qV5ucKcKjfmq3i46LSX4vnLy8fnGVrq09f1F1r8yuY2lSQs0
Cp9wkfBFxA==
=G+6D
-----END PGP SIGNATURE-----

--ha3ss3lic4lbxxde--

