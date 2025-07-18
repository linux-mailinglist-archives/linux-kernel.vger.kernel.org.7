Return-Path: <linux-kernel+bounces-736767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C20B0A197
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9383A3843
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625D33985;
	Fri, 18 Jul 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6ghCjhz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F82BD59C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836798; cv=none; b=lhhmaKgUtBHeFopWkS1iN12mZbSmhYo8Z3lRiGb0wKAeRSBrBd6WqMY1i/DNVyqUR7Wkfuys4ouSUZl9C7hGburwVOtwsK5cidN8/d0HKligqD1OW6RHnfKKnAvIGbSu772E/muyBR7HjomeSPUCNhiuroTQGv1/4QJ4LRfrHOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836798; c=relaxed/simple;
	bh=yV3C4OM0Ncg3Bd4NzNey4UabPHAiewsc05KQRlUt24g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAPu3a0XJgZHtpxnyP71o04PJq3dEN5YZIuAno7T1Dj0mAR/Q33e0eEOgWQXpOaApjMzrat93b39JlJiTjOG3M7BkEZPcDIbEDV/9q8twAwiI8dZRY65heata2TWp9ijvgewRzMDoYwZCYkQxGFHF8aiNLp/VLQgYBBOVrCGXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6ghCjhz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752836796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=21+i6/3q/KbRZs7c78B9Zaciwq4VXi+y94ZoRHHKkFg=;
	b=Q6ghCjhzEf3B3ry1MH8Kp6b9+6wxKV8vZbYPgdJVItblodhrs+nhB8dppSHM8k/5Gxq93G
	LYMYSWRjWjinMelDistziDK4N3BEKNKMFzbqnhnbxHkAyldRNZwsedlpMRJ+bjHidtZ9yR
	qrGkkWxzlRCAQ7WWFEvGxWr+K4NRbaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-jVG5-lcUPWSMAj510k5cVA-1; Fri, 18 Jul 2025 07:06:34 -0400
X-MC-Unique: jVG5-lcUPWSMAj510k5cVA-1
X-Mimecast-MFC-AGG-ID: jVG5-lcUPWSMAj510k5cVA_1752836794
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-456175dba68so15619745e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752836793; x=1753441593;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=21+i6/3q/KbRZs7c78B9Zaciwq4VXi+y94ZoRHHKkFg=;
        b=Jurr23nXn+wJuJsfxIExuyzyY4BY820rXts4ZtBa3XsCcoobR5noEi+Jx6+f52VAsp
         KHo6ZkBRTF0Cz4FxM0kA58Ya2MEzoqzjRcWG0tLVWcMgNdZNKDYRLOZyW8owrXbc/BQV
         E5bNuYUHYeGhCa5o5vRfG7LkbUAbIJoMgVS11lfbFNIljSG3XRoxv1ajlKrx0caiZ+dP
         nlN0KcVxmoKXPFNsouvj13RDdN1yU9Y/x9vZ+PKln2pSR6MfkYRM5Ib2/hBJdN5SVWMV
         f4gPu4lgS0a+9mq0mu51qyURsoz17Ja03qD8PyBqBZ1hQQLD89jvAG2Ea0mbV+qTVS0n
         9dOA==
X-Gm-Message-State: AOJu0YzFaVF1iSrbg1vt5xPvPdVsH8e9xTvGBD9/x2Kpsyq8sjpHHdjR
	HQLCLxoll295n5EKsarCOXh09OZLipI0ovr+Alm7z3WImj06W7jr5/XsAMXZybdF02gWevl6sAY
	h/ulLOb4wzcNYiJ7SnvwVXWyzsS3Cyf1xNJZrFq6dRAlzrqqWAB2Qjz9wBo9D9vacYQ==
X-Gm-Gg: ASbGncuB2PNyMXddL+v6dqQ4gbxjrXeVyqUo581lYzRkWpBkWLV3RzaHE7/v0RS1OnG
	urOjDYRU9ZFdX36Di+vP4PhQGGo5vhRtvvj6vVGqgO1iJJv9epvVbJvU4dfT+JRWg25kLzrEPoG
	IPPwUw5E0gUhol9XFGWdkuzHeAJLlNV3eRdm/6FQw/hyTSbVUEGTPU1klstntD9E+T7b2h7sDoj
	FBfvHGXG571S3ip0X8rvEcPFNVDRLwcevpBOz8AaAOAivdKbkkLoRKDi/4ttc62d7ZLYo0A5bA+
	PD7inE4Mbscsk0fJ/df+ySRzobw/2tbvMCzw07zxqmaphbzxYLnHCTBJD4lTkn6FUAQmh5MFPyf
	nrwTY7qFb2/Jr398aiuil67j+FpWO3XKaSiGcmAJ+deZjt2qlkiXcRCtpl10SLq7klgI=
X-Received: by 2002:a05:600c:1d20:b0:454:a37a:db67 with SMTP id 5b1f17b1804b1-4562e36c7a6mr117551445e9.17.1752836793576;
        Fri, 18 Jul 2025 04:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcJiqGxI9oDWWi5nW5+YKTz9nonD/LjKsAIai1+MhX5KKmpqdahPoV4Oxx3e4BuJMcH10ZFA==
X-Received: by 2002:a05:600c:1d20:b0:454:a37a:db67 with SMTP id 5b1f17b1804b1-4562e36c7a6mr117550875e9.17.1752836793013;
        Fri, 18 Jul 2025 04:06:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b740c51sm16819475e9.19.2025.07.18.04.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 04:06:32 -0700 (PDT)
Message-ID: <889dade6-8b3d-4cce-93ec-827886f7cb2c@redhat.com>
Date: Fri, 18 Jul 2025 13:06:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] mm: introduce and use vm_normal_page_pud()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
 Lance Yang <lance.yang@linux.dev>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-9-david@redhat.com>
 <4750f39e-279b-4806-9eee-73f9fcc58187@lucifer.local>
 <fdc7f162-e027-493c-bfa1-3e3905930c24@redhat.com>
 <15adb09d-4cdb-435d-927d-0c648d8239dc@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <15adb09d-4cdb-435d-927d-0c648d8239dc@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 12:47, Lorenzo Stoakes wrote:
> On Thu, Jul 17, 2025 at 10:14:33PM +0200, David Hildenbrand wrote:
>> On 17.07.25 22:03, Lorenzo Stoakes wrote:
>>> On Thu, Jul 17, 2025 at 01:52:11PM +0200, David Hildenbrand wrote:
>>>> Let's introduce vm_normal_page_pud(), which ends up being fairly simple
>>>> because of our new common helpers and there not being a PUD-sized zero
>>>> folio.
>>>>
>>>> Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
>>>> structuring the code like the other (pmd/pte) cases. Defer
>>>> introducing vm_normal_folio_pud() until really used.
>>>
>>> I mean fine :P but does anybody really use this?
>>
>> This is a unified PFN walker (!hugetlb + hugetlb), so you can easily run
>> into hugetlb PUDs, DAX PUDs and huge pfnmap (vfio) PUDs :)
> 
> Ahhh ok. I hate hugetlb so very very much.
> 
> Oscar is doing the Lord's work improving things but the trauma is still
> there... :P
> 
> Also yeah DAX ahem.
> 
> I'm not familiar with huge pfnmap PUDs, could you give me a hint on this? :>)

vmf_insert_pfn_pmd(), called from  drivers/vfio/pci/vfio_pci_core.c

Essentially, we create huge PUDs when mapping device BARs to user space.

-- 
Cheers,

David / dhildenb


