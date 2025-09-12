Return-Path: <linux-kernel+bounces-814153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9FFB54FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3945D170AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3E3002DE;
	Fri, 12 Sep 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvPEDHkb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098230F529
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684805; cv=none; b=OlmJiE+iNMc1CW3q3AGOMos5HwTd1Tzfd3uo5Coo9ci/uo7ZJSOV3MYeRuOFptu1MK1/UcyJ8vF3k89A4Qxjq3Z15TiMkPhYbaI0ktBZlH97vuQYY+RQOqCOaPgkSJXmVerVz2Km/zTmxIVBjCf3S8QsUaroiGRqtaC2yucaruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684805; c=relaxed/simple;
	bh=08mzWjt/6o6OaGoelal58fGoqDWE8lgwqZB2PCXBUOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvhPcOye7wku0v4BzePltcjt69t7MXFTefc4qIokuf2rX/UJstpi48YS3NLrwVW1hXwKhc5d+O54hNXz/+C+vJWfVyMbOMhZVEjAkyAePOq86a+kpVLqua+6q2bnKXtB4/UJN4LU4aOUuQTE5gftXCHPxyraRweE4M02bAzLHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvPEDHkb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757684803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LkEIiRRQkvSVtosaIK3QPaVmFb7eg/hw/VZ7vwDxlFI=;
	b=cvPEDHkbwVdVjhXJHYbsO2Cs3+KfqPMr2ga+Yys4lztjvw64zrd941NRjP2FmK93mJsI5g
	VZAJNkqhwsGp1kVSrPFAOl/2mXBIGA6bPExC7YhBhTLJMLTbK6ApjfyOlzlDC+JhKrb8ak
	NE7iLhIWKw0Mlj7Ve/JhoEnsFev+EnM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-CE_EmgFFOEi46ZQlB4UJqA-1; Fri, 12 Sep 2025 09:46:41 -0400
X-MC-Unique: CE_EmgFFOEi46ZQlB4UJqA-1
X-Mimecast-MFC-AGG-ID: CE_EmgFFOEi46ZQlB4UJqA_1757684801
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3df19a545c2so1431904f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684800; x=1758289600;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkEIiRRQkvSVtosaIK3QPaVmFb7eg/hw/VZ7vwDxlFI=;
        b=LCYUtVCq59xaGLSYn/F8af8DdSe8V6gioUIoZhKIrPq2/TxqEM+quxVXHlv/ugn5JM
         TxYM2FSIlrUTJpy/fJJHbAi9aEWUa+yKTSLGHYyle1/bPG6P2EVO/QxlZjohc+vZx2O1
         sPCiu6odkgVh4oAhHuRjIKH1ag43OM6juVnS/CTTWiKP4g5rDqlKR1irudoWF8urzHHZ
         9iP9qWDrebJZ8rARFufmdYd9HwPpGUlhXh/8VedzEPOgdWlbH0Mn96xz5n1E9z0szoOC
         ACkqxB3X6WU6B87jMouSHFn6wLrzeGp7Uoy3YJ2TsSS14roLTDauHGGKBiqL/pdGPMDW
         qhAg==
X-Forwarded-Encrypted: i=1; AJvYcCXIBubyH8sqQMGrSixQAkU5vFj0AGJXUD9Kagg9dxA+5quwRU/HGlm/CtNFXhhKQcJl0HERl+zfBd7rI+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyMtpZzBSaK7DkbTpxp2V5Rn0hDfh55+CHkEa86yU+p029i1R
	LPlrhW93vZ/b39sVkLnqLaPoKpjZ3zSkdpCA5BbJ7jhN+f6hp/UyhTMK0W71KtqbDu2pWzjrsWo
	jnDtUMo6444+ieSvfjTVsHt/abaAj18X9rPBPSYcJYN5GsWCwEevemrHeaRxSulByyQ==
X-Gm-Gg: ASbGncti3xZAd1SNTsYfb6o3e8jwvR/sRf3L+/q3liMLhQju1pJfA2B8i+OLJfrqaSw
	BHW+9QDWxEhu5Bif5AO/ya84GEjVqF5jbvBHyaSvrDXC22hvPhNOdpY6deoTpa6dZw3/RqkUAhT
	ijFniA06wCqgjiGITIz+k53icGSp6HiNbKgbyW3hOgqeagGcXer3fubNedIZQ0+jcxo25OFqvmQ
	A1sjdbz/458Ha90apF/KiGB5FYCqQnMOu137ZvaAH7Qooge8ncSixlGy4iNPF8jhdj+9qsEDzZB
	3mAK5xgVGEqlTTDvO+9k1D5X8EemWY7m6DXECZOxwnZiThKLGSanuyQo99wOy0o2aYEqavGHnF2
	zpyyO3kuXGSzpwFEI+2YtWYMX+87oWyn+gcwNcjMYaiZZA1tKlklAQkmB6iQs3oNF3kA=
