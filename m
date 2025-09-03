Return-Path: <linux-kernel+bounces-799303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF78BB429C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7BA1BC6342
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4CA36934D;
	Wed,  3 Sep 2025 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ4geQwH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB82D9789;
	Wed,  3 Sep 2025 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927342; cv=none; b=IsVEoXAq6ghMf+5EdjglwXuwVMi85PXPdJTjNTJ4ISBtZ71wNNTa7g2NHUj9Sgwr19SDT8BdV6QmqsnJobpAbk3agV9x30lmwt8GyR5Ed8566jObKaB/z+tkpvcWzZxiYEAqt4ep7NEUEe4awEid56KR0UlA0vTRSQRUsUOFgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927342; c=relaxed/simple;
	bh=Fo6LUWpj3L5ImvxYmnMdcLAutllHq3gmR/VcBHiyvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMFdtMU7ayAtrbNGtjdOhvMjcSA2Ef5r8Nu9DAQBm/PH+4DlhQpBkqqcAj1IqK3CUPv5LfPfsoT6uqrOPWLnjbIpBkwNcIemRgWaSsZiZ4QfV3ExsiiufnSGABchno+vE/+4Z6KY8lzSL9Q564cGnTx1Au/yO1qGaOtSrPeuJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ4geQwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1045C4CEF1;
	Wed,  3 Sep 2025 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927341;
	bh=Fo6LUWpj3L5ImvxYmnMdcLAutllHq3gmR/VcBHiyvUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZ4geQwHjeuGI8qFmHj/azGmZXOMy/TZAa52LUYJyMj9TpdH6oXSgJ0HItAveoFNu
	 hgZ7lqtF+5abnKaxl9Gw2Ts0MJs2y5v4auC0VBT/+swnd0u/LuV2natu6k1U2HvbA3
	 nQBsXRj1uEalx9GP4eBtbRFTYOxXjIlHdf1K+9E/ytLGF2u/sj3PloZDCcC7yeJrR+
	 luJoYa4bubCP+RJHy1gggSxUm/dF+p3HCc89uZquyvczKlLmFwZvYT61xTCTlRz+WP
	 y6HnqzsKNEqE6fhno+7yjomOSm2c+ratX6MxM1+s9NKq+1tDIO8pw3QQO0crWRPYv6
	 987U442D47FKA==
Date: Wed, 3 Sep 2025 12:22:19 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] LoongArch: Fix unreachable instruction warnings
 about entry functions
Message-ID: <ots6w2ntyudj5ucs5eowncta2vmfssatpcqwzpar3ekk577hxi@j45dd4dmwx6x>
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-4-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901072156.31361-4-yangtiezhu@loongson.cn>

On Mon, Sep 01, 2025 at 03:21:56PM +0800, Tiezhu Yang wrote:
> +++ b/arch/loongarch/kernel/Makefile
> @@ -3,8 +3,6 @@
>  # Makefile for the Linux/LoongArch kernel.
>  #
>  
> -OBJECT_FILES_NON_STANDARD_head.o := y
> -
>  always-$(KBUILD_BUILTIN)	:= vmlinux.lds
>  
>  obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index e3865e92a917..a11880f3a7e1 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -42,6 +42,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
>  	.align 12
>  
>  SYM_CODE_START(kernel_entry)			# kernel entry point
> +	UNWIND_HINT_UNDEFINED

Should this not be UNWIND_HINT_END_OF_STACK?

I notice Loongarch doesn't seem to use that anywhere.  How does any ORC
unwind succeed?  UNWIND_HINT_UNDEFINED sets an error condition which
should cause a livepatch transition to stall.

-- 
Josh

