Return-Path: <linux-kernel+bounces-836207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1881BA9021
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BDF3B7387
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988512FFFBD;
	Mon, 29 Sep 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAks20Wj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AA824BD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145254; cv=none; b=mAw12ncsi4NMzAgy1FFU8QXhrvwSzPmTuRzN2OoAnlojdmdCUGvVstAYRVlMBxk/Ljy1Jfqd5cZUJEX12VFJFA6xKfStCk1vUx5p00VylXyR8ql/YLouAK/11BUbpMRF28DxdX7Ozl8a0njurxkKFNRLaJ16gGqravOT5wmDu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145254; c=relaxed/simple;
	bh=BzGJ1VtHskkNiyRX11olsIrlyqdVGgIM0Xq4aXiJXB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tl/A6vgaO4BVWc5ZGmom5TpsyrWqMkezPum/YhLZs9p2vKHP5l0mbl/GFSs61/jSGT2DTIEvKaEI/9qKth5gg/6tR1F/cNZQv4bjWYRlCLWa4IlP70JyB8aNZPxnAAVcqeVbG3LCLwUsJKpg99c3/Lskm4u5XXdti4qzKgv9LH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAks20Wj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759145250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bUzzR4h35LcYPP/dUTPoniliXa+mo6qwLfSHPwhOPz0=;
	b=ZAks20Wjcpy046FEICo0DNOth0aoL++Yeq+xlgFVh6Q3rQlBHzhssqTaoF9Y6lBa+O7Zvp
	NRvD0nRe5RuzUf7VzZ1xNoAkfye1VGp3vNnsf2qNWZdWaJiH7fmR9GObsCwbTTymVPtt4P
	1yhF68L5gpL46j/Xabq5Xtizv/c7jFw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ugSFot5ZNi27iSLVRGlQIA-1; Mon, 29 Sep 2025 07:27:29 -0400
X-MC-Unique: ugSFot5ZNi27iSLVRGlQIA-1
X-Mimecast-MFC-AGG-ID: ugSFot5ZNi27iSLVRGlQIA_1759145248
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece14b9231so3263924f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145248; x=1759750048;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUzzR4h35LcYPP/dUTPoniliXa+mo6qwLfSHPwhOPz0=;
        b=FsnkV6eBLC1iYpiE0XYkOqmh6yeoohaCnQXIrAf4Ggcjghgwqr1E9pQwNygaacis/B
         w/vmN3JAh8DPrI2LqvfSFaRNaOeyJdP1ew8Ph8pl4rcYuVxtXSBcsC5B5aV2CZk1dh7Z
         ywRm1LOAAkpP5ZYIhdJBkCcevemVrtnQreEzKGl9ElzMCxX+j4wZM2sdid7XLr941iDL
         PJ4sMUTGmYh1bDzv+BEL5yNagLBR699LrbLaS38eLPovxlbU1gLSRKvr3AxiEdaObgr6
         ZsR/+FzQ+wNft8cqbK4q+oyTqZjlUch2b1yULy3oVe40o2uc75qXlqOLyCIUeRUpHxrO
         lpdw==
X-Forwarded-Encrypted: i=1; AJvYcCUJerL1434/dc3MoUqGbh+52do/j9gJZWw/DNd1nDR30ruqF61t9WfczrrNqAvdMaDEeyUDw7Aob6kyjgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO9LbFNfiBDDC8k4F+eqiMHMW1oJI9Td2eZaUb5uhWe+ZZCW1w
	ux4PebJkWPocVW/pvYy4c84MR350o1GW72oH2RTr/7cDjCYJ3MZJj0WJ36cF7qaFY9o71GQQk1z
	QAMqsP8VjIIhBLw5G7i90v/xdTM5oK/JGwL51YbMaX8EEmo/sA0XBb9vb6W9XUojr4Q==
X-Gm-Gg: ASbGncujWiVCFgSjMr29XTZz3bqYwcsEB8ltY0BeL8ZDOifksk/8g13qoYQYs8Qeaht
	PwL9kBJw1zVJ8uIvmk0EZK9OXYwy+PeGY23uFhdMpB8ghaoQgr9OkbJhVQzCa4QDVVZZixeinmt
	9zN2pPL/JV/+bbu2ASJSvJvMYMBMnmw8N9liMBpEo84SZmbNcIkt7vDJ16gtz/35lOo/YODd9UV
	DopjjH7H4nPKBvmqsCbxEH7bFzLzvtdauGJyrCe7iPY28XaqlH0qN1teSYxLQVqkmYJX/59RP9w
	/5MZcNz3d6siB4l/+zv8Ad6spgQHFrqKf2XYYj02GMeWS/bwDW03r3SzZmghKAdM0hCNN5hBq1X
	ZFVkWkFGFxIYJwlujJvXUovUr3TxAWbhIDl/GzKGBhdt57RNLN3Zbhet953vj8FrQaQtJ
X-Received: by 2002:a05:6000:2381:b0:3ee:1461:166c with SMTP id ffacd0b85a97d-40e497c34b8mr16195947f8f.5.1759145248183;
        Mon, 29 Sep 2025 04:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/tA9KRR768hrK7BG/BIDGLCJ0HvflPjA0QZhOedUiyGROdESFV5RXXJc4fB7bwIlLev1Qyg==
X-Received: by 2002:a05:6000:2381:b0:3ee:1461:166c with SMTP id ffacd0b85a97d-40e497c34b8mr16195914f8f.5.1759145247758;
        Mon, 29 Sep 2025 04:27:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f39:1500:c90f:7794:3c33:4164? (p200300d82f391500c90f77943c334164.dip0.t-ipconnect.de. [2003:d8:2f39:1500:c90f:7794:3c33:4164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72face8sm18055901f8f.5.2025.09.29.04.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:27:27 -0700 (PDT)
Message-ID: <ef3ebfb1-83f0-4a3e-a8a0-ac0ba729aae5@redhat.com>
Date: Mon, 29 Sep 2025 13:27:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/thp: Drop follow_devmap_pmd() default stub
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250929104643.1100421-1-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250929104643.1100421-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.09.25 12:46, Anshuman Khandual wrote:
> follow_devmap_pmd() has already been dropped by the commit fd2825b0760a
> ("mm/gup: remove pXX_devmap usage from get_user_pages()"). The fallback
> stub in the header which is now redundant, can be dropped off as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   include/linux/huge_mm.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..96ce0ca54e49 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -652,12 +652,6 @@ static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
>   	return;
>   }
>   
> -static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
> -	unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
> -{
> -	return NULL;
> -}
> -
>   static inline bool thp_migration_supported(void)
>   {
>   	return false;

Acked-by: David Hildenbrand <david@redhat.com>

Documentation/mm/arch_pgtable_helpers.rst still mention devmap helpers, 
want to clean that up as well?

-- 
Cheers

David / dhildenb


