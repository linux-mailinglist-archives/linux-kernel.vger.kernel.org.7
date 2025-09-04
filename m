Return-Path: <linux-kernel+bounces-800524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4BB438C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817C25661E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10B267B01;
	Thu,  4 Sep 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhsNwnYC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40074EEC0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981903; cv=none; b=LUNkXHRuNq1RgbcClE5hooJ7dP59Jwd3Nfbr9fAbrXO1YvcKDbqeXFQjIey33tMRHZq68dmwNswKbNZWoLNdZekXD/pP5FNpgVIVkUYxb1vc8cTDLfE5aUjam45rizTmpH+pKmQYPpdFh7JAWZgy1GDJduRynVo/9SSKnt/bRrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981903; c=relaxed/simple;
	bh=66nV7x9taXwzAR9J6YPlOauNzE3KaxTRy/9n9NnIgm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpR6pQad+PamT+uJnQrBu7gnkStCHCi8mvX9xvFdue3XOCAeRBIPI23n1a6d/YnDHkgpV1QKxqXGDJbqJIbS2uVnbQIvJ3WGg+ncQBa1zM4z7rbKNFLAdu+mm8J0dfm7yxfkVddMhrYMSl5UpK1c7gZ+MTqFjfj/IlhV+CJBNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhsNwnYC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756981900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iNez6/M9s3PJsme5pRqUUeFXGJSz6E2jhwKDhn5HC94=;
	b=RhsNwnYCGzBHvYN8pP22ZsRcSgJZAc0zL7TWBBELNVKycHwWAOEPXJLy2InhpgpkjQZUYM
	u0U58TaoEiBmDdg/DVwkVUuHrvT2zFZWJWSkY+fWjdSoeMnKjLt0YeuPUhLQGylq//VHJ2
	p4g1KNZ++W/vKEoQPikz1BJ0JxMVdSY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-Z0yX6yQqMVWqsnNtXkFa9g-1; Thu, 04 Sep 2025 06:31:37 -0400
X-MC-Unique: Z0yX6yQqMVWqsnNtXkFa9g-1
X-Mimecast-MFC-AGG-ID: Z0yX6yQqMVWqsnNtXkFa9g_1756981897
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b80aecb97so7363375e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981896; x=1757586696;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNez6/M9s3PJsme5pRqUUeFXGJSz6E2jhwKDhn5HC94=;
        b=ZEWzs8PEcjBLdZldexjWA8DyOT6eM2lcx7DR+j0xRqamhOl7HsYbhjMTDnJyIkhISY
         4oSy++bweMdA/8QctP1Wn+XKbHrZwyv8W3GJuE+2cPSqy0vIUHQRHlXL8c+W5GdHkh+k
         H3zY15h9PB1JDiiTpJ6Iwtk3v/bN7QKpWLSOkXymVk2XtXzWv8QzPOO/dX0eCUY1wUzA
         avt7zysoLOMRAJV3vNr5nnlkiJeF/2NGtZUXg7ITWRN/esqTGXcx+lqGQJsxUhulP+jH
         Qs7NtkQmhQ2fevkRUt65ng12nyu4ei8NTD/dsaIxTfsYAwhO4tLaTeGC3LkL0MVSlUhM
         oPOA==
X-Forwarded-Encrypted: i=1; AJvYcCXc5TKUWKGfravvvIgCwGz8rZzu2azYxnt1XGelrpFSiw4ZbLBAleZhn/irWhbZz14vGHX6fAtm2RYDOfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1782jgGESflXwdYHhm6+9TDHgY+Dhqb3n07nCyv4jPun++c+/
	Yg53PHWsi5JNGJb1waQrfGDGArKwYOHz7QiqQzo3Dqogr1KUNY9r+3tg3Gm4QeDpAxsroIJmySk
	V5TfzVbzqE7dTpsk5Bcej2D2hS0TtaAQykLhWSRr4/XTLtvYrPlnhvjkptVB0WdavyQ==
X-Gm-Gg: ASbGncvAZSVX+jxwqTJkjFBabzOlEyLxlAbSrDIjq5cUww9Lj3jGnDqKL5a613+RAK1
	I2i1jdUxcqktlMPF7ShJVElMKVB2hJeYo4wobD2cmSSGMwCu+x6Bqa2I6f4mdelXQPFyppWuY2j
	MOZYEG066Y87wGJGJtsOfevXLdYD0/dYH6yR1Uf0dURheR3/CmGGJwiPGEQNrCTu8sbrxvZ8Cpf
	7d5hdU0MQyP0cQvkIv1iCCBRoee55WTh3LaXFp9IBFBf/swPr3QhiqgJUYYgoSdcdEY5BpzD5PG
	JRjwlfPIUddkcadavawzCJt/8Cec9GdGaiG5A++tql0S0CXAUOlaTNdBBu1JvPxL70LUHZDEoiu
	5FzD/d7CzXYXO1BwbiD/2nltVsNqqhaBJIKhPNdWgf2/rlThyRMKwEMh8TOXs32t5
