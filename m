Return-Path: <linux-kernel+bounces-822635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9CCB845CC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4A5220E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9022F9DA5;
	Thu, 18 Sep 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO3pgznF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01022253A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195043; cv=none; b=jFLR2eAm43ia7cwKoOf4nj6IjwVIcSO4I47xhZmmfEwIu31FTAIk90B0NBTcaeteth47JU69K9+kVDVYAuvWZySsAN3mH+AIRPCpUe9GWyXjk0RLPl7Z4yt2USrV/7Tk6ewUKnCja8IxUphgVYRl8JGEvHytcxHVRJMnsSaiwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195043; c=relaxed/simple;
	bh=BIhTqvphsDb94im/JmaAdb8Xzx4dyvpKF4n7PmHjam8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jg7mVL/v+fOR3nuk61AEBFGSnjufY7i+stemp2osN8MgeUp3tfAnCpKb7F4+UqYE321cokBQfb2ANPOiSoY8J8DBTSIdcpvHm6SDIJyWr34smC80ZcmWh7GNgXED3c80fZ6YyJVPOhh/VNCOUOE8ut/FtVX0nmKK1hFFlMg7Yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XO3pgznF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758195040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pBqPf02a1oTGK+tCJbE1ES/WnQGlGEKm2G2y16LpUTI=;
	b=XO3pgznFtfB8OcgYm8IGLB1rTzF8vPQnTket/DxCTNVGZKNeu2aberL9bKpm803d46pnIE
	Ku6EWhHxwCXVLsUH88+8TwR8CcauZswGSgA7kI/wy7JJOyQ3h+/dp1P/ntqI0hjTTLR2MS
	HfSLvtOaCRr/UbV12ZTTMi8CxPNGhaE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-vNaoGHJPOa2Q6V6Mj6zI7g-1; Thu, 18 Sep 2025 07:30:36 -0400
X-MC-Unique: vNaoGHJPOa2Q6V6Mj6zI7g-1
X-Mimecast-MFC-AGG-ID: vNaoGHJPOa2Q6V6Mj6zI7g_1758195035
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f29eb22f8so4259075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195035; x=1758799835;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBqPf02a1oTGK+tCJbE1ES/WnQGlGEKm2G2y16LpUTI=;
        b=ssX6Jvk8ATo5AHYWOUm/iiw2qsAhVPVFzMQeye1fJAuyBX87wTsa9Blzx0kIS5Vebk
         JRqsrfJjLPL6A+Bk8Fdb5AmMsqOEE3KzWfP2M4FXz3WbiGWhXHo56MEaEfxLfDvhNy0j
         KVYu856WKgtKQ7BCLYPRgTdBlAuPREKosW6Z1ADA6uqSy7SGk3gsaroI42kn/yD3Hq7n
         ute+DSDbzCwNaoLhrUWhZYDcAiW5bKSLtv2/dDC7tswwlqvPINDM8F4t34S+nVkdTdq8
         k5f4gXyHpOwY5GcGyBOeX9FMMvRc8fAHKF7h2dpR3MUHMTt4iyGKtkiPfRp12Y3ball8
         G3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWibnQPYTcqFvI4raQcXtROfu1VFhVpimFAEJJStutHGc5qwEqVtI6bhOXS6xSG5SaSlj3Zsxo87cXVhsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrkDtx6/DbwFQEyVuInldMiZHTIebr4fsuuLJ9hw/JUeWNCpAi
	6AfKCLnKskQi3el3f4Zhcc9eUf5Fnm65XSGjzuyQstPnRIK8FtzRkI/PjR+OHbLw1TX4rnw0i/5
	gJM4VC8Gc8OnplDU3AOKKH4Y8OBVeQi8BmlFsdL/t9xGAI7YTRcSwluyd/nfOwsYX7Q==
