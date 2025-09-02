Return-Path: <linux-kernel+bounces-796110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CAAB3FC0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A5148397D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717127EFE3;
	Tue,  2 Sep 2025 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9f/thgV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5512836A3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808316; cv=none; b=BrA3lcsArbh9Hfcu4ykXb49qzojsxxhfZTkM1dXUSYyzzKw5FgZg/V1wu/k1wWKESYsTMAuDvjh3h7p1BaqdhX3cY2JP0RQGud7DJqMVnfdn5yQ1Xp2SyV7nwhseKslr3A0jm3uBanY9KdzWXpDLTApBepJf6JwccLmY5bZ1LF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808316; c=relaxed/simple;
	bh=wz/yk7VaKLnUdFZXtSAi4e+vOS1hn3IxE69YK9vN2+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5yBtIRO8QL5d9dugp8k5hYfz3/qpanq2/L/ZCcB1i/ABhyXNUJRiw+BWVgimuv0crT7JrTBa38x0IvCA04ES443p6kXouAQt+8kJMUmPgoLuwbvJ8+HJjJSbhnwYyRnjrJrFo0CnDX/GWSRS7zQTb15zVzwj7jX/t7DFq0Bxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9f/thgV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756808313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XfPQDWh+blhS1iVGJAFgii1Xqa8zns+gAsDev0OCaLA=;
	b=A9f/thgVCdWLSTsHCM4igR7WqrT7PJqUpt3hvYL0Bj5NXvC/YyXo6r6JRUlXBFGzEEmtpr
	0FKtckDxrJEYNts4PloM4xa65m1Vy/ecgjCjUTlM+6yWScIxx5XQCTNcJ+FyNJVrxl+02z
	tGk9m4gner9dkmFwom+5j9QWHfNQNZg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-O2jqi9PSO6qck5sJK62org-1; Tue, 02 Sep 2025 06:18:32 -0400
X-MC-Unique: O2jqi9PSO6qck5sJK62org-1
X-Mimecast-MFC-AGG-ID: O2jqi9PSO6qck5sJK62org_1756808311
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b9ca27a11so775885e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756808311; x=1757413111;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfPQDWh+blhS1iVGJAFgii1Xqa8zns+gAsDev0OCaLA=;
        b=hZI7X69SRwdewPGWSifTn8UuEUcQuTJRR5hzUh94eyrkmqfdcEyOcWt072PIVtDAOj
         qElOqiO4+7Yl5+vK2LEUF83NzaoQAuusI5qoj2TD6Qm+8rUUxPqje8ovQHZhT1DD9Vi1
         QSx+VGKXmfyI/cZBgn1prWtQYHrGVuTer76czpBLZV2iB2Ufp1KS/0fvduKTtnLgVGdD
         qvPwNwjrrIbm2bIo3XftrMFuPN9oIeIgxIEW/cCERDdYmdB1sd/kwnZd6V9GoZeM6Y8P
         y0y08fGE4hU2gnMo34hcTFWSX9qDBDQi2sisiW2vWI2vftZUOsa7LXkM3zFGjoca1+cs
         S+2A==
X-Forwarded-Encrypted: i=1; AJvYcCWIDDA1CF/IawM/ma+gdTgnXEuDS3oQKe/T5/Z0gHg6iVLCKgK/RmirXN4jwxsqSaarTbiydAa9QtSKg6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLG0JsZFJoWg9vonDhDJi6rpqr2yWL61Jf/SG82ChKUMw7qVbq
	Ro1Uj6euGCrdS5thEHECtpBTkjUW62T8G1MZc0LNnaR/jyBrRHFcyQ0UkNXSXd1RW7ddHa377fu
	IrQeV7ISgUZqcGknBLXSZJsIESYV+cwG5LBakGvcw7v2vj6p6OzRF+k+Ey8I9ISy7Iw==
