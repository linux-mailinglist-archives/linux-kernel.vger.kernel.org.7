Return-Path: <linux-kernel+bounces-821345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D46B810AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9505954116C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD182FC019;
	Wed, 17 Sep 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="KE97qftU"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F72FC002;
	Wed, 17 Sep 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126659; cv=none; b=OWeW4GVxUcaobjegDSpHHhvT8kpZsO+445KlcmV33rP/bBN9fO9SzmmOxvd/D1+UoIdDgrw+FsauIAzYFuu+EhOAl+cn5s/N5YR8MbBoCasBpTazM1xUCqLUT9tb8IHxHNhLrMWSkcFlXYUEM/glMt6c1qHWJjU1JugLcYLmoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126659; c=relaxed/simple;
	bh=UTcpWzsO83bU5VLg2V0mNfFARp0fI0qWWWu0UU2p/o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlDdEbH4I/Z/nf3WJx0PM+IMa1TE7dcT7cAU6pPK64aWNl0dgdR9hEB6HrNR81RxKLxRbBBn3DPWhr+GttbqCgqKBnyje2BK5dxqfjCsOBt04tuUFS1ZhDBWy0LZuIoC6ZC8QS+QVrPKPtJiUQe+kjboOPWDXj+R8wNTDc2eJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=KE97qftU; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1758126624; x=1758731424; i=christian@heusel.eu;
	bh=5YPboLUdZctXu5m55DOsPmcWf3tVIqydrP9uMcMNWuU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KE97qftUtTS0K4iP/8AFSgOaoOh66ZlKP4hM4iCLEYyqn0v5ehB5Ew5b/EhaQurz
	 AUD5gu7UBjzHxegYy9n1ArDFghZxcwbvF5LHa4aDj8a67RB4QY9p7KPe095A4/Duy
	 FrSnYe2HKMFVfxEXYeTlUQkVC5zL3ACmolYRSG3wpL0IraIpHt0BnKRKhU9OYCsX/
	 obUNgwz68NGPIB2zXppaYqSyhDrKOHJyn+PI3w+UydFlNJklzt2J7qtTbGEbefO7v
	 UO7ZJBpAfr8u9XXModp3kCd9wyMMpv1mi95ccSlPYYTfK+jYqFY4/g3AbBfsjW203
	 /bimYma95uxIdBloFA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MlfCk-1uXnUY152Q-00ihC6; Wed, 17 Sep 2025 18:30:24 +0200
Date: Wed, 17 Sep 2025 18:30:22 +0200
From: Christian Heusel <christian@heusel.eu>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	rust-for-linux@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250915: error[E0425]: cannot find function
 `atomic_read_acquire` in crate `bindings`
Message-ID: <e734f4e7-914e-4350-a6b5-968eff64af57@heusel.eu>
References: <CA+G9fYtT7HNBM2XBbePeZ-Fw+ig7SJ+JE_NpQ1VuHR_TvAjX2w@mail.gmail.com>
 <CA+G9fYs4JB0ngq+aryXHVQSq-f05cb4agCfyM9zN0SgprQf0_A@mail.gmail.com>
 <27366f94-67d4-4b73-b420-cacdbe9d603f@heusel.eu>
 <aMpma-2UokTo0u9j@stanley.mountain>
 <228245d0-4620-48c7-b4bd-532bb873bdf2@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tgcjvuwq4ccznzrm"
