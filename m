Return-Path: <linux-kernel+bounces-837205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528AFBABAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077571C3E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75593296BDC;
	Tue, 30 Sep 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inG81Tjr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA117A2E6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214499; cv=none; b=flBBuZRAQupIbnVgf/1ECR71Y8w9hTY3FwESxB1tNE4c2CmzLyhNLVeXGCb7kyO2CXzMsjA+ObZv+EeNGSQ1JMgbOH6wJydnGJhZtxpUU4GZz+Wqz+c5NS3E+EkrO0Hjy6jBebiL8oonTdn/va7BsIs1VOwpf+A9XBBa4InF34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214499; c=relaxed/simple;
	bh=sF6nKId0shqlOT+yFucKXNJY+hnhCZWCkGkksj9v9bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJGiCPsj66IG3ASaRAi1NACK9HwV4X8oPX/PJNDcVc98Qw8uGKIrLTps6QTpRAoWN9lC61vhe/9/tfw74tTFxd5/0RJHVp6EAeK+2XLaZPJ4p05YdZAH9hgPEgOB/zlqMCTETEUn9OnD8l1pYhno6FLOcTK6hh3r/Uy6grTgDWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inG81Tjr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759214496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lYaoOw8qzwN21ASCyI37EJX6p2H1Y8ERe04KSYlj1rA=;
	b=inG81Tjr0VKv7VyIjZ6AdzWHcoi6cTV3hpW3JrEwJyTG5V3qIPfkDhUbUcQg1gTw4mTJR0
	7G6Z+KVbNfOyqGtvpExRilrlqOsAiZkQPrbNmqEDLXeh2tQ4H5wznAuphtRv5lVa1mBePK
	jQUb5LpbQr9ufFgrTcJP1Rz6eQYaD7Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-rmPRF6oONe2PwTLf8syPxQ-1; Tue, 30 Sep 2025 02:41:33 -0400
X-MC-Unique: rmPRF6oONe2PwTLf8syPxQ-1
X-Mimecast-MFC-AGG-ID: rmPRF6oONe2PwTLf8syPxQ_1759214493
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-41066f050a4so2736766f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 23:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759214493; x=1759819293;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYaoOw8qzwN21ASCyI37EJX6p2H1Y8ERe04KSYlj1rA=;
        b=lfyjoVdbemnWfF5ZEZK38LJM4hAN68zoXkgdQVdLp9a4YhF43EDLMmAfjFUobysosk
         Dyydxdo3dPL/z4pan5hkMKGRDoBdXVmQo/TFFEa19LvZNWzqeOifjgsZ3OQuBpFap/Ol
         fW6bGobuqwgyTWPRdEAUH6NysFFiH70U5UYk+M7fy/4AcLuKJWW08zlyCk1W3Vu4d0sC
         6OSum3j0AnKwfk3IekP3IB7hl3y/iktuLpZ/k0881PWQX1KvwXNNaqmFEZijyxXCyOp4
         AwDBA3qNQczSto5lXG9pQNRHOqq7XpSaqosklvJCc7Nx73fFsFjoaUmmHKZvD75aB5Rx
         WHfA==
X-Forwarded-Encrypted: i=1; AJvYcCXSzSnFr9JpqoMFQptW0mvpc4Upi1gBI7UfQnvPc/6JPxH9JsxHR0IUaVwnOmU3xLJ7kvOVSKEvab94YCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxLbgk/Bt+MWrsd7MjSlkeAPlEMLKjnpVIIXPv2BRLuE/u4+B
	QpS76WNIPXPK5Rw+Fcvhzz3jpxbK0vmR8wWrtvZ4IJhsmLzyaMLgCCUsAA08g+eqphm6bEAR+yb
	e33EC8N+dZVkbfz0o7dMxeT1SrjxVkKDcuRUAN5zFwURKjMls3VSXBFENJE7in4fcjg==
