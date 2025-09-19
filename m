Return-Path: <linux-kernel+bounces-824810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA1B8A31C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FCD1C87D61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED63164CE;
	Fri, 19 Sep 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U826dbrf"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337D3164C7;
	Fri, 19 Sep 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294537; cv=none; b=gzJuZGDa3cVaPYmWknUTRlj/RxGslx9kwEzUbajE39tN7qbl3vPCgrOOyzd5bRkPQab9FmbR2RamtcX23sN8rYuAhFx3eluJs+L9yzsNCJ928y6XKtokLK8zMYb+p6QX8wA8zuYRFhg9YG+udAgzOQa30C2v2zO0BwBHIH5JcxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294537; c=relaxed/simple;
	bh=8ryEgTZTMEPj8syckr/YTW94b0ggpKy61vp5LUHsNX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U55MK3FEaFiFEPCv1PNKiQt6F/XeMNpND38nDzeeYD7Lxfvlb5TN7yQodWZ1P2T0Cqk2nk5ZxFQR/GU006JSWJtJH44wwrsBAT6nQ1FYHFzU2JLjWAFpOk4MZZ1XT9lROotuFEvEZR+JZRW8ZWHZ2Nx5Yg3ZRMR7VBaTdHbD+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U826dbrf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D0573C8F1D8;
	Fri, 19 Sep 2025 15:08:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 55895606A8;
	Fri, 19 Sep 2025 15:08:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C38A0102F1D79;
	Fri, 19 Sep 2025 17:08:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758294530; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kVkUIo4dQVT4SOntZ8cZ5+tgvO9vk9zBQavLp3x8Y90=;
	b=U826dbrfoYbVfNFx4Z8CHR+MxQoqEzgV6pb0s//raOyvHWb+CQ0/CKQ/dvTw3eNBDb9BPb
	YXZdxuRY6vu3bawS6Tje2jgmpPLMKsT2HtUB/94Pm6vym/Dk6voLAxKbxJ99iDghwh67TQ
	8NBtm1FzWB9pywWDF1xjX5IQFCA13ZXh+ost/xZ51KAXR2V3X44lQNmgFJJexbXTwG7ACf
	McDDbYEbyeudr/9TpAMH8iXWVGDFn2dSle/rGdtMiRcZdDI9+xSyG45ewNpQlB/MxyB4d1
	zTQFL5Q1gGkaGrJ27v+uP1jKiK8KBld0WRlbQ6IAyT9U3oRWGv6aT32Z5MxPag==
Date: Fri, 19 Sep 2025 17:08:24 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org,
 dianders@chromium.org, cristian.ciocaltea@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 l.stach@pengutronix.de, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH v5 4/7] drm/bridge: dw-hdmi: Add API
 dw_hdmi_set_sample_iec958() for iec958 format
Message-ID: <20250919170824.63df1d6e@booty>
In-Reply-To: <CAA+D8AP8eJ8_pueq1ZSb-ORzTJbNT7HOwKFOO5ZCXqgqoQ1qGQ@mail.gmail.com>
References: <20250821073131.2550798-1-shengjiu.wang@nxp.com>
	<20250821073131.2550798-5-shengjiu.wang@nxp.com>
	<20250901185208.394cd162@booty>
	<CAA+D8AOCTqb5jLeRapYk4wRGZrsrPiuAR=ow3OA1B0+M9X4k7w@mail.gmail.com>
	<20250909-omniscient-honeybee-of-development-adca8a@houat>
	<CAA+D8AM=aRU-0QcgtxZ+=YBZ2+kMrP2uzSE3e+NJs3Z3zkrSVg@mail.gmail.com>
	<CAA+D8AP8eJ8_pueq1ZSb-ORzTJbNT7HOwKFOO5ZCXqgqoQ1qGQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Shengjiu,

On Fri, 19 Sep 2025 11:43:05 +0800
Shengjiu Wang <shengjiu.wang@gmail.com> wrote:

> Hi Luca
>=20
> On Wed, Sep 10, 2025 at 6:29=E2=80=AFPM Shengjiu Wang <shengjiu.wang@gmai=
l.com> wrote:
> >
> > Hi
> >
> > On Tue, Sep 9, 2025 at 2:39=E2=80=AFPM Maxime Ripard <mripard@kernel.or=
g> wrote: =20
> > >
> > > Hi,
> > >
> > > On Wed, Sep 03, 2025 at 06:41:05PM +0800, Shengjiu Wang wrote: =20
> > > > On Tue, Sep 2, 2025 at 12:52=E2=80=AFAM Luca Ceresoli <luca.ceresol=
i@bootlin.com> wrote: =20
> > > > >
> > > > > Hello Shengjiu,
> > > > >
> > > > > On Thu, 21 Aug 2025 15:31:28 +0800
> > > > > Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> > > > > =20
> > > > > > Add API dw_hdmi_set_sample_iec958() for IEC958 format because a=
udio device
> > > > > > driver needs IEC958 information to configure this specific sett=
ing.
> > > > > >
> > > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > > Acked-by: Liu Ying <victor.liu@nxp.com> =20
> > > > >
> > > > > [...]
> > > > > =20
> > > > > > +void dw_hdmi_set_sample_iec958(struct dw_hdmi *hdmi, unsigned =
int iec958)
> > > > > > +{
> > > > > > +     mutex_lock(&hdmi->audio_mutex);
> > > > > > +     hdmi->sample_iec958 =3D iec958;
> > > > > > +     mutex_unlock(&hdmi->audio_mutex);
> > > > > > +} =20
> > > > >
> > > > > Apologies for jumping in the discussion as late as in v5, but I n=
oticed
> > > > > this patch and I was wondering whether this mutex_lock/unlock() is
> > > > > really needed, as you're copying an int. =20
> > > >
> > > > Thanks for your comments.
> > > >
> > > > Seems it is not necessary to add mutex here. I just follow the code=
 as
> > > > other similar functions.  I will send a new version to update it. =
=20
> > >
> > > Let's not be smart about it. Next thing you know, someone will add
> > > another field in there that would absolutely require a mutex and now
> > > you're not race free anymore.
> > >
> > > Unless there's a real concern, the mutex must stay.
> > > =20
> >
> > Ok, thanks for comments.  Then Patch v6 need to be dropped.
> >
> > Is there any other comments for this Patch v5?
> > If no, can this series be accepted?
> > =20
>=20
> Can we have a conclusion that keeps the mutex as Maxime's comments?

If Maxime wants the mutex to be kept, it's fine.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

