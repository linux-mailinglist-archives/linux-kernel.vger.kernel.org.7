Return-Path: <linux-kernel+bounces-853050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D8BDA89D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36BC19A467B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588C2F90C4;
	Tue, 14 Oct 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sp9OXcm0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86162DAFAE
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457594; cv=none; b=CqvWpiojQpLYFoLhX8VAtn5Ym/A7VCYt3jDLlaWbr94oBnv86gBXokJD6O62vDXfStXfYa0Exu8s7XsRnMBLPVOk5WuZeL2v5bSwftD79sqVjZi69w+7zk2GHKx/nNfsejwUTKYTYATPdmK+UkrVljtERXLtJgtNDH7WvNyLYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457594; c=relaxed/simple;
	bh=BFszsmBbrqIRlQNLtXE/8UQ/wten+MVLnW1k5LyJrvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuE46IU2h9eLe/RRAltznBzK2CtJ9xqsYjHtgkL8soO8o/ugchqa8B8SZgElxqTPbKEWi71+lu+BXSUHLTmeenQzPBxtOzKOHmRd7vYbBtM/A1NdlajH9AUuWx8IaS+eFJL5bJrcVYG4G07ZYIqcJe5F4wjFkpUrDHg+84fDN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sp9OXcm0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760457590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D3JExTX7qDONwFiBK/cy5SwZpbx5Q00xzbok6ccFezE=;
	b=Sp9OXcm0YvEWHr1yiIwfpumAhIfm97npYRss6om8Zn0FzGrY1Y3IYr+4bpLkFcYLK+KpHb
	f3zSmEGDHMm4DdDqVqm7YRk9C08+57cEk+Vq+E6yg4PaP7c2cZ+6yoe8g3C8dEFYyApl6c
	YNAubbw592qnbqpO+CynnCL9W7hPcMo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-NoTI7yxMMGKS8CPkpjj3vQ-1; Tue, 14 Oct 2025 11:59:48 -0400
X-MC-Unique: NoTI7yxMMGKS8CPkpjj3vQ-1
X-Mimecast-MFC-AGG-ID: NoTI7yxMMGKS8CPkpjj3vQ_1760457587
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426d2cd59e4so3266051f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760457587; x=1761062387;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3JExTX7qDONwFiBK/cy5SwZpbx5Q00xzbok6ccFezE=;
        b=AMwGoqZtExxzuKumedra8IOyolNTJhUCLYaGu2bmeUMVUtex9bRbqayvEX/wH0emak
         Wek3KwbYDg59YbzP1bdLUJ5cj7SD+j8HaF4myM0CnhR/NPl+lZY7SEMcosMqHsF8Bizi
         tJ0Wqr+cBKmvBBkiG/NeOfHuMl05zyDWBQZUT2E5I2CV3Vdr+jWFEcX780cqSwgVSxik
         U07kTtNjo4RAMblW87VpmjMccTdhQPI1T0yqbSzHAQj+/PgHYqGHooHuo3tzzsJg1MX/
         IYExELrttefxesW7ZYuiZnQFthqr89KGBm58C/YIBMa6Vpcghn4bcA6dwduZ2l6w33eD
         Hrug==
X-Forwarded-Encrypted: i=1; AJvYcCUZwiSzapc74QX0ivGh+4F1Jl5xI+t6g5sjWFkbAPfPInRsaU9QyYiG/WQ0RX04YbbPeYvuGueIQCz90x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9njMcCSMS9/0Kex9lksB/BtDkyieq1Ivp+gkQBf7fS+Rz4Zuf
	0xqRydiykFgjU2mZbdLimno/VyWQZ600x86u7scp+QVNebMdXG8/uvmHT1PvQArO3MWzj4DU8dP
	VQlTmAHMkWn5kYNxtIq6yled43g009I8tLPBE5RPT8qFO4HzZY4gjefNBDw3helajRA==
X-Gm-Gg: ASbGncuhwrqi1paEp/C+HzqYTG5iMnx6spcbi9ckSzpYae1Y1IymozG2sVsJ/Jm2F17
	9azaJspZT4bpWUpre/CAMEYcXxLr/NumWxAhfPFRrQ5d1HPt1ANG8v4Xa6aTWTxo1UVCyME2DrI
	uKAr2GsOIHFf/lv8GIxoLS4oK0vhJXNPwNhwECUoADM9Yy1puJFMTKTCd/JydgwBtMLVH7yQLUH
	p1WBaepU1NBKOVvgwSjAxPaNG9StK1K6waTiSBen6FQ1syC3tBSwe0IqysNxlaAnv4j32msCcDg
	cpwge6XZGHMKuVnzx2hKXrL9sNn7ZTtDfCxkRWhPHuIs3hxERKcRZ4HLMOC/OyuflhfnhxGMeg=
	=
X-Received: by 2002:a05:6000:4313:b0:3ec:4fe:860 with SMTP id ffacd0b85a97d-42672425c24mr16687839f8f.46.1760457586676;
        Tue, 14 Oct 2025 08:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4ydOZIRE7sHeeiIjnNQssmIuPMZbTLGKFmdMHdqf/+b6bC5doemJ0TPBd0hvAaiSH8ZkHbg==
