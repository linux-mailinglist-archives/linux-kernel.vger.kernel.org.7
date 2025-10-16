Return-Path: <linux-kernel+bounces-855787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C92EEBE24FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 948054F9736
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265B23161AD;
	Thu, 16 Oct 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Snl+kGbU"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911929C323
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605933; cv=none; b=YsT5OUxqD88Iki74hybEBbbDUwrC2RTwov/rlnjil+s9TKO3VGG11DAgxV9NSRDl3roGBpdrunfRv+mDcfMgdIiahi66YWkQGkflNVm/2XWxl10wLgTIldjgpLIhIumSrL+8/mWHebYcCwsFZvs6clSPsLjvwlKmZUQ7S3Ay6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605933; c=relaxed/simple;
	bh=76/qTp2LLY7E/n5OGiql3qCuNp8iwug83W1yS/8TCQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S7kd+6E8RVNunaPjwBML1qVZ/AosWt9EoXJ1N2bKnGu7yA1bTPDUEICwBr9FasLjIGUyNmoqUthQ7x8Y+tX/S0ebf8ThS2IMp6rNvw7TmCtupyGaP4CuWDY2zJjUNXsmELECLY38tegECJI72DjjkDZgmkOia6mENfYr0xUnXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Snl+kGbU; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760605928; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=fgeHUBnnzn4F0XCj9WH4FTp3VMCD901IrDDVgd7Moos=;
	b=Snl+kGbUrO5YQeWS29XK8USkMp0cRBiOJnktoTDqiQagezzPzH+eja3Fkwhm81TIwrPvHXWpBVJZ3GCNsjJ4RJaEsKm2FYYQ5RvUUyS/sACmQaOFv7N3cTvBJQwCfQJJ+GGlwmnmVFpDH9jsHoKGWZSIm/Ifo93IKxoD0dIASV8=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqJqvSn_1760605925 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 17:12:06 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Vlastimil Babka <vbabka@suse.cz>,  Zi Yan
 <ziy@nvidia.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>,  Ryan
 Roberts <ryan.roberts@arm.com>,  Yang Shi <yang@os.amperecomputing.com>,
  "Christoph Lameter (Ampere)" <cl@gentwo.org>,  Dev Jain
 <dev.jain@arm.com>,  Barry Song <baohua@kernel.org>,  Anshuman Khandual
 <anshuman.khandual@arm.com>,  Yicong Yang <yangyicong@hisilicon.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Kevin Brodsky
 <kevin.brodsky@arm.com>,  Yin Fengwei <fengwei_yin@linux.alibaba.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH -v2 1/2] mm: add spurious fault fixing support for huge pmd
In-Reply-To: <3fc642be-b8f3-4fcb-b13c-3359cd52e921@lucifer.local> (Lorenzo
	Stoakes's message of "Thu, 16 Oct 2025 09:25:12 +0100")
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com>
	<20251013092038.6963-2-ying.huang@linux.alibaba.com>
	<4c453dcc-2837-4f1a-905b-3462270f5e31@lucifer.local>
	<87ldlcpnbx.fsf@DESKTOP-5N7EMDA>
	<d748bc6b-2aff-4cee-a233-008f4d2555fa@lucifer.local>
	<87bjm7lh4u.fsf@DESKTOP-5N7EMDA>
	<3fc642be-b8f3-4fcb-b13c-3359cd52e921@lucifer.local>
Date: Thu, 16 Oct 2025 17:12:04 +0800
Message-ID: <87o6q7i523.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:

> On Thu, Oct 16, 2025 at 10:22:57AM +0800, Huang, Ying wrote:
>> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:
>>
>> > On Wed, Oct 15, 2025 at 04:43:14PM +0800, Huang, Ying wrote:
>> > OK this is great, let's put it all in the kdoc for the new shared spurious
>> > faulting function! :) and additionally add it to the commit message.
>>
>> Sure.  Will do it in the next version.
>
> Thanks!
>
>>
>> [snip]
>>
>> >> >>
>> >> >> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> >> >> index 32e8457ad535..341622ec80e4 100644
>> >> >> --- a/include/linux/pgtable.h
>> >> >> +++ b/include/linux/pgtable.h
>> >> >> @@ -1232,6 +1232,10 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>> >> >>  #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
>> >> >>  #endif
>> >> >>
>> >> >> +#ifndef flush_tlb_fix_spurious_fault_pmd
>> >> >> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, ptep) do { } while (0)
>> >> >> +#endif
>> >> >
>> >> > flush_tlb_fix_spurious_fault(), when the arch doesn't declare it, defaults to
>> >> > flush_tlb_page() - why do we just do nothing in this case here?
>> >>
>> >> Because all architectures do nothing for the spurious PMD page fault
>> >> fixing until the [2/2] of this series.  Where, we make it necessary to
>> >> flush the local TLB for spurious PMD page fault fixing on arm64
>> >> architecture.
>> >>
>> >> If we follow the design of flush_tlb_fix_spurious_fault(), we need to
>> >> change all architecture implementation to do nothing in this patch to
>> >> keep the current behavior.  I don't think that it's a good idea.  Do
>> >> you agree?
>> >
>> > Yeah probably we should keep the same behaviour as before, which is
>> > obviously, prior to this series, we did nothing.
>> >
>> > I guess in the PTE case we _always_ want to flush the TLB, whereas in the
>> > PMD case we otherwise don't have any need to at the point at which the
>> > spurious flush is performed.
>> >
>> > But from your explanation above re: the stale TLB entry this _only_ needs
>> > to be done for architectures which might encounter this problem rather than
>> > needing a TLB flush in general.
>> >
>> > Given we're generalising the code and one case always flushes the TLB and
>> > the other doesn't maybe it's worth putting a comment in the generalised
>> > function mentioning this?
>>
>> I'm not sure whether it's a good idea to document architecture behaviors
>> in the general code.  The behavior may be changed architecture by
>> architecture in the future.
>
> Right, but we are unconditionaly doing a TLB flush in the PTE case but not PMD
> so let's document that to be clear :)

Sure.  Will do this.

>>
>> [snip]

---
Best Regards,
Huang, Ying

