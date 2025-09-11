Return-Path: <linux-kernel+bounces-811741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB4B52D51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DC3A7770
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FF02EA147;
	Thu, 11 Sep 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hqu2WDM4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58917207A32
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583070; cv=none; b=T9T6Apt32YDsFyeBAYKIAh1b/mDwLP4do6PRcBi1gXVFcyMh5ayFYbw5Lj4hRP3JyFe3Ondf0bz0Sr+5W6KKfMSlRxTE8TDv+uG3jd2znuwzze90n5NGRzYc06zgZT8YDnZI1uwUe3wJm+qsu8ES8GXCRQ8SYxLmVCnmdP4NVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583070; c=relaxed/simple;
	bh=DnXMGqE4MgWcf66B2jqyRkYREKPT7nXhPLgOD4PUn1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vx5kNjjzBUt3ja4lh5dlEo59Q9gtGlwoNmte6MiHk/wDzVq6ouHQ9Nnrb1nGjsI6Yt2dcH4ORuoVLIuASbDXtnUyWgiR3P/6/apvlyF39RdKv8iUknpnGoQzjDgA3fFn+E7+7kRJxKtompMW36a/kGeJl31uRf1a6sIF3mX4SA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hqu2WDM4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757583068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tQgBSzW7MZBLnkTQQxNiCmSvpaQHwAjw2wmF5H1RJdc=;
	b=Hqu2WDM4GoBOQq7/+dYtL7mmtCTupqcMiON+flCZ67VVRF8RMhDpfiSpN9GvUuVAhmht1V
	xMa1ZNL/czTkAdyIA9JGjBs++LNTOZSuXyPK+xh5lmObMrVtI+qTJlI0Mh/loi6ukJICXG
	vG18qWLWphcNT3GkSBmxmFpmyCoYxEU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-GuRXMPbWOAat5tKjXu0jDg-1; Thu, 11 Sep 2025 05:31:06 -0400
X-MC-Unique: GuRXMPbWOAat5tKjXu0jDg-1
X-Mimecast-MFC-AGG-ID: GuRXMPbWOAat5tKjXu0jDg_1757583066
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45dd9a66cfbso4177135e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583065; x=1758187865;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQgBSzW7MZBLnkTQQxNiCmSvpaQHwAjw2wmF5H1RJdc=;
        b=vv68qzVqkHCl1l+k/Z7Rm5wVsXpKyX/tJI8TgFk/ZO6kEGC52s5qfPMLLcM2+aCKAT
         8Qkwg7qzrPuI+Ktt4tbmgdLZ32BwUAVXJ8mAT7UTDGwv4hu+h0MXVRuMccgIr75jAa3V
         pPe7ZUO32yiMVMYm4lwhuhQ8dwMOm+T9OgW2Fb7gEVa9EtHVViLHdfEDZDtRPUvuwyDj
         nwMpbqKMMIqXyCWiMidb9E5h3Vqp7hyNUZu1cCKHoc+w/4m3z16uNC2jvCDPbH+YWOAp
         ygIg8Q9EoKOPsGBmk7oFRG+dmxyihOg7Xs/uq/aun9tNJVOYBa+LL4Qoa2Vp1AQQdB61
         J5/w==
X-Forwarded-Encrypted: i=1; AJvYcCWKc20564zaijZgNxXoJnyJdkBkCA15ODvISDv03E6MxLmbORQogWN42TMi/ZlRLoMWmO8ySuUV6Ck1SoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySS1mS/w3Vec5+093bN1odWNyGk1xzo6qrCN60Tc8TnSjU6V0D
	NF3y8sxfhsU5BdK1jVgI9CCElanxOykhs5RdFrzLXjnia7nILPMrUM+o5ldEw9GWlWhX7u5IBCk
	gh5/IZTLq59oDstc5CcY/lM2GXLFg736gUi5fs9p74mYSeAxWzZNoTRdYtxTo2H7JAg==
X-Gm-Gg: ASbGncv5IcG/EpXJyOWcLXrjIln7Ax802Dqi6APkAxEdtWQXWqZL73cUBxbMq+pfmRS
	+eTdxJUVZa+K9iSOD6iJW0V+gtPasjL1KjezdsPLsSCCMp/NYLBuzpaRtwtZskkJCidPVvneJ1u
	+LicKi3i4JPMkuLHJi+3mFjgl7gSD4sEuaj4yHNelxFX3OdqL3Vf5Vl4cPNeRu0ZgyB3VRE/SLD
	8MqWRyo7crm19JfINThoNH0G5AMuZBuGYiy7TAI8adQ8BuagMZag+BMeJ4I848su8UMCzNlfQhi
	Brp0eo2WVEJ8hSvTNnpEBGT5TvqeFWdqrRIPU5sNjZeoT4JaA1ZhEqTDacU6gWWzWHkJ+O0m5K6
	EnM73jYXWGviFcPS9qGRTQQqXVjlfd2x71u3HMNrzOoKLebXe9B4vcKuIlWdAcrkTwR8=
X-Received: by 2002:a05:600c:154c:b0:45d:da25:595d with SMTP id 5b1f17b1804b1-45de241c045mr143090085e9.22.1757583065422;
        Thu, 11 Sep 2025 02:31:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL1YG8rjRM376Qm23m4BVQbfhxC1h3Ges4BLaAmucG/B6vAYPJtZTYpNyHaceuuLmMA9KADg==
