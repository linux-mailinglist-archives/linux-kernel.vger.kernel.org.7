Return-Path: <linux-kernel+bounces-745943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72109B120C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597F21C839BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81D21FF2E;
	Fri, 25 Jul 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTzRehcB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008C77111;
	Fri, 25 Jul 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456970; cv=none; b=EdBmLanWAbZWlIMnZ4Odq/9c7YguZnmS2riaIowEACs9+AESxojccJGtj+TscF3u65w9Ns62pEpo5D+HLxVpJMlhhQPmWs2BdghQAYS/dSl1BFHho8+wD50KT3p6FNpPje8wR0Y3LyFVi4P4NpaYc7lTBzEL1U+CvmMnGHJzBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456970; c=relaxed/simple;
	bh=4z75SrHjXr50/yowMYxQ2DKjhdQt2pRb645trmsq8RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDYbU2qe1H/NE/v4hn305Cf2gOVJ0x8wzG+3DGX+GQexAZbaFHnr5z3mguzFOZHD4TV+aX3fSD37N15qATLZYwBNSieElMtX5AURjohQxe42VW1AI2gXHuhCAD9AItoxkp/8FnJhzEnW2ZPwJ0JJKLwlod4LigT063XL/H3Untc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTzRehcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1355BC4CEE7;
	Fri, 25 Jul 2025 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753456970;
	bh=4z75SrHjXr50/yowMYxQ2DKjhdQt2pRb645trmsq8RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTzRehcBUWafXpv9SEUoJ0axX3lmrWSZo5OtLNvx4ZP+AZO3gk0ueKK+c0zL72PKQ
	 wMymujh+bOV+wy6yZRSGqwdjIWFzovrSOaKXWKCTabs736O+wJTgINYtjXoSLXgH2X
	 Z25FBFYIJ6H/8t9BCFr/qtajJmn04JKvNyKzcYQUQZuvmJ4QffHDCe3GCs0DhtWdnZ
	 gTIAx8MH3qWaO1FfzZTTZZw11lvkgPE3MhaPqyDZWM6KPr122S6YzCtVIzRxT02YQm
	 8Y3kvFK+HFNSVVm0+YFkujflELRLsghC0wJPkSTD+OteEcAcwdPx2yNb7TNlrcdsQT
	 yot47ITOeyn5A==
Date: Fri, 25 Jul 2025 17:22:47 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 00/32] drm/mipi-dsi: avoid DSI host drivers to have
 pointers to DSI devices
Message-ID: <20250725-juicy-falcon-of-climate-d87ea6@houat>
References: <20250625-drm-dsi-host-no-device-ptr-v1-0-e36bc258a7c5@bootlin.com>
 <20250707-strange-warm-bear-cb4ee8@houat>
 <20250707115853.128f2e6f@booty>
 <20250707121319.1e40a73a@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ddlhwrl6lkvw5cd5"
Content-Disposition: inline
In-Reply-To: <20250707121319.1e40a73a@booty>


--ddlhwrl6lkvw5cd5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/32] drm/mipi-dsi: avoid DSI host drivers to have
 pointers to DSI devices
MIME-Version: 1.0

On Mon, Jul 07, 2025 at 12:13:19PM +0200, Luca Ceresoli wrote:
> Hi Maxime,
>=20
> ouch, e-mail sent by mistake unfinished and without proof-reading...
> well, let me continue it below.
>=20
> On Mon, 7 Jul 2025 11:58:53 +0200
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>=20
> > On Mon, 7 Jul 2025 08:16:49 +0200
> > Maxime Ripard <mripard@kernel.org> wrote:
> >=20
> > > Hi Luca,
> > >=20
> > > On Wed, Jun 25, 2025 at 06:45:04PM +0200, Luca Ceresoli wrote: =20
> > > > This series is the first attempt at avoiding DSI host drivers to ha=
ve
> > > > pointers to DSI devices (struct mipi_dsi_device), as discussed duri=
ng the
> > > > Linux Plumbers Conference 2024 with Maxime and Dmitry.
> > > >=20
> > > > It is working, but I consider this a draft in order to discuss and
> > > > challenge the proposed approach.
> > > >=20
> > > > Overall work
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > This is part of the work towards removal of bridges from a still ex=
isting
> > > > DRM pipeline without use-after-free. The grand plan as discussed in=
 [1].
