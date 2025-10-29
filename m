Return-Path: <linux-kernel+bounces-875929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B09C1A28A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC51425628
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBA52E1F02;
	Wed, 29 Oct 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHJ/EKKU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23729C13B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740153; cv=none; b=RiaYJaMkLXe9hoCJWMS4aGkWvlZ/gBWYxbz+Yt1sqZQfTpyDsank382tFd3f+AQELFLmqdPaAbl5J8v9GxWDmn3H2Cha6dcuD/fEVrn4pg+RP7K7qQEaYmbIlhQzYvxb2MLmCqvWdQ/qB9iWoidYSoW3nrs4RfRjY3oRP901J6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740153; c=relaxed/simple;
	bh=x9vrTfvNIqZkKoJz89lC/ZZ2ItECz4sP6HThMv4kSak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWIIW5RlHTOzbg5//iOanVwre7fUdCxVj+Bf/eT8WaU5U61KQnJ119/Lo5wfO23yBosFbhR3vL3NxPgvBc1uVPQrmctno7dXJpVlarnqMvI9N63U+VdQMJHzpSJHzkNTFymAeLxsC1DfcOXiXZSD9lB55wwF1fevBXGBE3bKcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHJ/EKKU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761740151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A2LLGcK+hTB7diSRVPmDLBi0AA16yQBkapdsK4RLPno=;
	b=CHJ/EKKUOueG/YiZzP1oxYa0CWFfbBqBZJVKEEqf6poIeknqzwa0rEGZuszf7g6I5Y1ct2
	ebXFOHj5xRJsPCRCBjmZlriNbE8seBOTR1seWFuzU/ar5S8UXaj/LtflrHCHI1nh1zKyF8
	hLzkNAhSynR8RPwsEqsZlNU1QclxgGY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-QJJamwE_MQWPjHZ9Yw497A-1; Wed, 29 Oct 2025 08:15:49 -0400
X-MC-Unique: QJJamwE_MQWPjHZ9Yw497A-1
X-Mimecast-MFC-AGG-ID: QJJamwE_MQWPjHZ9Yw497A_1761740149
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a1ba620dc9so261030185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740149; x=1762344949;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2LLGcK+hTB7diSRVPmDLBi0AA16yQBkapdsK4RLPno=;
        b=J7i/g1XWVM/mh4A/ySSFyWaljdhwyZKpGtlxn9GGdOU1VJclhvJY005CwBufWNMyAN
         AgAPXLzIw+INVxP8/hWndk8ig71sFJ3GbH22r7KMaXQYCx5VLSFoiw2rUo2SaRdr4ud5
         vMTgKHBvoXj7qJC8Pj9haRYhyvufBwBTW9RUF2+SFP0C/VhxLupz8s/V/SSJzESaDR23
         cj/FKtZZwcjy9JBJSnxu5pt/PLtfpAcFE91uphonP9pQ1P4VjSALxSWGrP2spWOQFDaR
         xMh8wSXIbSueptzMHHY15Z+AwTT9bTErymxxBT9qd4RBFbPgUu51u0NK9lsPrtr3Rlha
         ZTAg==
X-Forwarded-Encrypted: i=1; AJvYcCVOJV5k18bQinlNyjad4N8n7azjfriVjMSb53hAvfA8KQEynqsIL39bk7IdilJcenCMbFFQN950+c6wqJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhusC0i8jm7eJSQLqCeJz7cpcK8au18BDABshFaGow2Q/MN/Xx
	FLnw50KBvUPVCjqRSxPzbOr8Kh3vFnoF0MaYT4o82arBHvhGq/l6A+NEPqzwB2eC2JzEFKF5qCC
	j6FxwX+/Ccoxaps58cKqLqk3POu2cw/wsTKFna5dj6uOCa2eY7+lFhjHZCbhXkyqpkA==
X-Gm-Gg: ASbGncu1ENX0mkx2tF33n5vJzSJIE0F3VicSSn+WRVMQ1v2hI7CL0HHPUm4oZThPDQT
	ez714UxGz9F1suVoiOdPLAt89uPlCjPF3j0TWbl80W1mot4DJ20FYho+KyMU2Sy0mKmN+8HGBiq
	YnT8LMH1iBJOzFaAojZK9+xpxzKZdfynLefWvGrBJl6EKZaRePw0HDmbtkPqJs/TsXeSgHYgvBk
	BCNdpVBTkH+Ja0NCbr/rMGNayrGlpHh16x3TqeBYKk5ci/6Rry44PNg/YVNR09E7K6dTzm0JnkZ
	CbSDld6NCPnaiYiy/NScduQRRIU205jhoMANMtpK/5LSAxIJmEiPRvFX3ymYkz0XO1zHFGrh3Cm
	Nahj28MJKG5HWW1+6uCIOvA==
