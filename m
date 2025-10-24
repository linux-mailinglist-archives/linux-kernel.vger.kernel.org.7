Return-Path: <linux-kernel+bounces-869123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B3C07071
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4031C2593D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E932ABC8;
	Fri, 24 Oct 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F03O8p1d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534C328B4F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320568; cv=none; b=uykK4oBssFDmchPM4Dj1mOk3gEptUv19ArxbqXU8b1OUpv8qzbYihfpiOsEd/3tmxKmSqZs843UsiTEB0wYKrK3fgFb+altwLH/d1fQFLugn52ld1ewKt1KrxVUCJap8dod8uLgXs3s60KskFeXmKH+k2zChAX3iKxfHVnK07GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320568; c=relaxed/simple;
	bh=SDI94PUu79UY1fN/O11MyWzpILk0HRWd+qAdanW+Jgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwPoeuzvAnfjyMQZ1+1YTQoB7s7eiH8Jf9JeLM6MFFSZk8QcdowWkN4Ad94fDJNJEXlrsM9HSIrDpO2MOPZEHIYnOWjxtTzpi0SHPNfwf+9EF1/eHVJ/p7mXCZvFN/BENApiTCCjFz4jEhpbvEFuC2KTJLGlnCxp2llfYFVT9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F03O8p1d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761320566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YCFQCFgPLJJHNF45uz8IXNSwQz2ZtuMOkcxhO1VgMIE=;
	b=F03O8p1dmSQhCfF/TGETGt9bCP1phpbyUaZTAWvXpZv3e7As2s+4AwZ57sctdxFq8RRD+f
	nRFEFSxkVYau58ElwtYKlVNySRKF49cBRxjYCE5InP4Chnn0toUWorqOr0Q4w3HezOs64G
	RY8b4f5oYbXY7cMEoMIHG1fYr7/sAKY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-TJX9drLMPEe9zstZKJqJmA-1; Fri, 24 Oct 2025 11:42:43 -0400
X-MC-Unique: TJX9drLMPEe9zstZKJqJmA-1
X-Mimecast-MFC-AGG-ID: TJX9drLMPEe9zstZKJqJmA_1761320563
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42992cb2ee8so222858f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761320562; x=1761925362;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCFQCFgPLJJHNF45uz8IXNSwQz2ZtuMOkcxhO1VgMIE=;
        b=MjfsddvYGpU/Wtj+vAAp8Q/EcP71osP32xYFr74bLTWdA6Sqp7agwVp5eGmi/3PcoB
         8FLNn+/sLcyBN+tSFdB2DmezxVFr/AyzaQhEH4w9KMYNOBVTDXC8T4gg2+hqu4SmquUw
         VtIY/EBbo+LFYagQPOs8kXfvYf81rXcFa+8oHF4x7r3/KovPLaqiJztRpuqXxGCxeMmb
         r9Lh9CcFhBxjvK78qpoHmcYgzlXlNDVJIrGUCjR9r5pz3ScSLjqiCnpLxwecatRsCGIz
         wcR3e1/0iSWforwLSExji37WxI3+ctTPuaTwwciPbkzXkS3DNz6uTiBTBOVwBOthHyrd
         ARsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnACv9Yb/rWvuNcEA3tBGVV3i8fxB2e5MU57P5FOT94pYj9mYWppWY9knMThGkPkdImHc3pYZWc1clNJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98g3TNkr39tFoh96NM6YtWq8DqOPPR+v7UpSydv24+CHwoNgz
	8clTQjFI97eOGNq/ALqQ2geDlCu/uCFnQne0+u/fRop0FgiylYEQi09ZSCojdFMyeyggUUcEytY
	1lXxcxGYGW37ag6TvR5JlH1W6G5NjxCLiDmNoKfuDCAsDboEAQNMcqvvy+Tj93Fh9Og==
X-Gm-Gg: ASbGncuKKtrwqlBnNQjZpeJ/vqNybQtBodgTmyPFgV15N7dRc5Spbm3ergFxAfI4Gyp
	TRjGYP+t+cShD+3YR/Kn0zJlXP64vXGcAOROZQdTFkS544WNpcENiOsS7PzsTXBO9UujsTnRinB
	QdyktB6kQJNJySF2Xg+PJknfq3pDn74sNFXYnUTA8nNDEBk4Gxd2wLeZtjGjBow40m6O/sdRDBB
	EsWPjvhG7WzGNY649By9Qv3YoebjivKVzjTQzbW7FuHbsHt3Gfex1Q6Rg7bSavkiDljHQzqIMar
	OS0tUmExtiEMl6N9cWWx9SOdH1Gxflrxmb4bvxLoX6sDhdmbL4HCL96FgiVE6c48/4VuGPa0qz6
	gRGsJN8Fl/G3Oq0tFL5YSEVponKYvwo7X1RnHwVQK6Jn1gikkehFI8f3jEK4mYfCnvK9ZIX5wnr
	yzc8qUpAS2+O47wsOoJcGgXBGxuNk=
X-Received: by 2002:a05:6000:2689:b0:426:d820:a3f9 with SMTP id ffacd0b85a97d-42704c76535mr18604359f8f.0.1761320562520;
        Fri, 24 Oct 2025 08:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPnF0/ru3FWnNa1cDip4fvA/H/2f2hSvDV5kZEbyyXOBfqac/lKNoCd+rrZ3iEhhxjPCZDfA==
X-Received: by 2002:a05:6000:2689:b0:426:d820:a3f9 with SMTP id ffacd0b85a97d-42704c76535mr18604343f8f.0.1761320562141;
        Fri, 24 Oct 2025 08:42:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f57b7sm9942229f8f.16.2025.10.24.08.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 08:42:40 -0700 (PDT)
Message-ID: <18262e42-9686-43c1-8f5f-0595b5a00de1@redhat.com>
Date: Fri, 24 Oct 2025 17:42:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-2-kirill@shutemov.name>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251023093251.54146-2-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 11:32, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> Recent changes attempted to fault in full folio where possible. They did
> not respect i_size, which led to populating PTEs beyond i_size and
> breaking SIGBUS semantics.
> 
> Darrick reported generic/749 breakage because of this.
> 
> However, the problem existed before the recent changes. With huge=always
> tmpfs, any write to a file leads to PMD-size allocation. Following the
> fault-in of the folio will install PMD mapping regardless of i_size.
> 
> Fix filemap_map_pages() and finish_fault() to not install:
>    - PTEs beyond i_size;
>    - PMD mappings across i_size;
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Reported-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Some of the code in here might deserve some cleanups IMHO :)

[...]

>   	addr0 = addr - start * PAGE_SIZE;
>   	if (folio_within_vma(folio, vmf->vma) &&
> -	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK)) {
> +	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK) &&

Isn't this just testing whether addr0 is aligned to folio_size(folio)? 
(given that we don't support folios > PMD_SIZE), like

	IS_ALIGNED(addr0, folio_size(folio))

Anyhow, unrelated to this patch ...



Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


