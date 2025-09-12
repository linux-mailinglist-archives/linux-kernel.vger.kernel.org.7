Return-Path: <linux-kernel+bounces-814463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7D6B5546A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FAC1D65724
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E54C22FAFD;
	Fri, 12 Sep 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f56cV9J+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9538FA3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693180; cv=none; b=cfsCDX3Kfg6Ue0PL5dLdNdc/K7kIc/i8f6OyPiUy/7X2/aRCh+iuTgC/nvRULMiz0OhuuY5AGKJDqu8skG1OSc3R5BtmY5Rkka0B5czxl/uY/VWObukIe4GCihJg7kGfYCTyR8YtR38/rwM/bZS/UBBq9Dptp915TX8IOxN42A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693180; c=relaxed/simple;
	bh=kKRzEF2tif2Gzp7LphMsgUe/IDu2VeQs/AdiCGVBxPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5hW6FaVCpWQF5HcHV/U22DCrrKiim2m2qx3Fbri/yA6XzV12rpS3gl2NIoGapQb6CFovzRjQkAwu2XpIB1UR0E7u50wVvsQpPd1/1h7+7unciZFE9fNamBqQwHhIA6sEAG2V8/AeFzjsAKfjCNpkv9SE7A2n4Sua212wahYhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f56cV9J+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757693177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dxzwguxznvqE0mx+qo75gr4n5bBcbz0Oi4oqNYnLVvU=;
	b=f56cV9J+Bbma3nFgjyBWOHXaDohY1g2cBPP2WAsmFi9bk3aeCeTE8m7THQbp3u4ho0V44b
	GjK9i0pH70ogjWQaFWbhtv9vwUIsraVaGk4AQwOzjol+q/PwLpu5FUff2vAKuQcX/R9LQl
	gsHIuI/gH0quvW6xZjFjZrn/vDp+VHA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-se8O4SdYPyObdV_zeba05w-1; Fri, 12 Sep 2025 12:06:15 -0400
X-MC-Unique: se8O4SdYPyObdV_zeba05w-1
X-Mimecast-MFC-AGG-ID: se8O4SdYPyObdV_zeba05w_1757693174
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e7696b36d9so475068f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693174; x=1758297974;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxzwguxznvqE0mx+qo75gr4n5bBcbz0Oi4oqNYnLVvU=;
        b=G6UE7NiPxb4kGskVfdNEGK0aP1+e8ggakNlhexTqPpuDgwSYmyaNlYtj2yXjEozhKP
         /l3D4aTXUdkWIjIY9N146vCijMv7YEwArPdp4z89Im350+LxlO4U4YsrobPB6W+UFzcp
         KFVVUH8CgB2NVFhjVsNcfVjouzxXW1+RurJXkj99LSwIF/onqF8KsONDXVHmgkO7AgCl
         QFwIT/CIzVswxnwJtkVRTqVE3uKCTtaqX2PkVdVpQSXhBlCqKaaOr5DLoqm777IBm0r5
         3LG83lrrmCGzbanqkIT806KJMmHXeOHF9SaMWVs39shjQJGsNPk1ZM8a54q26v0GeZwz
         e33g==
X-Forwarded-Encrypted: i=1; AJvYcCU+iVpeBCxGBjDo6LreZS/G2eoyllFxkpSV08LGbTcvnsU9opMt4evFnYvSKSlem9y4YOkR32hUm7fzqow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFv0v1u5uX6bgqnrGQhP1+mYautDfj4Hu6sq/TYuZbNpDnf7p4
	unI9z1xw6j/hLzsC2mlqpqCMExyPKwdsy3MVcM0D5R+cyfKnm0fcY8zH2y+wyrFMrv6JNp7cW3T
	gggcwbnYRj7xRhOAcvq9xSA4032aQkyLZg4KFZ56P9yxSgS1DWscq8XnbyLrzn8uQWA==
X-Gm-Gg: ASbGncu7Zglcj4bou3Jp+B3iTEgL6BDviDqUAWxHTZnB5xNM8s75i4aPi3X4kI4WKix
	pXFrGEGBCV3QhAjRPYkCQRLH8Z4dkh/WrS4H3OWsQt5yrOtzHLowEnxBGKgvf+XCwfy1mrtcT7p
	n+ybhwr+cNjoracNYh6akIGFwWbTdtTQPotjgQmuMBU3ecjoxjBwDnpTRvmV2qle/hbRoaCPSVZ
	mU8dMYFn+z25lOzkaaSDqWsJb1gkVFsGuWv+8hsOkDOJ2W48wCfeFtb8k1QqwWcDcgcLNElfO2b
	x/VQDABQCqQVtqncSkP3u+P1PNh2vtdJtTsP3whfxTQBm5qhng9h9q5TNat1cDPhzGNRiz5VO4N
	6LL30BoGANCyzHGQ0zkUm9NSxQxccmMLCrTWeIEPq8zaB0+5pWo0njlg1LedYY05UZfc=
X-Received: by 2002:a5d:5887:0:b0:3e7:44c7:4bad with SMTP id ffacd0b85a97d-3e765a36ea1mr3659992f8f.31.1757693174140;
        Fri, 12 Sep 2025 09:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhFpAvzAr4h6nHJq/W34QBFAPDcffgJvXu784z1DyQ2B8SVflxg8bLzme2d+Eci71k9K3ttg==
X-Received: by 2002:a5d:5887:0:b0:3e7:44c7:4bad with SMTP id ffacd0b85a97d-3e765a36ea1mr3659945f8f.31.1757693173667;
        Fri, 12 Sep 2025 09:06:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775842sm7308106f8f.7.2025.09.12.09.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 09:06:13 -0700 (PDT)
Message-ID: <e21cd2ba-9061-4c6c-9956-23db8be5e16c@redhat.com>
Date: Fri, 12 Sep 2025 18:06:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] mm, swap: wrap swap cache replacement with a
 helper
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
 <20250910160833.3464-11-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250910160833.3464-11-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 18:08, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> There are currently three swap cache users that are trying to replace an
> existing folio with a new one: huge memory splitting, migration, and
> shmem replacement. What they are doing is quite similar.
> 
> Introduce a common helper for this. In later commits, this can be easily
> switched to use the swap table by updating this helper.
> 
> The newly added helper also makes the swap cache API better defined, and
> make debugging easier by adding a few more debug checks.
> 
> Migration and shmem replace are meant to clone the folio, including
> content, swap entry value, and flags. And splitting will adjust each
> sub folio's swap entry according to order, which could be non-uniform in
> the future. So document it clearly that it's the caller's responsibility
> to set up the new folio's swap entries and flags before calling the helper.
> The helper will just follow the new folio's entry value.
> 
> This also prepares for replacing high-order folios in the swap cache.
> Currently, only splitting to order 0 is allowed for swap cache folios.
> Using the new helper, we can handle high-order folio splitting better.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


