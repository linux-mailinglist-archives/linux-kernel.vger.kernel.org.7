Return-Path: <linux-kernel+bounces-862850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB323BF6667
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D83B2AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C76A2F12DA;
	Tue, 21 Oct 2025 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGgglJf4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2041C69
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048532; cv=none; b=LIm80d/J9AukRY1ROS/HYDBdqYEeCoBRgYySZNTJ2MV24Rm/wunsH3gDAQrMocgUx309QNPgndPu2RSOL6wDa3VHoyXWlE3y3hVpZJsfWi2sRJddD/S4sUj/GrFKLMkTinp6aFx+4QZVA7xp3nd7ovN1+M9zaS0/QEArQhEA2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048532; c=relaxed/simple;
	bh=Se4jxx6lLa/LixzWounwQe2HQfxls1H1T66SY4jhs0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPRIQGbaMEns3RDEr2300Z4SX/lG5LJ2hiNkHAtgQXBCCpnzLH6IIIdTBjE+eJvqumlwVI9Z+BPro7JvM2EmmDhYvQ8CM3RLKrity18WKBkrQBFUWc3iiE7JC5anWzVPh9U/P3Gaasc6DIYletUiiOZvaJ/oeb/sLIHM+fc+tkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGgglJf4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761048529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jBk/hMZm1AU2HUgl06IU47txGUglYm8peBHpiuPlFXY=;
	b=eGgglJf41d6cQxOjm+mNunYzitf/Nrynmlijl9Z0pLasiaW9j5gMWPkeGJ04s2SKftSnpE
	hqdoqTZQvt2K0HXjtBpt9D/z53FfHj9TrpncuOAwB3WYas6S9ZveSaOWQXmcVc/3jIF88U
	lwokAKpAKFYxBfn0GC5ryP/hjeGHWao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-aV7Pwgj0OPuTC2esxXWZrg-1; Tue, 21 Oct 2025 08:08:48 -0400
X-MC-Unique: aV7Pwgj0OPuTC2esxXWZrg-1
X-Mimecast-MFC-AGG-ID: aV7Pwgj0OPuTC2esxXWZrg_1761048527
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso2403580f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761048527; x=1761653327;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBk/hMZm1AU2HUgl06IU47txGUglYm8peBHpiuPlFXY=;
        b=k5QykrBcVL43mCMXnQhLAHFCi3A15IFN9/6qLj60U1yJSzXT4o+kvWTtAsSDHqbev3
         zh2YwXViRLs5aVxgkntMY8/+PaDeaEput1HhlKdBt0lS7ony7v89E09Bw7gTht0tPLz8
         /Xcs9tVhB/Ox0LaACqmwKeD4To1ww+UEGZcabfgNUU304g8P0F/qGNK5zbThMKLTmRPS
         mCvOvOODwkYaKRzZA74S0RGl1MjcPeSbQLemcCHzJ0jjN+egK398WtSiEZH2cyUg154Q
         berF4eVAuCAKoqQiRPYzmmqL4H57fUOc0/OoEEcrI3XeZWwDp9Viv2+76QS8Ox7Npfa+
         ST9g==
X-Forwarded-Encrypted: i=1; AJvYcCW3enNsQW/n1ez1LstbgS6McJejLZbuAHZXiXoZNtMZzoUeA/fhMYrBzlIi82bPGYzK074S8Ya5k+1qRG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOlt8Kn7sjz+H4qzL57GW+aMU5gwfqwS9ZDBf+H/J1v80n2zl
	m9kssy1a6hxpHMJgf84L8fVWGbdFMi98D9nWn39q/r6Mj1thvYgRhLZy6Qxrw4b0ibJdf2luluO
	C5t+2n+0QxOOz6t+Wk3bCgt7tjhH7Ned93U4Do7FkTVsXo43vGX1rv2yij3WCpDyYWQ==
