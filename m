Return-Path: <linux-kernel+bounces-756477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497BCB1B4DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A8D3B3E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB52749DA;
	Tue,  5 Aug 2025 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3s2UbGD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9760B227BB5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400293; cv=none; b=daAvw7KHyNtgoXMPOhwGJMs42/p62uX08SXilJTcn1PKBkrAbpD/5EIDjt/PqB0HKKgE5NoQmJYSrXkqIOim31HHIFfJCsTi2dz1TDRrnqOcb1xjrGS264qXY3Du+pJEl+mAdllxqfLiRa/lJ2ARZrYhq6R9hRQRNmpTWU6pyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400293; c=relaxed/simple;
	bh=RfLzX4Q4BxbnsHtU4GtgxETLEB/PtabHAd+a1FtlCB4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bs2LPlzZ7A6f7RE9VAjqj64hSCMJKabSDYtcKwFInLs0OqR/vCWQHCLf+LiJYYXWcvs5BgMLOmvUgOfAptSitYpum5ug1VlS3MxTlRDcnt7SYRpuI6NZRVS2ep90tobtfXxsrfvNnpvNIa89FiK51PBaFrW1RDzgfSdRj4E6Vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3s2UbGD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754400290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XYOJKTILfQciCJhITCN9P/oSYM+SzdAxmdh58NlLZ3c=;
	b=G3s2UbGDB50aN+w6Ov/AharsZ5pJS1LAguhNlhjNbIn0zM77DS1aF+kWaPfkumzUV5Cxzh
	7C00WcDjroS2GEYPEP07SvchOzmLPgIa3iJ3TkjRSgZJlspIZkooXKiUvsJ3kmHsbB3R3e
	PYT4DUEPahYWf6oqJip+/oE3moG6+CQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-bJvRdIjcO9WhSdHoEzSNgg-1; Tue, 05 Aug 2025 09:24:34 -0400
X-MC-Unique: bJvRdIjcO9WhSdHoEzSNgg-1
X-Mimecast-MFC-AGG-ID: bJvRdIjcO9WhSdHoEzSNgg_1754400270
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459e30eeea3so3696865e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754400270; x=1755005070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XYOJKTILfQciCJhITCN9P/oSYM+SzdAxmdh58NlLZ3c=;
        b=QuB8cb1XdEtQGiYUYGPBdmAxT+WlGX2OYlEIokwXPImA7xPNlUKNnl6dkkK9W9Ye3s
         oCJ4ObckqusvzZnGLsrfBl0pXBGeeNBJgJbkS0TJjWeX7VUUYh2udzVv/3MaXaU38fVX
         w4QjoLLB0N/jYeENImm1PXv7UrUE4iVJdSd+0UT0SqImFbVuJvJWIYd6a/c5Ut4DVPIf
         oysRaifAVkqG+XELJ6qcGz48XCc3uouyC/LyLUkK7NnjHFP/455NeWC8VLU+pwUMYBte
         6A+p5k86Il0yM2m4N3YBaGE1Pi9STRYZJAuutWi6rh8wH2sUl39MCJq2bmgK6d1Juww0
         9r0g==
X-Forwarded-Encrypted: i=1; AJvYcCU72981J1R2xJVoBhDCrLAjjnn+BLIkZQwxPUrpst4kRJFpq28WC0RNLoeOsM0WBXiLcOTjvJOd3Nira1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQn1IfMar+U1sjmaJUV5lpBSe8c9VolxN2vX/s85X01YoILww8
	PwhETfZchv1DlsOxKHW4TCYBQCRw4fSz3jY3Spf6f6e1ZsD1/x53FHMKNto4S1hokl1M1B5I9Ef
	MOWN/lcskeke/f9jqeWc90bgssbiMbK3/FBkUfZTa3SWz+vWIXe6sKc5KSYbeXJyI0Q==
