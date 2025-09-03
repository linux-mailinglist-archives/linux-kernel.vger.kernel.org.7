Return-Path: <linux-kernel+bounces-798011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF0B4185D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD1E7B0EC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8F2E3AEA;
	Wed,  3 Sep 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEBTdBl0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA84B2E9ED1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887922; cv=none; b=HVVmZsRgChhA4/pCtYaFbuqPf6KQ82DdOx6um7HF0/Ciy6u50dj2HB3fK2+HNNYAeAwwRkV+zPNI35UNTXJO0VB+Wu5bdto7z4ASyGHjw/PiPPLwUzYpPcCwdHxWhba/xM+yixWWa4jF8ynYkDEQ5DKdT5SSDbbjvQjmLp/pAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887922; c=relaxed/simple;
	bh=8ogsxAFBxfKig4gw1RdyimJPTl32xBE+G4njiSDx4M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naVCK5NHhFua68BrOtuaYyLb43bicjz6LokQQpg08+m+zEkPfzAVfXP7I8Va8rbJAfpIsKOQWxO9Zg+zWYmgagjOd/79WqDYuGSYnh/pUh/6ZwMyzKToIQ/Nmz38xM46AuF7mI3YgkSFUpKJBFToKAXwuWbCh4hjOJR4VwHvtZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEBTdBl0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756887919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qEo6sIiOZpM0+aYlHlHYuM/LZSXR7Rc5DD9SislhVzk=;
	b=IEBTdBl0aiKBtX7F11gnllCMyMwMylDn2eg4l34hHJlwXRrSxM8XHD+0VfULe/lVeQA514
	/SZ5k3E/hnEIBBVW82Tf9HRUWgcsPPlB/0gObHuut8GQ/jA1emV1+8Lgv93x8BvwHlKbnp
	91882JndgoBQRrQbERsElZJbBN907a0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-VWfxKhq_NzKWMzKakYsj7w-1; Wed, 03 Sep 2025 04:25:18 -0400
X-MC-Unique: VWfxKhq_NzKWMzKakYsj7w-1
X-Mimecast-MFC-AGG-ID: VWfxKhq_NzKWMzKakYsj7w_1756887917
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b87609663so20714765e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887917; x=1757492717;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEo6sIiOZpM0+aYlHlHYuM/LZSXR7Rc5DD9SislhVzk=;
        b=nh8lrjNwkA4ul1zEV7qaqMKwNjSphkHFJJaxaIAC8/bkYDyTar8AyZMhWw1n4Mx06r
         72bOyAZyGHKewfGtYTBXhl59Jp/QS808+sgU9H78W4SbIZKhBDcvZCuj75qPDkO/jVvP
         lbTMGiiuSkueL/HbJpjOglO7VJPbhAfKGTsUMPTaJQTTZ1yv5ve5/nyQyvpMeix5Xi9B
         +ZA8loQT+LH5l4nxYA5R8CqB0HA3Le0mQuAVqh/xRyD6p8gKdIT5JMke66dUmGJFK7UY
         IWmBtFlN2iO1GcFoPGIFgS2pX8WY6kEPGJOVCwk04FPAXQWz8JOKTlUzeagKiH6xFTYF
         r1kw==
X-Forwarded-Encrypted: i=1; AJvYcCUi+KWNwqCMnKh12Xxh19K6uJPk/0qPQI3qztMMZ256GvD+031BvM0sE0zONR1p//SiTh/DvkKVsoAK9ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLO7mnssSTXq5Pj9WnjDaH6oocu1jQnBxEs8Qwm+InOwbh2H0D
	Pi1jM5YNKxdbdjBC+XuF2L9Yz77iBmLXSt8HxrPBYbxCR9PgF7STHesDmuBYm5Th6ZE2k5kczcR
	XVLgltIinIcnlZs+foPAcYP1bqFT0VxSWwpghrgtvadA6Fdok0A1av+0Ft4CmHErzdA==
X-Gm-Gg: ASbGnctZnBYCmT0NTS6CEJpjKoUXBp8b9blB95QYeVE5hQD2waHcMT8S42sMxz61ZjZ
	4W0EnpbE6GkGLgBkCzuwyLzXhBEtBVPeFU9nQri7blc7UEBKkBfypXxVvlisnauM9gmA5vPb4CR
	pKjSTnY8g7R2zJdVvXLuoVQW/Omxn6oHYA9MfHy6rRk/F8EIMw5Lq3to9zmxcU5VX9q8ugpVmlA
	M7/rs1bL5XGmQ0N5ybfneSK4/Z64eI1V4FtP+pHkcry3PifNhyjYzElDm8KdS2nKTiK73LUvgve
	qEZP6UX0Tq7H/1ks0nlQomwrCU3Io+HjP+NlMF9yn0xugNmzoEn/kmerMZqKlOCxgjj2bqgQof5
	N72oZU9V+R+7OM3Ueeo24gPJTcE8WJO52/aZQgi0yvYZKqWOwhgUZHs/T4+JsShGF2VM=
X-Received: by 2002:a05:600c:444a:b0:45b:7c20:5709 with SMTP id 5b1f17b1804b1-45b87bf56cbmr110751185e9.12.1756887917382;
        Wed, 03 Sep 2025 01:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXFZTNjXv1KCj2KN78f3Fb0kdyuEOiHEfKZ5mGiTx64+28c0jQ3VEf6QxekGDbPo7kC1JGRw==
X-Received: by 2002:a05:600c:444a:b0:45b:7c20:5709 with SMTP id 5b1f17b1804b1-45b87bf56cbmr110750855e9.12.1756887916923;
        Wed, 03 Sep 2025 01:25:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45c6faad9cfsm33627155e9.0.2025.09.03.01.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:25:16 -0700 (PDT)
Message-ID: <28e704b5-92ae-43a8-80a7-3746db1832fd@redhat.com>
Date: Wed, 3 Sep 2025 10:25:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] mm/shmem, swap: remove redundant error handling for
 replacing folio
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-6-ryncsn@gmail.com>
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
In-Reply-To: <20250822192023.13477-6-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 21:20, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Shmem may replace a folio in the swap cache if the cached one doesn't
> fit the swapin's GFP zone. When doing so, shmem has already double
> checked that the swap cache folio is locked, still has the swap cache
> flag set, and contains the wanted swap entry. So it is impossible to
> fail due to an Xarray mismatch. There is even a comment for that.
> 
> Delete the defensive error handling path, and add a WARN_ON instead:
> if that happened, something has broken the basic principle of how the
> swap cache works, we should catch and fix that.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Sounds sensible to me.

With the "!error" code not deleted

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


