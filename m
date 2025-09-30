Return-Path: <linux-kernel+bounces-837104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA6BAB624
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E747B3BC695
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3292248B9;
	Tue, 30 Sep 2025 04:37:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED1834BA40
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759207055; cv=none; b=Rj7072pvwSKl5qh0kAK8sPWPtVmDTjJvQQAEUMoUDixecgCEHFqnqZCLcrMsSfWLkSHt1Z6eu9yAQZa6h6cFnaWpwQLmBJAO/ID87oRJolDSjuTCJl7PukfWUt+L23Prouad1mYvF3dJT1WOI1bFnldkljWDhpQREwwf80HG5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759207055; c=relaxed/simple;
	bh=aeM0tY+ssUPKgRJ4qM3x6rsw12MW39dIMfJPzlwWKfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXsqEDPqEgYP7029aEOc+Lrf5I22txF2m432AdVBKRZklraj0RJ0hH2mCJAjBsCi4QGiejhwlUW0E8H/4pGazqOc8R7ieH+LTGajmfdkJbbP29vLZRrTzklsbzlXdTRmDHloyPxzDiRHac42pcPNxyUSbnXfz9Ld75rzdPaLNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1D331424;
	Mon, 29 Sep 2025 21:37:23 -0700 (PDT)
Received: from [10.164.18.53] (MacBook-Pro.blr.arm.com [10.164.18.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 433023F66E;
	Mon, 29 Sep 2025 21:37:29 -0700 (PDT)
Message-ID: <9736fd6a-8987-4b10-9b05-e03106463c34@arm.com>
Date: Tue, 30 Sep 2025 10:07:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ptdump: Replace READ_ONCE() with standard page table
 accessors
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20250930025246.1143340-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250930025246.1143340-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 30/09/25 8:22 am, Anshuman Khandual wrote:
> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
> anyways default into READ_ONCE() in cases where platform does not override.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   mm/ptdump.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index b600c7f864b8..18861501b533 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -31,7 +31,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
>   			    unsigned long next, struct mm_walk *walk)
>   {
>   	struct ptdump_state *st = walk->private;
> -	pgd_t val = READ_ONCE(*pgd);
> +	pgd_t val = pgdp_get(pgd);
>   
>   #if CONFIG_PGTABLE_LEVELS > 4 && \
>   		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
> @@ -54,7 +54,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
>   			    unsigned long next, struct mm_walk *walk)
>   {
>   	struct ptdump_state *st = walk->private;
> -	p4d_t val = READ_ONCE(*p4d);
> +	p4d_t val = p4dp_get(p4d);
>   
>   #if CONFIG_PGTABLE_LEVELS > 3 && \
>   		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
> @@ -77,7 +77,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
>   			    unsigned long next, struct mm_walk *walk)
>   {
>   	struct ptdump_state *st = walk->private;
> -	pud_t val = READ_ONCE(*pud);
> +	pud_t val = pudp_get(pud);
>   
>   #if CONFIG_PGTABLE_LEVELS > 2 && \
>   		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
> @@ -100,7 +100,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
>   			    unsigned long next, struct mm_walk *walk)
>   {
>   	struct ptdump_state *st = walk->private;
> -	pmd_t val = READ_ONCE(*pmd);
> +	pmd_t val = pmdp_get(pmd);

I believe this should go through pmdp_get_lockless(). I can see in pgtable.h that
some magic is required on some arches to decode the pmd correctly in case walking
without locks.

Reviewed-by: Dev Jain <dev.jain@arm.com>



