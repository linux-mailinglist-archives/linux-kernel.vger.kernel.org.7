Return-Path: <linux-kernel+bounces-759871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B5B1E3C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2327B129F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB0F248166;
	Fri,  8 Aug 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkLp3nVF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F323770D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639146; cv=none; b=FnNDdicYliP0613aKNCud12qBG838kLRqEnfFpVnrndt3WyUe+IOBgS73b1f3JZQxRHi6qE0SrlJREGx3vZIBiGAOT+qa932DDWYh4+vEjdCIoU5bEoZR6bexRlEv3oU2bxBBZFu/qsyunxNYMQnfC774/t6ec/llt1YicNjWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639146; c=relaxed/simple;
	bh=a8oH4vc72EwOVQxEOxMgSpHCC375o9rsk/WFcT5M9JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg2ic1mdzUiritpOmKWWocriLTMeHB0gQUARGejxDsGQxVCHrKaF3MNOf8tESev4suLv/mP7u2p94nECYMT6It9lX4mT3FLQWLVP6b9K81H7wEOBOf/gx8/gG+QDxWTlBn5oujLl/rUAyuSvLn8eI0/B9Q+EPqRzDyWzc706kC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkLp3nVF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754639143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=off+V+WfSdu6BkP2pk0d17xfYRqm/hECfoU7LMpjnbw=;
	b=JkLp3nVFurY3e8aoCKVQS3QavvwEGvi5xdEMWYL3b//5qcFWcyV8QD3gARAZ3KhbXEHrSo
	mUSUCMrBDdZsG8EtfmDf27AczyLXMiULDaNY8DguKa0Fc0ib4ssgWyiojRqcZcQrvQkgYH
	L0H85zUOP87cRYCCYmJzAAahrAiU1oU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-aj8zoxKFMqWJ9mO_DIFCIg-1; Fri, 08 Aug 2025 03:45:42 -0400
X-MC-Unique: aj8zoxKFMqWJ9mO_DIFCIg-1
X-Mimecast-MFC-AGG-ID: aj8zoxKFMqWJ9mO_DIFCIg_1754639141
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459d665a87aso13635855e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 00:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754639141; x=1755243941;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=off+V+WfSdu6BkP2pk0d17xfYRqm/hECfoU7LMpjnbw=;
        b=kAimC3Xi3YWqT2SLg9pxhoXw4e+Ltnb+4m7yW93msyt0frS6YqdqiTs8+/eyJGmwd7
         uI+5VW0G+0viucUnbsqf0gC3uJTSWx2U7YlV9B2EYAVBvhHMLR4qkZYZRUa7iJxfzF4g
         W1QrDIB/JXJtLjOLECpstxg8Ca/UhpgAUifZlZutp64zZQltWPkwJr1fC/3LFRMWgPmT
         To0XTiTqjIyOt+6HPDDTDCffFIq0kCsDyT5FzSFC1IPIQoGCObKIMhRDD4nlB8tiJaXj
         w+lZaeRwQr/kWZPTnPjI7IBT8g2HYtTY2SDWuaaz7+23fd7wktUkY0SRHAPYojDRuEDi
         c1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXdbTD3GCRbbwqhduNMT5aJuEIGE5/N1W7tc8uoKmI1Iaps7+GtS1SGt0CC5lOKNcHQ/smbL27ZLbN893k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3kfuMqhxW//M/pYVfZrt3wCQ2UXgEkZlOh3AEF+eg+34KgNc
	dNrtwk1bJKfmMcIzkid7gMzFhNKgXsVE6Vd2T6l4CETImLV8t1C4BLlC7aqLgv3bVQ0DKFMCQex
	SZr+hChc8rjSFLKP1AjyD6uxcH9neUXktMmCpHA1ZOFgMS8HsqD5eyOmxjZ0wSJlaHw==
X-Gm-Gg: ASbGncvqo8vNdmpDWauIJVCBLSpRFb+keosLpOTspmrymO4OuDxUy3Kh1MxQz8fQZ1F
	FSjdo6zine7u58hRYEk7GMFuF42rxoyrFIuNFRdgX/7f84O3i2PCT27y/XOI6fbX7DIYYZE6MGB
	g3XI6XmJ6rEHbcazmpee4doP4ZHlhtpthcvP7X49yj5jEpzHqK3YUHaVSXEU8RhLEUrgNljRlAK
	p6CSi6QLJkGfnh49jag1YYI/HGFAkvAoRTxWviMnf+srmbVq3KTdlrSfookHq4dmPjPsyIb4Vbo
	mx3PvkK5dZJ/V4ABV9sGpW+Nweb6ihAW4pZcAdHEL+hQC/St1e7oVMBnAxR8GiGO2w/evwSGCkt
	glCZMCBTIFX5qw1D/eY2Do2AGvD6kURcew38iFW2UMG1umQUYG/TgHcuTtBc0UtdN
