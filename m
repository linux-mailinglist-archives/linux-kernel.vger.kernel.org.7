Return-Path: <linux-kernel+bounces-829765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63571B97C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926811AE1892
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19D930F81F;
	Tue, 23 Sep 2025 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4cRAaZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FF30C357;
	Tue, 23 Sep 2025 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758668831; cv=none; b=Hx/Wqqpzzmo6HXaLSi3oZF4Xxtz14BYdakoIH7F8w13CcuNQiIEuqqNEQXxjyfbU6KV1hJabhl4wzhPR4mtbfHjlDLIQFglf9B/mdXSfmvmcayPVjAiDW80ChI156CWdZRotNYCmKOaFku3L81hd0A+tX9iPD4RwRnImtTlEyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758668831; c=relaxed/simple;
	bh=qNP/U155QZV5wJYSzAPav4Jflz7dVsRRNHSVxpI+GFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haCbeMmvtJNsQjS2GfO3YGgERDQEjIkUm53jN5XsLMs+bGxjXzWod7Xiz44GNYAy3eT7Gb2pRcMI9PM6p8fqw5JAh1UFmyb1szB9wXrUZzCpr0lOBkshMnYvo8V/q5YYTMkygm4GUQlWYE/psIXAkipNjnbV9LLbW/FNqNzOZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4cRAaZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793BFC4CEF5;
	Tue, 23 Sep 2025 23:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758668830;
	bh=qNP/U155QZV5wJYSzAPav4Jflz7dVsRRNHSVxpI+GFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4cRAaZ6RiCacsOCfT6lBuYxjzKS/1YG+3nFqS+RIcSXAAeUiMvsS20L2LpyeFUUK
	 jo9IHylTJRrLgQMDMq/F7+ZbikwPgt7Cm/r9Yfa9qw3YiqliiRGO51f4LcKtbtfRs3
	 AdTUCj60VwuNgn3b9PGX2DWn7KK0vvvYstMtPZNGjtLTz2hJv7T/VeIQxUFGh0Zs7l
	 UCYtyeGpzhobWAy8bHU2bQmPqwY1HR0R4ENFBlg1I4KCM3vW2E/pP6NW1zcPT0Z8xg
	 mXKDH/USKVqYAIOGQEQ7B4uJvTCJRfYYp3JvrC5HM1hH595i5pBfGDuK/e6ZltAYlO
	 044fO3cMGHChA==
Date: Tue, 23 Sep 2025 16:07:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	WANG Rui <wangrui@loongson.cn>
Subject: Re: [PATCH] LoongArch: Fix build error for LTO with LLVM-18
Message-ID: <20250923230705.GA2598658@ax162>
References: <20250923130122.2321771-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923130122.2321771-1-chenhuacai@loongson.cn>

On Tue, Sep 23, 2025 at 09:01:22PM +0800, Huacai Chen wrote:
> Commit b15212824a01 ("LoongArch: Make LTO case independent in Makefile")
> moves "KBUILD_LDFLAGS += -mllvm --loongarch-annotate-tablejump" out of
> CONFIG_CC_HAS_ANNOTATE_TABLEJUMP, which breaks the build for LLVM-18, as
> '--loongarch-annotate-tablejump' is unimplemented there:
> 
> ld.lld: error: -mllvm: ld.lld: Unknown command line argument '--loongarch-annotate-tablejump'.
> 
> Call ld-option to detect '--loongarch-annotate-tablejump' before use, so
> as to fix the build error.
> 
> Fixes: b15212824a01 ("LoongArch: Make LTO case independent in Makefile")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: WANG Rui <wangrui@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build

> ---
>  arch/loongarch/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index ae419e32f22e..fcfa793f9bb0 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -115,7 +115,7 @@ ifdef CONFIG_LTO_CLANG
>  # The annotate-tablejump option can not be passed to LLVM backend when LTO is enabled.
>  # Ensure it is aware of linker with LTO, '--loongarch-annotate-tablejump' also needs to
>  # be passed via '-mllvm' to ld.lld.
> -KBUILD_LDFLAGS			+= -mllvm --loongarch-annotate-tablejump
> +KBUILD_LDFLAGS			+= $(call ld-option,-mllvm --loongarch-annotate-tablejump)
>  endif
>  endif
>  
> -- 
> 2.47.3
> 

