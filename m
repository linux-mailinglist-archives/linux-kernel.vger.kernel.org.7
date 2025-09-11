Return-Path: <linux-kernel+bounces-811191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41986B525B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9858B581DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FEF192D8A;
	Thu, 11 Sep 2025 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cIooxd9+"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE5156661
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553638; cv=none; b=eotF+adQaAnEYC1anqkjApRemnJL+il8G4iGjIvoYJDZnIHL0fEFtrBe2gcNcoWSFGPbiabWaIHfNHling0KxadRIkKWmUk7hAAQC6T7ZMLjn8aver0SZ2R7pRiL5tONfZ3CD0SeCZSSh/Dl0y9FlTIk0flVfG1tpzhVdbRU75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553638; c=relaxed/simple;
	bh=aGORLcrMRhgNWkSIItxPR4CntL83+XM7IVwmg9r3A5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R2ESAwrZbj+7ao9izbAwNna0mcesI1+AEdWBQDSkDbvAvgq+TjwCjTtbyXncGE4VNTCqtK/fuan3bLibopOuviSE8k6jHcAZ1r8RdHJq+WP7TIaG6Dn4jyE5IjH9pcjMyxWJ15QTvAFpkAg6ATVZhQLtQf/kFjq43OiHV1rzWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cIooxd9+; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757553627; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=6rTAxnX2kPCvVjSV1Z9d0MDskdOa8h5diPJciFh9K6Q=;
	b=cIooxd9+XhIcjyWCh2Dj+hYnAHBNNNKEzyKkBlYcc7G6zHcHhp7m+idh7ywtfizedHOLx4yGxIIHA76EzcG/3qMvP4nxMx07H53HkArJ9fqSurdvxk24LCTWbT5P0LqXnFgCeCr4niSI0EOrdWHLq/gw/0xpNN5xI//Vva8HQuU=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wnjxwc0_1757553626 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Sep 2025 09:20:26 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,  James Morse
 <james.morse@arm.com>,  "Christoph Lameter (Ampere)" <cl@gentwo.org>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] arm64: tlbflush: Don't broadcast if mm was
 only active on local cpu
In-Reply-To: <dcc3b52d-0b86-47fc-8297-a6abc8af4c38@os.amperecomputing.com>
	(Yang Shi's message of "Wed, 10 Sep 2025 16:58:25 -0700")
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
	<20250829153510.2401161-3-ryan.roberts@arm.com>
	<dcc3b52d-0b86-47fc-8297-a6abc8af4c38@os.amperecomputing.com>
Date: Thu, 11 Sep 2025 09:20:25 +0800
Message-ID: <871podlr8m.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yang Shi <yang@os.amperecomputing.com> writes:

> Hi Ryan,
>
>
> On 8/29/25 8:35 AM, Ryan Roberts wrote:
>> There are 3 variants of tlb flush that invalidate user mappings:
>> flush_tlb_mm(), flush_tlb_page() and __flush_tlb_range(). All of these
>> would previously unconditionally broadcast their tlbis to all cpus in
>> the inner shareable domain.
>>
>> But this is a waste of effort if we can prove that the mm for which we
>> are flushing the mappings has only ever been active on the local cpu. In
>> that case, it is safe to avoid the broadcast and simply invalidate the
>> current cpu.
>>
>> So let's track in mm_context_t::active_cpu either the mm has never been
>> active on any cpu, has been active on more than 1 cpu, or has been
>> active on precisely 1 cpu - and in that case, which one. We update this
>> when switching context, being careful to ensure that it gets updated
>> *before* installing the mm's pgtables. On the reader side, we ensure we
>> read *after* the previous write(s) to the pgtable(s) that necessitated
>> the tlb flush have completed. This guarrantees that if a cpu that is
>> doing a tlb flush sees it's own id in active_cpu, then the old pgtable
>> entry cannot have been seen by any other cpu and we can flush only the
>> local cpu.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   arch/arm64/include/asm/mmu.h         | 12 ++++
>>   arch/arm64/include/asm/mmu_context.h |  2 +
>>   arch/arm64/include/asm/tlbflush.h    | 90 +++++++++++++++++++++++++---
>>   arch/arm64/mm/context.c              | 30 +++++++++-
>>   4 files changed, 123 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 6e8aa8e72601..ca32fb860309 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -17,6 +17,17 @@
>>   #include <linux/refcount.h>
>>   #include <asm/cpufeature.h>
>>   +/*
>> + * Sentinal values for mm_context_t::active_cpu. ACTIVE_CPU_NONE indicates the
>> + * mm has never been active on any CPU. ACTIVE_CPU_MULTIPLE indicates the mm
>> + * has been active on multiple CPUs. Any other value is the ID of the single
>> + * CPU that the mm has been active on.
>> + */
>> +enum active_cpu {
>> +	ACTIVE_CPU_NONE = UINT_MAX,
>> +	ACTIVE_CPU_MULTIPLE = UINT_MAX - 1,
>> +};
>> +
>>   typedef struct {
>>   	atomic64_t	id;
>>   #ifdef CONFIG_COMPAT
>> @@ -26,6 +37,7 @@ typedef struct {
>>   	void		*vdso;
>>   	unsigned long	flags;
>>   	u8		pkey_allocation_map;
>> +	unsigned int	active_cpu;
>
> Any reason why you don't use bit mask to mark the active CPUs? And
> mm_struct also has cpu_bitmap to record the active CPUs which the
> process has run on. Why not just use it? x86 uses it to determine
> which CPUs kernel should send TLB flush IPI to. I understand this
> series just check whether local cpu is the active cpu or not, but bit
> mask should not make things more complicated. And it also can provide
> more flexibility. We can extend this, for example, use IPI to send
> local TLB flush if the number of active cpus is quite low. AFAIK, x86
> added TLBI broadcast support too, and fallback to IPI if the number of
> active cpus is <= 3. IIRC, Christohper's series did the similar
> thing. He should be interested in this series too, cc'ed him.

Agree!  One possible disadvantage of this series is that the benefit
will gone after the process is migrated to another CPU.  This is quite
common if the process isn't bound to a CPU on a system without many
CPUs.  A cpumask will be helpful for this situation.

>
>>   } mm_context_t;
>>     /*

[snip]

---
Best Regards,
Huang, Ying

