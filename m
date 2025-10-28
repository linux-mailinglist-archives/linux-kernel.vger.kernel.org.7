Return-Path: <linux-kernel+bounces-873312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F45BC13A25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73D71890987
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6102E11C5;
	Tue, 28 Oct 2025 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="LsPet6+K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="ClfkBYFX"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D72DBF75;
	Tue, 28 Oct 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641454; cv=pass; b=X5d+oyr4IuuMrAXULX5o8I5AyhN3HIkR9qnUvMKnT5YmXenGcq9hYn4ST/jzOZjQH/lFwXHv3lk8SSn8q2sCK2sVxiDCMVqgfrdjyic+Us64WdmywUHbjY5WXh7LC0HPQVoXZp8pqFzBsGK3cacLNtfHoPTUnLwouIUKgOZnUAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641454; c=relaxed/simple;
	bh=iEY4Wt1Q2As11SfIf0/Sluu+mH2O6nSTVRG/jlw/s+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpXojUXn8u+4eduF/1ZHENjjwJN37TkOZ6x/ZVes+dYjN6CveBlq4uxhvhUpG6JnJdohIZu4Jrd6erfOeW2u9svjbLqO+E6U+jhNPmXAWPzEGfp+OTnXxlHuuFOVlUJOqWRi8Lhm4FbrgpX21X4kINoinSgBTQznxf7SI/Wu55w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=LsPet6+K; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=ClfkBYFX; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com; s=arckey; t=1761641451;
	 b=ibClSf3l/Qv3u4iRhdYIkbbz0qfJEkYTL/h8CDqWw7Tsvx/MNjoXUnSoudPK543S22dFjt0c1K
	  mc4ydtXIBSVY8/EQf4JApQNVG44s/tmOqGebhjn7Hd5BRrmWpvSCuM8EjV4QFE3l41JZt3TRS6
	  FBPdVQ36JSMiWVc2qjHtgYLylvBzebqUIwI9Y7jBTS9Ya9IhnCQacjZv6OMzXnJMHtMwraMJVN
	  IH6EHISkR8mprHt/kyamJDW+RrzIMm+JsqFp9io0t+FLWrERedCImkQ1Rm4KGG8qTdCkdkRo4s
	  KDeYwEky4ocjNCmxTfdc95h3wCsFM9hpEoUNIGKDgardUA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com; s=arckey; t=1761641451;
	bh=iEY4Wt1Q2As11SfIf0/Sluu+mH2O6nSTVRG/jlw/s+s=;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	  To:From:DKIM-Signature:DKIM-Signature;
	b=Ar/SIQtL6gh2hcBl87bjWQnr/hyL/kAbbrO7NO1V9QYcS0rOUy3A3QaxXR33aDanUrZhTQiuiF
	  b98ZkL49IG8u9icKv1chWsuvtZ4CA2QIB9YZpiBbam9t7HzyOVmypYrrOxvZsa9RbgDv7SWAwA
	  9Rxu8EPZb5qjyhm+ve3t/uwBItWF5Ob+Fue2QIw3xC0eB4ev7EZnUO7NA/R9mlp9gMscbiYWmB
	  ELb/JbK7w+fATfImU/UJABQA9FxQeYSOZ8WGLx/GFu4Vk/8MwX1IsbJ5kW6xQ+1pmks9wh2C77
	  4RyE1/ZQPloOUYe6spgip4CGGkGvzPTZVOPbs9ZJ4pCjTA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=zdfLZeLr5NvufMpcLIsBqTthOwjM4I46IsO/Ts8RIWE=; b=LsPet6+KdSQtippXk3uCBtNAhS
	tpDGra5MuqsTXtB799xWBnCoxdIowJbN5b0T0h/u5RqLK+zt3ResmVlCYpt3aLx7GE5yw1Gxa1ivQ
	WrIKHIqAzxHMxaWV0XYLyDLJ40BskubU3SVWgbE9QSue/UzBWJdbPahTz0JZ1ihQjEXs=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDebE-00000000ZxG-28Pw;
	Tue, 28 Oct 2025 07:58:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=zdfLZeLr5NvufMpcLIsBqTthOwjM4I46IsO/Ts8RIWE=; b=ClfkBYFXsfPZoGUrAKm6wwrL8U
	0zjVtmTjsdovD2/5iy3S07INI/dq3tPMKjgIVJh+4zSfrNHzW4bmUZJmIVqhtBpQxebkaD/TP505H
	uPbAkefTqhyeHburXaz+Sl2c4WKBDsBXYz4mXe7sLTBogltkk27UVLS6bDnRCo27AkC4=;
Received: from [87.17.42.198] (port=60166 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDear-00000000Lap-143e;
	Tue, 28 Oct 2025 07:58:13 +0000
From: Francesco Valla <francesco@valla.it>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
Date: Tue, 28 Oct 2025 08:58:05 +0100
Message-ID: <2756316.lGaqSPkdTl@fedora.fritz.box>
In-Reply-To: <yq4btdc5qqukuqps7y53dratmu64ghyifgprlndnk5rbgml4of@rvca75sncvsm>
References:
 <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>
 <yq4btdc5qqukuqps7y53dratmu64ghyifgprlndnk5rbgml4of@rvca75sncvsm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2568004.XAFRqVoOGU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 5a7c746a07f8a41a36c791bb827bc739
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vDebE-00000000ZxG-28Pw-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

--nextPart2568004.XAFRqVoOGU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Francesco Valla <francesco@valla.it>
To: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH RFC 0/3] Add splash DRM client
Date: Tue, 28 Oct 2025 08:58:05 +0100
Message-ID: <2756316.lGaqSPkdTl@fedora.fritz.box>
MIME-Version: 1.0

