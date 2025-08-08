Return-Path: <linux-kernel+bounces-760204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9629B1E7C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07337587E22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A370A275AE3;
	Fri,  8 Aug 2025 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgiQTmPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126FB27586C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654080; cv=none; b=F6TXLf8JXuhdkEmoyn+0b8Wtq0EB+qGsdKP5jkowB8ms1YNMbcdibqwQTggVbFpTNZflOgMR+koaJDlcS7yzwzRu1gBtNrVRgJ0brB37jzAXGK3YZk/u0ZgXPqgF24rk5AnnIcdGaYhHPVj84S84VlRep2XP0GgsyN7P8saqCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654080; c=relaxed/simple;
	bh=kl2NK5vZVEJ1cuoKOne6B1eUNATkpcR/aXK7M5rs130=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4DJXfqQBUWupBNWJU3HMVLrpsJRJwoG5LnymYEKPMalJkXlngedaz/Iv6lia0GgBbCX8sSyD/jX2tt4co9p8aQvb7H3HWBLFw1p10Tu9YGOv21Hid8KEY0raC6kMrKFwvl7PGC4355rUSLW4wrce6RSTIgnX0cwRE0KQOWyKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgiQTmPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DD2C4CEED;
	Fri,  8 Aug 2025 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754654079;
	bh=kl2NK5vZVEJ1cuoKOne6B1eUNATkpcR/aXK7M5rs130=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgiQTmPPOPRhi9AtZUIzrmLsRGQkexyZmeK4Fldz+wXGGd7C1h9p+xHiAN2sfGRf+
	 4YT/vbnFNtsNybr0ENQSAAFmbJCS4X8nCAJnMe1vxTfGhz9cEaZlXrEcyPCVWzmEu4
	 HLhG24zvFS5G/1Lp+FROqtllP3skQfUoaZvVl5+qvOBMfu9fDXo8998uLeywmMC+BK
	 3tykewBaob4txA60uvnR/d4bbmoCVskFzJ/VKu1jra9oXmHShgYdtVXZ0d9hb246Oa
	 9FBrm1Rn79bN4QVRLY5pThl3QdKKl6ANzFmXojrFOLqEAxEUG9AZQgacwdlg/KCqam
	 1POVlUeoDkhbQ==
Date: Fri, 8 Aug 2025 12:54:34 +0100
From: Will Deacon <will@kernel.org>
To: fanqincui@163.com
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Fanqin Cui <cuifq1@chinatelecom.cn>,
	maz@kernel.org
Subject: Re: [PATCH] arm64/module: Support for patching modules during runtime
Message-ID: <aJXlegQfZTdimS3k@willie-the-truck>
References: <20250807072700.348514-1-fanqincui@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807072700.348514-1-fanqincui@163.com>

On Thu, Aug 07, 2025 at 03:27:00AM -0400, fanqincui@163.com wrote:
> From: Fanqin Cui <cuifq1@chinatelecom.cn>
> 
> If use the ALTERNATIVE_CB interface in a kernel module to
> patch code, the kernel will crash. The relevant log is as follows:
> 
>  Mem abort info:
>    ESR = 0x000000008600000f
>    EC = 0x21: IABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x0f: level 3 permission fault
>  swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000013cfbed000
>  [ffff80007b0b0000] pgd=0000000000000000, p4d=10000013d0d03003,
> pud=1000000103175403, pmd=1000000115804403, pte=0068000116b77703
>  Internal error: Oops: 000000008600000f [#1]  SMP
> 
>  Call trace:
>   0xffff80007b0b0000 (P)
>   apply_alternatives_module+0x48/0x7c
>   module_finalize+0xc0/0x134
>   load_module+0x15c0/0x1c08
>   init_module_from_file+0x8c/0xcc
>   __arm64_sys_finit_module+0x1c0/0x2d4
>   invoke_syscall+0x48/0x110
>   el0_svc_common.constprop.0+0xc0/0xe0
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x34/0xf0
>   el0t_64_sync_handler+0xa0/0xe4
>   el0t_64_sync+0x198/0x19c
>  Code: 00000000 00000000 00000000 00000000 (d503233f)
>  ---[ end trace 0000000000000000 ]---
> 
> To avoid this problem, this commit supports add a new section.
> When the module is loading, this section will be found and the
> page table attributes will be set to executable state in advance.
> 
> Signed-off-by: Fanqin Cui <cuifq1@chinatelecom.cn>
> ---
>  arch/arm64/kernel/module.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 40148d2725ce..2160b2877935 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -24,6 +24,7 @@
>  #include <asm/scs.h>
>  #include <asm/sections.h>
>  #include <asm/text-patching.h>
> +#include <asm-generic/set_memory.h>
>  
>  enum aarch64_reloc_op {
>  	RELOC_OP_NONE,
> @@ -477,6 +478,9 @@ int module_finalize(const Elf_Ehdr *hdr,
>  	const Elf_Shdr *s;
>  	int ret;
>  
> +	s = find_section(hdr, sechdrs, ".text.alternative_cb");
> +	if (s && s->sh_size > PAGE_SIZE && PAGE_ALIGNED(s->sh_addr))
> +		set_memory_x(s->sh_addr, s->sh_size >> PAGE_SHIFT);

Hmm, so the alternatives callback function lives in the module itself?
Which module does that? I'm a bit nervous about running module code
before the module has actually finished loading...

Does layout_sections() correctly map '.text.alternative_cb' as
executable later on?

Will

