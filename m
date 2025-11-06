Return-Path: <linux-kernel+bounces-887584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C23C38A73
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E532C3B5CC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023531FFC48;
	Thu,  6 Nov 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="egzIug9j"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896261ACEAF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390906; cv=none; b=sNBfDT4YoISw0U7+sLKFwxKErmSl+n22UOXVxRWBGP5gBuaeVf8cia60XwIMluKpNvsPGCDckA95tLB4qBQCTC+lIDiKr8oSxdTcncoUW8e+KEgGC+BvFHjfQAyR8em5e8fhRySlBDmcmro+dDzvgLweU40DP9ChuhRMVexhmFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390906; c=relaxed/simple;
	bh=ps6wg7aadJM3o6E8oY3oxuBvGN7GlU/ysa6dlKasb1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VEb1o5pB8k17XGW1w+qphagP6WbzeOoJE6zTzsU/Mq5tqAN+6vkXjal1tSK/QGoTtxgcEPC3qj+Km0JEyhXvpfhEHD0QItv+GT1v133UI3YR5dXsOYPE/RyLITlPIPRR7dYRbGU3LnjFVSneTHyKnbW61WA/l/PcwC0i3g8ln5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=egzIug9j; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762390886; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=r6I0TYY3j79BQpKPB1Cj7u8E0I09XzskLvOBfRvxEFM=;
	b=egzIug9jy80entm/RTk+M5jaJv2MHtLd7D+4hNuYYwDnJ7voxocXNO0d/V/rpeHRY0c4tQAIoiua6EJJq2Kkrx39YJ8JX0vBy9cReiLfJIjEHtHDvQsyPcQnKyu+2CcXZ9yMC3v8UB8mDkziplqUNxU8GVabJhfyxj57SRPUa+Y=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WrnG5nF_1762390876 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Nov 2025 09:01:25 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,
  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  Vlastimil Babka
 <vbabka@suse.cz>,  Zi Yan <ziy@nvidia.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  Yang Shi <yang@os.amperecomputing.com>,  "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,  Dev Jain <dev.jain@arm.com>,  Barry Song
 <baohua@kernel.org>,  Anshuman Khandual <anshuman.khandual@arm.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Kevin Brodsky
 <kevin.brodsky@arm.com>,  Yin Fengwei <fengwei_yin@linux.alibaba.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH -v4 0/2] arm, tlbflush: avoid TLBI broadcast if page
 reused in write fault
In-Reply-To: <20251104095516.7912-1-ying.huang@linux.alibaba.com> (Huang
	Ying's message of "Tue, 4 Nov 2025 17:55:14 +0800")
References: <20251104095516.7912-1-ying.huang@linux.alibaba.com>
Date: Thu, 06 Nov 2025 09:01:15 +0800
Message-ID: <87ms509dpg.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Huang Ying <ying.huang@linux.alibaba.com> writes:

> This series is to optimize the system performance via avoiding TLBI
> broadcast if page is reused in the write protect fault handler.  More
> details of the background and the test results can be found in [2/2].
>
> Changelog:
>
> v4:
>
> - Collected Reviewed-by and Acked-by, Thanks Lorenzo, David, Ryan, and
>   Barry.
>
> v3:
>
> - Various code cleanup and improved design and document in [1/2],
>   Thanks Lorenzo and David's comments!
> - Fixed a typo and improved function interface in [2/2], Thanks Ryan's
>   comments!
>
> v2:
>
> - Various code cleanup in [1/2], Thanks David's comments!
> - Remove unnecessary __local_flush_tlb_page_nosync() in [2/2], Thanks Ryan's comments!
> - Add missing contpte processing, Thanks Rayn and Catalin's comments!
>
> Huang Ying (2):
>   mm: add spurious fault fixing support for huge pmd
>   arm64, tlbflush: don't TLBI broadcast if page reused in write fault
>
>  arch/arm64/include/asm/pgtable.h  | 14 ++++---
>  arch/arm64/include/asm/tlbflush.h | 56 ++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c           |  3 +-
>  arch/arm64/mm/fault.c             |  2 +-
>  include/linux/huge_mm.h           |  2 +-
>  include/linux/pgtable.h           |  4 ++
>  mm/huge_memory.c                  | 33 ++++++++++------
>  mm/internal.h                     |  2 +-
>  mm/memory.c                       | 62 +++++++++++++++++++++++--------
>  9 files changed, 140 insertions(+), 38 deletions(-)

Hi, Catalin,

Do you have time to take a look at this series?  Are there some remain
issues?

---
Best Regards,
Huang, Ying