X-Received: by 2002:a5d:64e4:0:b0:3e1:4d93:5580 with SMTP id ffacd0b85a97d-3e7659f409dmr2572913f8f.37.1757684800345;
        Fri, 12 Sep 2025 06:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh0SWF7pTljY6Vs/x3MxkGL3BzSuLf4FfxVO0ALVeWlY8LdDeumV7KYuM+jKuGgXdED/mnEg==
X-Received: by 2002:a5d:64e4:0:b0:3e1:4d93:5580 with SMTP id ffacd0b85a97d-3e7659f409dmr2572865f8f.37.1757684799824;
        Fri, 12 Sep 2025 06:46:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm1982983f8f.58.2025.09.12.06.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:46:39 -0700 (PDT)
Message-ID: <da251159-b39f-467b-a4e3-676aa761c0e8@redhat.com>
Date: Fri, 12 Sep 2025 15:46:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org,
 hughd@google.com, richard.weiyang@gmail.com, lance.yang@linux.dev,
 vbabka@suse.cz, rppt@kernel.org, jannh@google.com, pfalcato@suse.de
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <20250912133701.GA802874@cmpxchg.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250912133701.GA802874@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 15:37, Johannes Weiner wrote:
> On Fri, Sep 12, 2025 at 02:25:31PM +0200, David Hildenbrand wrote:
>> On 12.09.25 14:19, Kiryl Shutsemau wrote:
>>> On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
>>>> The following series provides khugepaged with the capability to collapse
>>>> anonymous memory regions to mTHPs.
>>>>
>>>> To achieve this we generalize the khugepaged functions to no longer depend
>>>> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
>>>> pages that are occupied (!none/zero). After the PMD scan is done, we do
>>>> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
>>>> range. The restriction on max_ptes_none is removed during the scan, to make
>>>> sure we account for the whole PMD range. When no mTHP size is enabled, the
>>>> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
>>>> by the attempted collapse order to determine how full a mTHP must be to be
>>>> eligible for the collapse to occur. If a mTHP collapse is attempted, but
>>>> contains swapped out, or shared pages, we don't perform the collapse. It is
>>>> now also possible to collapse to mTHPs without requiring the PMD THP size
>>>> to be enabled.
>>>>
>>>> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
>>>> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
>>>> mTHP collapses to prevent collapse "creep" behavior. This prevents
>>>> constantly promoting mTHPs to the next available size, which would occur
>>>> because a collapse introduces more non-zero pages that would satisfy the
>>>> promotion condition on subsequent scans.
>>>
>>> Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
>>> all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
>>>
>>
>> I am all for not adding any more ugliness on top of all the ugliness we
>> added in the past.
>>
>> I will soon propose deprecating that parameter in favor of something
>> that makes a bit more sense.
>>
>> In essence, we'll likely have an "eagerness" parameter that ranges from
>> 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if
>> not all is populated".
>>
>> In between we will have more flexibility on how to set these values.
>>
>> Likely 9 will be around 50% to not even motivate the user to set
>> something that does not make sense (creep).
> 
> One observation we've had from production experiments is that the
> optimal number here isn't static. If you have plenty of memory, then
> even very sparse THPs are beneficial.

Exactly.

And willy suggested something like "eagerness" similar to "swapinness" 
that gives us more flexibility when implementing it, including 
dynamically adjusting the values in the future.

> 
> An extreme example: if all your THPs have 2/512 pages populated,
> that's still cutting TLB pressure in half!

IIRC, you create more pressure on the huge entries, where you might have 
less TLB entries :) But yes, there can be cases where it is beneficial, 
if there is absolutely no memory pressure.

> 
> So in the absence of memory pressure, allocating and collapsing should
> optimally be aggressive even on very sparse regions.

Yes, we discussed that as well in the THP cabal.

It's very similar to the max_ptes_swapped: that parameter should not 
exist. If there is no memory pressure we can just swap it in. If there 
is memory pressure we probably would not want to swap in much.

> 
> On the flipside, if there is memory pressure, TLB benefits are very
> quickly drowned out by faults and paging events. And I mean real
> memory pressure. If all that's happening is that somebody is streaming
> through filesystem data, the optimal behavior is still to be greedy.
> 
> Another consideration is that if we need to break large folios, we
> should start with colder ones that provide less benefit, and defer the
> splitting of hotter ones as long as possible.

Yes, we discussed that as well: there is no QoS right now, which is 
rather suboptimal.

> 
> Maybe a good direction would be to move splitting out of the shrinker
> and tie it to the (refault-aware) anon reclaim. And then instead of a
> fixed population threshold, collapse on a pressure gradient that
> starts with "no pressure/thrashing and at least two base pages in THP
> a region" and ends with "reclaim is splitting everything, back off".

I agree, but have to think further about how that could work in practice.

-- 
Cheers

David / dhildenb


