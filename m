Return-Path: <linux-kernel+bounces-863043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4641BF6DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACB105038AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E53033859C;
	Tue, 21 Oct 2025 13:46:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2F1210F59
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054360; cv=none; b=XQa7cCdqXCz/fQU/RbwpMLT9Ic016YLefn6/ITLSqiQIGyL1TNaKkU2+oc5xIJ/NrHy6TX5MDeepCqLQz8D9Go0YJM/Y7/vzu5cniVmJ1d6IfvR6A282427GiZC5geANIo1QtNQFtz0h0MILW3VtaBNoxAwkcaCNUNEz27OcJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054360; c=relaxed/simple;
	bh=x4HrEn1M9Sk3piYChqejT9iaRMP6cuEYvvtEbBW2lL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7R7QUgxLIHAsFLQqe9xszzG93IXs6YPWZM/Jiy7AkKmQmMj2T6pFTbCl5z073Rc2M5j393vxJiA7Xetaubkj01CHs4Hb4KZ5I7a/eT4MJ6DzwxC8rGTqCb2xC+AdlRYY78wYYjS2pir6t7xgSgLSt++xEgOL/+bnWL3uh8pwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAA281063;
	Tue, 21 Oct 2025 06:45:49 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D22043F63F;
	Tue, 21 Oct 2025 06:45:56 -0700 (PDT)
Message-ID: <8ca00b05-d402-4359-9403-32dc714e3cb0@arm.com>
Date: Tue, 21 Oct 2025 14:45:55 +0100
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
 <1148d823-5a89-4f32-911b-f009a8ea5641@arm.com>
 <875f379a-c3eb-4b1b-bb42-46183a879d69@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <875f379a-c3eb-4b1b-bb42-46183a879d69@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anshuman,

On 10/21/25 13:45, Anshuman Khandual wrote:
> 
> 
> On 21/10/25 2:30 PM, Ben Horgan wrote:
>> Hi Anshuman,
>>
>> On 10/21/25 06:20, Anshuman Khandual wrote:
>>> Add remaining TLBI_XXX_MASK macros and replace current open encoded fields.
>>> While here replace hard coded page size based shifts but with derived ones
>>> via ilog2() thus adding some required context.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  arch/arm64/include/asm/tlbflush.h | 26 ++++++++++++++++++--------
>>>  1 file changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>>> index 131096094f5b..cf75fc2a06c3 100644
>>> --- a/arch/arm64/include/asm/tlbflush.h
>>> +++ b/arch/arm64/include/asm/tlbflush.h
[...]
>>> @@ -100,8 +101,17 @@ static inline unsigned long get_trans_granule(void)
>>>   *
>>>   * For Stage-2 invalidation, use the level values provided to that effect
>>>   * in asm/stage2_pgtable.h.
>>> + *
>>> + * +----------+------+-------+--------------------------------------+
>>> + * |   ASID   |  TG  |  TTL  |                 BADDR                |
>>> + * +-----------------+-------+--------------------------------------+
>>> + * |63      48|47  46|45   44|43                                   0|
>>> + * +----------+------+-------+--------------------------------------+
>>>   */
>>> -#define TLBI_TTL_MASK		GENMASK_ULL(47, 44)
>>> +#define TLBI_ASID_MASK		GENMASK_ULL(63, 48)
>>> +#define TLBI_TG_MASK		GENMASK_ULL(47, 46)
>>> +#define TLBI_TTL_MASK		GENMASK_ULL(45, 44)
>>
>> The definition of TLBI_TTL_MASK changes here. This might be the correct
>> thing to do but it should be mentioned in the commit message and the
> 
> Sure, will update the commit message.
>> other user, arch/arm64/kvm/nested.c, needs to be updated in tandem.
> 
> Right, missed that one. Probably something like the following change
> might do it for KVM without much code churn.
> 
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -540,7 +540,7 @@ unsigned long compute_tlb_inval_range(struct kvm_s2_mmu *mmu, u64 val)
>         unsigned long max_size;
>         u8 ttl;
> 
> -       ttl = FIELD_GET(TLBI_TTL_MASK, val);
> +       ttl = FIELD_GET(TLBI_TTL_MASK, val) | FIELD_GET(TLBI_TG_MASK, val);

This and the other changed lines are missing a shift, but otherwise
seems reasonable.

> 
>         if (!ttl || !kvm_has_feat(kvm, ID_AA64MMFR2_EL1, TTL, IMP)) {
>                 /* No TTL, check the shadow S2 for a hint */
> @@ -963,7 +963,7 @@ static void compute_s1_tlbi_range(struct kvm_vcpu *vcpu, u32 inst, u64 val,
>         case OP_TLBI_VALE1ISNXS:
>         case OP_TLBI_VALE1OSNXS:
>                 scope->type = TLBI_VA;
> -               scope->size = ttl_to_size(FIELD_GET(TLBI_TTL_MASK, val));
> +               scope->size = ttl_to_size(FIELD_GET(TLBI_TTL_MASK, val) | FIELD_GET(TLBI_TG_MASK, val));
>                 if (!scope->size)
>                         scope->size = SZ_1G;
>                 scope->va = tlbi_va_s1_to_va(val) & ~(scope->size - 1);
> @@ -991,7 +991,7 @@ static void compute_s1_tlbi_range(struct kvm_vcpu *vcpu, u32 inst, u64 val,
>         case OP_TLBI_VAALE1ISNXS:
>         case OP_TLBI_VAALE1OSNXS:
>                 scope->type = TLBI_VAA;
> -               scope->size = ttl_to_size(FIELD_GET(TLBI_TTL_MASK, val));
> +               scope->size = ttl_to_size(FIELD_GET(TLBI_TTL_MASK, val) | FIELD_GET(TLBI_TG_MASK, val));
>                 if (!scope->size)
>                         scope->size = SZ_1G;
>                 scope->va = tlbi_va_s1_to_va(val) & ~(scope->size - 1);
> 
>>
>>> +#define TLBI_BADDR_MASK		GENMASK_ULL(43, 0)
>>>  
>>>  #define TLBI_TTL_UNKNOWN	INT_MAX
>>>  
>>
>> Thanks,
>>
>> Ben
>>
> 

Thanks,

Ben


