Return-Path: <linux-kernel+bounces-757616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4848B1C449
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FC516208A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58928A70C;
	Wed,  6 Aug 2025 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPmg3q+F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD677207A22
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476143; cv=none; b=MoQ7ste4Z6Oi3/97zTzDEyR7FBbFOGMif7QUkn0WHIoN5fzQQHiKrqc0v9ieBQcwSYb1N2UruNOAgQm4EjFZN8tAGOPvN6oq3cQSG1nDixboj76KpkzKP+Kf54nwGsrHEo4LhxWfzEQDfZ0p0gi3DoCko0CXF/L6tma2VcPXCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476143; c=relaxed/simple;
	bh=kjG5OCIU/3LZTQF34k/AuCTuywlZAz7QWt31SLdhtEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPD/N8GEwr6gW+9bU4BcdYwdgZ+TTKydztE/B60fBORJWCDmhB+j49qYEQ2DsiLYR7rUgcs3d7IgOZERY2BshD8VCSGQIAUWksR7sCiU/9BLwzaqpgU7jCoArnt6cTxCA8E6tlFuEgemfGXlHETkcGbUYgVPLyc2YXq0L58sV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPmg3q+F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754476140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s85fEJ1hPbwJ1lBrvMiN3B9Ym2qPT06ksiPFgWtT3io=;
	b=iPmg3q+F/sojUi33Z2fWC2fap8LUEfu4bx1xJ9+okO+6bFGL57aWkJfeiV0oZQ4961P5D/
	9KharUHSf3ABbvAbzmxR1nbEX83VlP87eg9CWRJ124R8aaTfiFClU4cXbOpo+D5fn4zsK5
	5C0RROzMqTHj180vKwQSQc0ojhRCboQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-6QyBAoJZMeuYRLeL2S9jAw-1; Wed, 06 Aug 2025 06:28:59 -0400
X-MC-Unique: 6QyBAoJZMeuYRLeL2S9jAw-1
X-Mimecast-MFC-AGG-ID: 6QyBAoJZMeuYRLeL2S9jAw_1754476138
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7931d3d76so3021095f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754476137; x=1755080937;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s85fEJ1hPbwJ1lBrvMiN3B9Ym2qPT06ksiPFgWtT3io=;
        b=DheFxoA4gTeC1sfCHq3JvOwhRYcpOO/iancKY8Mpmeu8JUgRY3A2DZ+uL/86c+pYfm
         WK1Q3B94a43BqvVSzpPaBm/lHYJ1BRwbH0FmzjQhOzSKAs0PexhKCOuCdBf9fsox0toZ
         zu+DKy00Jz0aYGxyOIkz6DRdVVWO+nnpqRFs+WP+x/tALJUx3+b3S4ABiWttRtEQDJyl
         VPcCO9hGLU8OJk8JoxWSwAcMaSo1bEM8k0DeUHkcGmkQvydNz08chtChwOAXWZ59wRgW
         2TdiFgkL+VZhhABAzcAzBOElULyp7TzI1/CsBC2pQUTHZ+j1F7NbHWWRBjndy/b488ua
         Uj4w==
X-Forwarded-Encrypted: i=1; AJvYcCWLpqrkGCW7s0sJPiaD2ej9sUFUbOIP94bn6pR0HCfDjNmtDGfbvFQFZ89ZXBnD/drsLJ9iZNVhhSPZPD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweNoqzqlm32V/zZctrANX7eRFEGuHx5SumxI1gkQAMvHZ3L3G2
	jr6kysQFJ4LwjSR9MPC4NttqU8ILrxHyBM3TKEw/vExc8+2THNlqty2Te/gHcbzGto6aal0NNTs
	hRt8MoQpHqYBndB9eeWQS987Q0yRtGn3S5PM9wWGMslTvqXyscBHSFvPN0JKH2rT/4Q==
X-Gm-Gg: ASbGncsT45T9j+16umbE8u852wrHFQRNNfFujDTRos8OQXgMGykFlVGK/cRegskweGh
	mMR7cNrLF7GC3Etr9HzNMMBZPjDeEPHu6h1K1gwR+wC/XlKuuDT0JAzBgOmHO0oHYeg6vkhBE3Z
	rkFwhBzwRV5bVlylQtAKUtAXI+kW2NHKWHxL7idtQyVb2UX+3sAlLlEqJTtb8bbMzGPDC7o4yZ0
	e1WKHxfEDWL8HDsIdf1dywXd2+ltt7DBGqfOoJbR411ti+QL8HSRgbSYeEHcqTKMR3fqOKDFvMY
	AvlPJCFqRCRwaxTJ+FxHduTcKkzgp5a4FDcduk3mJl/tA1kze+9jWCNqz73J5LUYs64Jj6yxgQh
	p5wWxuyBRjh+3EDYVeguKXG3EJc9pvlOyfQqGJRP9EtE3pokdn/uxih4dsH+uuUkw2UY=
