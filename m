Return-Path: <linux-kernel+bounces-853079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF967BDA98E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6FAF4E3698
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B20F301702;
	Tue, 14 Oct 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cd+l9F1G"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B933009E3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458906; cv=none; b=mFDOSsoua9g9rU977JfDSQqcLO5ckB0GDe4b87Rp6OdydiRm+8ZDfVRHP6sDQTVhXjKwq31LgGYEHVTkO4f2olnF3rOpRsGtsxjQvMtf2GV/CulnynqDGJ5nzmmv23SIFW3iosZOaVSZ/6sTck+kziCONS8F7/IffhEMWE4XGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458906; c=relaxed/simple;
	bh=FXJqhG6PQdI0GQJE8yRlkl9AUTPBoi+ZPnQdOudHoSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YntjIrwmn3Ca+k739/qNo9JG8CrS/fV5OGA+YF/rbB9eph4mABvsyY3Luy47CwznaFjuKd8MvMVY7+F2wMeJQ9j9iItmLAN113x1YpW05HruqEEvaBUE9kjDiJV1zSyRGVB22TbAUupCocZ8U4hvejTd7Djc7VI91Mq5j1su+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cd+l9F1G; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 46E2A1A137D;
	Tue, 14 Oct 2025 16:21:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1451E606EC;
	Tue, 14 Oct 2025 16:21:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4102A102F226E;
	Tue, 14 Oct 2025 18:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760458900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Q5VkFvpdG+5j0Avc9VWCGW1KAt0RMhA01Y+e3bX7gy4=;
	b=Cd+l9F1GhutWAKbJfpKFRtC+YM2PrCN0tPZ09Cx9GzjXpDfy6ubn8tnC8qJnwFUZ39jO17
	eNdzaS8m4UERRcu3lCRiWZhpqKjRxnakaD35amzU/pOtARpMVGm9te6DoTR1n0Hr7zV04Q
	J9+zJieAOM7cbRKmWRYfWcD+BQSy8lc9Ne+ShHZXv4VbSmgVH0RQ8BM+r5WVhvL8MFDGSL
	JOLWICqFEJg6btXW701gPlsRNCm5Ie8esQnC2b9ZZnOLI0iL+Lvmhr2K4BGc0PfIv9WAHs
	Qjx/EleSfJsCZ+9oKvI4SlaxyUe8QxtN4Z0gG6mSsPVLBosHHFEmreaRymxb4Q==
Date: Tue, 14 Oct 2025 18:21:22 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Douglas Anderson
 <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bajjuri Praneeth <praneeth@ti.com>, Louis
 Chauvet <louis.chauvet@bootlin.com>, thomas.petazzoni@bootlin.com, Jyri
 Sarha <jyri.sarha@iki.fi>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH] drm/tilcdc: Fix removal actions in case of failed probe
Message-ID: <20251014182122.5f63b027@kmaincent-XPS-13-7390>
In-Reply-To: <p4u2goyadub3dfuz4empf3g7a44b2ausy4hjjkcwj7nzgeochx@xztpij2i2lao>
References: <20251014143229.559564-1-kory.maincent@bootlin.com>
	<p4u2goyadub3dfuz4empf3g7a44b2ausy4hjjkcwj7nzgeochx@xztpij2i2lao>
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

Hello Maxime,

On Tue, 14 Oct 2025 17:36:47 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> On Tue, Oct 14, 2025 at 04:32:28PM +0200, Kory Maincent wrote:
> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> >=20
> > The drm_kms_helper_poll_fini() and drm_atomic_helper_shutdown() helpers
> > should only be called when the device has been successfully registered.
> > Currently, these functions are called unconditionally in tilcdc_fini(),
> > which causes warnings during probe deferral scenarios.
> >=20
> > [    7.972317] WARNING: CPU: 0 PID: 23 at
> > drivers/gpu/drm/drm_atomic_state_helper.c:175
> > drm_atomic_helper_crtc_duplicate_state+0x60/0x68 ... [    8.005820]
> > drm_atomic_helper_crtc_duplicate_state from
> > drm_atomic_get_crtc_state+0x68/0x108 [    8.005858]
> > drm_atomic_get_crtc_state from drm_atomic_helper_disable_all+0x90/0x1c8=
 [
> >  8.005885]  drm_atomic_helper_disable_all from
> > drm_atomic_helper_shutdown+0x90/0x144 [    8.005911]
> > drm_atomic_helper_shutdown from tilcdc_fini+0x68/0xf8 [tilcdc] [
> > 8.005957]  tilcdc_fini [tilcdc] from tilcdc_pdev_probe+0xb0/0x6d4 [tilc=
dc]
> >=20
> > Fix this by moving both drm_kms_helper_poll_fini() and
> > drm_atomic_helper_shutdown() inside the priv->is_registered conditional
> > block, ensuring they only execute after successful device registration.
> >=20
> > Fixes: 3c4babae3c4a ("drm: Call drm_atomic_helper_shutdown() at
> > shutdown/remove time for misc drivers") Signed-off-by: Kory Maincent
> > (TI.com) <kory.maincent@bootlin.com> ---
> >  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> > b/drivers/gpu/drm/tilcdc/tilcdc_drv.c index 7caec4d38ddf..2031267a3490
> > 100644 --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> > +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> > @@ -172,11 +172,11 @@ static void tilcdc_fini(struct drm_device *dev)
> >  	if (priv->crtc)
> >  		tilcdc_crtc_shutdown(priv->crtc);
> > =20
> > -	if (priv->is_registered)
> > +	if (priv->is_registered) {
> >  		drm_dev_unregister(dev);
> > -
> > -	drm_kms_helper_poll_fini(dev);
> > -	drm_atomic_helper_shutdown(dev);
> > +		drm_kms_helper_poll_fini(dev);
> > +		drm_atomic_helper_shutdown(dev);
> > +	}
> >  	tilcdc_irq_uninstall(dev);
> >  	drm_mode_config_cleanup(dev); =20
>=20
> I don't think that's the right fix. tilcdc_fini is pretty complex
> because it gets called from multiple locations with various level of
> initialisation.
>=20
> This is done because tilcdc_init is using a bunch of deprecated
> functions with better alternatives now, and those would make the job of
> tilcdc_fini much easier.
>=20
> That's what we should be focusing on.

I am also currently focusing on improving this driver (which has indeed some
weird code leftover), but this work will land in drm misc next while this i=
s a
fix for the current implementation which fix an unwanted warning.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

