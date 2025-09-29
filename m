Return-Path: <linux-kernel+bounces-836269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDEBBA927E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A34E64E19AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087A630505F;
	Mon, 29 Sep 2025 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeGHCI2Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4A2FCBF9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147707; cv=none; b=g6B5NZIuzpKuF8UWbBMZWxnKUJN8LankFCTPH+zAzu5dQQpHFZtseFL4AnBMe5cdx4qR70SWUIirK/UN6eQqNc49cvTxKjPZRN7DD9H1Ay0KuR9+mzs+Jvvf7q7YIFTI2OSxYZMCTJQE+LXAoCQVibwpftgnawsKo+ro9MV5IJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147707; c=relaxed/simple;
	bh=y/O/ggdIcQGRLvHgZ95tApUPVlN69+CY/pYv6rR8ctk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7k3FB+OlYF0yYt/kV4dXWabw6eMs1Lef2rXOAQPB1a3P6mhWlaaC8huvpcHxcO6tG897dVQXmdGxRDENQjzy0aHox8z0QRHxc4tIVOHonEwrjQokuuwLMEtgG7Mog4Eu3fM9MGR2/Ot+b7XDXWpX96T9snMJOJ3oCftQSmCkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeGHCI2Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759147704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WiyXLvaLe86C4CnNbDWkghciau0ml4CvMCknlnsFgLs=;
	b=XeGHCI2Q0R02wnJAIZ5+hV3txj+LpfG+oCgaaFBU/rS9Up/9ji1jQR+5avZdljxqhc3Qox
	1mBuf/gYG90B2H8Rd4xjWWepGW4kfz6Ubg2lFW2dtXtqZFgIWPXXpNPGSxfIptAvii6USj
	Ps4BBcg7h0LcJvzQWv/mpcRmR7/LtG0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-XnFwaRhDNOi8S4uQGfmdlg-1; Mon, 29 Sep 2025 08:08:22 -0400
X-MC-Unique: XnFwaRhDNOi8S4uQGfmdlg-1
X-Mimecast-MFC-AGG-ID: XnFwaRhDNOi8S4uQGfmdlg_1759147701
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so29018055e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759147701; x=1759752501;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiyXLvaLe86C4CnNbDWkghciau0ml4CvMCknlnsFgLs=;
        b=Kfp5Qq1iSV7VHqoK8G3oct2CFh2caZVd9y+m1DCCiVvDsjCv3cFOcT/9YRqHp5dcQs
         qn08Y/CyFHyEbxvzxqHdjVxFQyJG+PU9mS/DT36zTqD11ozDN3JuN3pjC1QdzmKnSz0Y
         dN8GeJSfFsmRhDAM6PEWQClDOnFnbNNjR+CwuAjFNy/EVNv9zULqLLu0sRuK3sB0qs+H
         Jx3iurkAsBJvdbnpB5Z9Uh2h9HOgSYP06xJXPUb7R10rUJ193bI3NvJevFuPHdNGuSTK
         IpM9JwIVWWsplOoTaCkHqPDHCv3UIIIiF8k0dJQxrYzuPUNuy/sj4CJn0Gbg+Te+R8RL
         mV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKkGzkzgN6+JcdnigmQAeMyRSSWfJq5Y/0irsqSaMcAuATdCWrW73/WM379+PyjIlr1onHQ2cnaqKy9iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Bt+aW2EmeKmtoZ5ZKnvf9MHpFEUwVDV6J4XQ44IfsPv4vLen
	q8Le2KpEnfsvvoQ7njja+DcMOHiO5fKb6tgrjxfPtgwDtMQRXDorhHVznSLrc51MLlFzR13ZoHZ
	utvktZ8EmqFZ9CIdJK9FVV4ORxlwdm2wc+xg/OzWYiOyEGBeVSGIehbUbNeon6erIZQ==
X-Gm-Gg: ASbGncs/Z3j4E+nxUe9E3SgnUiqt94AD3b3yYs5UnS7VhMf1dLydn4SNDhM7mF3s1VD
	k/VDBpYPLAVL6BsBRwgp8PdO/fPnBOK37XA41sb4V+h/PAAbE8l/CLlCLuKOb34I8L3BX566/4q
	d5wKubVUgVSklGkgC6rXUpxGZyi5VoCtnToZBw5lOIsZ4zr3Lb9nxIkE+FSaCF6FEggbRlh8zRG
	5iPtL3CxtLTYdS7lOCTXZrk0ddta0StTzfmNkOngv0BCIC9En6z8hK+GTlDDF5eMtp6X0lLEp4o
	+4fr4lvf5woytXQxXlCcrvBN2nM1EBxqU8AEPrb82/3nSeUPLLVbRncfb1sWN35CzgogKoD7G+8
	vbcvdE8KrTPt/P4eq4tK0Wd6wE0razVNIxepKD8IR135K/T+8eNqwX3DtyKT1f9wqwKwD
