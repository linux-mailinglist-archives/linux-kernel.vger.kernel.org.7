Return-Path: <linux-kernel+bounces-727421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B091CB019F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F087A89DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5505A2877E8;
	Fri, 11 Jul 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hm9b+2nT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475A2853F7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231046; cv=none; b=R9Zk6bk5q2wZz9DutORSJJM+kqj/3u/aKubGFMhuJ9toM0H9kMyv9Udv7JDuTtkvct9/RSEsz/4uxIZtWf55xrFMsljLeBJRRaYvPnIvPm/MLHkcUM68zYFn2PEnNuHiKITIpCBlXGv4Ww6diHcuN4jVzHp9CgpzdpYu5iq5EFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231046; c=relaxed/simple;
	bh=2qa4VPUuvS8ArBYp9wXlXYpFGhIkwwSkMvsByTLeTQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tf20nfh9N4EQyobT6y9+ePZhyofSgSdmnJ0ZcidhsqSOkO16m871EBj+tolrkHhf74zcAsG3+sQ7CorlH7g66We8XwwxAp013iSVe1DyNMUV3VnZbZIFlZSQ2CHrIpFccJxQ/C87DYpK8ujGo8LBlFVClU6nj0sd5ALUqyK+FNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hm9b+2nT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752231043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IaNhrf1vDIB1tcZYpLbfYHlYcscO1h0tIvRYBHcyJS8=;
	b=Hm9b+2nTluzunwlWi+N6OjOg/Z4RwW/ayUKAvSen/8REuz0R6zVyaBjG08zrS6P126IA/f
	H2dIF/4f/RSt0AcIr40sKwzpesvvxe28edhgjbVzYsrk1/eQRL/oT+SAYM2TPmfLkkV3lW
	AdwTj+OEXGlLXKZn3OcJL2iWUGCg4wA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-TUag6RBxMYm8EbqjCfu-4A-1; Fri, 11 Jul 2025 06:50:42 -0400
X-MC-Unique: TUag6RBxMYm8EbqjCfu-4A-1
X-Mimecast-MFC-AGG-ID: TUag6RBxMYm8EbqjCfu-4A_1752231041
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538f375e86so15371775e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752231040; x=1752835840;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IaNhrf1vDIB1tcZYpLbfYHlYcscO1h0tIvRYBHcyJS8=;
        b=W9193p3KKR1q+A8ayFOaIOGGIOoe72hRl1tQZLdtzHE1/h9LgjuEJNis7iiQY85m7P
         ykBD+B+UANj5SHWlzbpVj+aiIfhCnwZOnwwJm/pSKI6j0usaDZp9Mo6RdGKrmwH/YVxT
         hvqlP9ImOSMP4P4KmQ2QqSM7dLGSmPUnhLsAro49wyRd+npNHqejZxQ0ypvNOao8XW1D
         L9fLpC7DLKA3hnORrom7UJPHF0fJPgkjV9Gvf1SsMT7Pqc0TxgF75tfCJnJTCVyiFGwE
         NpBDLrIo6J781KVFFtjGFPZnSBFQnqa92Pwazlc+94n7xhP5MJFtnG5aJqVDK24Pilhd
         Knbg==
X-Gm-Message-State: AOJu0Yzyuif5J3kxnyRlIiyTP30TIOwKGvPoGB9Ct6trCQEALVcrEuw0
	wt0fbilBlZySA5bxcLUfkm/5W94tjBUAIQlEnnN0uYjYOnruLnwkB5Lhgd+6/YeKLjoTz9JwQTI
	i/wlxGAAQZ+ZT6isiEgN6kue+8Mq0Q/KVl0vME39FIectmnrl3wLoVei2Al4n1osLPg==
X-Gm-Gg: ASbGnct641R3qgszyuDhwvXryy0xkAQJhvwM7pNiKXn0ISf7LJhgiMGC0fCzKDFm4x0
	n9JgL9rupjdQJHogwi3hUguP1c4tm+ThM2KSovodKHk0/rfygLT3Ry/54CGvWixuOIFMSXzL6l/
	EkrAyzotkPMbi5Odz5XVMEzXDitTSfc1K/dvmpDzASgwTo35dzdFY3Ta7h149A+GuqwS0Gbf9ft
	BMbnwwWO+GbbCIab1ofDR3+6h5WpVmR63elRVXPIjZlZX0AMoB/Y/ylXFuJKiZtcxLo0pEsBLiq
	7uIn5k/Yg513RKcMgeryQoT9H6duCKYfUQX0ibigbKlg5E9HpfVV8P3MLrZOA3TX+0vDKUHyQM9
	WS4o+wnJYtBhO0+QPMs5Z3PdsZh2hs1AwU+DmFKEDLhZFBEv0owJu1h1BJoZpZfTfZlA=
X-Received: by 2002:a05:600c:350e:b0:450:b240:aaab with SMTP id 5b1f17b1804b1-454ec13e155mr23023405e9.8.1752231040545;
        Fri, 11 Jul 2025 03:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8U71ECaPsCVjPVmqRpdPwRIokASxhL+QMhmtfISD+bMHDtWhYaJy/EGrxKUsA5eatuAcOMA==
X-Received: by 2002:a05:600c:350e:b0:450:b240:aaab with SMTP id 5b1f17b1804b1-454ec13e155mr23023185e9.8.1752231040070;
        Fri, 11 Jul 2025 03:50:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd439051sm44045995e9.8.2025.07.11.03.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 03:50:39 -0700 (PDT)
Message-ID: <39cfb01a-88f2-479a-898d-cbcbb869821d@redhat.com>
Date: Fri, 11 Jul 2025 12:50:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/memory.c: Use folios in __access_remote_vm()
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jordan Rome <linux@jordanrome.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20250709194017.927978-3-vishal.moola@gmail.com>
 <20250709194017.927978-5-vishal.moola@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250709194017.927978-5-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.07.25 21:40, Vishal Moola (Oracle) wrote:
> Use kmap_local_folio() instead of kmap_local_page().
> Replaces 2 calls to compound_head() with one.
> 
> This prepares us for the removal of unmap_and_put_page().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   mm/memory.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d63f0d5abcc9..3dd6c57e6511 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6691,6 +6691,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>   	while (len) {
>   		int bytes, offset;
>   		void *maddr;
> +		struct folio *folio;
>   		struct vm_area_struct *vma = NULL;
>   		struct page *page = get_user_page_vma_remote(mm, addr,
>   							     gup_flags, &vma);
> @@ -6722,21 +6723,22 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>   			if (bytes <= 0)
>   				break;
>   		} else {
> +			folio = page_folio(page);
>   			bytes = len;
>   			offset = addr & (PAGE_SIZE-1);
>   			if (bytes > PAGE_SIZE-offset)
>   				bytes = PAGE_SIZE-offset;
>   
> -			maddr = kmap_local_page(page);
> +			maddr = kmap_local_folio(folio, folio_page_idx(folio, page) * PAGE_SIZE);
>   			if (write) {
>   				copy_to_user_page(vma, page, addr,
>   						  maddr + offset, buf, bytes);
> -				set_page_dirty_lock(page);
> +				folio_mark_dirty_lock(folio);
>   			} else {
>   				copy_from_user_page(vma, page, addr,
>   						    buf, maddr + offset, bytes);
>   			}
> -			unmap_and_put_page(page, maddr);
> +			folio_release_kmap(folio, maddr);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


