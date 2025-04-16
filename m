Return-Path: <linux-kernel+bounces-607768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F667A90A84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 19:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D771F1906FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA438217F36;
	Wed, 16 Apr 2025 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/FeiuTG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3DD1CAA97;
	Wed, 16 Apr 2025 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825998; cv=none; b=k3u7T3DVsxQODkEb5ePz3l8Pz+Y4VrAazAtm/gve3EXf5r9dZdKabH19jsBhaf/U7wc3bhigKAkJSm8Y8oSHcxL2RLrxNLr4wAmIRh+eh5J8aFeM+uuE2zyIqf3qu5jT/wEu0/COziiqr4jqWY9R1aAl50xCzD7T/3NXYrNbuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825998; c=relaxed/simple;
	bh=3aocZmmM0xo3L08WVrGRy3d56/7XtLUVo6wAG0g3wMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMRDsjcAh7o+PJlZ1Se4pc2B9oG3g5/evlI5908rVfSHqA3NFRTXpFJolGa1fGO31TBK7keIQgBdfCw3nNMcaLs7YEGCXuF+99S5xbpvNXX33bH5BaCVImoxRyDi3M2RXFxKEMTNdZiM6OeuhrxxR76S+snEuC8YEqO9ipgBrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/FeiuTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCC8C4CEE2;
	Wed, 16 Apr 2025 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744825997;
	bh=3aocZmmM0xo3L08WVrGRy3d56/7XtLUVo6wAG0g3wMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/FeiuTGRmVvwARCZJEmpCG9jFIdkBii/99uRO3q0AqOQbS0fV/4UCenwGG/a0DKb
	 kWcJs7tNoOzz3yBcweEoRVTaoQ3o11qpGAWZkb5Rn8UbMw3e47RvXF+SP+6eUhQksT
	 U+RxfpBPw4zhOjhoc6cktRuQyyYQybabV7NpAMLcvyZ066ZOBYo/c1uQqc6v00O8SW
	 OtgjJ6Lgyru57xjwrSHelyu6M2mYxAxELK4xz9sNe1hIcGp5dWfvl+v2QyLvLfDi3l
	 9eo772AE2hSBSyNjOpOPFmiZhUMLbcj5KgDbZKZaf+sh01QpjtdbHJBcghIGU7TzQS
	 ZMZ6/ikwoJrIQ==
Date: Wed, 16 Apr 2025 10:53:14 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Gow <davidgow@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: Re: [PATCH] kunit/usercopy: Disable u64 test on 32-bit SPARC
Message-ID: <202504161052.4011756D7@keescook>
References: <20250416-kunit-sparc-usercopy-v1-1-a772054db3af@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416-kunit-sparc-usercopy-v1-1-a772054db3af@linutronix.de>

On Wed, Apr 16, 2025 at 02:44:19PM +0200, Thomas Weiﬂschuh wrote:
> usercopy of 64 bit values does not work on 32-bit SPARC:
> 
>     # usercopy_test_valid: EXPECTATION FAILED at lib/tests/usercopy_kunit.c:209
>     Expected val_u64 == 0x5a5b5c5d6a6b6c6d, but
>         val_u64 == 1515936861 (0x5a5b5c5d)
>         0x5a5b5c5d6a6b6c6d == 6510899242581322861 (0x5a5b5c5d6a6b6c6d)
> 
> Disable the test.
> 
> Fixes: 4c5d7bc63775 ("usercopy: Add tests for all get_user() sizes")
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> To be honest I think sparc32 wants to support usercopy of 64 bit values.
> But it does seem to be broken.
> 
> (+Cc SPARC maintainers)

I wonder if these archs need to explicitly fail to build if they trigger
a 64-bit wide put_user/get_user call? It seems weird to me that it
should be possible at all to provide access to the function if we know
it's going to 100% fail.

-Kees

> ---
>  lib/tests/usercopy_kunit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/tests/usercopy_kunit.c b/lib/tests/usercopy_kunit.c
> index 77fa00a13df775074a19772bfbc9120ef33634bb..80f8abe10968c1d91c61006f1eaa63858c633872 100644
> --- a/lib/tests/usercopy_kunit.c
> +++ b/lib/tests/usercopy_kunit.c
> @@ -27,6 +27,7 @@
>  			    !defined(CONFIG_MICROBLAZE) &&	\
>  			    !defined(CONFIG_NIOS2) &&		\
>  			    !defined(CONFIG_PPC32) &&		\
> +			    !defined(CONFIG_SPARC32) &&		\
>  			    !defined(CONFIG_SUPERH))
>  # define TEST_U64
>  #endif
> 
> ---
> base-commit: 1a1d569a75f3ab2923cb62daf356d102e4df2b86
> change-id: 20250416-kunit-sparc-usercopy-c36de3ca4ef8
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 

-- 
Kees Cook

