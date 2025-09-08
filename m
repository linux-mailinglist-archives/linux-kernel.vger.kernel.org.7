Return-Path: <linux-kernel+bounces-805224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC899B485A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BE91B21ACF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB1C2E7BCC;
	Mon,  8 Sep 2025 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7UR3w1+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DD2E2DDD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317107; cv=none; b=aLAKFhkk36Gdp06UMSE+GRHSNr62AJWX4ZlkACTlMvIip8sjkRhzdmGJYMjkCvd5+65JTB3fZxNk96qtywq2AhMCb2bQaBp42iBgsbugQ9Jh9qfa8gCC76IQpe/bFa0GQy8ZE7qrtQR+soDR9zwXZfiPn7jeugo+LZP8cm5F0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317107; c=relaxed/simple;
	bh=xZyXSPN3TqXRpqby+u6K9RNCYtgzdNCtWWDdPtK6xoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mbt8X04Af4zcXTrZveGw3AgHmM1CXpVx3n7eeDQ1WFRN1obXEV9m4/UM/It5yvEz+Tti7e7bDt3kG2UNDw2jeN+ORy67jIEpfKwgbB8WBqPBFmJrRR/fS6Ld9XB4XL1LG5nw1PfaL0Ja0FbUrbCd/71qKwbkgKKgCM5HBlNHOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7UR3w1+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757317104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dHHdLgAcbywenL/cZnIRyAsE86ZGrixMjg4dNdyKV1E=;
	b=h7UR3w1+8dEC8ip1AYSmv4KW2fJlwxC40/wkWvpede8YNaLxCwHRV8mNXVucwJ/RDDfTmM
	B3ziODdGWUNRkauDIa3tOQRcVw8LmGSoniKOKUD+mXc/rujACYITDUm3RLnvDvNEMALgxi
	zd9oXfiA1HOjYnjwuUd97BUWNvkq0pA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-lHAljuldP7Or3JFGriA0Vg-1; Mon, 08 Sep 2025 03:38:22 -0400
X-MC-Unique: lHAljuldP7Or3JFGriA0Vg-1
X-Mimecast-MFC-AGG-ID: lHAljuldP7Or3JFGriA0Vg_1757317101
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb6d8f42bso38338945e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317101; x=1757921901;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHHdLgAcbywenL/cZnIRyAsE86ZGrixMjg4dNdyKV1E=;
        b=ktnmb5Vkxq7Q9HMart18zHfB01xTm4OMHavLBPCaPBNep/OFDcWp7LM3xqQ9oYecAI
         2VegydjcbBPo33OqRINei3c+bhMVNbi+UMemHEulglHSc3baH8e+AKzlHlUEYHS9WB63
         IZwXOPSHsjr5we7sKkRBJIc4xhBg7jVMl/ozeA/1i0MY3l9P/520k3hFDdHum1GYdQyx
         qcnpJl2UYZW55IaeFYUvyckbPj8WfszoylAd3OhdUEyzzORVv8KUA/WrpF4jdLD6n9Pt
         fDmUUCCAXhq6znn+LU8IDXZ2rhUg3lTEqCZADQh814XR2SkKjYPFmwqwQM6vVt1tI4+2
         brvg==
X-Forwarded-Encrypted: i=1; AJvYcCWvbCLl0EbHunIeYh8ql5xgHM1IFLdauDLuFrgth7cWfQAZE8AjcWqtVWqXENwEhrKZgtlfVbcZwiZo1OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnaDOh4XGFbb4cqA8XfjmwnFoGZt6Z5wYgMjiVuRxfLul2fJs
	l4YRkAEVk9F/ijOJ2AfjlxcmdtlQgOEqWrqHDB7ITJwnTb5WZWmxTznbMwP3eBlUQTnVa1dpYLy
	UpPPvXbenn85P2atYdSOJ8Iys0ROySnjxzXB2tvHRkVBfEcAOkAKMZqN9PuJZHvehLKb70yPTiw
	==
