Return-Path: <linux-kernel+bounces-862475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 413B5BF563D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E989F352541
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D5E32AAD8;
	Tue, 21 Oct 2025 09:00:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5D2E1F0A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037240; cv=none; b=Nbpci/Wpw3HjpA9mBS++BYdP/9GlmqP7iWF0VBcNgJhjQeQLrzMy9WHYfzaBeAILA0hvjgJq8RKlm5GQKycFX8n/WSW20V9l2zRpA/TanaYWZcnGl9FAviaZTsSbdQ5G7IiXNXjjpmfYGmSQcQB3z0w75/G4T1VbHruNqRhGtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037240; c=relaxed/simple;
	bh=lv9c03O8j0aOw9yokKu2khhzwUjROQHnbJfhnWDKLGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5Q3A4V7WK2jqyctVxEV77Aqgv6SZ5nWF5YFY4UPxkdYzKhuXOG8IxgirCbWHbwoPk6FiQTsUzgwEar6uBoWpRuhyBZ5EvRa9mnOaDF3d27rm7CJPCfVafg9jUl1ccxeZk6yzuu+Tu1CW7tggEcVJ36/NDsSRujIin/MxjOngUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A5D91063;
	Tue, 21 Oct 2025 02:00:29 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B89573F66E;
	Tue, 21 Oct 2025 02:00:36 -0700 (PDT)
Message-ID: <1148d823-5a89-4f32-911b-f009a8ea5641@arm.com>
Date: Tue, 21 Oct 2025 10:00:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64/mm: Add remaining TLBI_XXX_MASK macros
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20251021052022.2898275-1-anshuman.khandual@arm.com>
 <20251021052022.2898275-3-anshuman.khandual@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <20251021052022.2898275-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anshuman,

On 10/21/25 06:20, Anshuman Khandual wrote:
> Add remaining TLBI_XXX_MASK macros and replace current open encoded fields.
> While here replace hard coded page size based shifts but with derived ones
> via ilog2() thus adding some required context.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/tlbflush.h | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 131096094f5b..cf75fc2a06c3 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -57,9 +57,10 @@
>  /* This macro creates a properly formatted VA operand for the TLBI */
>  #define __TLBI_VADDR(addr, asid)				\
>  	({							\
> -		unsigned long __ta = (addr) >> 12;		\
> -		__ta &= GENMASK_ULL(43, 0);			\
> -		__ta |= (unsigned long)(asid) << 48;		\
> +		unsigned long __ta = (addr) >> ilog2(SZ_4K);	\
> +		__ta &= TLBI_BADDR_MASK;			\
> +		__ta &= ~TLBI_ASID_MASK;			\
> +		__ta |= FIELD_PREP(TLBI_ASID_MASK, asid);	\
>  		__ta;						\
>  	})
>  
> @@ -100,8 +101,17 @@ static inline unsigned long get_trans_granule(void)
>   *
>   * For Stage-2 invalidation, use the level values provided to that effect
>   * in asm/stage2_pgtable.h.
> + *
> + * +----------+------+-------+--------------------------------------+
> + * |   ASID   |  TG  |  TTL  |                 BADDR                |
> + * +-----------------+-------+--------------------------------------+
> + * |63      48|47  46|45   44|43                                   0|
> + * +----------+------+-------+--------------------------------------+
>   */
> -#define TLBI_TTL_MASK		GENMASK_ULL(47, 44)
> +#define TLBI_ASID_MASK		GENMASK_ULL(63, 48)
> +#define TLBI_TG_MASK		GENMASK_ULL(47, 46)
> +#define TLBI_TTL_MASK		GENMASK_ULL(45, 44)

The definition of TLBI_TTL_MASK changes here. This might be the correct
thing to do but it should be mentioned in the commit message and the
other user, arch/arm64/kvm/nested.c, needs to be updated in tandem.

> +#define TLBI_BADDR_MASK		GENMASK_ULL(43, 0)
>  
>  #define TLBI_TTL_UNKNOWN	INT_MAX
>  

Thanks,

Ben