X-Gm-Gg: ASbGncubh+V0YteD/9Q62nbd0gmNSm1tatCpAdK6cFy1pBcHewDaSoB1LuYxwiTxd2M
	vZOdbY4vneGXULUlLQkipjTh8T0crVsm8l1pxVKmc6TR494vsBH/A23vO6qxxA32MdtJzYVjBnD
	3Q5gV/9Xsc2FwvV4knTQCmSFUnSAWjuf47ZJQRBqth+cNIIMGk4NYVaGfChRCKQ7OjcONDDMQhC
	y8PfQpGltx1fY+DUJo3ED7hMYLDPKh5Co67XFQF6TK+A0a6kcgIHZXuM1KkgvY7NPyCVccH2kjE
	tebntSEqsuN4voxSHVPaB8LBRbm1/J7WNAtSRqBv0uh8L8vI/45S6lU8xuVRFZFdZo1Caahqefz
	BlcJdXX/EC6j3O26hJP7RCLqSJhoELw/CafX4j+vv53JT63hPXw18w32iFUpTbsFzbOU=
X-Received: by 2002:a05:600c:4754:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-45b8554e53amr108058045e9.6.1756808310848;
        Tue, 02 Sep 2025 03:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ+ztZI1y4AVzKBKNuPojd6cp+oaGeLPMegv91kQPUznpJCNgOTUu1ktEdtczx4Xk1VYZ6YQ==
X-Received: by 2002:a05:600c:4754:b0:458:b8b0:6338 with SMTP id 5b1f17b1804b1-45b8554e53amr108057835e9.6.1756808310345;
        Tue, 02 Sep 2025 03:18:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66bbcf19sm164087935e9.4.2025.09.02.03.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:18:28 -0700 (PDT)
Message-ID: <911dc3b4-c511-4ef2-a159-091780987965@redhat.com>
Date: Tue, 2 Sep 2025 12:18:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
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
 <20250822192023.13477-3-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250822192023.13477-3-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 21:20, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Swap cache lookup is lockless, it only increases the reference count
> of the returned folio. That's not enough to ensure a folio is stable in
> the swap cache, so the folio could be removed from the swap cache at any
> time. The caller always has to lock and check the folio before use.
> 
> Document this as a comment, and introduce a helper for swap cache folio
> verification with proper sanity checks.
> 
> Also, sanitize all current users to use this convention, and use the new
> helper when possible for easier debugging. Some existing callers won't
> cause any major problem right now, only trivial issues like incorrect
> readahead statistic (swapin) or wasted loop (swapoff). It's better to
> always follow this convention to make things robust.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

[...]

> +/**
> + * folio_contains_swap - Does this folio contain this swap entry?
> + * @folio: The folio.
> + * @entry: The swap entry to check against.
> + *
> + * Swap version of folio_contains()
> + *
> + * Context: The caller should have the folio locked to ensure
> + * nothing will move it out of the swap cache.
> + * Return: true or false.
> + */

I appreciate the kerneldoc.

Intuitively, this should be called "..._swap_entry".

But I wonder if "contains" is really the right term to use here. It's 
more like that a swap entry "belongs to" (was assigned to) a folio, right?

Sure, we store the information in the folio, but the "contains" is a bit 
weird.

folio_matches_swp_entry() maybe?


> +static inline bool folio_contains_swap(struct folio *folio, swp_entry_t entry)
> +{

const struct folio *


> +	pgoff_t offset = swp_offset(entry);
> +
> +	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +	if (unlikely(!folio_test_swapcache(folio)))
> +		return false;
> +	if (unlikely(swp_type(entry) != swp_type(folio->swap)))
> +		return false;
> +	return offset - swp_offset(folio->swap) < folio_nr_pages(folio);
> +}
> +
>   void show_swap_cache_info(void);
>   void *get_shadow_from_swap_cache(swp_entry_t entry);
>   int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> @@ -144,6 +167,11 @@ static inline pgoff_t swap_cache_index(swp_entry_t entry)
>   	return 0;
>   }
>   

-- 
Cheers

David / dhildenb


