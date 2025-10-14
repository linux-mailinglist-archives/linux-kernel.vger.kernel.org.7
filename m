Return-Path: <linux-kernel+bounces-853412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9719CBDB92B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86F8A4F04A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2AD3081CD;
	Tue, 14 Oct 2025 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAQi4/73"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253A2D46D8;
	Tue, 14 Oct 2025 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479693; cv=none; b=QiiMdlIMnOZCIS2g51SgQ0IIGBfRBU03pzNWb8mv0pYUkx9XebCx1tqM6wenk6ZDwI4YdH47g5RhArGyvyik4iTjdbyK059iPqyUaRa+hX0v57A/CgmjCxhVtxsswJIu7umpXeDPXVAGxG++LfMmf9eBsrrxFOSk3FoSqBCf6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479693; c=relaxed/simple;
	bh=f4so7NqnRUr6AWlJ8b9KwzJood07O4nAUzz9RgXezHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er73T10x8rhhX5/u80J3mU4ZTB9ecPBScr0maplR7Mbc8/TSZjDCSC8hLEHCCsRSLzbh6P9ThUiZUxUKo9zxTjxZDoD/ufFmN7WSG9bb1XRNVhaETlf3r8+Jlc/10vupRSDQJvC880MTe6wSCuuqYnT62tlO1g7tqJ+7DDYWC+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAQi4/73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C330C4CEE7;
	Tue, 14 Oct 2025 22:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760479693;
	bh=f4so7NqnRUr6AWlJ8b9KwzJood07O4nAUzz9RgXezHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAQi4/73VpLqoDftoj5wJV9cixrdhbTpov0QHjrFoBFc8QdqUGaoIgovzd5BQ8+Kp
	 bhFszhqJLuGzX1BVVBGFkZw1ZDG9sH3Om8DhXt1xr0gd3Ms+VJoi5K6grtEcWDmnsk
	 H0lXYWz9YxEvUxvhGFg3R5019jlYziV+ebUB4pBuby1mXpi5Cst6ISezZi3Y10REDN
	 PkmBp3+bu1AExXm+gEaJn34LReMki6YItwhg1IM9+U8iF9EGkaqeTUs/EzfTuso1xh
	 v+Dp29trfHGteMnmtbAAO3gn3l7lkRLUw8toBPxhOdwe8YS8aJSgs9yOiB86r3A2Fa
	 cWV8F6XhA2oSw==
Date: Tue, 14 Oct 2025 23:08:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Joan-Na-adi <joan.na.devcode@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding
Message-ID: <1603c2ad-d2d1-457f-8273-e397c541b782@sirena.org.uk>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-4-joan.na@analog.com>
 <512ffe3d-5ab3-4e87-afd2-46f0005a8d17@kernel.org>
 <08b4c0a0-cc59-4640-94ff-2d243c558a67@sirena.org.uk>
 <1d1808d5-f166-488d-97b0-78fdd7d8ed0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FTWivOCAVqJuz5DR"
Content-Disposition: inline
In-Reply-To: <1d1808d5-f166-488d-97b0-78fdd7d8ed0e@kernel.org>
X-Cookie: Madness takes its toll.


--FTWivOCAVqJuz5DR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 14, 2025 at 11:54:41PM +0200, Krzysztof Kozlowski wrote:
> On 14/10/2025 15:11, Mark Brown wrote:
> > On Tue, Oct 14, 2025 at 10:14:15AM +0200, Krzysztof Kozlowski wrote:
> >> On 14/10/2025 07:31, Joan-Na-adi wrote:

> >>> +  maxim,en-mode:
> >>> +    description: |
> >>> +      Enable mode configuration.
> >>> +      "push-button"  - Push button
> >>> +      "slide-switch" - Slide switch
> >>> +      "logic" - Logic mode

> >> You just repeat the name in the description. Say something useful.

> > Do you have concrete suggestions there?  I can see dropping the
> > descriptions entirely but otherwise I'm not sure there's much to
> > usefully add.

> Then just drop descriptions. I could imagine datasheet has something
> more, but if not, then really no point to copy paste.

I suspect someone said descriptions were needed...  TBH I think just
the enumerated names are clear enough.

> >>> +  maxim,dvs-slew-rate-mv-per-us:

> >> Except you said mv/us, not us. Confusing.

> > That's what I'd expect for a slew rate?  It's the speed with which the
> > device ramps between voltages during voltage transitions, mV/us is a
> > perfectly normal unit for that.

> Yeah, but the property unit suffix "-us" says that unit is us, so not
> mv/us. I think we did not have that case so far, unless I missed such,
> so either we ignore description mismatch from property-units or we
> change it to something, like "-mvperus".
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

Right, and the above does say "mv-per-us" which is how I'd have expected
those units to be formatted rather than "mvperus".

--FTWivOCAVqJuz5DR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjuyccACgkQJNaLcl1U
h9DzAQf+J8wr4nH5jE8loa1E9aZWNCree6ocxQorbFa0fF1wr5dcfStv3cNHZUdK
Cj04aZy0x5TGZHuhN7YokFub/5eVynNjXOlvHCMbXLyhjgBxK8cfzfLedYDqC4H8
qrQccY+8xgYNCIEypgjnsHdGbsLrWpb+pqLF3G0FD0QDw+OVJiZXBOXtcHLdgRXf
GCHNOWNBr1Acgq90HCLHTkM1blj/e/CMFgiCNnZxWSuu5g5kFNyffDGkoXQqoZft
pljalKMliRJNMTqp9uoI7XIX86Y0xI/VWMtrBGdHy19hKuCMdtE8aVm826/eoZ7N
o+6NQSEHfKfK9bdqYCOngWLtnpAO7A==
=Rx33
-----END PGP SIGNATURE-----

--FTWivOCAVqJuz5DR--

