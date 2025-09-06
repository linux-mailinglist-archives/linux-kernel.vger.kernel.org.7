Return-Path: <linux-kernel+bounces-804113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA00B46A1E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1215A76C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89D2C21F7;
	Sat,  6 Sep 2025 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YFehdbp/"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A5279DC9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757146829; cv=none; b=HCg06EjSp8vzO1/s6ESKX1cqwFXJyyxdc3quVGE9t2WdGHbjhWNlTE9wOpS6JjB+8NXgEdp/LcmbIYLQjhLGdAgg2y9F6BvwT8wfspTirG5eWt6TlRdTieS0vTg/28FEXhptSQ409j2gcpkNZ9/01a0QucWdp8Dzs+JKAbiZXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757146829; c=relaxed/simple;
	bh=G9IVH57h32BJAEAE8Lr6RwZVyPBE2zPVU84jCkiQOPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf0eo08wrmOAHB9qRozBVds+wmwh+5/WsK5QP9dq210ov0754aTacy1W0E+sarTi2oeN/EIczj23TpGfUUodBcSW/ZimqsJLLBQM9853XWffz1vtOv/fAwkJuzi1q8BBmpkmSFjKNXI+VOE84QsPsblotD0xwSnBKxSn7g5Cg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YFehdbp/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=6gFK
	6y3NZ8AVy3nrwn6m27UvowW1B4LV1gpidyd94qY=; b=YFehdbp//mrfKSqV0Xp3
	nvU03PkQIF+p/YXXXr5yQtgUGvmm6D5wvoQYt8N4+DMZbcS3Drj3QcNt91caibMF
	kBF/efBWBax1sCJKH2IYx2czvv4KRbGd6bnKXWGpvhuJjHbVF6hVYkSXBUtCQIC8
	VFZl/CLZi/4aV7qGOLH65rrUcuBoz+3VWGCmUkJ0gREcfzRk4OHE/bHAgBseb2t2
	yTXlB8aLRid0S7/vtDWbblFDV0N1rxZBogoabhkymEPEwurKyjKPBbZfs687KPwW
	m2YnJGGKCY3X1YMDp6ICbYp+a1ZAZx1Oftjv+kttUFD+eyATWfBu/6FoQXt311XV
	YA==
Received: (qmail 122139 invoked from network); 6 Sep 2025 10:20:24 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Sep 2025 10:20:24 +0200
X-UD-Smtp-Session: l3s3148p1@TelMoB0+5sYgAwDPXxPDAOCjMSL5jkIv
Date: Sat, 6 Sep 2025 10:20:16 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v6.17-rc5
Message-ID: <aLvuwAy6ofUUycGr@shikoro>
References: <wrui7mvzr6r6qmzh3y24zehmv3yx3geth3b7llsn6sqdlt26gv@5tpp7hr2266p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgMXdDcvQOzJdnGm"
Content-Disposition: inline
In-Reply-To: <wrui7mvzr6r6qmzh3y24zehmv3yx3geth3b7llsn6sqdlt26gv@5tpp7hr2266p>


--dgMXdDcvQOzJdnGm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 06, 2025 at 03:18:24AM +0200, Andi Shyti wrote:
> Hi Wolfram,
>=20
> Here is this week's pull request: four patches affecting two
> drivers, i801 and rtl9300. The rtl9300 patches are a
> prerequisite for others that will be merged into i2c-host.
>=20
> Have a good weekend,
> Andi
>=20
> The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58afc=
f0:
>=20
>   Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git tags=
/i2c-host-fixes-6.17-rc5
>=20
> for you to fetch changes up to ede965fd555ac2536cf651893a998dbfd8e57b86:
>=20
>   i2c: rtl9300: remove broken SMBus Quick operation support (2025-09-04 0=
0:31:34 +0200)

Thanks, pulled!


--dgMXdDcvQOzJdnGm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmi77sAACgkQFA3kzBSg
KbamRw//b6GGisble5A0rqukB5MQiVeTdmeOH+APsTZ8Uhlzg+GEqRza9TKItg2o
DTGnhjPXp94viTgO4rA7kYey+Bc20b7iHfgs6yEPQZ10IWAW5H0SYK5ikKQE5fZZ
WyTCKhrl3mUfCzA8QlHKQFfqD9TKeYWYVrcxLQGxOwCEQucnk3imXcITL7849no6
lP0EGyZ/QbIvu4KIJlkhVvS8gUDbncHmtWh7MDPwUfhXEFCrN2FdeUIIwJvs71jg
cGmZgOOABjZ1nErmf6N6CPqFEcpKcNa1xK3EipFWTbsrozBBHx7tRneuVkZx955r
a/+H4ZodkAL1yYw7vcSBTuPfC1T8v43KZLa/OTOoBWualW2sErarBv3ruldwTqB+
Owna7cGUXndtdJSJSpdT9kJ4MV8eK+5UsIQu4ARmyHz9PhOF4qVERgMdRghEWyGh
L9Njbo0h/vOebT2+/jSASG4HQDrBCrIAIh3B0aLatnKFHWcW4dghqfO4j8D1EkjY
DxCvWF51KYNnRE6IC98StzAIGMkVIWXOi8Kj1//hkRL31Iu3uavgWxyVMwvtoVmn
VoxEY2CEwP/RRTxrF/3+aYYyEwTx8Cck8FSP7RidzPnozgKOkurvX0WNVQa5TEw8
Xz2MA6UnIOF+Q0JeDn3MIEDIsHJsLOVUHSKE+Meza8/QfAVCklg=
=2qk3
-----END PGP SIGNATURE-----

--dgMXdDcvQOzJdnGm--

