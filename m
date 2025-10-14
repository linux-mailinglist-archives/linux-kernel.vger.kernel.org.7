Return-Path: <linux-kernel+bounces-852219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37095BD875A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E460B4E400C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC5220686;
	Tue, 14 Oct 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAtFp6Xr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F222E0B5F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434554; cv=none; b=FRSBQiPK4A/G+oHcWZL+goQF0J4RvEroQ4CMi6pDTYo1gMz0f6R6kIj/9QKaeJQUdvTucdUpfYcpNSr/kGa0FpsFIATysbXXip9EfjPwo2TAohi1+90zddKl/MAAasCgHPdyWQmIqQWqfTv6krSW+o8BJ3wRCBPG7o4oy65KbGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434554; c=relaxed/simple;
	bh=3Si0dDgaFIvyLnlngswyBeNjiHi5o/P1ytnqMKD1hzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4ZIbRFKeBF6PSYQom4BrMI7Ek+kBw+VBVhixt99cLAwUPKaENxIHtZXZr+36++YyfyOS9K6i78VWLSwPVStN+2BoWCDohcLYQXE0Zv4QTnQlvDcdaOpkCblFWHtrJpg2WZ9KnI9fkkBFLQ42mLvuIqNxN+EBwuhm12T3FHfN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAtFp6Xr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760434551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y2F6jOViE63Bow9w5wII9vTrnKutraVO4tvBb2COsWY=;
	b=XAtFp6XrPBsqOftDeU6TwQWiUCfKEHqAybDwMXTHekK8RY7g1dJfUVu2d4koUS3+p9Z3wZ
	sgObsSy14F/THScFSyUMASDslGil3tcaHJXVutmp7BJcN2EBGN2rV9+NiL/KuEs+/LP/Ed
	Kwlg8JG0W06Hxv78n8YTIdJMJHsYka4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-7tQLvpUVOyyJTT5VcMmJ2A-1; Tue, 14 Oct 2025 05:35:49 -0400
X-MC-Unique: 7tQLvpUVOyyJTT5VcMmJ2A-1
X-Mimecast-MFC-AGG-ID: 7tQLvpUVOyyJTT5VcMmJ2A_1760434549
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3ed6540fso34339285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434549; x=1761039349;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2F6jOViE63Bow9w5wII9vTrnKutraVO4tvBb2COsWY=;
        b=aBlSFg7eAffiBfk7DYaemxiCSoSpxESyJh4Qj85F7dIX2W90JsfMxCeDz+rPY642pG
         qnZsx0CYhvYeuEpEa2XWO7fPDdwYrAOQ27RiAjPRvCWzBwMxpeGl5Ro6gQevRyGuyQ3y
         fpcwdvxug4uwaY0Dc8ZPFp0HyEKhrcPQog6FswzghY1J/Y7dKlEMUSqEVXm+4l+8NuIm
         F6270A/aHDvNCAN2sdcRji+piu0HZg9G8xalyspvqVjAJbkJBTPCYeFUZJdxJ3UAb2nR
         PGhYNf9QWDIBaDycZbn9rGtEx/EeS9xn6RQCeKHnprWVos/tgezRhwK3Sc+mfna0UWZr
         7XHw==
X-Forwarded-Encrypted: i=1; AJvYcCUFbkvuR5Lb9DrljiZBKKncsxuhv1aJ8MQT57tHAwr8RVqn0eifwpn2quZzXMOSUNsHa3zcKO488YZTsLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCq/Tyn0tg9ctCow6d44zyD8v7NSOI/4ZMx21DeRBNKd1VyvQ
	BTcxJjelRm/zb0WDlb2jEZeQKkoO09vcJcm7TYRWwQJwfQXQvEJaTuMCKT+vM96cHSVp1LxnwBl
	yB8ZYYRy2cxs2ezpYWLt6sx7AlFT4Rhfwa+Q5F0mAEurY3jiABPBws5MNyRwtCSJjBA==
X-Gm-Gg: ASbGnctTix8b9r3DYiKyx1OPDFHTf8IQQpoaoO8ZDk/escaz87IBhRtR/VyXXOYQl/r
	AyQ+23ZMjVwvTxXHf/SsJDBGRkhJthXqYf6ZrtgxNd76v8RiWic/fmwUxVflTXH06insQERPLrp
	08Jq0ZnXvCVGEHQ2IP6YqCrQ32dH0RwUfVPIIO2k7pj1ANxQC3UNuFNvsyyA0eJjcUkqBK8skrX
	39IJSH+bin5N+zUKayFmot5lq+qVDycrosWAuqRTRuF2f2iFNQuJPxUcZd3DIzITMn1dfvA1Xbn
	VQEcxLVbycuERxPO/pLrvMHp3te6AKvRq8Aor7a6zU4avcJxZFWMR6ZXfrY48B/QYZ1wjqoDrA=
	=
