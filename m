Return-Path: <linux-kernel+bounces-806452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD22B496F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65241203A78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453431354E;
	Mon,  8 Sep 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dn7M4n/u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415AC31283B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352645; cv=none; b=he195zg80nNkujaWC1o9iWqpNCnNyWjMvcoPzDv+CCGZaosXw4PAGx3f3UkDmybTfgCF8DWaUGSCZAkOyD6ainvwQG21GHE+NYGn91qwnIW3ZqEf1C38QKFXuX70qsjhxMWYAHj9N3y2gvDMoWvvaCYZVoOcZ0Q75Mwl49gH4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352645; c=relaxed/simple;
	bh=JyPkBfczRRzXpM98VuI8SgsMu1wrAKH/fI6gRLdmGRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrroMgUszjQT3RLo2rwII2eWy/31fRGq6xQaus5Jd1Nw7tgzrKo21kw6Q07afV0iI8yeU+LyeknDX8sK+Mf4Da/1/iaxVNPQqpBHa2xSgPSHtIh4yXZSwxRB6aRXAYazranZVo7oabHX9j+JCSZ2ryY9lscl3tDP8c5yqGifSj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dn7M4n/u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757352643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RAwcm1nPLLX4X92euXLnYeRyvAbGSoqBmBe5SHTlwFM=;
	b=Dn7M4n/uL18CMRQz3835/ibmNp3mKtqdrGsHyDuHwXrWSd9n9XwKPXPuebjYRvyvLn0AEK
	90OcofXxFVLc1JTLQL2xH1fgU72W8KZ181QtsHksJXYHhQHQyIJIlixtNEW0L3b0rvmddA
	a1dlOnc5fk0SIdtPn+HoxEBvYbp0ePc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-0Hl_JFjXMsGl4kM9_fdlmQ-1; Mon, 08 Sep 2025 13:30:41 -0400
X-MC-Unique: 0Hl_JFjXMsGl4kM9_fdlmQ-1
X-Mimecast-MFC-AGG-ID: 0Hl_JFjXMsGl4kM9_fdlmQ_1757352639
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3df3e935ec8so2193137f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352639; x=1757957439;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAwcm1nPLLX4X92euXLnYeRyvAbGSoqBmBe5SHTlwFM=;
        b=M/fmg6JaCypp6LR6Ce34iN7XlGyBpYda6qpLfo5YmGfUPjyrdzGuLqyXwt3TzQr7U3
         FLhdaDjzdnlkln+dpsX5CcOnwoIO2FYnhYFjWRCm5SliOS5gqRCSkSTiKqj/NB41N790
         qX4DBbfm5hjek2gW0h0fgLNIRfwqwFuYwrWJ9SYTZgNJEIzM3qzN9vg8FRm7wiQSsiGv
         elilwHuIkndQ0R8hF8frR1C+jewPHHdUFDV04FnSzKRydiDBha4pcR7jEdOBBKmt7+3R
         zdxcqde5OAPi+hh0rrJO5wkj+2w7PRtNdY+mzarJRWZLAL7EQo0yQbI3CMfByJ4nFFih
         iUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgjtm5EMJgmNcih5gCUrSMVfFQJnlSNNj73dfawmAUOmWL8hMKKxuNkIUmIdXKZmqsIWZv3u3nPX3660I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN39Nliot9Mzi46BYqjyCkCHNe+bG9s+tXiqW1EAgK5Tmdp7wV
	AY5bAlC6H8sYK1IHIA3BqZXNhjROt5YA2eg2x8BiXzgOJOdWjWgtQiv10J+nNn92JT6G0Q3edMm
	7lP8miLT5+DQVuleMgFUG7Ro+Z7nfFS4zWXAsRsZv+DqThiIWPCVbfCdSlJAnDwOYgA==
