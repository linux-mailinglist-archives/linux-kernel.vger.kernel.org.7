Return-Path: <linux-kernel+bounces-866874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE52C00E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA021A06F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4077630E854;
	Thu, 23 Oct 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b76Z/p52"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D63009CA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220172; cv=none; b=uEGyzTPJMIORvy6KSY0iKTZ4imYTLhAnDLZME6kVnDkkW7xOXN3QCgSmZfdz3PX1nwt/VjbfeaPurQAkkOdacjKAqZoprqIWkdYMgGByFOwQx/iV0yFQeZX3baBbw52n8E+CStHj78xnBtzDegi9dVUCluwv4aSVkpSqVTNpSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220172; c=relaxed/simple;
	bh=ggm7K33F2Lvf8aetxoMCpPifvf34MtktdbfMQDbo63U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elhxs8pWHWLSGIqzb2TcJgTcxU896NgWJkup9zcVCXBbPoAkXXsCsACx01ik5noAw/g+Y7nuVxijEt7HTm5YQK/Q4FjpROl+2nkD1u87szAGituCLSH3lOHmf2+7I634JEPlD88am69az/b4VEH0omOfafZt6kjk37gZI7T2E/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b76Z/p52; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761220168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JCBxlSGX2oKy9c5VZTiKe/QSwX2dngLFxql68g6Ybmk=;
	b=b76Z/p52zxZo7xjt83fwpgJer/gtHjQ0IVS5U/7X99UJJVTJziZ4Fez5Lm7ic/OZUsSq8y
	56eqaXhnACeA0OkH81MYSYGHMlKBrdXMfyMc6gMjBbDYQnqT6TjQ4SUmb0yK9T6aHp4bL5
	vVQ1OZmVHiNmcDlc9uMF9H711hBNZ1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-JUEhfr3TNhS69CNcGVqRHg-1; Thu, 23 Oct 2025 07:49:25 -0400
X-MC-Unique: JUEhfr3TNhS69CNcGVqRHg-1
X-Mimecast-MFC-AGG-ID: JUEhfr3TNhS69CNcGVqRHg_1761220164
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4256fae4b46so439555f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220164; x=1761824964;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCBxlSGX2oKy9c5VZTiKe/QSwX2dngLFxql68g6Ybmk=;
        b=VDhRyp73PoRm82oO23BOwiYB9f7c9R32h9BuDU7C+D6BGvvm72fw1cEHkx4MeQhP5Y
         cV9zS45JQs49lw31E6lVJ7fPxJkRLn/THyYzeIEU6f2v5E/qMeSdDDjcSHBcC7E9hcLy
         8bTXJbi2QhGutazlkEPw+OrNxRLjV6Os9jEYnvR/thQC3P1a3XZC3mJEHU13jhqqir7R
         jujrc1yBxPFDkUl5ajW6ay0pbTHXyrKcXSWnMrBS6xhH836/r/8kAq17RCfsMxhiyFql
         V+1i8TUzRiCfyYFTcNR9yybchK9ZXFkSQuBCLJ7CySWFABmayZ5dZY3aEbPaADvzO5vr
         76pg==
X-Forwarded-Encrypted: i=1; AJvYcCUUV4BSXDMM/XB/ipe8g7agb7+UVp4rx4N8WHtU6YczVHmVK9QvQLOp+yzvJCPDIWB+/EHdHiAlAZJthTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yfOf3SSRrMKD28kLgnZlGvE6s5JneERINnKGVMCU0/aG4Xfe
	NHpegR2eedQOe/RZBZR0rf4ffQLOFnFH2RL7xSbESIcl9AXLsIYz82rZHsea36yxWNn5DEaXVfa
	QgXxqqUuNK019y4kO1BhvA2oV35R5rO5qEuJI4zjrpUuNaL+j+DzEIS+6+19p1TzTHA==
X-Gm-Gg: ASbGncuqglobw76/OvKtuR6g/WZ7MmEbKIO/9jqt9REJ8VC5djuQJeOVN5yho2Bc3a9
	Ky9rwN1beR5XwuLUtscI0nrQKz63eC2El7fPTpCxdj1Vv9bR/p2muQxwenBhVOoks0u10gebly8
	mVT+jEkoKHpvDL32pmYACfAFd1c6oyIeMXXt10j9rXz+A2TiiHEp2nEdGvzQWHUdk925aX/qB8L
	c6wEe8PkYyiZR8Kasbnlybe2s7PEIK7nOxCfUn6Iy+/BGttoFr5tSRh5p5TDa1c5o6g+cv40DmJ
	FlpuTC7CTtTnYwin13qTQp3Yxj1EqR5O8HB8xE9kjGe1Ui0Zm8zYWLo20ZZ3OulSdu31iLNczuj
	iDA8A278sOfrlm3ODS3QpPZZxCKGgMfk/4bT+i/OSokqkSEPz4aHde2lITIxKwYhUQ5JgrKWxRJ
	y6glLvc3ZFFjjdqnoaBj4Xd2PO7V0=