Hi,

On Monday, 27 October 2025 at 11:09:56 Maxime Ripard <mripard@kernel.org> wrote:
> Hi,
> 
> On Mon, Oct 27, 2025 at 12:03:00AM +0100, Francesco Valla wrote:
> > this patchset adds a new DRM client offering splash functionalities,
> > able to draw to screen:
> > 
> >   - a colored background;
> 
> So, I like that part, and we were recently discussing about this.
> 
> >   - a single-line text message, which can be set through sysfs or
> >     directly from the kernel command line;
> >   - a very simple progress bar, which can be driven through sysfs;
> >   - a static image (optional).
> 
> But there's no reason to have all that in the kernel, and we already
> have userspace components to do so (plymouth being the main "mainstream"
> one).
> 

I get that for the "text message" and "progress bar" parts. I still have
some uses for them, that however may not be adherent to upstream philosophy.

> > Once compiled inside the kernel, the client can be enabled through the
> > command line specifying the drm_client_lib.active=splash parameter.
> > 
> > == Motivation ==
> > 
> > The motivation behind this work is to offer to embedded system
> > developers a new path for a simple activation of the display(s)
> > connected to their system, with the following usecases:
> > 
> >   - bootsplash - possibly displaying even before init;
> >   - early activation of the display pipeline, in particular whenever one
> >     component of the pipeline (e.g.: a panel) takes a non-negligible
> >     time to initialize;
> >   - recovery systems, where the splash client can offer a simple feedback
> >     for unattended recovery tasks;
> >   - update systems, where the splash client can offer a simple feedback
> >     for unattended update tasks.
> 
> If plymouth cannot be used by embedded systems for some reason, then you
> should work on a plymouth alternative.
> 

Thing is: any possible alternative would still start after userspace has
been loaded, checked (in case of secure boot, which is ubiquitous now)
and initialized. This means, at least in my usecases, several hundreds of
milliseconds after userspace start, to be summed to the panel initialization
time.

> > While the first seems the most obvious one, it was the second that acted
> > as the driver, as in the past I had to implement a ugly workaround using
> > a systemd generator to kickstart the initialization of a display and
> > shave ~400ms of boot time.
> > 
> > The last 2 usecase, instead, are the reason I dropped the "boot" part
> > from bootsplash.
> > 
> > == Implementation details ==
> > 
> > The design is quite simple, with a kernel thread doing the heavylifting
> > for the rendering part and some locking to protect interactions with it.
> > 
> > The splash image is loaded using the firmware framework, with the client
> > expecting to find a binary dump having the right dimensions (width and
> > height) and FOURCC format for each modeset. Given a 1920x1080 RGB888
> > modeset, the client will for example search for a firmware named:
> > 
> >    drm_splash_1920x1080_RG24.raw
> > 
> > If the firmware cannot be loaded directly, the NOUEVENT sysfs fallback
> > mechanism is used to let userspace load the appropriate image.
> > 
> > == Testing ==
> > 
> > Testing was done on qemu (both with vkms and bochs drivers), on a HDMI
> > display connected to a Beagleplay and on a ILI9341 SPI display connected
> > to a i.MX93 FRDM board. All these platforms revealed different
> > weaknesses that were hopefully removed.
> > 
> > == Open points / issues ==
> > 
> > The reason for this being an RFC is that there are several open points:
> > 
> >   - Support for tiled connectors should be there, but has not been
> >     tested. Any idea on how to test it?
> 
> Did you mean tiled formats?
> 

No, AFAIU the tiled connectors are different connectors that feed different
panels, which however are part of a single logical screen. Support for this
setup is present at drm level [1], but I'm not familiar with it.

I've only found this used inside the i915 Intel driver [2].

> >   - I'm not entirely convinced that using the firmware framework to load
> >     the images is the right path. The idea behind it was to re-use the
> >     compressed firmware support, but then I discovered it is not there
> >     for built-in firmware.
> 
> Yeah, firmware loading for this has a few issues (being tedious to setup
> for when built-in being one). I think just going the fbdev penguin road
> is a better choice: you provide the path, and it's embedded in the
> kernel directly.
> 

Yes, this is already working, but if large-ish images are used, the loading
time for them defeats the entire purpose of an in-kernel splash.

> >   - Again on the firmware loading: CONFIG_LOADPIN would interfere with
> >     sysfs loading.
> >   - And again: FW_ACTION_NOUEVENT only has one user inside the kernel,
> >     leading me to think it is de-facto deprecated. And still, uevents
> >     for firmware loading seem frowned upon these days... 
> >   - Generating binary dumps for... basically any format is not so
> >     straightforward. I crafted a Python tool with AI help which seems
> >     to work quite well, but I honestly did not yet understood which is
> >     the policy for AI-generated code inside the kernel, so it is not
> >     included in this patch set. All client code is genuine, though.
> 
> BMP is simple enough to support so we should probably use that instead
> of a custom format.
> 
> Maxime
> 


Thank you!

Regards,
Francesco


[1] https://elixir.bootlin.com/linux/v6.17.5/source/include/drm/drm_connector.h#L2253
[2] https://elixir.bootlin.com/linux/v6.17.5/source/drivers/gpu/drm/drm_connector.c#L2739


--nextPart2568004.XAFRqVoOGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRUrtjevJ039mawAeLir2xSXEi5AAUCaQB3jQAKCRDir2xSXEi5
AFnSAQC9C4qNTZxuzclFDDCR37ko3jNFdZTX3yJfD8TIeTHZzQD/aVd9TRgWztp0
2tBumHqBgLdhZcyZQNGyt5HWFk7XcQU=
=5pI2
-----END PGP SIGNATURE-----

--nextPart2568004.XAFRqVoOGU--




