Return-Path: <linux-kernel+bounces-873232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7DC136E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3635E1A23B79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650D298CA6;
	Tue, 28 Oct 2025 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="v+XRmDh9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="OZijjk78"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9A18C031;
	Tue, 28 Oct 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638670; cv=pass; b=CTBxYq+anOa1HpbYNoin2bjY0xkhNhMQ6rG34MuGYf4rwUzjynEXqagfvwJcWCY4V2qsOC8evHYoBkL0/I31oc3V3okTfmA7OToebvL1sC6I5upxIUAp0AUMx8/2ma2ey6DtqVr5gXo0MdDRoaEhaWK3SP41wbWAeISc5/1poto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638670; c=relaxed/simple;
	bh=s6a57ztWgKqzZop2eXVnrLGAARifLGZdVEuuyt6o4uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgTK3Yuk/vDREfSQ+Ek2wVfEwGe6HP6OCdnjkGl5F0YCE2TK1a27tUHQMT7hJqpb+RjVRZoiLpH5xZOCGoJ0njbE6HAHNvnDrrg2PyveUdktCHQIJ4nvvZ/maev2+SNWpNT6FpggazkVjxwovCLzzREVbgfWTiL8TkvmJSkdm+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=v+XRmDh9; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=OZijjk78; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-zd5h.prod.antispam.mailspamprotection.com; s=arckey; t=1761638668;
	 b=DYmK8D8fCSvsIDFzEj1OIWynwBzz0cUvAAe0/WpYFviDLEER+EBGejIYllC58fP3oHjI7GY/xp
	  VvPSwZqNSF5jrl927d8aO2vMegGQFJ730VXILcKepLkH7h9uJ0IeAlysdDH05qFSW7MbTXP8Qr
	  Zd55TeERz7rwK1BQdwGFBw5uSmkfOAjdxYFKaYRW1V2rYyJgCo4pOwOxbcj8t8JWM2Sf7+mUBx
	  QuuW7Apeoj2wTlxRtP5ekdHy+avDG4dsVtS3AM3rOZpo6ixoIkKA/xmVs461fLLBm0E2ODWy7/
	  zNapQz6dVbPfXwSwiLUZAkUpM4sHNOzBBtmR+edWyir0CA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-zd5h.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-zd5h.prod.antispam.mailspamprotection.com; s=arckey; t=1761638668;
	bh=s6a57ztWgKqzZop2eXVnrLGAARifLGZdVEuuyt6o4uw=;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	  To:From:DKIM-Signature:DKIM-Signature;
	b=km0lZcWvK/UlWCWRMN3KP0ohUIgo/XL+gSj4Lv7L87YWe51MaevqH99PI8ll14QnbivVD2bsH1
	  2+rZj5n8uLN6ovHYxGB0Z/5rnynxGMgpdFRMnWU7As7alr8GrLzcSAMMP+cSagAel+96E9oa9M
	  nkB4EAYW98PdkjnzLtMMOIOdSFzUAT9nFspdX7hZoabtzn35N/48g0ipjxMV+uwisNYgsEEGoC
	  BGUv24y7SNSPT8GtBFUPJ3pz/l1z44jsf7TjuxqVLnXFR0WE02p2gAQmuHFJ6wSPMdjmEzhgrD
	  7eP5XO4gtEWItfy+w2YMOIAowWP1oKiDEKJIiTn5vDz7lw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=tv0PkcWT+R6COZq+/bFx5P+D3RWcMKpvqpZ6j2a+CzU=; b=v+XRmDh9AdgS8LEFJZFq2yeBKt
	4a5Mmj980ZRHqPvi/g+btq2iQo6NFT5sVv5sh1aNbwblPPjyj4t7JVuOMYeNgpKFjG73Mr2vhGmU6
	0ng7YuL6pknZ04cNchwWsI0qy0rQAHG6QksYU+QJ1PDTH58UfnqkNQNrOZolR+Ea5k8Q=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-zd5h.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDegj-00000000zwy-1f2q;
	Tue, 28 Oct 2025 08:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=tv0PkcWT+R6COZq+/bFx5P+D3RWcMKpvqpZ6j2a+CzU=; b=OZijjk78i+B95GvMw1d1NggCNV
	gS6m2njSh3c14y+eNYU715tLWZwRBp9g+3B6fbflCkwKy0OL0r3wiHrXShrdC8Lp2yi3rndZqqoeZ
	oAYUvakhfEITOdyEyqBxG8zOrOaWYuqP1MvxL6fFbYUF1jOM7JjMO+V/hG3IfexkFZhc=;
