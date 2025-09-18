Return-Path: <linux-kernel+bounces-822609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC076B844DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8604A3B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE0302CA0;
	Thu, 18 Sep 2025 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY2y7E8o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3A13D638;
	Thu, 18 Sep 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194083; cv=none; b=YOKKGYq4XIJI/Lxu/6MJLkbD9LrcYXDo5StAwGhB0dLmpK3VNZ9NGt52zMKuTf+rjlIjWXPOTtMPbd5RxUXTecDNfNhHQmrao6GXVJDG95C8d583TPuqaLcCsIjlkxnmYnNdcI67tBmOMSRZQ5So61M8bZTW8bUK2zhX61Uxlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194083; c=relaxed/simple;
	bh=uqKLQL0kXPlTW24rRLvkA6f101bLzhi+v2aTGmvoekQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtqZXiWqnApvkQxqoaBlj7aNbCjw2n5llxi5G3/yvQSc+IYSeR81OEjEp80e0YyS2XFG/PpqRxflB6OmF2zLcBGuSj+d3U13fojjmNz6f39qnmYf0/zI9TwFt0BMOOejeEjBSUP/w5ZaqppvrYxFlgUhfYPpLxINQbQpt7MGIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY2y7E8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226F6C4CEE7;
	Thu, 18 Sep 2025 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758194083;
	bh=uqKLQL0kXPlTW24rRLvkA6f101bLzhi+v2aTGmvoekQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hY2y7E8oPFC4GuWcczzwCap37MRRFfXocXGwF5tfiob6nWiwEGmnk3ou8Ag/L2fOj
	 WNZP/y4IpK8Hr6/BlKZ9obj6KneJTH6b5m2Ms5TdqTMtv6QQt5S8m7tNeIM9FjxH+F
	 +xfQF7JOPk9XX5JZHhd+klKP5TiksKlVnn3bJnbEXMO+f4WZx97XuDpArSLa8tvB1O
	 dXARWNioqFc4PiD54+ZR3jVUYPKlbknmjL4sbyDa7u8PcqA6xUnBpyz5TbBnBjvDeq
	 DzGNAQqOi/yaQe5eobFR50ynsaNQ/Wzt4IWOyXQRcSvGSFkndiCumN2Jfsv7YC9g/z
	 uGkOtT69qz3+w==
Date: Thu, 18 Sep 2025 12:14:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	linux-sound@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
	Fabio Estevam <festevam@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v3 0/4] ASoC: fsl: fsl_qmc_audio: Reduce amount of
 interrupts
Message-ID: <85ea3256-dd31-47b1-8e2d-a9d207b28fa0@sirena.org.uk>
References: <cover.1755504428.git.christophe.leroy@csgroup.eu>
 <3d20d3ec-2f52-4cac-9c5c-fd2141a12a0b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Rv2MdpZahqmMZwq"
Content-Disposition: inline
In-Reply-To: <3d20d3ec-2f52-4cac-9c5c-fd2141a12a0b@csgroup.eu>
X-Cookie: Victory uber allies!


--1Rv2MdpZahqmMZwq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 08:12:21AM +0200, Christophe Leroy wrote:
> Hi Mark, Liam,
>=20
> Le 18/08/2025 =E0 10:19, Christophe Leroy a =E9crit=A0:
> > This series reduces significantly the amount of interrupts on
> > fsl_qmc_audio device.
>=20
> I can't see this series in linux-next.
>=20
> I see in patchwork [1] that this series still has status 'NEW' but also
> state 'archived'.
>=20
> What is the way forward to get it applied for v6.18 ?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--1Rv2MdpZahqmMZwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjL6ZwACgkQJNaLcl1U
h9D2swgAgTsZe6lJbstmvGT3sE8IM/SR5DbwYbMqquiSJfASLpWn6+IpQ9jey7dC
rBQ/Kac/dqktoRic2n2MNciZbkk1DBkKn7U3giWJn+Lc2TEdF/2k3D8gIb0fTkOv
pFy2ITzlJpnJe41HMTRLT0Y+2MmjTmLBp6H5mbExn9AJ5RtMcXxAMDfCB5pqSWQr
nSzduldkPYgbVRrD+RbcTzbal6R/Rjkatm1QfAt5iy7K4cvZQmNIZEOrePIP/Mzm
nt9+XFbYZHnCTxshgzhYuJBgsik6w211UWlWYuibWrlvWW/323RrN8l46amu67bJ
Zkpxs4GJvx/WIEeyf0hmzc8A7/+Qqw==
=xpzh
-----END PGP SIGNATURE-----

--1Rv2MdpZahqmMZwq--

