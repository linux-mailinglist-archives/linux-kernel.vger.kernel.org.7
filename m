Return-Path: <linux-kernel+bounces-870666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44812C0B68A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 182664EB798
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBECF2FFF88;
	Sun, 26 Oct 2025 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Td8P9PMH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="oJsmgykt"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C81990A7;
	Sun, 26 Oct 2025 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519829; cv=pass; b=GvPWNf7Vi4maiFc1IIlLixZZVh3J8pbQFn9yvLIHdXEipQw3j09g/uWV1J1N/NaTZwGX3m3m85qc/qxc5sXHT8wx0FRZWlI0MPlgzYo2WWiCxP01RAIvqEPHPxUpn40NHS92PYDoGWc/utW0uJdwZXg6U5ioRfdTEsniQukBT7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519829; c=relaxed/simple;
	bh=+ifDqTasTBOiJ3jA1D6liL2PSivxMkHApr4Dpp+jaK8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q3oNE8nIHuvXLoAZGdY2nelja/lCBuEbpjme42JvIHNC2DnaAmKFM0x5uhmXkIRr1VUmiw2O1D+qYenAJEMwnU6J2X4AnVgplyWoCl+dFQi02Wplt+sPeeXGEdeBIRMLmEPFpxsgC+aqSkKds+Kor4d88F8VQUjfxwH6vOnRqco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Td8P9PMH; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=oJsmgykt; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com; s=arckey; t=1761519827;
	 b=kYH5c7hCUpkCufM9V49I8B9SOmH/vcXsZh48LLFeMPD6nYkYctg6s2n85jlvlwrZ32V+esvB+Z
	  cC1uYliWBM5blMcxNc5qSdBP5zypk1y2tyRfZmN5thVjpznThRKqhxqare4VZQcyilwCRiRJtX
	  4vjjnJ8DO7lBVAYsxNomRmsh7JhuKPMiqn+kZ5Z/ZFWSzz19XhXCyMleoOLHJV6+H8puezeyZ+
	  ekTMLF46lysxpHo/6mLtBKamj65axQbeY0qfMnDNBW7CxcNoE5dh4SaBz75STMJjxOB5kd3m+h
	  3fXDX0p0TqH7ZtZw1xoMejWSL5sQdZqDTHqNtw4pP+nFUg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com; s=arckey; t=1761519827;
	bh=+ifDqTasTBOiJ3jA1D6liL2PSivxMkHApr4Dpp+jaK8=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=31GINQpXeMO5IoAXw7UqAE1EVTh0zvIifVQ3liMBt033uDyt0v8T50x+2dbPYn9CMHvek1bIkN
	  IaJTaJnvwYKbid7T6Jlrqv1hjZ2EYtI/chXTfbi39obm+D3VBVoNz7T9m18h08eOMxGqrWjJ/o
	  tKzS201b1gA3lEQ6ixTUTU18/KleEe154opY8JVINX3NnGUcYJp/21c2pj6NGTgIem4toXrBTo
	  vhhehofSLej5iIFLFwPrK8qWuOP2JXc9SussNo5+zDaEFFQiF60E4N+EQleJg/vQNHZ0/J97jG
	  wcXDkC3MyZ7LdmZ7JW7lmN5HAtKYySNtyPovB/3ytLh2WQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=/esxIZLC2v0hWhtNa8E6uqHduQe1rcLZyFz3W/CggDI=; b=Td8P9PMHdQrHiZSkispMZYb2kq
	lAWhF8I0xCFOKMC21ZsSISnBmrMqtb+TYZ8jsfFWztgyApVKDxZ3DOG4OplBeIWaRv9Cf5sAJem3q
	r2XLzSub1LHl7bSFAZasIEhrj1oQsk0VakoEa4zT7dK4h4pXhTu3HP8y5f3Y8FpHliOE=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4x87.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vD9lw-00000002w75-3XG0;
	Sun, 26 Oct 2025 23:03:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=/esxIZLC2v0hWhtNa8E6uqHduQe1rcLZyFz3W/CggDI=; b=oJsmgyktsnxT0LuJkjKfBc6mkC
	Ia7FzRMvopHpApfgCqw5F+wed/RyBmT/1WB2Vfmu6YNRAvC4cNDdWFc+93N9ay8H6gQOvJEZK/49/
	uPYs5/A90NnwUEmTraG88dQrXyDYYJYdfTiK99oMJ6pgCyuna2C1gd+/11t1WHuMvT4I=;
Received: from [87.17.42.198] (port=63736 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vD9lp-00000000KNm-3zNW;
	Sun, 26 Oct 2025 23:03:30 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH RFC 0/3] Add splash DRM client
Date: Mon, 27 Oct 2025 00:03:00 +0100
Message-Id: <20251027-drm_client_splash-v1-0-00698933b34a@valla.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKSo/mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMz3ZSi3PjknMzUvJL44oKcxOIM3VRDgxTzFDMz41TzNCWgvoKi1LT
 MCrCZ0UpBbs5KsbW1ALwPpH5oAAAA
