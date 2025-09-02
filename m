Return-Path: <linux-kernel+bounces-795714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B378B3F6E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D490A1A8405C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A222E6CD7;
	Tue,  2 Sep 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6o35P2i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F232F758
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799197; cv=none; b=ujcqWGn+RM2T40pwr3MRotbf4emq7hQbBnc/o2FR3rImYxjm+K+t/NiNsQMI83KmqIyMGO63rJQB9ClF0iIT8LzHnSEjvsJ8mYrkTO+Kkb5Q7CWHRd6Qw9Anbee8Mjwe9E/fno6f23OnNVqAscaV0wNR0wNfD23wP/309TvyClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799197; c=relaxed/simple;
	bh=dtUiXzSxmQvj3BkfT9ZJmw6suut8eqw7PuOSO7nJoeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8xi++v8BS3yjHpMjLPFj1nZZpZIbJvkzbF1ca84MaU9VB2Y67groridIC1yLArcJqZPBNMB4Hq/Mijm048k51M4l+kTp7+D4MUtqBP4JFFIoL/lpdTfx1Rh5Hysyz7KMV4Cdnj4tpvuPRmwbLoaozAhU8VwqpQjtXrmHhfIwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6o35P2i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756799193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qzr7tEk9QItwIeF7TnzaOixRSPGJEnioPW1Itw0DucE=;
	b=S6o35P2iu98VgVd30fXsT2U2hKTd/CRoGd+A+Qh0f10ew1YgNOUEQnLx+5j8CeZ5X/iotc
	FjmJGeB8pOd3ICb7u6lEWGFZmEnLoPG/qmqsKoJRp3f99Q0iviDs+fNOvynmPX4e86wq5c
	/gF2EbXyf2x/aK6B5wzEmMUwXNXVfdM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-H33hJl5hPWyw_vWHFbGOPA-1; Tue, 02 Sep 2025 03:46:32 -0400
X-MC-Unique: H33hJl5hPWyw_vWHFbGOPA-1
X-Mimecast-MFC-AGG-ID: H33hJl5hPWyw_vWHFbGOPA_1756799191
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b467f5173so48180145e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799191; x=1757403991;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qzr7tEk9QItwIeF7TnzaOixRSPGJEnioPW1Itw0DucE=;
        b=B4y3NqsN40eYBMpywD3AXrnPdz1VvIP+74pYIz0pT8uUaMayeMx1MKDxaSzsP//Zk5
         I+7cYslTBdwMa+T28vzZHEWcIUzbc9L6wbhPZFjyhXMAAfqcY9Neow8GDi3WIM/CYzKk
         2PmwELDT8ORaWt5YxoQHyOqP9fFaWx25NgZslWrIcmAb69ZgRa8ekpu58E3JQ7lCE4fa
         zJ44Nx5Q4zIlpcVS7ufPBjOmgrBounqMTtZ9WHL1UjIJajbLEFwItBdEcmMN045hEvbR
         +cLWy9BCWMuaLpO7TdL6aIdaxwoBr3U1wt6sEh7TTpkL9/7ILSGjTlzX1JzN8sd5/h/I
         q2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGUIhl8zHetsjD8Ftb5Nkr6u2wPhY393wztFjuWehZ1hb0TxIOb4dkRemKpXpoXyFJ2H9OLPwSJmzp7MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOneQo2O89yEcKerRTFQwDyyrgrAEN/GQdSBs/UJuMnRv666ib
	VW1jyrvrp2/nX+8qUKWzAWIP0x8wYGxk1Nlo58qlTlBZITjXnG7A31K738ITKjiXxIIWIt3kKJ+
	9how+p/UhBFvm6XHP20/Td4EpWmaDSvJuemXoLlksSar/f2VR4OXDu3MaGWoDN3Ulog==
X-Gm-Gg: ASbGncvTsmKHIb5RQlS2NMuj5J/hh5jcTpWxvDKCcXDKSsIqhpxmZudfI+4KC+bOc3x
	/V3XWucndEATzulvFnGZAAqx/fMS8TDXI5Rl3FeLyndy0lrLUpzPQHQ3zXFiLYK9dl1E4Tv4nRW
	eZTagXReGAT8eK1vlJfbrVxoNllXcGN9G24D03NOET7D90y+1QfwMv4kjbPa/ojyML9NVEq3npR
	qOIb1Nt1thQvV99EOfxkY3eDG6voQRrKo70DH/MUy3eYRmebqZweAaPYCF1DqkxYuSQAqYowKGy
	1MMo8WQqN8gtSJIXf6OlEB1N+cjx450FvbSUU2bsd+bTY0XXgfcgVWcGpSDJ3aralMA668yYTa8
	H/Mj4He/AFFeaMrEsNl8krtnNp7d1ZaKmljyaUU96NhJP/ovM0CdYvI8+PS2WuIPsQ9M=
X-Received: by 2002:a05:600c:548f:b0:45b:944b:4317 with SMTP id 5b1f17b1804b1-45b9aae5a3bmr3712125e9.19.1756799191112;
        Tue, 02 Sep 2025 00:46:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5pO0lIsDBZdbx8V/mVrz2LttNQMwlq6E6UrKsC2j3HgWKZXpWhllYGOkAr7VnCW+kCacaog==
X-Received: by 2002:a05:600c:548f:b0:45b:944b:4317 with SMTP id 5b1f17b1804b1-45b9aae5a3bmr3711835e9.19.1756799190691;
        Tue, 02 Sep 2025 00:46:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7eb05fd9sm185570505e9.24.2025.09.02.00.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:46:30 -0700 (PDT)
Message-ID: <ee3ee18c-27a0-4c38-a639-e93e91a392ad@redhat.com>
Date: Tue, 2 Sep 2025 09:46:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/gup: Remove dead pgmap refcounting code
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: osalvador@suse.de, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
 linux-kernel@vger.kernel.org, dan.j.williams@intel.com
References: <20250902051421.162498-1-apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902051421.162498-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 07:14, Alistair Popple wrote:
> Prior to aed877c2b425 ("device/dax: properly refcount device dax pages

"to commit aed877c2b425" ...

> when mapping") ZONE_DEVICE pages were not fully reference counted when
> mapped into user page tables. Instead GUP would take a reference on the
> associated pgmap to ensure the results of pfn_to_page() remained valid.
> 
> This is no longer required and most of the code was removed by
> fd2825b0760a ("mm/gup: remove pXX_devmap usage from get_user_pages()").

"by commit fd2825b0760a"

Otherwise checkpatch complains.

> Finish cleaning this up by removing the dead calls to put_dev_pagemap()
> and the temporary context struct.

[...]

>   {
> @@ -661,7 +656,7 @@ static inline bool can_follow_write_pud(pud_t pud, struct page *page,
>   
>   static struct page *follow_huge_pud(struct vm_area_struct *vma,
>   				    unsigned long addr, pud_t *pudp,
> -				    int flags, struct follow_page_context *ctx)
> +				    int flags, unsigned long *page_mask)
>   {
>   	struct mm_struct *mm = vma->vm_mm;
>   	struct page *page;
> @@ -688,7 +683,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
>   	if (ret)
>   		page = ERR_PTR(ret);
>   	else
> -		ctx->page_mask = HPAGE_PUD_NR - 1;
> +		*page_mask = HPAGE_PUD_NR - 1;

At some point we should remove that page_mask thingy as well and handle 
it like gup-fast: let follow_* will in the array directly.


Lovely

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


