Return-Path: <linux-kernel+bounces-732534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8669BB06835
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01523AC838
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30B274B23;
	Tue, 15 Jul 2025 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvVEK9Ku"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352A285043
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613204; cv=none; b=IuFjZbqRzHq+6/ewKCF6gGS8LGnSd1BGSxZvwb6UJLmvNnle8AavDFp69a0hSJi19e67tvSuU+uHZxWWEAY3Olyh3BgY0YzF+47AA/mRDi9R6acr4pautPfFCiVH4Iy7H2NoELvbpbc7DpY7XDHwT+22SEHmHUtsmX0m32FqNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613204; c=relaxed/simple;
	bh=iE7fn1sEy74oxnwIRnDmh25m0BNjo2Af0l6QUHQSxLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFDfEzx2S/iVvWfrqjaljvNen0oDtL4YR6ThQvktuTTMBPNPxtLRLM6Z+oZRANSdIVYAsz+wPSxV0g9+pR7oJw//NHXNnrqysXmtqeOj3MrmQCcIKFl+8Jiock5Pa2NpD3qpkVIvhBWucVQOlglXo5i205xXS6yo0tePKyBEa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvVEK9Ku; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752613200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orfWWsl/2+Pf8r55VoCjlT3TESiqdbdfWb5bInIXtl0=;
	b=AvVEK9KuDBAzGjAQjiHL3MUYSYslakJxLz9PulH+J8FARFL2nd3olFphqfDbykHTr+2fX/
	jmXHcW24/4dblOZYmsiMhE4m6fMBKizksol8XgdN0qfSEaYlSNorsjsrIF49S9TJsJOO+b
	YyoDPlQqmOgCBG3w3nHzxdOyKD8Ahfw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-8heMpAEiOqqAOfvKzFK_Kw-1; Tue, 15 Jul 2025 16:59:59 -0400
X-MC-Unique: 8heMpAEiOqqAOfvKzFK_Kw-1
X-Mimecast-MFC-AGG-ID: 8heMpAEiOqqAOfvKzFK_Kw_1752613198
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so2592799f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752613198; x=1753217998;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orfWWsl/2+Pf8r55VoCjlT3TESiqdbdfWb5bInIXtl0=;
        b=UEGLkS+mcc9Kz4DL2cuguVeesyq8+B7VZDX1uOXC0lvsvyBSAqQa9Ax6dAmnHAIfJr
         afrvRj+USYe17VW9hLilHf6hzuIQBnTUrPoN+eEIj6WkV1qq4+ACShSWKAfX4sPx3iBg
         uG3gQKdXDuLOj//8f2R09dH04xDeH72TS8lkl8R2rH6X+zNV3VC/pDv0ITjyfyN7BC77
         Jg++vcRe3FcgBCkt+Mvrx+oW5Nr/ezIiAMJP8LWGoQDDLx8OmgkTtErLyHI74GI1MThm
         ke+fklLGNoJeTtf/qMoBGcroZVr0NfV+asdq0C4jngkFOAk3vFJlYfZYY3GZh348sGSz
         SN0A==
X-Gm-Message-State: AOJu0YxftdmR+9L0B6uIEHxF830TbrCmPiyqQmHxlTIWUsWYKjV7LhH8
	YeVzsO2JaMvyfHl0S87PiVzqhMlcuNcD+blJUpjQ9ZA6zwTw6j2nZ5h+4KG+B/1HUM1/x0NLw9n
	ghlpHanZaWGgye0vioeAOPZUyAEGYEB3XlMYITzTIbivp/Wd+J4SvDs8kEmKQ1QzFZg==
X-Gm-Gg: ASbGncv1/v63goVu47JF2f6WzdQnUDzWfBcYK9Ws/4QhkMAYwJYhGE75crEFRi4SEdq
	f7Pp6bExzwnZGeHzOCCtReNeuAbFXFlh3q1Y4Y8WVScJlfvRK8PqoIUcV0wqDyg7X4rBYShdHi3
	D8U9eocp2sujlX5OwmSkyJfdSGc2iW46PRuPW4xdxXaioHSTw4cCA8Ch/+qzjY52eIpw62WJeWS
	knqfFU8jo5j8WwUVDvt9ayfEXFCMHtkwSSAJ897EGetHSBRTsLbkc+RoWZVsu0B7+ekEZmgoZrE
	fJ7IULuqR79UdWFtYnyzkERVyqTf1E3QXcsMnqk0hYZ4tF8p+1s/LdNAmILYyeB2xDqHbMA=
X-Received: by 2002:a05:6000:2f88:b0:3a6:d26a:f0f5 with SMTP id ffacd0b85a97d-3b60e4ed4f2mr29337f8f.21.1752613197690;
        Tue, 15 Jul 2025 13:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyYymmr26QFygmkbNiXyQJM9jzV+eIWenc1xK+3dviERnxtgr6GW8Q8vgbqdgO2rkMKSnHcQ==
