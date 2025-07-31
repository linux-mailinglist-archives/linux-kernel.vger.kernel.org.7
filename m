Return-Path: <linux-kernel+bounces-752133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CFCB1719D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F11894A20
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4562BEC2C;
	Thu, 31 Jul 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMOPoOOv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF51E50E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966592; cv=none; b=Pn8rqqeyw0fySC5Gw/4sNqboCRF3udIMQu+gtI7bgaQXafJLp3M1h5Fwj3U1vdJOcoqa9pi8OPqbadSXMYKoSEDzN1nuCnhmCPQkRC7hoQrkT9qYo0X0APpnZgglHGRwIDw/dkg0Vd1rC0eKJ4djmAn8t09PgRcKnLlzIIuKAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966592; c=relaxed/simple;
	bh=RXeuAfQ4YDNnIha6BAWXMlvxcMYbfJ3/NcxuDcOMFgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdvIk1b5cn4WVRP45VJe/Ea8y+89WpSuddV82LohUi3etitdEHgOEyopc2veEDA1lA2AQafxksZ+hL3aFt7On4fg9OzCQHHni9zfrYbWevwGSsG4+8VelEMDm/gIcp64XA0wT9OokpuSTs4J3fjGlYoyL4bSnFuuqc5QSfh720o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMOPoOOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753966590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UcOt3lDwl5HSBcRvfgdcxrISNXFWOJA2vLtr2p4qtLk=;
	b=aMOPoOOvJ8OslHZw1KKiWKQCWJXBzRWBrgPV2NpxMEzbQs3ACGosCKvtlILXHssL2Qyk16
	UTC8dCdWP12NhaZeZXaaR0Ya8qtntgyz+VptZfzuHXrnJ9OBq53RtpvoteWvzEJ4qYPL8Q
	OD/S06SWV8/SCKsqZMXp7C2BFMgMGww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-WRaCzg4rP7eTstVBR9fDqA-1; Thu, 31 Jul 2025 08:56:28 -0400
X-MC-Unique: WRaCzg4rP7eTstVBR9fDqA-1
X-Mimecast-MFC-AGG-ID: WRaCzg4rP7eTstVBR9fDqA_1753966588
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7886bfc16so207354f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753966587; x=1754571387;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UcOt3lDwl5HSBcRvfgdcxrISNXFWOJA2vLtr2p4qtLk=;
        b=wiQi/0F2F4RBN4a9fOXSz4PI45ueYE+gIy8PZ1srY3brhTWOdwZivz0kJKm1ms2fes
         dtFMnLbZ55JunRtWwX7IIxuLGPPhwjUr/xVmWpY8Th/PV6O/P3otXvtoZgSExjLYEn5g
         rpOw3rRK/Vux89bU6JW57DIOPn+MqArrJKakmSlEU7J+tRprR8KBB2iOYpOnXLBWWKIt
         pabhCUKm2wn8SyH8NFFrOQElTZZiKCnfC8/haaxOjjSfwHe5xkCsUABt9CG6UXW1EUVP
         CFdh3Xp8YMqLsb/dzG3l0dUcZH/izayaZyNFpRaREID/vY/MKLfv3AVZ/1uCJrrhqFzt
         1NEA==
X-Forwarded-Encrypted: i=1; AJvYcCUGwYqNBkLpgD4/dK4d+166V6cH81D37ESP+uDQfHIu87AeMTVLSom6XJvD3sOEvtPB4UtXRwyljMYeW8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxjDK2HVc5MlHB9mTfclFO+R41y1pxWCSBA5m6J38WfOXCfSt
	/pHXBxWDU8Zma2HCMhar/QsU5RQgA8d1lYP7jn7HjG4aXuZuTjF/6k9hhFTxmi69lS6rPCfN2P6
	2i4sC2FynTGXhbqYCU+yJ/j36qczrIaskwyMqjGUB9nF9S9eIQEcQBwVegduEm4N55w==
X-Gm-Gg: ASbGncvr5qmlthU0krrGaTr248VDgl3FxEWTZKq+D9e6fthDl8072nK2GiNrdMZPlQH
	fYFNbU21HEjUYpsDAA+EEquvoktGIdJiJr+ME/JjY/geHnjN97B0W225H+d/FcjuLuguszXjZ3R
	KdG37RvwZ7ycHRub5xx8+vi1Ciu6Q0Lgslv9LZ3mCD7UnACkRNhXMZ9Q+G2fbLa3qY7bpz6xKFp
	T8wIcL0Od1xCcb+jdyamskHvrXYdBtG+xVuUt1vD9pU+H/IjNmxAKfCDew7og3I/2WiRkW4k0Tv
	5KUx0vJS9HtukVekjZPUI2TchPCWBoL2OEy1FgGMjC3OdYur9yrZVPJDT9vA2SxF8Y4hTuRJPJI
	n9u4W8NW33zIZ/Dxnu0+3ZC/vtqBJGZS9H9RZbN6IprTW9sLpwJ4CsCiojwy1ixui2lM=