Received: from [87.17.42.198] (port=62990 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDegM-00000000NKV-2TYu;
	Tue, 28 Oct 2025 08:03:54 +0000
From: Francesco Valla <francesco@valla.it>
To: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
Date: Tue, 28 Oct 2025 09:03:53 +0100
Message-ID: <7194118.9J7NaK4W3v@fedora.fritz.box>
In-Reply-To: <3edea192-6a3f-44f5-b570-7033776e2ce4@suse.de>
References:
 <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>
 <yq4btdc5qqukuqps7y53dratmu64ghyifgprlndnk5rbgml4of@rvca75sncvsm>
 <3edea192-6a3f-44f5-b570-7033776e2ce4@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9956517.eNJFYEL58v";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: de4ab1ac8654d35d866963dfba46f082
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vDegj-00000000zwy-1f2q-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-zd5h.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

--nextPart9956517.eNJFYEL58v
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Francesco Valla <francesco@valla.it>
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
Date: Tue, 28 Oct 2025 09:03:53 +0100
Message-ID: <7194118.9J7NaK4W3v@fedora.fritz.box>
In-Reply-To: <3edea192-6a3f-44f5-b570-7033776e2ce4@suse.de>
MIME-Version: 1.0

Hi Thomas,

On Monday, 27 October 2025 at 13:35:31 Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Hi Francenso, Maxime,
> 
> Am 27.10.25 um 11:09 schrieb Maxime Ripard:
> > Hi,
> >
> > On Mon, Oct 27, 2025 at 12:03:00AM +0100, Francesco Valla wrote:
> >> this patchset adds a new DRM client offering splash functionalities,
> >> able to draw to screen:
> >>
> >>    - a colored background;
> > So, I like that part, and we were recently discussing about this.
> 
> The panic screen has configurable foreground/background colors. Maybe we 
> can harmonize these settings.
> 

Maybe, but probably the panic colors would typically be much more vibrant
than splash ones. 

> >
> >>    - a single-line text message, which can be set through sysfs or
> >>      directly from the kernel command line;
> 
> Put it into the kernel config.
> 
> >>    - a very simple progress bar, which can be driven through sysfs;
> 
> Once you have options to control these settings from user space, you 
> should do it in user space entirely. As Maxime suggested, please improve 
> plymouth for anything with animation.
> 

On this I can agree, see my reply to Maxime.

> >>    - a static image (optional).
> 
> Board vendors often provide an image, see /sys/firmware/acpi/bgrt/. This 
> is a candidate for display, or the penguin or a custom image. Please 
> make it configurable by Kconfig. Again, if you need policy and 
> heuristics for deciding what to display, you better do this in user space.
>

I'm not under ACPI/UEFI typically, and the concept for this patch was not
developed on such system. But I'll take a look!

> > But there's no reason to have all that in the kernel, and we already
> > have userspace components to do so (plymouth being the main "mainstream"
> > one).
> >
> >> Once compiled inside the kernel, the client can be enabled through the
> >> command line specifying the drm_client_lib.active=splash parameter.
> >>
> >> == Motivation ==
> >>
> >> The motivation behind this work is to offer to embedded system
> >> developers a new path for a simple activation of the display(s)
> >> connected to their system, with the following usecases:
> >>
> >>    - bootsplash - possibly displaying even before init;
> >>    - early activation of the display pipeline, in particular whenever one
> >>      component of the pipeline (e.g.: a panel) takes a non-negligible
> >>      time to initialize;
> >>    - recovery systems, where the splash client can offer a simple feedback
> >>      for unattended recovery tasks;
> >>    - update systems, where the splash client can offer a simple feedback
> >>      for unattended update tasks.
> > If plymouth cannot be used by embedded systems for some reason, then you
> > should work on a plymouth alternative.
> 
> Agreed. With an updater running in user space, that process should also 
> manage the display update. No need for this in the kernel.
> 
> >
> >> While the first seems the most obvious one, it was the second that acted
> >> as the driver, as in the past I had to implement a ugly workaround using
> >> a systemd generator to kickstart the initialization of a display and
> >> shave ~400ms of boot time.
> >>
> >> The last 2 usecase, instead, are the reason I dropped the "boot" part
> >> from bootsplash.
> >>
> >> == Implementation details ==
> >>
> >> The design is quite simple, with a kernel thread doing the heavylifting
> >> for the rendering part and some locking to protect interactions with it.
> >>
> >> The splash image is loaded using the firmware framework, with the client
> >> expecting to find a binary dump having the right dimensions (width and
> >> height) and FOURCC format for each modeset. Given a 1920x1080 RGB888
> >> modeset, the client will for example search for a firmware named:
> >>
> >>     drm_splash_1920x1080_RG24.raw
> >>
> >> If the firmware cannot be loaded directly, the NOUEVENT sysfs fallback
> >> mechanism is used to let userspace load the appropriate image.
> >>
> >> == Testing ==
> >>
> >> Testing was done on qemu (both with vkms and bochs drivers), on a HDMI
> >> display connected to a Beagleplay and on a ILI9341 SPI display connected
> >> to a i.MX93 FRDM board. All these platforms revealed different
> >> weaknesses that were hopefully removed.
> >>
> >> == Open points / issues ==
> >>
> >> The reason for this being an RFC is that there are several open points:
> >>
> >>    - Support for tiled connectors should be there, but has not been
> >>      tested. Any idea on how to test it?
> > Did you mean tiled formats?
> >
> >>    - I'm not entirely convinced that using the firmware framework to load
> >>      the images is the right path. The idea behind it was to re-use the
> >>      compressed firmware support, but then I discovered it is not there
> >>      for built-in firmware.
> > Yeah, firmware loading for this has a few issues (being tedious to setup
> > for when built-in being one). I think just going the fbdev penguin road
> > is a better choice: you provide the path, and it's embedded in the
> > kernel directly.
> >
> >>    - Again on the firmware loading: CONFIG_LOADPIN would interfere with
> >>      sysfs loading.
> >>    - And again: FW_ACTION_NOUEVENT only has one user inside the kernel,
> >>      leading me to think it is de-facto deprecated. And still, uevents
> >>      for firmware loading seem frowned upon these days...
> >>    - Generating binary dumps for... basically any format is not so
> >>      straightforward. I crafted a Python tool with AI help which seems
> >>      to work quite well, but I honestly did not yet understood which is
> >>      the policy for AI-generated code inside the kernel, so it is not
> >>      included in this patch set. All client code is genuine, though.
> > BMP is simple enough to support so we should probably use that instead
> > of a custom format.
> 
> file /sys/firmware/acpi/bgrt/image
> /sys/firmware/acpi/bgrt/image: PC bitmap, Windows 3.x format, 768 x 256 
> x 24, image size 589824, cbSize 589878, bits offset 54
> 
> That should probably be the format for now unless your firmware uses 
> something else natively. Code for reading a BMP file can be found in the 
> efifb driver. [1]
> 
> [1] 
> https://elixir.bootlin.com/linux/v6.17.5/source/drivers/video/fbdev/efifb.c#L24
> 

When I started working on the patch I was not able to find this BMP decoder,
I only found the PPM one from the bootup logo. I'll take a look here too.  


> Apart from the criticism for complexity, I do like the idea of having a 
> splash screen.
> 
> Best regards
> Thomas
> 
> >
> > Maxime
> 
> 

Thank you!

Best regards,
Francesco

--nextPart9956517.eNJFYEL58v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRUrtjevJ039mawAeLir2xSXEi5AAUCaQB46QAKCRDir2xSXEi5
AGFFAP44WmJhkVq8Dd3yPrN4/6UbZ2jWawAOmn01DC155zZoIgEAhZhC84pdRLkN
8fFc7/Acio+KH0UOmzebgGlT202k6g0=
=JHNe
-----END PGP SIGNATURE-----

--nextPart9956517.eNJFYEL58v--