X-Change-ID: 20251026-drm_client_splash-e10d7d663e7f
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-embedded@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4592; i=francesco@valla.it;
 h=from:subject:message-id; bh=+ifDqTasTBOiJ3jA1D6liL2PSivxMkHApr4Dpp+jaK8=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDBn/Vmx//lFsUfpG631xeVf+9ajvKStYpZbcOJsp6k70D
 BOWYpVZHaUsDGJcDLJiiiwh627c2zPX/FvaBsZHMHNYmUCGMHBxCsBEokUZGaatnPdjfprcnu+T
 J8y6NOn7bnunq08ZZLjNrQV9s39Ib9vHyLBftpKRIfZT0H4zw2ebNVqrK/gSS6Zt8dz/OT1i8+J
 IDw4A
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 2bb777e146862eddcffe1886d2eba538
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vD9lw-00000002w75-3XG0-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4x87.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello,

this patchset adds a new DRM client offering splash functionalities,
able to draw to screen:

  - a colored background;
  - a single-line text message, which can be set through sysfs or
    directly from the kernel command line;
  - a very simple progress bar, which can be driven through sysfs;
  - a static image (optional).

Once compiled inside the kernel, the client can be enabled through the
command line specifying the drm_client_lib.active=splash parameter.

== Motivation ==

The motivation behind this work is to offer to embedded system
developers a new path for a simple activation of the display(s)
connected to their system, with the following usecases:

  - bootsplash - possibly displaying even before init;
  - early activation of the display pipeline, in particular whenever one
    component of the pipeline (e.g.: a panel) takes a non-negligible
    time to initialize;
  - recovery systems, where the splash client can offer a simple feedback
    for unattended recovery tasks;
  - update systems, where the splash client can offer a simple feedback
    for unattended update tasks.

While the first seems the most obvious one, it was the second that acted
as the driver, as in the past I had to implement a ugly workaround using
a systemd generator to kickstart the initialization of a display and
shave ~400ms of boot time.

The last 2 usecase, instead, are the reason I dropped the "boot" part
from bootsplash.

== Implementation details ==

The design is quite simple, with a kernel thread doing the heavylifting
for the rendering part and some locking to protect interactions with it.

The splash image is loaded using the firmware framework, with the client
expecting to find a binary dump having the right dimensions (width and
height) and FOURCC format for each modeset. Given a 1920x1080 RGB888
modeset, the client will for example search for a firmware named:

   drm_splash_1920x1080_RG24.raw

If the firmware cannot be loaded directly, the NOUEVENT sysfs fallback
mechanism is used to let userspace load the appropriate image.

== Testing ==

Testing was done on qemu (both with vkms and bochs drivers), on a HDMI
display connected to a Beagleplay and on a ILI9341 SPI display connected
to a i.MX93 FRDM board. All these platforms revealed different
weaknesses that were hopefully removed.

== Open points / issues ==

The reason for this being an RFC is that there are several open points:

  - Support for tiled connectors should be there, but has not been
    tested. Any idea on how to test it?
  - I'm not entirely convinced that using the firmware framework to load
    the images is the right path. The idea behind it was to re-use the
    compressed firmware support, but then I discovered it is not there
    for built-in firmware.
  - Again on the firmware loading: CONFIG_LOADPIN would interfere with
    sysfs loading.
  - And again: FW_ACTION_NOUEVENT only has one user inside the kernel,
    leading me to think it is de-facto deprecated. And still, uevents
    for firmware loading seem frowned upon these days... 
  - Generating binary dumps for... basically any format is not so
    straightforward. I crafted a Python tool with AI help which seems
    to work quite well, but I honestly did not yet understood which is
    the policy for AI-generated code inside the kernel, so it is not
    included in this patch set. All client code is genuine, though.

== Additional notes ==

A bootsplash client was one of the TODOs for the DRM subsystem, so patch
3 removes the relative section from the list.

Curious to hear your thoughts. Thank you in advance!

Best regards,
Francesco

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Francesco Valla (3):
      drm: client: add splash client
      MAINTAINERS: add entry for DRM splash client
      drm: docs: remove bootsplash from TODO

 Documentation/gpu/todo.rst                    |  17 -
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/clients/Kconfig               |  46 +-
 drivers/gpu/drm/clients/Makefile              |   1 +
 drivers/gpu/drm/clients/drm_client_internal.h |   9 +
 drivers/gpu/drm/clients/drm_client_setup.c    |   8 +
 drivers/gpu/drm/clients/drm_splash.c          | 761 ++++++++++++++++++++++++++
 7 files changed, 831 insertions(+), 18 deletions(-)
---
base-commit: 4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d
change-id: 20251026-drm_client_splash-e10d7d663e7f

Best regards,
-- 
Francesco Valla <francesco@valla.it>


