Return-Path: <linux-kernel+bounces-813488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649BDB54626
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD0BAA6DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2171853;
	Fri, 12 Sep 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmX9aJ0+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474F271443
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667467; cv=none; b=aucZNQj7iaQZRwGF5atDvKkSwx3AiFEg6VtTT87umsopazXgmfJsJXsAnQpvoMHFFeMAB46f9KYziaD6rSgSe1sOFmurhRI8h8vbrdmsuAYCvweCFFehX4oxZLJP5dzdT8ncpQ4utdbNEHXgSW1SLbFQzrVS99AEKlWUvE3NMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667467; c=relaxed/simple;
	bh=NVWPy33J3q4wQlLtS//5objHdfnj64cUjgTBrKzyTMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4Rhf8bjq29l1T9QKAH0m8TZn5U2DZGDo511RCYVivpq8rfs9dNzaW/l5fPqGpAreUPq1hUp99l8ur0+hCjNlZhWOvL2L5CGMZkDM/8dw0Q9mVA8BtzYMzihlk6ftVa4NZiMETps8tP58XtTxAdEvI1BUOLD9Wn6RIxZ7ppOgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmX9aJ0+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Gvh2Zb5LHN8KYqKprwhbFHUr38VnGteS2eUYfgfDSpM=;
	b=LmX9aJ0+iP/7JO26juR/Mmj2LVVY+UUXDePycp+vRCF/7jAstEioHFjIr/fg6Hvb9AKwj8
	VZFhx0LeSZ82TmmxhJVV3F9RDyeLVHvdwFvvaSCvMOZ5m1FofAZFuTo4nq8jBx3nHAuwmp
	CSk1h12xwafJej3fFmxRalz+I+IHG7Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ZWIZ-CWjMya0Bf-AIjG4zg-1; Fri, 12 Sep 2025 04:57:43 -0400
X-MC-Unique: ZWIZ-CWjMya0Bf-AIjG4zg-1
X-Mimecast-MFC-AGG-ID: ZWIZ-CWjMya0Bf-AIjG4zg_1757667462
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45dcf5f1239so7407645e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667462; x=1758272262;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gvh2Zb5LHN8KYqKprwhbFHUr38VnGteS2eUYfgfDSpM=;
        b=du1zlXIcPExsk1RTBeAyS72Bzri/uIolYOkKc8/1YshW1CduiBhtWGUb+w84DYvZl0
         w0YaGVf1C70H7YQQUmXFP50duouQJtHVpijufclkauHnIuJPlvrho1KxUTLJT75btjaK
         qonuF6+/3reapvV6uVG3qgnbtupUyJrsuXmhPbLqLkBAKQFMdHXSFfFwPejon6HeJHoj
         KFxuqP6gmcC7kDsNbN5L7b+wW1lBX8syItN3ItUuK0gKGsCb387TCyW5fx9A7zBvqKXb
         euUKORLMv8vwARf0xh4RFc1ZJ43RT2FTqjcdW93rNibT1a/gUiWOe3cuvwk48SdUWqfZ
         +Aig==
X-Forwarded-Encrypted: i=1; AJvYcCU72lD5K/G2n9L1fz1OdSSv/75w3q7Ft1vOtuNSgnLYtScd3dL8tBkOUQaubr2+wFSHGhwnZM1GrJ8ib9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1FONGIijailgbzpaCw23dgt5XiZAlwqmhADmz1T60h7OP+7Z
	Bri4/mPAteW9hoGQj+B9XJhpm43dqe/3p9p/6VMjugneMH6WrU5os1qUWpXIyhRH2L72Gn9zEMp
	24jB1zh/vheGX3gqN5SnpJJlPAW5/OItZd3iYTkxYkpz0apPgq3jpOcygP6/lQtXkHA==
X-Gm-Gg: ASbGncuk0WpE0WwHhjqdtwYVILimRiRY/UaLXWkF4qLgqmrYnNopCEIVTwbnejxvPTF
	tQvyj5dT9vhxWXRZ2kXYzlyZPFipl6Jj2eBICyBHyRplQI7O5hJ1kYyvdmbzNfxgzmoGqxZnI+u
	f23odgKAGjSwD+6djl/uzxPzAIZr8ytqapOjxMfQIXkmIqc92BDrV/7tyZK9EzBZa4RtEBEFekH
	dKcVNibmNNdfBn5e6GNciKE0U2Al2k44h/Z1fGVe53GAR1nECGpGXAsTzWu8Ork3Icd6QazDVHe
	uva2aZDgvkzKHW/ulLrrQvsVLqj60Q+Z+7QzxEF3xc22vg/xA3Ice2cAlYrDCzBML0lN5mBKZ3M
	BO8yUseMr6rnzrK0Nsa1XptHENjCBNre6kFBEHEB3iYM99W9brTtM6DWSHYfDUSCKCFw=
X-Received: by 2002:a05:6000:186a:b0:3d7:618b:2923 with SMTP id ffacd0b85a97d-3e765a26619mr1969480f8f.48.1757667462557;
        Fri, 12 Sep 2025 01:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtpTEH8ZF0pk5VHVw23WjjC8G4J66w7d/8+zqmiDSw8BuA65N1n/WplO5cXk5Q2FqiT8TxDg==
X-Received: by 2002:a05:6000:186a:b0:3d7:618b:2923 with SMTP id ffacd0b85a97d-3e765a26619mr1969454f8f.48.1757667462122;
        Fri, 12 Sep 2025 01:57:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607ccf88sm5755903f8f.33.2025.09.12.01.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:57:41 -0700 (PDT)
Message-ID: <1bef69dd-7308-41f6-ac0f-5f171609c1cc@redhat.com>
Date: Fri, 12 Sep 2025 10:57:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 05:45, Baolin Wang wrote:
> Currently, we no longer attempt to write back filesystem folios in pageout(),
> and only tmpfs/shmem folios and anonymous swapcache folios can be written back.
> Moreover, tmpfs/shmem and swapcache folios do not use the PG_private flag,
> which means no fs-private private data is used. Therefore, we can remove the
> redundant folio_test_private() checks and related buffer_head release logic.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


