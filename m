Return-Path: <linux-kernel+bounces-884849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 725BAC314F3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEFD189855C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407AE322755;
	Tue,  4 Nov 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOsFIG7L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0D1922FB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264335; cv=none; b=oD5/Px+dnxTpBq+CqZkfLQ4WjbigZpxhhLkE78nm7IWMVT06O8w7ThMSqds+H7WtYC1eQpFn7bMwr6QKCmISRz8gO1FBQZ0P9crnp+/CdtwZP0FFD7sAgvIdEEwaXUbsmQSrsl3wKaXdGawwOswgKFVHclG9jvxT37eyUA4unXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264335; c=relaxed/simple;
	bh=mvMjXhl3MNKPgc5Kqll4DxQ9dTiVZSH7HfzvE28ozI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzBpWGH4tkbtj87S7nEZKpuv/lLq6J7r38uawlujDHZqLmJFGQgVyFo9SDrIU5MVebb+PjbImpEQ5crVAhqZLNirsFmYFfwFIebc6shT8yE/ShXakXOwCbPsbg4McISbxuJvtp7wWNr++ssfGdvfc0hs1n5DaiS0rMo4rVV1t8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOsFIG7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57FEC4CEF7;
	Tue,  4 Nov 2025 13:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762264335;
	bh=mvMjXhl3MNKPgc5Kqll4DxQ9dTiVZSH7HfzvE28ozI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOsFIG7LVU0esaWa+vyGn7o7fSR5cYgCPYdRq3ryjy7xarL8b1OFcpFBBq7goSw1T
	 SrD0qvclMEZl1Rkf3I088Y4ApUiERQDfMej3/X0rV9BQL1fAnbJj0MwFmoO75VXJUe
	 q1URqUwLAngEa7gm7BsFidPAKSI/YAlmlP/N37OaF8XuflWFpBhP/u+IvXRmF7CR4k
	 ko0QMnZD/3tGVIlRaB86V1bpGhIhA8O1I/mPzE4cLx/wyBVFpucjibONeu1RnW6/nq
	 SargB4ZW6aSn6ZRWynrzAOWRKpUhCk8HRc9g+hSTrSL38w0apfrrh3yhpgRRSlKjhk
	 euu2YqjTfo0Hg==
Date: Tue, 4 Nov 2025 13:52:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Andreas Kemnade <akemnade@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] regulator: core: fix constraints handling if current
 state out of range
Message-ID: <aQoFC3YDNlw4imML@finisterre.sirena.org.uk>
References: <20251103-regu-fix-v1-1-c8a46581c850@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H2LHxGUrPEiBrxQb"
Content-Disposition: inline
In-Reply-To: <20251103-regu-fix-v1-1-c8a46581c850@kernel.org>
X-Cookie: If in doubt, mumble.


--H2LHxGUrPEiBrxQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2025 at 08:32:41PM +0100, Andreas Kemnade wrote:

> -		if (current_uV < rdev->constraints->min_uV) {
> +		if ((current_uV < rdev->constraints->min_uV) ||
> +		    (current_uV > rdev->constraints->max_uV)) {
>  			target_min = rdev->constraints->min_uV;
> -			target_max = rdev->constraints->min_uV;
> -		}
> -
> -		if (current_uV > rdev->constraints->max_uV) {
> -			target_min = rdev->constraints->max_uV;
>  			target_max = rdev->constraints->max_uV;
>  		}

There's a valid issue here if we can't represent the exact constraint
(the hope was that people wouldn't specify constraints that their
hardware wasn't capable of representing but we can't exactly stop
them...) however this change is risky in the case where the voltage is
too high since if we specify a range from minimum to maximum we'll try
to select a voltage as close as possible to the minimum.  That could
result in a large change if the range is wide, and potentially go under
the voltage the hardware needs for it's current configuration.  We were
trying to set the highest voltage in the range to minimise the risk
there.  This isn't a concern in the case where we're raising the
voltage.

--H2LHxGUrPEiBrxQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkKBQsACgkQJNaLcl1U
h9CbbAf9FRZnxoNVgvCCVyEdUk/O7uflh5d/26SSY9RbW6XWKEmgGCATfLk77KwW
YSsHItwiwBtyaYgHommZ54JXp2nprvlDBL7uO56JRMZygiyAetwWGFhofGZBYz5W
fYlhS0YqWX7PgdvIaesjT2kyqjrdE0PtZaNftbqYn2ko1RAC2T7jXXVmBQkcj1Qc
EVxxAzKwROseU1/7pp3bN/hZIrCBkTK0N+NYkTQ/mebT2dkWXHgEAHFryk5+cuMU
6EOstSDvbkFM8zrKFTizi5if3m6sPESnP8UKNJxEOsrNXOYTmlDKge5d5lTzUXuV
gXvJhoVav/cNykxv7upciM362+Z9uQ==
=5+J/
-----END PGP SIGNATURE-----

--H2LHxGUrPEiBrxQb--