X-Received: by 2002:a05:6000:2f88:b0:3a6:d26a:f0f5 with SMTP id ffacd0b85a97d-3b60e4ed4f2mr29322f8f.21.1752613197179;
        Tue, 15 Jul 2025 13:59:57 -0700 (PDT)
Received: from [192.168.3.141] (p57a1ac9c.dip0.t-ipconnect.de. [87.161.172.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b60e3ed902sm76138f8f.91.2025.07.15.13.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 13:59:56 -0700 (PDT)
Message-ID: <00891d95-94c1-4cc7-a152-3d243a91afd1@redhat.com>
Date: Tue, 15 Jul 2025 22:59:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing page-extents
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ziy@nvidia.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
 <fe138d11-e0fe-4e57-8e51-a5521bad1b88@redhat.com> <87qzymocok.fsf@oracle.com>
 <9865895d-c9bf-42e2-b813-bdbd39ad3af1@redhat.com> <87ple2jysm.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <87ple2jysm.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 22:35, Ankur Arora wrote:
> 
> [ Added Zi Yan. ]
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 11.07.25 19:32, Ankur Arora wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 10.07.25 02:59, Ankur Arora wrote:
>>>>> Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
>>>>> where architecturally supported.
>>>>> This is only available with !CONFIG_HIGHMEM because the intent is to
>>>>> use architecture support to clear contiguous extents in a single
>>>>> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
>>>>> which excludes any possibility of interspersing kmap()/kunmap().
>>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>>> ---
>>>>
>>>> Staring at the next patch, I think this can easily be squashed into the next
>>>> patch where you add actual MM core support.
>>> I wanted to do this in a separate patch to explicitly document what the
>>> responsibility of the interface provided by the architecture is.
>>> That said, the commit message didn't actually do a good job of doing
>>> that :D.
>>> Copying the more detailed commit message from my reply to Andrew,
>>> one important part of the clear_pages() is that it be interruptible
>>> because clear_pages_resched() implicitly depends on it.
>>>
>>>> This is only enabled with !CONFIG_HIGHMEM because the intent is
>>>> to use architecture support to clear contiguous extents in a
>>>> single interruptible operation (ex. via FEAT_MOPS on arm64,
>>>> string instructions on x86).
>>>
>>>> Given that we might be zeroing the whole extent with a single
>>>> instruction, this excludes any possibility of constructing
>>>> intermediate HIGHMEM maps.
>>> Do you think it is best documented in the next patch in a comment
>>> instead?
>>
>> I would just add + document it as part of the next patch.
>>
>> Looking at the bigger picture now, you introduce
>>
>> 	ARCH_HAS_CLEAR_PAGES
>>
>> To say whether an architecture provides clear_pages().
>>
>> Now we want to conditionally use that to optimize folio_zero_user().
>>
>> Remind me, why do we want to glue this to THP / HUGETLBFS only? I would assume
>> that the code footprint is rather small, and the systems out there that are
>> compiled with ARCH_HAS_CLEAR_PAGES but without THP / HUGETLBFS are rather ...
>> rare (mostly 32BIT x86 only).

Agreed.

> 
> I thought about this some more and there are a few other interfaces that
> end up clearing pages:
> 
>> clear_highpage()
>> clear_highpage_kasan_tagged()
>> tag_clear_highpage()
> 
> In this set, there are many loops of the form:
> 
>     for (i = 0; i < n; i++)
>         clear_highpage();
> 
> At least some of these (including kernel_init_pages()) could be migrated
> to variations on a clear_highpages() which could be:
> 
>      static inline void clear_highpages(struct page *page, u32 num_pages)
>      {
>              if (!IS_ENABLED(CONFIG_HIGHMEM))
>                      clear_pages_resched(page, num_pages);
>              else
>                      for (i = 0; i < num_pages; ++i)
>                              clear_highpage(page + i);
>      }
> 
> (clear_pages_resched() should be safe to be used from here because
> everybody using this should be in a schedulable context.)
> 
> (The kernel_init_pages() was also suggested by Zi Yan in a review of v3 [1].)
> 
>> clear_user_highpage()
> 
> Only users folio_zero_user(), __collapse_huge_page_copy() and
> userfaultd.
> 
>> clear_user_page()
> Not many users apart from the highmem interface.
> 
>> clear_page()
> 
> Not many users apart from the highmem interface.
> 
> I'm happy to do this work, just not sure how to stage it. In particular I
> would like to avoid a series which tries to address all of the cases.
> 
> Maybe it makes sense to handle just add the clear_highpages() variants,
> folio_zero_user() handling and some of the obvious users of
> clear_highpages() for v6?

Yes, no need for excessive handling.

What I was getting at was: could we get rid of the kconfig option and 
simply glue it to the availability of clear_pages() in a reasonable way.

-- 
Cheers,

David / dhildenb