X-Gm-Gg: ASbGncuy+n3gQTNaCBWEQ2jrpjPLy3VE5cqEBo0lthluJNJ10hZ0x6YOyi7jO2DsX82
	LKwpbfwR8jbue7gfYakFkXLBQ4f8XNtDyF77yhhJd+T5Ng81pcGXYNaR9LkXPlj6Mfcg7ikFzaz
	liVxK634XTjv1sTX3zQ7fzIY7cz3taT8YQHn6q4WnAlE4ancNx6VIfFUBaNKry7PeUsWBfXP7Px
	E96m7Cn0ss/uSRSBaDAkXd4CM0Sh3W3mPYO8FOa0ne9f2LOCeBjY9nzbSEBOjvkJ2AW0Uq59nKn
	GbDeLwvsMGmUaUnce/KdcKVKBKq4rgSjmMvlM6Rf00S0ljWkBf1qlp5qFxHFv4ESKCSjmuSEgWZ
	kCmHqUVMC
X-Received: by 2002:a05:6000:3105:b0:3ee:15c6:9a60 with SMTP id ffacd0b85a97d-40e497c34a1mr15672030f8f.6.1759214492740;
        Mon, 29 Sep 2025 23:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQF9o5qWpBDFJJVt3D2oyXGVYSoEewGDgjfPn6Bd3CFXCSIuBY8r/0k5EG3CenB1jAXiThWQ==
X-Received: by 2002:a05:6000:3105:b0:3ee:15c6:9a60 with SMTP id ffacd0b85a97d-40e497c34a1mr15672008f8f.6.1759214492338;
        Mon, 29 Sep 2025 23:41:32 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d? ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31ea3sm253476505e9.12.2025.09.29.23.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 23:41:31 -0700 (PDT)
Message-ID: <f0f0479a-fdab-4f42-9600-5d7b44a73f4e@redhat.com>
Date: Tue, 30 Sep 2025 08:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ptdump: Replace READ_ONCE() with standard page table
 accessors
To: Dev Jain <dev.jain@arm.com>, Anshuman Khandual
 <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250930025246.1143340-1-anshuman.khandual@arm.com>
 <9736fd6a-8987-4b10-9b05-e03106463c34@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9736fd6a-8987-4b10-9b05-e03106463c34@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.25 06:37, Dev Jain wrote:
> 
> On 30/09/25 8:22 am, Anshuman Khandual wrote:
>> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
>> anyways default into READ_ONCE() in cases where platform does not override.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>    mm/ptdump.c | 8 ++++----
>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/ptdump.c b/mm/ptdump.c
>> index b600c7f864b8..18861501b533 100644
>> --- a/mm/ptdump.c
>> +++ b/mm/ptdump.c
>> @@ -31,7 +31,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
>>    			    unsigned long next, struct mm_walk *walk)
>>    {
>>    	struct ptdump_state *st = walk->private;
>> -	pgd_t val = READ_ONCE(*pgd);
>> +	pgd_t val = pgdp_get(pgd);
>>    
>>    #if CONFIG_PGTABLE_LEVELS > 4 && \
>>    		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
>> @@ -54,7 +54,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
>>    			    unsigned long next, struct mm_walk *walk)
>>    {
>>    	struct ptdump_state *st = walk->private;
>> -	p4d_t val = READ_ONCE(*p4d);
>> +	p4d_t val = p4dp_get(p4d);
>>    
>>    #if CONFIG_PGTABLE_LEVELS > 3 && \
>>    		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
>> @@ -77,7 +77,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
>>    			    unsigned long next, struct mm_walk *walk)
>>    {
>>    	struct ptdump_state *st = walk->private;
>> -	pud_t val = READ_ONCE(*pud);
>> +	pud_t val = pudp_get(pud);
>>    
>>    #if CONFIG_PGTABLE_LEVELS > 2 && \
>>    		(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
>> @@ -100,7 +100,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
>>    			    unsigned long next, struct mm_walk *walk)
>>    {
>>    	struct ptdump_state *st = walk->private;
>> -	pmd_t val = READ_ONCE(*pmd);
>> +	pmd_t val = pmdp_get(pmd);
> 
> I believe this should go through pmdp_get_lockless(). I can see in pgtable.h that
> some magic is required on some arches to decode the pmd correctly in case walking
> without locks.

pmdp_get_lockless() is a nasty thingy to handle selected 32bit 
architectures.

But given that we're using ptep_get_lockless() in ptdump_pmd_entry() it 
probably wouldn't hurt to use pmdp_get_lockless() here.

Staring at ARCH_HAS_PTDUMP, I don't think any 32bit arch would actually 
end up compiling ptdump.c.

E.g., on x86 only X86_64 ends up selecting ARCH_HAS_PTDUMP.

-- 
Cheers

David / dhildenb


