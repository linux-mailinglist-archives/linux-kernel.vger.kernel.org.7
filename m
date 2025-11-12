Return-Path: <linux-kernel+bounces-896720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D569C510D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D437F4EEE19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDFF2DC34B;
	Wed, 12 Nov 2025 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdQrzR3v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA5257824
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934711; cv=none; b=PYI5z1WDvDWSqb2S6s4lJ5Gwv7/9NOzcZsL6yisw1thF2OwTgRC8T5nzYsPjWtnDc0ELM8LcvSdN/uPsLEsoePtyv+B7b4C69ybDM++QU1AIshCQBvRmkUd8YcAoS0WWAqeDhxhvxdai/muX0NZsPcpF6iXQFXf1FP32RtGZtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934711; c=relaxed/simple;
	bh=SA7i33ysWzPDlrhtd68Z/egkmmkPzs0rHOKGyx4PbTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLsD3qSZy6e6FIa0dIj8UeC1U7JKhAVLRp9Wi+ttWEw1MYJiHLURCXtdi4tysRWAl2k8r6PFbhfx+7NFySAxLQ35oWe4pMjuv6ySLdG4ZqUOq37WIvqMyaujFNssd7oIzoByxMzG+m2kuAWdJt0DUInDXLoej3EqqMvXGe7K7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdQrzR3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89486C16AAE;
	Wed, 12 Nov 2025 08:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762934711;
	bh=SA7i33ysWzPDlrhtd68Z/egkmmkPzs0rHOKGyx4PbTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KdQrzR3vf+z1dXt8moVE4lWL0xR6YvwRPceeAI609o8bZcg0tfarInopUZdeROePM
	 MzbHN7CuSrgHjf2d6E3N34UssO7AdaZLpXc8x8qV6la0CuoHkV7BzW0wYqy9vWsEnN
	 zqrejZxeQWsmg03EZUrEmhytog3MWalbPNdPhzfB1sCQxBENXv1srgxqZQCWyq+gGd
	 r/pL0Dvss93HZcQ0j/doy+dMk09NmRk76+wCr1wofTRm5EPDthGgzViu61q2QtSpms
	 cbCmjww2cTrehhj0y7cvy1PYaAD88KbMJc1mMg61gXLcdtgzfpTs9XXtytuFksal/V
	 U26qPyjAo2dzQ==
Message-ID: <7b78c1d8-9efc-4570-8f4c-244af665a159@kernel.org>
Date: Wed, 12 Nov 2025 09:05:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: fix handling of zero page in follow_page_pte()
To: peng8420.li@gmail.com, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: osalvador@suse.de, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
 linux-kernel@vger.kernel.org, dan.j.williams@intel.com
References: <20251112072424.125514-1-peng8420.li@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251112072424.125514-1-peng8420.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.25 08:24, peng8420.li@gmail.com wrote:
> From: "peng8420.li" <peng8420.li@gmail.com>
> 
> In some scenarios, `__vm_normal_page` might return NULL.
> In this case, if `is_zero_pfn(pte_pfn(pte))` is true, simply return `page = pte_page(pte)`;
> no further folio processing is needed.
> 
> Signed-off-by: peng8420.li <peng8420.li@gmail.com>
> ---
>   mm/gup.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 95d948c8e86c..60ae5f0c20e0 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -838,6 +838,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>   
>   		if (is_zero_pfn(pte_pfn(pte))) {
>   			page = pte_page(pte);
> +			goto out;
>   		} else {
>   			ret = follow_pfn_pte(vma, address, ptep, flags);
>   			page = ERR_PTR(ret);

I'm sorry, but that's just wrong. Observe how me might run into the 
gup_must_unshare() branch and how try_grab_folio() would grab references 
on the FOLL_GET path.

-- 
Cheers

David

