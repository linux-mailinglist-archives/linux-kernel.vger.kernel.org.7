Return-Path: <linux-kernel+bounces-868318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC009C04E56
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBB33B2EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DF62F0C6A;
	Fri, 24 Oct 2025 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OAiC5xik"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E282F1FC7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292528; cv=none; b=TAIhvPjIr+ZlSXx7EdrPN1EzvMYcRMkGe/KQZgUhNo7k+iBF2M/bOulfE7s0wnKWaVMLLjdmfm0Zn/izeRTdCiDGoGEiTfRyiNujZ37/VMqP8EcaqGCY5BA+iQA8ocUzZcSy8oBij35Ah0sTHbeA1iqDInW9M+GQXcv6HHt1mSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292528; c=relaxed/simple;
	bh=aR+JKqf2KJtx9OXnrDQ37SCTFjChvqCBpowAQpfeMaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrPlklz6cVrTxNyE3rsoLhFjIQzuLxN0g6HOio5EyDOq9Ubxi18i/zfFMlWcCd5N2PCLESgzQGvFr4d5H/MHfvNaZ0feHcBsGxbSmxE5VK2Ds3aV5p0DZnNk+l5oFqUFuwYHLtUzdDf0svyyayDaqsB9c2bQF2kRYtjQgxdzC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OAiC5xik; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 736AE4E412D1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:55:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 375EE60703;
	Fri, 24 Oct 2025 07:55:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCA2D102F23EC;
	Fri, 24 Oct 2025 09:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761292523; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PFvilJoQ2eOzHbk5yIska+gVk7PLougEK5Za3LiPZTE=;
	b=OAiC5xikTDmMr3GAaJDS7EUvNuVSTA9+zOIFxJv8psYffJRfTHpfry33/PplIuVy5JbDvY
	JE32Mr2f3Y7no4I1K52a/Ke8wcb/fVz1Riww4xr8Ytv7sC6ty7omfiPUZIK01pjNhlA6ZU
	7oP+gXL341FE5srAIhdd9SFCJ5yNXOm8LdS0cl0LmYHmqGzc88W/rH0dlKSkKWR4rNc9BV
	lfsffrhOvf/JQRkjhLIjUGhLWLzkzJpukM1m3OKhFSRYzNnoLWpPN3XlDcHv0A5wzTgn1X
	vfE0K/3EoHasRi1/ybphm60Kl6VRLdmL9NmcV5Jk0uem/QkoWKnz0m5xjlb+7A==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Herve Codina <herve.codina@bootlin.com>
Subject:
 Re: [PATCH v2 5/5] regulator: ltm8054: Support output current limit control
Date: Fri, 24 Oct 2025 09:55:16 +0200
Message-ID: <12768289.O9o76ZdvQC@fw-rgant>
In-Reply-To:
 <CAHp75VciOagW2grjYNxsBLKtwrEqaJZa-mKmUQgW8L8X3mky7A@mail.gmail.com>
References:
 <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <3500149.e9J7NaK4W3@fw-rgant>
 <CAHp75VciOagW2grjYNxsBLKtwrEqaJZa-mKmUQgW8L8X3mky7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5935577.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart5935577.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 24 Oct 2025 09:55:16 +0200
Message-ID: <12768289.O9o76ZdvQC@fw-rgant>
MIME-Version: 1.0

On Wednesday, 22 October 2025 18:37:31 CEST Andy Shevchenko wrote:
> On Wed, Oct 22, 2025 at 11:06=E2=80=AFAM Romain Gantois
> <romain.gantois@bootlin.com> wrote:
>=20
> ...
> > For part 2., I'm having more trouble finding a proper solution. One
> > potential fix would be to put the IIO channel reads/writes in a LTM8054
> > driver work item and have them run without the regulator lock held. This
> > would incidentally also solve part 1., however it would make the current
> > limit operations asynchronous, and it seems like a lot of unnecessary
> > complexity.
>=20
> Interesting that locking a single  regulator, there is no context and
> hence the lock class is global. Hence whoever calls a regulator will
> have the same lockdep splat, even when false positive. Basically the
> solution for those cases (and I don't know if yours / this one falls
> into the category) is to enable context for the single regulator
> locking and set up a lockdep class (so the regulator core should call
> lockdep_set_class() at mutex initialisation).

The strange part is that this "global lock" is actually a lockdep-provided
mutex which isn't taken when lockdep is disabled. It seems to be there to
ensure that ww_mutex contexts are not taken recursively, but then again the
IIO driver is calling regulator_lock_*nested*() so it sounds like
recursively taking the ww_mutex context might be expected here...

Thanks,

=2D-=20
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart5935577.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmj7MOQACgkQKCYAIARz
eA6I7A/+PX2HOKEhaaWSZPLsA52iJ4dmaYrH43O2kGXjvFnQ0mtpI2tRMu3lp5F4
0F7UYfgEL15RJN7mbOhZ9Bv3rceP9hFerIY3sDI0pD3+x1Om/YsINLfWEj7GNlXO
SN/SEDyiZhXRw6k7HneqJW5tffIwM7vkEsP+jkf4lj+4qQzg9t76IrBnahbwSaXK
S2IFbmcdyspMJD+a00RyQQJoJVxSvbJEvaT0cDlgl0Y9YaXxWgX+i7KKaZu1xM5f
K2hJu6VE5GaT6NjRBnin9xg7XoH9Po4uq698E0FESM3Fu+nPjCRX2mRkbcjeHlCx
HTZH6Yji8QozJgJ07ABT4V6w/0d2oPavv6qokzXw/NWwae2qsigyDadbXzdQ+KMT
4BEz43iIa3l2+fjXyhjg4OUkZlpHffXd3oi9/McMmPkguxCHt4ZLnVMTi4ybUMao
UOgiNWYSZNyx4xFNOf/rsDJu4G1vmegN7JWWAEC6JmBUlnJw68GoS725HPmRchTY
ncl+L1Y+xogC+uWBFCY8sgZLoAWHS2CQBhzR6Fm88hagar5pt/JHbbwOUPv/LOxt
06aQaoOJFS0UxYq9uXrZYNN7824Vaen0KtH0ouVlifllEF4pCFpn2bs6qAa9omSL
e2bIAEsG4JyMsOwuBLDMYIUfjzG2EnKX0c5W/ZRdQ7F+yoe3haQ=
=Va+8
-----END PGP SIGNATURE-----

--nextPart5935577.DvuYhMxLoT--




