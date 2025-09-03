Return-Path: <linux-kernel+bounces-798041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A85B418B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EACF3B5715
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CB2EBDDC;
	Wed,  3 Sep 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pbarker.dev header.i=@pbarker.dev header.b="dkh0b5Iu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BbRGkPk6"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C82EACFB;
	Wed,  3 Sep 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888671; cv=none; b=XWF+3Sa3kNxKcC9bPeIUXU3GNq5RQMgNhrKu3dMSHugS/VLcNzM6CbpFk8g+1DDuDz/y18BwYHWsDM1SBhdrGrqxH+x88M+YdPI+du1ktntVNWT/cLIXtqqdXZQrMA2weDY27GzhStoGUTTpLOq5agcgXAxFXuZD/cajAHtO3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888671; c=relaxed/simple;
	bh=HRJL63K+pt60xVYH2OwXL9cway+602AapnU1/G+3GW4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkkZmrt9NQdxT6c+aJ9fULRLOd3FRb/jd5cN14S220uI/5ww5wd71XRnIlvJLD/V902H8kNpkQoXTJEB882PtZJyAndkHbOquKbqaEyOpagcE/55yjE7Ki+cCWM0Q0Ev3CcqHOc+8MBKNqW/ksfTkYdMA0M/ah3Fky37BisdYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pbarker.dev; spf=pass smtp.mailfrom=pbarker.dev; dkim=pass (2048-bit key) header.d=pbarker.dev header.i=@pbarker.dev header.b=dkh0b5Iu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BbRGkPk6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pbarker.dev
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52D7D7A02A3;
	Wed,  3 Sep 2025 04:37:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 04:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756888667; x=1756975067; bh=US1cagWNYL
	+QRlqKfTeyuWIXRO8VusLp8zQHX2qwJkE=; b=dkh0b5Iuu7zD3ncB3AIHzgByoC
	xIIClIUl7j7gTS8f+438mL9SPXFL96ZxiDlKdRsrlmTNFMZrlIPOJ5jLtnQ6eG1l
	poKhp8NG9lf7U8kJ67IAnmk4VIoYqsZhD6dzYu+ytdpkxNBAmlwDokbppSo4tL98
	DycL8yJG+g6vy3sWLVkjlYh3I2SP09BC3wPzVA5BjOP1BWadQh7Mc6Yotv1ZUiOg
	zM/kKExPsHQPIPZPHCoSGlC+FHSXEan5c4WYFpZLlHAIk+2pCmpn/Bj1lOG9SnGP
	qurRvCbq4JR7gB1fc4/WEm+Edstz/15/9lLszcCQMZyJqYy3VsSnA+/nOxOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756888667; x=1756975067; bh=US1cagWNYL+QRlqKfTeyuWIXRO8VusLp8zQ
	HX2qwJkE=; b=BbRGkPk6xBwNelfFTn6sCy9ES1eVCq3Iup2vFO6TelDqOf2t0CR
	TRNCCChnZiYHOd0CQkseec/2H0sqjL1oG3OnI95CHDuqf+fJ5yJWLWC5ETDVUFwG
	5DEtxUnysDESR/Z007JYJQb4vaIjCWbI3/m6G4Ap/tq9ms8uvrtVY371oHojW/s8
	UBN+zOzIPfC7hoAyYdDDkvrnJ8DWykfW8H0hhycHtyZEmp+zlcyLc68cY3SiKXV3
	CChSu1zH2cKDsKXDxspX+X8fYfBFKW5P+/ZICNQhE5nYCOW2mw8SgmLAnPm0NIVq
	WQonGeAEF3+V115/u8thNy7vMaluZf3KLbQ==
X-ME-Sender: <xms:Wv63aAB9RPiEpsd0LZeNmjfUsPtrNqRJCiSLftFnmA0W7BYSXHW71g>
    <xme:Wv63aAeBsM_Lyz3blsGXuP6aWxaoZWf-VkPzX45MIjH3Yntz-7iVkgsWzOA1VxJq_
    5xHEQWegUqYX7o4MeY>
