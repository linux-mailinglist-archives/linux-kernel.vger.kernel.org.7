Return-Path: <linux-kernel+bounces-592815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C7A7F19B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 02:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB347A31C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 00:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75313D2FB;
	Tue,  8 Apr 2025 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuF9mxA3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E117C91
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744071507; cv=none; b=RYX+x8JeVpIy2bVxo/bmZrtDxQu1MiOOUDhSsjQkpq4Mc25h53sPR0JPVBtkPBbO0GyE8lBBHLEGPtSV/J28YkmATRv+2fRWqPfJXBcqYG4NcWzHu59VW7ZVnfRS0FccVXp4m7Qi0fJjrFBOKJ7z6Hy2SNQ1gvms9GbTUpcqtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744071507; c=relaxed/simple;
	bh=NEg8ot9+60o0XVU9F8BkVCyIub49xYwxQ7uQrOauiII=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvaJ3DUfL9VXKjVarRMupm9OYPW8h5UTN6av3RR+JGLbKBmyIbvklBr1JeUfNYIjv59oyMVXZtzRDLpPZ5NC2f0IMDrujR/y2cNdtF3iF2JsoIXKqKDZFmeb+oKpa3n5KgoY+8GUfjuan9wyiWEWY35zrvStR27QRFvZBuaKsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuF9mxA3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744071506; x=1775607506;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NEg8ot9+60o0XVU9F8BkVCyIub49xYwxQ7uQrOauiII=;
  b=HuF9mxA30/5uzIvt+LXwMbHEpnOQEt8MznBwJ07eR/W+U2MJFQCc2+bU
   xGtb3FVCUgvTkVe7ya6R8nRLBH/ZYaS1VX72i8VLwMVK8n3inxlyiAHKC
   YjTy2fFNZQJhnihGZgOSxgqJrH1xttjBC+G5j89h7OZf+YOKUn8rGZmu6
   aAj65b2KbPyEVK053bNQvmFfzCVmL59mwK2EyFGGfuCkyyr+1E0YsATS7
   I3IbjNoYYUMnskHqjijjZGn0brJ7jOBMlW8i6FsPHQZGwXXHU9SXwTmmS
   0vYFLj1Ja+DEFJyL/r0WhrGRiW3MiticXuFKQk4P+Pzi/06xdYl11pzI8
   w==;
X-CSE-ConnectionGUID: rGDqpNSmTcapiTflr0R3JA==
X-CSE-MsgGUID: cn8BTrdDQlWx0+b4Ko8gnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44629334"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="44629334"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 17:18:25 -0700
X-CSE-ConnectionGUID: t3H/F+gwSFCwxKNA/uREKg==
X-CSE-MsgGUID: dK9qkXUXS7GHlshAfYP5jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="151291770"
Received: from ksmithe-mobl1.amr.corp.intel.com (HELO adixit-MOBL3.intel.com) ([10.125.211.148])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 17:18:25 -0700
Date: Mon, 07 Apr 2025 17:18:23 -0700
Message-ID: <87bjt7eca8.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: <imre.deak@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	"Jessica Zhang" <quic_jesszhan@quicinc.com>,
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
In-Reply-To: <85a58rsgjj.wl-ashutosh.dixit@intel.com>
References: <20250401-b4-drm-panel-mass-driver-convert-v1-0-cdd7615e1f93@redhat.com>
	<20250401-b4-drm-panel-mass-driver-convert-v1-4-cdd7615e1f93@redhat.com>
	<Z_P0A9lxWD0aAdjp@ideak-desk.fi.intel.com>
	<85a58rsgjj.wl-ashutosh.dixit@intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/29.4 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Apr 2025 16:22:40 -0700, Dixit, Ashutosh wrote:
>
> On Mon, 07 Apr 2025 08:49:23 -0700, Imre Deak wrote:
> >
> > Hi,
> >
> > On Tue, Apr 01, 2025 at 12:03:47PM -0400, Anusha Srivatsa wrote:
> > > Move to using the new API devm_drm_panel_alloc() to allocate the
> > > panel.
> > >
> > > Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> > > ---
> > >  drivers/gpu/drm/panel/panel-auo-a030jtn01.c | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c b/drivers/gp=
u/drm/panel/panel-auo-a030jtn01.c
> > > index 77604d6a4e72c915c40575be0e47810c90b4ed71..83529b1c2bac2e29f41ef=
af4028950214b056a95 100644
> > > --- a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
> > > +++ b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
> > > @@ -200,9 +200,10 @@ static int a030jtn01_probe(struct spi_device *sp=
i)
> > >
> > >	spi->mode |=3D SPI_MODE_3 | SPI_3WIRE;
> > >
> > > -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > -	if (!priv)
> > > -		return -ENOMEM;
> > > +	panel =3D devm_drm_panel_alloc(dev, struct a030jtn01, panel,
> > > +				     &a030jtn01_funcs, DRM_MODE_CONNECTOR_DPI);
> >
> > This doesn't compile and (yet) it's pushed already to drm-tip. AFAIU
> > it's supposed to be
> >	priv =3D devm_drm_panel_alloc(...);
>
> Yes:
>
> drivers/gpu/drm/panel/panel-auo-a030jtn01.c: In function =A1a030jtn01_pro=
be=A2:
> drivers/gpu/drm/panel/panel-auo-a030jtn01.c:203:9: error: =A1panel=A2 und=
eclared (first use in this function)
>   203 |         panel =3D devm_drm_panel_alloc(dev, struct a030jtn01, pan=
el,
>       |         ^~~~~
> drivers/gpu/drm/panel/panel-auo-a030jtn01.c:203:9: note: each undeclared =
identifier is reported only once for each function it appears in
>
> Please turn on the config options for particular module if you are making
> changes to that module.

Though probably, you can argue, that the pre-merge CI build should already
be doing this. A sort of allmodconfig for the DRM subsystem, so that these
kinds of issues don't get missed.


>
> >
> > > +	if (IS_ERR(panel))
> > > +		return PTR_ERR(panel);
> > >
> > >	priv->spi =3D spi;
> > >	spi_set_drvdata(spi, priv);
> > > @@ -223,9 +224,6 @@ static int a030jtn01_probe(struct spi_device *spi)
> > >	if (IS_ERR(priv->reset_gpio))
> > >		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to get =
reset GPIO");
> > >
> > > -	drm_panel_init(&priv->panel, dev, &a030jtn01_funcs,
> > > -		       DRM_MODE_CONNECTOR_DPI);
> > > -
> > >	err =3D drm_panel_of_backlight(&priv->panel);
> > >	if (err)
> > >		return err;
> > >
> > > --
> > > 2.48.1
> > >

