Return-Path: <linux-kernel+bounces-843518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78587BBFA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4131E189A235
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963119E7E2;
	Mon,  6 Oct 2025 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J72OmIiy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F913B5AE
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759788307; cv=none; b=AJAwJo5P1NI9qosjIOYi8bN6s2i53ZXRckRojkqACQM+HUODrYnT4Wxu810amno1WTPl4xV/htDq+bvEHlNgkdVOEPI1trM5zDnZXAyeUddXewAu3KwStSp+4GqMYLZrZXwtRnQ7RT+LuwappgSr+1OZ8fPvj6Oe0Ae6R0Hw5VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759788307; c=relaxed/simple;
	bh=q3kplwV8NXd3uPtOrwoRgmx8fOKbtWwzi1AVH/2yisI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obcH6av3CJdlpEMAFZYC1zOxQQO5xYyT0abTGN1WD8/zRpUy8hy19b/O1MCmFH1xKU3Jv0TdjAodECDJk6by/lkEYADE9ST4RQzZwigaRtL5JANoJUsXqEjRN4mIChhozsJDXl10Pqf6EARDUhOYbsYsgL86fYHM5SFu+1toYrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J72OmIiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02087C4CEF5;
	Mon,  6 Oct 2025 22:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759788304;
	bh=q3kplwV8NXd3uPtOrwoRgmx8fOKbtWwzi1AVH/2yisI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J72OmIiykYOp8aL+SVx3MVwpM1bgaNnSi+z8gaDrIyizd7z0FWJ5htYvIgPHAB+iQ
	 kRyJA8Nb7q21i/vYDc9Arxw1YXT9iOPvnKCdE1/QeqCztmlGIPrX5mGnBhCmtNSevh
	 WLmtEssHFb1CUd1ANm51rNnR6/+yWJY+pMHas7ToSbi3o2ORZ9+tZQ3ciDbbABY/f3
	 0IeedpKogA/Vh1TXvQpTjhDwsXClrSIzS/CO4ILqNiDsQOI5JXxOwpw+ti60DpDVrp
	 Pl/+cOYWe575/E2IHgnXfZacGhZRLc5gCZ4yufNbNukKcC2rowh3JMGtsRRpwtlu8w
	 VklB1raQ3J9nw==
Date: Mon, 6 Oct 2025 15:05:00 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools headers: kcfi: rename missed CONFIG_CFI_CLANG
Message-ID: <20251006220500.GC3234160@ax162>
References: <20251006184412.552339-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006184412.552339-1-cmllamas@google.com>

On Mon, Oct 06, 2025 at 06:43:57PM +0000, Carlos Llamas wrote:
> Commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI")
> missed one instance of CONFIG_CFI_CLANG. Rename it to match the original

Technically, this was correct when 23ef9d439769 committed:

  $ git show 23ef9d439769:tools/include/linux/cfi_types.h | grep CONFIG_CFI
  #ifdef CONFIG_CFI
  #else /* CONFIG_CFI */
  #endif /* CONFIG_CFI */

This is a cross tree collision, as

  aa34642f6fc3 ("tools headers: Sync linux/cfi_types.h with the kernel source")

was merged in 6.17-rc4 via the perf tools tree but Kees's tree was based
on -rc2, so he did not have it. It only becomes a problem on the merge.

> kernel header. This addresses the following build warning:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/linux/cfi_types.h include/linux/cfi_types.h
> 
> Cc: Kees Cook <kees@kernel.org>
> Fixes: 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI")

With all that said, I think this fixes tag should really be:

Fixes: a5ba183bdeee ("Merge tag 'hardening-v6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux")

> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Regardless, I think the fix is obviously correct.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/include/linux/cfi_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/include/linux/cfi_types.h b/tools/include/linux/cfi_types.h
> index fb8d90bff92e..a86af9bc8bdc 100644
> --- a/tools/include/linux/cfi_types.h
> +++ b/tools/include/linux/cfi_types.h
> @@ -43,7 +43,7 @@
>  
>  #else /* __ASSEMBLY__ */
>  
> -#ifdef CONFIG_CFI_CLANG
> +#ifdef CONFIG_CFI
>  #define DEFINE_CFI_TYPE(name, func)						\
>  	/*									\
>  	 * Force a reference to the function so the compiler generates		\
> -- 
> 2.51.0.618.g983fd99d29-goog
> 