X-Received: by 2002:a05:6000:290c:b0:3b7:94a2:87e8 with SMTP id ffacd0b85a97d-3b900b4db70mr1365790f8f.18.1754639141345;
        Fri, 08 Aug 2025 00:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSQyZ6srhCQNBWcyjP7G0L44E2w5msI6TiW+KZd297AXzK4cJgdtoPU5jB4A7wacNHhMiWvg==
X-Received: by 2002:a05:6000:290c:b0:3b7:94a2:87e8 with SMTP id ffacd0b85a97d-3b900b4db70mr1365770f8f.18.1754639140894;
        Fri, 08 Aug 2025 00:45:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6? (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de. [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf956sm30052328f8f.24.2025.08.08.00.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 00:45:40 -0700 (PDT)
Message-ID: <b0d257a4-a37d-41da-92f9-4d1c0a11c30c@redhat.com>
Date: Fri, 8 Aug 2025 09:45:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
To: Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <158e6422-fc82-4d6c-a442-2ebe956a66da@redhat.com>
 <3fc75720-8da7-4f6c-bdce-1e1280b8e28f@lucifer.local>
 <6870e24f-dda6-421c-8df8-58294927b62d@arm.com>
 <ae01c6bc-019a-4263-8083-8ab073e72729@lucifer.local>
 <303b1764-6471-421f-b4c3-6a2585cee2ae@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <303b1764-6471-421f-b4c3-6a2585cee2ae@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> Not sure if some sleep has changed your mind on what "hint" means? I'm pretty
> sure David named this function, but for me the name makes sense. The arch is
> saying "I know that the pte batch is at least N ptes. It's up to you if you use
> that information. I'll still work correctly if you ignore it".

The last one is the important bit I think.

> 
> For me, your interpretation of 'the most number of PTEs that _might_ coalesce'
> would be a guess, not a hint.

I'm not a native speaker, so I'll let both of you figure that out. To me 
it makes sense as well ... but well, I was involved when creating that 
function. :)

> 
>>
>> I understand the con PTE bit is a 'hint' but as I recall you saying at
>> LSF/MM 'modern CPUs take the hint'. Which presumably is where this comes
>> from, but that's kinda deceptive.
>>
>> Anyway the reason I was emphatic here is on the basis that I believe I had
>> this explained to met his way, which obviously I or whoever it was (don't
>> recall) must have misunderstood. Or perhaps I hallucinated it... :)
> 
> FWIW, this is the documentation for the function:
> 
> /**
>   * pte_batch_hint - Number of pages that can be added to batch without scanning.
>   * @ptep: Page table pointer for the entry.
>   * @pte: Page table entry.
>   *
>   * Some architectures know that a set of contiguous ptes all map the same
>   * contiguous memory with the same permissions. In this case, it can provide a
>   * hint to aid pte batching without the core code needing to scan every pte.
>   *
>   * An architecture implementation may ignore the PTE accessed state. Further,
>   * the dirty state must apply atomically to all the PTEs described by the hint.
>   *
>   * May be overridden by the architecture, else pte_batch_hint is always 1.
>   */

It's actually ... surprisingly good after reading it again after at 
least a year.

> 
>>
>> I see that folio_pte_batch() can get _more_, is this on the basis of there
>> being adjacent, physically contiguous contPTE entries that can also be
>> batched up?

[...]

>>>>
>>>>>
>>>>>
>>>>> Not sure if that was discussed at some point before we went into the
>>>>> direction of using folios. But there really doesn't seem to be anything
>>>>> gained for other architectures here (as raised by Jann).
>>>>
>>>> Yup... I wonder about the other instances of this... ruh roh.
>>>
>>> IIRC prior to Dev's mprotect and mremap optimizations, I believe all sites
>>> already needed the folio. I haven't actually looked at how mprotect ended up,
>>> but maybe worth checking to see if it should protect with pte_batch_hint() too.
>>
>> mprotect didn't? I mean let's check.
> 
> I think for mprotect, the folio was only previously needed for the numa case. I
> have a vague memory that either Dev of I proposed wrapping folio_pte_batch() to
> only get the folio and call it if the next PTE had an adjacent PFN (or something
> like that). But it was deemed to complex. I might be misremembering... could
> have been an internal conversation. I'll chat with Dev about it and revisit.
> 

I am probably to blame here, because I think I rejected early to have 
arm64-only optimization, assuming other arch could benefit here as well 
with batching. But as it seems, batching in mremap() code really only 
serves the cont-pte managing code, and the folio_pte_batch() is really 
entirely unnecessary.

In case of mprotect(), I think really only (a) NUMA and (b) anon-folio 
write-upgrade required the folio. So it's a bit more tricky than 
mremap() here where ... the folio is entirely irrelevant.

One could detect the "anon write-upgrade possible" case early as well, 
and only lookup the folio in that case, otherwise use the straight pte hint.

So I think there is some room for further improvement.

-- 
Cheers,

David / dhildenb