Content-Disposition: inline
In-Reply-To: <228245d0-4620-48c7-b4bd-532bb873bdf2@leemhuis.info>
X-Provags-ID: V03:K1:Tig3e/n2RcHavpNsMkY2JCTAJHXDurtAqQcHheMpmv1TsxMgP8L
 w8TDk1p+7SB1tExC8/4MIS6aFEW1+G7j5prTndFntaUxLw1vFYKfrFQE4P3PwN3HLOsyG1k
 QOoDxkKH4hO4KmOO0ImtSPy9nsbHsaiQIQynhsMG0wqJXiHHbCCj08EtRjgr2IfFaU/fsGW
 cD4XKGCH4B2T22zzhX0QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h9kMXARLPq0=;gPHMkZqC7ePbZTnFE2nuKE311d0
 R8cyLFPRpZnG8Qdc94PTq8U+/Vc4mA3ADFMDAFY23Ixpx8PzX55AwVFbc3kFeFAJ7/fEoCup2
 22w9tdLsB88I/1BuRTQU2qAwAhY9LsNDh7zf9rwO2Oddg4cRuWCurVK/LxF37H7AHZceyPqF/
 hCrP8kyZiFhns3Nqg1ZFv47Iy9Gm4EFlBmU8rJa0tKSgkU0vavY85MMqN9qcjTRYN/Opmx5Et
 vBV0TmKgJvbEILs6AFeU4bLc2k0qnqlBCs3Zsz16OuzzZUiTA+HHzbyVej7abuG7b5y+7mIYZ
 f+J0eGTYzz7Tc6etgvtjcAsDRUz5qA+IyNKAN/9hBHXKyM2K1SKsyBPzN5qBxxvwd59DZ/JaX
 I5B7FNaJq3l5UiAkoM2Yk4+sbi00OH0w0EVRiFG2CWgpe56aWSFQHZwUNrs9ELbQ8oFxl7yFW
 vCw7d50UNcCDH7O6IOJgc14gR2E04IybACcDnDO9AtDuSx0Hdm0Uqkr1xa8vXMJEaFw6y2nZy
 PQ91dD6k6TChgwV6rejHOwwciCsBYNb8k5BFVf/K3RSr7OyTMUH/n44D4X1Hqpi6s6fgjNYi+
 MEbgvW3Th2Dr/ewUySUoDAXS7ZZFKBzOhKHlXR1wHgRgHV/PiFppyvSyWXiKQWNYHP5Ux6/LG
 1RMxq5wYZCV+3Xhr7T3PDstyCi8rjkW2etXM+pw1V3ofiKZyHI2HcC8qFgZOaFdy8uehtc5ks
 b2jmI/0P5dmDDVmsIbBrWHlXQOCACymTFuPFS3Dz4Qo8xG8V8FwQhvg8UT0BTFahGEErW+zu1
 3Luniw4Aq/+ta/jYbzF8tp9/FOCfcE2i4IRmGWXZ2nRv70wk1z5/7KmWcS0jArap7WcC+CqZb
 DuOib2WATd29mOgwy8G6GoHuIY8RUUbgswD3yeXNvIVGcVTcvEpUES7pOSbrR2E2sVRrS0AYp
 GXVH+Q/OJCGTG//nZEu79oTNmLoTLyZnxcdtCj7MRSwGC4mVg37PstCuOdXXiWxNFWAEdyrE+
 CluTPF9OR0e7N8QVy0g6GnbnBYoCCHIFLP1RkD6qd28td8yvMYcyHHzakowqrSh6t2xTg941t
 pr+G1L04VYHwvVd6ZE7Ej1zxSSNpjYngxcUZZ4ZsyWukp/C7/fC+v3TaoUnfCAHNyFq9b0+Iw
 IRyLTDdeR2+rMCeN9vDRVE1Fj7xZvR4KblrQQhfkWxRonH7lYjWeGUbiYxlDsrk2cyLZcVW5J
 yTgJ3/7qZd6tYeoiWP+GnWLW5Z++rmArh50ek4OdFjroplpIK9DXFBP/Pd1AEX8RBWQc2pgYb
 5BKwmHIgOihGcNnKXRojYsJ0nf2RjWy/DYDlFrQ2IW+xU32vyLdC8PsDvBuRDhWz7yb6fL9cc
 4eOD0AbrrG+YPTRlU9/vR0GWxgQIOVbFbnRwWwtUgB1n1+R8b8FoCA8G7KvjTikvZn/plWyxh
 v+5ClYyqSdShpVj2VTcFRvE7qp3HRcBDT+3Wz+xoIPTcxrcRKKoGs+y/noA1Zd1nqK5zVvkRI
 qJVN8SD+sGvVahVrlZGtfbgjYhbn+mCKpWOw/MnlMrrCGWjeljcLFGM2quru4ukeAj78Xas7c
 BPKsjn0CzMihJcWkbVTz6p/uNlKNbwZPwZy01blL94s4W83XdASvTwv5QnS292UzVyosXsKmq
 c5t4rw1Xsm4G7BD1f7/LywgjMso1YTpmr8NsuXXv+/TE7CYANJGkGouwhTd/wfLzBWIWiflLG
 0HoLoa6171i+Kf5S0JQQhfVe4xVwjY+3TU0qgsvnRBt+jAiE/FiYH4SE=