X-Gm-Gg: ASbGnct5eV4Xik103BeV36MFjRf64j+VcQWPfJBCX9EssIy1qYlWGg6jqZQGwVV3xhE
	B8tsGKmMTsgsWix78MvLtYioz0CBI1QajbQp2PYIh5liFv/DMXMO3IQLUdd99fxDcprWVNJn4gy
	P+vXG9qbfDaHe2ynzFhc8g0Nwo7XbJhecLiYFEaJ+sc7DfbYCNi1QZvmNyBtJPrTejtYfATg63A
	tLJ4p4OEfgBZzKs60nfZElZo1lMXc4m7baADViv/bfcb2VClsKSqdG7Ixmox1FiF+ZiA1KXsKq3
	IBuZ85cY/4wQFeTZw6MvfW3ktU9E3Xhsk1jUx2JaggIOo1qGd7Rfsx8rW30weVLnSrFefC7ofFF
	l7vBc3nnJi4YW8eVCi+e5IvaIBoAYgPAKGsTBlpqnSijXZdHJdWqNArvfmqinLkPuNxRT
X-Received: by 2002:a05:600c:8b5b:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-46202a0e941mr53963245e9.15.1758195034901;
        Thu, 18 Sep 2025 04:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD9aiGVd8wYPkpij9ydkBEiOHOxxDrIOX+4KKE+0QofLHzUS5fuCtWvKkqly/0tsK+aQgr+Q==
X-Received: by 2002:a05:600c:8b5b:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-46202a0e941mr53962745e9.15.1758195034398;
        Thu, 18 Sep 2025 04:30:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:dd00:ca9c:199e:d2b6:9099? (p200300d82f07dd00ca9c199ed2b69099.dip0.t-ipconnect.de. [2003:d8:2f07:dd00:ca9c:199e:d2b6:9099])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0d8a2bfsm38316155e9.2.2025.09.18.04.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 04:30:33 -0700 (PDT)
Message-ID: <6e6f596a-1817-45d6-b674-04e8aefde6d4@redhat.com>
Date: Thu, 18 Sep 2025 13:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/fault: Try to map the entire file folio in
 finish_fault()
To: kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20250918112157.410172-1-kirill@shutemov.name>
 <20250918112157.410172-2-kirill@shutemov.name>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250918112157.410172-2-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.25 13:21, kirill@shutemov.name wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The finish_fault() function uses per-page fault for file folios. This
> only occurs for file folios smaller than PMD_SIZE.
> 
> The comment suggests that this approach prevents RSS inflation.
> However, it only prevents RSS accounting. The folio is still mapped to
> the process, and the fact that it is mapped by a single PTE does not
> affect memory pressure. Additionally, the kernel's ability to map
> large folios as PMD if they are large enough does not support this
> argument.
> 
> When possible, map large folios in one shot. This reduces the number of
> minor page faults and allows for TLB coalescing.
> 
> Mapping large folios at once will allow the rmap code to mlock it on
> add, as it will recognize that it is fully mapped and mlocking is safe.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---
>   mm/memory.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ba4f6b71847..812a7d9f6531 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5386,13 +5386,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   
>   	nr_pages = folio_nr_pages(folio);
>   
> -	/*
> -	 * Using per-page fault to maintain the uffd semantics, and same
> -	 * approach also applies to non shmem/tmpfs faults to avoid
> -	 * inflating the RSS of the process.
> -	 */
> -	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
> -	    unlikely(needs_fallback)) {
> +	/* Using per-page fault to maintain the uffd semantics */
> +	if (unlikely(userfaultfd_armed(vma)) || unlikely(needs_fallback)) {
>   		nr_pages = 1;
>   	} else if (nr_pages > 1) {
>   		pgoff_t idx = folio_page_idx(folio, page);

I could have sworn that we recently discussed that.

Ah yes, there it is

https://lkml.kernel.org/r/a1c9ba0f-544d-4204-ad3b-60fe1be2ab32@linux.alibaba.com

CCing Baolin as he wanted to look into this.

-- 
Cheers

David / dhildenb


