Return-Path: <linux-kernel+bounces-864552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0CFBFB0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 678F04F86BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069930F7F7;
	Wed, 22 Oct 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BRsA2xdL"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58030EF88
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123874; cv=none; b=EV3ykO9LufvQ9ddC5LqEqtMZFfzXHbc3HkZMsBqSavhUTWHhj3aCDjWKpc7kHCP7gCVSwhV6oVC1HXQ2W+zzlsxcKHDyYsjouJ0rZOCuvr90Ib9nK+tD9aeOy5c5I+bYM9Fdvj537/vqCdOzCJlGGBkZ9U8f9/4Y9RWLhryBv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123874; c=relaxed/simple;
	bh=tIrzq1M0NfFahPodWpDUzJIAJ7FZGd03VNxP1buffCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOx/1O+QwUxv+fJA0McJRpdLALxtCNpifpetnU1QuL/05CqO6ZvUAHM5VaEba7HLQySn01iEJ2sM3FsRz/BQZZq/B3x6mOCaDwWvjiHk2ofhPJIZt7VKiKo0esfYtnqqrbaaLmteA3LzjXSzhn/PjQCkujhILcYu0euE3I4Hp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BRsA2xdL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3032FC0B8B2;
	Wed, 22 Oct 2025 09:04:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DAFC6606DC;
	Wed, 22 Oct 2025 09:04:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC1EC102F2424;
	Wed, 22 Oct 2025 11:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761123869; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TPfFMBERm5dyXammymO+1vkoeJ/PAmEMHoRiaPzuWiE=;
	b=BRsA2xdLFHxr5wkHQuVgtmzHR8hGlOzwut65jYHV16OJttkXiYP9Mk+6cA+1JL391boUKl
	Ytxx1L4Qyh4CFndUy+Q+09ce37oPbPs52IpJVVv53gBfBfBwns/hQFIWvdrg7OHIs3c0wy
	Ben67npuuzn+dXIEpxJlGXWdgGhHYR5gm4pOeEXnYCO2nQQGJ55vixLTewyM2Wim+zS+sQ
	0aEuNt3dDglk6GHWI8WzCd6C7LiPyNEqL1BM+DWWHFGjrYOn6gaNbaxk0n4V5UV9UR5jTM
	HasfWNk9NScktaUVnu/3z4coRPzBUM+cjq1VU/RyVz7v5D6eqPbwFZ0opAgpjw==
Date: Wed, 22 Oct 2025 11:04:24 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Douglas Anderson <dianders@chromium.org>, Maxime Ripard
 <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bajjuri Praneeth <praneeth@ti.com>, Louis
 Chauvet <louis.chauvet@bootlin.com>, thomas.petazzoni@bootlin.com, Jyri
 Sarha <jyri.sarha@iki.fi>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH] drm/tilcdc: Fix removal actions in case of failed probe
Message-ID: <20251022110424.36a63ad3@kmaincent-XPS-13-7390>
In-Reply-To: <20251022105840.5e1f06bf@kmaincent-XPS-13-7390>
References: <20251014143229.559564-1-kory.maincent@bootlin.com>
	<5269c71a-b439-46d3-acb4-590eee2406f4@ideasonboard.com>
	<20251022105840.5e1f06bf@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 22 Oct 2025 10:58:40 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Wed, 22 Oct 2025 10:05:47 +0300
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
>=20
> > Hi,
> >=20
> > On 14/10/2025 17:32, Kory Maincent wrote: =20
> > > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> > >=20
> > > The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpe=
rs
> > > should only be called when the device has been successfully registere=
d.
> > > Currently, these functions are called unconditionally in tilcdc_fini(=
),
> > > which causes warnings during probe deferral scenarios.
> > >=20
> > > [    7.972317] WARNING: CPU: 0 PID: 23 at
> > > drivers/gpu/drm/drm_atomic_state_helper.c:175
> > > drm_atomic_helper_crtc_duplicate_state+0x60/0x68 ... [    8.005820]
> > > drm_atomic_helper_crtc_duplicate_state from
> > > drm_atomic_get_crtc_state+0x68/0x108 [    8.005858]
> > > drm_atomic_get_crtc_state from drm_atomic_helper_disable_all+0x90/0x1=
c8 [
> > >  8.005885]  drm_atomic_helper_disable_all from
> > > drm_atomic_helper_shutdown+0x90/0x144 [    8.005911]
> > > drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [tilcdc] [
> > > 8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [ti=
lcdc]
> > >=20
> > > Fix this by moving both drm_kms_helper_poll_fini() and
> > > drm_atomic_helper_shutdown() inside the priv->is_registered condition=
al
> > > block, ensuring they only execute after successful device registratio=
n.
> > >=20
> > > Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at
> > > shutdown/remove time for misc drivers") Signed-off-by: Kory Maincent
> > > (TI.com) <kory.maincent@bootlin.com>   =20
> >=20
> > Should this be cc: stable? =20
>=20
> Indeed I think so.

Should I send a new version with the stable tag included?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

