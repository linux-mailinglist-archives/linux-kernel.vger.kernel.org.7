Return-Path: <linux-kernel+bounces-874705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89257C16E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AE53BBCF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAF034F24D;
	Tue, 28 Oct 2025 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrP7iokd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2878234DB57
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686092; cv=none; b=MuNQgl8QMr3nMQwMLSCBzhf5kHJHr/EglHu5Zg3RRAYvQYN/mUrbdjHehBwrCkAuziEAJsC80W9KTIcoSyJ3i/UVnJ+B+srxq8krCS9vFlduepxNJJev3KVaaNr8PDQg4VK4ZruejtmgFmKfi/0wZFkF8S+m+Qh8Fc74x/w+zY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686092; c=relaxed/simple;
	bh=TSJqQiqcuIrrLHU2HBL8/BtxE2AmDhEy6dzxtsABhr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLcxK/A3i6q7FT8ygkBX5SN3lzMkAduJ8HF40g7B0tEpQK4qIzZitywxyK62Ew9mdntyV7xIKdalI5qYEPd6v9Hg3ich8VcQwacuIrnihz7CTeYA6d6wQ/MCfk1xObRH7D71HdQf1sJHA+o7Wih/4ZCRkZUWrNvw5+nlVDVRdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrP7iokd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761686089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HrvyEcRFoneqk86qrnzAoo3f6d+zdXeHYtZ1JCa9Ps=;
	b=DrP7iokdscZHCVhRXbjQ+4XSO3Pkl7bjW0wPc/2xUNJqfaq6Nausw8CX7RFcp3LAe85Oy3
	okQxmPel2+5NWTgzgq7I3M+PEcDkaxoBHqxNDzy0//yZkoaV9WSJmKjjmLP9y5DD8qP1Sm
	lCrJQwITRkIfEe2Fc3+0xPh4zNZMUK8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-wH57p0tEOJWhYNLYSehmiQ-1; Tue, 28 Oct 2025 17:14:47 -0400
X-MC-Unique: wH57p0tEOJWhYNLYSehmiQ-1
X-Mimecast-MFC-AGG-ID: wH57p0tEOJWhYNLYSehmiQ_1761686087
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-89e83837fadso1249517285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686087; x=1762290887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HrvyEcRFoneqk86qrnzAoo3f6d+zdXeHYtZ1JCa9Ps=;
        b=wtrzc1vpbm0v5I9ql3GSp5VH+SeszlQJskLZTMsOHN3lNNDoFiadH7g+xTgNCBnbUm
         76K1yOXuz79vMGtj4pGLYrzSj9N97c+GtqsuWwmbqR7l2wgcC7qPLBTVxi24VlGvU9/C
         Z5tnuJBMz5VpnDqiAKlfTbh2/PShEyFT9MAR71B/egK1QLNfhGIVVM+cf1wRBjctHuUB
         08QLz+z9pkaqFVoSRukv/otbELtPdkUizfT7cJ/5p4XhyKK737wr+7Xx67Uzlf9gG5bg
         GR8KDFR438FYnNo264Bcr/yo8WVKurKXLODpDCFg4k7ZX0Cc1RS+aUCjA1+pdvFRt1iD
         3mOg==
X-Forwarded-Encrypted: i=1; AJvYcCU16ex7rSewXuP6CVwOIQLiGTnf4KkqUPrr4NXKCv+rhmFtq7fzgpete98gGLBOOo2qdjLTbOvyhTZ9908=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYJiSY8YmBoB3l4qy6UuDdG9ya3pnsJ64m/Rd2uvRZrINFhgF
	0YNBynR7EsIkJJ1VHVyI0CUlsDM0uFbw67aam3BB/WD5vHU7KsskH3D5NrD1Jky9tDlR4spgHxx
	MfCyvcE3l4VZMit0SejVYekNEQJq4a3NLavTebVnldNL+KQXVmasF8rSbpoGy1X8fAA==