X-Received: by 2002:a05:6000:2908:b0:3b8:d1d9:70b0 with SMTP id ffacd0b85a97d-3b8f49274bemr1706342f8f.40.1754476137447;
        Wed, 06 Aug 2025 03:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqcuMGgXTI80XNd7U4VUy0jmmg4JtekFe2gy7z4uJGY7EhGa5/HqatfjsYaIs+GhSWHgVy7w==
X-Received: by 2002:a05:6000:2908:b0:3b8:d1d9:70b0 with SMTP id ffacd0b85a97d-3b8f49274bemr1706322f8f.40.1754476136998;
        Wed, 06 Aug 2025 03:28:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac036sm22401606f8f.15.2025.08.06.03.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:28:56 -0700 (PDT)
Message-ID: <aa496798-5ac6-4cb0-bdc2-91515172e935@redhat.com>
Date: Wed, 6 Aug 2025 12:28:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: Dev Jain <dev.jain@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 will@kernel.org, Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
 anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 hughd@google.com, yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
 <9552ddff-d778-4934-9349-37c7237cbb78@lucifer.local>
 <54ee1971-d91a-4fe6-90b8-16212c8568d1@redhat.com>
 <0d52d680-f3d3-454f-8c12-602f650469ab@arm.com>
 <9cbe9c6a-0013-4239-9347-bf5d43021fe3@lucifer.local>
 <e3d13396-8408-49c0-9ec9-1b02790959aa@redhat.com>
 <2d0d58a4-bd27-41ac-9b25-1cd989c02383@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <2d0d58a4-bd27-41ac-9b25-1cd989c02383@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.08.25 12:20, Dev Jain wrote:
> 
> On 06/08/25 3:41 pm, David Hildenbrand wrote:
>> On 06.08.25 11:50, Lorenzo Stoakes wrote:
>>> On Wed, Aug 06, 2025 at 03:07:49PM +0530, Dev Jain wrote:
>>>>>>
>>>>>> You mean in _this_ PTE of the batch right? As we're invoking these
>>>>>> on each part
>>>>>> of the PTE table.
>>>>>>
>>>>>> I mean I guess we can simply do:
>>>>>>
>>>>>>       struct page *first_page = pte_page(ptent);
>>>>>>
>>>>>> Right?
>>>>>
>>>>> Yes, but we should forward the result from vm_normal_page(), which
>>>>> does
>>>>> exactly that for you, and increment the page accordingly as required,
>>>>> just like with the pte we are processing.
>>>>
>>>> Makes sense, so I guess I will have to change the signature of
>>>> prot_numa_skip()
>>>>
>>>> to pass a double ptr to a page instead of folio and derive the folio
>>>> in the
>>>> caller,
>>>>
>>>> and pass down both the folio and the page to
>>>> set_write_prot_commit_flush_ptes.
>>>
>>> I already don't love how we psas the folio back from there for very
>>> dubious
>>> benefit. I really hate the idea of having a struct **page parameter...
>>>
>>> I wonder if we should just have a quick fixup for hotfix, and refine
>>> this more
>>> later?
>>
>> This is not an issue in any released kernel, so we can do this properly.
>>
>> We should just remove that nested vm_normal_folio().
>>
>> Untested, but should give an idea what we can do.
> 
> This puts the overhead of vm_normal_folio() unconditionally into the
> pte_present path.
> 
> Although I am guessing that is already happening assuming prot_numa case
> is not the
> 
> hot path. This is fine by me. So I guess I shouldn't have done that
> "reuse the folio
> 
> from prot_numa case if possible" thingy at all :)

I mean, it only applies when trying to NUMA-protect something that is
already protected. Not sure how relevant that is in practice.

As we don't even batch these today, we could just do:

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 4e0a22f7db495..2154a1a3c6656 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -127,10 +127,6 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
         bool toptier;
         int nid;
  
-       /* Avoid TLB flush if possible */
-       if (pte_protnone(oldpte))
-               goto skip;
-
         if (!folio)
                 goto skip;
  
@@ -304,6 +300,9 @@ static long change_pte_range(struct mmu_gather *tlb,
                         struct page *page;
                         pte_t ptent;
  
+                       if (prot_numa && pte_protnone(oldpte))
+                               continue;
+
                         page = vm_normal_folio(vma, addr, oldpte);
                         if (page)
                                 folio = page_folio(page);


But with my change, we could actually batch-skip such large folios,
because mprotect_folio_pte_batch() would see the folio.

-- 
Cheers,

David / dhildenb


