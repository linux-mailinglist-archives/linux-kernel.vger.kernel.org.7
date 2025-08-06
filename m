Return-Path: <linux-kernel+bounces-757707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4280B1C5C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747B718C0F79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7926E17D;
	Wed,  6 Aug 2025 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnkowobA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50F1D5CE0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482918; cv=none; b=QsoKU2KX9XtIoanFhmMQmntdZqZSwiUe7yHTglQq1FwNMmyMPpM5fs0EvvqCxBjQVNjZa6LMiDQZSdY9tqrTfaIrNfPRVlZK0JP5LE/+4MCIWtPqR2jd1BRgBmbO50S6aMmDWvySSJX0Y1lvj6iE4OXkE+VqG8/pffE9qZG1ZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482918; c=relaxed/simple;
	bh=dHDVA3SEe7O4brXi85xeeMdOmAFY6Qk7Gm6tOJ4BmZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEH/tozmJwCHk1YkQwLmk007y+Br5IbgxgH8/Y0FjwQTjbh6V/8TcXmcfpPXTZ9AQwBtdGececYTSGuHC8Y99zFnqRfU8LGlI02SVGlHEX/whyOsdGjqKkleqrvEZpV/uxTKSN2tS/aqXFDMGUuefi/oj1yTJrYtnOCTaWzLGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnkowobA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754482915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F2wXVi4QzTDBtU3Us3UTeh8WA+WDu9bJjruMqCrZlzY=;
	b=BnkowobAxRrk8f2UejZtvBkgnfulBf31jQ5rVQ/7KUYrwEjUt4/2/uF8hg59TWjT+ctl+8
	ZRpObCJdeESsTwJQGTAVJBQJW1Xw+Qi7X4ry2V9CL+pv0vbfgCIxEbVbXx4BYxd+1z4YTI
	z4U1uw2SbhOn6FPIgGCte6g5YcyhmH4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-bIpm0FWOM-26G3kU7GWw7A-1; Wed, 06 Aug 2025 08:21:54 -0400
X-MC-Unique: bIpm0FWOM-26G3kU7GWw7A-1
X-Mimecast-MFC-AGG-ID: bIpm0FWOM-26G3kU7GWw7A_1754482914
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-458bb0e68c6so23350875e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754482913; x=1755087713;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F2wXVi4QzTDBtU3Us3UTeh8WA+WDu9bJjruMqCrZlzY=;
        b=TYt+5A/JBR5TD0i0L/y76XWbL39lmBlGcXzD7R1kFYgSVRzJEyfO+ZsQtjnzKCatkZ
         7sOvB9GSMRZBmM5jrUIS5PedES/NMCJFBC6laKWnSkUuQRoN0gsKGonMcT07HgdOjghs
         eYQVW+CiXMxME0ZkKVhgb0O9WA8c6Ei/PkhHs/mtMB9iYJtCfWv2/6e5XB5flxqxlMi9
         C5NHKx4OGEvFRJMV8b0H0K+rOpPagijblueM0s0zKY9TGIOOw5PYfzy3jxLDjdKrfCqN
         Yho6v09575xNjcwbtwPBJQrnfeaF0KL3s01nq9TUDb66ybxLG4X2aYkba9INKRR+dm7S
         6XWA==
X-Forwarded-Encrypted: i=1; AJvYcCWpqj5epyY0wzrUndz0BF8yCk5uGH03frsRibRjD5t7w1/VS0oMUD9wWNjVaN9sXAvriByzmw7sG7GwddU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPN5NkthU7lDTFcq6kUqe+iXTNGVMpKOIOAVlE8AqInkPgDFJ
	1H+Brcd/pBCfFeB4tC6BUG12EAOkw4qesRp8DtLF7y0kG0unFdJ9aaVOyn0cUTR9Ny8Jel8lYiR
	UNp801D0g+AoTT/WilzmOkBxUDwn4ru29qZiD7V0Xgrhwloe4EPH6OX07Pi9lcOy9OyiZQbUw51
	K2
X-Gm-Gg: ASbGncvwj9TOF9qzQliPGsF+POTjrUdqeKxDhY7lMeqzce10tPY2WICdh5nNKQQGPYs
	yeh2jvFWmFA42eIQCfsrKXZE6GdFgwAqREupNxwEj3UzxnRzfSL8/Cv5oBfWZNmnjzbG6mDrOlr
	J2n8maYV1vwyCy7aSIzmFWs8s3ClTjdPjVJ4cgjnr0DEUSLS8wUmsjHGj0QSNJiJlqlXqlqlTpp
	L9A/5RAiTgllKH/BH/rlRlJwWWmZJFyrq1lTNw8t4xCJ+jw658vbAsnCD+SbvkUc2Tcebkr5+bv
	DvMP6NTTWCypHsscuaV734Sltr1o7OGN4/SA6o4sMgOXtAdySIaP6B5TCDlWlz+sPzoW5gaODXw
	dFO1zWGwmE8qKExnlDMzpVhVfZB51yKBdgdcDWGf5kF0oSGg9f0Za4JYxVZq4Rh295yM=
X-Received: by 2002:a05:6000:24ca:b0:3b7:97c8:da97 with SMTP id ffacd0b85a97d-3b8f4924341mr1780868f8f.43.1754482913455;
        Wed, 06 Aug 2025 05:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrhEEan++iSXOab9zkoq+gifw7e0bR0MIb7hns3/KNkBAB0GTU5Q8yfIUjPoioTc7fxEAojA==
X-Received: by 2002:a05:6000:24ca:b0:3b7:97c8:da97 with SMTP id ffacd0b85a97d-3b8f4924341mr1780843f8f.43.1754482912987;
        Wed, 06 Aug 2025 05:21:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4beasm22333215f8f.30.2025.08.06.05.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 05:21:52 -0700 (PDT)
Message-ID: <3d2c04e0-b164-41fb-922b-ad7c09075a62@redhat.com>
Date: Wed, 6 Aug 2025 14:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in follow_page_pte
To: Dev Jain <dev.jain@arm.com>,
 syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org, jgg@ziepe.ca, jhubbard@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <68930511.050a0220.7f033.003a.GAE@google.com>
 <20250806111922.669-1-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250806111922.669-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   static void commit_anon_folio_batch(struct vm_area_struct *vma,
> -		struct folio *folio, unsigned long addr, pte_t *ptep,
> +		struct folio *folio, struct page *first_page, unsigned long addr, pte_t *ptep,
>   		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
>   {
> -	struct page *first_page = folio_page(folio, 0);
>   	bool expected_anon_exclusive;
>   	int sub_batch_idx = 0;
>   	int len;
>   
>   	while (nr_ptes) {
> -		expected_anon_exclusive = PageAnonExclusive(first_page + sub_batch_idx);
> +		expected_anon_exclusive = PageAnonExclusive(nth_page(first_page, sub_batch_idx));

We shouldn't need nth_page here, for the same reason we don't use it in 
rmap code: we're operating within a single page table and hugetlb does 
not apply.

-- 
Cheers,

David / dhildenb


