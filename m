Return-Path: <linux-kernel+bounces-805779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25126B48D44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0797E1B205AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B85C2FE060;
	Mon,  8 Sep 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBVXRHsc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63E1DFE22
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334085; cv=none; b=PJLbFMrPns1KsJPs110KCRY4o2XAcEyL16pl50qyGfc4n5Ms7smbtFWl1LgGgmTWO8XnrPxEizI3Dm9SVqXCG7GFoEYfInj4PEgWJ46M42LIxz4EabeeS0JueGB9uzz6enwdwXcHBuNq/SI7RIgcZaz6XQzPFSAnc1k5v3eMgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334085; c=relaxed/simple;
	bh=dkRD0QfL9mTdtQmYA2V1x7BlcApfi5bbMn4MYkEzL+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZvPUCNlLu5hwbx6MRNtrveWK6r2BwnZ8XhsJ9FTdkewziERbPwXrBpj3g1WHdRPHUFvv8dVYaHqhuLQ8t0x03ZYXK530GIyANgQ0fpubnwO8dbG9WpiMkdSgP532HG6WReaBdF7ooy4JCobde62FWPwIXaqN/j31Gz4Xks1ew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBVXRHsc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757334081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b4LGF6/6A+Ec1kKIYxFDi7dxUU3JUaFn3tA0l45b07A=;
	b=WBVXRHscVECAureFtO0dQ3PU/6IOyeJ+Ic3twMjYeTc+LaMI/l0eeS6qf3+W8/Dy/wmep5
	8gEmrc/+U6KzlqDDWxbE7NsmZ1xWhKRiYAfNNc8FVt4xiQQaQK382D3+hdl2Cvvqv6W+yu
	ctrBWD4trZ6bCPqJLLmAcPJTwDojBnk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-nsvVt9xaNOGod3-l3rqXxw-1; Mon, 08 Sep 2025 08:21:20 -0400
X-MC-Unique: nsvVt9xaNOGod3-l3rqXxw-1
X-Mimecast-MFC-AGG-ID: nsvVt9xaNOGod3-l3rqXxw_1757334079
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso31110335e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757334079; x=1757938879;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4LGF6/6A+Ec1kKIYxFDi7dxUU3JUaFn3tA0l45b07A=;
        b=wzAR6H3DWBIuQElroEiKZl///18oo8TaNJlVPKR4x2kgNJ7C61XuTlTJPfezvM9pbc
         RVz0nW8l8OqBMeHKTvXholuIGeY9+5ilEi5741AaPSSUBXmTqAeFKZpEBBay4X4B4UoX
         nykFMFDrFaDxY4T8zyI/Xx/AYXZIeCIV/BJuYe2W4CyZpm+zVARsKu4dA8x092iNAb7i
         4aOMoPhIW50029gx8Z+zdzXjCEzU7nFpnigXhY7+7eHG6/0487OBAF0erAR5ydD/QVmz
         Rvh1b2YCKRWuljN3kiE8SxjMBKWSsswzQUrLi4OhOG6e4faS3KZEAUtrHgFCe3pfAAE1
         ZXew==
X-Forwarded-Encrypted: i=1; AJvYcCXRVYztxrhUps+nL+s9DuE6b3UKeC/sPDqeCAEYvogaobwEOY6z/e8RgO65wQXv3ovnUPqVKs1KY+FDdos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sjxQg2LLPMXu11CQ8eX5XTVgD6QN9/NL2trA3BLyzqwYSDyb
	BFVOPEUPBhCdi0+Rd1NdNLU7Iu6P2aN9O+w2ePmsVLA4Xs9PW9gQTD5amSfCXmwD8KPoFdpOwLN
	+cNjPFRTU2HRFdzeUN3iaX5Ejb+U9D62dkUm1DCMToSwwCCpbsrGVTaQwME+JzNdROg==
X-Gm-Gg: ASbGncv8UKAMqifELh4dx+IKVISyT9+U2ZnTC2GEOXPkSZKWqG3JnPJ+jsO70gk/eZ4
	+cB8B+takNesX2nq12fEWiRSNArSm7jPMIpcgeRtLLF9/cp+jjK+ABfM+JYZzKEIb9jahZPTL34
	+eWoikmP7ZGX7/ahomjs7KrhzM9ItOoE3ticOS3LmDmx3jOkkpmVi2eEKcQRmDGsm4i/q1TTL+f
	tPOUOG47sPVcKhWXX0wyOYI/bV3BR+sePXH/RQkbubl5WDomdPbURssvKpTps0GwKMfXYiOgGGU
	QPi3OH6kv6vL+W5tg8zduAhGhvyEXkCeNVLh/j1CAbsbw9AL4BcUhrW/1gFzlyGYbgSwnnVp2PM
	yMXH+5YV//N2b21/Wdl4qbC0goYKnYh4Tz5MylN+yyovIepEsRMLXsL2vn8P7PjEH
X-Received: by 2002:a05:600c:4f4a:b0:45c:b523:5a09 with SMTP id 5b1f17b1804b1-45dde21d0c0mr67037455e9.16.1757334079240;
        Mon, 08 Sep 2025 05:21:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOfP/PckjNKVTxCMvCkIOKSMsum91MTyZE+ZCSe31JnH0/HVLXj8wHIDxlH9JiUcB3ZBOyuw==
X-Received: by 2002:a05:600c:4f4a:b0:45c:b523:5a09 with SMTP id 5b1f17b1804b1-45dde21d0c0mr67037165e9.16.1757334078820;
        Mon, 08 Sep 2025 05:21:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2df4c8dsm171199905e9.15.2025.09.08.05.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:21:18 -0700 (PDT)
Message-ID: <84d3ab47-a960-4709-b127-ffbb8d85ac23@redhat.com>
Date: Mon, 8 Sep 2025 14:21:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] mm, swap: tidy up swap device and cluster info
 helpers
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
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-8-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-8-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 21:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> swp_swap_info is the most commonly used helper for retrieving swap info.
> It has an internal check that may lead to a NULL return value, but
> almost none of its caller checks the return value, making the internal
> check pointless. In fact, most of these callers already ensured the
> entry is valid and never expect a NULL value.
> 
> Tidy this up and shorten the name. If the caller can make sure the

"Tidy this up and improve the function names." ?

> swap entry/type is valid and the device is pinned, use the new introduced
> __swap_entry_to_info/__swap_type_to_info instead. They have more debug
> sanity checks and lower overhead as they are inlined.
> 
> Callers that may expect a NULL value should use
> swap_entry_to_info/swap_type_to_info instead.
> 
> No feature change. The rearranged codes should have had no effect, or
> they should have been hitting NULL de-ref bugs already. Only some new
> sanity checks are added so potential issues may show up in debug build.
> 
> The new helpers will be frequently used with swap table later when working
> with swap cache folios. A locked swap cache folio ensures the entries are
> valid and stable so these helpers are very helpful.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


