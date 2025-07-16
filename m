Return-Path: <linux-kernel+bounces-733797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79BB07915
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE1D3B07B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555926658A;
	Wed, 16 Jul 2025 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEEaNQ2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD473263F4A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678378; cv=none; b=b1hyMd+HU93YIMBE88B4ITAxrb2WcKtdVz8xQtPDDe+jClQw5tv0iLi6Non6glXMWT2ey9inYI2Nn87EuPHNKbx8+BETKX625yNthiHM4TL33+Y5eWshOJbxZgt9zRVCm1QIG3fswjTCqi7a/+fS19KAoGbsy1SjCWG6UMB9Fzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678378; c=relaxed/simple;
	bh=WKuwpKVt9zZ8ckB0vN8JO0JzK0NC6moeuIOO+N1EA6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgvtvDflS/6h3FfIWQYieonQkQudt6yb14GGlymxJJRNjgfxK2+nmKI22bKXzVWj42oUKPfRVOkWzfs9ZJfweKFyymxPwQh00EBqNx54VCCzoAuH2SfFU5ZYIIS+7LWj+uP9oCQporeWveRcTCVpEICu7AN6Bd1uE9IZ2OWQ2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEEaNQ2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EBDC4CEF0;
	Wed, 16 Jul 2025 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678378;
	bh=WKuwpKVt9zZ8ckB0vN8JO0JzK0NC6moeuIOO+N1EA6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEEaNQ2Lnv9psWcfzpuCU4ZdFuvDDrKfSznX2c4YLP88gmiefl3G5DvqYG7qoTO/g
	 mZS8dcFpeJxjDmeuDQqkksGWYYsYLN567tGiz8D/dGAI2k6+aLu6Y+lkJYe+qaeWsF
	 nANZthvWtUtzw0iAdXgu1PXjxxiPiB/NuszRRJG5R15qfYQQ1HEAKiT2r3RpbPO9SC
	 CILntfpJ7sk/ALCXo9KFr8GciZczhJcszPtrtXS9gsiuj5QYphvjDSHJoJWB54275d
	 226RG26RjP2snleAB/gMqd39MSXeIJ7upvyVVKsdl2blDUa/QDj9q8O9yOto5da0+z
	 N4T5nN7ro/fuA==
Date: Wed, 16 Jul 2025 17:06:15 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/tests: edid: Update CTA-861 HDMI Vendor Specific
 Data Block
Message-ID: <20250716-realistic-cream-ammonite-304cca@houat>
References: <20250625-drm-update-edid-v1-0-2d963743ab9e@kernel.org>
 <20250625-drm-update-edid-v1-2-2d963743ab9e@kernel.org>
 <046193df-bb11-4d84-98a4-c6d46d359316@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="alj2dibegux2zdfp"
Content-Disposition: inline
In-Reply-To: <046193df-bb11-4d84-98a4-c6d46d359316@suse.de>


--alj2dibegux2zdfp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] drm/tests: edid: Update CTA-861 HDMI Vendor Specific
 Data Block
MIME-Version: 1.0

Hi Thomas,

On Mon, Jul 14, 2025 at 01:02:33PM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 25.06.25 um 17:14 schrieb Maxime Ripard:
> > For some reason, the HDMI VSDBs in our kunit EDIDs had a length longer
> > than expected.
> >=20
> > While this was harmless, we should get rid of it to make it somewhat
> > predictable.
>=20
> Dump question: should these errors be kept in another test specifically f=
or
> detecting this problem?

I'm not entirely sure what you mean here, sorry. Did you mean that we
should get some tests to prevent that kind of EDIDs from being accepted
by the kernel?

If so, I guess it would mean getting a test suite for the EDID parser
itself, which is definitely something that should happen at some point
but seems a little out of scope to me.

Maxime

--alj2dibegux2zdfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaHe/5gAKCRAnX84Zoj2+
dsewAYD1axpR1DkXlPCwINCEdtcqV1K1gc0Ck3unBBJukPewwJ3aJFdIse3nSCGc
N0S9ApgBgN1b6+5aCRPHfzDWSkeB2bDfR6afkUsugIHUpFNGeh5BKu96GBJ/E+vh
ezDP9N6nig==
=+J+F
-----END PGP SIGNATURE-----

--alj2dibegux2zdfp--

