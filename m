Return-Path: <linux-kernel+bounces-842621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B476DBBD2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290473AA520
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3211ACED5;
	Mon,  6 Oct 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f47erfIK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22024F510
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759734046; cv=none; b=NF5YDJd5L8i5K0aXhnIdgxxcaK5yR6fcRsD6z+NSmAF/6Qh3vvD/ftCXuTasHqU0MziuQy8j6R3k4hT/9aPCX8U/RfqZCTd9V3ks9iYkHHOXKKEueGy5Gw7QTZFBf0RqA6m1eZVI/e5Z5JpVcV+Ckj7XenVl5UZWSVqp35JQh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759734046; c=relaxed/simple;
	bh=Gvi7UH8MENlBOo4vPBqUfSZkLOgCiazwqGb5NpAxzzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmrmIhXGctfR2y+Q9KjRRDNRxTnBatKVfLXiU8ibf+Aa8LpG5D9eGfy8nZI4PaQbn+GBgg8f3hHR7XmjJtJDxgAd/41oO6P37AimG1t/EImIXlblWYMyAJC1WwzU3Xix/FjRAJZQM2xr5Gze259qiJkYbrJz51/1XMJNEIh12DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f47erfIK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759734044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FaGnOp3nPx7VlCT4vqkGBWd8zmqUqA0DpAI85zD6jQc=;
	b=f47erfIKDTs4GENTWhG98JYCaS4Z4XcjJHmSW9apOnezVEjZMpUTT9EisSx2tHcxnYZRAS
	Qb/05o+HGQcHR7mK4iMil1ggnjC+IBemYVZ8rNO29R44eOsxq/wXkXQw2mzunO1IJa3tgC
	PxImcHxk+gE4IpGjYDZs7Vm3m7rUyzE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-OIHAfyppOsaYuIygfEbW7Q-1; Mon, 06 Oct 2025 03:00:42 -0400
X-MC-Unique: OIHAfyppOsaYuIygfEbW7Q-1
X-Mimecast-MFC-AGG-ID: OIHAfyppOsaYuIygfEbW7Q_1759734041
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso2404544f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759734041; x=1760338841;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaGnOp3nPx7VlCT4vqkGBWd8zmqUqA0DpAI85zD6jQc=;
        b=Xjwy0HJILjbQz9b1l5/5x3hp2ZN2LqLaCOs2vvtz2drSv7z16r2Nq2WuQLGP2hJmbK
         Sl2uuW1IKQiq4NJJLGDwJhizE5dYgbkqZOz3/38kKBJ9BF3qaEDBlGZTlNZl3dX4d8Pm
         QfIQrpyY41mkXn2yQ5YrXOv17bxXTH2O//Jqlk69itU0Cvsq7DoEtyEMbAKl7cY/RSXC
         VIOlS0Qor4S+yd/sraOMym8MEGSvUkoWRxgbX6RCz1XqzJ52gygM5eqRTQrgNla/5Ll3
         orB1zI95T0M3n0AQKtoy/Kxa5mtcm6MX03casv6g4s+zW5l4zvTur3EhhuIk+LKGO34I
         +KDA==
X-Forwarded-Encrypted: i=1; AJvYcCU1xh9Pnm3lDiBKF3OScHXK546yOwp+7RqkL8fMmpYqWIQCOd7jZOJy3HGRyabm3Dm0KN0HmLMIX9093zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3cUJX4WPHKDUhEdNBI01CVdDAD/XNagIvXsmxr0MtWilbZC7
	jXpaeQPSDgbQSKxjo7NqHEBGSbR6ND0Fg2szItCSxQE7fkhcHn1wuLAZkdpv0kQmUiQm6eUWNuk
	9tjgRRki81ri6t7d+UmQDNEfplR/TFI+fmJYXnzlcGyJjpnhuZ9/gJHkJBsYl7uPESQ==
