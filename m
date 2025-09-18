Return-Path: <linux-kernel+bounces-809579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7B0B50F69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889217A99CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302227056D;
	Wed, 10 Sep 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H52COcov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034FE31D392;
	Wed, 10 Sep 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489423; cv=none; b=Ubq+L5D2YHj1FA4IAMTdIxo3KI/HUMtRS/kOeqOJilWan3RD2h6iFbF7EAcO9HfrWMDl8hRsxRjod44IJLGJqs6VGed4CHTUHwaZT0qOu4k3288qZMkoMx84oLZ6p2OKbIKTSnbDk0cm+OWGQL1IUUm2QZIE8EL4qLfwhUI9Qb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489423; c=relaxed/simple;
	bh=4M0n9dhFOjwBsj8qa6KbJmB5wbmUTZbKFbxuZfgxy5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2gqeVqj5rzxTmkfyr77vLJeswh+5e7ycY87ZTrIjoyQsTcB8XJiexjyd7n55VzyNv5nTHUtwQb1/qjhqL1/WctyxDQVAvolF0pIzCIRe41h1KqN4m4s4EvXH+DN/nv+wMZnzp/pJ25WVsEf/kshJxuRtdGJkljK2D9LZjaNjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H52COcov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F48C4CEF0;
	Wed, 10 Sep 2025 07:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757489422;
	bh=4M0n9dhFOjwBsj8qa6KbJmB5wbmUTZbKFbxuZfgxy5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H52COcovNyEFke9kN5TRvK+aXvcGWR0DW8t0vyXltz5YkgDgbdfmugoXAeNqj5n6l
	 4EdhUkZmusQ1bC3N02hSR4UAumXQZYg64Pup1df1R50HDGZVH+iyMXxcQT0dbAU6uT
	 sbm24X5W0+2OvonjNTX5qwj79dBfLUYXehFAf9iFWp24PRaNm2vfrkBd7JO8Zx+ktv
	 2j09guNySeBdqawEv2hoZq9ZzY+QmY9Xw4xP7T3AhYEvXbikCC+COb760BxC5U4Abo
	 XRcIpL1qW9ooSqdLXY+9j61tqnqOalFbz5MXw4PvtdB47nmwOV4wCgS+GLgnNnrTl4
	 3n/DfqBBqC48w==
Date: Wed, 10 Sep 2025 09:30:19 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Daniel Stone <daniel@fooishbar.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Liu Ying <victor.liu@nxp.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 00/11] drm/connector: hdmi: limit infoframes per
 driver capabilities
Message-ID: <20250910-didactic-honored-chachalaca-f233b2@houat>
References: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
 <CAPj87rNDtfEYV88Ue0bFXJwQop-zy++Ty7uQ9XfrQ2TbAijeRg@mail.gmail.com>
 <57ekub6uba7iee34sviadareqxv234zbmkr7avqofxes4mqnru@vgkppexnj6cb>
 <20250901-voracious-classy-hedgehog-ee28ef@houat>
 <voknqdv3zte2jzue5yxmysdiixxkogvpblvrccp5gu55x5ycca@srrcscly4ch4>
 <st6wob5hden6ypxt2emzokfhl3ezpbuypv2kdtf5zdrdhlyjfw@l2neflb4uupo>
 <pe6g2fanw65p67kfy5blbtiytngxmr6nkbazymojs4a66yvpl3@7j4ccnsvc6az>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="xcyykjy7tru36lrv"
Content-Disposition: inline
In-Reply-To: <pe6g2fanw65p67kfy5blbtiytngxmr6nkbazymojs4a66yvpl3@7j4ccnsvc6az>


--xcyykjy7tru36lrv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/11] drm/connector: hdmi: limit infoframes per
 driver capabilities
MIME-Version: 1.0

On Wed, Sep 03, 2025 at 03:03:43AM +0300, Dmitry Baryshkov wrote:
> On Tue, Sep 02, 2025 at 08:06:54PM +0200, Maxime Ripard wrote:
> > On Tue, Sep 02, 2025 at 06:45:44AM +0300, Dmitry Baryshkov wrote:
> > > On Mon, Sep 01, 2025 at 09:07:02AM +0200, Maxime Ripard wrote:
> > > > On Sun, Aug 31, 2025 at 01:29:13AM +0300, Dmitry Baryshkov wrote:
> > > > > On Sat, Aug 30, 2025 at 09:30:01AM +0200, Daniel Stone wrote:
> > > > > > Hi Dmitry,
> > > > > >=20
> > > > > > On Sat, 30 Aug 2025 at 02:23, Dmitry Baryshkov
> > > > > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > It's not uncommon for the particular device to support only a=
 subset of
> > > > > > > HDMI InfoFrames. It's not a big problem for the kernel, since=
 we adopted
> > > > > > > a model of ignoring the unsupported Infoframes, but it's a bi=
gger
> > > > > > > problem for the userspace: we end up having files in debugfs =
which do
> > > > > > > mot match what is being sent on the wire.
> > > > > > >
> > > > > > > Sort that out, making sure that all interfaces are consistent.
> > > > > >=20
> > > > > > Thanks for the series, it's a really good cleanup.
> > > > > >=20
> > > > > > I know that dw-hdmi-qp can support _any_ infoframe, by manually
> > > > > > packing it into the two GHDMI banks. So the supported set there=
 is
