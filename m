Return-Path: <linux-kernel+bounces-798000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B44EB4183C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06020169914
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8F02DF716;
	Wed,  3 Sep 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPMgBxkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695F19C542
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887575; cv=none; b=BNeB6OEx6/8mTPHpD9zUtWfP00fqmgGBbZ10/Th6Q/ETwZAkk7XW3XHqiv7tPez+bz4yLUyutpFcpq2YZvjsMebRoOKPwkcZ7ABnb86St35iXzXRzIpb0dw4mHWDy0KTvhNz+gQlP8SNlkxubtCwlWpbUxbz20qKfiXYmNSRUF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887575; c=relaxed/simple;
	bh=ilN+/yAmoLmQjIzw3UStMiE7Qavd0DtdX0dNqv99F4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K28UqIqfB8Nj//5J89ye0+CM3ySljcyZLQRLg5YXAjWRO+ymhvIafgVFy9+0Q7F2bSotsAFgm655CCV654k1Ho/U1aXrOG5M0L3kqbPDeL8NnQTZCAGEN3csge1VWykatHGxEMA+vYjPazDDE8PeVMvOdgSCiUMUq/M2nAUNUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPMgBxkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA14C4CEF0;
	Wed,  3 Sep 2025 08:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756887574;
	bh=ilN+/yAmoLmQjIzw3UStMiE7Qavd0DtdX0dNqv99F4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPMgBxkXyGSAykeqqPV415F2hVWsKGG1mCM0w+itSw8TChsGfGmn4oQS/xxaflF22
	 XkIND2pDyun4knuAl6aqELJtLBDOBVA9Yinn7Z43l1PI8G6yleHd2tlVY4RtaGVwsl
	 SnMxEhNXrd4eiFy6bY2jOUmiQDUM7oMvjuqHy4DyCsL33vFRNoO/qGT7NRzxWObITa
	 T0voKb+BFT7ZOwqaPQKJyht/9U6b0JO4dBnZZeMhGxVlKpOa2jmVlVv7ZzgQKDQGs1
	 yk7STw5pNK9DkUHC1OtjVmtc2DQ8k+BmvUJ1Vhj6coDJ2GCSFYshG04ueerH9jBu07
	 7mBBex5a0LrHw==
Date: Wed, 3 Sep 2025 10:19:31 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/panic: Add a kconfig option to dump kunits
 results to png
Message-ID: <20250903-benevolent-boobook-of-wholeness-e631f9@penduick>
References: <20250821095228.648156-1-jfalempe@redhat.com>
 <20250821095228.648156-4-jfalempe@redhat.com>
 <923276d2-9240-48bd-95df-13b4e9e23dcd@suse.de>
 <7ff51c5b-939e-47d9-8c3b-3c596565d114@redhat.com>
 <pucvcimuuyz7f7ih7hx7l6bmutarlryvzwiqh7a26bk65ya5sf@uj7agoqm4lm3>
 <533c2197-d7bb-4294-a094-c4f993a5893c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="vwzls2bjg3vxobva"
Content-Disposition: inline
In-Reply-To: <533c2197-d7bb-4294-a094-c4f993a5893c@redhat.com>


--vwzls2bjg3vxobva
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] drm/panic: Add a kconfig option to dump kunits
 results to png
MIME-Version: 1.0

On Wed, Sep 03, 2025 at 09:30:23AM +0200, Jocelyn Falempe wrote:
> On 02/09/2025 18:58, Maxime Ripard wrote:
> > On Mon, Sep 01, 2025 at 03:04:26PM +0200, Jocelyn Falempe wrote:
> > > On 27/08/2025 12:45, Thomas Zimmermann wrote:
> > > > Hi
> > > >=20
> > > > Am 21.08.25 um 11:49 schrieb Jocelyn Falempe:
> > > > > This is a bit hacky, but very handy if you want to customize the
> > > > > panic screen.
> > > > > It allows to dump the generated images to the logs, and then a py=
thon
> > > > > script can convert it to .png files. It makes it easy to check how
> > > > > the panic screen will look on different resolutions, without havi=
ng
> > > > > to crash a VM.
> > > > > To not pollute the logs, it uses a monochrome framebuffer, compre=
ss
> > > > > it with zlib, and base64 encode it.
> > > >=20
> > > > May I suggest to export the raw image via debugfs? Debugfs can also
> > > > export additional information in additional files, such as width/he=
ight/
> > > > stride/format. This could provide the real/last image on the fly, s=
imply
> > > > by reading the files. No workarounds or encodings needed.
> > >=20
> > > I'm looking into that. The difficulty is to get the debugfs content o=
utside
> > > of the test kernel. As I'm using a uml kernel for testing, I will nee=
d a
> > > special initrd, and a way to share files with the host.
> >=20
> > Yeah, I agree that it's not very practical. If only because the test
> > context doesn't stick around once it's been executed, so you would
> > effectively leak an arbritrarily long buffer with no hope of getting
> > back its memory.
>=20
> I've made a prototype with debugfs, a small ramdisk with busybox, and usi=
ng
> hostfs to mount the host filesystem in the uml kernel, and it allows to d=
ump
> the raw panic buffer easily.
> Even if it's a bit more complex to setup, I think this use case is not
> really a kunit test, so it's probably better that way.
>=20
> Let me a few days to clean that up, and I will send a v2 of the kunit tes=
ts,
> and a new series to add a debugfs interface.
>=20
> Thanks for your reviews,

We also have to think about how it's going to be shipped and used. If
your debugfs integration has to be disabled everytime we're running
kunit through uml, qemu, and in CI (because we can't retrieve the
result), on a live system (because it would leak memory indefinitely),
how is it useful?

The diagnostic lines are part of the test result, are in the logs, and
can be distributed. You're having all those problems solved already,
without having any additional work to do.

Maxime

--vwzls2bjg3vxobva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaLf6EwAKCRAnX84Zoj2+
dmNbAYDbFTPY+oVjuG+Cjj9zFiJJv0tv/7KUMLP/wm+E+ln2A1cF8GQdaTl79Py/
3jfKKfYBgPD8z3ernIBP3zst6hvHqL+EWGPjcjgFieAo37hYbdYRLiLXCPY7zFGo
QN1zO/q9AA==
=+q2Z
-----END PGP SIGNATURE-----

--vwzls2bjg3vxobva--

