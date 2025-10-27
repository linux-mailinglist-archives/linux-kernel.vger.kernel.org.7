Return-Path: <linux-kernel+bounces-871573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2398C0DA38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2311885B35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB932F49F2;
	Mon, 27 Oct 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cLOCMcSp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190921FF3B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568881; cv=none; b=ugkrxJ9VvznGlz3LeHvTtlJmyG3Y3srG5F9N8nu1iIOTnInK/f+6wi5LB99FRP9+AkXNfHu3I+VHWoWNDqk66hJtn+VAzce0DZhtq+510Nbyln1xiSCQHnO8h8DNTesFt8AevHLIm6+AIaa6XgppGH7FXpHULNFswSJN8BGXEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568881; c=relaxed/simple;
	bh=zIA7CYP7MP7otslNuxA8EJWMnrgrr6UbF5Y/fLvRKoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBpsVkJ6JVkzf3BKqEKJjAbfK+xjbmM3z9VjGefwBr6pdZ5TFsgkWN+LVsaIbUTokM6QH8jiX/yQWL9zq3p6egUov02we4ySkCHbFhJi/ktGM10Gyjtjx2lr9s9ptmd3EllyCpkACJpjvJzjKaPJzhRHaC42nd+jqoRyZRIuGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cLOCMcSp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0474640E019F;
	Mon, 27 Oct 2025 12:41:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 40bnCv3Bee17; Mon, 27 Oct 2025 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761568864; bh=8tAYZy7U1ebgZ3yufSzji3+OjzI4Ta9GIJ0Mp53XepI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLOCMcSpphagQ/E8zZJ4nwI0tBJjuQTdiOb/vIzlznfJeOOvDsy2YVYqWtr48MfYz
	 lU/Ss9HLzDyCGqdYMjdhlQoK8+0hZVgs4jSjT33UN0qEM7wrf50SYn/IAbNyd5aean
	 E1Dau6r+CNCYGedw1F4Z0NIatNsUo7eI93K8zQ97pqOcbND8whNBoC5vRd3psEhoLp
	 fdqaKH2hAujRXmcbtX64nwXxUmCexkZPedEt/lT5C1DEAjbhsUfczldCcG9FYkRaSc
	 EpWIhbXyKBIb7LQcfknNrccaX/LrHlnZ1Rk5+BooLngMY6kQK4OOtX34he11qQl5o5
	 xzGpuGGMUjyOWeU4SNoENX7f0B5VdR6397CTW5RO3GAKhf4SkxMspPrpaGb/LlfYnp
	 oF48jBjqj3QYh4P+gcAJwb0flZuwNvsKg/PUFpgY9MXusL8UF6Dz677bh20yxb5aME
	 UnB6qQrtYppfgXs5+QWJ3p361DadSSFJdRfUmXWNTAUq/j2qppYBy3umpxhdWnVOYN
	 eVlnb4zfPGf01Vz1GMcUiuWU3IFRYuiCG7tvGuLLR0XKuj9+7/7+gl7xiW4aZG2AKf
	 IZoLU5RDmlh3NPAXRjkQ6jsDgJGpSQfOFNJAzL02as9g/dzA1xIa3GHijHLcoSmIgl
	 XwIjsm1uA62U7r4PFG2uemUs=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 53A9240E016D;
	Mon, 27 Oct 2025 12:40:57 +0000 (UTC)
Date: Mon, 27 Oct 2025 13:40:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Leyvi Rose <leyvirose@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: x86: Disable SSE4A
Message-ID: <20251027124049.GAaP9oUaUtzzHUK4j4@fat_crate.local>
References: <20251027114059.GJ3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027114059.GJ3245006@noisy.programming.kicks-ass.net>

On Mon, Oct 27, 2025 at 12:40:59PM +0100, Peter Zijlstra wrote:
> Leyvi Rose reported that his X86_NATIVE_CPU=y build is failing because
> our instruction decoder doesn't support SSE4A and the AMDGPU code seems
> to be generating those with his compiler of choice (CLANG+LTO).
> 
> Now, our normal build flags disable SSE MMX SSE2 3DNOW AVX, but then
> CC_FLAGS_FPU re-enable SSE SSE2.
> 
> Since nothing mentions SSE3 or SSE4, I'm assuming that -msse (or its
> negative) control all SSE variants -- but why then explicitly enumerate
> SSE2 ?
> 
> Anyway, until the instruction decoder gets fixed, explicitly disallow
> SSE4A (an AMD specific SSE4 extension).
> 
> Fixes: ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 4db7e4bf69f5..8fbff3106c56 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -75,7 +75,7 @@ export BITS
>  #
>  #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
>  #
> -KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
> +KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a
>  KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
>  KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

