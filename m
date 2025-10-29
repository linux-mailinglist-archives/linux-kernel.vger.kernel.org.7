Return-Path: <linux-kernel+bounces-875507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B9C19241
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBF98502962
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6B3128DA;
	Wed, 29 Oct 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjrgF0fd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE6A1B3923;
	Wed, 29 Oct 2025 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726999; cv=none; b=puMt+t9rClxlaeirMvwI4DW38iW7/2UdTJeaPdxI7fPuslf6J45X4S/wHw0dSCNqjP8/wCp+3Rech2NXW++FwFjlVZerb4yFk5hBgMidN1psCJop+OsduO/Um3EsK+VxX+HhU721HOk+oslvJICkiUK9cHEyoUxtmkfndXqKK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726999; c=relaxed/simple;
	bh=1rKtagzqCuyPPLrsSkpbDvAK+y4SdzCtc2efQBAaXAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiwQ/4xsmHJv8gKlJ3voQWDYT0HbLlyz2Pc/mehaS3QnZ1IORTCFfPyFqTzsXwQPAxQQevmj9QrjMilDIxaXyOtL9CX8d33Y9HcPlRjkY83Yvrg7UUFhH8L11td+bli8jhAKvURZIhpZMp0WHA6JzAVVX6K8O9WN6k6swPxLurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjrgF0fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE9EC4CEF7;
	Wed, 29 Oct 2025 08:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761726999;
	bh=1rKtagzqCuyPPLrsSkpbDvAK+y4SdzCtc2efQBAaXAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjrgF0fd1Kw6Rz/hY36Ug6cppaVasCKMFiUTxVsnD3ZwCCquW0JgNgsQDWQSn45OE
	 Ka0U3KcchPWlwJIPDtlcSxauweiv26U0K2RSuHGHNvbSvVN3rPFhoJiw6En9H+vohz
	 siC6P4OCbcdk8RO9aqg1erGf7NO7aAPETSdrJnptKWiRf7Yz6GwkEfk8fV46BeScQD
	 /8nAN1DKNAPffKgftlEfRuZMKmg89xw5c0PgezIaPpF6FX5ef9sYeYzjB32cENm+fh
	 1bhzcG8iM9dAI3va4KS8UeT2cE3RaCoQtuBs0QphWVLSSrITEEYgiXxEIq6Q+tuwcp
	 6/yj+oZjlV1vA==
Date: Wed, 29 Oct 2025 09:36:35 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
Message-ID: <4uknyhx7lshybin3qjdyh7oq6udtdw3lqagumg6w6qjre3pn55@23c5itmo55f5>
References: <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>
 <93cbbaef-918f-4300-aa5b-11f098e217b2@amd.com>
 <23clcxtgbzbsji2knwp47xdc5udj7lnhbvzsgqi3vklvmhdgjd@26ycx2ed77l4>
 <4497733.UPlyArG6xL@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="escnxwlco7olhzqd"
Content-Disposition: inline
In-Reply-To: <4497733.UPlyArG6xL@fedora.fritz.box>


--escnxwlco7olhzqd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 09:09:06AM +0100, Francesco Valla wrote:
> Hi,
>=20
> On Monday, 27 October 2025 at 18:19:12 Maxime Ripard <mripard@kernel.org>=
 wrote:
> > On Mon, Oct 27, 2025 at 11:31:06AM -0500, Mario Limonciello wrote:
> > > On 10/27/25 11:28 AM, Maxime Ripard wrote:
> > > > On Mon, Oct 27, 2025 at 11:01:55AM -0500, Mario Limonciello wrote:
> > > > > On 10/27/25 7:35 AM, Thomas Zimmermann wrote:
> > > > > > > >     - a very simple progress bar, which can be driven throu=
gh sysfs;
> > > > > >=20
> > > > > > Once you have options to control these settings from user space=
, you
> > > > > > should do it in user space entirely. As Maxime suggested, pleas=
e improve
> > > > > > plymouth for anything with animation.
> > > > > >=20
> > > > > > > >     - a static image (optional).
> > > > > >=20
> > > > > > Board vendors often provide an image, see /sys/firmware/acpi/bg=
rt/. This
> > > > > > is a candidate for display, or the penguin or a custom image. P=
lease
> > > > > > make it configurable by Kconfig. Again, if you need policy and
> > > > > > heuristics for deciding what to display, you better do this in =
user
> > > > > > space.
> > > > >=20
> > > > > I'd actually argue that the static image from BGRT should be the =
preferred
> > > > > priority.  This can make for a nice hand off to Plymouth.
> > > > >=20
> > > > > The (UEFI) BIOS already will show this image as soon as the GOP d=
river is
> > > > > loaded.  Bootloaders like GRUB by default will avoid showing anyt=
hing or
> > > > > will overwrite with the exact same image in the same location.  T=
his can let
> > > > > the kernel do the same, and then the moment Plymouth takes over i=
t could do
> > > > > the same.
> > > >=20
> > > > And BGRT isn't typically found on embedded systems at all, so I'm n=
ot
> > > > sure it's a sensible default, let alone a priority. At most a possi=
ble
> > >=20
> > > There are certainly embedded machines using UEFI and that have a BGRT.
> >=20
> > Yes, indeed, hence the "typically".
> >=20
> > > How about "Sensible default the top of the priority list if it exists"
> >=20
> > How about we don't tell contributors what their priorities must be?
> >=20
> > Maxime
> >=20
>=20
> I'm not familiar at all with BGRT, I'll study a bit about it.
>=20
> A build-time configuration could then let the user select:
>=20
> - a plain solid color
> - a custom static image
> - the penguin logo (?)
> - (on UEFI systems) BGRT source

It wouldn't work for generic distros that would run with the same config
on systems with and without BGRT.

Again, that whole discussion around BGRT is very premature, I'd suggest
to drop it for now.

Maxime

--escnxwlco7olhzqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaQHSEgAKCRAnX84Zoj2+
dpGIAX422nWOX75YY7H8/KLRytbQNW5Mc3R0yHeeBRF2Es62f2SWmkYJtpd604aL
gPtkHr0Bf2dw31hWMOP/ppZ975jt6D0JUZCVXttO2ltAPk1jJbxLm0z0Oe2x2aIX
RT783F5qdw==
=onat
-----END PGP SIGNATURE-----

--escnxwlco7olhzqd--

