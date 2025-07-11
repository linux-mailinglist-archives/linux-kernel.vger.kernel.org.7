Return-Path: <linux-kernel+bounces-727418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9E8B019F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000F26485B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690A82877E8;
	Fri, 11 Jul 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geKFCZZv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4B28541A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230972; cv=none; b=iv1wMwOYI3Ffzivo2gkNgGmHNTg1qrAO8NHbYQd13rnT2QmadpmHDuzzObEiSyGlJOSzc3T3hOW0Ph6ivy1YxSR+wg0KwLwrJsT13o7WOVPXbH0UNfJCcSZe2Qns7KbAe+KupPN04cBjMB7VbV4WwRpUIZS4xz1Ft09rJao6sSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230972; c=relaxed/simple;
	bh=xPwNpunno6oD9PP3jJiB2Ey+Blb8/Y2b7bF7FDOPcgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyjMtO97lZRMhgad91Hd2AZxujW6azLHVuGxYmOqeA/zlN54/Y2mccKe0q2DRSQqwMi76A4vOsAI2p/ScdT8Kc01wHUSnm+mUyBrn5QiRr/bU5Ozfk9YJJw8vwsubffIZJRTh3iW7Epcj/j6ugoMDG6cwlxWw3/IRcHdqF9GkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geKFCZZv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752230969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E8FdYOVeS0rJgUvHx0cKvojaQnDNsgbZopVnLDtjnZ8=;
	b=geKFCZZv7webHZo4lFnGo9GzT6D2tHRgITs4QNg4VRbrGlfW9poLzmaR3zIaA3ao5zEfHE
	q5gV5QfIhFNr6NEauR7VPP+Uy2ZRzPvx4wdZV7lzWpM+bNwmN16Zc1Dpgw4OSaOW80ThZJ
	Mxg1skdR6CHHG9i7P0ZabExUaYAs4AY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-hqgVuYIGPGKQa1VnskoRSg-1; Fri, 11 Jul 2025 06:49:28 -0400
X-MC-Unique: hqgVuYIGPGKQa1VnskoRSg-1
X-Mimecast-MFC-AGG-ID: hqgVuYIGPGKQa1VnskoRSg_1752230967
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so11681465e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752230967; x=1752835767;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E8FdYOVeS0rJgUvHx0cKvojaQnDNsgbZopVnLDtjnZ8=;
        b=gaCjlDA8dYKGGUDcPZlZ0rVMsUlzGubSPXFOueMOTdcn4oCB32lOX/B6osr7sa9pf8
         Fe+dO/A8ejS6b8xgC4GjZ6uXjL3/wJAoGw5t2p8P8wPFv+y2hym3oQy/Fwqh5RO1eFzz
         WrUJlvqLahhdEqDBu1nQ1hHYHlb+2Y6op+WaY7/jfhmnyLkGc4UDe/D9LZwdsDYrn3EX
         y+IgUT3XPrG2/qHafanpmeTbJuD5erwbcVEuUdEt06x0sRPnJrsZDjIEbWP2lIYcgDZC
         N+WUHq37eRYCK2V6j90P9hF7ZQO9J0YjyGdB70zAD0YqjZLqNUhAqH/rivwb3NVBnAFi
         zMcA==
X-Gm-Message-State: AOJu0YwsNy7v6G3rjYeP+F98jUFhQtaO2+WP1Zf6jREOVvV0/bGJxrk2
	43g2862OvvzYFxNAR+2/ayFnvM3W73WX72D6nN6xzTZxyzkljhcjcPaHDR8CA7mVaiaAKBq7TdV
	kQ13DrehG///1TaRpDu318AKlaJLpO+rT0/6eMrhRXrw10bWCqb/rlhiSTcREj4o1kA==
X-Gm-Gg: ASbGncsMWcXPCTuxa4OfGkxNwl+mJbQ7Bd4OFVDEh9L/xJXoeoO6JxKMAQs/b8/jwRY
	zJh4SMLJqq0Uh7dksJnp9BNFtvEyQWn71H+sPT0I7mnwARKXLL2EM5K38qAvdmDgAghm+eTec98
	pPADEfH5OgXHEBmgVStr4m4QBx+7gVOmMv6Y13Y9tHWPj82DHdjWAmETWCC8RaMoo3dLL6VqmF6
	KQ2rFTChX/IY36vs21v6IXsWqn5WhLzW74ZhM0SupNXI6zyR9iisphBbUVcQJ6n1Ym6XU6RTHAy
	uPixYI1uP3aCJvo/wST+u0h2zSvBwQeIAIGDn6nhXIkh0nWiPZkpEdFUDcjkpkRyj7+fTp/04Aw
	Efy4E7otkeSdYC1Pln0WWaEmH9LSjeUr5cBQQk5GZych7BuagMqHCoUocyokiD3+y13s=
X-Received: by 2002:a05:600c:1c1f:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-454ec16a5b1mr28065495e9.10.1752230967213;
        Fri, 11 Jul 2025 03:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbt8UKpPwWDvR0+0kCm2Qz0XraVSE2GNazJDrmfX1Q7I8cEerDfFZIkIEln2jL8dMShvm5Pw==
X-Received: by 2002:a05:600c:1c1f:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-454ec16a5b1mr28065205e9.10.1752230966785;
        Fri, 11 Jul 2025 03:49:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd538b63sm43791545e9.19.2025.07.11.03.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 03:49:26 -0700 (PDT)
Message-ID: <faa3d518-cd0f-4848-b4c7-deaad02bd0fd@redhat.com>
Date: Fri, 11 Jul 2025 12:49:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/memory.c: Use folios in __copy_remote_vm_str()
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jordan Rome <linux@jordanrome.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20250709194017.927978-3-vishal.moola@gmail.com>
 <20250709194017.927978-4-vishal.moola@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250709194017.927978-4-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.07.25 21:40, Vishal Moola (Oracle) wrote:
> Use kmap_local_folio() instead of kmap_local_page().
> Replaces 2 calls to compound_head() from unmap_and_put_page() with one.
> 
> This prepares us for the removal of unmap_and_put_page().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   mm/memory.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1174f3001307..d63f0d5abcc9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6815,6 +6815,7 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
>   	while (len) {
>   		int bytes, offset, retval;
>   		void *maddr;
> +		struct folio *folio;
>   		struct page *page;
>   		struct vm_area_struct *vma = NULL;
>   
> @@ -6830,17 +6831,18 @@ static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
>   			goto out;
>   		}
>   
> +		folio = page_folio(page);
>   		bytes = len;
>   		offset = addr & (PAGE_SIZE - 1);
>   		if (bytes > PAGE_SIZE - offset)
>   			bytes = PAGE_SIZE - offset;
>   
> -		maddr = kmap_local_page(page);
> +		maddr = kmap_local_folio(folio, folio_page_idx(folio, page) * PAGE_SIZE);

It's weird to go page -> folio -> page ... but maybe that's just the way 
it's supposed to work here ...

:)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