X-Received: by 2002:a05:600c:8b05:b0:46e:3e82:6551 with SMTP id 5b1f17b1804b1-46e3e826872mr95979895e9.2.1759147700739;
        Mon, 29 Sep 2025 05:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG33fiIdiXh2Apbgrxvp2qHDqZqgyu02SfE3Pyi3i8dLLAoQOztr9pyWiMkM+wl4qduG0BzsA==
X-Received: by 2002:a05:600c:8b05:b0:46e:3e82:6551 with SMTP id 5b1f17b1804b1-46e3e826872mr95979585e9.2.1759147700309;
        Mon, 29 Sep 2025 05:08:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f39:1500:c90f:7794:3c33:4164? (p200300d82f391500c90f77943c334164.dip0.t-ipconnect.de. [2003:d8:2f39:1500:c90f:7794:3c33:4164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f53596sm10484755e9.7.2025.09.29.05.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 05:08:19 -0700 (PDT)
Message-ID: <69b463e5-9854-496d-b461-4bf65e82bc0a@redhat.com>
Date: Mon, 29 Sep 2025 14:08:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/rmap: fix soft-dirty bit loss when remapping
 zero-filled mTHP subpage to shared zeropage
To: Lance Yang <lance.yang@linux.dev>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, baohua@kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, usamaarif642@gmail.com,
 yuzhao@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, stable@vger.kernel.org, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
References: <20250928044855.76359-1-lance.yang@linux.dev>
 <b19b4880-169f-4946-8c50-e82f699bb93b@redhat.com>
 <900d0314-8e9a-4779-a058-9bb3cc8840b8@linux.dev>
 <1f66374a-a901-49e7-95c8-96b1e5a5f22d@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <1f66374a-a901-49e7-95c8-96b1e5a5f22d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.09.25 13:29, Lance Yang wrote:
> 
> 
> On 2025/9/29 18:29, Lance Yang wrote:
>>
>>
>> On 2025/9/29 15:25, David Hildenbrand wrote:
>>> On 28.09.25 06:48, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> When splitting an mTHP and replacing a zero-filled subpage with the
>>>> shared
>>>> zeropage, try_to_map_unused_to_zeropage() currently drops the soft-dirty
>>>> bit.
>>>>
>>>> For userspace tools like CRIU, which rely on the soft-dirty mechanism
>>>> for
>>>> incremental snapshots, losing this bit means modified pages are missed,
>>>> leading to inconsistent memory state after restore.
>>>>
>>>> Preserve the soft-dirty bit from the old PTE when creating the zeropage
>>>> mapping to ensure modified pages are correctly tracked.
>>>>
>>>> Cc: <stable@vger.kernel.org>
>>>> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage
>>>> when splitting isolated thp")
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>>>    mm/migrate.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index ce83c2c3c287..bf364ba07a3f 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -322,6 +322,10 @@ static bool try_to_map_unused_to_zeropage(struct
>>>> page_vma_mapped_walk *pvmw,
>>>>        newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>>>>                        pvmw->vma->vm_page_prot));
>>>> +
>>>> +    if (pte_swp_soft_dirty(ptep_get(pvmw->pte)))
>>>> +        newpte = pte_mksoft_dirty(newpte);
>>>> +
>>>>        set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>>>        dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
>>>
>>> It's interesting that there isn't a single occurrence of the stof-
>>> dirty flag in khugepaged code. I guess it all works because we do the
>>>
>>>       _pmd = maybe_pmd_mkwrite(pmd_mkdirty(_pmd), vma);
>>>
>>> and the pmd_mkdirty() will imply marking it soft-dirty.
>>>
>>> Now to the problem at hand: I don't think this is particularly
>>> problematic in the common case: if the page is zero, it likely was
>>> never written to (that's what the unerused shrinker is targeted at),
>>> so the soft-dirty setting on the PMD is actually just an over-
>>> indication for this page.
>>
>> Cool. Thanks for the insight! Good to know that ;)
>>
>>>
>>> For example, when we just install the shared zeropage directly in
>>> do_anonymous_page(), we obviously also don't set it dirty/soft-dirty.
>>>
>>> Now, one could argue that if the content was changed from non-zero to
>>> zero, it ould actually be soft-dirty.
>>
>> Exactly. A false negative could be a problem for the userspace tools, IMO.
>>
>>>
>>> Long-story short: I don't think this matters much in practice, but
>>> it's an easy fix.
>>>
>>> As said by dev, please avoid double ptep_get() if possible.
>>
>> Sure, will do. I'll refactor it in the next version.
>>
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>> Thanks!
>>
>>>
>>>
>>> @Lance, can you double-check that the uffd-wp bit is handled
>>> correctly? I strongly assume we lose that as well here.
> 
> Yes, the uffd-wp bit was indeed being dropped, but ...
> 
> The shared zeropage is read-only, which triggers a fault. IIUC,
> The kernel then falls back to checking the VM_UFFD_WP flag on
> the VMA and correctly generates a uffd-wp event, masking the
> fact that the uffd-wp bit on the PTE was lost.

That's not how VM_UFFD_WP works :)

-- 
Cheers

David / dhildenb