X-Received: by 2002:a05:620a:4629:b0:892:6e93:e029 with SMTP id af79cd13be357-8a7276580a1mr862370385a.30.1761740149088;
        Wed, 29 Oct 2025 05:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyumHWc8S9UaG4uGmnoGLKBMBA0S/1xJaGK1g8R1NYRMtc9AQHCDzfiJJ6iyUcmiHht4va/g==
X-Received: by 2002:a05:620a:4629:b0:892:6e93:e029 with SMTP id af79cd13be357-8a7276580a1mr862364885a.30.1761740148609;
        Wed, 29 Oct 2025 05:15:48 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8a8025fc8cesm328725385a.23.2025.10.29.05.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:15:48 -0700 (PDT)
Message-ID: <9a8254b9-92f8-4530-88e8-fca3b7465908@redhat.com>
Date: Wed, 29 Oct 2025 13:15:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Luiz Capitulino <luizcap@redhat.com>, borntraeger@linux.ibm.com,
 joao.m.martins@oracle.com, mike.kravetz@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, gor@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com, osalvador@suse.de,
 akpm@linux-foundation.org, aneesh.kumar@kernel.org
References: <20251028211533.47694-1-luizcap@redhat.com>
 <6bbdf4ce-10e3-429b-89fc-ef000f118fec@redhat.com>
 <20251029104457.8393B96-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029104457.8393B96-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:44, Heiko Carstens wrote:
> On Wed, Oct 29, 2025 at 10:57:15AM +0100, David Hildenbrand wrote:
>> On 28.10.25 22:15, Luiz Capitulino wrote:
>>> A reproducible crash occurs when enabling HugeTLB vmemmap optimization (HVO)
>>> on s390. The crash and the proposed fix were worked on an s390 KVM guest
>>> running on an older hypervisor, as I don't have access to an LPAR. However,
>>> the same issue should occur on bare-metal.
> ...
>>> This commit fixes this by implementing flush_tlb_all() on s390 as an
>>> alias to __tlb_flush_global(). This should cause a flush on all TLB
>>> entries on all CPUs as expected by the flush_tlb_all() semantics.
>>>
>>> Fixes: f13b83fdd996 ("hugetlb: batch TLB flushes when freeing vmemmap")
>>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>>> ---
>>
>> Nice finding!
>>
>> Makes me wonder whether the default flush_tlb_all() should actually map to a
>> BUILD_BUG(), such that we don't silently not-flush on archs that don't
>> implement it.
> 
> Which default flush_tlb_all()? :)

What I meant is: all such functions that an architecture doesn't expect 
to be called because they are effectively unimplemented.

Taking a look at flush_tlb_all(), there is really only a dummy 
implementation on s390x and on riscv without MMU.

So yeah, there is no "default" fallback one :)

BTW, I'm staring at s390x's flush_tlb() function and wonder why that one 
is defined. I'm sure there is a good reason ;)

> 
> There was a no-op implementation for s390, and besides drivers/xen/balloon.c
> there is only mm/hugetlb_vmemmap.c in common code which makes use of this. To
> me it looks like both call sites only need to flush TLB entries of the kernel
> address space. So I'd rather prefer if flush_tlb_all() would die instead.

I'd assume that we only modify the kernel virtual address space, so I agree.

> 
> But I'm also wondering about the correctness of the whole thing even with this
> patch. If I'm not mistaken then vmemmap_split_pmd() changes an active pmd
> entry of the kernel mapping. That is: an active leaf entry (aka large page) is
> changed to an active entry pointing to a page table.

That's my understanding as well.

> 
> Changing active entries without the detour over an invalid entry or using
> proper instructions like crdte or cspg is not allowed on s390. This was solved
> for other parts that change active entries of the kernel mapping in an
> architecture compliant way for s390 (see arch/s390/mm/pageattr.c).

Good point. I recall ARM64 has similar break-before-make requirements 
because they cannot tolerate two different TLB entries (small vs. large) 
for the same virtual address.

And if I rememebr correctly, that's the reason why arm64 does not enable 
ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP just yet.

-- 
Cheers

David / dhildenb