X-Gm-Gg: ASbGnctk6062F88exDXNX9pYQjQ0EfAkA3vOz1d/I6FebrwVIOR7S8tDMQ7u6LUyKjt
	KGnbWOiZG6EC8OgYB92Yj0BFJR9kzfbTABxEVF9d667s+b/XJoqxHerRQEVQpAa2ZORK9ceX2c1
	1q9Ra9u7CCgLkcplWuADKPbai8jlizAbFSGeAo0Y1LO3bzgUlLlKSFTuGvz3jeZ7JP5Lc84sN6c
	Y3DPeymN3QgYRZUairseUoFTczCcOChXh+amHfEDcIYU3tfYhO7uTErIzv98EjIiqsrnmMr0vz8
	k5RJTdEfEAEDcKKVh87p4jvBIpdWqcenEJcjYYh5ueQ8Uc9ytM1HUOgKHNJspqx5Xtd0iFOSuKF
	Vgl1Cuj3+
X-Received: by 2002:a05:6000:2583:b0:3ec:dd12:54d3 with SMTP id ffacd0b85a97d-42567176351mr6653602f8f.35.1759734041253;
        Mon, 06 Oct 2025 00:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJyRXVvWp7lKh4Mm+unXiZ6Z1ChboFVCaXHpiuwIGkUUAOEzvDQCLfW7UG3JyfvMv7UXnJ9A==
X-Received: by 2002:a05:6000:2583:b0:3ec:dd12:54d3 with SMTP id ffacd0b85a97d-42567176351mr6653575f8f.35.1759734040777;
        Mon, 06 Oct 2025 00:00:40 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4256866060fsm14171223f8f.14.2025.10.06.00.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 00:00:40 -0700 (PDT)
Message-ID: <65f4f0ab-e6ce-4419-9eff-c82befb6278a@redhat.com>
Date: Mon, 6 Oct 2025 09:00:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/dirty: Replace READ_ONCE() with pudp_get()
To: Lance Yang <lance.yang@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20251006055214.1845342-1-anshuman.khandual@arm.com>
 <4b513d32-7795-4998-98df-d398c3d5462a@arm.com>
 <1c948262-e201-4473-b156-8b90fedc9ce7@arm.com>
 <CABzRoya4kGWCFL95B2NEoLk4Qk9c3Vs1694NSWPFhiQiFHyomg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CABzRoya4kGWCFL95B2NEoLk4Qk9c3Vs1694NSWPFhiQiFHyomg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.10.25 08:48, Lance Yang wrote:
> On Mon, Oct 6, 2025 at 2:28 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 06/10/25 11:37 AM, Dev Jain wrote:
>>>
>>> On 06/10/25 11:22 am, Anshuman Khandual wrote:
>>>> Replace READ_ONCE() with a standard page table accessor i.e pudp_get() that
>>>> anyways defaults into READ_ONCE() in cases where platform does not override
> 
> Nice cleanup!
> 
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>    mm/mapping_dirty_helpers.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
>>>> index c193de6cb23a..737c407f4081 100644
>>>> --- a/mm/mapping_dirty_helpers.c
>>>> +++ b/mm/mapping_dirty_helpers.c
>>>> @@ -149,7 +149,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
>>>>                      struct mm_walk *walk)
>>>>    {
>>>>    #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>>> -    pud_t pudval = READ_ONCE(*pud);
>>>> +    pud_t pudval = pudp_get(pud);
>>>>          /* Do not split a huge pud */
>>>>        if (pud_trans_huge(pudval)) {
>>>
>>> Talking about mm, why not also make changes for these READ_ONCE accesses
>>> in gup, hmm, memory, mprotect, sparse-vmemmap?
> 
> Yep, I agree with Dev on that one. Because the change is assumed to be a
> no-op on all architectures for now, right?
> 
>>>
>>
>> Right, could replace all mm/ READ_ONCE() for pxdp pointers with the pgtable helpers
>> but that will create too much code churn in a single patch. Thought of doing these
>> replacements per file will be much more contained which is easy both for review and
>> testing.
> 
> Emm... as pointed out by Dev, it would get the entire cleanup done in one
> go, avoiding the churn of multiple small patches ;)

I think I'd prefer smaller patches here. For example, the discussion on 
the debug PT stuff was quite helpful and probably would just have fallen 
through the cracks when blindly replacing all READ_ONCE.

Having that said, combining some simple cases across multiple files does 
not sound too bad either.

-- 
Cheers

David / dhildenb