--tgcjvuwq4ccznzrm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: next-20250915: error[E0425]: cannot find function
 `atomic_read_acquire` in crate `bindings`
MIME-Version: 1.0

On 25/09/17 09:58AM, Thorsten Leemhuis wrote:
> On 17.09.25 09:42, Dan Carpenter wrote:
> > On Tue, Sep 16, 2025 at 06:46:06PM +0200, Christian Heusel wrote:
> >> On 25/09/16 09:56PM, Naresh Kamboju wrote:
> >>> On Tue, 16 Sept 2025 at 11:17, Naresh Kamboju <naresh.kamboju@linaro.=
org> wrote:
> >>>>
> >>>> The following build warnings / errors noticed on the arm arm64 and x=
86_64
> >>>> with rust config build on the Linux next-20250915 tag.
> >>>>
> >>>> First seen on next-20250915
> >>>> Good: next-20250912
> >>>> Bad: next-20250915
> > [...]
> >>>> Build regression: next-20250915: error[E0425]: cannot find function
> >>>> `atomic_read_acquire` in crate `bindings`
> >>>
> >>> Anders bisected this build regressions and found,
> >>>
> >>> # first bad commit:
> >>>  [eb57133305f61b612252382d0c1478bba7f57b67]
> >>>  rust: sync: Add basic atomic operation mapping framework
> >>
> >> Is this still an issue on next-20250916?
>=20
> FWIW, I ran into this on next-20250915 and it afaics was fixed for
> next-20250916.
>=20
> >> As far as I can tell this has
> >> been fixed, but now there is another rust build issue, see
> >> https://lore.kernel.org/regressions/0fee48bb-7411-4414-b4e7-395a8c3d0f=
6c@heusel.eu/
> >> for more information.
> >=20
> > next-20250916 still fails but with a different Rust issue.
>=20
> Ran into that that merge mistake, too, but that can be fixed by the
> patch Christian linked to above  -- and I expect Mark (now CCed) has
> seen it and will resolve this with today's -next.

The issue was indeed resolved with todays next release :)

> > [...]
>=20
> Ciao, Thorsten

Thanks everyone for their input!

Cheers,
Chris

--tgcjvuwq4ccznzrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmjK4h4ACgkQwEfU8yi1
JYXdFg/9ENVS1WHEXyTd2kyCYeNfNwHCBpbmHjNOsFy5vlHSHvGcSZSETLSG0Vr/
R1w9iCGblTzuNAdbad/nDyhUVBTvhV9DADF74b5fIbbS4Kf4vhTAPCGpH9iAHGzL
lIbkUl4EX4CRG6B/AJc/UnFVtgXGmTRZ461W6Nil2rRjYaipKYdwoHpShr0pAuWd
wI7Zcm2//jy58g3wTPCsa1pxHrGTRtwmNKRd6MaqoGk8ZdSWyhPq4xjzA0ozOQd6
LkcdGDmUnpxdnaPUZbZ3DdSq/BsVpaEsE6xspYaXWukOW7gFegIk+mKP9mzZNj19
l9+7vpesss1wlCM3ICdfe2vTz93Fti/SEIvB860FayRtZBjUH+EuuUJ5pNi8IutE
eCYo3GDoppXQsx7JMd5ajDPI3GUQqApFrukMC6/HyF71rSUIoqdgw3NbcsiVHsVy
lyYD7pUELoOQUIP4odOtgX89iG2wSCaW6b+Lc9kKNds7K1WS82E3NPYt6ki8S7lj
BUql1Fdc/52lcdY8HvE45KGFntXNoALpVkKcg/A2GPfzmKR93HnjmofcD/S4ioGC
r7La8EwJcOlQ1F5nuP6B7pMTQ0VZnJlqxc9eNp7zMxNNAT/ANI96k8osz9/D4+SN
mfBMJPEY19+ADpNnuIg0HOP2GHo+9Z7oA4oi/VfLysCvvq4V0ec=
=OqdB
-----END PGP SIGNATURE-----

--tgcjvuwq4ccznzrm--

