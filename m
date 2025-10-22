Return-Path: <linux-kernel+bounces-864350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758A9BFA948
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4C5561EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A92F8BC9;
	Wed, 22 Oct 2025 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Je40si7c"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAD279331
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118431; cv=none; b=Defvbi1V+lHExU1Nuc9TAbZ1FkgWA6APXqjS4ElX0mobrcEiWoSU+K/yGDx/84QgKjB/0Y9cGdcVcgrPhKqJndZ149wjB+tmZptPwuOZvz8USGi4AsdwoNEXXH1NXc/9ZYVYFRoCDpu0n/q0GqWZwerKOLcZY4u1zXPmfMFEvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118431; c=relaxed/simple;
	bh=fpzR07Si4HhcygrOtPOt31dRvS0JUA8Nf2VgISWxjJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHZqTB7SMqof24y7mpHBNlkCxRq1XoAQ51ST5OCejwfXJH/xkgzp55yNnRksMXewovHSpAKciW+4WkHJ6cVjQ4Lw4elV7qUfbucoSyS7jDpqiQTifwVHMH+/HLGhu5xbtwl76oMDb+AVLgjtZKLYClBL6cR497vfMG2y9QAsGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Je40si7c; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761118417; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=CqsGVZ4SyFVwjVPf+wFK4DLy89I6GDvi6h9PlM5oYdg=;
	b=Je40si7caHoMlCWxRAp4a2jLr6vxM21PxWWfisTnD9mubCzhfYc4fuYkHya00IKwoJakL4fn17zUv61dvdcE7+GWgjtFrIiifm8Pjh4ffkazl60vkaNv+Muc0wy+faJ5Fu72l95vQvQ1m9HZHmlazIqmqHWNjf30NORAoj3qTaU=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wqm1la1_1761118416 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 15:33:36 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  David
 Hildenbrand <david@redhat.com>,  linux-kernel@vger.kernel.org,  Catalin
 Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH V2] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma()
 tests
In-Reply-To: <20251022032951.3498553-1-anshuman.khandual@arm.com> (Anshuman
	Khandual's message of "Wed, 22 Oct 2025 04:29:51 +0100")
References: <20251022032951.3498553-1-anshuman.khandual@arm.com>
Date: Wed, 22 Oct 2025 15:33:35 +0800
Message-ID: <87ecqve6gg.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> Add some [pte|pmd]_mkwrite_novma() relevant tests.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@linux.alibaba.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> These tests clear on arm64 platform after the following recent patch.
>
> https://lore.kernel.org/all/20251015023712.46598-1-ying.huang@linux.alibaba.com/
>
> Changes in V2:
>
> - Added a new test combination per Huang
>
> Changes in V1:
>
> https://lore.kernel.org/all/20251021024424.2390325-1-anshuman.khandual@arm.com/
>
>  mm/debug_vm_pgtable.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 830107b6dd08..def344bb4a32 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -102,6 +102,12 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>  	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>  	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>  	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
> +
> +	WARN_ON(!pte_dirty(pte_mkwrite_novma(pte_mkdirty(pte))));
> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
> +	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));

Why do you use

pte_mkwrite_novma(pte)

instead of

pte_mkwrite(pte, args->vma)

?

> +	WARN_ON(!pte_write(pte_mkwrite_novma(pte_wrprotect(pte))));
> +	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite_novma(pte))));
>  }
>  
>  static void __init pte_advanced_tests(struct pgtable_debug_args *args)
> @@ -195,6 +201,12 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>  	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
>  	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
>  	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
> +
> +	WARN_ON(pmd_dirty(pmd_mkwrite_novma(pmd_mkclean(pmd))));
> +	WARN_ON(!pmd_write(pmd_mkdirty(pmd_mkwrite_novma(pmd))));
> +	WARN_ON(!pmd_write(pmd_mkwrite_novma(pmd_wrprotect(pmd))));
> +	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite_novma(pmd))));
> +
>  	/*
>  	 * A huge page does not point to next level page table
>  	 * entry. Hence this must qualify as pmd_bad().

---
Best Regards,
Huang, Ying