X-Received: by 2002:a05:600c:154c:b0:45d:da25:595d with SMTP id 5b1f17b1804b1-45de241c045mr143089605e9.22.1757583064918;
        Thu, 11 Sep 2025 02:31:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0156b0a8sm19931135e9.3.2025.09.11.02.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:31:04 -0700 (PDT)
Message-ID: <a05ffc6c-33b3-4e14-92b6-852e8ff37d96@redhat.com>
Date: Thu, 11 Sep 2025 11:31:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] mm: Change dup_mmap() recovery
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com,
 kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
 chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-7-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250909190945.1030905-7-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 21:09, Liam R. Howlett wrote:
> When the dup_mmap() fails during the vma duplication or setup, don't
> write the XA_ZERO entry in the vma tree.  Instead, destroy the tree and
> free the new resources, leaving an empty vma tree.
> 
> Using XA_ZERO introduced races where the vma could be found between
> dup_mmap() dropping all locks and exit_mmap() taking the locks.  The
> race can occur because the mm can be reached through the other trees
> via successfully copied vmas and other methods such as the swapoff code.
> 
> XA_ZERO was marking the location to stop vma removal and pagetable
> freeing.  The newly created arguments to the unmap_vmas() and
> free_pgtables() serve this function.
> 
> Replacing the XA_ZERO entry use with the new argument list also means
> the checks for xa_is_zero() are no longer necessary so these are also
> removed.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   mm/memory.c |  6 +-----
>   mm/mmap.c   | 42 +++++++++++++++++++++++++++++++-----------
>   2 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 24716b3713f66..829cd94950182 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -408,8 +408,6 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>   		 * be 0.  This will underflow and is okay.
>   		 */
>   		next = mas_find(mas, tree_max - 1);
> -		if (unlikely(xa_is_zero(next)))
> -			next = NULL;
>   
>   		/*
>   		 * Hide vma from rmap and truncate_pagecache before freeing
> @@ -428,8 +426,6 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>   		while (next && next->vm_start <= vma->vm_end + PMD_SIZE) {
>   			vma = next;
>   			next = mas_find(mas, tree_max - 1);
> -			if (unlikely(xa_is_zero(next)))
> -				next = NULL;
>   			if (mm_wr_locked)
>   				vma_start_write(vma);
>   			unlink_anon_vmas(vma);
> @@ -2129,7 +2125,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>   				 mm_wr_locked);
>   		hugetlb_zap_end(vma, &details);
>   		vma = mas_find(mas, tree_end - 1);
> -	} while (vma && likely(!xa_is_zero(vma)));
> +	} while (vma);
>   	mmu_notifier_invalidate_range_end(&range);
>   }
>   
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0f4808f135fe6..aa4770b8d7f1e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1288,7 +1288,7 @@ void exit_mmap(struct mm_struct *mm)
>   	arch_exit_mmap(mm);
>   
>   	vma = vma_next(&vmi);
> -	if (!vma || unlikely(xa_is_zero(vma))) {
> +	if (!vma) {
>   		/* Can happen if dup_mmap() received an OOM */
>   		mmap_read_unlock(mm);
>   		mmap_write_lock(mm);
> @@ -1858,20 +1858,40 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>   		ksm_fork(mm, oldmm);
>   		khugepaged_fork(mm, oldmm);
>   	} else {
> +		unsigned long max;
>   
>   		/*
> -		 * The entire maple tree has already been duplicated. If the
> -		 * mmap duplication fails, mark the failure point with
> -		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
> -		 * stop releasing VMAs that have not been duplicated after this
> -		 * point.
> +		 * The entire maple tree has already been duplicated, but
> +		 * replacing the vmas failed at mpnt (which could be NULL if
> +		 * all were allocated but the last vma was not fully set up).
> +		 * Use the start address of the failure point to clean up the
> +		 * partially initialized tree.
>   		 */
> -		if (mpnt) {
> -			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> -			mas_store(&vmi.mas, XA_ZERO_ENTRY);
> -			/* Avoid OOM iterating a broken tree */
> -			mm_flags_set(MMF_OOM_SKIP, mm);
> +		if (!mm->map_count) {
> +			/* zero vmas were written to the new tree. */
> +			max = 0;
> +		} else if (mpnt) {
> +			/* partial tree failure */
> +			max = mpnt->vm_start;
> +		} else {
> +			/* All vmas were written to the new tree */
> +			max = ULONG_MAX;
>   		}
> +
> +		/* Hide mm from oom killer because the memory is being freed */
> +		mm_flags_set(MMF_OOM_SKIP, mm);
> +		if (max) {
> +			vma_iter_set(&vmi, 0);
> +			tmp = vma_next(&vmi);
> +			flush_cache_mm(mm);
> +			unmap_region(&vmi.mas, /* vma = */ tmp,
> +				     /*vma_min = */ 0, /* vma_max = */ max,
> +				     /* pg_max = */ max, /* prev = */ NULL,
> +				     /* next = */ NULL);
> +			charge = tear_down_vmas(mm, &vmi, tmp, max);
> +			vm_unacct_memory(charge);
> +		}
> +		__mt_destroy(&mm->mm_mt);

Usually comment about just calling things start/end, maybe with prefix 
if required.

Apart from that, LGTM.

-- 
Cheers

David / dhildenb


