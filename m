Return-Path: <linux-kernel+bounces-853408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C55BDB901
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD791355C19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C230DD27;
	Tue, 14 Oct 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eimdwUMt"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4230CDAA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479488; cv=none; b=XNxNGw5bP1uF1FjzYlE+4CzJzEJjQ4mjn16voJm4cEeRPZ+Y1/uIwoMy5nzK6ZSnZ98Ej1dG1QhqCuGwnD1uONVSbc8YqdMYc+PHuJNh6ktgq1luQ3tCp0jU3YSkLI6lcJX77B9Kzg0Qa7dcXgPSrqhxE2kiqyvQfUA+pukxMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479488; c=relaxed/simple;
	bh=TjKD1HJCmzN9QjVHtgXTv+J9VVzCcdw7vjNr+JLntjo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kKecucR8Q/I58YlRqk5bXETdcMyKjciF+iX1cgBWHDHxYlpqlQFOhIDqf0mATa2m07NPiGgII900PbwMJrWZHiI6XIt7uf+mdoXsdJjI/u7ZCQkwX/kztNDrgSchg2GFQ9NdNlWso0FWTtPx6Pm0YIgGoSo6cyYbi+SfMtagQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eimdwUMt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eceb38eb1so67979155ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760479486; x=1761084286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=em9G7k50/YoPb9HbweOv7zMBAXiBoWznZJD05Jcou8E=;
        b=eimdwUMtIJ41S5r0cEbwhsI5edttw11Kc23lY0C8EVRmWfBAT36T+apSYUq2TAVycK
         6jZ89pyu/JpEWCeBy0Y5va1LfU8KP6uA4PfTvst8YJm0ydHLehk41U36cw+5Sj16xYx1
         Q9ba9HEDwYSYDpgKUwq4ZLbW4bntZyeMkZzQmaGtEXVyApENROMYUEkWf41x/lj5vWE6
         P6TTnfhpfQ7vewN9rJ7hpx7Car9dAkigIWpTna/DMMDZeZXgck66aIveZAR7xlJoHJB+
         ueYbR1QBZ1ycUQSmWsk/W3+oP/Adzfa5Q7r/ny37w9XizuvB5n6IwXAseERaU7m7fvuO
         yiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479486; x=1761084286;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=em9G7k50/YoPb9HbweOv7zMBAXiBoWznZJD05Jcou8E=;
        b=jKXs+EdFjS0uzsZsgsnD9OXs5k/xWzmrXLc6xb6aurGGNB3Jn+fQYGiZ3bgVLsHWqe
         oblZ7jY7qA50nsI3ljC9Svjw85dZ4pBzpyjkF2xUH2M7W6spejWT1hIFN2eSCPE25xND
         jpCwyzvwaYc6t9eHk2N0Tk27OKEZbcUyAtqsBtKDhOnOifZ/xDL0GNnAH8C0igKDAclK
         9dITvXmCRdLurPfLqopJnYpQHaMeY8q4FgLAAz5cRwiv9MUOHcBBjJK/07B5z1eAR9Ta
         3dN8Khq2DRdTRnS5aWLzGko+PnHK4e3dfhDNlKgFRgKo+3MJWWjKIEhq1cGVplyJH15O
         XxNg==
X-Forwarded-Encrypted: i=1; AJvYcCXiYiCztrwAYDdfxJsQWJSC+te1gpCV96Xlk14eV1fMqb/BN319BrpMI9euE5I4Tk36bqlnYfxgpb4cW/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmUQd0Ym18XTmIH8H+ulddKnHtUv4EAxsfP3uUc1/MKXsJ3jY
	uihAVnEyZEtV7Qv2cYHWcL16QL1wdS1B4YqRiIPXlgZTw7skEJOjmYE2
