Return-Path: <linux-kernel+bounces-786700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC124B363B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5491F1BC71B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63572FC01F;
	Tue, 26 Aug 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnJ0hlmY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C928FD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214725; cv=none; b=inZ+IjWP8Zk3HhgHOe7Dn5Se48w1GqPMIriZwa+QkNA93/7VlqiV3X+b/SSU8Mzak+wdxccncRmCael+oDfvqe74JzAMrfq7k6f3G0vZ7OEwVAAiZzTfLLCl9vb9afSBNt4CBsxxaklHoKfVzYz0Tg3tX5m0nQ/zXsPjtKKhyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214725; c=relaxed/simple;
	bh=QeLpOY6ZMYEffirgezdp9G7YYAOUdnqyFaviAsS1hqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPlTedlFQ3/a8DmLfx66UKJluHfvcvud+a+5e6f/Z1Aw2S6s9pqodClYdIAx5bHm6NvEGbGpfBkaQXMCTQi9UcCAi/VBvgsbeE3nyzH1IXLnRhif1I5L4DLbea5VaRZ3ti/JsOiAxMXkqLMNjV4wTrRMBbIDAclhRLjWBjZ3+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnJ0hlmY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756214723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4QSSifgUL+pROPLdu64RBhU3ne5/Fuiph5UVy59wA20=;
	b=EnJ0hlmYvYgGm3Vxp7TJ/Z5FHiweZ8rBeXe2U3fiGwOocZXe5qAehsg24stQsBCEnx+SRY
	0Es0X8dlJ41S1RNPjwrMkFwvwH6eCc4/l3BET3BqxjJWoNj+xO5Nb01VygYleWzlflfhB4
	QD4I4d4JvLJlaWUAED9Swl6AgboNpTg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-f-_UmXlGMAuQrixDjrZVWg-1; Tue, 26 Aug 2025 09:25:21 -0400
X-MC-Unique: f-_UmXlGMAuQrixDjrZVWg-1
X-Mimecast-MFC-AGG-ID: f-_UmXlGMAuQrixDjrZVWg_1756214721
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so26871915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214720; x=1756819520;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QSSifgUL+pROPLdu64RBhU3ne5/Fuiph5UVy59wA20=;
        b=VU1quQ9L/wttsLVhR4kB7vX15y/sPA5ExkCd8ymjRKpRDQ/BquWhIktkWQZYvsUNX4
         9AqeXOoVcd2k7KC7JD31CAhxaHNTvNbv/rIlSdb0lXMJ7qriG/HIC4dIdzWkgmpRYZD8
         OUS17bKMJhZ21FKbZYYoYs3HLUNsr7ASEga4g/K7yjM+NnjLVXVfXK8tYTQfK6ZzDD7f
         GgjqnNDs6pgP395ih8x/CG3lGjwsUBFB/le+Zx4pAhRYmzJSnYhrwVsgH9U479DgMLv7
         cJIYq7W6oeeXNFl0GEMYuWuYVHnldYg6WBT/WbNJY+bgs4QA5/qiwUSEdGAdn5OOgquD
         vu0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs4GAwN7Zul4iqYb449t1IoGmxvPlc1WHshIfsTc+p4bKgFYdTZRChlym5I4OXCY8ruuKBBf6qqqFX57E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/STJCdRDCmR0jIHIGinY2vguCtHYYFbc08c8eekQXpMg8o1FI
	oKg8Q7SSzdLL9glqbiiWWCQQagjfMo6mrsrXid1SDhuuZoGxXI8mZQsBIqDnbu+qM9FD+zR7MaR
	xjoNCvMiElQ7cC3+BapJRYL75iFPScZtABzZjAiAX6YTjaAvRAI9DFLbO+viDPPP+EQ==
X-Gm-Gg: ASbGncswv3UhtjH9DgIw8lsxJHerIOWHV5m3Ijb++tx8TTyH4e5gByeBbtKiblDOZGx
	E5Vd8YptTym3a0mgHNcfV1LdsWjPAGk7D4VfhMpqbkzv6A2PhQqimpLh71a45Py9SjNP21U1naf
	A0xWO/E8NjfWyNFmqyNe1fmwG6JjR/4xOvwRPLDOq3MCorQNgwhkfG2QuQUWh9UpKY08vgMBj6b
	jqYYX7kF9d+c2fwFpibp2WZFONO7QfYrqw4tdkT9W1cGNYVbchUvlXE7TDL7+DK08lHMiM+6Iz6
	WMIEhxc8beloG6SnJ21FP+IDtTpjGFgaCiGH8+6y4mzxtveRJ5SmIlDqnca3ecjFcC1LLWdOyA=
	=
