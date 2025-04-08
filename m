Return-Path: <linux-kernel+bounces-592738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B0A7F0F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 01:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3051B17CC2B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2FF22756A;
	Mon,  7 Apr 2025 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmcVeA5+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4356C228C9D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744068164; cv=none; b=Aq+yneksNZJS95Xj7diCVtp7phpEmWkANwUc3tJUOCAlCZxs1SbUdiBhRolh/9qYy55OEZUCCl6csC9xpRd5tVXDK/hVR7hQS1ODpSJZIAq163SxV/u4IcGMBZ+NQ6zMf2JC8JT0hbBIjidnwyGtDVwhm7Xbs+wX8mWHDes0iE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744068164; c=relaxed/simple;
	bh=80ZGVNCb1le4Kw9QAhQ1/FSPErr0GaBFWW7iDJ175EY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvFHttySaXXPA4WDV1kuN1aIrj9FEcCUGboJ0W0ynENFyrBdT7Uj/LMD13zTueJEwgILGOkVE0/HHNEZ4CpSURRM+VeyU7hESTLlGWo63Xb8l2LJnWD8nBxa9GSU7f+9H1i88JHxoQs2EywFdNhCT2VFPZZf3uoYdQIhQ8KIzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmcVeA5+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744068162; x=1775604162;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=80ZGVNCb1le4Kw9QAhQ1/FSPErr0GaBFWW7iDJ175EY=;
  b=cmcVeA5+1BfIs3iUGwi9nG154ZzQ+/DgLAJdBk1uybtSi3+p2MfEce3i
   93fvJ26bwPvtQ0ybIh4dVGqXHs8CtkL7JTELKIIyeq2RCbVEw4xCQjZOb
   GACbvj3HD/B2FRd34hsfMtdSLtdUcMuXa4uzjT0WCyPkza/zjJrN0ypkC
   LI80vu/86AlueBAzK+Xjk26kU1+EU0hpBcQTq4+hQkRSNXm12fy79XpZ2
   PhzztEGYCvXnTFk+GZMFZ9kq90amG9qca6ffoyV8t/GaX5LapWF0f04rm
   rAqtQER8v/NYKm+0u1zJpWCzSR6c7zL1oYuixTu8hUebmQ0JvnO0NSdfW
   Q==;
X-CSE-ConnectionGUID: 3jRSUfdlR+u6qAV58eHajw==
X-CSE-MsgGUID: m8cuLDeiT2CzAOdXc7UUUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49328011"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="49328011"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:22:41 -0700
X-CSE-ConnectionGUID: l/iskZYpQnmABjwIMSeaqg==
X-CSE-MsgGUID: gTDvxkaDQd6Vw+v4Y0W+RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="151281706"
Received: from orsosgc001.jf.intel.com (HELO orsosgc001.intel.com) ([10.165.21.142])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:22:41 -0700
Date: Mon, 07 Apr 2025 16:22:40 -0700
Message-ID: <85a58rsgjj.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: imre.deak@intel.com,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang
 <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Linus Walleij <linus.walleij@linaro.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Douglas Anderson <dianders@chromium.org>,
	<dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] panel/auo-a030jtn01: Use refcounted allocation in place of devm_kzalloc()
In-Reply-To: <Z_P0A9lxWD0aAdjp@ideak-desk.fi.intel.com>
References: <20250401-b4-drm-panel-mass-driver-convert-v1-0-cdd7615e1f93@redhat.com>
	<20250401-b4-drm-panel-mass-driver-convert-v1-4-cdd7615e1f93@redhat.com>
	<Z_P0A9lxWD0aAdjp@ideak-desk.fi.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/29.4 (x86_64-redhat-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Apr 2025 08:49:23 -0700, Imre Deak wrote:
>
> Hi,
>
> On Tue, Apr 01, 2025 at 12:03:47PM -0400, Anusha Srivatsa wrote:
> > Move to using the new API devm_drm_panel_alloc() to allocate the
> > panel.
> >
> > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> > ---
> >  drivers/gpu/drm/panel/panel-auo-a030jtn01.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c b/drivers/gpu/=
drm/panel/panel-auo-a030jtn01.c
> > index 77604d6a4e72c915c40575be0e47810c90b4ed71..83529b1c2bac2e29f41efaf=
4028950214b056a95 100644
> > --- a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
> > +++ b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
> > @@ -200,9 +200,10 @@ static int a030jtn01_probe(struct spi_device *spi)
> >
> >	spi->mode |=3D SPI_MODE_3 | SPI_3WIRE;
> >
> > -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > -	if (!priv)
> > -		return -ENOMEM;
> > +	panel =3D devm_drm_panel_alloc(dev, struct a030jtn01, panel,
> > +				     &a030jtn01_funcs, DRM_MODE_CONNECTOR_DPI);
>
> This doesn't compile and (yet) it's pushed already to drm-tip. AFAIU
> it's supposed to be
>	priv =3D devm_drm_panel_alloc(...);

Yes:

drivers/gpu/drm/panel/panel-auo-a030jtn01.c: In function =A1a030jtn01_probe=
=A2:
drivers/gpu/drm/panel/panel-auo-a030jtn01.c:203:9: error: =A1panel=A2 undec=
lared (first use in this function)
  203 |         panel =3D devm_drm_panel_alloc(dev, struct a030jtn01, panel,
      |         ^~~~~
drivers/gpu/drm/panel/panel-auo-a030jtn01.c:203:9: note: each undeclared id=
entifier is reported only once for each function it appears in

Please turn on the config options for particular module if you are making
changes to that module.

>
> > +	if (IS_ERR(panel))
> > +		return PTR_ERR(panel);
> >
> >	priv->spi =3D spi;
> >	spi_set_drvdata(spi, priv);
> > @@ -223,9 +224,6 @@ static int a030jtn01_probe(struct spi_device *spi)
> >	if (IS_ERR(priv->reset_gpio))
> >		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to get re=
set GPIO");
> >
> > -	drm_panel_init(&priv->panel, dev, &a030jtn01_funcs,
> > -		       DRM_MODE_CONNECTOR_DPI);
> > -
> >	err =3D drm_panel_of_backlight(&priv->panel);
> >	if (err)
> >		return err;
> >
> > --
> > 2.48.1
> >