X-Gm-Gg: ASbGncum5wixFX4/e6i6OR8ksPIAkg5Ic+64J/CyEiZRiOI+tYKoJmuTa97LBBeTEuG
	S8HZatKFp/zCf9RDa6ch4WSvfql3Rl3tgf25E0NyX1tQAqbvQcJkuU75RxvWbNsjfQ0ORautEKv
	1A9FojHdm0lmXInAWHcnuZDZWnwjGSwnjIo7/zQ48jXAo4y/RIPPbNo20Ejc/8CwWSa4GjDAjIL
	F4Y+AyXHc1Krhgz/QnS975/a2YnLAn5FZBQCoEd0rkFgB5z7IRjThwdkHf2TRLzRrItl1VtqZks
	6S/1zrPIFr8l+IybuE8uik4pNecHRUV1BnoIk6Hp9XIphkrZBxYb3mK2LlBzADB1t5AsCQddld/
	mtg==
X-Received: by 2002:a05:620a:192a:b0:7f7:8271:1a77 with SMTP id af79cd13be357-8a8e426cda9mr126340585a.13.1761686087103;
        Tue, 28 Oct 2025 14:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8D9LTgZgrHHdWeOYc+DL8B2sdCN5Uw6C+NWfSsJhoUGyXAHdeOuejLijrW6CXCNixE1Fy2g==
X-Received: by 2002:a05:620a:192a:b0:7f7:8271:1a77 with SMTP id af79cd13be357-8a8e426cda9mr126337685a.13.1761686086724;
        Tue, 28 Oct 2025 14:14:46 -0700 (PDT)
Received: from [192.168.2.110] ([70.49.125.126])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254a297dsm929505785a.28.2025.10.28.14.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 14:14:46 -0700 (PDT)
Message-ID: <5cc06269-5a6e-4874-bf68-fa4790f22bc2@redhat.com>
Date: Tue, 28 Oct 2025 17:14:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: fix HVO crash on s390
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, osalvador@suse.de,
 akpm@linux-foundation.org, david@redhat.com, aneesh.kumar@kernel.org,
 borntraeger@linux.ibm.com, mike.kravetz@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20251028153930.37107-1-luizcap@redhat.com>
 <50d815a1-8384-4eaa-8515-19d6c92425b3@oracle.com>
 <20251028161426.35377Af6-hca@linux.ibm.com>
 <5c72e064-9298-490e-b05a-16be6b5590b7@oracle.com>
 <20251028170251.11688Aa3-hca@linux.ibm.com>
 <4f522b65-1ab8-4725-8da7-3f071e7919c1@redhat.com>
 <20251028193708.7213A7e-hca@linux.ibm.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251028193708.7213A7e-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-28 15:37, Heiko Carstens wrote:
> On Tue, Oct 28, 2025 at 01:15:57PM -0400, Luiz Capitulino wrote:
>>>> flush_tlb_all() however is the *closest* equivalent to this that's behind an
>>>> arch generic API i.e. flushing kernel address space on all CPUs TLBs. IIUC, x86
>>>> when doing flush_tlb_kernel_range with enough pages it switches to flush_tlb_all
>>>> (these days on modern AMDs it's even one instruction solely in the calling CPU).
>>>
>>> Considering that flush_tlb_all() should be mapped to __tlb_flush_global()
>>> and not __tlb_flush_kernel() on s390.
>>
>> You're right.
>>
>>> However if there is only a need to flush tlb entries for the complete(?)
>>> kernel address space, then I'd rather propose a new tlb_flush_kernel()
>>> instead of a big hammer. If I'm not mistaken flush_tlb_kernel_range()
>>> exists for just avoiding that. And if architectures can avoid a global
>>> flush of _all_ tlb entries then that should be made possible.
>>
>> Should we take a v2 doing your suggestion above for now and work on
>> the tlb_flush_kernel() idea as a follow up improvement? At least we
>> go from crashing to flushing more than we should...
> 
> That's of course fine. I guess for stable backports a small fix is the
> best way forward anyway.

Exactly. I'll also see if I can find time to explore your API
improvement suggestion. I'll send v2 shortly.