> > > > > > 'all of the currently well-known ones, plus any two others, but=
 only
> > > > > > two and not more'. I wonder if that has any effect on the inter=
face
> > > > > > you were thinking about for userspace?
> > > > >=20
> > > > > I was mostly concerned with the existing debugfs interface (as it=
 is
> > > > > also used e.g. for edid-decode, etc).
> > > > >=20
> > > > > It seems "everything + 2 spare" is more or less common (ADV7511, =
MSM
> > > > > HDMI also have those. I don't have at hand the proper datasheet f=
or
> > > > > LT9611 (non-UXC one), but I think its InfoFrames are also more or=
 less
> > > > > generic).  Maybe we should change debugfs integration to register=
 the
> > > > > file when the frame is being enabled and removing it when it gets=
 unset.
> > > >=20
> > > > But, like, for what benefit?
> > > >=20
> > > > It's a debugfs interface for userspace to consume. The current setup
> > > > works fine with edid-decode already. Why should we complicate the d=
esign
> > > > that much and create fun races like "I'm running edid-decode in par=
allel
> > > > to a modeset that would remove the file I just opened, what is the =
file
> > > > now?".
> > >=20
> > > Aren't we trading that with the 'I'm running edid-decode in paralle w=
ith
> > > to a modeset and the file suddenly becomes empty'?
> >=20
> > In that case, you know what the file is going to be: empty. And you went
> > from a racy, straightforward, design to a racy, complicated, design.
> >=20
> > It was my question before, but I still don't really see what benefits it
> > would have, and why we need to care about it in the core, when it could
> > be dealt with in the drivers just fine on a case by case basis.
>=20
> Actually it can not: debugfs files are registered from the core, not
> from the drivers. That's why I needed all the supported_infoframes
> (which later became software_infoframes).

That's one thing we can change then.

> Anyway, I'm fine with having empty files there.
>=20
> > > > > Then in the long run we can add 'slots' and allocate some of the =
frames
> > > > > to the slots. E.g. ADV7511 would get 'software AVI', 'software SP=
D',
> > > > > 'auto AUDIO' + 2 generic slots (and MPEG InfoFrame which can prob=
ably be
> > > > > salvaged as another generic one)). MSM HDMI would get 'software A=
VI',
> > > > > 'software AUDIO' + 2 generic slots (+MPEG + obsucre HDMI which I =
don't
> > > > > want to use). Then the framework might be able to prioritize whet=
her to
> > > > > use generic slots for important data (as DRM HDR, HDMI) or less i=
mportant
> > > > > (SPD).
> > > >=20
> > > > Why is it something for the framework to deal with? If you want to =
have
> > > > extra infoframes in there, just go ahead and create additional debu=
gfs
> > > > files in your driver.
> > > >=20
> > > > If you want to have the slot mechanism, check in your atomic_check =
that
> > > > only $NUM_SLOT at most infoframes are set.
> > >=20
> > > The driver can only decide that 'we have VSI, SPD and DRM InfoFrames
> > > which is -ETOOMUCH for 2 generic slots'. The framework should be able=
 to
> > > decide 'the device has 2 generic slots, we have HDR data, use VSI and
> > > DRM InfoFrames and disable SPD for now'.
> >=20
> > I mean... the spec does? The spec says when a particular feature
> > requires to send a particular infoframe. If your device cannot support
> > to have more than two "features" enabled at the same time, so be it. It
> > something that should be checked in that driver atomic_check.
>=20
> Sounds good to me. Let's have those checks in the drivers until we
> actually have seveal drivers performing generic frame allocation.
>=20
> > Or just don't register the SPD debugfs file, ignore it, put a comment
> > there, and we're done too.
>=20
> It's generic code.
>=20
> > > But... We are not there yet and I don't have clear usecase (we support
> > > HDR neither on ADV7511 nor on MSM HDMI, after carefully reading the
> > > guide I realised that ADV7511 has normal audio infoframes). Maybe I
> > > should drop all the 'auto' features, simplifying this series and land
> > > [1] for LT9611UXC as I wanted origianlly.
> > >=20
> > > [1] https://lore.kernel.org/dri-devel/20250803-lt9611uxc-hdmi-v1-2-cb=
9ce1793acf@oss.qualcomm.com/
> >=20
> > Looking back at that series, I think it still has value to rely on the
> > HDMI infrastructure at the very least for the atomic_check sanitization.
> >=20
> > But since you wouldn't use the generated infoframes, just skip the
> > debugfs files registration. You're not lying to userspace anymore, and
> > you get the benefits of the HDMI framework.
>=20
> We create all infoframe files for all HDMI connectors.

Then we can provide a debugfs_init helper to register all of them, or
only some of them, and let the drivers figure it out.

Worst case scenario, debugfs files will not get created, which is a much
better outcome than having to put boilerplate in every driver that will
get inconsistent over time.

Maxime

--xcyykjy7tru36lrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaMEpAwAKCRAnX84Zoj2+
dk8gAX9rbNWwNIwKSB0+wgpd+2lgIwy4gt6EhhgTtTz3dzSxqsa2u+1FhrsGsBJE
FiMw/LgBgIGnPFV/ZqY6NuZQ8Z6fwsK5cORWCjwaLn48kjvnTHE5U3qynIeE7xuQ
mP9pD1yh4A==
=X/3+
-----END PGP SIGNATURE-----

--xcyykjy7tru36lrv--

