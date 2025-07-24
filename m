Return-Path: <linux-kernel+bounces-743703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48295B1021A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E06D1C873F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD625F99B;
	Thu, 24 Jul 2025 07:41:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616EC248193
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342887; cv=none; b=lFgVyyD1LLDr3TngI9U3UqzF8Pa+921aAnzTpe4iLeHyqTG0IXSRqAeu+Mfw+qon1P3aThVBhHWo+VwQJS/86X2hH7aw2KVEIzk8d2G5Cr2rT2YgUQPEdkieVFehcvdyQLDkv5XuvZWuL5vfXM6LXSbgY4n++9K8NChnFlvfGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342887; c=relaxed/simple;
	bh=Q/2NW7sSfTz9KcB7mML04f45vFgLMXJOtnTmM4OcWvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Luc9xKSt+kKmZ+/vL0sq8KcloRKtntMS18Q9MNv1/HmT1zF12AMMwcYPR4GL4Um0LGI3/ZKM5yhrrd4sJc9RWeqd8AhBByAwjv5LUxWkmih91utr1tAQN76w63JpeHxxAwTuSIreUqGw4w7eKd5eEq16xY8WyiSAZXTgj8RBnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueqZC-0004mm-Cq; Thu, 24 Jul 2025 09:40:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueqZ9-00A1Dn-32;
	Thu, 24 Jul 2025 09:40:35 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5B108447D62;
	Thu, 24 Jul 2025 07:40:35 +0000 (UTC)
Date: Thu, 24 Jul 2025 09:40:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, imx@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com, 
	andrzej.hajda@intel.com, festevam@gmail.com, simona@ffwll.ch, robh@kernel.org, 
	shengjiu.wang@gmail.com, rfoss@kernel.org, airlied@gmail.com, tiwai@suse.com, 
	jernej.skrabec@gmail.com, p.zabel@pengutronix.de, luca.ceresoli@bootlin.com, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, tzimmermann@suse.de, jonas@kwiboo.se, 
	victor.liu@nxp.com, s.hauer@pengutronix.de, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	linux-arm-kernel@lists.infradead.org, neil.armstrong@linaro.org, lumag@kernel.org, 
	dianders@chromium.org, kernel@pengutronix.de, cristian.ciocaltea@collabora.com, 
	krzk+dt@kernel.org, shawnguo@kernel.org, l.stach@pengutronix.de
Subject: Re: [PATCH v2 2/6] ALSA: Add definitions for the bits in IEC958
 subframe
Message-ID: <20250724-fair-sheep-of-success-e02586-mkl@pengutronix.de>
References: <20250724072248.1517569-1-shengjiu.wang@nxp.com>
 <20250724072248.1517569-3-shengjiu.wang@nxp.com>
 <87jz3ykpju.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vpabkhcgtahxjd2o"
Content-Disposition: inline
In-Reply-To: <87jz3ykpju.wl-tiwai@suse.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--vpabkhcgtahxjd2o
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/6] ALSA: Add definitions for the bits in IEC958
 subframe
MIME-Version: 1.0

On 24.07.2025 09:37:09, Takashi Iwai wrote:
> On Thu, 24 Jul 2025 09:22:44 +0200,
> Shengjiu Wang wrote:
> >=20
> > The IEC958 subframe format SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE are used
> > in HDMI and DisplayPort to describe the audio stream, but hardware devi=
ce
> > may need to reorder the IEC958 bits for internal transmission, so need
> > these standard bits definitions for IEC958 subframe format.
> >=20
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  include/sound/asoundef.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
> > index 09b2c3dffb30..7efd61568636 100644
> > --- a/include/sound/asoundef.h
> > +++ b/include/sound/asoundef.h
> > @@ -12,6 +12,15 @@
> >   *        Digital audio interface					    *
> >   *                                                                    =
      *
> >   *********************************************************************=
*******/
> > +/* IEC958 subframe format */
> > +#define IEC958_SUBFRAME_PREAMBLE_MASK	(0xf)
> > +#define IEC958_SUBFRAME_AUXILIARY_MASK	(0xf<<4)
> > +#define IEC958_SUBFRAME_SAMPLE_24_MASK	(0xffffff<<4)
> > +#define IEC958_SUBFRAME_SAMPLE_20_MASK	(0xfffff<<8)
> > +#define IEC958_SUBFRAME_VALIDITY	(0x1<<28)
> > +#define IEC958_SUBFRAME_USER_DATA	(0x1<<29)
> > +#define IEC958_SUBFRAME_CHANNEL_STATUS	(0x1<<30)
> > +#define IEC958_SUBFRAME_PARITY		(0x1<<31)
>=20
> I'd use "U" suffix as it can reach to the MSB.
> Also, you can put spaces around the operators to align with the
> standard format, too.  I guess you followed to the other code there,
> but following to the standard coding style would be better.
>=20
> With those addressed, feel free to take my ack for this patch:

Or make use of the BIT() and GEN_MASK() helpers.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vpabkhcgtahxjd2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiB428ACgkQDHRl3/mQ
kZw/twgArxwtsVQVLCtwTC1hTu1XO6jfEwAQpaPieSPwdzfilkYMvr5Y9dRXex55
jD6ZICtiqq+5U58pzhF7kpFQn1zBXU35xuvqu4H7EmC8yNPcgPr3gZd7FZOyFv+M
dehm4FgajYh4JhZBpfLNISc5DSTLiKiWA1fMQUPmfsyaHcikhRBPntgFqRp7Qz6Q
rnjazptVZ4MOkFgCL/Gnuzjs+0go1y4H6rLEcDdvFqGx9id/GJiQ+DHUWXEHnmr4
12scaPJb4fWgbwJ3/YtzCDHPUG6wVyoaQ3oek6NRQaXZ8T3Zic0IGem1++odVGZM
b7VK73jGSrhTMmTWcU3DIsNHR5b8mw==
=My/c
-----END PGP SIGNATURE-----

--vpabkhcgtahxjd2o--

