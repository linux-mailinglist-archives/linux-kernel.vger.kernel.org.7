Return-Path: <linux-kernel+bounces-728183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84D8B0245D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4171C5A7878
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97AB2F1FFA;
	Fri, 11 Jul 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+U0UFbe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366F2AEF1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261301; cv=none; b=W2jF5yRkK8F8I+XAcT5nhUJk3Gqjj6hLCVwunf9QAcm5kpu+kMdTt05m2mjmAPkmeol4Lbamu4p7OjHIQg0Hq1FX1tWls2t28RTCuIGhEbHL5m6L0np4jZy97wCduds1JYAByXCiinWNFb0DdnniPCk5dGDxsbXG7nWftZNb+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261301; c=relaxed/simple;
	bh=Uruk3H2g0XNEy6mEA/NvL/gnNZMNToLlruY4+EFrtsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goEoY8r2T4nNxSkOfPrxeo8o1XiGwlik4KPdsJxUbZWC+3MGpC5h0omydzSZRkhCwoNT7iQX3qwdhXGEmAy289XiXrnH/WDsGKs6sQUt6QpjoRN08dDSpNq+elfqiu8P55mM4DOodU4kzIwSzbyqgsL8YzKzcRm5duiP37TwS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+U0UFbe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752261295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x73vDOHVFNFFFNmyXaWRn2Hqby6A/rJdxBDJ0lg/l8s=;
	b=L+U0UFbey26p0ffk2VLN83i3bYRw21L915bRUgEgqYkyVJ2mSj493mqeT1btootdUVdG64
	ZQxV+yQR7J58Aga3djUjzBGfIDOF/5Vku0xSUB9qM2sKOTmSA7LkBD8rZXt1goPxfryMS0
	UfhetoUpLHoIlkkpJeuw2eUXyoT4fMw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-TonSsnsHMw60WlwjeGgqLQ-1; Fri, 11 Jul 2025 15:14:54 -0400
X-MC-Unique: TonSsnsHMw60WlwjeGgqLQ-1
X-Mimecast-MFC-AGG-ID: TonSsnsHMw60WlwjeGgqLQ_1752261293
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45359bfe631so14973625e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261293; x=1752866093;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x73vDOHVFNFFFNmyXaWRn2Hqby6A/rJdxBDJ0lg/l8s=;
        b=ZYj0inl0pi4y8LZAyB0/Gyc1j/i5tKfprkbJhJ5wkTZCye0wgrrxIdNvX61Ssl4UIF
         U+jip2jUVhah2DZWhARBjt45ijA3zQruM0+48NVxZ8hC6MdNpcF2k+xZQwzqek31ubCh
         eQtPzpYOFIqA0SlwzmIkXE/q96jp/DEiSuWM+JK20Vh/9jk8hhQLbuU8zShfm7prRmr0
         88rjVhuvDuPmERraNK/bXyytJZ5d/oLUEmRya1trLvNDQ7um/h3g4YyTQexnYMOwxdVj
         ia34FFB+rFOBk9k3MvLeUexicpwt+OFjQ9wPUuWleo76AEp78SOIaU25GxJX9Fc1Sl9H
         W+OA==
X-Gm-Message-State: AOJu0YwAWoJF9G79V2392rlEfuk8H7IPgHP5eAsxnj6MvnEAAhCSx0Ua
	lfRaSbMgX8HCQuy5zwsM5j0v7LQWZk4a/KOnZ84enZRfHoVkdYm++TwfP6dfwQ/SJ33WM6Z03w5
	9lDxezR0FTkfchvqaReIJ0xyaSEVGx/fxGyybU429D27N6dNFuZKAFYEunulLTG79Pg==
X-Gm-Gg: ASbGncuZLCUeQOm9l1MZv5jXx8WRt2UCqhpKi1tZZwtCP/nIFhr0bEKecouZf47bimJ
	dxijUZKzAmPiXUI1q1o/kCbZJOnnrYX3azolhqD2VcMZCTXl1OZyufUPfhkphjCPV5+DwCgGNd1
	B6Y1jaSU08REObOKqEEQ2mpJOJfD8aghkKKhWFcQ5jYjzJefHkLSKVLwQn9E8kqrCdIzF/+A+Pp
	b+HwxVHA2qHFa3Gb5P/lzHgjMJF/wRXPm8Ob6Dq71PV2M9f6nmpY8Ff9nOgX4Ox5jfQTCtEGYNE
	S6hZr2gLvsat3dk0mRVwaeCLyWxrwScVFTg3Kf6yyK85rG7adIS38h8YwYm8oOmQvSIB8x4NlBW
	aEbsvkaHyrck6qYueOiQ4yGhatfxSBDP1mLLp//YIBe9P7SNr3/Hqfhm4+TC6HOoKqR0=
X-Received: by 2002:a05:600c:6287:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-454fe10f108mr48366525e9.30.1752261293052;
        Fri, 11 Jul 2025 12:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET8nfY6nQTF1LjFcu5Dan27Zqi1z7O9GXMSzEjUhvggRBPghyXfAK4/VxcHkoIFe9ejiyVOg==
X-Received: by 2002:a05:600c:6287:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-454fe10f108mr48366295e9.30.1752261292533;
        Fri, 11 Jul 2025 12:14:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c? (p200300d82f0a2e0089cbc7f082f2e43c.dip0.t-ipconnect.de. [2003:d8:2f0a:2e00:89cb:c7f0:82f2:e43c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d511bd78sm95925055e9.35.2025.07.11.12.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:14:51 -0700 (PDT)
Message-ID: <2c6db237-3d64-43f5-8a20-168be5b248c8@redhat.com>
Date: Fri, 11 Jul 2025 21:14:50 +0200
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
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
 <a1575434-77eb-4358-896a-6d0e62feef4c@redhat.com> <878qkuprku.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <878qkuprku.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.25 19:25, Ankur Arora wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 10.07.25 02:59, Ankur Arora wrote:
>>> Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
>>> where architecturally supported.
>>> This is only available with !CONFIG_HIGHMEM because the intent is to
>>> use architecture support to clear contiguous extents in a single
>>> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
>>> which excludes any possibility of interspersing kmap()/kunmap().
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>    mm/Kconfig | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 781be3240e21..a74a5e02de28 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -910,6 +910,15 @@ config NO_PAGE_MAPCOUNT
>>>      endif # TRANSPARENT_HUGEPAGE
>>>    +config CLEAR_PAGE_EXTENT
>>> +	def_bool y
>>> +	depends on !HIGHMEM && ARCH_HAS_CLEAR_PAGES
>>> +	depends on TRANSPARENT_HUGEPAGE || HUGETLBFS
>>> +
>>> +	help
>>> +	  Use architectural support for clear_pages() to zero page-extents.
>>> +	  This is likely to be faster than zeroing page-at-a-time.
>>> +
>>
>> IIRC, adding a help text will make this option be configurable by the user, no?
> 
> I tried changing the value in the generated .config by hand and that
> reverted back to the computed value. So, I think this isn't configurable
> by the user.

Yes, I misremembered and the help text confused me.

So yes, the help text in that case (internal entries) is uncommon (no 
need to guide the user when there are no options :) ), but feel free to 
keep it for documentation purposes.

(e.g., HAVE_64BIT_ALIGNED_ACCESS does that)

Maybe we should call it similarly HAVE_... to make it clearer that there 
are really no options.

But I'm bad at #kconfig, so whatever you prefer.

-- 
Cheers,

David / dhildenb


