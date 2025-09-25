Return-Path: <linux-kernel+bounces-832642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA5B9FFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA874A0B15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7730B2C0F8C;
	Thu, 25 Sep 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9mpiWIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C229DB96
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810285; cv=none; b=ow/mjd4sd4QA3wFQQb9QUHzzoouBe7jqCM6vSO4JJevUjfMFojLMaZrJLmNnNpK0CQ6QZkJAvYdOll/1kajYHMKSA33+PM+4b2zF/8zclZw7Gsjyzg+FLFZmDUb5Dv9I1b+fXlD+LamL+aDkTRaY2BXjVAILhsXcck7VryrUxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810285; c=relaxed/simple;
	bh=gY6i16D1ibbZV3L3IKVILpoC6LX7WGDhAWvmLCwLZmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkWonGZ9MWbJLjWEJDnj70J5zw1/g7t9ioDSZ3Q10hBNnED4qQw3ux6+QOaRjpRw/aeVenA3F3t01ls0GcPmm0Bolb9AmNlygE4Stu4aekoJKp5vqWhqYs/MzrEpkyiekh0m3kAjQyovPPj73Ca6LtxUOQxfJy4GVzQ7tv/Tw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9mpiWIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6DCC4CEF5;
	Thu, 25 Sep 2025 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758810285;
	bh=gY6i16D1ibbZV3L3IKVILpoC6LX7WGDhAWvmLCwLZmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9mpiWIgEshJsaGwH2A+XZvR4lJzxMpqaGLJPwPxDkWkPP19wOBhRMlQv6gmsCPFU
	 TxTuss44favw9VzgKJHbdUpz+XZ1YBMDzYz9a7tZqsDvNgLMl+NUHKw4xkkmbEJOzN
	 JMip9Z54xGngkyKMKWCIf53VVBjSV70Cye/H2iChsspXEV/oLh3ecimiumpLpKDrGY
	 Nrchqlhaa19O30VSyu2VuttBSnoLFOOLInGyUlEnIPPYBJcMUoHFvKAd8BXtytRSvb
	 nEvyLe9jtyxd55xIbnQr6wH19VkXvf5p3QrRyv9KHSsclGzw5bJgQiSwbYEq59mn7K
	 y7hAdYf6BaOXg==
Date: Thu, 25 Sep 2025 15:24:40 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	'Thomas =?iso-8859-1?Q?Wei=DFschuh'?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kernel-dev@igalia.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tools/nolibc: Add stdbool.h to nolibc includes
Message-ID: <64c56cf3-90ad-428a-9a14-64928771f9fc@sirena.org.uk>
References: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk>
 <20250925141423.504427-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pEgg2Nr7nw/tglVH"
Content-Disposition: inline
In-Reply-To: <20250925141423.504427-1-andrealmeid@igalia.com>
X-Cookie: Shipping not included.


--pEgg2Nr7nw/tglVH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:14:23AM -0300, Andr=E9 Almeida wrote:
> Add stdbool.h to the list of nolibc.h includes, otherwise tests compiled
> with -nostdlib will fail with "error: unknown type name 'bool'", even if
> a nolibc stdbool implementation is available at tools/include/nolibc/.
>=20
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/lkml/833f5ae5-190e-47ec-9ad9-127ad166c80c=
@sirena.org.uk/
> Signed-off-by: Andr=E9 Almeida <andrealmeid@igalia.com>

Fixes: f2662ec26b26 ("selftests: kselftest: Create ksft_print_dbg_msg()")

> ---
>  tools/include/nolibc/nolibc.h | 1 +
>  1 file changed, 1 insertion(+)

> --- a/tools/include/nolibc/nolibc.h
> +++ b/tools/include/nolibc/nolibc.h
> @@ -116,6 +116,7 @@
>  #include "sched.h"
>  #include "signal.h"
>  #include "unistd.h"
> +#include "stdbool.h"
>  #include "stdio.h"
>  #include "stdlib.h"
>  #include "string.h"

It's not 100% clear to me that we should add this to the nolibc
includes given that nolibc itself does not rely on or offer stdbool -
I was going to send something out adjusting kselftest.h to unguard the
include there.

--pEgg2Nr7nw/tglVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVUKgACgkQJNaLcl1U
h9AjEQf8C1/AGK40TRugU6PUa8f7BnNJF0mQlJ6b7juCtu7gzZ7c1yteI1+W3Ycl
CXWFhCOv/UxRbYC6g025yotRxZeLGSRG1Rbs5Z9c/7UqitDF01bh7RH8oIyKVFnz
++MYraFp15wWxjo7Z+B5xYA12ucMmqFpHOPhr0gvfGXKW+yzfnmJRm0r1nYGCgJp
OboUdQFhHjOAUTWbz7fbsfra24REbEpruMvGFCmHMo5F6AZlvVnHBx9Fhrvp7m6d
XEnQybI8ROHzAooGvwrNBs9y4nA0dxTc14S5PCdzoCSIPBAzgEUrC6oyixhS6bo8
noVhD/shHzpayT2J7yi/D21NDZ49og==
=RiWJ
-----END PGP SIGNATURE-----

--pEgg2Nr7nw/tglVH--