X-Gm-Gg: ASbGnctAgtxL4fKbeuN6N1urs/2Ig/j8tLSa28OuYhBR8d4FUBB9mBgJJi+sNd1OCSy
	0tKJylcqME2+k+pHZT33A92s7skXOsi9JJ+AVxytexpmxyfaNnhQYe8OhoQR12cBW5rbKkkYDTi
	JRPYV7rphj3TdodUfpkqt9Ys9hQ00C5lK7B1mkEbXKCoSVOGKHySFu45d8XjdNPNsZtYLRFr3Gg
	twQthaBy7OqzigGBjuIh4vjZVti2RQyA90NuNveM2Ai1zmlOXirVviR2O92y1Nss6bdHzJuNsNa
	PiEdZvEnFD25Sd+EV2RGmW9bFejExhkGAZmGwZk03akERjrWisdgvOKMNKbx8zlxiA4jIEk6EEY
	mDxH5NQIvRbo5oP0mEjiRhfPbBkQpB5DcWbX4XrajvmBaCdRPa18xf6uazEaGPX++tIA=
X-Received: by 2002:a05:600c:1c23:b0:459:ddad:a3a3 with SMTP id 5b1f17b1804b1-459ddada9f2mr41838375e9.25.1754400269649;
        Tue, 05 Aug 2025 06:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr02D/Z7RCBEzNWKzAb5ZRGgoaEQj6y+Ky1C5usyKNW+A/uJvyYEO40lI8YVfU7KUse5YlTQ==
X-Received: by 2002:a05:600c:1c23:b0:459:ddad:a3a3 with SMTP id 5b1f17b1804b1-459ddada9f2mr41838175e9.25.1754400269232;
        Tue, 05 Aug 2025 06:24:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm19185818f8f.67.2025.08.05.06.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:24:28 -0700 (PDT)
Message-ID: <65fb1e02-563f-4323-8bc4-a81a6e6ad09e@redhat.com>
Date: Tue, 5 Aug 2025 15:24:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
From: David Hildenbrand <david@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lizhe.67@bytedance.com" <lizhe.67@bytedance.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com>
 <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
 <CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com>
 <7f891077-39a2-4c0a-87ec-8ef1a244f7ad@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <7f891077-39a2-4c0a-87ec-8ef1a244f7ad@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 15:20, David Hildenbrand wrote:
> On 05.08.25 15:00, Linus Torvalds wrote:
>> On Tue, 5 Aug 2025 at 10:47, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> The concern is rather false positives, meaning, you want consecutive
>>> PFNs (just like within a folio), but -- because the stars aligned --
>>> you get consecutive "struct page" that do not translate to consecutive PFNs.
>>
>> So I don't think that can happen with a valid 'struct page', because
>> if the 'struct page's are in different sections, they will have been
>> allocated separately too.
> 
> I think you can end up with two memory sections not being consecutive,
> but the struct pages being consecutive.
> 
> I assume the easiest way to achieve that is having a large-enough memory
> hole (PCI hole?) that spans more than section, and memblock just giving
> you the next PFN range to use as "struct page".
> 
> It's one allocation per memory section, see
> 
> sparse_init_nid()->__populate_section_memmap(prn, PAGES_PER_SECTION) ->
> memmap_alloc()->memblock_alloc().
> 
> With memory hotplug, there might be other weird ways to achieve it I
> suspect.
> 
>>
>> So you can't have two consecutive 'struct page' things without them
>> being consecutive pages.
>>
>> But by all means, if you want to make sure, just compare the page
>> sections. But converting them to a PFN and then converting back is
>> just crazy.
>   > > IOW, the logic would literally be something like (this assumes there
>> is always at least *one* page):
>>
>>           struct page *page = *pages++;
>>           int section = page_to_section(page);
>>
>>           for (size_t nr = 1; nr < nr_pages; nr++) {
>>                   if (*pages++ != ++page)
>>                           break;
>>                   if (page_to_section(page) != section)
>>                           break;
>>           }
>>           return nr;
> 
> I think that would work, and we could limit the section check to the
> problematic case only (sparsemem without VMEMMAP).
> 
>>
>> and yes, I think we only define page_to_section() for
>> SECTION_IN_PAGE_FLAGS, but we should fix that and just have a
>>
>>     #define page_to_section(pg) 0
> 
> Probably yes, have to think about that.

Ah,

#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
#define SECTION_IN_PAGE_FLAGS
#endif

so it will already be optimized out with your proposal, great!

-- 
Cheers,

David / dhildenb


