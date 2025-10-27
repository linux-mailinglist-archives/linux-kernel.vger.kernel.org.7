Return-Path: <linux-kernel+bounces-872223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6077AC0F9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B60D464473
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977463164A8;
	Mon, 27 Oct 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiRZpR7E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A8315D4E;
	Mon, 27 Oct 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585556; cv=none; b=nkjUIfGgfX9eteGTxcxPeM4bve274joG6wxtD+v/I+MBs4a58kEUzYmS3YCE6oueLmuuSGfs67Mk0SoUHSATv1G3ZnCFxhF0cWFvYrLD1Pmhz0uIRzBtD/oW1Ok54IMpi0cYbSXWnGmYyFSDZDElP03shOxxLu/yj2vWBMj06eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585556; c=relaxed/simple;
	bh=PCbERfcgvUw2fEkvsMjdinpQ0b6sj2+DSxOZAwZ+8yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Md5EIeQDncvUTALbbrBcT0ujkMHcTH6o/je5UbESsu+dMq+6ZRmli0kx7nxf6XHOwXMbw2SgjLUb3KSjUwLnQuRm6BT766qedm+aLhvYkUZDBtqbC74A/3OF0Lr2r08nNEl3QwfMvSQgAnrMyvVtLg1wzn2vXAbqw4emaPeFXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiRZpR7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C25C4CEFD;
	Mon, 27 Oct 2025 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761585555;
	bh=PCbERfcgvUw2fEkvsMjdinpQ0b6sj2+DSxOZAwZ+8yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiRZpR7E5aEAnwZeinP27w+be99PhDiZzT8O7biKazF1E833weB+2RLr+k1k2L2yL
	 ibl+3ks3p3Pw2FNFBpo95EEC+6oSTqcQylsRFQdSEFEJWzRnMbwvLjUD9ITmcnNX8i
	 Rnut5ejGe1gb6UlGDKqulgSz8JEa6vgn6zkMYGwt+Cn6nHegXxRMOEFXKe6vz22yJf
	 tkUPxeX0I9MJvOhiD8CGvIYT9v/OglhBRaCZeGkVCDwX+kLVMasHvsT9fmQI4A6K3B
	 5gg+o5yfujWLqKKd25aazvhpxPCTRRHNC+cWQ05GPjlkNoJP+kRq3a3F/0LoeEYmXW
	 hA1wusUyBvGOg==
Date: Mon, 27 Oct 2025 18:19:12 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
	Francesco Valla <francesco@valla.it>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
Message-ID: <23clcxtgbzbsji2knwp47xdc5udj7lnhbvzsgqi3vklvmhdgjd@26ycx2ed77l4>
References: <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>
 <yq4btdc5qqukuqps7y53dratmu64ghyifgprlndnk5rbgml4of@rvca75sncvsm>
 <3edea192-6a3f-44f5-b570-7033776e2ce4@suse.de>
 <5ff10f7d-e9d4-4d4d-ae82-8986dc28d14b@amd.com>
 <i7xxy33do4q4odvxxb77xv4ri5jgr6dup5kvfsjfs4h7mbmhrj@h3ke7h5whyvx>
 <93cbbaef-918f-4300-aa5b-11f098e217b2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="swebmu2gokkv3szx"
Content-Disposition: inline
In-Reply-To: <93cbbaef-918f-4300-aa5b-11f098e217b2@amd.com>


--swebmu2gokkv3szx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
MIME-Version: 1.0

On Mon, Oct 27, 2025 at 11:31:06AM -0500, Mario Limonciello wrote:
> On 10/27/25 11:28 AM, Maxime Ripard wrote:
> > On Mon, Oct 27, 2025 at 11:01:55AM -0500, Mario Limonciello wrote:
> > > On 10/27/25 7:35 AM, Thomas Zimmermann wrote:
> > > > > >  =A0=A0 - a very simple progress bar, which can be driven throu=
gh sysfs;
> > > >=20
> > > > Once you have options to control these settings from user space, you
> > > > should do it in user space entirely. As Maxime suggested, please im=
prove
> > > > plymouth for anything with animation.
> > > >=20
> > > > > >  =A0=A0 - a static image (optional).
> > > >=20
> > > > Board vendors often provide an image, see /sys/firmware/acpi/bgrt/.=
 This
> > > > is a candidate for display, or the penguin or a custom image. Please
> > > > make it configurable by Kconfig. Again, if you need policy and
> > > > heuristics for deciding what to display, you better do this in user
> > > > space.
> > >=20
> > > I'd actually argue that the static image from BGRT should be the pref=
erred
> > > priority.  This can make for a nice hand off to Plymouth.
> > >=20
> > > The (UEFI) BIOS already will show this image as soon as the GOP drive=
r is
> > > loaded.  Bootloaders like GRUB by default will avoid showing anything=
 or
> > > will overwrite with the exact same image in the same location.  This =
can let
> > > the kernel do the same, and then the moment Plymouth takes over it co=
uld do
> > > the same.
> >=20
> > And BGRT isn't typically found on embedded systems at all, so I'm not
> > sure it's a sensible default, let alone a priority. At most a possible
>=20
> There are certainly embedded machines using UEFI and that have a BGRT.

Yes, indeed, hence the "typically".

> How about "Sensible default the top of the priority list if it exists"

How about we don't tell contributors what their priorities must be?

Maxime

--swebmu2gokkv3szx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaP+pkAAKCRAnX84Zoj2+
drPKAX49FE7QjngVHnA1mf13kfP6ZKCacCVX6G4v2AsdFZMFqxax8CsyueLnuT1S
O6YBTKQBf2etLxgBAFSiJ0S7jwoNmkZNnFyjp3NcIMTrXmNibOnyBfRHK+RSa2KF
u0BJYIAKYg==
=qXHe
-----END PGP SIGNATURE-----

--swebmu2gokkv3szx--