> > > > Here's the work breakdown (=E2=9E=9C marks the current series):
> > > >=20
> > > >  1. =E2=80=A6 add refcounting to DRM bridges (struct drm_bridge)
> > > >     (based on devm_drm_bridge_alloc() [0])
> > > >     A. =E2=9C=94 add new alloc API and refcounting (in v6.16-rc1)
> > > >     B. =E2=9C=94 convert all bridge drivers to new API (now in drm-=
misc-next)
> > > >     C. =E2=9C=94 kunit tests (now in drm-misc-next)
> > > >     D. =E2=80=A6 add get/put to drm_bridge_add/remove() + attach/de=
tach()
> > > >          and warn on old allocation pattern (under review)
> > > >     E. =E2=80=A6 add get/put on drm_bridge accessors
> > > >        1. =E2=80=A6 drm_bridge_chain_get_first_bridge() + add a cle=
anup action
> > > >        2. =E2=80=A6 drm_bridge_chain_get_last_bridge()
> > > >        3. drm_bridge_get_prev_bridge()
> > > >        4. drm_bridge_get_next_bridge()
> > > >        5. drm_for_each_bridge_in_chain()
> > > >        6. drm_bridge_connector_init
> > > >        7. of_drm_find_bridge
> > > >        8. drm_of_find_panel_or_bridge, *_of_get_bridge
> > > >     F. debugfs improvements
> > > >  2. handle gracefully atomic updates during bridge removal
> > > >  3. =E2=9E=9C avoid DSI host drivers to have dangling pointers to D=
SI devices
> > > >       (this series)
> > > >  4. finish the hotplug bridge work, removing the "always-disconnect=
ed"
> > > >     connector, moving code to the core and potentially removing the
> > > >     hotplug-bridge itself (this needs to be clarified as points 1-3=
 are
> > > >     developed)
> > > >=20
> > > > [0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0cc6aad=
d7fc1e629b715ea3d1ba537ef2da95eec
> > > > [1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9=
d6f2c9c3058@bootlin.com/t/#u
> > > >=20
> > > > Motivation
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > The motivation for this series is that with hot-pluggable hardware =
a DSI
> > > > device can be disconnected from the DSI host at runtime, and later =
on
> > > > reconnected, potentially with a different model having different bus
> > > > parameters.
> > > >=20
> > > > DSI host drivers currently receive a struct mipi_dsi_device pointer=
 in the
> > > > attach callback and some store it permanently for later access to t=
he bur
> > > > format data (lanes, channel, pixel format etc). The stored pointer =
can
> > > > become dangling if the device is removed, leading to a use-after-fr=
ee.
> > > >=20
> > > > Currently the data exchange between DSI host and device happens pri=
marily
> > > > by two means:
> > > >=20
> > > >  * the device requests attach, detach and message transfer to the h=
ost by
> > > >    calling mipi_dsi_attach/detach/transfer which in turn call the c=
allbacks
> > > >    in struct mipi_dsi_host_ops
> > > >     - for this to work, struct mipi_dsi_device has a pointer to the=
 host:
> > > >       this is OK because the goal is supporting hotplug of the "rem=
ote"
> > > >       part of the DRM pipeline
> > > >  * the host accesses directly the fields of struct mipi_dsi_device,=
 to
> > > >    which it receives a pointer in the .attach and .detach callbacks
> > > >=20
> > > > The second bullet is the problematic one, which we want to remove.
> > > >=20
> > > > Strategy
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > I devised two possible strategies to address it:
> > > >=20
> > > >  1. change the host ops to not pass a struct mipi_dsi_device, but i=
nstead
> > > >     to pass only a copy of the needed information (bus format mainl=
y), so
> > > >     the host driver does never access any info from the device
> > > >    =20
> > > >  2. let the host get info from the device as needed, but without ha=
ving a
> > > >     pointer to it; this is be based on:
> > > >      - storing a __private mipi_dsi_device pointer in struct mipi_d=
si_host
> > > >      - adding getters to the DSI core for the host to query the nee=
ded
> > > >        info, e.g. drm_mipi_dsi_host_get_device_lanes(host) (the get=
ters
> > > >        would be allowed to dereference the device pointer)
> > > >=20
> > > > This series implements strategy 1. It does so by adding a .attach_n=
ew host
> > > > op, which does not take a mipi_dsi_device pointer, and converting m=
ost host
> > > > drivers to it. Once all drivers are converted, the old op can be re=
moved,
> > > > and .attach_new renamed to .attach.   =20
> > >=20
> > > I don't recall discussing this particular aspect at Plumbers, so sorry
> > > if we're coming back to the same discussion we had.
> > >=20
> > > I'm not necessarily opposed to changing the MIPI-DSI bus API, but I
> > > don't think changing the semantics to remove the fact that a particul=
ar
> > > device is connected or not is a good idea.
> > >=20
> > > I would have expected to have bus driver (maybe) take a device pointer
> > > at attach, and drop it at detach.
> > >=20
> > > Then, when we detect the hotplug of a DSI device, we detach it from i=
ts
> > > parent, and we're done.
> > >=20
> > > What prevents us from using that approach? =20
> >=20
> > I probably should have done a recap of the whole discussion, so let me
> > do it now.
> >=20
> > It all starts with one fact: a DSI device can be disconnected and then
> > a different one connected later on, having a different DSI bus format
> > (lanes, channel, mode flags, whatever). A detach/attach sequence would
> > handle that, but only in the simple case when there is a host/device
> > pair. Let's how consider this topology:
> >                                                      =20
> >                 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90                 =20
> >                 =E2=94=82    DSI bridge    =E2=94=82                 =
=20
> > =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90  A  =E2=94=82                  =E2=94=82  B =
 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> > =E2=94=82 DSI host=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=
=BA=E2=94=82device        host=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=96=BA=E2=94=82DSI device =E2=94=82
> > =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98     =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98     =E2=
=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> >                                                      =20
> > Here link A is always connected, link B is hot-pluggable. When the tail
> > device is removed and a different one plugged, a detach/attach sequence
> > can update the bus format on the DSI bridge, but then the DSI bridge
> > cannot update the format on the first host without faking a
> > detach/attach that does not map a real event.
> >=20
> > The above topology is probably not common, but it is exactly what the
> > hotplug-bridge introduces [0]. Whether the hotplug-bridge will have to
> > eventually exist or not to support hotplug is still to be defined, but
> > regardless there is another problematic aspect.
> >=20
> > The second problematic aspect is that several DSI host drivers will not
> > even drm_bridge_add() until they have an attached DSI device. One such
> > example is samsung-dsim, which calls drm_bridge_add()
> > in samsung_dsim_host_attach(). When such a driver implements the first
> > DSI host, the DSI bridge must register a DSI device before the DRM card
> > can be instantiated. See the lengthy comment before
> > hotplug_bridge_dsi_attach() in [0] for more gory details, but the
> > outcome is that the hotplug-bridge needs to attach a DSI device with
> > a fake format once initially just to let the DRM card probe, and the
> > detach and reattach with the correct format once an actual DSI device
> > is connected at the tail.
> >=20
> > [0] https://lore.kernel.org/all/20240917-hotplug-drm-bridge-v4-4-bc4dfe=
e61be6@bootlin.com/
> >=20
> > The above would be improved if the DSI host API provided a way to
> > notify to the host about a bus format change, which is however not
> > present currently.
> >=20
> > The naive solution would be adding a new DSI host op:
> >=20
> >  struct mipi_dsi_host_ops {
> >  	int (*attach)(struct mipi_dsi_host *host,
> >  		      struct mipi_dsi_device *dsi);
> >  	int (*detach)(struct mipi_dsi_host *host,
> >  		      struct mipi_dsi_device *dsi);
> > +	int (*bus_fmt_changed)(struct mipi_dsi_host *host,
> > + 		      struct mipi_dsi_device *dsi);
> >  	ssize_t (*transfer)(struct mipi_dsi_host *host,
> >  			    const struct mipi_dsi_msg *msg);
> >  };
> >=20
> > This would allow reduce the current sequence:
> >  1. attach with dummy format (no tail device yet)
> >  2. fake detach
> >  3. attach
> >=20
> > with:
> >  1. attach with dummy format (no tail device yet)
> >  2. update format
> >=20
> > Adding such a new op would be part of chapter 4 of this work, being it
> > quite useless without hotplug.
> >=20
> > However while reasoning about this I noticed the DSI host drivers peek
> > into the struct mipi_dsi_device fields to read the format, so there is
> > no sort of isolation between host and device. Introducing a struct to
> > contain all the format fields looked like a good improvement in terms
> > of code organization.
> >=20
> > Yet another aspect is that several host drivers keep a pointer to the
> > device, and thus in case of format change in the DSI device they might
> > be reading different fields at different moments, ending up with an
> > inconsistent format.
> >=20
> > The above considerations, which are all partially overlapped, led me to
> > the idea of introducing a struct to exchange a DSI bus format, to be
> > exchanged as a whole ("atomically") between host and device. What's
> > your opinion about introducing such a struct?
> >=20
> > The second aspect of this series is not passing pointers, and that's
> > the core topic you questioned. I realize it is not strictly necessary
> > to reach the various goals discussed in this e-mail. The work I'm doing
> > on the drm_bridge struct is actually a way to store a pointer while
> > avoiding use-after-free, so that can obviously be done for a simpler
> > scenario such as DSI host-device. However I thought not passing a
> > pointer would be a more radical solution: if a driver receives no
> > pointer, then it cannot by mistake keep it stored when it shouldn't,
> > maybe in a rare case within a complex driver where it is hard to spot.
> >=20
> > I'll be OK to change the approach and keep the pointer passed in the
> > attach/detach ops, if that is the best option. However I'd like to have
> > your opinion about the above topics before working towards that
> > direction, and ensure I fully grasp the usefulness of keeping the
> > pointer.
> >=20
> > Post scriptum. The very initial issue that led to all this discussion
> > when writing the hotplug-bridge driver is that the samsung-dsim driver
> > will not drm_bridge_add() until a DSI device does .attach to it. Again,
> > see the comments before hotplug_bridge_dsi_attach() in [0] for details.
> > However by re-examining the driver for the N-th time now from a new
> > POV, I _think_ this is not correct and potentially easy to solve. But t=
his leads to one fundamental question:
>=20
> The question is: should a DSI host bridge driver:
>=20
>  A) wait for a DSI device to .attach before drm_bridge_add()ing itself,
>     or
>  B) drm_bridge_add() itself unconditionally, and let the DSI device
>     .attach whenever it happens?
>=20
> A) is what many drivers (IIRC the majority) does. It implies the card
> will not be populated until .attach, which in the hotplug case could
> happen very late
>=20
> B) is done by a few drivers and allows the card to appear in the
> hotplug case without the device, which is needed for hotplug.
>=20
> I had tried simply moving drm_bridge_add() from .attach to probe in
> the samsung-dsim driver in the pase but that would not work. Now I did
> yet another check at the code and I suspect it can be done with a small
> additional change, but cannot access the hardware to test it currently.
>=20
> Answering this last question might change and simplify the requirements
> discussed in the (very lengthy, sorry about that) discussion above.

You're not going to like the answer too much, but I think that it is
that "nobody knows".

The bad news is that I can't give you an answer, but the good one is
that it gives us some leeway.

As I said in my previous mail, we should probably figure it out,
document it, and then make it work for your drivers. Once we have a
documentation we can point to, the rest will fall in line.

Maxime

--ddlhwrl6lkvw5cd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaIOhRwAKCRAnX84Zoj2+
djR9AXoC5sxOL3Rpwa6JrXxKaa23U9lWLzUq7rbwLs2xb+X6W5Tnx1KkRA+FMtDZ
9k3MvkcBfjArstgtzXd02zQd/+zYdN9NNnF4tPEsURfPJc+TF5/0kbCRLJn+XpUX
xMfFCbifZQ==
=8ClE
-----END PGP SIGNATURE-----

--ddlhwrl6lkvw5cd5--

