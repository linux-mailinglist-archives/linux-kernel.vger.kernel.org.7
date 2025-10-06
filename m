Return-Path: <linux-kernel+bounces-842594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D52BBD189
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D4633489C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E2192D68;
	Mon,  6 Oct 2025 06:07:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A4DB661
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759730876; cv=none; b=FAwKv8eHRT/3Ss+TgMfR1C3zzvaDksCnHyjOQkNpU7oXx64v6OD+eFrS9vaSs9i0XDNm8/J1JWvZglSOabeNfiA92W7Zi2ifdJtn8I0p86PUtKFSqegyii54B7Lg5oxasf8p1njttNYEVWyGXMLjYtIYVkGy2e6V6M8emO986pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759730876; c=relaxed/simple;
	bh=wanpqYJKgkTOItfG6dUIGsO9Tb0evSs7UlMQBwxDWBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kn0w+OjFIqtdDvIzuPZuf8+9zwMjhump9F7BKxkwvxmYOyySxhAaKMaI65BeC9IrfbwpVMHF8WRudwGyuFXnWBSZIVkjZkp+YlW0IuX2g3GcYyqwX/kHmcJ2A0ii3r36w++K8d9HmJ1fNL0Di9MzrLLmGk/f6Azq4mon9piKZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8227150C;
	Sun,  5 Oct 2025 23:07:45 -0700 (PDT)
Received: from [10.163.66.9] (unknown [10.163.66.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAE873F59E;
	Sun,  5 Oct 2025 23:07:51 -0700 (PDT)
Message-ID: <4b513d32-7795-4998-98df-d398c3d5462a@arm.com>
Date: Mon, 6 Oct 2025 11:37:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/dirty: Replace READ_ONCE() with pudp_get()
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20251006055214.1845342-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251006055214.1845342-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/10/25 11:22 am, Anshuman Khandual wrote:
> Replace READ_ONCE() with a standard page table accessor i.e pudp_get() that
> anyways defaults into READ_ONCE() in cases where platform does not override
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   mm/mapping_dirty_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
> index c193de6cb23a..737c407f4081 100644
> --- a/mm/mapping_dirty_helpers.c
> +++ b/mm/mapping_dirty_helpers.c
> @@ -149,7 +149,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
>   			      struct mm_walk *walk)
>   {
>   #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> -	pud_t pudval = READ_ONCE(*pud);
> +	pud_t pudval = pudp_get(pud);
>   
>   	/* Do not split a huge pud */
>   	if (pud_trans_huge(pudval)) {

Talking about mm, why not also make changes for these READ_ONCE accesses
in gup, hmm, memory, mprotect, sparse-vmemmap?


