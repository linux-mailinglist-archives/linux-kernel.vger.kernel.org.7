Return-Path: <linux-kernel+bounces-797154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ED6B40CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F409206D52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09B22E719C;
	Tue,  2 Sep 2025 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAxHDJj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FCC33CEB9;
	Tue,  2 Sep 2025 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835862; cv=none; b=ByBfKSjQODtK4/+p+FEzP/fjndF4EroHb4aaq4PGXN+pRLlP8HULHMMc8c+wmpecCjTFXFZ3kB7tP5HV++g+daVSE1tcCqSX1t07M/lQbz9i5cH1kT/TatixYO+APiCxGP18As4BOIAPqvnhZ0k9+W0eeRBCAsml6uAHLQ/yqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835862; c=relaxed/simple;
	bh=uHABCx0VqkfzurnmQC58wRTWxlIybKD4dg9qy2olHdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZSJrz5gXn/L9x9tMFGYwgDtDn26QYB/cwBRVsFzsCVe46AieloH7e25pe3J9j7P1/WHXaRi95uR9A26BRkkxIoK0VBHj1JxfTs4q0cqWgyYGsVgqg0j+UR5zrDR2nzL0iy6WsDLaNyBBRU4dirlzLSxMQscGBX3O67rLdi7Lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAxHDJj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21020C4CEED;
	Tue,  2 Sep 2025 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756835861;
	bh=uHABCx0VqkfzurnmQC58wRTWxlIybKD4dg9qy2olHdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAxHDJj+yaaPGDMpnDh4spc9d9yPjHCsp92rvLbeJEuET6c/6HRFgOdX3fFFs74Zr
	 CXHQpqBnnU/OXFRcUGOKTMLDRo4QWUCwFROJEzryIjjDp5PTe5v3wgxOHu6OuPGqr/
	 2O3LWJ1KyENaHoHorZm3lILBblPjiuSzJU5WDyVk/zWorplYRy/TZ/HEKl0qMQ3qM4
	 7luagzb/2egFB25WPd3Qb4WOKtKfxj6o1Eim1XfpkyW7vrWIo6FHaF0z9OM1wzdpo5
	 jGuDwiOSoKKHJnVIDXzDzev31XGHWEY8i7r7K8U1eQcAfO0dKBfbuxXbeVVAUrXukm
	 MyPb3S4bSV7ug==
Date: Tue, 2 Sep 2025 19:57:38 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, acourbot@nvidia.com, 
	daniel.almeida@collabora.com, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and
 infrastructure
Message-ID: <enuksb2qk5wyrilz3l2vnog45lghgmplrav5to6pd5k5owi36h@pxdq6y5dpgpt>
References: <20250901202850.208116-1-dakr@kernel.org>
 <humoafx7njwhvdwarelew2bwyl34q3ls5vbrkj6psfukoroni5@z7ap6mc4lj3k>
 <DCII677CICRL.2OCMSV7ESGTQ5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="k6igpdwgcafaqguy"
Content-Disposition: inline
In-Reply-To: <DCII677CICRL.2OCMSV7ESGTQ5@kernel.org>


--k6igpdwgcafaqguy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and
 infrastructure
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 07:49:56PM +0200, Danilo Krummrich wrote:
> On Tue Sep 2, 2025 at 7:40 PM CEST, Maxime Ripard wrote:
> > On Mon, Sep 01, 2025 at 10:26:39PM +0200, Danilo Krummrich wrote:
> >> Multiple DRM Rust drivers (e.g. nova-core, nova-drm, Tyr, rvkms) are in
> >> development, with at least Nova and (soon) Tyr already upstream. Havin=
g a
> >> shared tree will ease and accelerate development, since all drivers can
> >> consume new infrastructure in the same release cycle.
> >>=20
> >> This includes infrastructure shared with other subsystem trees (e.g. R=
ust
> >> or driver-core). By consolidating in drm-rust, we avoid adding extra
> >> burden to drm-misc maintainers, e.g. dealing with cross-tree topic
> >> branches.
> >>=20
> >> The drm-misc tree is not a good fit for this stage of development, sin=
ce
> >> its documented scope is small drivers with occasional large series.
> >>=20
> >> Rust drivers in development upstream, however, regularly involve large
> >> patch series, new infrastructure, and shared topic branches, which may
> >> not align well with drm-misc at this stage.
> >>=20
> >> The drm-rust tree may not be a permanent solution. Once the core Rust,
> >> DRM, and KMS infrastructure have stabilized, drivers and infrastructure
> >> changes are expected to transition into drm-misc or standalone driver
> >> trees respectively. Until then, drm-rust provides a dedicated place to
> >> coordinate development without disrupting existing workflows too much.
> >>=20
> >> Cc: Alice Ryhl <aliceryhl@google.com>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Simona Vetter <simona@ffwll.ch>
> >> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> Cc: Maxime Ripard <mripard@kernel.org>
> >> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
> >> Cc: Daniel Almeida <daniel.almeida@collabora.com>
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> ---
> >>  MAINTAINERS | 11 ++++++++++-
> >>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index fe168477caa4..1cd6597c7f1d 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -8079,7 +8079,6 @@ F:	Documentation/devicetree/bindings/gpu/
> >>  F:	Documentation/gpu/
> >>  F:	drivers/gpu/drm/
> >>  F:	drivers/gpu/vga/
> >> -F:	rust/kernel/drm/
> >>  F:	include/drm/drm
> >>  F:	include/linux/vga*
> >>  F:	include/uapi/drm/
> >> @@ -8096,6 +8095,16 @@ X:	drivers/gpu/drm/radeon/
> >>  X:	drivers/gpu/drm/tegra/
> >>  X:	drivers/gpu/drm/xe/
> >> =20
> >> +DRM DRIVERS AND COMMON INFRASTRUCTURE [RUST]
> >> +M:	Danilo Krummrich <dakr@kernel.org>
> >> +M:	Alice Ryhl <aliceryhl@google.com>
> >> +S:	Supported
> >> +W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-rust.html
> >> +T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git
> >> +F:	drivers/gpu/drm/nova/
> >> +F:	drivers/gpu/nova-core/
> >> +F:	rust/kernel/drm/
> >> +
> >
> > Would it make sense to add the drm-misc maintainers as reviewers for the
> > bindings?
>=20
> This will get you all the driver patches in your inbox as well, maybe
> discarding the following hunk is what we want instead?

I guess we would receive just as many patches as we do today :)

> 	@@ -8079,7 +8079,6 @@ F:	Documentation/devicetree/bindings/gpu/
> 	 F:	Documentation/gpu/
> 	 F:	drivers/gpu/drm/
> 	 F:	drivers/gpu/vga/
> 	-F:	rust/kernel/drm/
> 	 F:	include/drm/drm
> 	 F:	include/linux/vga*
> 	 F:	include/uapi/drm/

That's not really what I meant, what I meant was that rust/kernel/drm/
is the only thing I'm really interested on, but we don't need to
maintain it if it makes more sense to do so separately.

BTW, we should probably add to drm-misc

X: drivers/gpu/drm/nova

because we have a catch-all at the moment.

Maxime

--k6igpdwgcafaqguy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLcwEQAKCRAnX84Zoj2+
dlccAYDo9QYrxJCz0OhoOfPcIPgVc+XUoIj2Thx9znf/cTvLNYEaRcY/I0/HuCne
+XUOuCgBf2CpjVGBv2ii4XtIaC80SQ9raQ4m8QBGhKMPAVMSCTuVvOehQcFuZk7N
Gb2eLXotGw==
=8gSv
-----END PGP SIGNATURE-----

--k6igpdwgcafaqguy--

