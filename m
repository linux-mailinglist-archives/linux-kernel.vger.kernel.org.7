Return-Path: <linux-kernel+bounces-888822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ED881C3BFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 283ED341A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064024DCF9;
	Thu,  6 Nov 2025 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUcwcZL3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7424503C;
	Thu,  6 Nov 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442214; cv=none; b=plLR8CeK4LPT9Kj55m3qQ65hBLxHVDCtXLYS77bHxmW5nxDQnTpHzy6DTfYmee/kARvK4C0MpKbNLXPsx7yNu6t9JmXu24EBK17e014ZSLYWgAuXSKJoD3atnbvw5wzC3uHnKh2tNKPoKuzWl+aU8yShIQN73k90zn5f+9/f3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442214; c=relaxed/simple;
	bh=sw93HzZvGu9P1i+iQOU+54K5NF/ISfg6R9D40V3YXfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT3RHeGS+EQO9RcFphPoys6RUwsu4KIW8oMpv0HGqUN4hqjPGMQZPHbJcT1wMGj/RUupI2qnfJgN6iMnWOjIFKesnHRYTVTRnXlMLdQdnzoKt9IUA5nwClT/ig0HimTkhdhya0iA96GC4KaJkNi24eLpJDQ+F0Reryd2cpYipmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUcwcZL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EB9C4CEF7;
	Thu,  6 Nov 2025 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442214;
	bh=sw93HzZvGu9P1i+iQOU+54K5NF/ISfg6R9D40V3YXfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUcwcZL3xdgNqTG2JKegG2i9bvCC7qx27pVk4iM2U0mOsxRAUb2Te8uKsG16fqjeU
	 7M5hgdsWscDuM1ETvQUCfUuyACaaFDnHc2WNebaSqF8Yq48iyr/FVSriDwpBfrvoqc
	 LuEe7KhDiLkJCjdIZ6+zEf/G4dyZsDPuxG0DWAfKgjlOcSYOfemyPBZcaaf4AWFwra
	 c3rZ0QWJ5h0VywyhwmscOtJtJo2WV7WE8Zy2YYiQQzfTXjK0Vq9tLxpzlTzywwrdez
	 LwBp/kSXtMvaJtXwUmkanATfH9HT+h/vzC3n/Jk2v3EO8Oi/g+b86ckfDJA7t6qUei
	 Hmx2yIije53bQ==
Date: Thu, 6 Nov 2025 08:16:49 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 1/1] compiler_types: Warn about unused static inline
 functions on second
Message-ID: <20251106151649.GA1693433@ax162>
References: <20251106105000.2103276-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106105000.2103276-1-andriy.shevchenko@linux.intel.com>

On Thu, Nov 06, 2025 at 11:50:00AM +0100, Andy Shevchenko wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Per Nathan, clang catches unused "static inline" functions in C files since
> commit 6863f5643dd7 ("kbuild: allow Clang to find unused static inline
> functions for W=1 build").
> 
> Linus said:
> 
> > So I entirely ignore W=1 issues, because I think so many of the extra
> > warnings are bogus.
> >
> > But if this one in particular is causing more problems than most -
> > some teams do seem to use W=1 as part of their test builds - it's fine
> > to send me a patch that just moves bad warnings to W=2.
> >
> > And if anybody uses W=2 for their test builds, that's THEIR problem..
> 
> Here is the change to bump the warning from W=1 to W=2.
> 
> Fixes: 6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions for W=1 build")
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I can take this as a fix via kbuild or Linus can apply it directly
but...

> ---
>  include/linux/compiler_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 59288a2c1ad2..575a03643fa1 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -253,7 +253,7 @@ struct ftrace_likely_data {
>   * for W=1 build. This will allow clang to find unused functions. Remove the
>   * __inline_maybe_unused entirely after fixing most of -Wunused-function warnings.
>   */

The comment should be updated to W=2 instead of W=1 and we should
probably drop the sentence about removing __inline_maybe_unused entirely
since people such as Peter will never want this behavior by default. I
do not mind doing it myself if I take it.

> -#ifdef KBUILD_EXTRA_WARN1
> +#ifdef KBUILD_EXTRA_WARN2
>  #define __inline_maybe_unused
>  #else
>  #define __inline_maybe_unused __maybe_unused
> -- 
> 2.50.1
> 

