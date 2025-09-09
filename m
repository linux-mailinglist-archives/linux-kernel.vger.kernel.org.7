Return-Path: <linux-kernel+bounces-807446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719EB4A46F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D387A7C52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8598A2459DC;
	Tue,  9 Sep 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEynhRL8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8723C8C5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404895; cv=none; b=FQapYmx3UZB2YhwWg6Bsxl+gBRvbZIkAz35cc4UNVmj04CDZ6QpP1jBibRd0POhhQOzfTbZVIEJfzZIuP4/wRyt6HXHWD7iMXJaCTTSB/g28teoXbJe/Fg2Syc7F7gb9tDiZyjhEXcawWnGpJSDURiVmHHURS71fR9SPo03HHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404895; c=relaxed/simple;
	bh=bcZVfOq80qu/TOnn+urm5zcjgjtAMvg5UbHv0Vn5SEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he8wrHU4B9PUWbzwZs9OvGvFG+QkpfVulsc3fiM+wkV99DnCqjfxLZQDr9XM3hGX7D4yZAmHxb0cNpXGgv/G1G7s1zCyFY4ABtlI7vfoN8yd75SxhHWLY42JmagOTmNo2DDeviX1fgXppfnLZjsg8FwxVp95SpPgZwuKBcUIbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEynhRL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B78DC4CEF4;
	Tue,  9 Sep 2025 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757404895;
	bh=bcZVfOq80qu/TOnn+urm5zcjgjtAMvg5UbHv0Vn5SEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rEynhRL8qtfRJ4RO/BOjwkiwy94MggKyZxp0l6x5fbvLP60OmqT7vk15aWOgVy5kl
	 D7zMtbswcgpxQkylG1OgUcVIpNqsNuxjwLruQNOyWJIzTORsOphve171gBsBg7G3Ft
	 BsmJkmn9n8HZimHPs6OZPKo8r3E1eBBlsTQ3IW8DhkKAbrEzTMKgl2qdL3namjr6oZ
	 Yzdkk/X7L3y80l3Lqe8nL2oyjMNuwWu5yJTUK94PxHWuu4YkwKM1Bvdr2LfLMIIm0u
	 QAQ7mUKGP8ZPAOBkYMnA5OTV/sABm3Z8IFlKo63EpEFKErMabi5zv1fBNFX5MvsO/U
	 dJSy+2VWseRYw==
Date: Tue, 9 Sep 2025 10:01:32 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/panic: Add a kconfig option to dump kunits
 results to png
Message-ID: <20250909-terrestrial-straight-piculet-c43bd6@houat>
References: <20250821095228.648156-1-jfalempe@redhat.com>
 <20250821095228.648156-4-jfalempe@redhat.com>
 <923276d2-9240-48bd-95df-13b4e9e23dcd@suse.de>
 <7ff51c5b-939e-47d9-8c3b-3c596565d114@redhat.com>
 <pucvcimuuyz7f7ih7hx7l6bmutarlryvzwiqh7a26bk65ya5sf@uj7agoqm4lm3>
 <533c2197-d7bb-4294-a094-c4f993a5893c@redhat.com>
 <20250903-benevolent-boobook-of-wholeness-e631f9@penduick>
 <a8af8630-043f-4bdf-af77-8f02f992f221@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="o6d4z2qt3pvcr4ev"
Content-Disposition: inline
In-Reply-To: <a8af8630-043f-4bdf-af77-8f02f992f221@redhat.com>


--o6d4z2qt3pvcr4ev
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] drm/panic: Add a kconfig option to dump kunits
 results to png
MIME-Version: 1.0

