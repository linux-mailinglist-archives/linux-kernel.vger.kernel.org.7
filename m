Return-Path: <linux-kernel+bounces-740735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97FB0D860
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C6AAA4E68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73622E3397;
	Tue, 22 Jul 2025 11:38:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E512E2F1C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184283; cv=none; b=UIJ9Qmtbsny1n+SpZw9BTRRQ5dmEk5L04Bh9KTaOrkfIZU5okBqOQqViGrod7Bcv8EV87SpcepgywksdrybQnyFsK+diiYdRh3tMYF8cLNObaie7d+RYhUHRS1N52HKmvhW7Ns7vlOvIG9Wr5rDTlEIbtOfnZlXau2Bmkf3nGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184283; c=relaxed/simple;
	bh=O7dV4Fo3MDBZoBMUb0U5snvvyOSp/rzRYC/FsUwwoyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLe2iG+PXw5grxRcnBhlDp1PuCCe9zcfcHic4UeeFerGiQDKFIDU9IE+c0AwHAGeqRar5FlO0hRBnafv7YYSFFFjT0OcPRyZUihVzeXdoNIu3B+opkOiUsf6mzXFclvXslGkcqGFx9w6iHOee4o9XRDN49gMllC4VDeRjHjEV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 852BF152B;
	Tue, 22 Jul 2025 04:37:54 -0700 (PDT)
Received: from [10.1.30.167] (XHFQ2J9959.cambridge.arm.com [10.1.30.167])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C77853F6A8;
	Tue, 22 Jul 2025 04:37:56 -0700 (PDT)
Message-ID: <ac0b2fcd-6f90-4802-be46-dc1c20d55d2e@arm.com>
Date: Tue, 22 Jul 2025 12:37:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] mm: Introduce FPB_RESPECT_WRITE for PTE batching
 infrastructure
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
 joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-5-dev.jain@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250718090244.21092-5-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2025 10:02, Dev Jain wrote:
> Patch 6 optimizes mprotect() by batch clearing the ptes, masking in the new
> protections, and batch setting the ptes. Suppose that the first pte
> of the batch is writable - with the current implementation of
> folio_pte_batch(), it is not guaranteed that the other ptes in the batch
> are already writable too, so we may incorrectly end up setting the
> writable bit on all ptes via modify_prot_commit_ptes().
> 
> Therefore, introduce FPB_RESPECT_WRITE so that all ptes in the batch
> are writable or not.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/internal.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 5b0f71e5434b..28d2d5b051df 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -208,17 +208,20 @@ typedef int __bitwise fpb_t;
>  /* Compare PTEs respecting the soft-dirty bit. */
>  #define FPB_RESPECT_SOFT_DIRTY		((__force fpb_t)BIT(1))
>  
> +/* Compare PTEs respecting the writable bit. */
> +#define FPB_RESPECT_WRITE		((__force fpb_t)BIT(2))
> +
>  /*
>   * Merge PTE write bits: if any PTE in the batch is writable, modify the
>   * PTE at @ptentp to be writable.
>   */
> -#define FPB_MERGE_WRITE			((__force fpb_t)BIT(2))
> +#define FPB_MERGE_WRITE			((__force fpb_t)BIT(3))
>  
>  /*
>   * Merge PTE young and dirty bits: if any PTE in the batch is young or dirty,
>   * modify the PTE at @ptentp to be young or dirty, respectively.
>   */
> -#define FPB_MERGE_YOUNG_DIRTY		((__force fpb_t)BIT(3))
> +#define FPB_MERGE_YOUNG_DIRTY		((__force fpb_t)BIT(4))
>  
>  static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>  {
> @@ -226,7 +229,9 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>  		pte = pte_mkclean(pte);
>  	if (likely(!(flags & FPB_RESPECT_SOFT_DIRTY)))
>  		pte = pte_clear_soft_dirty(pte);
> -	return pte_wrprotect(pte_mkold(pte));
> +	if (likely(!(flags & FPB_RESPECT_WRITE)))
> +		pte = pte_wrprotect(pte);
> +	return pte_mkold(pte);
>  }
>  
>  /**


