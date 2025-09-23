Return-Path: <linux-kernel+bounces-828765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A06B9568F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE731896037
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5CF262FFC;
	Tue, 23 Sep 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1I7etC5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC462ECE86
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622531; cv=none; b=ZRs4+PutNG2fDgjTaUIRPfQMKMszll8TSA+CmT/W/1/F7ho2oR8Qf0aTKG9ZG1FDAbIc36Rh5gWCTNo60c6pPLmykpuF/sPn+kzjq8LcYZaF5Y4V4TBMRaqj+et3fVUYSzVLnajqJY2ycyUiXWfs3xGG+zHx15xOLq5r5mVMOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622531; c=relaxed/simple;
	bh=ZKeHLMCxFfMj54KKUsRxVMsUCENcLZ4thfkV5gL3HRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkQ2eykhTeo7CdzXhLSH/FaKeSwTNMN6OUs0CA0h4nTYqi6bbsim3dglbL9Fmfys7DpRb0KXKBi/BLJePNbzrFOAvQmePg9OCYC9OIix/pKvopH/spNa30tF3tusxmwQlozdzB2ccJSuc8w1mqgGdwRFlJH9SDbM8lpCUHx5L70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1I7etC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AE4C4CEF5;
	Tue, 23 Sep 2025 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758622529;
	bh=ZKeHLMCxFfMj54KKUsRxVMsUCENcLZ4thfkV5gL3HRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1I7etC5hrtOTSLHVLJi9j735HzbbgAlxFXlNeYw55HrVVgGDgsLztbtdrz4aqvM7
	 9SDHKjuixSucK9JNShan/XxpcmX+mEvFLD1da6Bjl5p1iaHBdDPc8PMFQCQY34cAFL
	 E7M5/CiOPOWEqkNCy3njqLusIyxM1QIaRUPxDB9bRRtu7qUXeLCRVz3bF2MNAt6TuQ
	 317VjMmuOF/oQGXB8SBkL2IBBiWrNg74PmFX21huwqcNIgvz9UcRaEqTKlPomjfmWL
	 PLFL9B7nEhsUPvIo5Zsu0wu/KtoMF8StfP22zAleCmwaYV23ehegm+zSVZS2FZ7gTd
	 /8t2EjGe2tt6A==
Date: Tue, 23 Sep 2025 12:15:26 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm/panic: Add a drm_panic/draw_test in debugfs
Message-ID: <20250923-smart-curly-muskrat-9acae7@penduick>
References: <20250908090341.762049-1-jfalempe@redhat.com>
 <20250908090341.762049-4-jfalempe@redhat.com>
 <20250910-astute-vole-of-kindness-c6f6ce@houat>
 <5af10ddf-26a4-4022-9bf3-ade739fe0f78@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="iyz3knbqty3vryra"
Content-Disposition: inline
In-Reply-To: <5af10ddf-26a4-4022-9bf3-ade739fe0f78@redhat.com>


--iyz3knbqty3vryra
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] drm/panic: Add a drm_panic/draw_test in debugfs
MIME-Version: 1.0

