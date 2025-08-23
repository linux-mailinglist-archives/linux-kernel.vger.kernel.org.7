Return-Path: <linux-kernel+bounces-782923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEFB32708
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 08:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4FB1B67B25
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE11E1DE7;
	Sat, 23 Aug 2025 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PDtoy5a8"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ADB19D884
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755929274; cv=none; b=NBKn5gYxUREnaa1BUrEP92K/xogTFXFsb5kVMv+9+QdVXIv8XAQRWv8xIRd8c1fmTq4AQvnY4tsu1e3uy9PeGXcPp7VTAlok7NCm/wBJyEcE6Uz34R7wg1BNLGpuDFqYNfhzCO4BRyt2XCHiF/7IUW/3/ntpz2YRWMivegzZI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755929274; c=relaxed/simple;
	bh=oNJ87XpWFHIErlufcq35l3r/kYo7XFGoerXU2FV6zjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPTKedM4JM1iCkoG+gvNBPWBP+snR7QeQJ66y3+QeNq8yxm14uXwYtSUKsl7bj6Tu+eUmzmpdCGUjjnqZdiJIen+fV1ybigWu+ygDq/gTC1MJhd942oCVGsTR1zHuwUpNh6zgpd1vxHTBiJxzZF4odfVyn7lW6+udnRRaByk7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PDtoy5a8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KjKO
	XvkqZ+hmJ2d2hhFT/SItvFU/o/YR5P8SuLDbeag=; b=PDtoy5a8uMILkbY0y4IT
	i+gCM2Kwce8JPlXWEqf8pHoDhq1JAwQcfV/TXuESflmE2R2MeUJF0NQgzdjGRUmy
	MGIgJMuaYEhDdgfnz3NrhvMEcVtURmXrM61P7acDQ6AZkAvzgHbzBLoc2TNpjPP+
	u+QgDFWW/FngAErt0kQmsRTBBrTRl5ELR5V5f9XNEATiz2DPkE2Eb6riruhnU+oI
	/co2dFjaw3CbLYDGeXbFiowX3Aasfwyk++tIbpbxoe9Fz7AWxyOVAUeISAyoxi05
	ClocO8U9kCGyCjLAbMJdi3Jd7SqED1qLB6rHYd+iLyKTQrhnrdrHdUPLOs3fwpub
	ZQ==
Received: (qmail 4114734 invoked from network); 23 Aug 2025 08:07:40 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Aug 2025 08:07:40 +0200
X-UD-Smtp-Session: l3s3148p1@zwTKIwI9QOhtKLO5
Date: Sat, 23 Aug 2025 08:07:39 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v6.17-rc3
Message-ID: <aKlaq8OfYSl-Bflb@shikoro>
References: <hw4vxalm4vifwdgt5stle53eierogvrslxsyckwbfd3inkjzu6@74qfsxp47vtl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mamJIoJ35SZxGrSB"
Content-Disposition: inline
In-Reply-To: <hw4vxalm4vifwdgt5stle53eierogvrslxsyckwbfd3inkjzu6@74qfsxp47vtl>


--mamJIoJ35SZxGrSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andi,

> Here is the pull request for this week. A big part comes from
> the rtl9300 controller, which has gone through several rounds
> and finally made it in. One last patch completes the work from

> Sven, but that already went into i2c/i2c-host.

That patch doesn't have a dependency on this pull request as it looks to
me, right?

> With summer ending, I hope the rhythm will soon return to the
> normal pace.

I could live with the summer pace all year long ;)

Hope you had a great time, too,

   Wolfram

> The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0=
b9:
>=20
>   Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags=
/i2c-host-fixes-6.17-rc3
>=20
> for you to fetch changes up to 82b350dd8185ce790e61555c436f90b6501af23c:
>=20
>   i2c: rtl9300: Add missing count byte for SMBus Block Ops (2025-08-19 20=
:21:03 -0100)

Thanks, pulled!


--mamJIoJ35SZxGrSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmipWqcACgkQFA3kzBSg
Kba/5Q/+NyJ16W85cZLo/+co6ZSYhPiQvjjcyO+CEIHvYN71ODdgWJtsRze/ZmCV
uDPxqWwn6+ZsrC8Elvvsihv651hUQLsizkmv2IaEpVyTpxa+ubmvh8pyjmGbZ1pm
AQVCEwiVi0qTVw7EpL1Rs04Z3l5V/VfBC4dInMOaRfSbtYYmBwR92R0wvTW7BZv1
x0nr3ToKatOT4VnqE35Zw3ng2sKzh9bG1e6zYvLQZxTb83MpwUm3Ws04d82AjmqU
okKZd7trcU9pna+y790937fgntcYU2M2lFjL5wmT/c41M0AaSYbv6cpvUgngTXp2
GUYh3EbtKvx2Woy4kkN6Ig63JDCXSZGxcIC1ikGjBievwe2vR21KMcg58UIIsS0W
6Y16J1BOV8GHGi04axVvJhgj7a4m05VFmfBMJPjmveek5zR6Lx2qmZmIRhTCOD3Q
Q8P8t5ekITdHtYBMp3Dm4oL1bfVr3rFg37DL+1Pv03henpjnr3hnXSiAQPcCVueq
VuR9PtuyobBtr4uxpEfPkUn8n/wLQ7+PsVClWY0vRzBN+82fcpTmS9rT5WxhxvXF
I6LSpke8CYeg20jr32O7AMUBEmMv0QW/3a6yjYuwCW8AmzsOa4jH/ZX7cDeQJYqA
HGMnpmMJhpAgqGM/z5QA7vhZ8VgkRawnjBfTdQWEs+gGqwpM9dQ=
=UG4J
-----END PGP SIGNATURE-----

--mamJIoJ35SZxGrSB--

