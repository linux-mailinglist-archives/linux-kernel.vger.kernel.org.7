Return-Path: <linux-kernel+bounces-819624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E6EB5A3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978561888DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D6C283FD6;
	Tue, 16 Sep 2025 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKyomrt1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368331BC9F;
	Tue, 16 Sep 2025 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057377; cv=none; b=WV6E2l5r99DyAJtcCGWVob54BVy/IoW6jPrFVtThn9WHV0g1UGeb0TOYYhhk9quBRJHHwv+PFZhpeEmWUzJbWjorSoehBN7YcgW9CTvpQlcVkkegBpH50pzayt4RiiyPGKZuSFjaqYqm2k7uximXDgMFe6J5GluN1FXaqve6x8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057377; c=relaxed/simple;
	bh=kBpRtBbR+gU+md5yBa0FD4QWFI0+TqFLBQcEyMNvqzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoDIOVny1uXt2FqPkjSxyqhUkEFNq997NzwDgDE9bCsQHbmTwuumSi2sfUsNXlgaBv1+G3VBcarV3RIDSOeWFOYg941sFxbgiiQrEymnedeKx5hUMJ4zpTHqJXmk802FXxBTL3BJrkYZBjPvjZn33WWfrfd9lU6XB0Veew27LQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKyomrt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C74C4CEEB;
	Tue, 16 Sep 2025 21:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758057377;
	bh=kBpRtBbR+gU+md5yBa0FD4QWFI0+TqFLBQcEyMNvqzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKyomrt1JRvKIxDsoHZ5RjY7ESCGT5FkYIOKfsYA4OxM5cGB5broh7qIsKFDXA3eo
	 AE5NDwCZNf90YmdbD0W9Y6iSAl8rTD/TKsstIg+6Dss8rUOUfWLLx0lpZ7gh+FxlK/
	 7V9+1b4Fq8c36CoWdHwmGFC58wLFyxuG3KfZ6bBXr2xKrtU8UaAC00+VEAJ6OtPHx1
	 g2pF7d0aJ3aTxk7YIVenmL+hz6Ue9Tz+jSUkKPVnJN/kfDBTjEP4Xx2MHKU8jGljmn
	 mxrSZIId+RAtBN753bs3jROu32b16taWBY7WzbXgLC4Qr+UGr4QQ86ljNlWVB7FSF4
	 A9w+xY1gPqgXg==
Date: Tue, 16 Sep 2025 22:16:11 +0100
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] kselftest/arm64: Add lsfe to the hwcaps test
Message-ID: <aMnTm59nrA5lBxN5@willie-the-truck>
References: <20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org>
 <20250818-arm64-lsfe-v3-3-af6f4d66eb39@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-arm64-lsfe-v3-3-af6f4d66eb39@kernel.org>

On Mon, Aug 18, 2025 at 08:21:20PM +0100, Mark Brown wrote:
> This feature has no traps associated with it so the SIGILL is not reliable.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
> index 002ec38a8bbb..941890f69df6 100644
> --- a/tools/testing/selftests/arm64/abi/hwcap.c
> +++ b/tools/testing/selftests/arm64/abi/hwcap.c
> @@ -17,6 +17,8 @@
>  #include <asm/sigcontext.h>
>  #include <asm/unistd.h>
>  
> +#include <linux/auxvec.h>
> +
>  #include "../../kselftest.h"
>  
>  #define TESTS_PER_HWCAP 3
> @@ -169,6 +171,18 @@ static void lse128_sigill(void)
>  		     : "cc", "memory");
>  }
>  
> +static void lsfe_sigill(void)
> +{
> +	float __attribute__ ((aligned (16))) mem = 0;
> +	register float *memp asm ("x0") = &mem;
> +
> +	/* LDFADD H0, H0, [X0] */
> +	asm volatile(".inst 0x7c200000"
> +		     : "+r" (memp)

Doesn't this corrupt H0 without the compiler knowing? It's probably
easier to use STFADD.

> +		     :
> +		     : "cc", "memory");

Why do you need the "cc" clobber?

Will