X-Received: by 2002:a05:600c:6011:b0:45c:b642:87a6 with SMTP id 5b1f17b1804b1-46fa28bbca1mr142788775e9.0.1760434548597;
        Tue, 14 Oct 2025 02:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlkAHGXny2AktZfU6F6Ctm7oqV+VbH4UKxyISSjJEN6gm5yYBb/IdMAma5QouQOPHbRHD5KQ==
X-Received: by 2002:a05:600c:6011:b0:45c:b642:87a6 with SMTP id 5b1f17b1804b1-46fa28bbca1mr142788655e9.0.1760434548106;
        Tue, 14 Oct 2025 02:35:48 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3desm22829660f8f.7.2025.10.14.02.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:35:47 -0700 (PDT)
Message-ID: <e6bb05f7-8f05-409f-9d87-2d25f66942a9@redhat.com>
Date: Tue, 14 Oct 2025 11:35:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] hugetlbfs: move lock assertions after early returns in
 huge_pmd_unshare()
To: Deepanshu Kartikey <kartikey406@gmail.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, broonie@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
References: <20251014050609.349461-1-kartikey406@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014050609.349461-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 07:06, Deepanshu Kartikey wrote:
> When hugetlb_vmdelete_list() processes VMAs during truncate operations,
> it may encounter VMAs where huge_pmd_unshare() is called without the
> required shareable lock. This triggers an assertion failure in
> hugetlb_vma_assert_locked().
> 
> The previous fix in commit dd83609b8898 ("hugetlbfs: skip VMAs without
> shareable locks in hugetlb_vmdelete_list") skipped entire VMAs without
> shareable locks to avoid the assertion. However, this prevented pages
> from being unmapped and freed, causing a regression in fallocate(PUNCH_HOLE)
> operations where pages were not freed immediately, as reported by Mark Brown.
> 
> A subsequent fix in commit 06e8ca1b3dca ("hugetlbfs: check for shareable
> lock before calling huge_pmd_unshare()") addressed this by checking
> __vma_shareable_lock() in the caller before calling huge_pmd_unshare().
> However, a cleaner approach is to move the lock assertions in
> huge_pmd_unshare() itself to after the early return checks. The assertions
> are only needed when actual PMD unsharing work will be performed. If the
> function returns early because sz != PMD_SIZE or the PMD is not shared,
> no locks are required.
> 
> This patch removes the check added in commit 06e8ca1b3dca ("hugetlbfs:
> check for shareable lock before calling huge_pmd_unshare()") and instead
> moves the assertions inside huge_pmd_unshare(), keeping all the logic
> within the function itself.
> 
> Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
> Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
> Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
> Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
> Link: https://lore.kernel.org/linux-mm/20251008052759.469714-1-kartikey406@gmail.com/ [v4]
> Link: https://lore.kernel.org/linux-mm/CADhLXY72yEVDjXWfxBUXfXhNfb8MWqwJmcb1daEHmDeFW+DRGw@mail.gmail.com/ [v5]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v6:
> - Remove __vma_shareable_lock() check from __unmap_hugepage_range()
>    that was added in v4 (commit 06e8ca1b3dca)
> - Move lock assertions after early returns in huge_pmd_unshare()
> - Complete implementation of David's cleaner approach
> 
> Changes in v5:
> - Incomplete: only moved assertions, forgot to remove v4 check
> 
> Changes in v4:
> - Check __vma_shareable_lock() in __unmap_hugepage_range() before calling
>    huge_pmd_unshare() per Oscar's suggestion
> 
> Changes in v3:
> - Add ZAP_FLAG_NO_UNSHARE to skip only PMD unsharing
> 
> Changes in v2:
> - Skip entire VMAs without shareable locks (caused PUNCH_HOLE regression)
> 
> Changes in v1:
> - Initial fix attempt
> ---
>   mm/hugetlb.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 85b2dac79d25..0455119716ec 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5885,7 +5885,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		}
>   
>   		ptl = huge_pte_lock(h, mm, ptep);
> -		if (__vma_shareable_lock(vma) && huge_pmd_unshare(mm, vma, address, ptep)) {
> +		if (huge_pmd_unshare(mm, vma, address, ptep)) {
>   			spin_unlock(ptl);
>   			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
>   			force_flush = true;
> @@ -7614,13 +7614,12 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>   	p4d_t *p4d = p4d_offset(pgd, addr);
>   	pud_t *pud = pud_offset(p4d, addr);
>   
> -	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> -	hugetlb_vma_assert_locked(vma);
>   	if (sz != PMD_SIZE)
>   		return 0;
>   	if (!ptdesc_pmd_is_shared(virt_to_ptdesc(ptep)))
>   		return 0;
> -
> +	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> +	hugetlb_vma_assert_locked(vma);
>   	pud_clear(pud);
>   	/*
>   	 * Once our caller drops the rmap lock, some other process might be

Can you resend based on mm/mm-stable please? Looks like this one is 
based on v5.

-- 
Cheers

David / dhildenb


