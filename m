Return-Path: <linux-kernel+bounces-805755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F6B48D00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A883A4A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159542FCBFD;
	Mon,  8 Sep 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD2nANK/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8952FB96F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333513; cv=none; b=DGudN+kjcumfN2mcjVaUQD0e3DM6b/5fLmZvYKhX3RF/+MVnqaUNL7oGNFHeBOrO2HipQfh8jG1qd/PXwHTpa+lyx7mn5VSmFK1BUU09ZgqZVP68bHc0HPKOMQXfQgpoz9J5dLO7yE2v5FmxKfULvlCJMIXg4blbP7nh8bC9ukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333513; c=relaxed/simple;
	bh=vle6k6nqWkAYbDZNabzD0T6Kzb1AWMmCl91ELTBnQSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWoUbD1dC6TlSAdd37yJq4Qb2uRgmWAzQxMj8AFgCNWSQoVHQzXDJowQfchFfIT3ZxWLaR+N9Q/WgPEGEXi2KvnR31kdifVTPJHaRjCgwiHHzDbl7AdmZzUtShyDZup005+KD+fF1qvkQZr2/mIlcdojMSl99l2aHBB4dtbTIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BD2nANK/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757333510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2jdiX8cmz33Wge7GjULKTSlElQOy4rRPNl1+9C4dPY8=;
	b=BD2nANK/Z/abuaE9R2k3id1lWvIEwB4A0qTIpPco9wIqGSxLOxzDqc7FaA9xd9Qfw/sQ0D
	Hi/nCm95iG2mUvG7ncgtWFy5g16fMOwzbqWrNBPDWLU8Q3f+6ZrfwFuxF6+mPGKt+ikilW
	RR9kzKUUw+Wu6DlFV5eOqhb1NySCN8A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-kHYEALiCNsG32G1UL-6kaw-1; Mon, 08 Sep 2025 08:11:49 -0400
X-MC-Unique: kHYEALiCNsG32G1UL-6kaw-1
X-Mimecast-MFC-AGG-ID: kHYEALiCNsG32G1UL-6kaw_1757333508
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dde353979so10726755e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333508; x=1757938308;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jdiX8cmz33Wge7GjULKTSlElQOy4rRPNl1+9C4dPY8=;
        b=Wmg1TwiPX5NkrV1vEU6r2Dcls7fZVoN0HQl+13+heexbRLobGAOI2J0jZBMHQA8wqD
         vwiZSrLWptDp5DLd1PcHn3wAWUDcRjsoLxkIRJJxRX/ECKMqMu31HaFLieu5VUAMAjYP
         nsNxYHFXZZWO81xmjeNt66e9Ft6mirMEzgHuYdpzWza1DwdNcvGAQXWfo+DuuqDjrtI6
         wmNKC5JxmIp4kLrReqh3mn8VEa5ZwDzOJKVNz0AukixHI6ORdjdy8l53IArd8/+uc3C1
         oEYeaGa5Qjx9Jc/6/cz3J8b7cxyiYcM73/t/MO5jqYTJO+o2EQ3NONLbeJbEBKSlOsGm
         sgYg==
X-Forwarded-Encrypted: i=1; AJvYcCUbgisqxFUYlT83cBcDiAFOltNkkYtmHw2V8eEL70+8jOPfC9fTWbsH254jX6xYux+CbN2DnoOKWgUT7+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+CYaFg4v2sZClayQyZ4gLniWVdKX+uWlsn4as9Ua5TneAdBz
	Pee5e3aPrkEvQtOwajw8XNUu0wnvs9RQ6VtGTak4ALrgPYHjKZ9hj/RvYKf4NrMbAio9+7t7/Z7
	vw036De9fYqf5XU2HWb3GHoiDrU3/k0/89DyLqpQX3mIyBBtAYfYKxvfE9uBvrx9r2A==