X-Received: by 2002:a05:600c:348f:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b68e5699fmr15039235e9.11.1756214720581;
        Tue, 26 Aug 2025 06:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ48NrVXwqJhZgyCqJ5MFpPBhjkOC2mFGLCH3i0h32WZie7Q73yLQ+HzSD9j5V62fMkPbf6w==
X-Received: by 2002:a05:600c:348f:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b68e5699fmr15038955e9.11.1756214720105;
        Tue, 26 Aug 2025 06:25:20 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66cdb5d1sm14126195e9.8.2025.08.26.06.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:25:18 -0700 (PDT)
Message-ID: <f8940d8d-0cb8-4b10-854d-6097d1a2c39c@redhat.com>
Date: Tue, 26 Aug 2025 15:25:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: two-phase hugepage allocation when
 reservation is high
To: lirongqing <lirongqing@baidu.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, giorgitchankvetadze1997@gmail.com
Cc: Wenjie Xu <xuwenjie04@baidu.com>
References: <20250826101840.3954-1-lirongqing@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250826101840.3954-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 12:18, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When the total reserved hugepages account for 95% or more of system RAM
> (common in cloud computing on physical servers), allocating them all in one
> go can lead to OOM or fail to allocate huge page during early boot.
> 
> The commit 91f386bf0772 ("hugetlb: batch freeing of vmemmap pages") can
> worsen peak memory pressure under these conditions by deferring page frees,
> exacerbating allocation failures. To prevent this, split the allocation
> into two equal batches whenever
> 	huge_reserved_pages >= totalram_pages() * 90 / 100.
> 
> This change does not alter the number of padata worker threads per batch;
> it merely introduces a second round of padata_do_multithreaded(). The added
> overhead of restarting the worker threads is minimal.
> 
> The result on a 256G memory machine as below:
> Before:
> [    4.350400] HugeTLB: allocation took 706ms with hugepage_allocation_threads=32
> [    4.351577] HugeTLB: allocating 128512 of page size 2.00 MiB failed.  Only allocated 128074 hugepages.
> [    4.355608] HugeTLB: registered 2.00 MiB page size, pre-allocated 128074 pages
> After:
> [    3.561088] HugeTLB: two-phase hugepage allocation is used
> [    4.280300] HugeTLB: allocation took 712ms with hugepage_allocation_threads=32
> [    4.281054] HugeTLB: registered 2.00 MiB page size, pre-allocated 128512 pages
> 
> Fixes: 91f386bf0772 ("hugetlb: batch freeing of vmemmap pages")
> 
> Co-developed-by: Wenjie Xu <xuwenjie04@baidu.com>
> Signed-off-by: Wenjie Xu <xuwenjie04@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: add log if two-phase hugepage allocation is triggered
>                add the knod to control split ratio
> 
>   Documentation/admin-guide/mm/hugetlbpage.rst | 12 +++++++++
>   mm/hugetlb.c                                 | 39 ++++++++++++++++++++++++++--
>   2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 67a9419..5cfb6e3 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -156,6 +156,18 @@ hugepage_alloc_threads
>   		hugepage_alloc_threads=8
>   
>   	Note that this parameter only applies to non-gigantic huge pages.
> +
> +hugepage_split_ratio
> +    Controls the threshold for two-phase hugepage allocation.
> +    When the total number of reserved hugepages (huge_reserved_pages) exceeds
> +    (totalram_pages * hugepage_split_ratio / 100), the hugepage allocation process
> +    during boot is split into two batches.
> +
> +    Default value is 90, meaning the two-phase allocation is triggered when
> +    reserved hugepages exceed 90% of total system RAM.
> +    The value can be adjusted via the kernel command line parameter
> +    "hugepage_split_ratio=". Valid range is 1 to 99.

Can we just do something reasonable here and not introduce toggles where 
nobody knows how to really set a reasonable value?

This really sounds like something we should not be exporting to users.

Also, can't we fail lightly during the first attempt and dynamically 
decide if we should do a second pase?

-- 
Cheers

David / dhildenb


