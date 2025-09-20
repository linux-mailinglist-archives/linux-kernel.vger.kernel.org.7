Return-Path: <linux-kernel+bounces-825524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA3B8C081
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D6F58663B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 06:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA41823CEF9;
	Sat, 20 Sep 2025 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyBcnN11"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812D2F872;
	Sat, 20 Sep 2025 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758348942; cv=none; b=rQ6/wx7iGejXNSjG46O+xba2HR0xAr7NYzymFoZqrzDnakKuv5UGqNZPlYumS6QvByID6GqIn2DTeHYYkQOg5Vgc42ov63hDQF4l0qsJ/2xH0V23XTR0FL14lq44p+yp641bLI0vMQgDmJsErEIdg8OZRWn79P1cdN/uTIsmyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758348942; c=relaxed/simple;
	bh=ztsE8IAVQOOAW1FSbXZvhh4tzVJWmEepEQOu4J5iAbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkbeFqIZFPcQ24rBORaSGeW4h8oHljmJrL3f/fjonURFnuEOQGiLiX8iuFewAw+y4GJGFmjPH+Rf8pQJKBcacEGuXdcRKfLCxGKwq0DXcka4Z1beEHd/xvMwAy4YWHHhz4/KmaMYnQextyEvDuI/XvyMJXCUT8xNB7AtDcDyR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyBcnN11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB01C4CEEB;
	Sat, 20 Sep 2025 06:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758348941;
	bh=ztsE8IAVQOOAW1FSbXZvhh4tzVJWmEepEQOu4J5iAbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyBcnN114pbec9dW9rWOF2xu2MiqweDbYS1MkVGnjmDUmY6XfGweniU3o1s7MDNh7
	 5o2cUgdl0lugdCw8SXtiVEuGdk9/O+I4zj4jYG36aWX+nqAkBYX2mFmhV0lqvcoG9X
	 lXgKc6tLwmMkLE/ItmEHTff/bef+dPDcih2Uk/W3nn3S10OrBZQsnDpfoHRe0q+ZdI
	 RIWzcb5rS0RBaIkQuAoct2TTRAKQrvzg3Y9TFDCP/OwGyHUL9r/Fi/ELTo9JmBDc/5
	 UCOkds7ukw0aEA+crddDNAvPhuthcGCPntzEucC29UIieXzY3X/T8ufNEcGvN0tmTT
	 RjW50vvCv5iUw==
Date: Fri, 19 Sep 2025 23:15:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 1/2] LoongArch: Make LTO case independent in Makefile
Message-ID: <20250920061536.GA1460394@ax162>
References: <20250909092707.3127-1-yangtiezhu@loongson.cn>
 <20250909092707.3127-2-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909092707.3127-2-yangtiezhu@loongson.cn>

Hi Tiezhu,

On Tue, Sep 09, 2025 at 05:27:06PM +0800, Tiezhu Yang wrote:
> LTO is not only used for Clang, it maybe used for Rust, make LTO case out
> of CONFIG_CC_HAS_ANNOTATE_TABLEJUMP in Makefile.
> 
> This is preparation for later patch, no function changes.
> 
> Suggested-by: WANG Rui <wangrui@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index a3a9759414f4..9d80af7f75c8 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -102,16 +102,16 @@ KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)
>  
>  ifdef CONFIG_OBJTOOL
>  ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
> +KBUILD_CFLAGS			+= -mannotate-tablejump
> +else
> +KBUILD_CFLAGS			+= -fno-jump-tables # keep compatibility with older compilers
> +endif
> +ifdef CONFIG_LTO_CLANG
>  # The annotate-tablejump option can not be passed to LLVM backend when LTO is enabled.
>  # Ensure it is aware of linker with LTO, '--loongarch-annotate-tablejump' also needs to
>  # be passed via '-mllvm' to ld.lld.
> -KBUILD_CFLAGS			+= -mannotate-tablejump
> -ifdef CONFIG_LTO_CLANG
>  KBUILD_LDFLAGS			+= -mllvm --loongarch-annotate-tablejump
>  endif
> -else
> -KBUILD_CFLAGS			+= -fno-jump-tables # keep compatibility with older compilers
> -endif
>  endif
>  
>  KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat -Ccode-model=small
> -- 
> 2.42.0
> 

This change is now in -next as commit b15212824a01 ("LoongArch: Make LTO
case independent in Makefile"), where it breaks the build for clang-18,
as '--loongarch-annotate-tablejump' is unimplemented there but there is
no version check before using it.

  $ make -skj"$(nproc)" ARCH=loongarch LLVM=1 mrproper defconfig

  $ scripts/config -d LTO_NONE -e LTO_CLANG_THIN

  $ make -skj"$(nproc)" ARCH=loongarch LLVM=1 olddefconfig vmlinuz.efi
  ld.lld: error: -mllvm: ld.lld: Unknown command line argument '--loongarch-annotate-tablejump'.
  ...

  $ scripts/config -s CC_HAS_ANNOTATE_TABLEJUMP
  undef

Cheers,
Nathan