X-Gm-Gg: ASbGncs8edc0Sszc7ShPY3JJTe3pUI9v5bZm/6kecNQeK8s5GY091lHJS/cPL6smOba
	nad3SSUH/yLZpu0TN44VoQmqjY3cWsakZB68wb88L8EoRi51FQ34z3T/w5cQywuFlpxPQp+9+6S
	s/itsdQUWHufdcASnwTruLtDr2QNtwsmhgc+As7dtTSXmHzMLhJfc+4T42c74ZcHJqQ4laLwtv/
	9qIquyhaLuW49l16VMIGdLgLIxLtyH0/gabk+36lmESE9bYQnJI2QUKBc8cykIbqUXa6mxpxzSL
	oGihstgf6LZ3IP98A8Sa/rI//1EPV2Oc4dHWWvkHk9gu8ckwwJitz0Yp56114vluQlxDbm4kIW4
	YoJZb4nfBFpIP2H8YE6jk+HJbqC88HgxwJ/4D2Jf/G5hwaPlV9F1TvksfV9aKWU6aUqy4jNIJGe
	8RJm0KkjIdTe6m/7p5Bhjw
X-Google-Smtp-Source: AGHT+IFkpy/T9xOcAh37FUeV77inYRWjgwBQGuYQSlksDCArTvA7VvnPknld6pHnbM60IY3q2F64IQ==
X-Received: by 2002:a17:902:e78f:b0:277:71e6:b04d with SMTP id d9443c01a7336-2902735691cmr341952385ad.3.1760479485597;
        Tue, 14 Oct 2025 15:04:45 -0700 (PDT)
