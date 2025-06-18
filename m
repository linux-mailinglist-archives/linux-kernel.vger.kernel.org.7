Return-Path: <linux-kernel+bounces-691611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74FADE6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 11:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C55163F05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE57280334;
	Wed, 18 Jun 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZDKThZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12994280A3B;
	Wed, 18 Jun 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238581; cv=none; b=oWKrgImmiLlE96iw1DQbaSNddX7ahsImJHxPR/+NIjtcpvf8ecRbaarXOht4WnkFNdwVS0boZZP4lsOuYkZ0jruip5RYo8WcVbvCPjtEXivEB5c5ZUmGwSQF6A8lmftTL9VamxbBGHcPFx7r96VUFdnPIPuAxIQvFri7QTg9wiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238581; c=relaxed/simple;
	bh=PSShPwrbGtVrVSCJQllIkymRaGdtic3I5Zg3vyJX9w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7QE8yAnlOojSFHTpoDXfFmSbR5cTr5e3ODUbomoYvjDieM9UkOYOj9TR3qt3AtXUI11fMoezZe+4X4xh7dNd70pjtjNoHnugyoMwKOnPjlW727ILeer0dIMTl3KexTkJWDwahuCG3ZdumYV2qlPPemoNUc/tSu39/5U/NvSsGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZDKThZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC17C4CEE7;
	Wed, 18 Jun 2025 09:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750238580;
	bh=PSShPwrbGtVrVSCJQllIkymRaGdtic3I5Zg3vyJX9w0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZDKThZgr9HUEW8OLQXxp8Z2odpNkMyaIKiZvNIlqBETxE7nwRe0TwSqlHm60wX4U
	 t1T1y/LCqbZLRY6hxIksIiTLfYtigVn30NjQAZJTDUYIh6SY28gAc71O+eJNYNyy36
	 ia6lhIKBuy/JzXwloIEhd6c69xk7jX+nbRsq0F2wO+Yp8lfF42p0eQeDBx6xCBefS0
	 h9RgTUekXbiHeOeH9biiPPp20CbE7JbbvONY5bRm1N3vXVaILIPinUOURPiFOBdF66
	 1DZeyP7Co/4ZJ4e98ENAUaZXymoB5XeJllN8Ph1ZIi7rS/d0oh+wdLSeSoXzUHfDd+
	 WzW66njYQtf+A==
Date: Wed, 18 Jun 2025 11:22:57 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Anusha Srivatsa <asrivats@redhat.com>, 
	Francesco Dolcini <francesco@dolcini.it>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: Re: drm/panel/panel-simple v6.16-rc1 WARNING regression
Message-ID: <20250618-fantastic-brown-elephant-df0ae4@houat>
References: <20250612081834.GA248237@francesco-nb>
 <CAN9Xe3RFEXZuWTZB5E1tJdjXc9o_hB1ArgA5SvqbDUBkwYea8w@mail.gmail.com>
 <20250618105158.06e42668@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="5wasac5pi2r2rga2"
Content-Disposition: inline
In-Reply-To: <20250618105158.06e42668@booty>


--5wasac5pi2r2rga2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: drm/panel/panel-simple v6.16-rc1 WARNING regression
MIME-Version: 1.0

