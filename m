Return-Path: <linux-kernel+bounces-787817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61EB37BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0348F7C16B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376631771E;
	Wed, 27 Aug 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhxgsoN3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A7279DA3;
	Wed, 27 Aug 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279823; cv=none; b=q5mT4GvhFIdy7Zv7FVVF/TayJvm1pDtl2sKDFq3NAPFh+8rYP0h9ibMQkqXzZ78hlOrqcHMk7Yo4SxmawmkpcG2CZ/ATBANsFmYdtVXgVYrNs7fUUyQa1vS3vvvysFCt3jePhqAsWzVYhQKEpQhj4s3oSGtBC7q9cCVf4AR/UsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279823; c=relaxed/simple;
	bh=DENKWc0ekq4UNDhRRQjwLrtYtoA+KfqAypfKZC86Eqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ3M/fZq0zYCl7OtbeNYnTF9iEFuw2xw29dChWVpQQnuBLlvvYT+Y0ujiqQK3wwJAsaOZpNOr0J4hTOk8vXJQzV6qPpe3hSqjZCgYJm6PaED5VTUXJG8PsryhE+f8Qb8qaajrKz8M7pdWyrwKhb/2sG+J/Na/26nK6/nQJcd21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhxgsoN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587B4C4CEEB;
	Wed, 27 Aug 2025 07:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756279822;
	bh=DENKWc0ekq4UNDhRRQjwLrtYtoA+KfqAypfKZC86Eqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhxgsoN3lmna/+JExixoNPap1mGT+zqpO8/iUSe0edBRPqG+uoL1AosmqpeX5IHTh
	 2chWd0LuCV5uA/wGXzLmitAFUDvq/N2tsQO6PHg3VWq7FgO8gIIqA6TBaSckSJRa5K
	 D/wIP3nU5H/MFsycCY/pxU8O00LxnYf2Rf4sYeMrQNL1vszte/bHWROoYjh07yq76F
	 kCIXEhSsvJvRwHGh8TO3/KAScj63Tkf8THgvAMfGKLUc202xART5lI5zoNuiRyDqH6
	 WtSV8ls84DVWfVSwbVY0+Ak+yUFRK6mcWFzICNSG3mLbZJ206lIt7L0gtlMiPrZDHv
	 XNBqbnNQJS+Tw==
Date: Wed, 27 Aug 2025 09:30:20 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Liu Ying <victor.liu@nxp.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/8] drm/connector: let drivers declare infoframes as
 unsupported
Message-ID: <20250827-adorable-ocelot-of-adventure-ba88b7@houat>
References: <20250819-drm-limit-infoframes-v2-0-7595dda24fbd@oss.qualcomm.com>
 <20250819-drm-limit-infoframes-v2-1-7595dda24fbd@oss.qualcomm.com>
 <20250820-artichoke-silkworm-of-election-521b5e@houat>
 <v7w7xkefm6ap7delx7wsvxmc76fwptqhe4ehokzfh4baueb7hr@acrx36exv42v>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="wgcccbljqt4firco"
Content-Disposition: inline
In-Reply-To: <v7w7xkefm6ap7delx7wsvxmc76fwptqhe4ehokzfh4baueb7hr@acrx36exv42v>


--wgcccbljqt4firco
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/8] drm/connector: let drivers declare infoframes as
 unsupported
MIME-Version: 1.0

Hi,

On Wed, Aug 20, 2025 at 12:52:44PM +0300, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 09:15:36AM +0200, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Tue, Aug 19, 2025 at 09:57:30PM +0300, Dmitry Baryshkov wrote:
> > > Currently DRM framework expects that the HDMI connector driver suppor=
ts
> > > all infoframe types: it generates the data as required and calls into
> > > the driver to program all of them, letting the driver to soft-fail if
> > > the infoframe is unsupported. This has a major drawback on userspace
> > > API: the framework also registers debugfs files for all Infoframe typ=
es,
> > > possibly surprising the users when infoframe is visible in the debugfs
> > > file, but it is not visible on the wire.
> > >=20
> > > Let drivers declare that they support only a subset of infoframes,
> > > creating a more consistent interface.
> > >=20
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >=20
> > I'm not really convinced. Infoframes aren't really something you should
> > ignore, AVI is effectively mandatory, HDMI kind of is too, AUDIO is if
> > audio support is enabled, DRM is mandatory if HDR is used.
>=20
> Nevertheless, sun4i, innohdmi, adv7511, it6263 and rk3066 drivers
> provide support only for the AVI infoframe.

Yes, but it's still something we shouldn't paper over. The spec mandates
it, if drivers want to deviate from it it's something we should warn
about, not silence.

sun4i is a good example, to me at least since I have the doc. The
hardware supports AVI, Audio, ACP, and SPD. HDR isn't supported, so DRM
isn't either. The only missing one is HDMI, but the documentation isn't
the best so it might still be supported. In short, it's a driver issue.

adv7511 supports AVI, Audio, ACP, SPD, ACP, and looks to have a
mechanism to send any infoframe as is. So, again, driver issue.

I couldn't find the other datasheet, but I'd be very surprised if it
wasn't the case for these too.

> Some of them can be extended to support other infoframe kinds (e.g.
> ADV7511 has two spare infoframes which can be used for HDMI and SPD).
>=20
> > SPD is indeed optional though.
> >=20
> > So, it's really dynamic in essence, and not really something we should
> > expect drivers to ignore.
> >=20
> > I do acknowledge that a lot of drivers just silently ignore the
> > infoframes they don't support at the moment, which isn't great either.
> >=20
> > Maybe we should standardize and document what drivers should do when
> > they don't support a given infoframe type?
>=20
> The chips might be generating infoframes internally. This series was
> triggered by LT9611UXC, which does all HDMI work under the hood in the
> firmware. See [1]. The series I posted hooks HDMI audio directly into
> the bridge driver, but I'd really prefer to be able to use
> drm_atomic_helper_connector_hdmi_hotplug(), especially if I ever get to
> implementing CEC support for it.
>=20
> ADV7511 likewise generates audio infoframe without Linux
> help (audio-related fields are programmed, but it's not the
> infoframe itself).

Implementing the write_infoframe hooks as a nop with a comment in those
case is totally reasonable to me.

I'd still like to document that drivers should only return 0 if they
programmed the infoframe, and -ENOTSUPP (and the core logging a warning)
otherwise.

That way, we would be able to differentiate between the legimitate
LT9611UXC case, and the "driver is broken" sun4i (and others) case.

Maxime

--wgcccbljqt4firco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaK60CAAKCRAnX84Zoj2+
dkbWAYCMfUjpHErZH+SQIgUybfgwR6GGsSh167v91iFWGWz8EJiwF3fqRZNLLMX0
Bs7dH+QBf3E+xTNLU4qS9e3zJulsSQ7EeLySYfsKG21vEhU0ndIesR3W4HshDPTR
mJeUGxkx9g==
=m9tf
-----END PGP SIGNATURE-----

--wgcccbljqt4firco--

