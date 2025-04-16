Return-Path: <linux-kernel+bounces-604324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95197A89339
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 07:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA08A1897AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 05:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF132741CA;
	Tue, 15 Apr 2025 04:59:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB422741AD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 04:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693191; cv=none; b=NHUZGDS7wdKD8FXAHSdJ8ZTBXzE9Nx7/bqaUVfbEtNhKVunujcP+E1ThgF0kSgbk6BMNf1RXhtxFA8G1gb5WSNcdsfHWW9mBkdnL8N4NKq73jT2JPYChzYoPBKH7dGIa/cOXnAhNBDzyjCdtaUfUmEP84yquHHGZ6Uk1pFetiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693191; c=relaxed/simple;
	bh=0NoQvozSdclDxiV2xGKA9RSXgdntWBTdc62dx5ProLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noX2s9C0TGeXqANvedp2ix25jXPkLiKpciKID0zyJk7KyloY/uERrpLxadjJLOSiZwDnGNqqcSvROfNMX8fgpruGuPBlYtAsIHL7v7BZ5pwwJFWcLB+fPZ2XFVhSG8yPM0KDVXd4M3EI6ZF1jch/1FYLbOqEqDlx9y0w4xs4jHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54BFA15A1;
	Mon, 14 Apr 2025 21:59:47 -0700 (PDT)
Received: from [10.163.49.104] (unknown [10.163.49.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A51D3F66E;
	Mon, 14 Apr 2025 21:59:45 -0700 (PDT)
Message-ID: <7e68b780-0591-4b05-98f0-154441f5dd14@arm.com>
Date: Tue, 15 Apr 2025 10:29:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Implement pte_po_index() for permission overlay
 index
To: Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250410052021.1533180-1-anshuman.khandual@arm.com>
 <0bad3714-06b3-488f-a414-b825f409b926@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <0bad3714-06b3-488f-a414-b825f409b926@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/14/25 18:58, Ryan Roberts wrote:
> On 10/04/2025 06:20, Anshuman Khandual wrote:
>> From: Ryan Roberts <ryan.roberts@arm.com>
>>
>> Previously pte_access_permitted() used FIELD_GET() directly to retrieve
>> the permission overlay index from the pte. However, FIELD_GET() doesn't
>> work for 128 bit quanitites. Since we are about to add support for D128
>> pgtables, let's create a specific helper, pte_po_index() which can do
>> the required mask and shift regardless of the data type width.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This patch applies on v6.15-rc1
>>
>>  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
>>  arch/arm64/include/asm/pgtable-prot.h  | 2 ++
>>  arch/arm64/include/asm/pgtable.h       | 2 +-
>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index f3b77deedfa2..028a164924df 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -211,6 +211,7 @@
>>  #define PTE_PO_IDX_2	(_AT(pteval_t, 1) << 62)
>>  
>>  #define PTE_PO_IDX_MASK		GENMASK_ULL(62, 60)
>> +#define PTE_PO_IDX_SHIFT	60
>>  
>>  
>>  /*
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index 7830d031742e..b53bc241e4e7 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -136,6 +136,8 @@ static inline bool __pure lpa2_is_enabled(void)
>>  	((pte & BIT(PTE_PI_IDX_1)) >> (PTE_PI_IDX_1 - 1)) | \
>>  	((pte & BIT(PTE_PI_IDX_0)) >> (PTE_PI_IDX_0 - 0)))
>>  
>> +#define pte_po_index(pte)	((pte_val(pte) & PTE_PO_IDX_MASK) >> PTE_PO_IDX_SHIFT)
>> +
>>  /*
>>   * Page types used via Permission Indirection Extension (PIE). PIE uses
>>   * the USER, DBM, PXN and UXN bits to to generate an index which is used
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index d3b538be1500..41979c0e6c21 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -182,7 +182,7 @@ static inline bool por_el0_allows_pkey(u8 pkey, bool write, bool execute)
>>  	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
>>  #define pte_access_permitted(pte, write) \
>>  	(pte_access_permitted_no_overlay(pte, write) && \
>> -	por_el0_allows_pkey(FIELD_GET(PTE_PO_IDX_MASK, pte_val(pte)), write, false))
>> +	por_el0_allows_pkey(pte_po_index(pte), write, false))
>>  #define pmd_access_permitted(pmd, write) \
>>  	(pte_access_permitted(pmd_pte(pmd), (write)))
>>  #define pud_access_permitted(pud, write) \
> 
> kvm also uses PTE_PO_IDX_MASK in compute_s1_overlay_permissions(). Shouldn't we
> be converting that site too?

Just wanted to keep the KVM changes for later but sure, will fold these in.

> 
> ----8<----
> diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
> index 3a96c96816e9..d9a8ee8e600f 100644
> --- a/arch/arm64/kvm/at.c
> +++ b/arch/arm64/kvm/at.c
> @@ -1073,7 +1073,7 @@ static void compute_s1_overlay_permissions(struct kvm_vcpu
> *vcpu,
>  {
>         u8 idx, pov_perms, uov_perms;
> 
> -       idx = FIELD_GET(PTE_PO_IDX_MASK, wr->desc);
> +       idx = pte_po_index(__pte(wr->desc));
> 
>         switch (wi->regime) {
>         case TR_EL10:
> ----8<----

