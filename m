Return-Path: <linux-kernel+bounces-853614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F81BDC1C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20653A4583
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993C730597E;
	Wed, 15 Oct 2025 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VvaFYJk6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7551DED64
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494157; cv=none; b=LN7iaUH3+REW8HXyhQvY6sk96VAhzo+VjCyUmSfBUkTEICji8ab+XLa/W9x0jOJiylsrrVFfxcsgP+ikbLJ5vWgLsMx4t1ZBv7covAxkUSGU3T0vRc8FUcc6MzohLGDwnBgjG6y/y/08dGLJGpDSW0vdYdrV++Jme5EQXtslWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494157; c=relaxed/simple;
	bh=QxXNkXYZ6ONgbk8YHR/mLJATVtR3hsrJ93KLwJeDotk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e4zKLZN/F/9KJVKRLgnELla1p2riD2pRdJWARYQkyz0azpq462y8N0hAj2VDk9C9ahtykhLkV+Ji7ivSbbpkS8wXuPaB6qkC6b5CciLE19GYNchJ7pW4BuhG+zJrt4ICpgSR4E9spMAQihcEvrwjGWgDR9iB9gnTs6+pq7raic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VvaFYJk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E370BC4CEF1;
	Wed, 15 Oct 2025 02:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760494157;
	bh=QxXNkXYZ6ONgbk8YHR/mLJATVtR3hsrJ93KLwJeDotk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VvaFYJk6gzu/SrmA09X4ZSzC66zDqCpQdKMerjfFF8ltzZcGubm1Fi6hqS8PSalnU
	 /cJIQJUAUZKfTqzO2x6UAcOcfbBsNE5cUJzXeH15YV6aVonxi5xT3DBuu3ZGeXZb9g
	 JJrJtkPMyBeinuZzO/aSs8L1QZXoYELYABRGGdYk=
Date: Tue, 14 Oct 2025 19:09:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yadong Qi <yadong.qi@linux.alibaba.com>
Cc: urezki@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ying.huang@linux.alibaba.com, dan.carpenter@linaro.org, kernel test robot
 <lkp@intel.com>, Huang Ying <ying.huang@linux.alibaba.com>, Dev Jain
 <dev.jain@arm.com>, Uladzislau Rezki (Sony) <urezki@gmail.com>
Subject: Re: [PATCH] mm: vmalloc: fix uninitialized value issue
Message-Id: <20251014190916.e9285e8ac6a8301cdacd9fe8@linux-foundation.org>
In-Reply-To: <20251014102337.5453-1-yadong.qi@linux.alibaba.com>
References: <20251014102337.5453-1-yadong.qi@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 18:23:37 +0800 Yadong Qi <yadong.qi@linux.alibaba.com> wrote:

> Issues reported by LKP:
>   mm/vmalloc.c:191 vmap_pmd_range() error: uninitialized symbol 'err'.
>   mm/vmalloc.c:243 vmap_pud_range() error: uninitialized symbol 'err'.
>   mm/vmalloc.c:295 vmap_p4d_range() error: uninitialized symbol 'err'.
> 
> Fix by initailizing err with 0.

This fixes warnings which were introduced by mm.git's recent "mm:
vmalloc: WARN_ON if mapping size is not PAGE_SIZE aligned".  Please do
point out such details.

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -170,7 +170,7 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  {
>  	pmd_t *pmd;
>  	unsigned long next;
> -	int err;
> +	int err = 0;
>  
>  	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
>  	if (!pmd)

So we get the below:

: static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
: 			phys_addr_t phys_addr, pgprot_t prot,
: 			unsigned int max_page_shift, pgtbl_mod_mask *mask)
: {
: 	pmd_t *pmd;
: 	unsigned long next;
: 	int err = 0;
: 
: 	pmd = pmd_alloc_track(&init_mm, pud, addr, mask);
: 	if (!pmd)
: 		return -ENOMEM;
: 	do {
: 		next = pmd_addr_end(addr, end);
: 
: 		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot,
: 					max_page_shift)) {
: 			*mask |= PGTBL_PMD_MODIFIED;
: 			continue;
: 		}
: 
: 		err = vmap_pte_range(pmd, addr, next, phys_addr, prot, max_page_shift, mask);
: 		if (err)
: 			break;
: 	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
: 	return err;
: }

If every single pmd fails vmap_try_huge_pmd() then this function
returns zero, indicating success.  Is this behavior correct and
desirable?

