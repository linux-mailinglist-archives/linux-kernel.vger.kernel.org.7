Return-Path: <linux-kernel+bounces-629322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536FAA6AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 08:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15744639D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E86223706;
	Fri,  2 May 2025 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEoEJCiw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652502222C9
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746167369; cv=none; b=ELZKC8W3YJBIdZxnBVvueL964LHAaBQVVA4clS23pwmVLgh/KXZhmuHbhTUAeULRqO9DJNHLX3hrbFUyemUw+0IO1E6TIO14MYj6p2Hnj5OGfwHCP8ojct8amayfSMWGTOrjh1zsC3wgl/QOY9mcAQzZpK688moYfT9tyGk7kzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746167369; c=relaxed/simple;
	bh=gpvR3xf0hbx6fu80qYl+r1d3SugkgbEx8ezCMK8VYy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP4hJRcJCi5tkeZ43Nvyi29lCoNKA2ixRBj0nX8ztbXCsNDOsQDsnU/ya+nDS9r97g42yHhu1H1ONKQTcVs+q9HnEeZLDBbZUqqBnO0UYZMvGoozao7oBKxFdyt0Kxn1Q1i0QRu36yHIOHRAn3qPfln8hHFl/fAuJf0JyaCZ66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEoEJCiw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746167366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZDEsQl9wXHHDjWYntq9+iB6WMGNQimz1vP5zwMw6YQ=;
	b=aEoEJCiwgPML+OYA5DgqFWdB+LLxgDvGYkzUeUDXdLHVNAnJNs/sFWKBjlDP3xDaxW0elO
	mMI5v8dCVAKrmK113MT/gn5AcankXc16MAMdCbFKcNQ3XR+GJdViYS/tSVaksNpjVJLr0W
	j/5q9tW84RPU2KyeBwZPuIlkQVjsDT8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-DydHxJdrPdWCIYvGBb5cZw-1; Fri, 02 May 2025 02:29:24 -0400
X-MC-Unique: DydHxJdrPdWCIYvGBb5cZw-1
X-Mimecast-MFC-AGG-ID: DydHxJdrPdWCIYvGBb5cZw_1746167364
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d6c65dc52so11457395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 23:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746167364; x=1746772164;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iZDEsQl9wXHHDjWYntq9+iB6WMGNQimz1vP5zwMw6YQ=;
        b=WHnKAHA43KEi6XJI5wofOu+zTlDiKxcEf851zFl9iGzqb59ltDLZfiNQeWyZQHo/K/
         IVpfsAfzHPK3U/MYJA1UZ3jbSpVhsT5JSNhyoafXILlD2Lm82IC7hgEEVX4f22hhnuI7
         K9nIck2nxWkWoWSywvMhaTnTu2zgqi2xuEXPZNa+xJDHKwnK806be/uPRWd9sSGaXWMM
         tcu9MEXWdsg6Fovvq7/5+NoTkXEh3DaVyLPMaT6zuzuU5MesbtuCq+J5LHSgcC31OxuL
         Sx+LWtfOazqb1VW8bGzyvGDbSaVnhQhlwAQWQNQcjZTrCGDB0o+83sHofVHGt7PXfY8A
         +Hyg==
X-Forwarded-Encrypted: i=1; AJvYcCUxQx5Ucf51FPmjRGwlrf2HJKVkMclRuPA0jS9LDadKsK+Ofg70D0XPmUGx6W8VQ77/pgb+rc9J3eJ8PaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTea2ylBuTR5GgLFEMi2ZEhU9ur4o4aYJHOaq4ipCe5vV/kzTk
	brlxs/5nuYb7PDL+f7soAboFgR7sMVEiEZyqKeAmGC5G5Atm34r4HPE+Cyw7dAivRPhu5cU8ekk
	6EMZITsuNKVOP74oGX++rEtO4T39eI3sE9SQZS5b4vrhqbZSOJh8hjGj7yCwS0g==
X-Gm-Gg: ASbGncszTULuKo+e5JNeU3cuYa0ZjFfIyPGYSEfhhCISdq2ckWQNpue4P4g6QthJcnz
	rEzMvtfPSRsEdrpj49DX3KQgxvfBJh0/ftlhHKcqqmhfpAfjzvP6k8ddbBpdCSmPy3uxEzu/ZaW
	bA9NZlRZhtT4+zR2ZQHt+6hgFEco3JxqHEtnC9Kkat7dvalNeVPZuyIl1hp9/8kMjCm+SDFpXXl
	+QHXJXVk1/CTaA+4KntAo6v/+t1Fos7eJOMMYjwTwkz7L6zakqkdn5jHDKynbCZt+xPQQ74ACT7
	xz0LmkrCnLJeqHHZLUGpvQWZEbphziTDfKUQ+VU2NkRwPeB1dsapD+9iGf0Z/mdV+48LD0fCz7Z
	Yh3Lvm3M58n33C67c5II83vOy6nbXZPpz1CUfDpU=
X-Received: by 2002:a05:600c:6286:b0:440:6852:5b31 with SMTP id 5b1f17b1804b1-441bbec1e10mr11638225e9.10.1746167363695;
        Thu, 01 May 2025 23:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2+xVsQ0C21l/rgaRxgHSUEMDNv+GhVKjGW+Tkc9Q4XJjh9K2+iMYzkDzIzSpf98d4/5Cenw==
