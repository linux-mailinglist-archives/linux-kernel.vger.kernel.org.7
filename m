Return-Path: <linux-kernel+bounces-871173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1448C0C93E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E80D24F13A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDE92FB0A5;
	Mon, 27 Oct 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SXI77pie"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE762FABE3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555817; cv=none; b=uxLTD8/zqdUgSA9DtKh972+7PZFX3CWaPr2vX8RYDD7PWxbWVECS8t3f3M9FnZKhEm+e8ocoGNDXZSDqGoWRHZPzzEkWT6qaWvKK5+rQRB4gDUyR7WjLaMGUqP1jOmKKSCwbdDADy40+mVdY6ouQQ6imSBcxBdLblH8nUcpaWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555817; c=relaxed/simple;
	bh=88+iBNZgvVpyohQ9kPzFpsIXI4y2JOvGnxidYf7LqAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFDLUizLZEvE6znDSCgzoihVdDnfFyUCqzAMV5UxhHDPMZTJCgfVtgtZeiczQ9RJSuux7jAbQRyqQRXgZYumc5Tkxa133pxg4TuOjX0hkY6ViFueQQ9+NsMiQg6lJiVt7yLTKXjueWVUIbiXhuCbDfUgCOaR4U4UTym3V64BVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SXI77pie; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bbadcbfa-0250-4d53-975e-97b81559c6ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761555812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lV8YyUI50b9YTzBcIMKZgPznygfBMpGKiWQNdsbpj0o=;
	b=SXI77pieU9uobUn+uaGz12VeYJLIB8q+z5LXhhnSmvbtcqjcLAupoE56fQ6yyy/zD+RCXp
	0TcGiSKcLO8IuwWlvFsoK3fGn3qdNwM2DryuFyrejF81na/PPHQi7m476EIvr7z4TYp/7R
	sl3s7OAZ8xOGeh9E/aEq96cG+CNFdUM=
Date: Mon, 27 Oct 2025 17:02:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v12 mm-new 03/15] khugepaged: generalize
 hugepage_vma_revalidate for mTHP support
Content-Language: en-US
To: Nico Pache <npache@redhat.com>
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 linux-kernel@vger.kernel.org, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 vbabka@suse.cz, rppt@kernel.org, jannh@google.com, pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-4-npache@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251022183717.70829-4-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/23 02:37, Nico Pache wrote:
> For khugepaged to support different mTHP orders, we must generalize this
> to check if the PMD is not shared by another VMA and that the order is
> enabled.
> 
> No functional change in this patch. Also correct a comment about the
> functionality of the revalidation.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>   mm/khugepaged.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 36e31d99e507..6cf8700823f9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -893,14 +893,13 @@ static int collapse_find_target_node(struct collapse_control *cc)
>   
>   /*
>    * If mmap_lock temporarily dropped, revalidate vma
> - * before taking mmap_lock.
> + * after taking the mmap_lock again.
>    * Returns enum scan_result value.
>    */
>   
>   static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> -				   bool expect_anon,
> -				   struct vm_area_struct **vmap,
> -				   struct collapse_control *cc)
> +		bool expect_anon, struct vm_area_struct **vmap,
> +		struct collapse_control *cc, unsigned int order)
>   {
>   	struct vm_area_struct *vma;
>   	enum tva_type type = cc->is_khugepaged ? TVA_KHUGEPAGED :
> @@ -913,15 +912,16 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>   	if (!vma)
>   		return SCAN_VMA_NULL;
>   
> +	/* Always check the PMD order to ensure its not shared by another VMA */
>   	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>   		return SCAN_ADDRESS_RANGE;
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER))
> +	if (!thp_vma_allowable_orders(vma, vma->vm_flags, type, BIT(order)))
>   		return SCAN_VMA_CHECK;
>   	/*
>   	 * Anon VMA expected, the address may be unmapped then
>   	 * remapped to file after khugepaged reaquired the mmap_lock.
>   	 *
> -	 * thp_vma_allowable_order may return true for qualified file
> +	 * thp_vma_allowable_orders may return true for qualified file
>   	 * vmas.
>   	 */
>   	if (expect_anon && (!(*vmap)->anon_vma || !vma_is_anonymous(*vmap)))
> @@ -1117,7 +1117,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   		goto out_nolock;
>   
>   	mmap_read_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
> +					 HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED) {
>   		mmap_read_unlock(mm);
>   		goto out_nolock;
> @@ -1151,7 +1152,8 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	 * mmap_lock.
>   	 */
>   	mmap_write_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc,
> +					 HPAGE_PMD_ORDER);
>   	if (result != SCAN_SUCCEED)
>   		goto out_up_write;
>   	/* check if the pmd is still valid */
> @@ -2792,7 +2794,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   			mmap_read_lock(mm);
>   			mmap_locked = true;
>   			result = hugepage_vma_revalidate(mm, addr, false, &vma,
> -							 cc);
> +							 cc, HPAGE_PMD_ORDER);
>   			if (result  != SCAN_SUCCEED) {
>   				last_fail = result;
>   				goto out_nolock;