X-Gm-Gg: ASbGncsRrp4T8aH75icA6o9/WFo4Oen1qXkepU1Ue+5Y+TYLzUphWmUyGT0bpOR7Q0g
	zRUACfC4aASJmjMaIoz+cLT5dYGOKwfTsy5MrFmqc9HtyYbmIueFwBPnsBEIf//X5iQ55oKP87D
	ymcQFJ4HDM+AErQ3wkZy8ZYmYgvScMC77QPq/GfW/a4fmDD49Xyg2NWGOH8tehHMBsEkgz3+zS2
	ORuzoe3EEp+zK08nORAX0HvzZX79xVlIfJlYBq1V+yb7El1X1hwf7Im4QPfueVuOa8erGW+7n3A
	5f8tv9aDgWDdZwCqXnNM6419yhgJrqBeT8nla84r3sfItp+NrQmowOZcjF9ypAjhSQW/8/3LH+f
	lbACDhVBilEku/GDPtfcVM0IgTy/4KB0cgZ7l8r8gKVCMOe6qoBJGm+fLQiRTGTMx
X-Received: by 2002:a05:600c:a47:b0:45b:6275:42cc with SMTP id 5b1f17b1804b1-45dddeefa72mr65846355e9.28.1757333507669;
        Mon, 08 Sep 2025 05:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFaf4eOc85QPP9D7Vpk6e+Udi31BlmbPwrs+IAuKckaQTcUAkvKTJbOWZ69fZd37sZP1st7g==
X-Received: by 2002:a05:600c:a47:b0:45b:6275:42cc with SMTP id 5b1f17b1804b1-45dddeefa72mr65845955e9.28.1757333507230;
        Mon, 08 Sep 2025 05:11:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de15de2b7sm82239365e9.14.2025.09.08.05.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:11:46 -0700 (PDT)
Message-ID: <bd8338cf-6723-46ef-9043-3ced8be56e62@redhat.com>
Date: Mon, 8 Sep 2025 14:11:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] mm, swap: check page poison flag after locking
 it
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
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-5-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-5-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 21:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Instead of checking the poison flag only in the fast swap cache lookup
> path, always check the poison flags after locking a swap cache folio.
> 
> There are two reasons to do so.
> 
> The folio is unstable and could be removed from the swap cache anytime,
> so it's totally possible that the folio is no longer the backing folio
> of a swap entry, and could be an irrelevant poisoned folio. We might
> mistakenly kill a faulting process.
> 
> And it's totally possible or even common for the slow swap in path
> (swapin_readahead) to bring in a cached folio. The cache folio could be
> poisoned, too. Only checking the poison flag in the fast path will miss
> such folios.
> 
> The race window is tiny, so it's very unlikely to happen, though.
> While at it, also add a unlikely prefix.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   mm/memory.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 10ef528a5f44..94a5928e8ace 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4661,10 +4661,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   		goto out;
>   
>   	folio = swap_cache_get_folio(entry);
> -	if (folio) {
> +	if (folio)
>   		swap_update_readahead(folio, vma, vmf->address);
> -		page = folio_file_page(folio, swp_offset(entry));
> -	}
>   	swapcache = folio;
>   
>   	if (!folio) {
> @@ -4735,20 +4733,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   		ret = VM_FAULT_MAJOR;
>   		count_vm_event(PGMAJFAULT);
>   		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> -		page = folio_file_page(folio, swp_offset(entry));
> -	} else if (PageHWPoison(page)) {
> -		/*
> -		 * hwpoisoned dirty swapcache pages are kept for killing
> -		 * owner processes (which may be unknown at hwpoison time)
> -		 */
> -		ret = VM_FAULT_HWPOISON;
> -		goto out_release;
>   	}
>   
>   	ret |= folio_lock_or_retry(folio, vmf);
>   	if (ret & VM_FAULT_RETRY)
>   		goto out_release;
>   
> +	page = folio_file_page(folio, swp_offset(entry));
>   	if (swapcache) {
>   		/*
>   		 * Make sure folio_free_swap() or swapoff did not release the
> @@ -4761,6 +4752,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   			     page_swap_entry(page).val != entry.val))
>   			goto out_page;
>   
> +		if (unlikely(PageHWPoison(page))) {
> +			/*
> +			 * hwpoisoned dirty swapcache pages are kept for killing
> +			 * owner processes (which may be unknown at hwpoison time)
> +			 */
> +			ret = VM_FAULT_HWPOISON;
> +			goto out_page;
> +		}
> +
>   		/*
>   		 * KSM sometimes has to copy on read faults, for example, if
>   		 * folio->index of non-ksm folios would be nonlinear inside the

LGTM, but I was wondering whether we just want to check that even when 
we just allocated a fresh folio for simplicity. The check is cheap ...


-- 
Cheers

David / dhildenb


