Return-Path: <linux-kernel+bounces-736792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA103B0A1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A452F1793BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1FD2BD585;
	Fri, 18 Jul 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr5yb86B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2F221F04
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838432; cv=none; b=UiamiBBHXOiyWPc8JFbj6uQc/2AUJdKaRIPC9QQ1PFqndM46LKEctlVrRKWXvH2f/dXkrKqf5o7x2HRhkhP8fYAiznofbp97rATPAmWGm9TTJlB7iFgFEkjXQHrioveUazFhxw3EBQLaHGHzlFevLljvwdoHOg+2fZBgSgWIZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838432; c=relaxed/simple;
	bh=ss4gbTsOaXhi72j0lyuVqUWKJ1y9ouYj/VwkNqG/yFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs0oXlpOYKNTiHoGggQVbgmkLpBZRAQWmPSTateZWp0E7Hp+pvz/f+3BrH2eBR+EvE1p7AE6dJ5tx7hrGfW1eW1yw5WeCI+aq1MxhyGwoseePau4wSOyi4K2v+84H081p6/u7ygikxmmgMFdD70yFO8bXN+LhBXaz5T+SVNznNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr5yb86B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E2AC4CEEB;
	Fri, 18 Jul 2025 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838431;
	bh=ss4gbTsOaXhi72j0lyuVqUWKJ1y9ouYj/VwkNqG/yFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pr5yb86BsBIJl0B7TbnBxNd+/lG2uDdwzKLGVWcSqLbrb+3t/G2itvDOIM5H0u0v/
	 fmbSJ/mowIj33aEKKlAf7xIhgBtmgOnDV1Iu6q577QxF7bQEy1VqwlMZKx5kstH/um
	 OqWdTNwkm1hMDsLVfVYJuv5SrVY26Y+Hvv9xzEg94BKQXPyWCifEfQMYDPtcfBwteD
	 6gWI476NY/87puMX2k3DTCF2IBK0LNk4XlMFMbyydsPPjrcYTPdJ4ElbMh5TXlKar7
	 jeTjpukFzkTs2HtnrRKwAoqUt/f196DVdVDCo5wmN6H40zM/APglsdBmHf6ER3dP+H
	 nMaLagxZ9oq8Q==
Date: Fri, 18 Jul 2025 13:33:34 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, Klaus Jensen <k.jensen@samsung.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] nvme: Add Controller Data Queue to the nvme
 driver
Message-ID: <fjnpyvjn2kqlmlzagvuy43numc7u44ylls3nqxay4sh5qjayv5@xq2ty7wipbg5>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
 <20250714130230.GA7752@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bytbhyrsj7nnxlk3"
Content-Disposition: inline
In-Reply-To: <20250714130230.GA7752@lst.de>


--bytbhyrsj7nnxlk3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 03:02:31PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 11:15:31AM +0200, Joel Granados wrote:
> > Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The main motivation is to enable Controller Data Queues as described in
> > the 2.2 revision of the NVME base specification. This series places the
> > kernel as an intermediary between the NVME controller producing CDQ
> > entries and the user space process consuming them. It is general enough
> > to encompass different use cases that require controller initiated
> > communication delivered outside the regular I/O traffic streams (like
> > LBA tracking for example).

Thx for the feedback. Much appreciated.

>=20
> That's rather blurbish.  The only use case for CDQs in NVMe 2.2 is
> tracking of dirty LBAs for live migration, and the live migration
Yes, that is my understanding of nvme 2.2 as well.

> feature in 2.2 is completely broken because the hyperscalers wanted
> to win a point.  So for CDQs to be useful in Linux we'll need the
> proper live migration still under heavy development.  With that I'd
Do you mean in the specification body or patch series in the mailing
lists?

> very much expect the kernel to manage the CDQs just like any other
> queue, and not a random user ioctl.
This is a great segue to a question: If CDQ is like any other queue,
what is the best way of handling the lack of CDQ submission queues?
Something like snooping all submissions for these CDQs and triggering a
CDQ consume on every submission?

I went with the ioctl as the faster way to get it to work; I might
explore what having it as just another queue would look like.

> So what would be the use case for a user controlled CDQ?
Do you mean a hypothetical list besides LM in NVME 2.2?

Best

--=20

Joel Granados

--bytbhyrsj7nnxlk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmh6MP8ACgkQupfNUreW
QU8hMgwAgBytHdz5pT7HLF0dvl1/Vh/v44hch5bV2NWwqeQWLoEHhrQuP0UEViGv
S1BMHYMIske+GAtL+AKRdNL/2LpuzQP4YSftL+fGtNxlPfOq4ehoNMeSVWxHuJa+
XnyJomh527pzEK9RkwMKa1R/9OXjZo4aHluV0jUAeGwtD012iXG2cVa2ADac3u0b
G7r+MkrJ8iA92QGjae+YThqq8qau7AfKIYLfzDRCtdBtkJA7wKSXY+2fe8HqZmmk
ODmdSY8QhyXs7dltzHbSCzuGuU8PTNIs8Ko9V7u/Jqwj0MZ/2YWkcFpLQ0ZWQ503
/CQoS44IQw9WXPnGwmtTBeBUUHAar0QXCUQAquWIjDcHFeH9F+J6/9rAmwzJ9FeH
UkQ72DNt+ebsMmsGOdlNVYQOhnXeH6ZPPkX74bSxVrpb1fJx0OWJFgNSfWb8X47E
AOSONgnQWaHd+Pz7QOl18tqyscX/RnOK1ylei0mqbpenj4bCwi+x7LK/R0TrCM9p
DP4izM1j
=agQF
-----END PGP SIGNATURE-----

--bytbhyrsj7nnxlk3--

