Return-Path: <linux-kernel+bounces-798157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70168B41A20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABE05E39DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE636284662;
	Wed,  3 Sep 2025 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7MuWP7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0932F756;
	Wed,  3 Sep 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892051; cv=none; b=T9TBX+wpLIGpKbCo95drwqJ0S4WnxlCR1P+97R5/ye5MfY7XibQo8Wmuy/LIPDTIQZJzjgdbx8ZLDVUAPSsNO27MEx/ps2rEcl2q5EUQwAWaz3ekab45it1/SbEOj2pXvmrrBYlFpGJfmDHeW5dyoOegnsx6dplvlSZvhMJeuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892051; c=relaxed/simple;
	bh=GDihKXdB/iW8hISyuFOd1z33+bUc8UJIXAuijhCIyio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIs1hsm/rQcWZxre+c/8QOEzI+gpXxtUd86DwVow6mLtotqL9GR1Zw2qgcw3ot4TNUfMHJ4kO9pgC9BVc23IVk8utGJjEtVEayGff9tR4c8Cnk9d7voG1ZW5ZdgpgZD9tP9YYCUdwJyKlayNsEV3hbXvLJyFibdDoxXpfhmWFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7MuWP7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E960BC4CEF1;
	Wed,  3 Sep 2025 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756892050;
	bh=GDihKXdB/iW8hISyuFOd1z33+bUc8UJIXAuijhCIyio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7MuWP7u08Xi8FGKLknJoFc35sa6Hw6umSlFyFT8spkNHstKj03ewdA/WU9qyk/6t
	 Fhk9VH3hLinTL4/cNGUSmXOSy4aJoHpcaJBHwubN87P72Oc4YauFScKAhys+Nlmnd3
	 rRu4OCxiTWxJfZ4MiGU3GpC9nu/ZtzZQZF0XVLmWEateM1eipzl2o9BpwLHDPN3J+1
	 BWhh7FnLiLEi0M7K8uiRMZYD/odozRcFKFqmoaJFftvJYoT80Gdb818am6MHAO2RDs
	 oEKocbEeNXGugY1NGHwfk9U7vJDbFW3CY1ZohJmQNKoQWPSGhmtmRC4Tu10k1z2p/k
	 mvZTR9+OSWFtA==
Date: Wed, 3 Sep 2025 10:34:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Woodrow Douglass <wdouglass@carnegierobotics.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator
Message-ID: <bd06ea10-dea6-49a8-810e-2b8c089933fd@sirena.org.uk>
References: <20250902-pf530x-v2-0-f105eb073cb1@carnegierobotics.com>
 <20250902-pf530x-v2-2-f105eb073cb1@carnegierobotics.com>
 <a527e022-75ad-492e-a3e3-579cacd7d324@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dAHVAgyC6PShPgv/"
Content-Disposition: inline
In-Reply-To: <a527e022-75ad-492e-a3e3-579cacd7d324@kernel.org>
X-Cookie: You were s'posed to laugh!


--dAHVAgyC6PShPgv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2025 at 08:16:21AM +0200, Krzysztof Kozlowski wrote:
> On 02/09/2025 23:17, Woodrow Douglass wrote:

> > Bindings for the pf530x series of voltage regulators

> Nothing improved and you sent it AFTER you received my feedback.

He said in the cover letter that he was resending copying in the lists
as per your request and would follow up with another verision with the
changes we both requested.  Obviously it'd have been better to just send
that version or at least tag this as a resend but I do understand the
confusion.

--dAHVAgyC6PShPgv/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi4C40ACgkQJNaLcl1U
h9AGhQf9GR3MCPKXhyfSZkZeiFP8NapYC8CZHvJlC4SeL7yuHX98RNRgooyzsfoN
9XuOe6Blool+SnUvrDe47KiisqpJRceiyzR04J6Mkkk+mJx2GApe0BfB4EJFx2uY
n8Bn5RCCN22kPcaBs1QelDWfTJ+85YEzC7/+uIdh5LSKW2RdaJ7YMhhB8JtLqKU0
vNkbUbfC4eC+pwkuOi4FkA89U54xC291m83oBYJdO1dI5Nlzguwraql3AJOE7BB0
QuR+5CebxG4V1bJ41KdW/6vt4tuEoO5rrNqI2jh8Rvd76hsbyEotztr41UvBkBiP
3BoBbl+eoLSHHbjMimDaFvdPPxW59g==
=kNVU
-----END PGP SIGNATURE-----

--dAHVAgyC6PShPgv/--

