Return-Path: <linux-kernel+bounces-858450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8844BEAEDF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F639472B7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4A296BC2;
	Fri, 17 Oct 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPSE2VfI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13392299950;
	Fri, 17 Oct 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718531; cv=none; b=Kos5PacNqWnqoOt7+Luwe3uT5RKYGgm9MXWjNxuB62aR4RJ3NEetHyZYbN8hmQugy1iOVOEzEsu/0QrIReUX6rkmUc4JqWi/pgmgkQqS0mn0USwEeIDg7okkVSHnT54tr8IaUdJ71ACNBzJukLex6803mYqACkn10dhO+RPcyAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718531; c=relaxed/simple;
	bh=Una6ZwWE3tWlRlTrxOgpKjKjFn4SWggaefOFaE2LkIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGmaU9Q6/7pTXM9Om0w6TypRhhyuXSb14osaXUpl39LrG7WZS85uBltJgcaLs5Ok1hTNSeNTY02lv1XUPznSy1MwXGM2e0bbaaoA4pC1Hgnw4Fr9pU/+UBmQxzdF7LkTjKzTQO9O3PKFr7jRtSgLraCtv3na5DukyVDAAI/eMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPSE2VfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21174C4CEE7;
	Fri, 17 Oct 2025 16:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760718530;
	bh=Una6ZwWE3tWlRlTrxOgpKjKjFn4SWggaefOFaE2LkIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPSE2VfIerOM/Uiu3H7RQmBdk4NecpNTc5oyBHdsxzQcHPScUq3qLvVnimuCoIWvN
	 jwepGfCzzj0iwk3E7R+79A9GL8P1pT+07w92mZe1atRfviiKKBJ1TOKUfv4H3HZLB9
	 89WuHrm3G4qcSQdBBV2DP6kEDhXPPz3TC28qC/ysEQS9NCgaCdQmq+kZymxxOWxXRE
	 Big+c6310OvKEvFQYavnu/iB2BXApjo7H1sXV/j7vHdx3m1cNKBojqwax+Mw7VGb8R
	 gzLlNRbfur6DwiCmZHqwG0+aWpBhpSEK9srmc3D3BYeYU4rP+n/lorSLfuWlyvi5qG
	 oeD7PZlkZNXKw==
Date: Fri, 17 Oct 2025 17:28:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 04/11] ASoC: cs530x: Remove unused struct members and
 constants
Message-ID: <4663ea33-d468-4088-a20b-f0910a4a8c4e@sirena.org.uk>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
 <20251017161543.214235-5-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9LoEsAyJsV+yPBG/"
Content-Disposition: inline
In-Reply-To: <20251017161543.214235-5-vitalyr@opensource.cirrus.com>
X-Cookie: Androphobia:


--9LoEsAyJsV+yPBG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 05:15:31PM +0100, Vitaly Rodionov wrote:

>  /* Register Fields */
> =20
> -/* REVID */
> -#define CS530X_MTLREVID			GENMASK(3, 0)
> -#define CS530X_AREVID			GENMASK(7, 4)
> -

It seems a bit unhelpful to remove register definitions merely because
they are removed, so long as they're correct they might come in handly
for something in the future.  I'm not sure if the datasheet for these
parts is public...

--9LoEsAyJsV+yPBG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjybrwACgkQJNaLcl1U
h9DB0Qf+Ipy6d5unq9Go1Am6/MXTFAQKjbiqT/Qa/ldOrOlBcbVF+FWe4g7LRqL6
o5RE17K0+szsubDch53wxEPdXDxoBl84meOrnrmDn+caILU6cVlezSvHC2Ix8t7E
uXyZx9gEGmDz4WidqDDHULwfR+/5VWZe03EDdRLpePcCGmYjt/wcuRUMaa/+Jex+
sqNXREfMR31hl1RJ7e4CVz+YjsTy+jlbufRJLdfqv8gl2G99PXmHLNowHAf32A7F
3E6D9SbzcsB5839mMQUA6rTxJAqMNFs6ElTwJJsQyMcmvGAvZ1a4NjIKbxk79l+O
+hq+KCfJIrMaGyktXIns6PSVfvyooQ==
=WrE8
-----END PGP SIGNATURE-----

--9LoEsAyJsV+yPBG/--