X-Received: by 2002:a05:600c:1386:b0:45b:81ad:336 with SMTP id 5b1f17b1804b1-45b855340e4mr168285055e9.16.1756981896481;
        Thu, 04 Sep 2025 03:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3MLtM5QDjEU/zOfZe3S/gDem/oxe78HJp4IABGPJ9GtWj8bc+E5LqhZjiV2Kjt/XWKXc5aQ==
X-Received: by 2002:a05:600c:1386:b0:45b:81ad:336 with SMTP id 5b1f17b1804b1-45b855340e4mr168284645e9.16.1756981895992;
        Thu, 04 Sep 2025 03:31:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d7ac825b88sm14277593f8f.7.2025.09.04.03.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 03:31:35 -0700 (PDT)
Message-ID: <0ba60468-fc6d-4f07-a9ea-e16b8bcd5575@redhat.com>
Date: Thu, 4 Sep 2025 12:31:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: tag kernel stack pages
To: Matthew Wilcox <willy@infradead.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20250820202029.1909925-1-vishal.moola@gmail.com>
 <96148baf-f008-449b-988b-ea4f07d18528@redhat.com>
 <aLdLDEW2d3hK4gUV@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aLdLDEW2d3hK4gUV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 21:52, Matthew Wilcox wrote:
> On Thu, Aug 21, 2025 at 02:44:31PM +0200, David Hildenbrand wrote:
>> On 20.08.25 22:20, Vishal Moola (Oracle) wrote:
>>> Currently, we have no way to distinguish a kernel stack page from an
>>> unidentified page. Being able to track this information can be
>>> beneficial for optimizing kernel memory usage (i.e. analyzing
>>> fragmentation, location etc.). Knowing a page is being used for a kernel
>>> stack gives us more insight about pages that are certainly immovable and
>>> important to kernel functionality.
>>
>> It's a very niche use case. Anything that's not clearly a folio or a special
>> movable_ops page is certainly immovable. So we can identify pretty reliable
>> what's movable and what's not.
>>
>> Happy to learn how you would want to use that knowledge to reduce
>> fragmentation. :)
>>
>> So this reads a bit hand-wavy.
> 
> I have a theory that we should always be attempting to do aligned
> allocations if we can, falling back to individual allocations if
> we can't.  This is an attempt to gather some data to inform us whether
> that theory is true, and to help us measure whether any effort we
> take to improve that situation is effective.
> 
> Eyeballing the output of tools/testing/page-types certainly lends
> some credence to this.  On x86-64 with its 16KiB stacks and 4KiB
> page size, we often see four consecutive pages allocated as type
> KernelStack, and as you'd expect only about 25% of the time are they
> aligned to a 16KiB boundary.  That is, at least 75% of the time they
> prevent _two_ order-2 pages from being available.

I assume, ideally, you'd also know whether all these stack pages belong 
to the same thread, not various ones, right? ("context" can matter as well)

> 
> As you say, they're not movable.  I'm not sure if it makes sense to
> go to the effort of making them movable; it'd require interacting
> with the scheduler (to prevent the task we're relocating from
> being scheduled), and I don't think the realtime people would be
> terribly keen on that idea.  So that isn't one of the ideas we
> have on the table for improving matters.

Yeah, while possible I am also not sure if we always want that.

> 
> Ideas we have been batting around:
> 
>   - Have kernel stacks try to do an order-N allocation and vmap()
>     the result, fall back to current implementation
>   - Have vmalloc try to do an order-N allocation, fall back down the
>     orders on failure to allocate
>   - Change the alloc_bulk implementation to do the order-N allocation
>     and fall back
> 
> I'm sure other possibilities also exist.
> 
>> staring at [1], we allocate from vmalloc, so I would assume that these will
>> be vmalloc-typed pages in the future and we cannot change the type later.
>>
>> [1] https://kernelnewbies.org/MatthewWilcox/Memdescs
> 
> I see the vmalloc subtype as being a "we don't know any better" type.

I guess this could get nasty once we would have metadata assigned to the 
vmalloc allocations (struct vmdesc).

> We could allocate another subtype of type 0 to mean "kernel stacks"
> and have it be implicit that kernel stacks are allocated from vmalloc.

Yes, that would work.

> This would probably require that we have a vmalloc interface that lets us
> specify a subtype, which I think is probably something we'd want anyway.

vmalloc subtypes don't sound like a bad idea.

> 
> I think it's fine to say "This doesn't add enough value to merge it
> upstream".  I will note one minor advantage which is that typing these
> pages as PGTY_kstack today prevents them from being inadvertently mapped
> to userspace (whether by malicious code or innocent bug).

Yes, as raised elsewhere, if we can do this consistently today (stack -> 
PGTY_kstack), fine with me.

-- 
Cheers

David / dhildenb