X-Received: by 2002:a05:6000:4313:b0:3ec:4fe:860 with SMTP id ffacd0b85a97d-42672425c24mr16687821f8f.46.1760457586263;
        Tue, 14 Oct 2025 08:59:46 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb483bcf9sm255457535e9.6.2025.10.14.08.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 08:59:45 -0700 (PDT)
Message-ID: <77b69bcb-6df0-4c3a-bb7c-a003fd51d292@redhat.com>
Date: Tue, 14 Oct 2025 17:59:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251014151126.87589-1-pedrodemargomes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014151126.87589-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 17:11, Pedro Demarchi Gomes wrote:
> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> Changes since v1 [2]:
> - Use pmd_entry to walk page range
> - Use cond_resched inside pmd_entry()
> - walk_page_range returns page+folio
> 
> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> [2] https://lore.kernel.org/linux-mm/20251014055828.124522-1-pedrodemargomes@gmail.com/
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---

[...]

> +
> +static int ksm_pmd_entry(pmd_t *pmd, unsigned long addr,
> +			    unsigned long end, struct mm_walk *walk)
> +{
> +	struct mm_struct *mm = walk->mm;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct ksm_walk_private *private = (struct ksm_walk_private *) walk->private;
> +	struct folio *folio;
> +	pte_t *start_pte, *pte, ptent;
> +	spinlock_t *ptl;
> +	int ret = 0;
> +
> +	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> +	if (!start_pte) {
> +		ksm_scan.address = end;
> +		return 0;
> +	}

Please take more time to understand the details. If there is a THP there 
you actually have to find the relevant page.

> +
> +	for (; addr < end; pte++, addr += PAGE_SIZE) {
> +		ptent = ptep_get(pte);
> +		struct page *page = vm_normal_page(vma, addr, ptent);
> +		ksm_scan.address = addr;

Updating that value from in here is a bit nasty. I wonder if you should 
rather make the function also return the address of the found page as well.

In the caller, if we don't find any page, there is no need to update the
address from this function I guess. We iterated the complete MM space in 
that case.

> +
> +		if (ksm_test_exit(mm)) {
> +			ret = 1;
> +			break;
> +		}
> +
> +		if (!page)
> +			continue;
> +
> +		folio = page_folio(page);
> +		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
> +			continue;
> +
> +		ret = 1;
> +		folio_get(folio);
> +		private->page = page;
> +		private->folio = folio;
> +		private->vma = vma;
> +		break;
> +	}
> +	pte_unmap_unlock(start_pte, ptl);
> +
> +	cond_resched();
> +	return ret;
> +}
> +
> +struct mm_walk_ops walk_ops = {
> +	.pmd_entry = ksm_pmd_entry,
> +	.test_walk = ksm_walk_test,
> +	.walk_lock = PGWALK_RDLOCK,
> +};
> +
>   static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   {
>   	struct mm_struct *mm;
>   	struct ksm_mm_slot *mm_slot;
>   	struct mm_slot *slot;
> -	struct vm_area_struct *vma;
>   	struct ksm_rmap_item *rmap_item;
> -	struct vma_iterator vmi;
>   	int nid;
>   
>   	if (list_empty(&ksm_mm_head.slot.mm_node))
> @@ -2527,64 +2595,40 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   
>   	slot = &mm_slot->slot;
>   	mm = slot->mm;
> -	vma_iter_init(&vmi, mm, ksm_scan.address);
>   
>   	mmap_read_lock(mm);
>   	if (ksm_test_exit(mm))
>   		goto no_vmas;
>   
> -	for_each_vma(vmi, vma) {
> -		if (!(vma->vm_flags & VM_MERGEABLE))
> -			continue;
> -		if (ksm_scan.address < vma->vm_start)
> -			ksm_scan.address = vma->vm_start;
> -		if (!vma->anon_vma)
> -			ksm_scan.address = vma->vm_end;
> -
> -		while (ksm_scan.address < vma->vm_end) {
> -			struct page *tmp_page = NULL;
> -			struct folio_walk fw;
> -			struct folio *folio;
> +get_page:
> +	struct ksm_walk_private walk_private = {
> +		.page = NULL,
> +		.folio = NULL,
> +		.vma = NULL
> +	};
>   
> -			if (ksm_test_exit(mm))
> -				break;
> +	walk_page_range(mm, ksm_scan.address, -1, &walk_ops, (void *) &walk_private);
> +	if (walk_private.page) {
> +		flush_anon_page(walk_private.vma, walk_private.page, ksm_scan.address);
> +		flush_dcache_page(walk_private.page);

Keep working on the folio please.

> +		rmap_item = get_next_rmap_item(mm_slot,
> +			ksm_scan.rmap_list, ksm_scan.address);
> +		if (rmap_item) {
> +			ksm_scan.rmap_list =
> +					&rmap_item->rmap_list;
>   
> -			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
> -			if (folio) {
> -				if (!folio_is_zone_device(folio) &&
> -				     folio_test_anon(folio)) {
> -					folio_get(folio);
> -					tmp_page = fw.page;
> -				}
> -				folio_walk_end(&fw, vma);
> +			ksm_scan.address += PAGE_SIZE;
> +			if (should_skip_rmap_item(walk_private.folio, rmap_item)) {
> +				folio_put(walk_private.folio);
> +				goto get_page;

Can you make that a while() loop to avoid the label?



-- 
Cheers

David / dhildenb


