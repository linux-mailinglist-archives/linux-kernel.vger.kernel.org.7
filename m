Return-Path: <linux-kernel+bounces-888806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29CC3BF47
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE5189DF61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB20345CB3;
	Thu,  6 Nov 2025 15:03:44 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97530E826
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441424; cv=none; b=c/h+QdXSN8aMJ75Uiw7h6uo6hpPhQR8RFjroV9al8JZslziORM75ptMXPRav3/slnTUHvNVs8XbvF2sz8cw0vIvBcC/PKXDeGVwWyw1PkO657GDWAsI5JWi6xnHoxY4r+8tjsczThp/7TYTBXSESwWSavP1foEFYQRg6QNqBcrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441424; c=relaxed/simple;
	bh=z4N6Bf0T0VYiK5Mxxn0CGxAsoHE2qIVKOD0hThM6PDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufdkwng3hLZnfKNIgWuasN6pSBfKb2dIxHMUIgqGWHwrItA2zgXBJxAkjbGjxeygJWZkfEENwI3/UCUAflr3Eo50YGhnjbrgJdqgBVr2dTgzo3hwNcAWqcRCtbbPUNbN76SuSX+XKY0YeMrblv60iHNXB8C8AN5NIXQ8wf9m3m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id D61071F8005B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:03:23 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 162E1B0A6F3; Thu,  6 Nov 2025 15:03:21 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id D776CB0A6F3;
	Thu,  6 Nov 2025 15:03:19 +0000 (UTC)
Date: Thu, 6 Nov 2025 16:03:17 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] drm/sun4i: Cleanup v3s mixer config fields ordering and
 indentation
Message-ID: <aQy4tVdoQeoEyuMV@collins>
References: <20250704154149.3464461-1-paulk@sys-base.io>
 <aKhFPRP8ILNkKAvy@shepard>
 <CAGb2v66=Ppqw+_fpAsRYd_4OBOhbHkk7RetfEXbYmvQ_+hoe7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0I3HyHXU+o/IGbUL"
Content-Disposition: inline
In-Reply-To: <CAGb2v66=Ppqw+_fpAsRYd_4OBOhbHkk7RetfEXbYmvQ_+hoe7g@mail.gmail.com>


--0I3HyHXU+o/IGbUL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu,

Le Thu 06 Nov 25, 14:01, Chen-Yu Tsai a =C3=A9crit :
> On Fri, Aug 22, 2025 at 6:24=E2=80=AFPM Paul Kocialkowski <paulk@sys-base=
=2Eio> wrote:
> >
> > Hi,
> >
> > On Fri 04 Jul 25, 17:41, Paul Kocialkowski wrote:
> > > The v3s mixer config definition is a bit messy. Tidy it up.
> > > No function change is intended.
> >
> > This patch didn't make it in the previous cycle.
> > Would it be possible to pick it up this time?
>=20
> I guess this is going to conflict with Jernej's refactoring / cleanup
> series.
>=20
> And, I think v3s is not the only one that has fields in a different order.
> Might we clean this up after all the refactoring?

Sure, it's better if this doesn't get in the way of the rework.
I'll send something after the rework is merged if the issue still exists.

Thanks,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--0I3HyHXU+o/IGbUL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmkMuLUACgkQhP3B6o/u
lQw+jg/+Mg60NxB2i+9ikMTfbzq3n2Owcv3rvikDcScmhu8WSIKRvFQC8jGJbUM4
5jsEuxjK/RtQyvoxmkuD404H54uPHes5kFIhZ5V2OJqxTN3UUptRmgsHhqwElZQI
G1be0tjhzXpoF1R/KsWfWi1xmf3tyf+kgapFhmAfdIU/E9To5b3BJydLDk0vMFFF
3bg+wujCC5OLjIWe3HbgrkAdHaqctEf4eMQCDQTW6TcyX3WMz6yRh7BCQluxtun4
R4a8XOMV5Pe6fgSWDLTSQ+QL5e1hcFjNTGRWzPqQ0CJkAVo7AdfOfUNxhQcTjbRB
jynrXFpdIoQAfj2NnSdrPheb/0cbKphnKlPSC1oiFM2DlJwveYUxTBliHBPUFO5g
Pxp9djf6mRLf3wXJXcozb9o4RWX0YXSh0jobwb6UeEIN8xYxix+5pMvFfO73IrQg
4hD+P7EfN53wQcMg993CWfO6h7d36XWDglFBUJQI7jIXQuuIOhIKCpv+1+RWZ/9m
UE0JJgPOXp3Suz7fR3IsVeNaoL4sGWY510e/ZUdddZflJNv7pAhklLCV/TbTPf54
jInSCc2fitmkqYGqCa+n9g0Yn8OoPMwGoqwI6FxT9QbaF5hWEKt0uvlp9uAs1srN
lpy0Pnxeniypj5RUxCNb0VoQ8FxJjeLkKqEzrD0uJheXl7Vpph4=
=lqF6
-----END PGP SIGNATURE-----

--0I3HyHXU+o/IGbUL--

