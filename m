Return-Path: <linux-kernel+bounces-867735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A73DEC03650
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29B624EE550
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B917A2FA;
	Thu, 23 Oct 2025 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7akVhzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4196218AD4;
	Thu, 23 Oct 2025 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761251503; cv=none; b=F4hpP6rMzid9L+ENbGSgmoXl/qOQeL9dybqfDDC7KxPTZvwwABP9vWMxW5byybkAmJMXHjECibSq2+3RAJssEJwc5zFWQoY3RuOtPeXsdcyscki6ZEwF5QVNFhD/2L/p0a8PEWecfNlbUiTi1yfBdT7oUi2AoxM4hC8L6+spwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761251503; c=relaxed/simple;
	bh=obi+9q/lEBxOXwCnktkr7trvGNzVMJhHXXAGuAHJGbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abIr9lyUDqypydKbkqTvEDghhS2CruunaYuUXo6uW+b1kiloaJ8w7kPswNEyLhw1td18s6kH9/lHRH4lqUYLS5tfPAq1kAQKGi3ngcwdTnXNsrTx8sXi45EzI0WZqphzVuD38krn/NYjkkgY993cadMy/RZGsy3nqGNteUPNqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7akVhzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11136C4CEFB;
	Thu, 23 Oct 2025 20:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761251503;
	bh=obi+9q/lEBxOXwCnktkr7trvGNzVMJhHXXAGuAHJGbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7akVhzNCzMKgcGktAsxWTNgCUFOrGrcwCPTPoDb2Rf4RGM8hdNQAQMuPYD40A5bc
	 gBtu/kQ0VzV0l8/DbfavWDrcyL4c3WRl/Fu5wcmNqFlCQjsB7hu2jo4oZuymd4QFmy
	 8TdpPN2ewoB9iwAmAr2tbXyPfaQRBu7iVRx38PYO4itM8BHC5AXAFSPsqF1iaLSE38
	 Td/vqnQzLX3NlcYcvzkyzAijdRLr6A0MsVNvs9zGl/13+Dwk6NvvHEmfPwLIJTrw0Z
	 lgI3aOChOmnNXvvu/mjsXlc9ZcajTF+lY6pmX4Q764PwdCOKsaN12Wwvf0uWMe0H09
	 91dMVYO+bdysw==
Date: Thu, 23 Oct 2025 21:50:34 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Kees Cook <kees@kernel.org>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] KMSAN: Restore dynamic check for
 '-fsanitize=kernel-memory'
Message-ID: <aPqHCrC0JPwQynWd@levanger>
References: <20251023-fix-kmsan-check-s390-clang-v1-1-4e6df477a4cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-fix-kmsan-check-s390-clang-v1-1-4e6df477a4cc@kernel.org>

On Thu, Oct 23, 2025 at 09:01:29PM +0200, Nathan Chancellor wrote:
> Commit 5ff8c11775c7 ("KMSAN: Remove tautological checks") changed
> CONFIG_HAVE_KMSAN_COMPILER from a dynamic check for
> '-fsanitize=kernel-memory' to just being true for CONFIG_CC_IS_CLANG.
> This missed the fact that not all architectures supported
> '-fsanitize=kernel-memory' at the same time. For example, SystemZ / s390
> gained support for KMSAN in clang-18 [1], so builds with clang-15
> through clang-17 can select KMSAN but they error with:
> 
>   clang-16: error: unsupported option '-fsanitize=kernel-memory' for target 's390x-unknown-linux-gnu'
> 
> Restore the cc-option check for '-fsanitize=kernel-memory' to make sure
> the compiler target properly supports '-fsanitize=kernel-memory'. The
> check for '-msan-disable-checks=1' does not need to be restored because
> all supported clang versions for building the kernel support it.
> 
> Fixes: 5ff8c11775c7 ("KMSAN: Remove tautological checks")
> Link: https://github.com/llvm/llvm-project/commit/a3e56a8792ffaf3a3d3538736e1042b8db45ab89 [1]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202510220236.AVuXXCYy-lkp@intel.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> I plan to take this via kbuild-fixes for 6.18-rc3 or -rc4.
> ---
>  lib/Kconfig.kmsan | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> index 7251b6b59e69..cae1ddcc18e1 100644
> --- a/lib/Kconfig.kmsan
> +++ b/lib/Kconfig.kmsan
> @@ -3,7 +3,7 @@ config HAVE_ARCH_KMSAN
>  	bool
>  
>  config HAVE_KMSAN_COMPILER
> -	def_bool CC_IS_CLANG
> +	def_bool $(cc-option,-fsanitize=kernel-memory)
>  
>  config KMSAN
>  	bool "KMSAN: detector of uninitialized values use"
> 
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251023-fix-kmsan-check-s390-clang-190d37bbcff3
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

Thanks!

Acked-by: Nicolas Schier <nsc@kernel.org>


-- 
Nicolas

