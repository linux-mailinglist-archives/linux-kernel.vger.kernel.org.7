Return-Path: <linux-kernel+bounces-759376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA6B1DCC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DE962371D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D5F21766A;
	Thu,  7 Aug 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2Xrg0ZY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415720FAB2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589453; cv=none; b=nKMwwrnOmVf9x8Xx4tavz3w1MzT+aUY9gJQixHGKTmTEWTYaLYWWq3WNDkNBCq4HcZacxtBGVIO0orn7sAfWZWued4qfx9s2W+hWxX7wwrbIt4hLAkRWKkrJ755ODWMCCvqGgxePdz/oH8GUz7K2+lGn6RB1LXVkmFEk6urVBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589453; c=relaxed/simple;
	bh=o9PhsAMPAYPHNYv4SZ0O7Yfqd4gCIz+z/qFLouKRaXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+Ubw+qX0pDCm5xI7ncLoNDxWK9d5eRPU4uGlqpvtLoHGFWpj+RydQZ/J4iLlCyEWV+d6ZZX6ifspw5tjUg+zGGsKRuBU/OGlFoTLXUKhbV2JSTzDGjnDJxRhy3c71sHXw+6K2Tze85QgUYQLPZGIYKC9/E0ctWSDbeYxQkoKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2Xrg0ZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A213EC4CEED;
	Thu,  7 Aug 2025 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754589453;
	bh=o9PhsAMPAYPHNYv4SZ0O7Yfqd4gCIz+z/qFLouKRaXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2Xrg0ZYors9ujEEzRxpg+3F9ofv0IaKxd8P8oi/Nxv/Fpz7w7Tc+/PNRp5tOFZER
	 9nr5lH5USRaThEClrS/0F9LTXe5ikGAlDkju3BXvrxJkQrLDqcCbMhnN21rozjHuVO
	 +cAH8HHEQKYvVpDkB+ep/c53bFvQh4NXAVo/+y8dIfsGXZh9azzZkRKFdf6b0nEYH9
	 CKhuxv5r7wfxcG7oo6mpvRFdiqJWJG0eJUiHZgLvmOBent1WmrTog2wHfK09SGNV05
	 RIISSNypjXHMEpZ429tzQTho+y9DLi8qmHQR4vjQoeTXPaQlIs7pQJiP6LTGkWd091
	 Y5VyjjBMUbxeg==
Date: Thu, 7 Aug 2025 18:57:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	oliver.upton@linux.dev, james.morse@arm.com, cohuck@redhat.com,
	anshuman.khandual@arm.com, palmerdabbelt@meta.com,
	lpieralisi@kernel.org, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, james.clark@linaro.org,
	yeoreum.yun@arm.com, joey.gouly@arm.com, huangxiaojia2@huawei.com,
	yebin10@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Expose CPUECTLR{,2}_EL1 via sysfs
Message-ID: <92feb0bc-18b9-438a-9567-a9059a8cb9dd@sirena.org.uk>
References: <864iuja70l.wl-maz@kernel.org>
 <mhng-9D9CB730-A22F-43E2-A012-D51EF3C1E027@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8ETIWXizD9Z0LeAy"
Content-Disposition: inline
In-Reply-To: <mhng-9D9CB730-A22F-43E2-A012-D51EF3C1E027@palmerdabbelt-mac>
X-Cookie: Real Users hate Real Programmers.


--8ETIWXizD9Z0LeAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 07, 2025 at 10:26:29AM -0700, Palmer Dabbelt wrote:
> On Thu, 07 Aug 2025 01:08:26 PDT (-0700), Marc Zyngier wrote:

> > For a start, these encodings fall into the IMPDEF range. They won't
> > exist on non-ARM implementations.

> OK, and that's because it says "Provides additional IMPLEMENTATION DEFINED
> configuration and control options for the processor." at the start of the
> manual page?  Sorry, I'm kind of new to trying to read the Arm specs -- I
> thought just the meaning of the values was changing, but I probably just
> didn't read enough specs.

Yes, pretty much and also because this is in a range of registers
reserved for use by the specific implementation.  See DDI0487 (the ARM)
version L.a sections D23.3.2 and D24.2.162 which specify the
IMPLEMENTATION DEFINED system register range, and the definition of the
term IMPLEMENTATION DEFINED in the glossary of DDI0487.  If you see a
small upper case term like that in a spec related to the architecture
then it'll have a specific architectural defintion.

> That said, part of the reason I just sent this as-is is because I was sort
> of expecting the answer to be "no" here.  No big deal if that's the case, we
> can figure out some other way to solve the problem.  Happy to throw some
> time in to making some more generic flavor of this, though...

It's something that does come up, working out a way to make use of the
tuning in the IMPDEF registers in a way that generic software can safely
and sensibly make use of is rather non-trivial though.

--8ETIWXizD9Z0LeAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiU6QYACgkQJNaLcl1U
h9C/Lgf/WSCWGaP2ngWUbX4z0kzWbXmxYJDiNxHJfVVtC1t2Z6+8tn6vbrTvBMkS
ohjVwDVAsLcNj2k09Q/ltjT0592+txX9IOXp1tsfA6ft9unMBDt+QkVpZXroiipq
D36bfhRLT2QDN/Ixjf+Nzy7KELjFozGvOKGmiYM2fCbS5FLhYfW9R+d1mhcCG/DP
L2oZ9SYWP8T4JCmKxE+uytj4cMa3r9HPGBbUZUhPKu6jVBHLQ6n3lO3viYByXG7h
aTOpS3fDV+hiK3MTVZWE2j5PdTWPWy2ynMlRJ+5i3DD01uZYupeuRQ6q6J3cdXli
sILq5TE5+oqVCTqKfoUVTQm6r5gwyQ==
=1SBy
-----END PGP SIGNATURE-----

--8ETIWXizD9Z0LeAy--

