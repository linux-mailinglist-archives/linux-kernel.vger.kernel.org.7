Return-Path: <linux-kernel+bounces-841386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0657BB72C9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF004A03F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD4C235BE2;
	Fri,  3 Oct 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLbPn1Qk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393DF23185E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501431; cv=none; b=YJJd5mDnCVDBE86CGd3b3P2gCAPQRi8jyAyhs3tTBXI7QrGXy8fUP5bngFQN6vwYVRUUj+lrYjx+wNhfibZyH6yIuJg2dQ14GYYex4p64URAFun0wXzDSOgxN9KJHwMwVgYzUDw89dhsLAxeSgnyGA7LHuvXP5j7CWwFhnTOkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501431; c=relaxed/simple;
	bh=vrqQ/uunB3QJ/L4U5wadBAHA2oI5nDh2QtaYKaOQA8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7Bg8HgshDxqgSD6d/uQzwr1GyQmxJjYrx6jz4kMU1WV/p1X0iIFSkgQUfqa7otUNlk8Fhl/3l0GCpC+JXrQFIE0s5439x8vZUhREn4a9iUstHQzUjXyBEd0ui97q+/7vEfIKMvhLTz1GkLEn2G8kU8VnsfIWO33ksvsQleDbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLbPn1Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A75AC4CEF5;
	Fri,  3 Oct 2025 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759501430;
	bh=vrqQ/uunB3QJ/L4U5wadBAHA2oI5nDh2QtaYKaOQA8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLbPn1Qkc5Hh3mJE5C6B1Hd2fp6R7O3RszHc6FCqPd/WXmv+Vu4k1mkKPwTTYpBF1
	 adZmmlpSL4ZATMWG93PUMfAXvwcfPR/os5M1AnAk7sxPboD48rTGHEa5iDhl9xM8+u
	 kzKzPntdp+prpoJSrypes4/3r/0dGcu3GnsQogpwOi22ZHlQV1xFcUKhX/3uvPW0os
	 AvUx6skBfn2Gvtzfy0NiIV6ih9OwCiywkpQRYJx6T6BOBE+35bkD7pqNm3XMEWDA8w
	 fYfvu4dqfB1XiErY+R4v9FpUUYRUs4q+tnghvnSTgd8XDgVwIFFUcCJpfPSOpSK/ip
	 QnxzKpvJzUymA==
Date: Fri, 3 Oct 2025 15:23:45 +0100
From: Will Deacon <will@kernel.org>
To: shechenglong <shechenglong@xfusion.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stone.xulei@xfusion.com,
	chenjialong@xfusion.com, yuxiating@xfusion.com,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] cpu: fix hard lockup triggered by printk calls within
 scheduling context
Message-ID: <aN_ccUJZQVMmk1V-@willie-the-truck>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <20250924123247.807-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924123247.807-1-shechenglong@xfusion.com>

On Wed, Sep 24, 2025 at 08:32:47PM +0800, shechenglong wrote:
> relocate the printk() calls from spectre_v4_mitigations_off() and
> spectre_v2_mitigations_off() into setup_system_capabilities() function,
> preventing hard lockups that occur when printk() is invoked from scheduler context.
> 
> Link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250918064907.1832-1-shechenglong@xfusion.com/
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: shechenglong <shechenglong@xfusion.com>
> ---
>  arch/arm64/include/asm/spectre.h |  3 +++
>  arch/arm64/kernel/cpufeature.c   |  9 +++++++++
>  arch/arm64/kernel/proton-pack.c  | 18 ++++--------------
>  3 files changed, 16 insertions(+), 14 deletions(-)

Thanks for posting the patch!

> diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
> index 8fef12626090..6fe29df41788 100644
> --- a/arch/arm64/include/asm/spectre.h
> +++ b/arch/arm64/include/asm/spectre.h
> @@ -118,5 +118,8 @@ void spectre_bhb_patch_wa3(struct alt_instr *alt,
>  void spectre_bhb_patch_clearbhb(struct alt_instr *alt,
>  				__le32 *origptr, __le32 *updptr, int nr_inst);
>  
> +bool spectre_v2_mitigations_off(void);
> +bool spectre_v4_mitigations_off(void);
> +
>  #endif	/* __ASSEMBLY__ */
>  #endif	/* __ASM_SPECTRE_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ef269a5a37e1..7d1f541e66a0 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -94,6 +94,7 @@
>  #include <asm/traps.h>
>  #include <asm/vectors.h>
>  #include <asm/virt.h>
> +#include <asm/spectre.h>
>  
>  /* Kernel representation of AT_HWCAP and AT_HWCAP2 */
>  static DECLARE_BITMAP(elf_hwcap, MAX_CPU_FEATURES) __read_mostly;
> @@ -3942,6 +3943,14 @@ static void __init setup_system_capabilities(void)
>  	 */
>  	if (system_uses_ttbr0_pan())
>  		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
> +
> +	/*
> +	 * Report Spectre mitigations status.
> +	 */
> +	if (spectre_v2_mitigations_off())
> +		pr_info("spectre-v2 mitigation disabled by command line option\n");

nit: Let's fix the message here for consistency and use "command-line".

> +	if (spectre_v4_mitigations_off())
> +		pr_info("spectre-v4 mitigation disabled by command-line option\n");

I think it would be cleaner to have a new function in proton-pack.c, say
"spectre_print_disabled_mitigations()" which can then print the messages
for spectre v2, v4 and also spectre-bhb (currently done in
spectre_bhb_enable_mitigation()).

While you're at it, spectre-bhb is weird because it also prints a message
when the Kconfig is disabled. We should actually just get rid of that
Kconfig option altogether (in a separate patch) like we did for the other
spectre mitigations.

What do you think?

Cheers,

Will