X-Gm-Gg: ASbGncs3rrVHE/CcM9Hqt2ckLYqAZZcLCSqKRBvdPGmllL3ILJ6tJimzTIKonrrpeaD
	lzHs8moCEU2+zPDMFSxygyvabSFZ/7XI7a2v52BDi0AhdsX+5HAPIBNNGv3Dr0SS4VO2Z2l1GWY
	Mhxvmoi6co/h226xtICY7m1wpnRCYm2KyJwFZSe7z4EwkZ4x46yIdUCyw2jbzPNg/ZjkHkHin/J
	ZqdCtxCANbwxR4sclicnHcZO1TGtzHDNb+BRcHlsva9HUM9lTXGzf+q+5G16oH1GL6ALRMvhWwe
	U55bzPL5IWn3TZYwTyqwWZSuY75XGw2vwyLrtNvp/XPihmbMTueauXKWzX0eroPsLQriVnY=
X-Received: by 2002:a05:6000:1aca:b0:3e1:2d70:6785 with SMTP id ffacd0b85a97d-3e643ff7737mr5284114f8f.31.1757317101307;
        Mon, 08 Sep 2025 00:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEi3ixPEd6PfcRDGE6ZK7yoXiFzuvm/dSuHsKQcRA2BIwiOIaHzlh3VPu6rAD/JstskdMYbg==
X-Received: by 2002:a05:6000:1aca:b0:3e1:2d70:6785 with SMTP id ffacd0b85a97d-3e643ff7737mr5284084f8f.31.1757317100864;
        Mon, 08 Sep 2025 00:38:20 -0700 (PDT)
Received: from [192.168.3.141] (p57a1ae98.dip0.t-ipconnect.de. [87.161.174.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e705508e22sm7508811f8f.49.2025.09.08.00.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:38:20 -0700 (PDT)
Message-ID: <5a1429ad-3900-404a-bdca-f25623ce603a@redhat.com>
Date: Mon, 8 Sep 2025 09:38:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: avoid processing mlocked THPs in deferred split
 shrinker
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 usamaarif642@gmail.com, ziy@nvidia.com
References: <20250908040713.42960-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908040713.42960-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 06:07, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>

Subject should likely be more specific:

mm: skip mlocked THPs that are underused early in deferred_split_scan()

> 
> When a new THP is faulted in or collapsed, it is unconditionally added to
> the deferred split queue. If this THP is subsequently mlocked, it remains
> on the queue but is removed from the LRU and marked unevictable.
> 
> During memory reclaim, deferred_split_scan() will still pick up this large
> folio. Because it's not partially mapped, it will proceed to call
> thp_underused() and then attempt to split_folio() to free all zero-filled
> subpages.
> 
> This is a pointless waste of CPU cycles. The folio is mlocked and
> unevictable, so any attempt to reclaim memory from it via splitting is
> doomed to fail.

I think the whole description is a bit misleading: we're not reclaiming
memory from fully-mapped THPs even when they are underused, because it
could violate mlock() semantics where we don't want a page fault+memory 
allocation on next access.

So something like the following might be clearer.

"When we stumble over a fully-mapped THP in the deferred shrinker, it 
does not make sense trying to detect whether it is underused, because 
try_to_map_unused_to_zeropage(), called while splitting the folio, will 
not actually replace any zero-ed pages by the shared zeropage.

Splitting the folio in that case does not make any sense, so let's not 
even scan if the folio is underused.
"



If I run my reproducer from [1] and mlock() the pages just after 
allocating them, then I essentially get

AnonHugePages:   1048576 kB

converted to

Anonymous:       1048580 kB

Which makes sense (no memory optimized out) as discussed above.


[1] https://lkml.kernel.org/r/20250905141137.3529867-1-david@redhat.com

> 
> So, let's add an early folio_test_mlocked() check to skip this case.
> 
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   mm/huge_memory.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 77f0c3417973..d2e84015d6b4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4183,6 +4183,9 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>   		bool underused = false;
>   
>   		if (!folio_test_partially_mapped(folio)) {
> +			/* An mlocked folio is not a candidate for the shrinker. */

/*
  * See try_to_map_unused_to_zeropage(): we cannot optimize zero-filled
  * pages after splitting an mlocked folio.
  */

> +			if (folio_test_mlocked(folio))
> +				goto next;
>   			underused = thp_underused(folio);
>   			if (!underused)
>   				goto next;


-- 
Cheers

David / dhildenb