X-Gm-Gg: ASbGnctyQ8P+HWH7YFFZkS5Cb1vtNoGaXRCGwi03ZZBswdNRKYoOfU//X+GMnNl+MGA
	62FmuSPAa4pusFIdfVuWzsKyE5nbAwOtBjp/CGisGL4LxPXgkSCpi88stxx2sSP5ZCy8eTsp+FE
	0mUNtwDZdhlY7B/yS93goiH9C+dg42Asw73a8IeGRopodtXI/k0VvHQwAMpJRFXbjlZCmECvB5J
	qVU9gMhURDNYlwDv2pWsPONMQx3cYdWP9vGZB0qD5khiJ6Vku75MlvRYzEbrUmfaVFeUI6aJSxT
	Ub8lQPjtg8QCOdjFXHaO0PWQXX47vKj6fhyC0kdKlJXMmBiV97fOCxzt91bmhtrhXhA8PxOunP8
	Qc3kfhNKUC70ZhxeaFyDZorg/J9YUI8/qg4cfulyTpfe5rXhMFh2rRYaCADKhZ/WD
X-Received: by 2002:a5d:5d05:0:b0:3ce:f0a5:d581 with SMTP id ffacd0b85a97d-3e636d8ff6dmr7012202f8f.7.1757352639355;
        Mon, 08 Sep 2025 10:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj6Fx/oJ/i3mGb5tdhsyoUu3a7TRpHUY03SW3dQRjVAjsi0xq639ZH0YB5uZksW3RpOLFefg==
X-Received: by 2002:a5d:5d05:0:b0:3ce:f0a5:d581 with SMTP id ffacd0b85a97d-3e636d8ff6dmr7012120f8f.7.1757352638837;
        Mon, 08 Sep 2025 10:30:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm197762845e9.3.2025.09.08.10.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:30:38 -0700 (PDT)
Message-ID: <92def589-a76f-4360-8861-6bc9f94c1987@redhat.com>
Date: Mon, 8 Sep 2025 19:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
 <af3695c3-836a-4418-b18d-96d8ae122f25@redhat.com>
 <d47b68a2-9376-425c-86ce-0a3746819f38@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d47b68a2-9376-425c-86ce-0a3746819f38@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 17:35, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 05:07:57PM +0200, David Hildenbrand wrote:
>> On 08.09.25 16:47, Lorenzo Stoakes wrote:
>>> On Mon, Sep 08, 2025 at 11:20:11AM -0300, Jason Gunthorpe wrote:
>>>> On Mon, Sep 08, 2025 at 03:09:43PM +0100, Lorenzo Stoakes wrote:
>>>>>> Perhaps
>>>>>>
>>>>>> !vma_desc_cowable()
>>>>>>
>>>>>> Is what many drivers are really trying to assert.
>>>>>
>>>>> Well no, because:
>>>>>
>>>>> static inline bool is_cow_mapping(vm_flags_t flags)
>>>>> {
>>>>> 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
>>>>> }
>>>>>
>>>>> Read-only means !CoW.
>>>>
>>>> What drivers want when they check SHARED is to prevent COW. It is COW
>>>> that causes problems for whatever the driver is doing, so calling the
>>>> helper cowable and making the test actually right for is a good thing.
>>>>
>>>> COW of this VMA, and no possibilty to remap/mprotect/fork/etc it into
>>>> something that is COW in future.
>>>
>>> But you can't do that if !VM_MAYWRITE.
>>>
>>> I mean probably the driver's just wrong and should use is_cow_mapping() tbh.
>>>
>>>>
>>>> Drivers have commonly various things with VM_SHARED to establish !COW,
>>>> but if that isn't actually right then lets fix it to be clear and
>>>> correct.
>>>
>>> I think we need to be cautious of scope here :) I don't want to accidentally
>>> break things this way.
>>>
>>> OK I think a sensible way forward - How about I add desc_is_cowable() or
>>> vma_desc_cowable() and only set this if I'm confident it's correct?
>>
>> I'll note that the naming is bad.
>>
>> Why?
>>
>> Because the vma_desc is not cowable. The underlying mapping maybe is.
> 
> Right, but the vma_desc desribes a VMA being set up.
> 
> I mean is_cow_mapping(desc->vm_flags) isn't too egregious anyway, so maybe
> just use that for that case?

Yes, I don't think we would need another wrapper.

-- 
Cheers

David / dhildenb


