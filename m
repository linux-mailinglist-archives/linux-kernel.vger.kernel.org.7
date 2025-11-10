Return-Path: <linux-kernel+bounces-892615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA7C4574A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E769188FE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED22FD7A5;
	Mon, 10 Nov 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5J6sHeF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7B24E4B4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764823; cv=none; b=sLE81N7r7/FljLoYS7upLxnCvQqO5yPfwL/nsI2cKVRHdKarp3EngL3SB9eUqaf9x45DHI77W8UcW0TrSLJ6U+y9EYqfCODaeE6su8JXnswxrqhaCzkOCqz9xO3ZjaqfbdFO4/pkB0536RAG89nN4pdC2/fIA465qXEzRJnnsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764823; c=relaxed/simple;
	bh=xT2FUP3MNs8+53gxJ4yLvrYObNqX1XJmIh259aRbrM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V++rOJA5iAxJx9eViwDuxBmtW0CZFuNxw3YaE2I5q6D9JJ/mD2RS4nWQRXjxq54kftHyI03FgyFePscGe79yS25va3w0yGKfEAulR+FhglovcSuICGpltg6NXnGEqvzUFaeI+Y05WM+rk0FFPN4KUwQbcVc21JZTAOookbU3pOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5J6sHeF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso20946795e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762764820; x=1763369620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ldu9p98EP72Lub2LnfLE7D8p6c6NaHeByWpsFXZ1WI=;
        b=M5J6sHeFJmBgG4wNPSOlQTIw68fBPQABQveNZz8h7+JoBolQQppDGEcbdSqqlPg8Yw
         0aW55G8TX3vO/sapMUjyroIGFZoJFWZJUJMg24i4AO+exDh7xra7zw2qpu83/IX9/pEE
         aM+64lLH7irC/56dRsmso5FiaWGk4SdA3BtZ8wB88j1Dt85+WoDVuqulGYcaCE+jIouZ
         AFqGWlZgmRoVV8IM0UWMMe27Mk8KdD5haFJ0tK7ZS6CHq+eXy57Cu8ehSdc1g/kS0635
         U+WGDoKcL00D3Itru3EoC1DuaTlej3pTxvP25L/UUgBtwL2Bsto17yS5DnZy41Or6p2l
         ReZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764820; x=1763369620;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ldu9p98EP72Lub2LnfLE7D8p6c6NaHeByWpsFXZ1WI=;
        b=Pb2jiKiC17BqMV6LOlCjZ2kAbkM9eLzdZQ6We9ear/IV0Jq/5Qe301UgRXqT+bhTwT
         MFH1rtMVEMOm4bf6OocnpP0+xEqmVLlbVoEYQ/bzUYrocOZyrOw+ocv3qGhdnhcxfRt2
         rLaXgeB18Rfa67mQLV10tQb8xer78DEPC0kwCNwNykdW72lXaRceO1wgLMROkOfzV2Gm
         Rf4NmY4+biQmfotoXM/Fp7I5voRhBeSZ1/5Ii9VZIq7S4obx+ZXZ7nw7/1rGixxpgt61
         zoDobx02StqtRW1E/eN3Sixhr97j0krTcfIaRrzq+PZVYFvPAukTAbnbOOTtYJnuSJ0G
         bHag==
X-Forwarded-Encrypted: i=1; AJvYcCUKbXo5o+9E7znmwN/4HXmxUR8Nr/6MeBvyWTHJYtlAzPZGn4ar7aKyysxixUaan8wIfJ7NpkxkACw7XOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCUBnvZVIjeYI0EJCqskEjwdU8nVQ4unH7lqnDIacYVH+t/18
	y2pssxN8qXUxI2IF3ckQeYMJBYP74EwGY7Q7Md0931so8SAd4qPmY5K+
X-Gm-Gg: ASbGncsl8LCdyxKaP9bhDl08gXhW3hJRRvX/VBcgZZ6MJJElTsRMSptpDcEq6g6SRXe
	F/xKQWmWnR7KxjdY4KXN/tAbnVbP18qsXMXWAJ2dLTL4G210axgSg9Nx1+o6RhwmVq3ucjd1doe
	+5xR7nZJeYnApxW+5UW4RB05e9d6jnBeTIXzuTgwdK3YQhbh+4kXE+3frTLFo59gUA9469kc3R+
	OkSWCLCkDa3DUlP1yHj6SQfvuNCWFGCIJLnXeeAyqMyOZlTRFJMRdoYx75puaZv9wCP5tjXG/Li
	O0pwDxEzVMfhWFdkSHe9tN+zLiCeS26/aatHA4w5gIwJKPCDeqEsk3Utlw07c51P7tz46T1XT27
	rEji+7C8W9KQJFwO8gDZXbTkNUFJBobG7kYyDyNf4VZWCpxLkpQtTMWco2HxBx6ymJl21UUK83j
	aQ0Ybjkh0c+TFPxMPZFJcT/njo6+H4WEkUAHkBku6upYZ4W0CN6Kvd9lr+r0YMEDRlPkG39Ylq4
	3vIREGC4tySW63NOvAEURXi4hJpfY9I1xYDfMtVLu5Xml/yIFgGj/AMaKpV
X-Google-Smtp-Source: AGHT+IHOWXilb/YcUOqkNvD5jv1JX4N6N7v+d1KUcRwDS+nMZxJhbeCpIXfmOsG8KxaFsorMfkvdQw==
X-Received: by 2002:a05:600c:a6a6:b0:477:79cf:89d4 with SMTP id 5b1f17b1804b1-47779cf8b43mr25246935e9.31.1762764819414;
        Mon, 10 Nov 2025 00:53:39 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2dd927d5sm14179020f8f.24.2025.11.10.00.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 00:53:39 -0800 (PST)
Message-ID: <048f6173-f538-46eb-b0dd-70f1aaa79562@gmail.com>
Date: Mon, 10 Nov 2025 09:53:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ptdesc: Derive from the compound head in page_ptdesc()
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: vishal.moola@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
References: <20251110063725.3118037-1-anshuman.khandual@arm.com>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20251110063725.3118037-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.11.25 07:37, Anshuman Khandual wrote:
> struct ptdesc (including all relevant helpers) support multi order compound
> pages. But page_ptdesc() coverts given page into its own ptdesc rather than
> deriving from its compound head as would have been expected otherwise. Just
> change the macro to fetch the struct ptdesc from the compound head instead,
> so that the same struct ptdesc is reached from all tail pages.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.18-rc5
> 
> Found via code inspection. Apparently struct ptdesc could represent a page
> table page which is multi order looking into helpers as ptdesc_nr_pages(),
> __pagetable_ctor/dtor() and pagetable_free() etc. Am I missing something ?
> 
>   include/linux/mm_types.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 90e5790c318f..f7107bc55d1e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -604,9 +604,9 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
>   	const struct ptdesc *:		(const struct folio *)(pt),	\
>   	struct ptdesc *:		(struct folio *)(pt)))
>   
> -#define page_ptdesc(p)			(_Generic((p),			\
> -	const struct page *:		(const struct ptdesc *)(p),	\
> -	struct page *:			(struct ptdesc *)(p)))
> +#define page_ptdesc(p)			(_Generic((p),					\
> +	const struct page *:		(const struct ptdesc *)_compound_head(p),	\
> +	struct page *:			(struct ptdesc *)_compound_head(p)))

Well, this adds overhead :)

The real question is when we would be converting from a tail page to a 
ptdesc.

Take a look at pmd_ptdesc()->pmd_pgtable_page() where we avoid looking 
up a tail page in the first place.