X-ME-Received: <xmr:Wv63aF57-P0Et6eGud5HfQZZFbXW3zdxJ1XkUxjUnbtkynYEtq8Sq6PDmV2nW5tdmdGv8ESwiDTxfFXvvTYw1DRn0JXwIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkffuhffvveffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceurghr
    khgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnhepve
    ejkeekvddugfeileegvefggefghefgjeetffduheduudfhleeigfejfedviefhnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhdphihusghitghordgtohhmpdhprhhothgvtghtih
    hnghdqtghouggvqdhinhhtvghgrhhithihrdhmugenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhonhhs
    thgrnhhtihhnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptg
    horhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepfihorhhkfhhlohifshesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Wv63aLVVDumImbMBoKXTqM4clhURfQD80cZOVU3jLI1lOgkg4kbncw>
    <xmx:Wv63aM6L5Pigk3cDUluhK3hELmYf7a5dJHkadgKJMDEn9esHjai1Lw>
    <xmx:Wv63aOppSDuQeyTsmoDsEq6E3bOncz0VNaaPwjbzioqVmvgbxR6_tQ>
    <xmx:Wv63aHlz5Wuy5Y9PIn9aq-DtAkx5By22vM6akMWa0qmaDpCceMNj6Q>
    <xmx:W_63aOBIH7kAIT60mjV94UQDJF9sr0Dvm7la7swZwCnTZSYtKr-JQFAG>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 04:37:46 -0400 (EDT)
Message-ID: <9fbb364c46d4affdadec7702c4c0e8987f7dae03.camel@pbarker.dev>
Subject: Re: [PATCH] Documentation: update maintainer-pgp-guide for latest
 best practices
From: Paul Barker <paul@pbarker.dev>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Jonathan Corbet
	 <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 09:37:28 +0100
In-Reply-To: <20250902-pgp-guide-updates-v1-1-62ac7312d3f9@linuxfoundation.org>
References: 
	<20250902-pgp-guide-updates-v1-1-62ac7312d3f9@linuxfoundation.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EB9gnekdljQv8zsDx1AE"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-EB9gnekdljQv8zsDx1AE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-09-02 at 11:44 -0400, Konstantin Ryabitsev wrote:
> Freshen up the maintainer PGP guide:
>=20
> - Bump minimum GnuPG version requirement from 2.2 to 2.4, since 2.2 is
>   no longer maintained
> - All major hardware tokens now support Curve25519, so remove outdated
>   ECC support callouts
> - Update hardware device recommendations (Nitrokey Pro 2 -> Nitrokey 3)
> - Broaden backup media terminology (USB thumb drive -> external media)
> - Update wording to follow vale's linter recommendations
> - Various minor wording improvements for clarity
>=20
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

In the last couple of months I moved my private keys onto a new Yubikey dev=
ice,
mostly following the kernel maintainer PGP guide. I read through the guide,=
 and
some other sources [1] [2] [3], in detail before I started. So I think I'm =
well
placed to review these changes. They LGTM!

Reviewed-by: Paul Barker <paul@pbarker.dev>

[1]: https://github.com/drduh/YubiKey-Guide
[2]: https://support.yubico.com/hc/en-us/articles/360013790259-Using-Your-Y=
ubiKey-with-OpenPGP
[3]: https://github.com/lfit/itpol/blob/master/protecting-code-integrity.md

--=20
Paul Barker

--=-EB9gnekdljQv8zsDx1AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaLf+SBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0boc6AQDkoJFNqcEdpNfARXGZRqp0DVgZKTnh7oMZ
TFjEtpcSwgEA1la9yaRFnzOVaf52f4flhFWTORyZaMDvCs5yfzdAHwQ=
=takW
-----END PGP SIGNATURE-----

--=-EB9gnekdljQv8zsDx1AE--