On Mon, Sep 08, 2025 at 10:55:17AM +0200, Jocelyn Falempe wrote:
> On 03/09/2025 10:19, Maxime Ripard wrote:
> > On Wed, Sep 03, 2025 at 09:30:23AM +0200, Jocelyn Falempe wrote:
> > > On 02/09/2025 18:58, Maxime Ripard wrote:
> > > > On Mon, Sep 01, 2025 at 03:04:26PM +0200, Jocelyn Falempe wrote:
> > > > > On 27/08/2025 12:45, Thomas Zimmermann wrote:
> > > > > > Hi
> > > > > >=20
> > > > > > Am 21.08.25 um 11:49 schrieb Jocelyn Falempe:
> > > > > > > This is a bit hacky, but very handy if you want to customize =
the
> > > > > > > panic screen.
> > > > > > > It allows to dump the generated images to the logs, and then =
a python
> > > > > > > script can convert it to .png files. It makes it easy to chec=
k how
> > > > > > > the panic screen will look on different resolutions, without =
having
> > > > > > > to crash a VM.
> > > > > > > To not pollute the logs, it uses a monochrome framebuffer, co=
mpress
> > > > > > > it with zlib, and base64 encode it.
> > > > > >=20
> > > > > > May I suggest to export the raw image via debugfs? Debugfs can =
also
> > > > > > export additional information in additional files, such as widt=
h/height/
> > > > > > stride/format. This could provide the real/last image on the fl=
y, simply
> > > > > > by reading the files. No workarounds or encodings needed.
> > > > >=20
> > > > > I'm looking into that. The difficulty is to get the debugfs conte=
nt outside
> > > > > of the test kernel. As I'm using a uml kernel for testing, I will=
 need a
> > > > > special initrd, and a way to share files with the host.
> > > >=20
> > > > Yeah, I agree that it's not very practical. If only because the test
> > > > context doesn't stick around once it's been executed, so you would
> > > > effectively leak an arbritrarily long buffer with no hope of getting
> > > > back its memory.
> > >=20
> > > I've made a prototype with debugfs, a small ramdisk with busybox, and=
 using
> > > hostfs to mount the host filesystem in the uml kernel, and it allows =
to dump
> > > the raw panic buffer easily.
> > > Even if it's a bit more complex to setup, I think this use case is not
> > > really a kunit test, so it's probably better that way.
> > >=20
> > > Let me a few days to clean that up, and I will send a v2 of the kunit=
 tests,
> > > and a new series to add a debugfs interface.
> > >=20
> > > Thanks for your reviews,
> >=20
> > We also have to think about how it's going to be shipped and used. If
> > your debugfs integration has to be disabled everytime we're running
> > kunit through uml, qemu, and in CI (because we can't retrieve the
> > result), on a live system (because it would leak memory indefinitely),
> > how is it useful?
>=20
> There is already a kconfig for this:
> CONFIG_DRM_PANIC_DEBUG
>=20
> Also I have an implementation that doesn't leak memory. (memory is freed
> when the debugfs file is closed).

So, if userspace completely ignores it, you still leak it.

> It's also more flexible, as you can change the parameters, and test any
> color format, and check the binary result.
>
> I think the goal of this is not to test for regression, but to help build=
ing
> a new panic screen.
>=20
> >=20
> > The diagnostic lines are part of the test result, are in the logs, and
> > can be distributed. You're having all those problems solved already,
> > without having any additional work to do.
>=20
> I feel sending an image through log is not really efficient, and I don't
> want to pollute all the CI with that.

Then maybe we should just ignore that part of your series for now. But
having a framebuffer lingering around in the system is a no-go for me.

Maxime

--o6d4z2qt3pvcr4ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaL/e3AAKCRAnX84Zoj2+
dqa9AX9CSd77qO/zlLhEcfLt73HTXykkutqLOtMcqS+DkcFeWRIU3WcytY4PPbZI
t3wfqAABgKNiQjdb/kmueqmI0k5Z7TkHESfwUoUnUbIKHhtaakfM5Raj7uwqDwaW
uKA8AoxpPQ==
=r/32
-----END PGP SIGNATURE-----

--o6d4z2qt3pvcr4ev--