X-Received: by 2002:a05:6000:470a:b0:427:491:e77d with SMTP id ffacd0b85a97d-42704da9e16mr15577041f8f.36.1761220164344;
        Thu, 23 Oct 2025 04:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJfOXZJEHV2NsbUj6aOO2PBD6VL5w9K1QsDgEyX5FiTcCiFyrw8Szd74pXh3vMEb+fyU8utQ==
X-Received: by 2002:a05:6000:470a:b0:427:491:e77d with SMTP id ffacd0b85a97d-42704da9e16mr15577028f8f.36.1761220163874;
        Thu, 23 Oct 2025 04:49:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc63sm3522878f8f.27.2025.10.23.04.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:49:23 -0700 (PDT)
Message-ID: <f57d73e3-fb6c-4c01-9897-c9686889fec2@redhat.com>
Date: Thu, 23 Oct 2025 13:49:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <06333766-fb79-4deb-9b53-5d1230b9d88d@redhat.com>
 <56d9f1d9-fc20-4be8-b64a-07beac3c64d0@redhat.com>
 <5b33b587-ffd1-4a25-95e5-5f803a935a57@redhat.com>
 <7fmiqrcyiccff5okrs7sdz3i63mp376f2r76e4r5c2miluwk76@567sm46qop5h>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <7fmiqrcyiccff5okrs7sdz3i63mp376f2r76e4r5c2miluwk76@567sm46qop5h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 13:40, Kiryl Shutsemau wrote:
> On Thu, Oct 23, 2025 at 01:11:43PM +0200, David Hildenbrand wrote:
>> On 23.10.25 13:10, David Hildenbrand wrote:
>>> On 23.10.25 12:54, David Hildenbrand wrote:
>>>> On 23.10.25 12:31, Kiryl Shutsemau wrote:
>>>>> On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
>>>>>> "garbage" as in pointing at something without a direct map, something that's
>>>>>> protected differently (MTE? weird CoCo protection?) or even worse MMIO with
>>>>>> undesired read-effects.
>>>>>
>>>>> Pedro already points to the problem with missing direct mapping.
>>>>> _nofault() copy should help with this.
>>>>
>>>> Yeah, we do something similar when reading the kcore for that reason.
>>>>
>>>>>
>>>>> Can direct mapping ever be converted to MMIO? It can be converted to DMA
>>>>> buffer (which is fine), but MMIO? I have not seen it even in virtualized
>>>>> environments.
>>>>
>>>> I recall discussions in the context of PAT and the adjustment of caching
>>>> attributes of the direct map for MMIO purposes: so I suspect there are
>>>> ways that can happen, but I am not 100% sure.
>>>>
>>>>
>>>> Thinking about it, in VMs we have the direct map set on balloon inflated
>>>> pages that should not be touched, not even read, otherwise your
>>>> hypervisor might get very angry. That case we could likely handle by
>>>> checking whether the source page actually exists and doesn't have
>>>> PageOffline() set, before accessing it. A bit nasty.
>>>>
>>>> A more obscure cases would probably be reading a page that was poisoned
>>>> by hardware and is not expected to be used anymore. Could also be
>>>> checked by checking the page.
>>>>
>>>> Essentially all cases where we try to avoid reading ordinary memory
>>>> already when creating memory dumps that might have a direct map.
>>>>
>>>>
>>>> Regarding MTE and load_unaligned_zeropad(): I don't know unfortunately.
>>>
>>> Looking into this, I'd assume the exception handler will take care of it.
>>>
>>> load_unaligned_zeropad() is interesting if there is a direct map but the
>>> memory should not be touched (especially regarding PageOffline and
>>> memory errors).
>>>
>>> I read drivers/firmware/efi/unaccepted_memory.c where we there is a
>>> lengthy discussion about guard pages and how that works for unaccepted
>>> memory.
>>>
>>> While it works for unaccepted memory, it wouldn't work for other random
>>
>> Sorry I meant here "while that works for load_unaligned_zeropad()".
> 
> Do we have other random reads?
> 
> For unaccepted memory, we care about touching memory that was never
> allocated because accepting memory is one way road.

Right, but I suspect if you get a random read (as the unaccepted memory 
doc states) you'd be in trouble as well.

The "nice" thing about unaccepted memory is that it's a one way road 
indeed, and at some point the system will not have unaccepted memory 
anymore.

> 
> I only know about load_unaligned_zeropad() that does reads like this. Do
> you know others?

No, I am not aware of others. Most code that could read random memory 
(kcore, vmcore) was fixed to exclude pages we know are unsafe to touch.

Code where might speculatively access the "struct page" after it might 
already have been freed (speculative pagecache lookups, GUP-fast) will 
just back off and never read page content.

We avoid such random memory reads as best we can, as it's just a pain to 
deal with (like load_unaligned_zeropad(), which i would just wish we 
could get rid of now that it's present again in my memory. :( ).

-- 
Cheers

David / dhildenb