X-Received: by 2002:a05:6000:2911:b0:3b7:9917:8b57 with SMTP id ffacd0b85a97d-3b799178f06mr4399056f8f.56.1753966587592;
        Thu, 31 Jul 2025 05:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEUGKyzKSROBWxRnVn35DU5KVo0FuypEf8UC38ej6rUCj170PDhpYsaBjudCBG7WOmh6rwMQ==
X-Received: by 2002:a05:6000:2911:b0:3b7:9917:8b57 with SMTP id ffacd0b85a97d-3b799178f06mr4399028f8f.56.1753966587144;
        Thu, 31 Jul 2025 05:56:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3700:be07:9a67:67f7:24e6? (p200300d82f443700be079a6767f724e6.dip0.t-ipconnect.de. [2003:d8:2f44:3700:be07:9a67:67f7:24e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2f03sm2278296f8f.72.2025.07.31.05.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 05:56:26 -0700 (PDT)
Message-ID: <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com>
Date: Thu, 31 Jul 2025 14:56:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
 aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com> <aItjffoR7molh3QF@lappy>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aItjffoR7molh3QF@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.25 14:37, Sasha Levin wrote:
> On Tue, Jul 08, 2025 at 05:42:16PM +0200, David Hildenbrand wrote:
>> On 08.07.25 17:33, Sasha Levin wrote:
>>> On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
>>>> On 01.07.25 02:57, Andrew Morton wrote:
>>>>> On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>>>>
>>>>>> When handling non-swap entries in move_pages_pte(), the error handling
>>>>>> for entries that are NOT migration entries fails to unmap the page table
>>>>>> entries before jumping to the error handling label.
>>>>>>
>>>>>> This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
>>>>>> triggers a WARNING in kunmap_local_indexed() because the kmap stack is
>>>>>> corrupted.
>>>>>>
>>>>>> Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>>>>>>    WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>>>>    Call trace:
>>>>>>      kunmap_local_indexed from move_pages+0x964/0x19f4
>>>>>>      move_pages from userfaultfd_ioctl+0x129c/0x2144
>>>>>>      userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>>>>>>
>>>>>> The issue was introduced with the UFFDIO_MOVE feature but became more
>>>>>> frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
>>>>>> PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
>>>>>> path more commonly executed during userfaultfd operations.
>>>>>>
>>>>>> Fix this by ensuring PTEs are properly unmapped in all non-swap entry
>>>>>> paths before jumping to the error handling label, not just for migration
>>>>>> entries.
>>>>>
>>>>> I don't get it.
>>>>>
>>>>>> --- a/mm/userfaultfd.c
>>>>>> +++ b/mm/userfaultfd.c
>>>>>> @@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>>>   		entry = pte_to_swp_entry(orig_src_pte);
>>>>>>   		if (non_swap_entry(entry)) {
>>>>>> +			pte_unmap(src_pte);
>>>>>> +			pte_unmap(dst_pte);
>>>>>> +			src_pte = dst_pte = NULL;
>>>>>>   			if (is_migration_entry(entry)) {
>>>>>> -				pte_unmap(src_pte);
>>>>>> -				pte_unmap(dst_pte);
>>>>>> -				src_pte = dst_pte = NULL;
>>>>>>   				migration_entry_wait(mm, src_pmd, src_addr);
>>>>>>   				err = -EAGAIN;
>>>>>> -			} else
>>>>>> +			} else {
>>>>>>   				err = -EFAULT;
>>>>>> +			}
>>>>>>   			goto out;
>>>>>
>>>>> where we have
>>>>>
>>>>> out:
>>>>> 	...
>>>>> 	if (dst_pte)
>>>>> 		pte_unmap(dst_pte);
>>>>> 	if (src_pte)
>>>>> 		pte_unmap(src_pte);
>>>>
>>>> AI slop?
>>>
>>> Nah, this one is sadly all me :(
>>
>> Haha, sorry :P
> 
> So as I was getting nowhere with this, I asked AI to help me :)
> 
> If you're not interested in reading LLM generated code, feel free to
> stop reading now...
> 
> After it went over the logs, and a few prompts to point it the right
> way, it ended up generating a patch (below) that made sense, and fixed
> the warning that LKFT was being able to trigger.
> 
> If anyone who's more familiar with the code than me (and the AI) agrees
> with the patch and ways to throw their Reviewed-by, I'll send out the
> patch.

Seems to check out for me. In particular, out pte_unmap() everywhere 
else in that function (and mremap.c:move_ptes) are ordered properly.

Even if it would not fix the issue, it would be a cleanup :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


