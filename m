Return-Path: <linux-kernel+bounces-741075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0765BB0DFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0373A97EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDEC2EAB8B;
	Tue, 22 Jul 2025 14:56:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E228C5B4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196189; cv=none; b=OYRYh6iBibXF93j1fGOJShl7xWnbxvFcQwoLF7WPvFeXk83CKmRmNHMDLyUrf/B/C1CUlG5HOvLLzbgn6s5iuFY4qluPATTwoIRORFR2LH3UP6Vy6joCpFa2bZhg+Z96fHTxhLZbCW82dqnqwZ1q9Tg4IipULDawS8Z1OaPRvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196189; c=relaxed/simple;
	bh=DwcswQ0G98csfq+HjDJJZQ4vC+N5acrodfen4/TmfRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6o5pv+r2BJKJJ4rawSwiOpGbGR03cIVsr3u1e4/QmI/H17nZlRS5Yjnx34YpTDLg0HI4w2M0kJ4wMls9QFrSMWNj5ilCikV71LLbxi4c6OEQZCq1I7gCGQVnf/+vJoT/rOYIEs/IfNhvYftTVZrz1wcP0MBtnnA1KyImNdL6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3425A152B;
	Tue, 22 Jul 2025 07:56:21 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B543F3F6A8;
	Tue, 22 Jul 2025 07:56:25 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:56:20 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Weikang Guo <guoweikang.kernel@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Ensure phys_to_ttbr on pgdir for
 idmap_cpu_replace_ttbr1
Message-ID: <aH-mlN88NrTzahfM@J2N7QTR9R3>
References: <20250722082117.1777570-1-guoweikang.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722082117.1777570-1-guoweikang.kernel@gmail.com>

On Tue, Jul 22, 2025 at 04:21:13PM +0800, Weikang Guo wrote:
> Commit 5ffdfaedfa0a ("arm64: mm: Support Common Not Private translations")
> changed the contract of idmap_cpu_replace_ttbr1, requiring that the TTBR
> argument passed in should already be processed by phys_to_ttbr (i.e., in
> TTBR format, not just a raw physical address).
> 
> However, the current map_kernel implementation does not always convert the
> pgdir/ttbr argument via phys_to_ttbr before calling
> idmap_cpu_replace_ttbr1. This can lead to issues on systems with
> CONFIG_ARM64_PA_BITS_52 enabled, as the TTBR would not be properly folded
> per the ARMv8.2+ requirements.

For the cases below I don't believe that this is actually a problem.
Since commit:

  453dfcee70c5c344 ("arm64: booting: Require placement within 48-bit addressable memory")

... we require that the kernel Image (including any trailing unallocated
bytes accounted for in image_size) are below the 48-bit address limit,
and so there should be no difference between the PA and TTBR format.

We could probably test and enforce that in the early boot code somehow,
if we're not doing that already.

If we were going to change things to avoid accidents in future, I think
it would be better to enforce this with the type system. e.g. we could
have a ttbr_val type that's distinct from phys_addr_t. Even then, for
the idmap code I think it's better to avoid the phys_to_ttbr() dance,
since that has runtime patching.

Mark.

> 
> Signed-off-by: Weikang Guo <guoweikang.kernel@gmail.com>
> 
> ---
> Note: I do not currently have access to ARM64 hardware or an emulation
> environment that supports 52-bit physical address (PA52). I would
> greatly appreciate if anyone with such a platform could help test
> this patch. Thank you!
> ---
>  arch/arm64/kernel/pi/map_kernel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
> index 0f4bd7771859..05a04eb91e81 100644
> --- a/arch/arm64/kernel/pi/map_kernel.c
> +++ b/arch/arm64/kernel/pi/map_kernel.c
> @@ -18,7 +18,7 @@
>  
>  extern const u8 __eh_frame_start[], __eh_frame_end[];
>  
> -extern void idmap_cpu_replace_ttbr1(void *pgdir);
> +extern void idmap_cpu_replace_ttbr1(phys_addr_t);
>  
>  static void __init map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
>  			       void *start, void *end, pgprot_t prot,
> @@ -90,7 +90,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
>  		    true, root_level);
>  	dsb(ishst);
>  
> -	idmap_cpu_replace_ttbr1(init_pg_dir);
> +	idmap_cpu_replace_ttbr1(phys_to_ttbr((u64)init_pg_dir));
>  
>  	if (twopass) {
>  		if (IS_ENABLED(CONFIG_RELOCATABLE))
> @@ -129,7 +129,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
>  	/* Copy the root page table to its final location */
>  	memcpy((void *)swapper_pg_dir + va_offset, init_pg_dir, PAGE_SIZE);
>  	dsb(ishst);
> -	idmap_cpu_replace_ttbr1(swapper_pg_dir);
> +	idmap_cpu_replace_ttbr1(phys_to_ttbr((u64)swapper_pg_dir));
>  }
>  
>  static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
> -- 
> 2.25.1
> 
> 