On Wed, Jun 18, 2025 at 10:51:58AM +0200, Luca Ceresoli wrote:
> Hello Anusha, Francesco,
>=20
> On Tue, 17 Jun 2025 11:17:20 -0500
> Anusha Srivatsa <asrivats@redhat.com> wrote:
>=20
> > On Thu, Jun 12, 2025 at 3:24=E2=80=AFAM Francesco Dolcini <francesco@do=
lcini.it>
> > wrote:
> >=20
> > > Hello all,
> > >
> > > Commit de04bb0089a9 ("drm/panel/panel-simple: Use the new allocation =
in
> > > place of devm_kzalloc()")
> > > from 6.16-rc1 introduced a regression with this warning during probe
> > > with panel dpi described in the DT.
> > >
> > > A revert solves the issue.
> > >
> > > The issue is that connector_type is set to DRM_MODE_CONNECTOR_DPI in
> > > panel_dpi_probe() that after that change is called after
> > > devm_drm_panel_alloc().
> > >
> > > I am not sure if there are other implication for this change in the c=
all
> > > ordering, apart the one that triggers this warning.
> > >
> > > [   12.089274] ------------[ cut here ]------------
> > > [   12.089303] WARNING: CPU: 0 PID: 96 at
> > > drivers/gpu/drm/bridge/panel.c:377 devm_drm_of_get_bridge+0xac/0xb8
> > > [   12.130808] Modules linked in: v4l2_jpeg pwm_imx27(+) imx_vdoa
> > > gpu_sched panel_simple imx6_media(C) imx_media_common
> > > (C) videobuf2_dma_contig pwm_bl gpio_keys v4l2_mem2mem fuse ipv6 auto=
fs4
> > > [   12.147774] CPU: 0 UID: 0 PID: 96 Comm: kworker/u8:3 Tainted: G
> > >  C          6.16.0-rc1+ #1 PREEMPT
> > > [   12.157446] Tainted: [C]=3DCRAP
> > > [   12.160418] Hardware name: Freescale i.MX6 Quad/DualLite (Device T=
ree)
> > > [   12.166953] Workqueue: events_unbound deferred_probe_work_func
> > > [   12.172805] Call trace:
> > > [   12.172815]  unwind_backtrace from show_stack+0x10/0x14
> > > [   12.180598]  show_stack from dump_stack_lvl+0x68/0x74
> > > [   12.185674]  dump_stack_lvl from __warn+0x7c/0xe0
> > > [   12.190407]  __warn from warn_slowpath_fmt+0x1b8/0x1c0
> > > [   12.195567]  warn_slowpath_fmt from devm_drm_of_get_bridge+0xac/0x=
b8
> > > [   12.201949]  devm_drm_of_get_bridge from imx_pd_probe+0x58/0x164
> > > [   12.207976]  imx_pd_probe from platform_probe+0x5c/0xb0
> > > [   12.213220]  platform_probe from really_probe+0xd0/0x3a4
> > > [   12.218551]  really_probe from __driver_probe_device+0x8c/0x1d4
> > > [   12.224486]  __driver_probe_device from driver_probe_device+0x30/0=
xc0
> > > [   12.230942]  driver_probe_device from __device_attach_driver+0x98/=
0x10c
> > > [   12.237572]  __device_attach_driver from bus_for_each_drv+0x90/0xe4
> > > [   12.243854]  bus_for_each_drv from __device_attach+0xa8/0x1c8
> > > [   12.249614]  __device_attach from bus_probe_device+0x88/0x8c
> > > [   12.255285]  bus_probe_device from deferred_probe_work_func+0x8c/0=
xcc
> > > [   12.261739]  deferred_probe_work_func from process_one_work+0x154/=
0x2dc
> > > [   12.268371]  process_one_work from worker_thread+0x250/0x3f0
> > > [   12.274043]  worker_thread from kthread+0x12c/0x24c
> > > [   12.278940]  kthread from ret_from_fork+0x14/0x28
> > > [   12.283660] Exception stack(0xd0be9fb0 to 0xd0be9ff8)
> > > [   12.288720] 9fa0:                                     00000000 000=
00000
> > > 00000000 00000000
> > > [   12.296906] 9fc0: 00000000 00000000 00000000 00000000 00000000 000=
00000
> > > 00000000 00000000
> > > [   12.305089] 9fe0: 00000000 00000000 00000000 00000000 00000013 000=
00000
> > > [   12.312050] ---[ end trace 0000000000000000 ]---
> > >
> > > #regzbot ^introduced: de04bb0089a96cc00d13b12cbf66a088befe3057
> > >
> > > Any advise?
> > >
> > > Hey Francesco! =20
> >=20
> > This mail reached my spam and I hadn't realised till today. Thanks for
> > bringing this to attention.
> >
> > Thinking out loud here: If we called dpi_probe() before allocating the
> > panel using devm_drm_panel_alloc()
> > then we would have the connector type. But  dpi_probe() needs the panel=
 to
> > be allocated....
>=20
> Reading the panel-simple.c code, the handling of the panel_dsi
> descriptor feels a bit hacky, and the recent change to
> devm_drm_panel_alloc() breaks it easily. Perhaps it would be cleaner to
> assess the whole descriptor before ding any allocation/init.
>=20
> You're right tat panel_dpi_probe() needs the panel, but it's only at the
> very end, to assign the descriptor:
>=20
>   panel->desc =3D desc;
>=20
> I think a good fix would be to clean it up by having:
>=20
>  * panel_dpi_probe() not take a panel pointer but rather returning a
>    filled descriptor
>  * panel_simple_probe() call panel_dpi_probe() early [before
>    devm_drm_panel_alloc()] and get the filled descriptor
>  * call devm_drm_panel_alloc() with that descriptor in the panel-dsi
>    case, or with the good old descriptor otherwise
>=20
> As a good side effect, it would get rid of a case where
> devm_drm_panel_alloc() is called with a Unknown connector type.
>=20
> Anusha, does it look like a good plan?

It is, and I'd even go one step further. Like you said, panel_dpi_probe
kind of exists to allocate and initialize the panel descriptor, and is
called on the descriptor being equal to the (uninitialized) panel_dpi
global variable.

We should also get rid of that hack, so do something like creating a
function that returns the descriptor, and is indeed called first in
panel_simple_probe. It first calls of_device_get_match_data(), and if
there's no match, and if the device is compatible with panel-dpi, then
it calls panel_dpi_probe (we should probably change that name too). That
way, we can get rid of the panel_dpi variable entirely.

Maxime

--5wasac5pi2r2rga2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaFKFbQAKCRAnX84Zoj2+
diMrAX49jR2F5YwzXSIgY8Dc3IRNsN6JXUTfNI2yfEXLy7iLPI5ea2adZWpPTUcv
MK28sbkBfRtkWVWkCrzMpmrqfVY4o88+mqpQ3/RTxn5amR5o45qK/kpxhxQMNH8+
SNXe7JwvJw==
=ku/C
-----END PGP SIGNATURE-----

--5wasac5pi2r2rga2--

