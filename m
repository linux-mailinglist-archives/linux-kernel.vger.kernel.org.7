Return-Path: <linux-kernel+bounces-709231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90455AEDAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 13:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30678188CA97
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 11:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E982550AF;
	Mon, 30 Jun 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVLuXIu+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2D1E9915
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282485; cv=none; b=j3mk7ppAJeaVKO/9Ie2MPe7Z2kpnjslBNSs6JOJNMDLUj8s7wiVMfljOWScavunNgS7wFLgzbj4FuikEQBviO4A56yD5pz5RAMPfVfkZ5iiTwqBoctGppm/21G9AXA96loD2epqHRIaJF6fbqa1r0hN8rwc6zO48gY56EgQpHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282485; c=relaxed/simple;
	bh=zagiGetzIA1++oSbADmtE4GXUYvT0JU8xOoPCG3YlQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcjjxtK7vBXfhNYsRvGK2pKAjyLBYHSPY5UmrCr7ybQ5XlQfkp5gZHdqIuExirduHAwcI3BHMmNDr7IPyVAyq+4JUgyqe7tElfuR9DRboXadJKe8+JzbwcyTfT/1NBSkmRxvfeq9gYEakVlxBus6xH5gdVjW5ziiIeXjqomdVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVLuXIu+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751282483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GHq7d4kBQr5b6SaXfNxBCKaAAuq16nnAu0Xcwe1WZZU=;
	b=cVLuXIu+iAKEWaWA1hM+Wj8WkA+71rklzRhpMWQlC2Fz7ZK94kzbWSk3g2q1pcMi7jMV+V
	hrNZxOUZ/ZeSAz8EMkhZFEKkB4dbDzc5o60dH3R9L3scpYgWjtvWQEydl2OACi0Xv0FapA
	MFiH8hyM53FAKFpKedb5G1hjNXLGMdo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-V5rTBXmDNbGVgHFQ4nQETA-1; Mon, 30 Jun 2025 07:21:21 -0400
X-MC-Unique: V5rTBXmDNbGVgHFQ4nQETA-1
X-Mimecast-MFC-AGG-ID: V5rTBXmDNbGVgHFQ4nQETA_1751282481
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so1898831f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 04:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751282481; x=1751887281;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GHq7d4kBQr5b6SaXfNxBCKaAAuq16nnAu0Xcwe1WZZU=;
        b=pzh2yUUuvT76tnnLolfEQV8EhTHqqWrq2TDvKtG5PzEHJbfHzXHFhJ+RV2KQxM25jU
         o7bmG8W528a5focTOMqqLJoSX3XDmGgoZMa5kDd1o030OZGnypwalcJsxFeuc23DBqvZ
         pNIZcwgXOBNM6MQVe0j7t0oH1ZyDstXQ+6wHFjxNxytGWA1EAol6SKm5QjbZvZXZ3ixp
         V8/qFj/ToUSRSvva/vLBZr2b0nqpqbkGjqLAcOgrIQH6Is7MP8XnAIyDi2lUIRgN9h31
         G04WRwojr9ezLxxx6Gc1f6jBy69gxihmjvInyHB74tn25JN97SncA+dH0GqaZ/huf0EN
         9RzQ==
X-Gm-Message-State: AOJu0Ywm2HBI3NAvgkjDcGqhjG+Hxd5CBUihWj8iiePsGdCvDyRmRBwM
	uP2JfaTBPC+1OC15KVwSfwqRNsoLwC1Hf42oLFn2jkTqHGtYXhe/8eAvHEET7UJ0Sn93GK9vo5f
	wNJTB4NtKWnmCp50KWunTDE/ORHP/H/kaHRSSkL3D5bptb6wBzzgTYbJmVLRu41vTew==
X-Gm-Gg: ASbGnctjbi1BblVtMJCiK8/qTA3rYqoCTOswfz6XkECVjURngnJ2IbGQ3kcV+a2c3lV
	wfiOmWQgeGhRDhlVzTEdNROa2gGue8zUtLCyYBhmnN9TgzXzKfRG/PL760pCtMZKN8wNuytyIK1
	yo6aEG1lquWIOZ8gfpErj7fgwqNLkZy89XZcqt1ghbaxQMHZM/pu9qGN+IH7LgT2hjuqL8zua8H
	Szu7g8kPEBJeMbWkZVf0LXfZzE3JMizFw9MqbqLKctLMRXipFqh7otMGTxtla4drp0nh6H9a9X7
	IhgHBCNXDpuz1csXFHtFuQMhhA/j+eU9M0ynuNwbEBcAe3rGUz0L7t9WksBa+Qaz3l3B6n+gpRQ
	JQG/aJZgX7BiNkYIcZShEAq59di584pHEds5HnrghmOmsHLfaEA==
X-Received: by 2002:a05:6000:40ca:b0:3a4:c2e4:11b with SMTP id ffacd0b85a97d-3a90bba887fmr10737956f8f.51.1751282480672;
        Mon, 30 Jun 2025 04:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGha/FbwoUKKz1dKbhvLWpIEOwiWlylTo4MrTOZr74+kyRGbAsp4CVpch9K5kNJYsqrHjsrnQ==
X-Received: by 2002:a05:6000:40ca:b0:3a4:c2e4:11b with SMTP id ffacd0b85a97d-3a90bba887fmr10737924f8f.51.1751282480253;
        Mon, 30 Jun 2025 04:21:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f40:b300:53f7:d260:aff4:7256? (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e595c6sm10400813f8f.66.2025.06.30.04.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 04:21:19 -0700 (PDT)
Message-ID: <d0457f65-9627-457c-ad58-a40a9cb8fc21@redhat.com>
Date: Mon, 30 Jun 2025 13:21:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm: remove boolean output parameters from
 folio_pte_batch_ext()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>
References: <20250627115510.3273675-1-david@redhat.com>
 <20250627115510.3273675-5-david@redhat.com>
 <b6ccc61b-2948-4529-9c9d-47e9c9ed25ab@lucifer.local>
 <997a3af4-0c8f-4f8d-8230-08b43d0761b6@redhat.com>
 <4500541c-dde1-41a7-81c8-ac1573d05419@lucifer.local>
 <5513d9ba-80bf-49a1-9a50-e1a6814925e7@redhat.com>
 <428257a9-439f-43a5-8590-4de83d45e185@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <428257a9-439f-43a5-8590-4de83d45e185@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 13:18, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 01:16:52PM +0200, David Hildenbrand wrote:
>>
>>>
>>> @ptentp: Pointer to a COPY of the first page table entry whose flags we update
>>>            if appropriate.
>>
>> + * @ptentp: Pointer to a COPY of the first page table entry whose flags this
>> + *         function updates based on @flags if appropriate.
>>
>>
>>>
>>> And then update the description of folio_pte_batch_flags() both the brief one to
>>> add 'updates ptentp to set flags if appropriate' and maybe in the larger
>>> description bit.
>>
>> Not in the brief one; the other description, including the excessive parameter doc
>> will be enough.
> 
> That works for me! Let's not hold this up on trivia.
> 
>>
>> FWIW, I briefly though passing in an arg struct, or returning the pte instead (and returning
>> the nr_pages using a parameter), but hated both. More than these two stupid pte*.
> 
> Well I love help structs bro so you know I'd love that ;)

Yeah, I was more annoyed by a possible the folio_pte_batch() vs. 
folio_pte_batch_ext /_flags() inconsistency.

I'll think about this once more ... :)

-- 
Cheers,

David / dhildenb