X-Received: by 2002:a05:600c:6286:b0:440:6852:5b31 with SMTP id 5b1f17b1804b1-441bbec1e10mr11638075e9.10.1746167363298;
        Thu, 01 May 2025 23:29:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:d600:afc5:4312:176f:3fb0? (p200300cbc713d600afc54312176f3fb0.dip0.t-ipconnect.de. [2003:cb:c713:d600:afc5:4312:176f:3fb0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af2a0csm79208595e9.18.2025.05.01.23.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 23:29:22 -0700 (PDT)
Message-ID: <b6093db0-9b18-4b70-81bd-6c02e80ac9fa@redhat.com>
Date: Fri, 2 May 2025 08:29:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: Nico Pache <npache@redhat.com>, Jann Horn <jannh@google.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-8-npache@redhat.com>
 <CAG48ez2oge4xs1pSz_T9L46g=wQnFyC63kQKsXwbHGRWAxQ+aw@mail.gmail.com>
 <CAA1CXcBHJbs7_DGVR929NOD5G4nkJ3LguDrL9itV8-QS+BNUpg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAA1CXcBHJbs7_DGVR929NOD5G4nkJ3LguDrL9itV8-QS+BNUpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.05.25 00:29, Nico Pache wrote:
> On Wed, Apr 30, 2025 at 2:53 PM Jann Horn <jannh@google.com> wrote:
>>
>> On Mon, Apr 28, 2025 at 8:12 PM Nico Pache <npache@redhat.com> wrote:
>>> Introduce the ability for khugepaged to collapse to different mTHP sizes.
>>> While scanning PMD ranges for potential collapse candidates, keep track
>>> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
>>> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
>>> mTHPs are enabled we remove the restriction of max_ptes_none during the
>>> scan phase so we dont bailout early and miss potential mTHP candidates.
>>>
>>> After the scan is complete we will perform binary recursion on the
>>> bitmap to determine which mTHP size would be most efficient to collapse
>>> to. max_ptes_none will be scaled by the attempted collapse order to
>>> determine how full a THP must be to be eligible.
>>>
>>> If a mTHP collapse is attempted, but contains swapped out, or shared
>>> pages, we dont perform the collapse.
>> [...]
>>> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>>>          vma_start_write(vma);
>>>          anon_vma_lock_write(vma->anon_vma);
>>>
>>> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
>>> -                               address + HPAGE_PMD_SIZE);
>>> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
>>> +                               _address + (PAGE_SIZE << order));
>>>          mmu_notifier_invalidate_range_start(&range);
>>>
>>>          pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
>>> +
>>>          /*
>>>           * This removes any huge TLB entry from the CPU so we won't allow
>>>           * huge and small TLB entries for the same virtual address to
>>
>> It's not visible in this diff, but we're about to do a
>> pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
>> entire page table, meaning it tears down 2MiB of address space; and it
>> assumes that the entire page table exclusively corresponds to the
>> current VMA.
>>
>> I think you'll need to ensure that the pmdp_collapse_flush() only
>> happens for full-size THP, and that mTHP only tears down individual
>> PTEs in the relevant range. (That code might get a bit messy, since
>> the existing THP code tears down PTEs in a detached page table, while
>> mTHP would have to do it in a still-attached page table.)
> Hi Jann!
> 
> I was under the impression that this is needed to prevent GUP-fast
> races (and potentially others).
> As you state here, conceptually the PMD case is, detach the PMD, do
> the collapse, then reinstall the PMD (similarly to how the system
> recovers from a failed PMD collapse). I tried to keep the current
> locking behavior as it seemed the easiest way to get it right (and not
> break anything). So I keep the PMD detaching and reinstalling for the
> mTHP case too. As Hugh points out I am releasing the anon lock too
> early. I will comment further on his response.
> 
> As I familiarize myself with the code more, I do see potential code
> improvements/cleanups and locking improvements, but I was going to
> leave those to a later series.

Right, the simplest approach on top of the current PMD collapse is to do 
exactly what we do in the PMD case, including the locking: which 
apparently is no completely the same yet :).

Instead of installing a PMD THP, we modify the page table and remap that.

Moving from the PMD lock to the PTE lock will not make a big change in 
practice for most cases: we already must disable essentially all page 
table walkers (vma lock, mmap lock in write, rmap lock in write).

The PMDP clear+flush is primarily to disable the last possible set of 
page table walkers: (1) HW modifications and (2) GUP-fast.

So after the PMDP clear+flush we know that (A) HW can not modify the 
pages concurrently and (B) GUP-fast cannot succeed anymore.

The issue with PTEP clear+flush is that we will have to remember all PTE 
values, to reset them if anything goes wrong. Using a single PMD value 
is arguably simpler. And then, the benefit vs. complexity is unclear.

Certainly something to look into later, but not a requirement for the 
first support,

The real challenge/benefit will be looking into avoiding taking all the 
heavy weight locks. Dev has already been thinking about that. For mTHP 
it might be easier than for THPs. Probably it will involve setting PTE 
migration entries whenever we drop the PTL, and dealing with the 
possibility of concurrent zapping of these migration entries.

-- 
Cheers,

David / dhildenb