On Thu, Sep 11, 2025 at 02:00:42PM +0200, Jocelyn Falempe wrote:
> On 10/09/2025 12:49, Maxime Ripard wrote:
> > On Mon, Sep 08, 2025 at 11:00:31AM +0200, Jocelyn Falempe wrote:
> > > This adds a new drm_panic/draw_test file in debugfs.
> > > This file allows to test the panic screen rendering at different
> > > resolution and pixel format.
> > > It's useful only for kernel developers that want to create or
> > > customize a panic screen.
> > >=20
> > > If you want to check the result at 1024x768 using XRGB8888:
> > >=20
> > > cd /sys/kernel/debug/drm_panic/
> > > exec 3<> draw_test
> > > echo 1024x768:XR24 >&3
> > > cat <&3 > ~/panic_screen.raw
> > > exec 3<&-
> > >=20
> > > Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> >=20
> > I see what you meant in your previous version, and I misunderstood what
> > you were saying, sorry.
> >=20
> > > v2:
> > >   * Use debugfs instead of sending the framebuffer through the kunit =
logs. (Thomas Zimmermann).
> > >=20
> > >   drivers/gpu/drm/Kconfig     |   2 +
> > >   drivers/gpu/drm/drm_panic.c | 117 +++++++++++++++++++++++++++++++++=
+++
> > >   2 files changed, 119 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > > index f7ea8e895c0c..0d3146070d9c 100644
> > > --- a/drivers/gpu/drm/Kconfig
> > > +++ b/drivers/gpu/drm/Kconfig
> > > @@ -83,6 +83,8 @@ config DRM_PANIC_DEBUG
> > >   	  Add dri/[device]/drm_panic_plane_x in the kernel debugfs, to for=
ce the
> > >   	  panic handler to write the panic message to this plane scanout b=
uffer.
> > >   	  This is unsafe and should not be enabled on a production build.
> > > +	  Also adds a drm_panic/draw_test file in debugfs, to easily test t=
he
> > > +	  panic screen rendering.
> > >   	  If in doubt, say "N".
> > >   config DRM_PANIC_SCREEN
> > > diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> > > index d89812ff1935..0c01d6067eab 100644
> > > --- a/drivers/gpu/drm/drm_panic.c
> > > +++ b/drivers/gpu/drm/drm_panic.c
> > > @@ -873,6 +873,7 @@ static void drm_panic(struct kmsg_dumper *dumper,=
 struct kmsg_dump_detail *detai
> > >    */
> > >   #ifdef CONFIG_DRM_PANIC_DEBUG
> > >   #include <linux/debugfs.h>
> > > +#include <linux/vmalloc.h>
> > >   static ssize_t debugfs_trigger_write(struct file *file, const char =
__user *user_buf,
> > >   				     size_t count, loff_t *ppos)
> > > @@ -901,8 +902,122 @@ static void debugfs_register_plane(struct drm_p=
lane *plane, int index)
> > >   	debugfs_create_file(fname, 0200, plane->dev->debugfs_root,
> > >   			    plane, &dbg_drm_panic_ops);
> > >   }
> > > +
> > > +/*
> > > + * Draw test interface
> > > + * This can be used to check the panic screen at any resolution/pixe=
l format.
> > > + * The framebuffer memory is freed when the file is closed, so use t=
his sh
> > > + * script to write the parameters and read the result without closin=
g the file.
> > > + * cd /sys/kernel/debug/drm_panic/
> > > + * exec 3<> draw_test
> > > + * echo 1024x768:XR24 >&3
> > > + * cat <&3 > ~/panic_screen.raw
> > > + * exec 3<&-
> > > + */
> >=20
> > This should be documented properly, and I'm also kind of wondering how
> > that would fit in the larger testing ecosystem.
> >=20
> > Ie, how can someone that just starts contributing to Linux, or is
> > setting up a CI platform, can have that test running.
> >=20
> > kunit is great for that, kselftests to some extent too, but I'm not sure
> > an ad-hoc interface is.
>=20
> It's a bit harder to setup, but also allows to do some useful things.

I'm not saying that the original test has no use. I'm saying a test that
can't be discovered and run automatically is a lot less useful, and even
more so when it's using an ad-hoc interface.

Because that means that CI, all the other devs, etc. probably won't know
anything about it and you'll end up being the only one running the test.

That's why I've been insisting on a standard solution, because that
would solve that problem.

I still believe that your use-case is legit, and the test can be useful,
but it needs to be somewhat standard. Getting the opinion from the kunit
maintainers would be a great first step for example.

> I've written a small GUI application which displays the contents of the
> debugfs drm_panic/draw_test file in a window.
> The displayed content is automatically refreshed whenever the window is
> resized, making it easy to inspect the DRM panic output at any screen
> resolution.
> https://gitlab.com/kdj0c/panicviewer

And I'm sure that part is useful to you, I wonder if it's something that
should be upstream.

Maxime

--iyz3knbqty3vryra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaNJzPgAKCRAnX84Zoj2+
dnenAYDvugDqSH/vSd4uCFNH2CHMWv+X+/b5k0Y4ywNBmz7zTFuDy3LQIUvvLrtz
4gnABSMBfjMOK0BCb/f1bZvVztgKh5rVjwXPpdZGNZJuHxSIH1VRH4O9z1FD+0rb
XX8x3wgXnw==
=yfrk
-----END PGP SIGNATURE-----

--iyz3knbqty3vryra--