Received: from ?IPV6:2804:14c:5fc8:8033:858f:c73d:3967:699f? ([2804:14c:5fc8:8033:858f:c73d:3967:699f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c7bsm174749665ad.3.2025.10.14.15.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 15:04:45 -0700 (PDT)
Message-ID: <be137610-65a7-4402-86d8-3d169e3ac064@gmail.com>
Date: Tue, 14 Oct 2025 18:57:54 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: Re: [PATCH v2] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251014151126.87589-1-pedrodemargomes@gmail.com>
 <77b69bcb-6df0-4c3a-bb7c-a003fd51d292@redhat.com>
Content-Language: en-US
In-Reply-To: <77b69bcb-6df0-4c3a-bb7c-a003fd51d292@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/14/25 12:59, David Hildenbrand wrote:
> On 14.10.25 17:11, Pedro Demarchi Gomes wrote:
>> Currently, scan_get_next_rmap_item() walks every page address in a VMA
>> to locate mergeable pages. This becomes highly inefficient when scanning
>> large virtual memory areas that contain mostly unmapped regions.
>>
>> This patch replaces the per-address lookup with a range walk using
>> walk_page_range(). The range walker allows KSM to skip over entire
>> unmapped holes in a VMA, avoiding unnecessary lookups.
>> This problem was previously discussed in [1].
>>
>> Changes since v1 [2]:
>> - Use pmd_entry to walk page range
>> - Use cond_resched inside pmd_entry()
>> - walk_page_range returns page+folio
>>
>> [1] https://lore.kernel.org/linux- 
>> mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
>> [2] https://lore.kernel.org/linux-mm/20251014055828.124522-1- 
>> pedrodemargomes@gmail.com/
>>
>> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
>> ---
> 
> [...]
> 
>> +
>> +static int ksm_pmd_entry(pmd_t *pmd, unsigned long addr,
>> +                unsigned long end, struct mm_walk *walk)
>> +{
>> +    struct mm_struct *mm = walk->mm;
>> +    struct vm_area_struct *vma = walk->vma;
>> +    struct ksm_walk_private *private = (struct ksm_walk_private *) 
>> walk->private;
>> +    struct folio *folio;
>> +    pte_t *start_pte, *pte, ptent;
>> +    spinlock_t *ptl;
>> +    int ret = 0;
>> +
>> +    start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
>> +    if (!start_pte) {
>> +        ksm_scan.address = end;
>> +        return 0;
>> +    }
> 
> Please take more time to understand the details. If there is a THP there 
> you actually have to find the relevant page.
> 

Ok

>> +
>> +    for (; addr < end; pte++, addr += PAGE_SIZE) {
>> +        ptent = ptep_get(pte);
>> +        struct page *page = vm_normal_page(vma, addr, ptent);
>> +        ksm_scan.address = addr;
> 
> Updating that value from in here is a bit nasty. I wonder if you should 
> rather make the function also return the address of the found page as well.
> 
> In the caller, if we don't find any page, there is no need to update the
> address from this function I guess. We iterated the complete MM space in 
> that case.
> 

Ok

>> +
>> +        if (ksm_test_exit(mm)) {
>> +            ret = 1;
>> +            break;
>> +        }
>> +
>> +        if (!page)
>> +            continue;
>> +
>> +        folio = page_folio(page);
>> +        if (folio_is_zone_device(folio) || !folio_test_anon(folio))
>> +            continue;
>> +
>> +        ret = 1;
>> +        folio_get(folio);
>> +        private->page = page;
>> +        private->folio = folio;
>> +        private->vma = vma;
>> +        break;
>> +    }
>> +    pte_unmap_unlock(start_pte, ptl);
>> +
>> +    cond_resched();
>> +    return ret;
>> +}
>> +
>> +struct mm_walk_ops walk_ops = {
>> +    .pmd_entry = ksm_pmd_entry,
>> +    .test_walk = ksm_walk_test,
>> +    .walk_lock = PGWALK_RDLOCK,
>> +};
>> +
>>   static struct ksm_rmap_item *scan_get_next_rmap_item(struct page 
>> **page)
>>   {
>>       struct mm_struct *mm;
>>       struct ksm_mm_slot *mm_slot;
>>       struct mm_slot *slot;
>> -    struct vm_area_struct *vma;
>>       struct ksm_rmap_item *rmap_item;
>> -    struct vma_iterator vmi;
>>       int nid;
>>       if (list_empty(&ksm_mm_head.slot.mm_node))
>> @@ -2527,64 +2595,40 @@ static struct ksm_rmap_item 
>> *scan_get_next_rmap_item(struct page **page)
>>       slot = &mm_slot->slot;
>>       mm = slot->mm;
>> -    vma_iter_init(&vmi, mm, ksm_scan.address);
>>       mmap_read_lock(mm);
>>       if (ksm_test_exit(mm))
>>           goto no_vmas;
>> -    for_each_vma(vmi, vma) {
>> -        if (!(vma->vm_flags & VM_MERGEABLE))
>> -            continue;
>> -        if (ksm_scan.address < vma->vm_start)
>> -            ksm_scan.address = vma->vm_start;
>> -        if (!vma->anon_vma)
>> -            ksm_scan.address = vma->vm_end;
>> -
>> -        while (ksm_scan.address < vma->vm_end) {
>> -            struct page *tmp_page = NULL;
>> -            struct folio_walk fw;
>> -            struct folio *folio;
>> +get_page:
>> +    struct ksm_walk_private walk_private = {
>> +        .page = NULL,
>> +        .folio = NULL,
>> +        .vma = NULL
>> +    };
>> -            if (ksm_test_exit(mm))
>> -                break;
>> +    walk_page_range(mm, ksm_scan.address, -1, &walk_ops, (void *) 
>> &walk_private);
>> +    if (walk_private.page) {
>> +        flush_anon_page(walk_private.vma, walk_private.page, 
>> ksm_scan.address);
>> +        flush_dcache_page(walk_private.page);
> 
> Keep working on the folio please.
> 

Ok

>> +        rmap_item = get_next_rmap_item(mm_slot,
>> +            ksm_scan.rmap_list, ksm_scan.address);
>> +        if (rmap_item) {
>> +            ksm_scan.rmap_list =
>> +                    &rmap_item->rmap_list;
>> -            folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
>> -            if (folio) {
>> -                if (!folio_is_zone_device(folio) &&
>> -                     folio_test_anon(folio)) {
>> -                    folio_get(folio);
>> -                    tmp_page = fw.page;
>> -                }
>> -                folio_walk_end(&fw, vma);
>> +            ksm_scan.address += PAGE_SIZE;
>> +            if (should_skip_rmap_item(walk_private.folio, rmap_item)) {
>> +                folio_put(walk_private.folio);
>> +                goto get_page;
> 
> Can you make that a while() loop to avoid the label?
> 

Ok, I will make this corrections and send a v3. Thanks!



