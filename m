Return-Path: <linux-kernel+bounces-871316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8124C0CE6B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2424C3BE619
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804FD1E1DFC;
	Mon, 27 Oct 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQgqcUAZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9D224B0D;
	Mon, 27 Oct 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559799; cv=none; b=WtL2Nsv5wrs3ON/GYSmRYOd07JEXLCDxoZQSsmz0O3oQ9P//wDxbfP7RfrhL+JFaKsBGxnrsRAgPlW96HS8nTaLkQo54lGrUvEGMv0cdl4G1VjEsat7wbvliZU3cgvrby13MPnuV58Yz+wvhC5LagY89sj5oJoIwxDGVFnD+41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559799; c=relaxed/simple;
	bh=iPy9PTr3E6+/Ob+n9HMKMgQGzj72xG8nvstl1/tHSgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Blw5Bpoao/Vab2/oDVYxAnz4dxuW397/1GewwP+yvd7ywTcAYGImzjzDp2UBgRMOPp5ZdIYlrjYARQbx37ykqoYDoK0c5gndyufeCYwMokK3Y3bPZe6DOHRKESbdLFTeNpTFPOf6yBS1vJX6RtdxDt6FIOxweOi/z0qpBP4DQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQgqcUAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E162AC4CEF1;
	Mon, 27 Oct 2025 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559799;
	bh=iPy9PTr3E6+/Ob+n9HMKMgQGzj72xG8nvstl1/tHSgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQgqcUAZfk9WrQ9EwaUhEg793Ot9p9gugIruVAI5kXguUun+aVKaJ6SeFg+H/WiI2
	 E2xFNizI4+u1MtkE1j5HRG/ckt718iPlvLArv4dlRUpsgXVoaGdvBjxbkIH5KDHad+
	 1Cv6l87yVGeay2lXjwtu1ynJhYuFnmuV3ZqRWEQfRH64ZdgSOcHtTWE+mVzu9GYuif
	 LL1GvDqqiTfy4Ocl73/6sL1sunIAYB8JFMzjEksL5rE6razCE93zioC9Ik1RmjZI0j
	 hgM7AWxYwNJFGYp766gKSN80WvnPZeO6mG8nUWVUkVSLpjwb5QOgycpcgqauzX2gCE
	 urPqvCx2ITz4w==
Date: Mon, 27 Oct 2025 11:09:56 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
Message-ID: <yq4btdc5qqukuqps7y53dratmu64ghyifgprlndnk5rbgml4of@rvca75sncvsm>
References: <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="6xetpxgspicxrvf3"
Content-Disposition: inline
In-Reply-To: <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>


--6xetpxgspicxrvf3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
MIME-Version: 1.0

Hi,

On Mon, Oct 27, 2025 at 12:03:00AM +0100, Francesco Valla wrote:
> this patchset adds a new DRM client offering splash functionalities,
> able to draw to screen:
>=20
>   - a colored background;

So, I like that part, and we were recently discussing about this.

>   - a single-line text message, which can be set through sysfs or
>     directly from the kernel command line;
>   - a very simple progress bar, which can be driven through sysfs;
>   - a static image (optional).

But there's no reason to have all that in the kernel, and we already
have userspace components to do so (plymouth being the main "mainstream"
one).

> Once compiled inside the kernel, the client can be enabled through the
> command line specifying the drm_client_lib.active=3Dsplash parameter.
>=20
> =3D=3D Motivation =3D=3D
>=20
> The motivation behind this work is to offer to embedded system
> developers a new path for a simple activation of the display(s)
> connected to their system, with the following usecases:
>=20
>   - bootsplash - possibly displaying even before init;
>   - early activation of the display pipeline, in particular whenever one
>     component of the pipeline (e.g.: a panel) takes a non-negligible
>     time to initialize;
>   - recovery systems, where the splash client can offer a simple feedback
>     for unattended recovery tasks;
>   - update systems, where the splash client can offer a simple feedback
>     for unattended update tasks.

If plymouth cannot be used by embedded systems for some reason, then you
should work on a plymouth alternative.

> While the first seems the most obvious one, it was the second that acted
> as the driver, as in the past I had to implement a ugly workaround using
> a systemd generator to kickstart the initialization of a display and
> shave ~400ms of boot time.
>=20
> The last 2 usecase, instead, are the reason I dropped the "boot" part
> from bootsplash.
>=20
> =3D=3D Implementation details =3D=3D
>=20
> The design is quite simple, with a kernel thread doing the heavylifting
> for the rendering part and some locking to protect interactions with it.
>=20
> The splash image is loaded using the firmware framework, with the client
> expecting to find a binary dump having the right dimensions (width and
> height) and FOURCC format for each modeset. Given a 1920x1080 RGB888
> modeset, the client will for example search for a firmware named:
>=20
>    drm_splash_1920x1080_RG24.raw
>=20
> If the firmware cannot be loaded directly, the NOUEVENT sysfs fallback
> mechanism is used to let userspace load the appropriate image.
>=20
> =3D=3D Testing =3D=3D
>=20
> Testing was done on qemu (both with vkms and bochs drivers), on a HDMI
> display connected to a Beagleplay and on a ILI9341 SPI display connected
> to a i.MX93 FRDM board. All these platforms revealed different
> weaknesses that were hopefully removed.
>=20
> =3D=3D Open points / issues =3D=3D
>=20
> The reason for this being an RFC is that there are several open points:
>=20
>   - Support for tiled connectors should be there, but has not been
>     tested. Any idea on how to test it?

Did you mean tiled formats?

>   - I'm not entirely convinced that using the firmware framework to load
>     the images is the right path. The idea behind it was to re-use the
>     compressed firmware support, but then I discovered it is not there
>     for built-in firmware.

Yeah, firmware loading for this has a few issues (being tedious to setup
for when built-in being one). I think just going the fbdev penguin road
is a better choice: you provide the path, and it's embedded in the
kernel directly.

>   - Again on the firmware loading: CONFIG_LOADPIN would interfere with
>     sysfs loading.
>   - And again: FW_ACTION_NOUEVENT only has one user inside the kernel,
>     leading me to think it is de-facto deprecated. And still, uevents
>     for firmware loading seem frowned upon these days...=20
>   - Generating binary dumps for... basically any format is not so
>     straightforward. I crafted a Python tool with AI help which seems
>     to work quite well, but I honestly did not yet understood which is
>     the policy for AI-generated code inside the kernel, so it is not
>     included in this patch set. All client code is genuine, though.

BMP is simple enough to support so we should probably use that instead
of a custom format.

Maxime

--6xetpxgspicxrvf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaP9E9AAKCRAnX84Zoj2+
dv9HAX4ih+okolm988IsppngNpozRPH+0bTL7tTiS+WP7ElIwx/nDF3e+NDgLokO
HobomAABgO2avIRLa6ShC6ZiIhdpXMqBRPWoLDGc7sMbZFtl0lza9IpYnTIkD8Ao
Xxid+w1qBA==
=hxwS
-----END PGP SIGNATURE-----

--6xetpxgspicxrvf3--

