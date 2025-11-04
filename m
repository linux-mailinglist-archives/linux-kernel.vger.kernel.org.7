Return-Path: <linux-kernel+bounces-885066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D2C31E63
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E470B4E29AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2482FB619;
	Tue,  4 Nov 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8FucS1M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842A02561AB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270989; cv=none; b=qmFXmxz4Ag5KSUE+dA5U0jUP8I3BtTWwKY4V49blZ6cPbh3mZUUDy7MKzibR0VPs1pLx+O6SifceHV0XYcDSH9i+VMiJKxQnuXx5ASBZoe30lWUWq0n3XCAQhsVaXZEIOZ4tyYvzbE+9VwJYMNLdtq0IYu+edqIXQq97zK84bE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270989; c=relaxed/simple;
	bh=KVTmgezBCR1xhPB/QEJzMt3rheg4sku63yQBXwnYTP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POeNrNJMjt+nOPEcR5fLIVZ7cWRct+mqHQ1jUvixvEBNndDf+oj5lG28V952JjjczA5Mp2vlHh4LqnVZBZGEIVQwBZHYFjNNh7gphNbbGrnvXrCCYJyq2ZNEMEedjnrSH8gmH+Q6R2+C9Zy3KvQuqDO5aOLaQo4wLRykdSs0b/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8FucS1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41362C4CEF7;
	Tue,  4 Nov 2025 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270989;
	bh=KVTmgezBCR1xhPB/QEJzMt3rheg4sku63yQBXwnYTP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8FucS1MWRrDaDhum/yjxBXSjcHW305MewAZ6Il1bMNCrQN9d5YWgPq7NaFePtAWn
	 203jESlM53J+4VhxPwmSG8Gjwskr08fIy3IrN+7bUq0Te0FoAd/+3hXWADJCWFTox4
	 +65vmET5Lb+by5OJ02rvKrjLYkpZpUOjDrdGgrdcfzFlt9JNfu4OGIQOFxXVCeeZLO
	 n+jhd749RuUFFCR3HOIQk5CKEn0wg8TFQOyjE2aXEgrSgj3QTxES/CN7cL0a5gOxhP
	 t6uqYJ+KZ8APdkbsvakEMKjA6vfVdXghOBRgv21zFhPbn3HugefDhaxcLED4r0bKDY
	 9Mf9s3tF8A0Qw==
Date: Tue, 4 Nov 2025 15:43:04 +0000
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com
Subject: Re: [PATCH] arm64/mm: Drop redundant extern declaration for
 rodata_full
Message-ID: <aQofCMqxiqujZP-g@willie-the-truck>
References: <20251015023609.427911-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015023609.427911-1-anshuman.khandual@arm.com>

On Wed, Oct 15, 2025 at 03:36:09AM +0100, Anshuman Khandual wrote:
> Drop the redundant extern declaration 'rodata_full' which can be included
> via the header <asm/setup.h> after moving exiting declaration outside the
> function arch_parse_debug_rodata(). While here also drop 'rodata_enabled'
> which is anyways available via the generic header <linux/init.h>.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/mmu_context.h | 2 --
>  arch/arm64/include/asm/setup.h       | 4 +---
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 0375ca3162ff..e4b3563e1d96 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -26,8 +26,6 @@
>  #include <asm/sysreg.h>
>  #include <asm/tlbflush.h>
>  
> -extern bool rodata_full;
> -
>  static inline void contextidr_thread_switch(struct task_struct *next)
>  {
>  	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> index 3d96dde4d214..902f1aab520f 100644
> --- a/arch/arm64/include/asm/setup.h
> +++ b/arch/arm64/include/asm/setup.h
> @@ -12,12 +12,10 @@
>   */
>  extern phys_addr_t __fdt_pointer __initdata;
>  extern u64 __cacheline_aligned boot_args[4];
> +extern bool rodata_full;
>  
>  static inline bool arch_parse_debug_rodata(char *arg)
>  {
> -	extern bool rodata_enabled;
> -	extern bool rodata_full;
> -
>  	if (!arg)
>  		return false;

It would probably be cleaner to make 'rodata_full' static in mm/pageattr.c,
move the guts of arch_parse_debug_rodata in there and then consolidate
can_set_direct_map() and force_pte_mapping().

You need to talk to Ryan for the last part, as David's made some
suggestions around that too.

Will