X-Gm-Gg: ASbGncub+wRMTCqw2A/C6K0U4C32c38SpZBMw5rwcDR8fbwFGbPS+VTZWHm9P9phJ82
	1Xv83TrzWTKAA9Z/r+1eQWVYRHCu22mBYhlOACLWKSnKexJerwj+5RHTqJI7lLp6EYu1qfincgQ
	VOY9hsiSuPHY6BgN8f1haJrIl4yrIA4M3+Rd4dKYcACqmq+NxA/kuGxf3En9E3OC3qEZfotmSav
	SsJDwrP/iiEnjxP9PRXgQJmNww65i1jShtCuOXBnkFIt2hwcV69dMgkvbaU9SEJLgKU3PTbi7Gr
	xhSfum+8wxefnVOIrupsSne3+a/C7xZMJoomB9Zf1mBX4hKG7sQi6Rgl7x3oaXZk71nREZY7iKb
	IMwfHv+/RoJm1tmMSXLvI7Y4aD3cc9Yk57+RYBkz1WPU1lXole2V+1gv0kdpvFXNeHd0Zl+2JWX
	QdpRttn1GEoLZ1S8pB6SJ0ebKV8gY=
X-Received: by 2002:a05:6000:612:b0:425:6866:ede8 with SMTP id ffacd0b85a97d-42704d49a78mr9955320f8f.8.1761048527232;
        Tue, 21 Oct 2025 05:08:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ5mwIbXc0FupYjOjOI7qYovL003CpULMJ3bbgFzgJ3ZkyizTtVqUvrxQ5Ewt99StNhrhgpg==
X-Received: by 2002:a05:6000:612:b0:425:6866:ede8 with SMTP id ffacd0b85a97d-42704d49a78mr9955285f8f.8.1761048526794;
        Tue, 21 Oct 2025 05:08:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a1056sm19970736f8f.2.2025.10.21.05.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:08:46 -0700 (PDT)
Message-ID: <8379d8cb-aec5-44f7-a5f0-2356b8aaaf00@redhat.com>
Date: Tue, 21 Oct 2025 14:08:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/memory: Do not populate page table entries beyond
 i_size.
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20251021063509.1101728-1-kirill@shutemov.name>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251021063509.1101728-1-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 08:35, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>

Subject: I'd drop the trailing "."

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

Right, there are some legacy oddities with shmem in that area (e.g., 
"within_size" vs. "always" THP allocation control).

Let me CC Hugh: the behavior for shmem seems to date back to 2016.

> 
> Fix filemap_map_pages() and finish_fault() to not install:
>    - PTEs beyond i_size;
>    - PMD mappings across i_size;

Makes sense to me.


[...]

> +++ b/mm/memory.c
> @@ -5480,6 +5480,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   	int type, nr_pages;
>   	unsigned long addr;
>   	bool needs_fallback = false;
> +	pgoff_t file_end = -1UL;
>   
>   fallback:
>   	addr = vmf->address;
> @@ -5501,8 +5502,14 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   			return ret;
>   	}
>   
> +	if (vma->vm_file) {
> +		struct inode *inode = vma->vm_file->f_mapping->host;

empty line pleae

> +		file_end = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +	}
> +
>   	if (pmd_none(*vmf->pmd)) {
> -		if (folio_test_pmd_mappable(folio)) {
> +		if (folio_test_pmd_mappable(folio) &&
> +		    file_end >= folio_next_index(folio)) {
>   			ret = do_set_pmd(vmf, folio, page);
>   			if (ret != VM_FAULT_FALLBACK)
>   				return ret;
> @@ -5533,7 +5540,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   		if (unlikely(vma_off < idx ||
>   			    vma_off + (nr_pages - idx) > vma_pages(vma) ||
>   			    pte_off < idx ||
> -			    pte_off + (nr_pages - idx)  > PTRS_PER_PTE)) {
> +			    pte_off + (nr_pages - idx)  > PTRS_PER_PTE ||

While at it you could fix the double space before the ">".

> +			    file_end < folio_next_index(folio))) {
>   			nr_pages = 1;
>   		} else {
>   			/* Now we can set mappings for the whole large folio. */

Nothing else jumped at me.

-- 
Cheers

David / dhildenb


